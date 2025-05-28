Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2ADC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKG6E-0000tX-9p; Wed, 28 May 2025 08:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKG6A-0000n4-C4
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:41:35 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKG63-0007kA-Ll
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:41:32 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4e58e0175ceso530488137.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748436081; x=1749040881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qV2ty7xeuAzjkeJYG9BdgdDp/4wFSsxmItOkHU0K0M8=;
 b=R68//JljmBfJ9g7UMMQVq6zrTKxMiTCBEXg1CuFZ0kSNW3pzwFUsgCvZLFzIvWmSWU
 L+s4B7p1XZlS49VF2OSO3u11sVd4JhToku6Nfe030fqqW3kTTlW6DmEVwwr708cMS64Y
 fYwYHHv/4m72URtwWuRI0Nvn0lKlGB3SMg9djQVqZNO2dqpRc0ArMi26J4VcgBA2PbCF
 ApooWFQ+JHGWA5vIfv3IkqcKzCJIchIDrUqolkJ69Df5+wfH+CIrLP9M8BszfvUFVRFw
 uw0k5L/F+zFRfA01deAUqGIzvT5SJE6+OFQ9AjtyPZgrIEDVSOM5Jv+sCxV7w3XBwoBh
 WDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748436081; x=1749040881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qV2ty7xeuAzjkeJYG9BdgdDp/4wFSsxmItOkHU0K0M8=;
 b=egrwV0LXrG/csdRFlm4ftXexQFsrcIaz+5T4vAAaNMl5pC/NuH7VUk3st0T46aR4u7
 KUmAu/UUmMt9VXfdWTWYm2akOdGiTxi41qghoq6kbE0p92l1dqCh+T9NV0QwahMUcVab
 CP+JzIV3kAKO//nPA3F7Ft9jIeKXTs/oyQL178uSBT1xYRcoe6sceImoO39mPSoykRfT
 bYaGnl8MoyS0ZdSvPJGofiVGRj2XC1zEVaLkbhHwvKe2pyEvobt85e9RxQM9NpXSx1YE
 uV5eUZiVTxkoNbH3hbGnn2YzM3HubSvFLQb3vyxwP4t4SQUHjE1piyvlZjF79xX3olJZ
 hkRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7WRk+S9dxpGMK++lb5NG/by/s2CUWsn2w4KyZp6iK3cmcZX1EBn6iSYJIEuveJJQlNKzIXgQcIL2c@nongnu.org
X-Gm-Message-State: AOJu0YyTGBGuKDHVdAMSIXqWqGx82Wo48EB6PTHzzRK4LH2CeW4NhYNG
 rBbj9JaGuoECHOkxmW+qr+gm/C6fnd7FKB5MbFFzMoCG1efhzQKVHeuc6wu5pQJywVg=
X-Gm-Gg: ASbGncuodIUr+sn0Ece5UdaJULbLFKZPv9BToC5ZLjV7xnawnR3SkK5sgJ6exiPNOXn
 DLhDMx+FxT9C+rTf1BlnlolUD2nKh51CvWz2jIf7Y//QIw8ezTf5EmXswhVeiZRtPoDnysfsk9s
 5Wj3ZwX0EsN4nVxtsYQ4TLB7OHXvrjrGXeIOSxgjMABcjso9e9OnrHE/I7WlCcTFLBz68juBUa7
 /XpHIOmzZwcBS3l1aYOYbSNrxYBXwxU/pBM5zRP4Pld/sS2Ff+TgCFQlpaZimufgpj52UDWjC92
 aEAiTlnfd6Yk8QVeie2ZSKcWzofSKpjGbswZc6Sxsj88zjbYENo0qWIr8uvtUwn0uxXdLOpiWeM
 vdcjZtlsq2urCLgJuCb80EIOYfa537w==
X-Google-Smtp-Source: AGHT+IH6XUj9DClPMfpVzSs/2eJ4sQC0Oz/YvRsC9nib8fAkxK9DpOvU+mWlaNISE+I8Ku8qlOtaaw==
X-Received: by 2002:a05:6102:510d:b0:4e5:9e92:a267 with SMTP id
 ada2fe7eead31-4e59e92a960mr1008995137.4.1748436081509; 
 Wed, 28 May 2025 05:41:21 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:2066:dacd:9134:8586?
 ([2804:7f0:b402:6ba2:2066:dacd:9134:8586])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e1f0db868sm738539241.26.2025.05.28.05.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 05:41:20 -0700 (PDT)
Message-ID: <375cfbd6-e585-4b6d-bf10-6571aa40370e@linaro.org>
Date: Wed, 28 May 2025 09:41:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
To: Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, Jonathan.Cameron@huawei.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250528113813.47086516@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe34.google.com
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

Hi Igor,

On 5/28/25 06:38, Igor Mammedov wrote:
> On Tue, 27 May 2025 09:40:26 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>
>> ACPI PCI hotplug is now turned on by default so we need to change the
>> existing tests to keep it off. However, even setting the ACPI PCI
>> hotplug off in the existing tests, there will be changes in the ACPI
>> tables because the _OSC method was modified, hence in the next patch of
>> this series the blobs are updated accordingly.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> it would be better to test whatever default we end up with.
> (like x86)

hmm maybe there is a confusion here, Igor. We are actually planning what you
said. This patch and the other two in this series related to the bios-tables-test
(i.e., patches 8/25 and 10/25) are for actually making the current (legacy) test pass,
since the new default as per this series will be acpi-pcihp=on. That's why here we're
adapting the current test here to have acpi-pcihp=off.

The new test that will test for acpi-pcihp=on (the new default) is not in this series
and we decided to merge it separate. It's in the patch 4/5 and 5/5 of the follow series:

https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5


Cheers,
Gustavo

>>
>> ---
>>
>> [Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
>> ---
>>   tests/qtest/bios-tables-test.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>> index 0a333ec435..6379dba714 100644
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
>> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
>>       };
>>   
>>       data.variant = ".numamem";
>> -    test_acpi_one(" -cpu cortex-a57"
>> +    test_acpi_one(" -machine acpi-pcihp=off"
>> +                  " -cpu cortex-a57"
>>                     " -object memory-backend-ram,id=ram0,size=128M"
>>                     " -numa node,memdev=ram0",
>>                     &data);
>> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>>        * to solve the conflicts.
>>        */
>>       data.variant = ".pxb";
>> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
>> +    test_acpi_one(" -machine acpi-pcihp=off"
>> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>>                     " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>>                     " -drive file="
>>                     "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
>> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>>   
>>       data.variant = ".acpihmatvirt";
>>   
>> -    test_acpi_one(" -machine hmat=on"
>> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>>                     " -cpu cortex-a57"
>>                     " -smp 4,sockets=2"
>>                     " -m 384M"
>> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>>       data.smbios_cpu_max_speed = 2900;
>>       data.smbios_cpu_curr_speed = 2700;
>>       test_acpi_one("-cpu cortex-a57 "
>> +                  "-machine acpi-pcihp=off "
>>                     "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>>       free_test_data(&data);
>>   }
>> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>>       };
>>   
>>       test_acpi_one("-cpu cortex-a57 "
>> +                  "-machine acpi-pcihp=off "
>>                     "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>>       free_test_data(&data);
>>   }
>> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
>>       };
>>   
>>       test_acpi_one("-cpu cortex-a57 "
>> +                  "-machine acpi-pcihp=off "
>>                     "-device virtio-iommu-pci", &data);
>>       free_test_data(&data);
>>   }
> 


