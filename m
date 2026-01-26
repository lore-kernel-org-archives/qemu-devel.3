Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4319AD1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQpP-00056c-0N; Mon, 26 Jan 2026 12:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vkQpL-00052p-Eg
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:56:39 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vkQpK-00033P-2n
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:56:39 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-5013c912f9fso54556971cf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1769450195; x=1770054995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RjsHIQwksePnk/jqY2y0u3F/kB3gkXA5UADHorzCmd0=;
 b=OUkEZQWROnsR04xrY8vCqhdJGIG3YjOPzmxxhZm94Z53jCexkwzP6ngghORIaTmbdP
 DH5TESdBNLksIME5vfgqyIzJyQHRqn2DnfWOCfJcj/s3jz8U8urNqrZ3wrQ/XqYnu+I4
 Dv4tM1azk8I1uxjR+NN3mzijG4XwNMskfGn+AVaf/kKFNVvxuTg2NULZO+eqaisQ2kfa
 E15jkcoRH5RTlzDD65xv8Gjsxufz/Ttn8nl9PSWUofQ9Fs5UmdYxoLnyw7tYM+ddUEqo
 hj/npst6r6RWgrJtuOCkjXidnaj83HfKf9niYyXjXoDYXo+8A4hrxnUQk8hwMvfVO+RS
 79xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450195; x=1770054995;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RjsHIQwksePnk/jqY2y0u3F/kB3gkXA5UADHorzCmd0=;
 b=dFyi4MWuonNren+J5TvjfFCzRnY3/fSOiz0GqnzwOgonNGXXTPYnUwdveo1cIRXbqo
 AudXEs/Hdd2sw1XeEWgCG2kAR8P0yTq6uUptpYagN1SoJddMk/y58RjjzpG1KkJn3XfW
 /U5fe8rw7nVTKDlvIgbdgqmHtdpCCjc9IVd/lFHPGckNDNe6NycHPRiy87hM91kgdL69
 LioHy9nNn4i39klVufMnGyhhJF8S3zWk0HPohFb+zPdzllv647zE+zWP61sOzub8NZnZ
 x8JLlZ9oWNGc1CSYgNc67fR51Veev1lzx0IqYxJrerm5XqoHPtK1BZANPTDqPtsLlLyG
 MqTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSanchcWdAU8PJkLzeRwiPbOeDGgmFxb18iajUvLssaR+ISjaITPv683tO6ifB86LvBEV8oLOT/YSV@nongnu.org
X-Gm-Message-State: AOJu0YzinK7Vimt6qwtg/c+iZA7gToR4Nl9O5wnSWM8zicpFa/F/Uxi9
 P/VkZsguvE8CcflbpbcZSVz03FY8kwGMjw1Q7YPiOTTSZanLN7z2ucsZZgEHmDAgWaw=
X-Gm-Gg: AZuq6aIOYBMtSod0GWCH4TOqDTRAEg0osNMGysEwjDQErT2pLZTfLd315K4+YrFvHvL
 0HNuSTo3LjwoMztIl02FG6U+gmu/2KDrDWOvZyriuBnbnPrZ74QMjBgj4xcZBqlAbzdtNETHD+h
 HCnO66unB9hnxDfhfCxKb24gUpQ4y+lJ9DQjwDR0z3B2i2bS8K0BC8qGZ1e2La56KX6CXlY68TB
 UQP+dYKqgWpczA4ZW0HWLSZl1b2ixNU0UrwIRZLns4Dj6O1aEMMYibYcD1LD7PEKoqxV50e3sLZ
 U+/5ifmnl9DyEUxnfpAnYF3Sym8D/KI6zgBqW3Srn3VSvUCXwH3dbM98S6S5ZllmXPHy9PkSRmE
 9ZqyQP7MEAzTx0KJTmbdtoLGEsRwORkXJK1HIZ9Yc9fELXAiBJbRRCvqK9CvYKVlESxqQnjivDL
 Yvd/G0zWCcrEOCPsdojXhETLY6bbgA5dDxh5ET+NU=
X-Received: by 2002:ac8:5d45:0:b0:4ed:bad6:9fa9 with SMTP id
 d75a77b69052e-50314b92f2amr75779101cf.6.1769450195129; 
 Mon, 26 Jan 2026 09:56:35 -0800 (PST)
Received: from [192.168.68.103] ([152.234.122.35])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502f7ee4b76sm90481511cf.15.2026.01.26.09.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 09:56:34 -0800 (PST)
Message-ID: <81d962d8-52fb-4203-a3fc-f3980b8a93bb@ventanamicro.com>
Date: Mon, 26 Jan 2026 14:56:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix vs*r.v missing SIGILL check
To: =?UTF-8?Q?S=C3=A9bastien_Michelland?= <sebastien.michelland@inria.fr>,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Jean-Michel Gorius <jean-michel.gorius@irisa.fr>
References: <20260126172246.2521444-1-sebastien.michelland@inria.fr>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260126172246.2521444-1-sebastien.michelland@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x830.google.com
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



On 1/26/2026 2:21 PM, Sébastien Michelland wrote:
> GEN_LDST_WHOLE_TRANS checks for require_rvv but it's always true, even with
> e.g. -cpu=rv32,v=false. 


hmmm that really shouldn't happen hehe I wonder if there's more bugs 
lurking in the shadows somewhere (spoiler: always) ...


> Instead the illegal signal for all vector instructions
> (except vset{i}vl{i}) is generated by vext_check_isa_ill, which checks the
> context-dependent DisasContext->vill that conditionally makes vector
> instructions illegal depending on the state of vl.
> 
> Currently, vs*r.v runs even when RVV is disabled or when vl has not been set.
> Adding the missing vext_check_isa_ill brings it in line with all other vector
> instructions, raising SIGILL in these situations.
> 
> Signed-off-by: Sébastien Michelland <sebastien.michelland@inria.fr>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


> v[zs]ext_vf[248] is also suspiciously missing the check, but doesn't fail in
> such an obvious manner. If it's also a bug then it might be worth fixing at
> the same time.
> 
>   target/riscv/insn_trans/trans_rvv.c.inc | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 4df9a40b44..1e99c35988 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1235,6 +1235,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>   static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                   \
>   {                                                                           \
>       if (require_rvv(s) &&                                                   \
> +        vext_check_isa_ill(s) &&                                            \
>           QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                   \
>           return ldst_whole_trans(a->rd, a->rs1, ARG_NF, ctzl(sizeof(ETYPE)), \
>                                   gen_helper_##NAME, s, IS_LOAD);             \


