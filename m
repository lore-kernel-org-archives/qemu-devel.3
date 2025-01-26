Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1455BC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2Fj-0004JZ-9Q; Sun, 26 Jan 2025 08:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2FZ-0004FT-8E
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:00:30 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2FW-0000nE-H3
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:00:28 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so4721836a91.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737896425; x=1738501225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4/4z/N45VW3KST+an5TUOD50DHW+1njKFWGGaGz2Brs=;
 b=svEiF4pt4SlJQkjKAOceth6NKLW/AKYSzc2VTNoQEK/s2UsqAE8PlaLAFCDBhO4Rj8
 60a4WdnhKd1RAvBzqlAp9ZiTr1gVTKBHgaVWasUTBq8aSDslsjslByEmFEBfNCkLrt9n
 8QBW+IKVwJ+A9HUbyNjbcThzaxA4FjiXNjMQF89paHNzm/hqvCo/doYEOMgG8ua6ozno
 4zsC3JIa5MYLXRyFjziFFwGEc7PRPFgQb3GblADAjehY8Kpf7XcMzUyIz/v3Cd8lHzR0
 DQYoB8VsmJmC3voq9ku1CVDg+Qtv7+v+HfjNhnGa0YeSfP0ziFAwQxfOzY3esRh8D3jw
 xCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737896425; x=1738501225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4/4z/N45VW3KST+an5TUOD50DHW+1njKFWGGaGz2Brs=;
 b=xSzoHo8r0NTHETqNMDjw64IUiG/xuMGiRQYujqTLap3qVQk/k7mRbOfpdAFODD+821
 vv2sZOnM+kn2CddBpFfRBe91Shn7QPyT5U42FTgSmv01X710YweJ6PqYyrHof8AN1qhC
 kSKAlKwSPnSFmM1TSW2ihFSIz5B6XkJgrc87gX6Q1UCsMXDN78XYfbmaXkM9M3xjYKGO
 7+Fmr0MhUI+4NZpMD1npmigeGdHgpk80TNVFzmfAnI/t0dnVfnYYFmjdDfxDGnwBlVE0
 e8FM4pfii7+L3rOYuqyuCjoM6cYqYTmtVzuvznf+Qh4wlqK60iBLJIu4O18i+K/xdPkO
 UsCw==
X-Gm-Message-State: AOJu0YzpgX8psylnPYuOWzvGEkTmTCsWpllAbr3bP9TiHjAAMJ8dWETp
 ZcJwjaQK/ijs1IrXsN4d+TBgHTxFssUatRfhykk48lo7UAe6qQaqfFvbUMInjJ5uz0iYixlMlRt
 p
X-Gm-Gg: ASbGncvJRlak1gJzYFc3AwREGByIRBW2ogrErECiKHDqDCQi+x3VBCO8EGwsEOx15Xy
 Ifsui742oFhNdmtRcuBF6SyT8ir3kZ9tkExt+KZYTscMwECfjsBAbxt3M+YepiSW2A/4virEufJ
 Ood9v6HlDgMP8HpvqVB2xHXf9RvPK9CO/uPF/BYHk992PodgzKABFGRgrNJSSaxDTEKvhPK86J4
 2+JgtIcuzxbXX8QlndR+c1H/WIKfm60kZXctPXj0bRBeNzSH0mO4ETnrprah8C2er+bEekfh8xp
 Wu6iMeM9iq9CeQQCyx+xO44=
X-Google-Smtp-Source: AGHT+IGj8MfcuyKEzG10DPv6YnnUKm3IQqcAdylargsKlCBivCFzV0hEUBbyQe2aKsh7Q35Wbq5Dfw==
X-Received: by 2002:a17:90b:534b:b0:2ee:a6f0:f54 with SMTP id
 98e67ed59e1d1-2f782c93df5mr53243436a91.13.1737896424839; 
 Sun, 26 Jan 2025 05:00:24 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f80178e5a7sm4805929a91.2.2025.01.26.05.00.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:00:24 -0800 (PST)
Message-ID: <775ed53e-8ca5-4cc2-a025-ad6dff251698@linaro.org>
Date: Sun, 26 Jan 2025 05:00:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 52/76] target/arm: Implement FPCR.AH handling of negation
 of NaN
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-53-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-53-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> FPCR.AH == 1 mandates that negation of a NaN value should not flip
> its sign bit.  This means we can no longer use gen_vfp_neg*()
> everywhere but must instead generate slightly more complex code when
> FPCR.AH is set.
> 
> Make this change for the scalar FNEG and for those places in
> translate-a64.c which were previously directly calling
> gen_vfp_neg*().
> 
> This change in semantics also affects any other instruction whose
> pseudocode calls FPNeg(); in following commits we extend this
> change to the other affected instructions.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 125 ++++++++++++++++++++++++++++++---
>   1 file changed, 114 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

