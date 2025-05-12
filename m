Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B42AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESYP-0004sl-Sc; Mon, 12 May 2025 08:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uESYA-0004s3-VR
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:46:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uESY5-000501-CR
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:46:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a0be321968so2601992f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747053981; x=1747658781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nW08n49HQoqIa405hc1jxrcqgTRuQtBBfzOxsnvIePs=;
 b=L8GAsVREJ8FgB4xFWP+zZsPiOpSO3yYtCLYdYDqN3QIFo0W4SuI7+ykbnmVPrIZF//
 /37mdt11uBgoathtx/8t+X+a/ZHIhI2kaVgwiFYHgQ0r9pKoTXnqDZcJA6TEpPBDB3AK
 DGQ3+Qz5GZImYyJ4yOm116XMLOLpBOHY2tBjj6xaC8N29UyQJZDVeDBmBUj8miHUTbUS
 YrZHFM+h0V+kidMr5kFuBuo08jitD++m1PmBljTel50xfnN3FjwTWSxpMPxqRw0s0G2r
 mXRSDIP1gc4U86TVYiTu7KyAHTsg5ItbdM3fUU+g5MJOc69uTEVOvnDsM/VKDRa+frFP
 xA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747053981; x=1747658781;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nW08n49HQoqIa405hc1jxrcqgTRuQtBBfzOxsnvIePs=;
 b=G1VKyD0x6eoFmYwwggssNGQcukrJv5eRX9FnovHRm9+gzEl7DvDtWSi7UNd/DYB4rd
 M6xiwrZZpiLIx/OlMvtonpiYfziXpR54nltgvRg7AGo+ZOsjaJYZt2x3IWlyJh0eltoX
 gDCBngYyDS+9ITypYNnMh3HGPLYRN4S9i7NlYlvLdtmR2jPRDoJ9BNT/3KoemE2EsrBd
 746LkusMtket2voHNVwmcwfU32Rmxws7ejsuiOYSrewYIqEHk/dQrtO4CK68Xhfd1m0T
 cipabdTRILphT7z2csC/W1zZnvVLPDju+FHhkZgchJDOtlNNjEYjcCHAOZyLGKFLnFpi
 gj8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWt0gkn+IY1cPMrKtnh8+ykqxEkseXoykKIw3PcpXslU8vomvQHOS9/ysH42p4260fx4LK2HdeEMbG@nongnu.org
X-Gm-Message-State: AOJu0YyhX96ZctC0P65Cekr+A/xiXGd5bV7a9PpDZxjyN/rIG7gOJWZ9
 k9+o+G7ZxlqTi6uQS0P0Ke6zf/N35hH4Jm9cmBbSxabHgE2ygkC0/3BxM1vWcJU=
X-Gm-Gg: ASbGncuzv4FUpnp53OIEXtojStuMcuiNVCVCFX16u7Rm+KbN1pYOXjHgdttoSzRglhf
 nUlm9xo7USplN/tz7Xkp08LcwU1t069/kanvx9FDMNbDd/97kVh0IuInfiwAe3qP/x/2OmtkPgQ
 wl4HaQCgy2TpAoMXQDgmUnp1iG6liMQsCk9BbQuGMeFIhqTXbTxPIvYC7NfUIf3UzxwPmUmbmbW
 RWODf5ZWbZET1BzG3qqGE/5FDwFF7C09z4Pz2AxU/gWPjqqWTUngcwq4dkHpIi0QkiW5PXscuip
 oQ3KaSNEi+U8v3Zrf4eCbWLDEpJIpoLVW1WSpaz4/T73GC9+2UP7Y26+ZH8yStxpRN1/XaxsKz6
 S6774xhJXe1zi
X-Google-Smtp-Source: AGHT+IHm18lSrgFPC8qXX4uTrV/fGhgcjsTOZRfe/SSERSfjwur8kvPrpR+cML1mxrMWZXG+3y4sdQ==
X-Received: by 2002:a05:6000:290f:b0:39a:c9c1:5453 with SMTP id
 ffacd0b85a97d-3a1f64b5e7amr10221081f8f.49.1747053981059; 
 Mon, 12 May 2025 05:46:21 -0700 (PDT)
Received: from [10.93.5.179] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2bdsm12401203f8f.74.2025.05.12.05.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 05:46:20 -0700 (PDT)
Message-ID: <d6cf5356-4cac-448c-9078-f5bbe5d2de84@linaro.org>
Date: Mon, 12 May 2025 13:46:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add PCI hotplug test for aarch64
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20250509232156.106465-1-gustavo.romero@linaro.org>
 <80e7eacc-0b71-4e1c-981e-607a4ce8a7bd@redhat.com>
 <e25812d6-cc1d-4727-b24e-208dbbe54afa@linaro.org>
 <b3c9413d-971e-4ac9-8314-93b88b349495@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <b3c9413d-971e-4ac9-8314-93b88b349495@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Thomas,

On 5/12/25 09:37, Thomas Huth wrote:
> On 12/05/2025 14.08, Gustavo Romero wrote:
>> Hi Thomas,
>>
>> Thanks for the review.
>>
>> On 5/12/25 04:59, Thomas Huth wrote:
>>>   Hi!
>>>
>>> On 10/05/2025 01.19, Gustavo Romero wrote:
>>>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>>>> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
>>>> native controller and does not support ACPI-based hotplugging. However,
>>>> since support is planned, this test sets 'acpi=force' and specifies an
>>>> EDK2 firmware image in advance. This is harmless and prepares for future
>>>> ACPI support.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> ---
>>>>   tests/functional/meson.build                 |  1 +
>>>>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>>>>   2 files changed, 74 insertions(+)
>>>>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>>>
>>> Could you also add the test file to one of the sections in the MAINTAINERS file, please?
>>
>> Any idea under which section I should add this test?
>>
>> Currently, it's only TCG, but in the future probably there will be
>> 1) a variant with --enable-kvm option and 2) it will have a variant
>> with ACPI enabled. Hence, currently it doesn't seem to fit neither
>> under "PCI" nor under "ARM ACPI Subsystem", I think I can create a
>> section tho? Maybe "ARM PCI Hotplug"? Could you please advise?
> 
> A separate section likely only makes sense if there are other files that you could add there. Otherwise, simply add it to the arm "Virt" machine section?

hm but in this case wouldn't I be kind "forcing" Peter to maintain
this test? And, otoh, if I add me to "Virt" section then I'm saying that
I'll maintain all the other tests as well?


Cheers,
Gustavo

