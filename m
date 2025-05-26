Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10235C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYNR-0006W6-H4; Mon, 26 May 2025 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJYNL-0006VL-JQ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:00:24 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJYNI-0004xV-Bx
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:00:21 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c55500d08cso202731985a.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748268019; x=1748872819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QtycBmsJOYuV0RBLwoITZm/+Gwc2xNO2MdRwzOgSg+o=;
 b=gWIjewBytBgjEkYYdTCcbnlr+irvYam92EuNjVC5bKUKnesHl1FtMxGeJJmxSFJ2+u
 VmXQdigTN+w3Uw+DhlwU56Vc8Ra30seko7kal9zSSO9H0d0k3bmBGX3+iZ0Kcxlj1H/c
 Ev2YpI6mCTNHAxoM50O2Kk0VcX0Ir8+6OpoVdgCr90aQyFEr/bO+aZ36zeR1TdoKiGDw
 RlQiwVwd/aWBnY+x2qfhpGBgJb0fmjhuf2sPCRrRempimN5U1TvX0H3rGRWpJ4cGLnLa
 SUS7bggP6FngmOvpizSUZwTfryDSCos7hsMGgTNuOjPMKbN7235oEgv1x9BgaY7jj9oN
 Zn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748268019; x=1748872819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QtycBmsJOYuV0RBLwoITZm/+Gwc2xNO2MdRwzOgSg+o=;
 b=IKydiHiJNvO6boO5H2VPe3feoA035+PxmCgAa030Xfosn4a9uhLxs9VgBANZwz3rjg
 C1fJJg5S6bh/RmtEAFjzvTCxL1a6HuyJCANBN75y+l3mGulDYawCPhmCuEWUVf7xFSd8
 2z/mmGpZon5vNw7BoC7L6VkkRZ5rg0VsOSwAWMk7zMY4fWlqp3GGR/Zumb9XI21pzcBH
 /bTmHjAAK4S8yPBGmM2+QtFUl++scCqDQZKPX7dcqVo3P/1+v1rYVvjAOsetllMx4BA1
 M2qwqYebGHIq0fvRa9wmMp8J/M8IEqIPRtq+G6X/SrAZL28MNEKucILB+y9vMFehtxky
 D87Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9xQ8TsGXI4ZYaAzvfqMkNopacWN7Ssv3AzkDybnYP6wmDutDHhjFmybrl+lqqpCr6ZW8Qy3neaaYR@nongnu.org
X-Gm-Message-State: AOJu0YzEIJrn8XSjvv6LXQ/flHXGt5RNx6dor4Zum7ASu6Fo7mEnhByb
 HMoqnaNKh3XxG+07sSmCXHxWusGLF0xyb6ugojO5/8XRiSLDWqp97V5Ouq6gZhZOGuyTqaKmaJo
 d16JWFwI=
X-Gm-Gg: ASbGncsXsQV+ZHz1/EHoG1utpmkLLvgykFSRWh0Rdufq4RM+znOwHT5EkdwQZHscEQ0
 v0ZzlUjZzrTK3cld3mlbC3ICzjLSO9V6l6/Q0hnco2cxgvhXKCLnUmCUrSfmt/9IeBeiYxM7W4v
 VMX371E55DioLWPAPqJOZZEpbQd/r2SF57YX6YZ621M+sYNXYTVNJmJzMd/6ESwzIfwjH5HJo+a
 FtCK1pemJ6+hSU4we6alQ6z1vgCbaj8EMp4r3IJ7pMKgem8+fzCusgpehTWl0z0sVKZPMGiAm/c
 ycIzDWfctL2etAgueqWZUUcasfKmvpOd6G/hbefvDg2mx8YO7nZ04qGQeZ+uQX/Vj5htr8Au8Wh
 sC8Nz/498UbSUhkLOg9YG88+mBBfVag==
X-Google-Smtp-Source: AGHT+IHPNY4hTF4/LjnIvibVihVMLlpvLkdcdlx/CRR5/dbzBkfJps9YVgLiZb9F44eLhWny/kucOA==
X-Received: by 2002:a05:6102:cd1:b0:4e2:91ce:8cad with SMTP id
 ada2fe7eead31-4e4241911f0mr7356501137.24.1748268004133; 
 Mon, 26 May 2025 07:00:04 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:d081:510e:25da:56a5?
 ([2804:7f0:b402:6ba2:d081:510e:25da:56a5])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e459aa1ca7sm1015278137.24.2025.05.26.07.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 07:00:03 -0700 (PDT)
Message-ID: <6e26d345-e78f-4643-9d3d-772dc06f3e97@linaro.org>
Date: Mon, 26 May 2025 10:59:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/qtest/bios-tables-test: Keep ACPI PCI hotplug
 off
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org,
 mst@redhat.com, imammedo@redhat.com
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
 <20250526053123.1434204-3-gustavo.romero@linaro.org>
 <a6cbf985-4bea-40ff-b12c-8f459249f570@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <a6cbf985-4bea-40ff-b12c-8f459249f570@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Eric,

On 5/26/25 10:23, Eric Auger wrote:
> Hi Gustavo,
> 
> On 5/26/25 7:31 AM, Gustavo Romero wrote:
>> ACPI PCI hotplug is now turned on by default so we need to change the
>> existing tests to keep it off. However, even setting the ACPI PCI
>> hotplug off in the existing tests, there will be changes in the ACPI
>> tables because the _OSC method was modified, hence in the next patch of
>> this series the blobs are updated accordingly.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   tests/qtest/bios-tables-test.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>> index 0a333ec435..216941dbb5 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>>       };
>>   
>>       data.variant = ".memhp";
>> -    test_acpi_one(" -machine nvdimm=on"
>> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
>>                     " -cpu cortex-a57"
>>                     " -m 256M,slots=3,maxmem=1G"
>>                     " -object memory-backend-ram,id=ram0,size=128M"
>> @@ -1775,7 +1775,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>>        * to solve the conflicts.
>>        */
>>       data.variant = ".pxb";
>> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
>> +    test_acpi_one(" -machine acpi-pcihp=off"
>> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>>                     " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>>                     " -drive file="
>>                     "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
>> @@ -1846,7 +1847,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>>   
>>       data.variant = ".acpihmatvirt";
>>   
>> -    test_acpi_one(" -machine hmat=on"
>> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>>                     " -cpu cortex-a57"
>>                     " -smp 4,sockets=2"
>>                     " -m 384M"
>> @@ -2123,6 +2124,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>>       data.smbios_cpu_max_speed = 2900;
>>       data.smbios_cpu_curr_speed = 2700;
>>       test_acpi_one("-cpu cortex-a57 "
>> +                  "-machine acpi-pcihp=off "
>>                     "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>>       free_test_data(&data);
>>   }
>> @@ -2142,6 +2144,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>>       };
>>   
>>       test_acpi_one("-cpu cortex-a57 "
>> +                  "-machine acpi-pcihp=off "
>>                     "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>>       free_test_data(&data);
>>   }
>> @@ -2227,6 +2230,7 @@ static void test_acpi_aarch64_virt_viot(void)
>>       };
>>   
>>       test_acpi_one("-cpu cortex-a57 "
>> +                  "-machine acpi-pcihp=off "
>>                     "-device virtio-iommu-pci", &data);
>>       free_test_data(&data);
> I think this is also meaningful that this gets inserted in the ACPI PCI
> hotplug series before it acpi pci hp becomes the new default (of course
> if you agree on that)

Yeah! I've indeed just mentioned it when replying to you in 3/5 :)


Cheers,
Gustavo

> Cheers
> 
> Eric
>>   }
> 


