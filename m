Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50192C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6nW-0000JZ-PB; Mon, 17 Feb 2025 14:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6nO-00007f-EY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:28:47 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6nL-0007pP-KZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:28:45 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220c8eb195aso96692635ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820522; x=1740425322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VEJ/B3GBCyQg1NZ8srPFvpNFWpxr50mPaKhI69Ppxgo=;
 b=OyYcGtjmYyXLq4ROhgyRLznQTA9gm9m/4XCVtht4IXiSXah+m1vv569wIx/2I5wQzs
 lQwynOh0iWkNGzxcidqKqqimLL9g2smx4IMcCw5Jp73R0LXInMRrtL2wLhYbA/i0HOUb
 fW0Io1KCYVUiAfDQcvF2zZoPjFTr9hp2BUOKo7HGshK78FK3e/aecGw3FznYTwdgbkB6
 znhEOXrC7RbfOoPRPrAZMuutsFjzu79HDNvZNBtUGV4ilm/X6q2U4PMVdYvDhfxwSnVf
 zUe+skYp+76/iSs+bu3UP/Ys1WdcmmKAQkf7rfAdnfYJDMolO519B3pQdcBknDIN6vYQ
 iPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820522; x=1740425322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEJ/B3GBCyQg1NZ8srPFvpNFWpxr50mPaKhI69Ppxgo=;
 b=Nu/gNEU4hOJNSIpocTBOj+GLvt+dbRrAM90dPxOB1z62uir7Tls1UYEfl8PH6iFwJ5
 BwppNyyHzxZJGzaqQXeSt/TZJK5b4WRwb6T7p7gNboJk/B3jGg6YNQfNTJcQyIMizNYk
 G1x4Tqz72z/7ucwubqxhIO7hPxCBbBgp6Yja/TYkBXxLmB3ZnTZQzURaDDiNY9WYvtQ6
 0wAysGZqVN3Deoa+MY0swjmKNeqJg8w7Yc6JmWT0UjdQjRHihWJEAsXmnVfaLpUv8FY4
 tytkAPCr9MAV7VOs4eHrWj4CRjwFbNFQHZy8cSz4yd3PZmq4UAPvKLfNhYOFjq+BqRnq
 +MSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtAGoov+vqxhB94/Te/86pp8ebRJTYhhoXLRFc9pG78dzno5/0amFSoRzY/Scq6E971PIQoiErEHxv@nongnu.org
X-Gm-Message-State: AOJu0YxkuNufmwyos/Su0bGQxH4mpPJJF72n7+YoKeT8w+HbMx9yne5Q
 riLZMcVZ32lPgtApy/1QPVskntBfHHsCi23liBTQiV4R3AfEEn+Mzh69E5J2jDM=
X-Gm-Gg: ASbGncsZH2NSR30Omd/UqmlTvE/Sxn1i+bIY9noKNcWtdEK0Yuric3qFqsAixlCV3tz
 Xitg3accV+4beyADCB+3EYFx6UlR5d0MUek306oBanubyyXESCqfnvO4kz2YB6I+5IikYec9Iir
 UxLr9cmktU0vwoloA2XmtmG4x6H1/bXSeJhu1AYl3R/TUrjAjhf4IQ/yVZNhnE/lUmLeRcUd9W7
 lxhJ2VyBfMRJdg50P7WuBaVMpPbsWPWPlYo63g55MXptZXe+1d+QOYIOv70OzXCnkaxQeC+2IdU
 3jsEuCr01n0a3oJmVi4WyCVCSDLGdqjT0ps2ao1TBNWbB+2URuAqJ20=
X-Google-Smtp-Source: AGHT+IFw9x3ddCLNhBbl16dPCQzotblc4ykNeeWquQsvMRT1NjsLlII2PlFLuCRaJQswwJsL3MPGMA==
X-Received: by 2002:a05:6a00:2e08:b0:730:74f8:25c1 with SMTP id
 d2e1a72fcca58-732618c0351mr14386201b3a.15.1739820521870; 
 Mon, 17 Feb 2025 11:28:41 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242568a0dsm8436448b3a.43.2025.02.17.11.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:28:41 -0800 (PST)
Message-ID: <3cf6d45b-0d0e-4669-954f-a545f3ec1a37@linaro.org>
Date: Mon, 17 Feb 2025 11:28:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] cpus: Restrict cpu_common_post_load() code to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-17-philmd@linaro.org>
 <e52485c5-122a-4a95-928f-08fcd17cd772@linaro.org>
 <a8be34a4-c157-4a5f-99bc-50c87c1330b1@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a8be34a4-c157-4a5f-99bc-50c87c1330b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/17/25 09:19, Philippe Mathieu-Daudé wrote:
> On 26/1/25 22:16, Richard Henderson wrote:
>> On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
>>> CPU_INTERRUPT_EXIT was removed in commit 3098dba01c7
>>> ("Use a dedicated function to request exit from execution
>>> loop"), tlb_flush() and tb_flush() are related to TCG
>>> accelerator.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   cpu-target.c | 33 +++++++++++++++++++--------------
>>>   1 file changed, 19 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/cpu-target.c b/cpu-target.c
>>> index a2999e7c3c0..c05ef1ff096 100644
>>> --- a/cpu-target.c
>>> +++ b/cpu-target.c
>>> @@ -45,22 +45,27 @@
>>>   #ifndef CONFIG_USER_ONLY
>>>   static int cpu_common_post_load(void *opaque, int version_id)
>>>   {
>>> -    CPUState *cpu = opaque;
>>> +#ifdef CONFIG_TCG
>>> +    if (tcg_enabled()) {
>>
>> Why do you need both ifdef and tcg_enabled()?  I would have thought just tcg_enabled().
>>
>> Are there declarations that are (unnecessarily?) protected?
> 
> No, you are right, tcg_enabled() is sufficient, I don't remember why
> I added the #ifdef.
> 
> Could I include your R-b tag without the #ifdef lines?

Yes.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

