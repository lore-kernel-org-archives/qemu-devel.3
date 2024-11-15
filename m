Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F40CD68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 18:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC0ge-00066B-UZ; Fri, 15 Nov 2024 13:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC0gd-00064f-QE
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 13:04:51 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC0gc-0006ST-19
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 13:04:51 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so1652055b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731693888; x=1732298688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PZtU5GCBkriYC9c6QuvY3eWUYDt+z2Pm7rxbVveCSR4=;
 b=YZD02N3Xgu2mT62hFxv/mcluiQOLXH4Mi2CSOPcn7CdANR51Gwij36DHWKcdt0dvBX
 2Kyh8BwmBpB6vb0guE9vDJ9JoxZyL3003sCzCgtaR49B+emolGPhs7Ges/m7WGDFXfmq
 75hnOC15sCKY9T4KjMsmmBDJ0LFWuiMpGqwBGeO+RsAK4Wiw1aFnVUo20qtFgXY2t/nS
 n+0giISnJUcumZ725v1q7tFjkhBF1HkTWiLvDONAyeVvPMHVzCkeGDn5jzm0dJM2mrzM
 2vK3x+eZcB/eLyehHDtIahmfqcOYupNKfZSC//b4N6uV0SfqTbMv/Nz5/yHigFCSZeqB
 oF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731693888; x=1732298688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PZtU5GCBkriYC9c6QuvY3eWUYDt+z2Pm7rxbVveCSR4=;
 b=vxg9RQWLetmp071CjL9AnnTxOlgTrmBrRV4wX19u95rQ0zsgkbLu1rR9yRIUqv5HKo
 2vR1CvYYRnn6Q3ylFg2SyioGLGGautF97RrczBtLF033a/vDOE6xwMyTG3w5rj7VC6tw
 Pb32b+6eysFWPJivm0zdSH4NO1G6Sr2D36w5/LTvDVcUV8kYMj99Pv7Udlad7oMPqvb2
 OSBSlLRww9kg1wLvWarxKL5OS4uXiGR9l1BJfHuHUk2tU02xWothrMVtDESyWdAwGuU2
 ucJ9nnxG4VJdVw9ckXCQLE9XRzt2TWO28bmZGNMQI55de5AXIP3kW0hEEi75EkuWOIiw
 5y5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV9HWyk9pMyJdmERVCk2GPhvJtKznCtSaY5jWSV3CZUGr4Ri3BTorbQ39fY8Z6j4Vqmuc9nhev/U02@nongnu.org
X-Gm-Message-State: AOJu0YyHDg/R802cLMCe8cnCPgq6r9CNvRgqne1eerTR1sWKu71nCO/2
 bevlIgu1g2SrcIifi1UH/Dcuob9P6zQZ458x9rs3Gxl1AVsvQx+zGYt6Adv78Yk=
X-Google-Smtp-Source: AGHT+IEuH3E5RE0MG4gZfGh2oIkH3IgU6/7+agJgKrRRhH9C7KduQ6QRP2x+9npeKXQMByTiZ1l4UA==
X-Received: by 2002:a17:90b:4c52:b0:2e2:b45f:53b4 with SMTP id
 98e67ed59e1d1-2ea1559acbfmr4126179a91.25.1731693888256; 
 Fri, 15 Nov 2024 10:04:48 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea2bb905e9sm381662a91.48.2024.11.15.10.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 10:04:47 -0800 (PST)
Message-ID: <06663fe0-9001-497f-8652-ed3c079555d3@linaro.org>
Date: Fri, 15 Nov 2024 10:04:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Allow top bit of SIMD_DATA_BITS to be set in
 simd_desc()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241115172515.1229393-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241115172515.1229393-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/15/24 09:25, Peter Maydell wrote:
> In simd_desc() we create a SIMD descriptor from various pieces
> including an arbitrary data value from the caller.  We try to
> sanitize these to make sure everything will fit: the 'data' value
> needs to fit in the SIMD_DATA_BITS (== 22) sized field.  However we
> do that sanitizing with:
>     tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));
> 
> This works for the case where the data is supposed to be considered
> as a signed integer (which can then be returned via simd_data()).
> However, some callers want to treat the data value as unsigned.
> 
> Specifically, for the Arm SVE operations, make_svemte_desc()
> assembles a data value as a collection of fields, and it needs to use
> all 22 bits.  Currently if MTE is enabled then its MTEDESC SIZEM1
> field may have the most significant bit set, and then it will trip
> this assertion.
> 
> Loosen the assertion so that we only check that the data value will
> fit into the field in some way, either as a signed or as an unsigned
> value.  This means we will fail to detect some kinds of bug in the
> callers, but we won't spuriously assert for intentional use of the
> data field as unsigned.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: db432672dc50e ("tcg: Add generic vector expanders")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2601
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tcg/tcg-op-gvec.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And queued.


r~

