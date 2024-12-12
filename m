Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD08E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLilv-0003br-3E; Thu, 12 Dec 2024 07:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLils-0003bK-D4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:58:24 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLilq-0002xz-Pe
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:58:24 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3eb5a870158so210691b6e.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 04:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734008301; x=1734613101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GvafGMHiHQHVMRGWjMWxtW9pruMjmgMfe54t/INFS/M=;
 b=HrQIw0XDXpwSN0yPC43+rVvrBxQ/+S3ZeGLGu0AYf+4q3ySf8TICWCLekte/WnOi/w
 ni4lcA6ttf9qHU6ETL01ws3TnkMdlzdjq9kPxsGAxYolX+RYKykepoOBSVAJJ9mQvWr8
 ADddcpYDQ+z3ycpKg48q+XAMfZzESKkfk5uEevadps8uPqZHDzZSE2BTNYA0B+e3VMov
 aWDvO6wV7UYdybXa7YIDIiBzJn93yBcpnebDnTE+UhbHeqU92aDuZLTIn38W42SfipZL
 xlvdHXSVGLpJ2XiANDY/FZSD8bvKtqzCMP8u2rdael1IUdLB1iKgh1swvzOpm888H3Yv
 gl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734008301; x=1734613101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GvafGMHiHQHVMRGWjMWxtW9pruMjmgMfe54t/INFS/M=;
 b=lJ5/R1/t6P+iaDc6r3SCqBWnRbtlqlA9ZKpMG+wlwqEV1WV3p+p9EyudH1MIn/OHHm
 FbFXW4i4nhdPHhMm9ydCNT43qb5Jz7lp1y34yclSccyg0x4h7mX0peF2UjrZ/vOtjJxR
 CiDqx9wksJ4s2278NNZRZjMYUYAkjarMCKtt9c7MMLgl4wQFX72d4sElwTC6NeJvXKNv
 efAjkexWU98XV0k+xNNUKbBEo6pOPoP/ElRJig2hd4RBRt4K8FV8hdGtinpXvj4jCHNZ
 27G2ftOkOcG7wfAL3Znn84xsVlLb7/1u8vDOdUQSSNxw5g/W6hTAx8W5E9DPqdHeWBZH
 6Okg==
X-Gm-Message-State: AOJu0YzH7CjOTpSBNpG5NC4KwEK8aekgCRzWj9foZoIdIuxUSJzjLosN
 YWllQ4859arw5v1OiJPuy4PiNrSpfrh3DJPmp3y2v/G9/CS5bRRI6fHSvTWjsT8=
X-Gm-Gg: ASbGncvwe6gY9d2DLURecoUwC826h22B53ZKheTjp7KSDYaRBoLsEOyjlZUN9M6ZQRA
 VxlJABcz981XzqD4UsVmcbdb8h5CqKVNg/ClHQD1Jgg7AhjnG0u/Tm4Ir2sQT+u+X9Tcb7uP3F5
 GZrTKiE6ZM8l7B8SfMZEGNdpeeQWV63o2s4zW5Ui6dg3sv20z7evCzHLr4AXfUYSlKoUlwwDvl+
 kChy+rwr0U2lvF1f0GtUhS8GyHgnRrkeXdJniJpmC/1GxsAhfO9ZGuGVPo/8F9eKAytZqcEvx25
 5wNTpIIbSoaKlpQMuL7qNdTV64OGgSY9m4E=
X-Google-Smtp-Source: AGHT+IFtSjCRlxWNJzOlS6bg2toewPn0WJzh4Z2OH5a0P/JvCleHA5ueb37V1ZxGPq/bOYj/th7dkA==
X-Received: by 2002:a05:6808:13d4:b0:3ea:5809:2835 with SMTP id
 5614622812f47-3eb9403ffa6mr1435146b6e.21.1734008301179; 
 Thu, 12 Dec 2024 04:58:21 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb9533b2e1sm406816b6e.5.2024.12.12.04.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 04:58:20 -0800 (PST)
Message-ID: <b149d4e7-6e75-4363-b743-6238cabfd6f2@linaro.org>
Date: Thu, 12 Dec 2024 06:58:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Use actual operand size with vbsrl check
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20241212082234.1572133-1-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212082234.1572133-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 12/12/24 02:22, Bibo Mao wrote:
> Hardcoded 32 bytes is used for vbsrl emulation check, there is
> problem when options lsx=on,lasx=off is used for vbsrl.v instruction
> in TCG mode. It injects LASX exception rather LSX exception.
> 
> Here actual operand size is used.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index 92b1d22e28..ba5ca98a33 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -5126,7 +5126,7 @@ static bool do_vbsrl_v(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz)
>   {
>       int i, ofs;
>   
> -    if (!check_vec(ctx, 32)) {
> +    if (!check_vec(ctx, oprsz)) {
>           return true;
>       }
>   
> 
> base-commit: 1cf9bc6eba7506ab6d9de635f224259225f63466

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

