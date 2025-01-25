Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2449EC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhvy-0004E4-SN; Sat, 25 Jan 2025 10:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhvx-0004Du-C2
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:18:53 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhvv-0002y6-P3
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:18:52 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-216728b1836so49240155ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818329; x=1738423129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ib3uNi5ZsSFFHuu5nsJqRbOl73cX4E8trcjhm0eJBT8=;
 b=oapnR8pfJJCX/GakE6qOtjU4gYQD6w/Ew4EJ2ykmYBEuXYlh+pOb5b/B+8eFrUuHFp
 hWxO4c+JE6OnIuJSYjyu1iNvjHs5Cvu72lCmvvtf+C20fWx/WcoEzWnH6pXWhIUyjDKv
 rUECPgvCSvlfBCEgo/cFW9VyKpRpNn2ek+fKKiuVKXmQW984530hGSjLtUIbkDUvhe3p
 UjccGHxEHYW2tOshjbaL4ugRK5YXGYPWoNHuv/TfttsYZVmQCIMIpf1Zis01UtLPvDQ3
 LsCNuRsJTBv/JeD2h2RVjh8ylbkiWyv7ss1gmrtajkDKNSsHyOEchy5Uq9yKVk/aXN2z
 Sp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818329; x=1738423129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ib3uNi5ZsSFFHuu5nsJqRbOl73cX4E8trcjhm0eJBT8=;
 b=IlRMVJvYkqMRFHCokMb6Bnff4W/O4+7Kp0pYkRE1c3vP39xrhWm4BlREJATdHPjoVH
 vU/v5nC8vYCPx+VRVQk5QLzgHJ59Ev4k38f4sPQjOVuwo3FKlJskiG8sSVSTwiZkGI8p
 57DAXOmlHxS/SixrjXrhRtAVum5hHFcOeivo3nK/9E2ag8G+zT/SjSAGmd4yVj/BP9Y2
 OHRMjrnxcrQSd+o5u4OExB2ZFezAdl0D3gS58Lbrl2hEE3f8Qx3AppB2zYYkcMh+03Li
 MJg52CLFKhbjZePildLR7lrpt0ngejvlBIzltPKtcpBLIrMrGOtXyYACFMR5LtI+YHhO
 lJBg==
X-Gm-Message-State: AOJu0YwOeDaFf74ew4xvgfmhAI9+EtPKJGN7/99q0HeVS15YGgoTyb8r
 hREn+HhCg2dUNhpYjnf67ryORF1dSEOjVcG2W9LP66slmoAwkCTEKQJ0kfWNCC5q02z5DEeHfUV
 B
X-Gm-Gg: ASbGncvQDf0j4k+okUQbO8snPhini8O33AeD8lPfQK+B1KDZCibwOlRNrhPp+uuzgS4
 5JlzQs8Arj/usxLdrRSfsBMBhyln6qZ3LUajIFaWpGqaW3sCARkF6edtFym2alHCFlj/qIPq381
 xiE3i0rbyEovGxEeJasekdimTEpO28FQ0WW+9mKGsM1LEcCoLTLQQVi3GQ9+7FvSVVwc84edYhT
 rcHOsTD2FHyBoyhCh9RguVUQ/sX8uC4R9zGPhB4OmMpEQMrJ2sz98RupwNDyCJqIc9ririLEeBF
 dsctTJwk8jUPfWGSzyqfsQ==
X-Google-Smtp-Source: AGHT+IEctn+wNeWotU52lfrzMYSIjJ29S+zGxihWX+IT6+fhLv5SxCSrPl/UgxSyrjvTOau0LBzJ0Q==
X-Received: by 2002:a05:6a20:3d89:b0:1e0:c6c0:1e1f with SMTP id
 adf61e73a8af0-1eb215e1995mr59195881637.36.1737818329373; 
 Sat, 25 Jan 2025 07:18:49 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c585sm3900131b3a.130.2025.01.25.07.18.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:18:49 -0800 (PST)
Message-ID: <c36cb2e9-9eee-4b0f-98a8-6f2595ab7fbc@linaro.org>
Date: Sat, 25 Jan 2025 07:18:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/76] target/arm: Use FPST_FPCR_A32 in A32 decoder
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> In the A32 decoder, use FPST_FPCR_A32 rather than FPST_FPCR.  By
> doing an automated conversion of the whole file we avoid possibly
> using more than one fpst value in a set_rmode/op/restore_rmode
> sequence.
> 
> Patch created with
>    perl -p -i -e 's/FPST_FPCR(?!_)/FPST_FPCR_A32/g' target/arm/tcg/translate-vfp.c
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-vfp.c | 54 +++++++++++++++++-----------------
>   1 file changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

