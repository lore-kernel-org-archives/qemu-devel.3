Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E50C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqRy-0004b4-TY; Thu, 09 Jul 2026 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whqRx-0004aZ-SF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:14:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whqRw-0004Fw-2Y
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:14:05 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so3818a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783610042; x=1784214842; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nr5Gyw2tG9V/vhCw47CREvMaOAoUvQlpEtddTOeoIBA=;
 b=OnqYZc69WCvuMrRmufW8CEQR0SBCDT5quyiKu1qBwl1pzMSvo9neVKXo5LOm27puUY
 /IA6/dL6oz6/OcXcEj3QxCNvQVZkXl1wXi8k0PveIbKWZbW9OhTdwgJJDM/zAEIk3iNt
 cOWoAfMKUs6oq09Uqg2N7TxaS/GWMamIiumYMrcGhcFQ/iRBhoGb+cHkdzc5jeccHxgC
 gmd1h4Ro+b17bI0hugDp0JgGAapCwJCRMHoVTYKmoioctBO/UEqbdAu/4XqaiKH3SOhp
 koAXQwjQfU9/WpcscRt2KX43HynKWlMSSUzvyTMBZNiVm9LuLRVxMMmrwWLLwV0aRASf
 6yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783610042; x=1784214842;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nr5Gyw2tG9V/vhCw47CREvMaOAoUvQlpEtddTOeoIBA=;
 b=WiUZCOchqThyZ4GPkRbuf1fdje7lbwpr9uUUy0H/SmrokDC8yHZmCf9d3odEiYgfJI
 rRabNx/SBrFq8BszcAc0ewqVmi2Q9M+ODLytT2j1FJXkHzvltVfLhTGMhDPFQsfP70Y4
 knmeVO/ij1cQIi9Fp58DLxFXkbIIDGpipYokWn1AWwUbtHuMfaqGKGomls6KluOnpctI
 lMedI07voK1rmes9AP3M2JN6CtyNZwmalU5+0PRKqakKP+2/37bWm6KJERplDKuRMGlk
 GqxNYrAPf48zAfyGumqrrePJW1XLcXMfhViSEhK5FURTDs2FBzErwHDNqRKYvCAEES/2
 O2Ng==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSy9qbHu4ovNlhpFKkZURDYUY+E6wEcOpWgKiUf0Fm/ADfkYceJ2TK+olDguI79bKvFhAwrC8dZJsG@nongnu.org
X-Gm-Message-State: AOJu0YyLpDswB2zz5tC4v/zIOAWMKg5pkM1tPfEukf9IEdHP6T9PFRTK
 APQ2mqdrlIF36ISNtU1vxlIKQewTs8DbeHxqlnobOtN9gZs6ZjeEFxV14torO9vo9Mg=
X-Gm-Gg: AfdE7ckitVroHreEvNI/JPR0uM7o0DQ/ilrJMXcvYedTtmM/BGcKsVZGXJlRpPQ1tch
 pIT26V7e0rDPysdDWUPFiFYJuhbXcVvRis0Eo9fWUvQAoCDSIpQjetOfzZgeQKmLT5mjoGPn0W8
 suQa+JeVwygSCrZ7KSRdFcV42aQM+fcdGjhXq+1cOMUj0g392Q+d/N6uj62CaLufxHhPuwtMaF/
 f678fWa4hivOLrH/W/YC3m35l3Exhyea7QtdMHj2/n3t/q5eXZd5xODWHgJxhXk0PjtzoLGOIgL
 Bk+NZKL29ZnsImhEC125p+hlWwDuTDqFjZytfXMwyTa5ZoG3ikaWUCUXSlPGA1O0cVFtzuzazLK
 2vUcDycVMaofxQvfBYtIvGUnFawHo4+WB02QitxrlUCtolMUyX8sXogKPfhgE0ZH9PgWe9XSQ8S
 J6rjmSuFW7jxevJRgue7pmuuk1ag==
X-Received: by 2002:a17:90b:568c:b0:387:e0db:bc34 with SMTP id
 98e67ed59e1d1-389426961c3mr7306988a91.42.1783610042417; 
 Thu, 09 Jul 2026 08:14:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3cd0bsm1375787a91.12.2026.07.09.08.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 08:14:02 -0700 (PDT)
Message-ID: <66efca37-5e6a-4c89-8df0-ba74198400c3@linaro.org>
Date: Thu, 9 Jul 2026 08:14:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/loongarch64: Fix cmp_vec with TCG_COND_NE
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20260623140609.645445-1-richard.henderson@linaro.org>
 <11442fc4-dca8-4bdb-b921-4ed749f4f0de@tls.msk.ru>
 <dfb00ba2-91cc-4c7e-bdf4-44ae97b08576@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <dfb00ba2-91cc-4c7e-bdf4-44ae97b08576@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/8/26 22:54, Michael Tokarev wrote:
> On 09.07.2026 08:45, Michael Tokarev wrote:
>> On 23.06.2026 17:06, Richard Henderson wrote:
>>> For NE we need to invert EQ, not swap operands.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3589
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> This feels like a qemu-stable material.
>> I'm picking it up for the stable series,
>> please let me know if I should not.
> 
> And for 10.0.x "LTS" series, I'm also picking up 2 extra commits:
> 
> a079836005 tcg/loongarch64: Fix vec_val computation in tcg_target_const_match
> 911f7328e9 tcg/loongarch64: Improve constraints for TCG_CT_CONST_VCMP
> 
> which looks like an improvement too :)
> 
> Again, please let me know if I should not.

Thanks.

r~

