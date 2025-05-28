Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B8BC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 15:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKIKr-0005aM-6d; Wed, 28 May 2025 11:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKIKm-0005a0-39
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:04:49 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKIKj-0004O2-VG
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:04:47 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c3b863b8eso3040524a34.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748444683; x=1749049483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tSPH3X0vf+RTEfgVAMQBy9/4Ydp7t2pTvizUr5Yr/nw=;
 b=CvDDtMH9lZe9OZWg1pt5ZgIeTdsok2ecROG8ZGUxWdNaSjmqHwwAqiLSaHyqNkoFJP
 MlHbaISVmtNEkh/lRPUButcfVcqI8XOvPc0nxiuOBG21N3AbROpHCBgtnUXUQeiKygte
 u8r26J3KEd63KXIv2f6evmfxCkwcmkLRdir5+d7d3cdzrgxaxlnzRb3DG2CbERBEv3u5
 u9J7DL16IKaL9g3/KDY5zEUPqCLF26o63e93myndkrl43W0mpABxN5S5OLYAKpB8RA5p
 6eFEBoD4r7ChVrFTeJcnYkCHwdS9lCfhoovoMXXma1D/vGJgYKj9fUHLPSmihMK+pQna
 TyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748444683; x=1749049483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tSPH3X0vf+RTEfgVAMQBy9/4Ydp7t2pTvizUr5Yr/nw=;
 b=wIxxW0Qv8Q/iQXb7vuCqFefDihmoOG5WM6eldV4QiaK05jD/k3q6eEoDre3p2Qmt6G
 shwU8RVNnrPkAtHu+DXE2m1RlvgtVEjLt+D3nwpjEFpg6egAFuJuSJh+zgt3CWABPzhA
 1MEuFIuj0ud6EytXW3cVTdkrOASor+8BFi9WPMYYyDDiNC1ecZi8gZnr++sn4CkuyLi+
 jU9nGhJhFV2i8zGJqvjcp/T2rj9+Bs13+Enp1uJNAA5zvowjAK5rGaDft1N6fjcR5DyP
 a/+QEx/X8P/DTjyB4Zx2TPfcAs2fRfvO//YOwdCiKuf60rHFUHeOFlgm7JmJCqwHOIo+
 T9Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+z1Sb39R7HxbEqxC9shvgcZhlo6BeChgVYX2u/YM2ITsUXuAXqsIx2wrEvrrfhkdiuMvm6+ci8YUp@nongnu.org
X-Gm-Message-State: AOJu0YxiJAuoklQDXae4TDeyoWYsKm853x34waYJLKKpTzcCD9f3DD9K
 SIKV6pKWJaraOXsy1j0wHYNLatehuzc1ldOejGzt1YlkZviHJaWt0l6n990QVlEVN6JCU9USd0B
 dZGmH
X-Gm-Gg: ASbGncsDDIi+FL+xFS4tMBlszASyxP0h+eW4rE9YjSNKLbdAaKtD5WS0gN9+IF4iVUh
 XglhssR8eX74vQDzHa8QTIQvbgTyHlKM37XQ6/CMIisYJ/FxWul4UKUNbx/1eKLPIcdn9Uua1ES
 mS4gBFHjM3l2dkT+006+lDQ8g0NoCVioUcDYnTdxlTq2mxKrkHpcrZBygx/gf2b9Gjkh/AcaFOp
 IkhQ3hfnpvCSav2CawnRtOqGibDaCqnVSyPrbxx65xVyc4MVMRzTqlUAAGrbGBc66koYZDoJK1I
 2ZvoitVbgdWeV06Btol2INx4BHBrEHgPPjGCTg8vm6sFwyDng7wCj93ZZIHmbZD6Co6GjZjrtlv
 EZLMn28E8h+uyPJf9pCG2ZugD/kVdGg==
X-Google-Smtp-Source: AGHT+IEB5FH9tG+PeTsf6ApJKcqIhzRGl03jk0Fxn6jR3QM1XYWKe4Khms9TW7eiat9qsaUbHUu3lA==
X-Received: by 2002:a05:6870:8dc9:b0:2c1:ac88:4a8d with SMTP id
 586e51a60fabf-2e8620d0871mr8874628fac.30.1748444673333; 
 Wed, 28 May 2025 08:04:33 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:c792:c8df:e54f:dec7?
 ([2804:7f0:b402:6ba2:c792:c8df:e54f:dec7])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87e1f03f933sm962585241.15.2025.05.28.08.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 08:04:32 -0700 (PDT)
Message-ID: <6a5776b4-73ef-427b-b4e4-b25031b0ce53@linaro.org>
Date: Wed, 28 May 2025 12:04:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
 <375cfbd6-e585-4b6d-bf10-6571aa40370e@linaro.org>
 <20250528150239.5f6b63d0@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250528150239.5f6b63d0@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/28/25 10:02, Igor Mammedov wrote:
> On Wed, 28 May 2025 09:41:15 -0300
> Gustavo Romero <gustavo.romero@linaro.org> wrote:
> 
>> Hi Igor,
>>
>> On 5/28/25 06:38, Igor Mammedov wrote:
>>> On Tue, 27 May 2025 09:40:26 +0200
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>    
>>>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>>>
>>>> ACPI PCI hotplug is now turned on by default so we need to change the
>>>> existing tests to keep it off. However, even setting the ACPI PCI
>>>> hotplug off in the existing tests, there will be changes in the ACPI
>>>> tables because the _OSC method was modified, hence in the next patch of
>>>> this series the blobs are updated accordingly.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> it would be better to test whatever default we end up with.
>>> (like x86)
>>
>> hmm maybe there is a confusion here, Igor. We are actually planning what you
> 
> perhaps, see my reply to Eric about my expectations wrt tests.

Yip, I read it before my reply here.


> (i.e. default tests shouldn't have any explicit CLI options,
> instead it should follow whitelist blobs/set new default patch/update blobs pattern)

I see. I agree with that. But this patch is not about the new test. The new test is
_not_ in this series. Patches 8/25, 10/25, and 24/25 are _not_ about the new test but
about adapting the _legacy tests_ (native acpi) to the situation when ACPI HP becomes
the default, because this series makes acpi-pcihp=on the default, hence the CLI option
"acpi-pcihp=off" added to them. An update to the blobs are also necessary because of the
change in _OSC method, even when acpi-pcihp=off.


>> said. This patch and the other two in this series related to the bios-tables-test
>> (i.e., patches 8/25 and 10/25) are for actually making the current (legacy) test pass,
>> since the new default as per this series will be acpi-pcihp=on. That's why here we're
>> adapting the current test here to have acpi-pcihp=off.
>>
>> The new test that will test for acpi-pcihp=on (the new default) is not in this series
>> and we decided to merge it separate. It's in the patch 4/5 and 5/5 of the follow series:

We're doing the "blobs/set new default patch/update blobs pattern" in the new test, which
we can merge later, once this series is merged, no? The step "set new default" then will
not be necessary because the new test will be merged separate, after this series, so when
acpi-pcihp=on is already the default.

Please note that although we're using acpi-pcihp=on in the new test, it's not necessary,
we can dropped this option, making it implicit as you say, and it will work. This is the
new test:

>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5


Thus, there are to "acts" of modifying the bios-tables-test:

1) Adapt the current tests to when acpi-pcihp=on becomes the default (hence the addition
    to them of "acpi-pcihp=off". There is also the need to update the blobs, but it's because
    of the _OSC method change in DSDT table, which will change anyways, even with "acpi-pcihp=off¨,
    hence the need for patch 10/25 in this series. This is _done is this series_.


2) Add a new test for testing the default (i.e. acpi-pcihp-on). It follows what you're
    saying above: "follow whitelist blobs/set new default patch/update blobs pattern",
    because we can drop the acpi-pcihp-on option from the CLI in this test without any
    prejudice to test. While the step "set new default patch" was actually done in 1).


Cheers,
Gustavo

>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5
>>
>>
>> Cheers,
>> Gustavo
>>
>>>>
>>>> ---
>>>>
>>>> [Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
>>>> ---
>>>>    tests/qtest/bios-tables-test.c | 13 +++++++++----
>>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>>>> index 0a333ec435..6379dba714 100644
>>>> --- a/tests/qtest/bios-tables-test.c
>>>> +++ b/tests/qtest/bios-tables-test.c
>>>> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>>>>        };
>>>>    
>>>>        data.variant = ".memhp";
>>>> -    test_acpi_one(" -machine nvdimm=on"
>>>> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
>>>>                      " -cpu cortex-a57"
>>>>                      " -m 256M,slots=3,maxmem=1G"
>>>>                      " -object memory-backend-ram,id=ram0,size=128M"
>>>> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
>>>>        };
>>>>    
>>>>        data.variant = ".numamem";
>>>> -    test_acpi_one(" -cpu cortex-a57"
>>>> +    test_acpi_one(" -machine acpi-pcihp=off"
>>>> +                  " -cpu cortex-a57"
>>>>                      " -object memory-backend-ram,id=ram0,size=128M"
>>>>                      " -numa node,memdev=ram0",
>>>>                      &data);
>>>> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>>>>         * to solve the conflicts.
>>>>         */
>>>>        data.variant = ".pxb";
>>>> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
>>>> +    test_acpi_one(" -machine acpi-pcihp=off"
>>>> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>>>>                      " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>>>>                      " -drive file="
>>>>                      "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
>>>> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>>>>    
>>>>        data.variant = ".acpihmatvirt";
>>>>    
>>>> -    test_acpi_one(" -machine hmat=on"
>>>> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>>>>                      " -cpu cortex-a57"
>>>>                      " -smp 4,sockets=2"
>>>>                      " -m 384M"
>>>> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>>>>        data.smbios_cpu_max_speed = 2900;
>>>>        data.smbios_cpu_curr_speed = 2700;
>>>>        test_acpi_one("-cpu cortex-a57 "
>>>> +                  "-machine acpi-pcihp=off "
>>>>                      "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>>>>        free_test_data(&data);
>>>>    }
>>>> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>>>>        };
>>>>    
>>>>        test_acpi_one("-cpu cortex-a57 "
>>>> +                  "-machine acpi-pcihp=off "
>>>>                      "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>>>>        free_test_data(&data);
>>>>    }
>>>> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
>>>>        };
>>>>    
>>>>        test_acpi_one("-cpu cortex-a57 "
>>>> +                  "-machine acpi-pcihp=off "
>>>>                      "-device virtio-iommu-pci", &data);
>>>>        free_test_data(&data);
>>>>    }
>>>    
>>
> 


