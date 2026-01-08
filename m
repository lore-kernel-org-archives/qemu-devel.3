Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D62AD1D489
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwCT-00035B-Lp; Thu, 08 Jan 2026 15:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwCM-00034f-9b
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:01:35 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwCK-0006z7-KT
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:01:33 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29f2676bb21so31643795ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767902491; x=1768507291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=57/WsTqKcMS3SEon625XD3BEwNkw+/VwPtndEefknIc=;
 b=E5em02WXLbGQ0Dn19lh//H7sk7vuDpFgt79jOdI0vC6sYZ0U8vxJqESbzWIZO6dzwC
 sLPy40MCe3UNP4YyIXObDqr0VKDkI3S0z0JfDNL/bdtQAeLkKrLPHrAwaO0KF8T+2NRo
 8ymMP494QI+S+brsKMIqNEHqDhP1ujSEDkhSkjOXojhwrdRCwpl/dmHEKacCZdf16qyB
 gtBgBrHru9TN+rEEjAGQbDeBEUSmxkpRYlHDuLvAE8gxaTby5sR2VYHQTZ24gq4zsn4/
 7+ROYmS68c5ySU+9dH0LK7BrfQ2rL4EZ049LnAcjQKtjzhwWC0TOkaEMRobT6xvw5LNA
 gjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902491; x=1768507291;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=57/WsTqKcMS3SEon625XD3BEwNkw+/VwPtndEefknIc=;
 b=BXKOrgGVMCT6BU1QcED1RuXXBJpUsBk3vQfX6VvJmTgeIuhioKUVHKWrudYWbwj33V
 JxbvzCClt+OsHlQfJ03PYQ+ZeMENRfDgYul8IngOexh9RiOzsLHy/AiRJs4ZOMxQxIqi
 MHGIZ8c512kO/EZ9okVof12D80sZuvbk0EzoJ5kBhiso2VHKaz/eQdybjeFwTtsqOSVO
 MOtcl7tKjfsWDCQea1263YVNNWXRAT2/7OA3z1tG9uiO0KFgFrPfCkXAxKnXRL6AwtNF
 qWnHGduBFitxedn+p9EQaLgggZF57r0QQL/QcfISFwdP9GyOIo9HKouHMnqbiXjAczPc
 IPLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ+5lH0bI8vzaAkGgU4YirHW9V9HFQTqqtuooEMGy+DTKXvBAQQ4imZgctiTwd/2aF8LVOnrQDZlF7@nongnu.org
X-Gm-Message-State: AOJu0YzWbiLLwOCOrcS0cWiyYbTLk0O1IxUyROroDms/mhkN0oMjrIQ3
 +T8EHYpc52xCERtlzWVTYS+L6Nj3A2uCVy7pUi7exuGC0abWP6PpKFfx09LVdpv+mLQ=
X-Gm-Gg: AY/fxX4VsEgb9SAb/XuDedh7/GGDRWwPypmmaqJxCD38zUhA5QjbRGgbgnTt5dp5nTj
 f8+ChMqaqbOiFEKVf+8/bg+uOZamyH5KkqLKKadtqdsaIPgcDE6huUkiZl/6e35HC9RHA+FoyxX
 d6ob4nGx3k/GR5SnEOHLFsgvtu5szrIg6NtpkMeFV2F71/FWf2404ywEyGU4RZiDUhIoxsnqIAd
 yOZocT67dkFQCYcGmK324SMkw47cTG8B80zokpFxAM9JWt7R+7T0Aqzn/fRzF0syqbyw3oBfz/X
 NMpOjKMZamMnNEcFeriHt/wn4Sv6m1xRiJl6alnl91YcpulyKiEXz0kz9STFFcOOx08ZnsljsHa
 72ZFFihQWCxaSpaoZS2zsnn0qg6xJ/VyKZhQjayIOCWEYy2KU28mknO2oPtrbueB0/TsOH+zPn/
 ESaEDkSwouB+032fg7vJW+XAM2n0838hYIRhCaHDgPqtoIL8lua8T+T3RPQBP1O/syIFk=
X-Google-Smtp-Source: AGHT+IH7UR9OalIownM85qMq4r/ZRftrDhcPLD9NnqkuwAFCgI0JFvdTwjPpruyw22I6YqC3ETh6Fw==
X-Received: by 2002:a17:903:2301:b0:29f:1bf:642a with SMTP id
 d9443c01a7336-2a3ee424c2dmr63257635ad.12.1767902490716; 
 Thu, 08 Jan 2026 12:01:30 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a507sm84697365ad.3.2026.01.08.12.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:01:30 -0800 (PST)
Message-ID: <757e9a62-bb53-4029-b166-cbfafc6b6def@linaro.org>
Date: Thu, 8 Jan 2026 12:01:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/50] meson: Reject 32-bit hosts
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> 32-bit hosts have been deprecated since 10.0.
> As the first step, disable any such at configuration time.
> Further patches will remove the dead code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/about/deprecated.rst       | 29 -----------------------------
>   docs/about/removed-features.rst |  6 ++++++
>   meson.build                     | 17 ++++-------------
>   3 files changed, 10 insertions(+), 42 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

