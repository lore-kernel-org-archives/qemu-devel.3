Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57843C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 21:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twp5Z-000626-Au; Mon, 24 Mar 2025 17:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twp5W-00061k-WA
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:12:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twp5U-0003gr-QM
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 17:12:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227b650504fso34805185ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742850719; x=1743455519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0QyIWcLuKy6ayyJnu5/t5A5DBKW0SwtVnX/A9OP+mX0=;
 b=oWEQeQ3IP7xtrlyv4vmHB1yI41TMADEB3oiQua/wAv6PQtyNk4jw4phr7QuaAbfS11
 pkRMVcwaWUKvBqswgwRS2XoZDwcDP3YzoFfJXpLJtgCLFI3j7/BtF/LmF441GMRW+v61
 bu0B2PEkF/ccZ8WvCYqhqsSPvVYA473cb+ADuDcDDa8lNgG96iiM0OZV0dmtpUgNgwQq
 xW516D3uI48xCH1Tw5k32uFZsW0gv8EFIguxAld+V8YsNdJycYOMGz11hPNjYhJ8IArC
 viCLO+0f3xwG1JZQ6doqDpkyDz18FhOGe4tmU4KqcHE+MDmEXUgdDFzoqy1URZvy71b0
 ao1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742850719; x=1743455519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0QyIWcLuKy6ayyJnu5/t5A5DBKW0SwtVnX/A9OP+mX0=;
 b=s4thrS0hvvhDS8u7F2+qJo4ZjSvJ/hSIFgS2VkCskHKJGnseRf8UXnuSJcKJtLz3Al
 M75v3exkvgwi4S4tDGdHgbBvmYPpWmNJZSXPJeDnDjWXwcXj7bYjYEuvwBYzbOByth5F
 okOkiqv0fiqKD5V9G5v+mL+H6dMtRAKq3cJ02Pn22ZrhJ5kqxYWnZz+Rsj+qgjOhkAS2
 zb+OhkMWwS/FDFVTt2Kv7VuT8J38RJDFeNXQOMD2IuoWygnWxnfz25BYmwOpxh5hSAKo
 uz8s0LfOwkKWGOZ81N7JOpcmN+d4+y2NH5zwwy6u8BWrwcxLEJrs5ffuccIoksg7in6G
 D3nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL2qN+oicn7+aGsNKnMiLR69bl19UDgb6zgyTKoStSoPHbkxPkgtDDX/SZfucrzyZozGJSxZsUIMD4@nongnu.org
X-Gm-Message-State: AOJu0YzV+H5ixW2eZ2WxwaYvPTLAzM7dCySaqQ6Bdrqlsk1cGGEzGA+T
 K15rZX97fl3r0D4UDx7wgS4UxejY2Qiwwn295VdRGESFslClmi/pvr7eCXy4QVo=
X-Gm-Gg: ASbGncvTTpUZy5GGKgImY08yhsFWBR8oC7VrHaFNkNFvSpWmlcZyNcws1EWlsboRvHR
 wId+uTeqaONkSN6Udb+NQoTjxQgJ9IFQrx2Jq9EQLH8ksFsfHhCmxmKbqUZGs4E3Vyy6tU5dnY2
 Zdff6QwCTbpJsrsuvCAazHh8tt9ayCZtDQFBACzNtOkLCbh9vqI53wiszTfPWcJ362RooxZemT6
 j7N6tgPQ8qOWjUE3k7KBHii5ATBqjgQ/zqulAJd+B//n2xGblmASPDbUYZlkjK1yLKrGuqB0bbL
 Mxu0eBXq2th7kRMK9aLb6xbvfQvnpKZrbS13+sV4XX2/5iAK5Lq7owAydw==
X-Google-Smtp-Source: AGHT+IHhKhK1Wampe7HG5CfLYgXfzWCQTUvTf2PVOHx87p/lS/w3GjKKNRuQC3jxYB7GAzu+vy6I7g==
X-Received: by 2002:a05:6a00:1702:b0:736:3ea8:4805 with SMTP id
 d2e1a72fcca58-7390597f7eamr17945734b3a.7.1742850719026; 
 Mon, 24 Mar 2025 14:11:59 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73939d2bdb1sm1805196b3a.144.2025.03.24.14.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 14:11:58 -0700 (PDT)
Message-ID: <11b5441f-c7c0-4b4c-8061-471a49e8465a@linaro.org>
Date: Mon, 24 Mar 2025 14:11:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/30] target/arm/cpu: always define kvm related
 registers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-21-pierrick.bouvier@linaro.org>
 <1109fe22-9008-47c6-b14d-7323f9888822@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1109fe22-9008-47c6-b14d-7323f9888822@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/23/25 12:37, Richard Henderson wrote:
> On 3/20/25 15:29, Pierrick Bouvier wrote:
>> This does not hurt, even if they are not used.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/cpu.h | 2 --
>>    1 file changed, 2 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index a8a1a8faf6b..ab7412772bc 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -971,7 +971,6 @@ struct ArchCPU {
>>         */
>>        uint32_t kvm_target;
>>    
>> -#ifdef CONFIG_KVM
>>        /* KVM init features for this CPU */
>>        uint32_t kvm_init_features[7];
>>    
>> @@ -984,7 +983,6 @@ struct ArchCPU {
>>    
>>        /* KVM steal time */
>>        OnOffAuto kvm_steal_time;
>> -#endif /* CONFIG_KVM */
>>    
>>        /* Uniprocessor system with MP extensions */
>>        bool mp_is_up;
> 
> I'm not sure what this achieves?   CONFIG_KVM is a configure-time selection.
>

CONFIG_KVM is a poisoned identifier.
It's included via config-target.h, and not config-host.h. So common code 
relying on it might do the wrong thing.
As well, its presence is conditioned by target architecture (see 
meson.build), so it can't be enabled for all targets.

For this patch, it's only cpu definition, but for code based on 
CONFIG_KVM/TCG/HVF/XEN, we should probably check {accel}_enabled() 
accordingly.

However, at the moment, I'm not sure what is the best way to deal with 
it for common code, as {accel}_enabled() symbol can only be present once 
in the end.

> 
> r~


