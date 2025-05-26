Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6E8C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 16:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJaPK-0006c4-EC; Mon, 26 May 2025 12:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJaPH-0006aG-FH
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:10:31 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJaPF-0006B6-Jk
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:10:31 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4e1aa5d8039so1455466137.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748275828; x=1748880628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jt3YNwKEM9Sbv9IbtQzDPNU9JuVIKLs8sclnWnA9QaA=;
 b=j9F7q74W+AcwLDEyjgCIF893SakCeJyzZVWMQTDo60eWQri1vOAazjcOyjtZ3J9Dl/
 6jUgd5f3sp1Ke9XWOioIRKZv7qGACAqnmB5zkSoTqdXx67TQO0A770Mv4dBzHvG5Auf7
 7FXENizV9zZtHXsz9yJ1UvV2BdZFjY7LOmaCrigkf7osm/YWXpbALc4wLFvvUDTHywIp
 UrweCZ8f84PqQbdh5A9I91svah6K9tOHgCvQ9zkMbS1XbCGntvDTJf876IO6L58idQ47
 SYtaV4f5pvPPMpunTAVXA/Rs8GRBWHlFSrrjFsej/2LYMIIeMr07g72TtS2kvbvkujQN
 AozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748275828; x=1748880628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jt3YNwKEM9Sbv9IbtQzDPNU9JuVIKLs8sclnWnA9QaA=;
 b=rHcerLVsolJqvGbbsGDDEWwqoPLc8k3mQsw3Rn0Pt2XuwOSaIpER8FTeaMqqFw2tKK
 /yFer0SJ3NVJSTH062J/tziY5TrDeuvfdg66u/s3ncxJCp2mne+F7j9rtPUFWumaEZ5z
 9BAiQdzDqBWjE4Ru+q+2BogYelwgb7ZLtm+I80FCqU9Rp3WgQ/lgfqsb2YL0D2ihwkWp
 Mc2vwXPobtmtex9x0e54Q6ILTTN7C6FvbMwULgkLt2BC1m9nKgMHu1ukbU6YeOxSmA1c
 ZAujQK1PSeU5wsu/+Gb3yuEOZe+/tc/Mo+L9CU5USJ8PSvuiR4WL2f/hkdB1hpYvZMlu
 4Mjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJlLZGLMG3lgzVcR9qRuH94TJscFsi/ZNFBYoGiSC08Dtyy8ZSVKK9gnYI8Npg4g7x69lq6x1xRNkW@nongnu.org
X-Gm-Message-State: AOJu0YxKn82uO2jePR9HtyT3VdP2Azes4GeytdcJVW7dgkqU/AEXynFP
 gxLnlOvN2EPVv23W3MUk1jwhKsg1s0TYH7t63M3bztP/p5tJD7WuXFivTlGQc8639CA=
X-Gm-Gg: ASbGnct6H43VWL/BkRZnYqKtA6olRw1756y9y9MDdA/VtqZ5q3XwaT5QVkuKbXMp1/L
 7Gx5GYCgfdo7j4TZ2te3ZuUG9vcPdCP1bR1kVFUQmgcV3TUaAtmHG0ZmK7mKmiz6OohwbT6Yd46
 ZTKiw0SuSubk3Q6XFu2skQj5zCy3xIIM2s69Rx2/tE1WwUef2NxwHK+ENbN7Q29v3RAon7CEUIX
 w30pMRalu79shSKHF8GjQ1bCaseArUKkALE2Tadg0L/LdUwTateO0noUx+VKzcMZXGN4aiH2Ahd
 ys8+0NbLZPmG7bXBkLaVaiYGK2LT7GeetSgZEUXpCx5vYNLL1qWLwkaPTxDHg3WlLXHfy6N9h2B
 OCcAt0C2thonoXjMnzfn1QkoNHLeXiA==
X-Google-Smtp-Source: AGHT+IG0Y3a/E82axJJ2arNy3Qk0+JYep8W1DncjnaOQhgGLyUqIPBW5k0I+otyo28c4yh61AiCa+w==
X-Received: by 2002:a05:6102:3ecf:b0:4bb:e80b:473d with SMTP id
 ada2fe7eead31-4e42409ba65mr6889352137.6.1748275828296; 
 Mon, 26 May 2025 09:10:28 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:d081:510e:25da:56a5?
 ([2804:7f0:b402:6ba2:d081:510e:25da:56a5])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e2b21b4a80sm9367677137.8.2025.05.26.09.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 09:10:27 -0700 (PDT)
Message-ID: <d86cd26f-c43d-4a99-bd9e-573d3d7cf8bd@linaro.org>
Date: Mon, 26 May 2025 13:09:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/qtest/bios-tables-test: Keep ACPI PCI hotplug
 off
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org,
 mst@redhat.com, imammedo@redhat.com
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
 <20250526053123.1434204-3-gustavo.romero@linaro.org>
 <a9a8d55f-7409-4dd6-97f6-a373de9870df@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <a9a8d55f-7409-4dd6-97f6-a373de9870df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe2a.google.com
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

On 5/26/25 12:28, Eric Auger wrote:
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
> On my end I also need to add -machine acpi-pcihp=off in
> test_acpi_aarch64_virt_tcg_numamem

Yeah, by reading the code I'm pretty sure this is required by the numamem variant
as well but I don't see a failure here :( I have _no clue_ why the failure doesn't
happen on my env. Are you running simply "make check V=2"? arm64 host?


> with that fixed,
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for the review! I'm sending a v2 with numamem variant fixed.

BTW, I'm sending soon also a functional test variant for acpi-pcihp=off.


Cheers,
Gustavo
  
> 
> Thanks
> 
> Eric
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
>>   }
> 


