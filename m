Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287C1C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 09:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDOp-0000yY-Ju; Wed, 28 May 2025 05:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uKDOm-0000vk-CO
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uKDOk-0004YW-8H
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748425712;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvV46O2v4fYzg5f8Hik7aieLH3aHVglYDkm52B/rBtQ=;
 b=ETHfsb3vK/henCwhTs6eZUIEgNqhF5ew+NossexCSPmEL+hr+c331jzdf3EvCaQNfDAgr9
 UjdN3umEqsMMdHcoekQOYW4ytpoivhYGjM5uxVNZduNFwT9tOhzote15O4Bqy295QY4R5L
 Uoa/8MJ8bglDBic1cIZK1thA1bt+DLs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-u5Igkz4OMgSIj6INCegd0A-1; Wed, 28 May 2025 05:48:24 -0400
X-MC-Unique: u5Igkz4OMgSIj6INCegd0A-1
X-Mimecast-MFC-AGG-ID: u5Igkz4OMgSIj6INCegd0A_1748425703
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442ffaa7dbeso32627145e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 02:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748425703; x=1749030503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fvV46O2v4fYzg5f8Hik7aieLH3aHVglYDkm52B/rBtQ=;
 b=VcyUTl3+1WXfCdTSYQT29S+qgpog/C2pI4iOAYn1zuLDRBzhrSARaFVAeobrkL45Ha
 OUFu2k8r68Oj/kgeKpkcTCFHMwajquAzSrKEaQX9FLmBWK+rHtjwPMX4+qg8omXGgr6l
 y23rAht1kJBWPxCn3zuLqtYf2TcyvIgvIgxN/gmBSZ2K+ocf6NT7lhdYBw0jySZ2g+Kv
 VtxrJRXWQYeJa9+uao8s0Sa2ZYcIhZoDY+yVKnPznBC235ZtLbZjY7ukPxWe8bBFCBG5
 oGqGp2K0+OPTrsrGSbMXIMeWHbbDSx0HMFSRMjzvP49p5//mkzAYgIUFQIkc+ik0pt/x
 247Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDfn78NyZwv2lOK+Oowz/BHXIRnhUdqST9f+5l4RYUhzIEbM3SUAH4MhfHOTEANPRyiqm0pGAkDmPk@nongnu.org
X-Gm-Message-State: AOJu0Yxi1YrNkdVrnaPPA08Ql9jN9P06ssOAk+CyVk+N4IANkehXCEDB
 k3skDfzGUk0I+muS2qI/JtCTMrKNCTtRE/w/aFm4nPcl0HCxBamuhLBFyqK5Zw3RQguq9K8+8ZV
 /zTZCsNAiF5ppmKQkdU0kDSvClJl01hgRNgJBm5z4tVzJ0w3ez7kotgzh
X-Gm-Gg: ASbGncs1pnKVWL+lK0fgDh4mELn7wzXwZnPXJQHSvTg8QQP6EGh972MFn1Eun2ParqV
 k6imTVRO87iXmo7fKorCmNAGVh1Ey3W0mykS4Q/3D4MfRa508n9FE/PBCcU/TRbyBs+sVqJ48M/
 HxiK++pdwk3k/gSo73y5sUdNLZom6XZLdykfVzGq7qy+YMK9+BN7AxGzPSkzDaG5Mez70D0EXVN
 a+Pe2Byj0zKBG1cl8cQ5d0mOTW8HmX7YLVx6D3hB1cNuPiEEoK+KjQTMYNeJkFZxay0W32CudVl
 KF3DLtQkW9lHzrDDz86uv5sHMGjPWXkJRzaVeoiPt5O67BdagnQpzTlJ8m0=
X-Received: by 2002:a05:600c:3c96:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-44c91cc5586mr187075305e9.10.1748425703497; 
 Wed, 28 May 2025 02:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXRDW7B71V5zR1Btcw8sQefGWwVVnbePdlK3vTjvbMsy/lVQTdJVqDlhiZ824bpC02R6DO4g==
X-Received: by 2002:a05:600c:3c96:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-44c91cc5586mr187074965e9.10.1748425703030; 
 Wed, 28 May 2025 02:48:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450064aeb6csm16135615e9.24.2025.05.28.02.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 02:48:22 -0700 (PDT)
Message-ID: <fd44ef37-ef02-4e60-817d-1362c76433b0@redhat.com>
Date: Wed, 28 May 2025 11:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250528113813.47086516@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor,

On 5/28/25 11:38 AM, Igor Mammedov wrote:
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
> it would be better to test whatever default we end up with.
> (like x86)

See my question on patch 2's comment. We intended to have tests for both
modes (legacy and acpi pcihp). Gustavo added some new tests for the new
default, namely acpi pcihp. Now I did not really understand your point
about keeping legacy mode as a default.

Thanks

Eric
>
>> ---
>>
>> [Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
>> ---
>>  tests/qtest/bios-tables-test.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>> index 0a333ec435..6379dba714 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>>      };
>>  
>>      data.variant = ".memhp";
>> -    test_acpi_one(" -machine nvdimm=on"
>> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
>>                    " -cpu cortex-a57"
>>                    " -m 256M,slots=3,maxmem=1G"
>>                    " -object memory-backend-ram,id=ram0,size=128M"
>> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
>>      };
>>  
>>      data.variant = ".numamem";
>> -    test_acpi_one(" -cpu cortex-a57"
>> +    test_acpi_one(" -machine acpi-pcihp=off"
>> +                  " -cpu cortex-a57"
>>                    " -object memory-backend-ram,id=ram0,size=128M"
>>                    " -numa node,memdev=ram0",
>>                    &data);
>> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>>       * to solve the conflicts.
>>       */
>>      data.variant = ".pxb";
>> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
>> +    test_acpi_one(" -machine acpi-pcihp=off"
>> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>>                    " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>>                    " -drive file="
>>                    "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
>> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>>  
>>      data.variant = ".acpihmatvirt";
>>  
>> -    test_acpi_one(" -machine hmat=on"
>> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>>                    " -cpu cortex-a57"
>>                    " -smp 4,sockets=2"
>>                    " -m 384M"
>> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>>      data.smbios_cpu_max_speed = 2900;
>>      data.smbios_cpu_curr_speed = 2700;
>>      test_acpi_one("-cpu cortex-a57 "
>> +                  "-machine acpi-pcihp=off "
>>                    "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>>      free_test_data(&data);
>>  }
>> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>>      };
>>  
>>      test_acpi_one("-cpu cortex-a57 "
>> +                  "-machine acpi-pcihp=off "
>>                    "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>>      free_test_data(&data);
>>  }
>> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
>>      };
>>  
>>      test_acpi_one("-cpu cortex-a57 "
>> +                  "-machine acpi-pcihp=off "
>>                    "-device virtio-iommu-pci", &data);
>>      free_test_data(&data);
>>  }


