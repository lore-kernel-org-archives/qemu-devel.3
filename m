Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE6BC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 06:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4wOu-0003Rc-24; Wed, 16 Apr 2025 02:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wOs-0003RD-IB
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:37:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wOq-0001qH-Nf
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:37:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39ee623fe64so69985f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744785450; x=1745390250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uc5EnQN3Tmcghyyxf6lUY3FxI7dEP+ytgX5uwIAE2jE=;
 b=FrQyYkUhpN0KDIFsFcRFiDioD6ZuEm2YG2MRo/wPTZKw2kua/sc2KQDMetiJGcHkPa
 8se9Zdx9w3S06WLX7JjcBPO/pCeX/1Q1JpuDBCSbuBCWLc+Yv4VAtliqnbM0MG4sd4YO
 l/qWsfWvE92G18HVjA5v8kzDCZD8k6CUk/X5AeQYcDWf4uakgwAuhEqYBTCC41uALlnI
 A5TYczPGEs5BpEGrerBxAYDsN4A7X/wj5TwRcBFkIwnDp5yMjuLI2IBnNBq7i5N1iQQe
 aOAFqxmlOFmk0cGxBMiAvkOo1JRaGofNrxg5krubfgoCz7nzzvbGtjfvn3JajrHeQT3w
 KKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744785450; x=1745390250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uc5EnQN3Tmcghyyxf6lUY3FxI7dEP+ytgX5uwIAE2jE=;
 b=CAkgdgGhia8GBFeD2Ya2KVktGOKIeMdYExSxK8egSoqe2Wi8AquIotRKU0Qr+BAi9f
 n3cwbkCasOOlcnt4Cv7rP7biChjnVZJ6JxYI0rwjbXcaMtuiKPaVC6HWCmImkzqCByRg
 +OgTFqb+7BORSSPfp+TjB4I+4wj2dcie8TN12BZVMDtVM/ZZkkNSGSKeJsU09roxiOl1
 HBEQjE/gLGIeVewIOCDrLdmbSOw+KAbcBiHtpCJgyYFY02hTXGpT+UWU0wHd4rKC6P5X
 vNLnusrCUmCNzX/vJr8WdKjeu8TxGZmor6YJacyVctxy4PjcIiY0W3AgzOzMVoF23o3C
 SZ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYSAbueycQkQjnQSKvnOmpjopsmJ79DkZUUXyx/jJdzixagMnh0hSaA7XHZUQeQ9JgtqGvcOUHNtSV@nongnu.org
X-Gm-Message-State: AOJu0Yw/x4+WCgRtMMWa6ep0w/hbwJ8Yk9EWCRCHVVnVg4iRGWWV4wvT
 /VKGAQB6hWotfpmNH+OG9qK62POAw3gfiFTVCt/Y6VkOaWSAdjyG70VmJkAKwzuOlOF0VWLdXKR
 Q
X-Gm-Gg: ASbGncucKeMd1kElG+v23qBKfMaEwDpwRmlVmyAtkXhU5Mo2mol3HIRe38rsrdDyzN/
 zIOcG0WfPNgP9BPje4aZdNCpna/0gZKEQddL/nA3WDJBA8GrzVMfR+YFh8/JztBLgeHRcH5fDri
 SiFpOmMcib0+9A/5isCNjO73YyTsvM7lFMa4TBqOg8bP73mn3CUaBtJSqaLLYXZFWJFgAPnfDdX
 nJYNKwVNsyZtYOL3jqSlMgKkkNIV64z/gDCjXUSfqd/Ci8KYePMC3ssZUQiAj4cjmofXIZDJR7B
 nCZhamt7GtA2vlT3b4m9YEk+zQ4OMwaK9jfWlOo0IVlrd6+67FsU9QuUszHCPd5nKTn+liFE1Ws
 g31tjSg==
X-Google-Smtp-Source: AGHT+IFGng5yZVELpLtkVlrCMuUzvNcw69e8ZdzDMVTy/faxE0UNodsIowynVszCmkQjdBqjSI/Ibg==
X-Received: by 2002:a05:6000:4021:b0:38f:4d20:4a17 with SMTP id
 ffacd0b85a97d-39ee5b15f39mr524970f8f.13.1744785450666; 
 Tue, 15 Apr 2025 23:37:30 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9777absm16035111f8f.46.2025.04.15.23.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 23:37:30 -0700 (PDT)
Message-ID: <a837f60d-0eaf-4733-b7db-b9c4eb25e863@linaro.org>
Date: Wed, 16 Apr 2025 08:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 111/163] tcg: Move i into each for loop in
 liveness_pass_1
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-112-richard.henderson@linaro.org>
 <f4d615f9-465d-4d18-8e96-e817f241a175@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f4d615f9-465d-4d18-8e96-e817f241a175@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 16/4/25 00:07, Pierrick Bouvier wrote:
> On 4/15/25 12:24, Richard Henderson wrote:
>> Use per-loop variables instead of one 'i' for the function.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/tcg.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index ed03840988..9da6c8bb4d 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -3924,10 +3924,9 @@ liveness_pass_1(TCGContext *s)
>>       int nb_temps = s->nb_temps;
>>       TCGOp *op, *op_prev;
>>       TCGRegSet *prefs;
>> -    int i;
>>       prefs = tcg_malloc(sizeof(TCGRegSet) * nb_temps);
>> -    for (i = 0; i < nb_temps; ++i) {
>> +    for (int i = 0; i < nb_temps; ++i) {
>>           s->temps[i].state_ptr = prefs + i;
>>       }


>> @@ -4215,7 +4214,7 @@ liveness_pass_1(TCGContext *s)
>>               default:
>>                   args_ct = opcode_args_ct(op);
>> -                for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
>> +                for (int i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
>>                       const TCGArgConstraint *ct = &args_ct[i];
>>                       TCGRegSet set, *pset;
> 
> Looks so modern! :)

=)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> 


