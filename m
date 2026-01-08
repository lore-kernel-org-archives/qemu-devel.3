Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A3BD1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdx7w-00013X-0X; Thu, 08 Jan 2026 16:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx7t-00010D-Iv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:01:01 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx7s-0003es-63
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:01:01 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c2dc870e194so1946254a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906058; x=1768510858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b4RCuymLrLvGTa//HZc5Us7uFSu9GMSDhbyEoYVerb0=;
 b=HbE/GnRRfi1GbzATfITCVeZCZmBnZ7Syfbwar+ONsTWdp6Maua1ORo18MggJAmWwpf
 SdKWqy1ZsDmYV9gf0y0QnXACD4M0XCjvfBJIkHNXpEMBIopzWfAQ+B97sqU7/yM+8N5o
 QSwAUt5NU82vV+FLmddF6t081TVq8yYTI0KkMtRGlDdT8EOcZgRLEPmoLrHtbGmzPh8Z
 4ZTLGsk8MVBX2hGpFlmKTPNPxB0HM/eZvf4UMkaiinUKqLxgPthE62s9bPrai+VIhzVa
 MTjRJz6ACfV6Of0l4AHrX6Np4J9cr6DqemDk6OM+6e11/hU2MUbcn1/iMoBeySh8a04P
 MJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906058; x=1768510858;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b4RCuymLrLvGTa//HZc5Us7uFSu9GMSDhbyEoYVerb0=;
 b=Gtr6PN3j8RRDPoY0yj1x1hxfyZrc04clb+8bTB/fHZNbJyweKe3oiyxk20RsZXSrqY
 Zy/+T0QY3VteA/A1KLfVQbbErIPWOzqZ1RsAt/OxXvg355ZQb81H+XD5Fkh+t6wvnvsx
 G+aPdQXx5kpUwebQjTdMPwhn5HDpTZnt0jyyd0lFXqf/0Ya0RXVwAhHqmeqy+TP/PDkb
 CtGCgSWugqUmkK/Pt+Bbig/SZ7LUL5UzcMHw9srenA5KRGkcLH6S08K+jHPI/c3Q0m9l
 6yh4dxoNNw5ZYd8/xCbvZoNjIRq4OGvkcvR8ke0qV3mpjW80Q6KXjY1BPX4YYrpDMniw
 vKow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5a+UEaVgWuQaGfpB++++2FctXJkIJq05NDjtoaxfL789FdRKRf/Qwm48QDPxlM/JRz64MBEdNbiqW@nongnu.org
X-Gm-Message-State: AOJu0YwWTQGEvR4iYqLgEMcR4COudYiwPYX49yAtdj/Ytt2mT3KBdx8I
 e2yOUERC/MQMj/phMWLkP7UDLQHYXuOZH8jl1612+Z9jvqWkRMl7yRRJa/pjHJ97lek=
X-Gm-Gg: AY/fxX5lCVZ7m0s7MNZWNHM0Ihi80+wXCR0+qNiA5z0ENAAzC9n6DECMsXWSWv1ysUe
 nU93kSONfc3jelf1jvSUDJPa4v6bF7Z59q3+jHM95x61Q6f+qrxdRPeI8tyQ+qFiSCVrfXzlu0P
 9MSuDLmDRHdMVOTT1++/5cm1QmsjrQyzNvMlf/aROh8OEaSHTI+VdyAJVRJwukPg8dZpAV3+m/P
 W8kgJbVfOnR9KjpMV6csPh6nucamOM/G2pFWFQ/Pv8o5tQOLao4Wf/c4WCfiJI75Va3u3d8/XrU
 GV8Qmlatdma0D3EtFF2qFVsc3r3RvgdpHYl64fnB13yduLy6eXeNsaJYQi7p4hdo2HBEDR/oHJF
 10+tuxv5MtsMLv9+DSPh/dcZEQk5RjsrMPAjE3TzWH+K6kyQcySzIvdiSL9/C0KQQldHz3ZjPFk
 UOzT9ZwbVAvN18RWh+oMsDPhpFw3+hbHTP/oOIkL1uHkQt5wXF+k+LYxqE
X-Google-Smtp-Source: AGHT+IGiiL33UXXbHy48fmKMZYfcl0y4PHed9KVCw65zhMNfZUnZ2oIk7/AdU+EUoPMlsEehJGN22A==
X-Received: by 2002:a17:902:ce82:b0:298:1013:9d11 with SMTP id
 d9443c01a7336-2a3ee4c07ffmr74505895ad.43.1767906053672; 
 Thu, 08 Jan 2026 13:00:53 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c39fefsm87474645ad.17.2026.01.08.13.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:00:53 -0800 (PST)
Message-ID: <e7896898-4e2b-4f8a-930e-aa3f031c5e85@linaro.org>
Date: Thu, 8 Jan 2026 13:00:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/50] tcg: Drop TCG_TARGET_REG_BITS tests in
 tcg-internal.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-30-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-internal.h | 21 ++-------------------
>   1 file changed, 2 insertions(+), 19 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

