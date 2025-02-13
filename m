Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1723AC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiayq-0004uY-Jg; Thu, 13 Feb 2025 10:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiayo-0004uI-CM
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:18:18 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiayk-0006x7-RV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:18:17 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4395a06cf43so6879015e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739459888; x=1740064688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PnDEd1/tJlb5Ei9310dawU1gfaG7VfyufkkVrlIEmeM=;
 b=KefqrW9xy7MgmFdqUd7P1V3dfHUI7QS8JCwhdtkKjXA3cGN8Wb62dqom6Ip/NjRKNy
 egXN5eDd5FddpeX9gjMMF08Rbw+oosKdt97FX829aGqeLfv5OCNrE6O4HItR1aAGhpGm
 SEX7FR24Ex0G78JdG82iAIV1zqtV9Jkqf/siqXk/iVwlWTfPEKsbh39zWyTz6NFjEMsY
 XIiJj/0HOyr/HOUVVr2wKc3NI6UA7fF1pMCim28/7sAPt8IDj9yeqBuhc9f82L2z9sBM
 JiTumhZGlkdG0XzwIaP+3YeEYDbyARjmPovQcKHIqpq7tik85TnkI/hmStuQWuntH1eY
 XSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739459888; x=1740064688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PnDEd1/tJlb5Ei9310dawU1gfaG7VfyufkkVrlIEmeM=;
 b=taUbARVQ03ZpP1ouQABdmekLSCWNWSdGFBxvVpMxB7lOY50FodV36x3unJiIe5g8XZ
 chu6bOT7Cxg4E5klTJgwn5UbdeXswNnmxbvuQCHqLoyLZQFuMyZWaNGQhAa7p2cmA6g6
 SS1cLyEr/2h1XTHr34soVIn0oPKKoqG5PvUlnCvdHQ+YkOEhzk4NqcOeaiIQ9lj0d6ru
 bZMRq27d6JHLmC3cTmmlCBq2Tzay2suFK72DIkSR8fmFAHmGHXXkddLUtochVRUbJHa0
 Gz1W3e/puF3A+JiHzisK4KlAaeTPzDIbe6RWMh2iwDzrkpmlP/7v2IfIsODOjD8H5id6
 zIXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT6D+MdajKgFIu46pCtuzluVGkhJj4dT97m9Oe9sfXYO83pExTSrM05hRrwO2Z3bitb1DM4rghRsD3@nongnu.org
X-Gm-Message-State: AOJu0Yw8t80fpBB29KkzXk3eunSsQKZZyNC4jGoPHf7X5GLVjrulBx8H
 ah5WiSm6l6/25OCUpBZtOXAfvQ0aAHgznXOQU006uJ99VgNxtxUBcKnUgDr/ppo=
X-Gm-Gg: ASbGncvfL4Z3ieVsp/9+ylc9Tw3gzgpcXlGGAXyY51C/DPLzEQIGbJMOKYadgIXh8yG
 A6drzAyZ5D8DgkbLUS4c8o3i8A/HviXKMhsqV2jf7rCqpmzimSlyXXKxzUXLZ9IqG6KACWMe4O9
 CmUrfw/1g20ID3ULf1mK9NGbzKZfbmwZQb0ZCNYRe+SdArIJH5pAg6qk8s/gdF8CK/u+aU7QQ5j
 OAhZv4fp6Y02Dz34fm3IR67nexq/a9XEXEtquVSNytB8xuaGmB9m5xXypxJQ+mH4znbLJgeCnQQ
 v8tw7m+D+8zQT8pk5QbpZFP2ZDMPZOa1P3Zfhv4y1BYx50fc5st4GTfxfd7aAiKVwoNwrs5FqhJ
 9k0I=
X-Google-Smtp-Source: AGHT+IG+ueWyQAPQxQzr1RMYZwiP/vfXZBXyo9djTjwa506gxMSOr8pFSzlf1gqgPpfFURYinepKPg==
X-Received: by 2002:a05:600c:3b9d:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-439601a11bbmr42520685e9.23.1739459888571; 
 Thu, 13 Feb 2025 07:18:08 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439618854bbsm20171735e9.32.2025.02.13.07.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:18:07 -0800 (PST)
Message-ID: <34dca52b-5b58-417e-880a-872bac6cdbac@linaro.org>
Date: Thu, 13 Feb 2025 16:18:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386: Use correct type for
 get_float_exception_flags() values
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250213142613.151308-1-peter.maydell@linaro.org>
 <20250213142613.151308-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250213142613.151308-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 13/2/25 15:26, Peter Maydell wrote:
> The softfloat get_float_exception_flags() function returns 'int', but
> in various places in target/i386 we incorrectly store the returned
> value into a uint8_t.  This currently has no ill effects because i386
> doesn't care about any of the float_flag enum values above 0x40.
> However, we want to start using float_flag_input_denormal_used, which
> is 0x4000.
> 
> Switch to using 'int' so that we can handle all the possible valid
> float_flag_* values. This includes changing the return type of
> save_exception_flags() and the argument to merge_exception_flags().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/ops_sse.h        | 16 +++----
>   target/i386/tcg/fpu_helper.c | 82 ++++++++++++++++++------------------
>   2 files changed, 49 insertions(+), 49 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


