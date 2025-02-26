Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9D1C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnBub-0008As-LN; Wed, 26 Feb 2025 02:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBuZ-0008AZ-6s
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:32:55 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnBuW-000306-S4
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:32:54 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3652143f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740555168; x=1741159968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=69g3bhTcyxlMe0VBrLeXRFtWrzHFbizmOxW4bTKexuY=;
 b=mcV3CXTTq561bfb0hYNPzZWlQRJDapB9cPvbdtT+3OWBZ1bibxPUdr4lcBPYPPfPhO
 O8L6rSgXNkLI02A8rznxKfSmnBSL18tRtCxB2UWjXHb2UeSlRE5VoCwwuIWv8abu3Xrr
 cEbsAG898a2rxp7HmtSc8yavFcNZS37KTbBBHX3ys4XPiY5HBHdGDTQWg38vYj3Uk/BX
 Y1rP+GspsYQ/OWRbnGI1Mtiaiopg7jhjMEtGd6y5Amfe92+9HDNY1u0W9qsBk9+Y4n+q
 iJJJMHwSgZ3Oj/ddxFHOixWAjqrR1BWZIeRlCqhWb6b9MN7VbywBENKwTPUpuw8vmjah
 V6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740555168; x=1741159968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=69g3bhTcyxlMe0VBrLeXRFtWrzHFbizmOxW4bTKexuY=;
 b=aoRjhzhrbtgu3c6Vp8QTgY6MPw19A1TadQRUH6takTofNCojgfBG1Mp49nTV6M2SJD
 S383FzhB9NBUSAz5rThXBKwU0MMXT4TMpJFQM0wrRINuB/BSN+an4AO3cVsKtu7qH1Wx
 9uAFWGsEyYVkIzqrVXtUYoNUbME+cMWdmlCvNGmlCa5VDn4gYTEJnEtscthe4BVC7vFe
 R3ZfWw8kxBu2QODTJqtRWvYXTZWa8K9ylxNjSpvt1zSvAx86waeDUH+yRHM9whmX3N+1
 bafRLa+ALkYSutANOyZWwClcj+sMOrS/3HWT+84qBrysvry/qmBlX/NQhFdv21fhcn4X
 Olaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLIeYYkqPZlJsS8xbMK2KEZ8Yk5Mt4kzzbb1imdWqOrZu3GVzlJQVTg75WBWfMPnhyGLBv1EiNT5CR@nongnu.org
X-Gm-Message-State: AOJu0YxMQK2ADWb8a72sRvA4O/zJIBXElbxZSHyGkcbqjsgAtxzSdkF3
 e8wNft8O77oNxOI0Msx3DBjZ6qIgu/K0idfKOxNsmkC7uFlUTjiNOhbURRflWXdyS7pGOP1GESi
 llyM=
X-Gm-Gg: ASbGncvf9SyV4/1JvEz3+7T1HyUhdXRet7b4xSrQmptHMMTSHkCSw8GudD2KYso8f1K
 677fGNIOr3qweQJI2TdbHSFwrhFaadsm+Hx1Y2IFR5M/ca+YgposKNUHmdOlWbqQTfW2NkEj6sw
 Z+U1iZekfh0PaT6sLEsENbk9qdPryGCzL3a/0dyvgsoas60A6l6PqOG4itliWndnwGFRELhGW+V
 IrJdxuLJIj9kEnvMMbgtJIJcm1s8txs48P3AJiA8QkeBsEa0Wa2fWVsV1owuYa0vnjnaJG35jMd
 b/HYRyS1IAHBMqt8Wi2SLSdCBVFe8TbN/TnGRVf+4V+27RiWqFflZvsSBMv5luz0LmpqhpYLQVQ
 =
X-Google-Smtp-Source: AGHT+IE3l9DM8pxQpByiv2ExjdHZqZX29tTftAoJ7Csrpi3uBSui9eK0OIj3/jq0apV/Tsz5IP3eeQ==
X-Received: by 2002:a5d:5988:0:b0:38f:3b41:c944 with SMTP id
 ffacd0b85a97d-390d4f367d2mr1573232f8f.11.1740555168502; 
 Tue, 25 Feb 2025 23:32:48 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fc9b3sm4591664f8f.97.2025.02.25.23.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 23:32:48 -0800 (PST)
Message-ID: <71780b2d-444c-4d3e-b919-dd1ade058995@linaro.org>
Date: Wed, 26 Feb 2025 08:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 012/162] tcg: Convert or to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        |  4 +++
>   tcg/aarch64/tcg-target.c.inc     | 31 ++++++++++++---------
>   tcg/arm/tcg-target.c.inc         | 24 ++++++++++++----
>   tcg/i386/tcg-target.c.inc        | 25 +++++++++++++----
>   tcg/loongarch64/tcg-target.c.inc | 29 ++++++++++++--------
>   tcg/mips/tcg-target.c.inc        | 25 ++++++++++++-----
>   tcg/ppc/tcg-target.c.inc         | 29 ++++++++++++--------
>   tcg/riscv/tcg-target.c.inc       | 29 ++++++++++++--------
>   tcg/s390x/tcg-target.c.inc       | 47 +++++++++++++++++---------------
>   tcg/sparc64/tcg-target.c.inc     | 23 ++++++++++++----
>   tcg/tci/tcg-target.c.inc         | 14 ++++++++--
>   11 files changed, 186 insertions(+), 94 deletions(-)


> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc


> +static void tgen_ori(TCGContext *s, TCGType type,
> +                     TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tgen_arithi(s, ARITH_OR + rexw, a0, a2, 0);

s/0/false/

> +}


> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc


> +static const TCGOutOpBinary outop_or = {
> +    .base.static_constraint = C_O1_I2(r, r, rU),

So 32-bit gets s/i/U/ which is TCG_CT_CONST_U32, a no-op, OK.

> +    .out_rrr = tgen_or,
> +    .out_rri = tgen_ori,
> +};


> -    case INDEX_op_or_i32:
>       case INDEX_op_xor_i32:
>       case INDEX_op_orc_i32:
>       case INDEX_op_eqv_i32:
> @@ -4172,7 +4180,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   
>       case INDEX_op_sub_i32:
>           return C_O1_I2(r, rI, ri);
> -    case INDEX_op_or_i64:
>       case INDEX_op_xor_i64:
>           return C_O1_I2(r, r, rU);
>       case INDEX_op_sub_i64:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


