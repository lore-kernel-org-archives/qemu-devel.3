Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F051CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfKI-0007o7-SW; Wed, 20 May 2026 07:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfKE-0007lB-Qk
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:42:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfKD-0007Vo-2Z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:42:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so4394431f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779277375; x=1779882175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pqo1iOD1JwJl2fyVL1y12yIavWufYk61gFL3DQ6YapA=;
 b=zKgWLdpZ6/A6OxBDl18TjIbz1XZtq1okNXBkUHX8JrWfsHdaMwHq67V5DXVR0vwzGu
 qkVzeKqbiDYucV6t5Asf1rqw392gS+kYibz0i46JdEvxgLZJrIFzFv67LRv15LHuR+Gm
 DdORo6lUYWJutcxaTFD9rL89I5LeeFEs0Ser1x++NhDtOm5VxvpFVF9QTD/o6HcrQH+1
 1o5gBSkEUnd35iZvNOSvpu0/GyiSE9/0Y0c7JoQGiKfggNasftiCbEAwt2ZmXFTR4bod
 aYDoWplV2ENEDliq7R0BjS9GH2ycP9+AouDmhZcbFhQh4Xk99+i+VPLk4e4Z9bg2I78d
 dZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779277375; x=1779882175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pqo1iOD1JwJl2fyVL1y12yIavWufYk61gFL3DQ6YapA=;
 b=atqvXmBJD2hsQmsYGQSNqYjwQiXgpd8KtAvhf5AlNFlWHXmEwxzdc9ObldT6pkqI66
 VuesRjw1PSTKZswPl4+HC76bQerG/5v9UlAls6Z862Xpwud9UQbHuSQQYQJSol/eDGLB
 zXPqTRDvUyPCqaueonmM/DSXu6cdSZ4n1vrPaIdbT4USbrQhtxQ/qri9t7AXxsM7EcGh
 In7PYA9ps5VSuXiEEuUcLOrHtp7Ob4nLOCmrWGoBbY8VPau0V/fSDuL8YMGOxYPo0cfT
 xx0amxYNR+kUFH0kPwKUu8sliCclBh6dy6O7ZzB4FSLpH+bPM7ty32MTaxcnfCD9a7eb
 foWQ==
X-Gm-Message-State: AOJu0YyK8TFXIcJd5EkS75l3gcBGLSSejXfZufDRyqQYpAr+JygWx1qS
 qnRevMcZFjxblNjVn0SOPaYzPB7QjHS6o3y3OmE9bHlNZVpNKodqkPSV0aE2uV8SQKZ3IcLGCcT
 iSMOxxFc=
X-Gm-Gg: Acq92OFWdUb/dNmtsiiMFx3GFu+1NL/BIeeUPUXLz455x8ScX7WPigVp1c4r25824Yp
 CIsU8OIDKezRe3/srX66SG9sURGYzpQ0bonUFKSrM/gIdGMyf/lfxoyUrDOc3/wL7NQ6Tss2V0H
 qDgIVvh9bUhKeAQ57zWZImtvtCEtjdx/3ZHg82mT5zkmVvifZyk1fGZy+AlcQdi4W9xhPbaSFuZ
 VQCABLFFwcmhj4pza6U/anViEs2SEws6D3nPfYnJYn3Xv4OISzVuZFKKabGWGtdXpjGzpinfvGI
 8reUAmFsmClMMgPaN25BTuF/7U1dgvB3zTDiwITy0ngrjvmSNhwezCntIK5u5jXza4Lp4twGHpi
 bXjTOo2gXppn61hsRjvGF7ofoGsTSHUw0ynXmgYVHNRGZL9xIGCjSTdLrOOM0D7QZytBQLk9zyx
 49JEuGviGIOSXmVQknck2vRfRnodoU+RWcl+nfdHg4/piEfGxLni6hP/RxrWJjOgROHBskyC4=
X-Received: by 2002:a05:600c:c116:b0:48f:e230:2a22 with SMTP id
 5b1f17b1804b1-48fe6632e84mr297505415e9.33.1779273693279; 
 Wed, 20 May 2026 03:41:33 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1a22csm52374163f8f.19.2026.05.20.03.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:41:32 -0700 (PDT)
Message-ID: <2a725a41-4ea2-4336-afb2-13251f975670@linaro.org>
Date: Wed, 20 May 2026 12:41:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 19/24] target/mips: add Octeon MTP instructions
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-20-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 20/5/26 12:18, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> Add the MTP0, MTP1, and MTP2 forms. MTP0 loads the low Octeon3
> partial-product pair from rs/rt into P[0]/P[3], MTP1 loads the middle
> pair into P[1]/P[4], and MTP2 loads the high pair into P[2]/P[5].
> For MTP0, also set P[1] to zero for backward compatibility with
> Octeon2 VMULU.
> 
> Legacy single-source encodings have rt encoded as $zero, so the same
> translator path also preserves the older Octeon behavior.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      |  4 ++++
>   target/mips/tcg/octeon_translate.c | 23 +++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index 5139543b153..bb0a9f1d99a 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -51,6 +51,10 @@ MTM0         011100 ..... ..... 00000 00000 001000 @r2
>   MTM1         011100 ..... ..... 00000 00000 001100 @r2
>   MTM2         011100 ..... ..... 00000 00000 001101 @r2
>   
> +MTP0         011100 ..... ..... 00000 00000 001001 @r2
> +MTP1         011100 ..... ..... 00000 00000 001010 @r2
> +MTP2         011100 ..... ..... 00000 00000 001011 @r2
> +
>   &saa         base rt
>   @saa         ...... base:5 rt:5 ................ &saa
>   SAA          011100 ..... ..... 00000 00000 011000 @saa
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index aae6e9811c8..36d268e09c4 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -242,3 +242,26 @@ static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
>   TRANS(MTM0, trans_mtm, 0);
>   TRANS(MTM1, trans_mtm, 1);
>   TRANS(MTM2, trans_mtm, 2);
> +
> +static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
> +{
> +    /*
> +     * Octeon3 two-source MTP forms load lane index from rs and lane index + 3
> +     * from rt.  Legacy one-source forms encode rt as $zero.
> +     */
> +    gen_load_gpr(oct_p[index], a->rs);
> +    gen_load_gpr(oct_p[index + 3], a->rt);
> +
> +    /*
> +     * Octeon3 clears P1 with P0 so that VMULU sequences remain

I think you meant s/P0/$0/ here. Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +     * backward compatible with Octeon2.
> +     */
> +    if (index == 0) {
> +        tcg_gen_movi_i64(oct_p[1], 0);
> +    }
> +    return true;
> +}
> +
> +TRANS(MTP0, trans_mtp, 0);
> +TRANS(MTP1, trans_mtp, 1);
> +TRANS(MTP2, trans_mtp, 2);


