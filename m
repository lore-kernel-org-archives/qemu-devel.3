Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A690CC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2sk-0007jm-Jf; Mon, 03 Mar 2025 05:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp2si-0007j8-MO
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:18:40 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp2sg-0004bm-Ta
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:18:40 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390ddf037ffso2136905f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740997115; x=1741601915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h9oYfY9dK1gkOtJaXYvKTMl2QkeS3k9DmvAVRfKH8go=;
 b=Pe6weueZS+5vkC+vz4564ChtnPzez2KHs710+a6bsDbRzoYpArPojwDXmMD5WZbkxy
 5Jmf5lHDXWCB1ALVUAjigMGfAaPJc3gw+RAfUJK2/nRXntuKA0SbPWyi2Ce/PeEJ91TA
 F8gF76QWvFRtehZyCUS9D11kBO/Bv7WvJars3AioZo1ncXQuL3Cp8B1Z9w3HE9qe3IGy
 WJhUOCCUPZWo/nLehToEGJEr4wRS1rlrGT/j3qsJRIFlWajA2mAjc0EZpx68jhPShi/+
 abevBA8IankhzvPZ0pRZ3IwTty9FyPIz04cNJ7eqRNIPVISAaIV+7kjTsqC4RLKaAOdZ
 835g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740997115; x=1741601915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h9oYfY9dK1gkOtJaXYvKTMl2QkeS3k9DmvAVRfKH8go=;
 b=NCbXcqf/9xw0rZtYGqkZZxdAbEMzMd7tlirKdQcfj+XHA0hIFVaZbVt7qxuVrfJ3DP
 JaD96ESAuKTxt1Wthguw1FmUUAIPNL8YVvGisY0VLWfwU3QsbtFaTHYad8Lkg13NQee4
 wDq6sevkP998NiAyBWjIoM4cla9iSNvEqThQsoxBNAo9Ugw1vw2qWamzyylLl21Spm7S
 tlwJJlN31EUblXoVkQ5XAnYNXokntqmuun4oLlzhSfalZyb2/roZeuTVstnXTG/9lDOE
 1A/SOCQFDqA2vhTxScPzNcSuk+aDXM8I4EURkwwVtZt2MmE3cBtNWCPWBEK8DC/AV4Wh
 Gn5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk7QwAs9kp5bFHyQiPDaR/Ycw1uYEfE1WNHkGhERjda/8zDINtg/G7Iw8fAdf94XSUxtyLweo2e8qC@nongnu.org
X-Gm-Message-State: AOJu0YyJ4oHkHm2BZKvgZS5nPP18CAz+QFgUh7IYeZtFLvaiI746UqS2
 XT3fmjNlYjyn5qQSQ3khaHWwN+1Krh7R22LwE5y9RV6GCVVf1N7OW3tpF2rUvqOG127Ft9/YQY9
 1TrZh6w==
X-Gm-Gg: ASbGnct/Sb3eBZhp9ma/KM/izZ9P9GbuU3CCHy731EGA8t3VvjZEEQG/TvgQuhV44ms
 HhXCSDFmig+mnWUoIF9Uj51dCEzcnl9VOT06NKwfYqLt7ZZbPFGJIHQKNqvE1RPeC0xeWC0Mlsv
 mDnHSybzS3TmtWgN6H/ZbO9i5n3q0iEVqqFFDutDHhgLru4xHxJd63h8OH221PwwkRj1RgvrfZl
 57SrxAhnstxJLg159yclXmJpLpBFa1stOxJPl2WwLwbuPDUwg3FxVh2PbJvrivE30mf1m4GeZpR
 eUwHpNznFnKoThjGOmVKJfj4xtCCszJcm7MMvUz7WnvwNAuMrb0+qYGWIVu9vl++ei0KZjgdtAZ
 d28azctu8KxVI
X-Google-Smtp-Source: AGHT+IHBg2ovyqNoZX6Xy6QlO82l5rQqSM7z38IFADFCQwdEJNUeJOEfe68kFkURkt9n7nHbDiZ3bw==
X-Received: by 2002:a5d:59ac:0:b0:390:fe13:e0ba with SMTP id
 ffacd0b85a97d-390fe13e232mr4139594f8f.27.1740997115237; 
 Mon, 03 Mar 2025 02:18:35 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e479596dsm13984075f8f.7.2025.03.03.02.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 02:18:34 -0800 (PST)
Message-ID: <63ee2093-85e3-4142-8dbb-e69e8744e742@linaro.org>
Date: Mon, 3 Mar 2025 11:18:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 027/162] tcg/arm: Fix constraints for sub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-28-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> In 7536b82d288 we lost the rI constraint that allowed the use of
> RSB to perform reg = imm - reg.  At the same time, drop support
> for reg = reg - imm, which is now transformed generically to
> addition, and need not be handled by the backend.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/arm/tcg-target-con-set.h |  1 +
>   tcg/arm/tcg-target.c.inc     | 11 ++++-------
>   2 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


