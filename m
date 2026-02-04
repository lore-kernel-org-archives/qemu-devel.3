Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23FCE9D411
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 16:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnfr2-0002Od-Dv; Wed, 04 Feb 2026 11:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnfr0-0002Nr-Hw
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:35:46 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnfqy-0007un-VK
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 11:35:46 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2b8397e3e09so977795eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 08:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770222943; x=1770827743; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wIacxnSS66bqTqI9bN8dDDhNgB7zWkOGIzaGFsyU7Xc=;
 b=FYi7f3/ism4AX87vI/I1mz1yk+e3VrO81JfpLy+BVJFth1I9ZPj9ujh/LopvLA47RJ
 co/KdzcVgOfESM7JyVf0ZtUNt7lcqSRQsQaED6bPWbtOSqs/2EuX4p6YNFyjvfiOZZi9
 E8YigC2LFOeqOstDo0I5CkFmKw32xNASl5jH9jIjA0N0SH/K/Ax8sA3KMhPmG6ZiDyBB
 NUkNpmOMhDnA0f5cPoZTYyXT4gv/dEDIggoLOhmkzLK0J30lK1uo+fsKSajldYyQRzT0
 yRfGCdvrLPIiG/kecXi+Ot7+4ulq7sUIKfvdh0D6u9TmBrTCeckFoNZKSVmxKD6tnjQo
 cycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770222943; x=1770827743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIacxnSS66bqTqI9bN8dDDhNgB7zWkOGIzaGFsyU7Xc=;
 b=Vo5o+uDME74uYus0V8MyhNE/ROg5HYTDkygT2vA+jS3SofFMPIEGPj/wJWLCM5RwOG
 i1cmTR+Mtjea80bRFEVj3EJiqDII6844kVI3geozfpELecYjCg3C9yEjqlOyfYZeNqHT
 mt4M4/ik2M7y172WPRRL0Aq6L8psR23KEXVmaa9jXTUoXNaS4ms0lMYXvXGG+edewCVH
 8HU/I0nvZXueoL2Ewc2ZjPVJCMBC3Ej8HF1j1WvskdRk+cxmWcp5slrc0KnWv6P9xpGq
 fOzA0hJ4rzGPVaQlpFlNIOnCPyl3kzCMx6hnuk7V9XvIiUwQdSmzFGJ21b6S5Av1Ypdr
 b1dw==
X-Gm-Message-State: AOJu0YyAdESbWaGxfA1UCXoyYqrABmwdNnQhsdccU+LDr7PY7Ikb5MAg
 SSgWho9XRK9E+mCeDyJmHycSpWAw68pLSxI7a0/neI72ZtMvh8H2GwMn
X-Gm-Gg: AZuq6aIt+L1QKXK2sDPLiCfVhb6yBMWjDmtcbWwYO6+P1wrx/x1wCCWTxE/8uEVqKUt
 2rnTV5WmOgX6zBY9fzbAFEO7u78MAWChAXzw5yfmSQDgCrq7gGql5m95rJKyfRWZfnQsSmvbByn
 d1/GRKdnaNhd3DEpEHvBoCbIstWGm/06P+jMGEz2zHFG+1eoQje78elKLNIAcQ+csnyukkrrgCy
 gyFvfNAjZTW929aq3bgBKjUxLE6GATRqlxe7Vb4ngp9crrmt8TWD60LM/m9hmLInxFvwdVdOZ/Q
 xgPQfwuPuQUjeAav/IEU0kEL4lQTiDTUVExgs0FRWU2jtyBWyJou8XMKysYnXAB1uQLIOL//xGQ
 TGN1x9CnEtff5o86cVQS31CRp7JLskQJ0gVGrPp1zUWIQPObGoX+qYAVcq/OCpjAoYJSEcQeet/
 By64tH8gwQ72D/oU3AYdQ3Phi1EPN7cDqeY1ez2RJ0YE0GJ6gtyz2Subhh/Hb2ezqgkNcH1fK2H
 Ffz20JbuTp4tMfH7iM=
X-Received: by 2002:a05:7301:9f11:b0:2b8:31e5:930 with SMTP id
 5a478bee46e88-2b832a201b0mr1260008eec.30.1770222943147; 
 Wed, 04 Feb 2026 08:35:43 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832e4cd26sm1802823eec.12.2026.02.04.08.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 08:35:42 -0800 (PST)
Date: Thu, 5 Feb 2026 00:35:29 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 14/19] disas/riscv: Add support of Zvfofp8min extension
Message-ID: <aYN1EwQBUzo89s81@ZEVORN-PC.localdomain>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-15-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204051756.667397-15-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Feb 04, 2026 at 01:17:50PM +0800, Max Chou wrote:
> This patch adds support to disassemble Zvfofp8min instructions.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  disas/riscv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 85cd2a9c2a..daffe9917f 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -984,6 +984,9 @@ typedef enum {
>      rv_op_ssamoswap_d = 953,
>      rv_op_c_sspush = 954,
>      rv_op_c_sspopchk = 955,
> +    rv_op_vfncvtbf16_sat_f_f_w = 956,
> +    rv_op_vfncvt_f_f_q = 957,
> +    rv_op_vfncvt_sat_f_f_q = 958,
>  } rv_op;
>  
>  /* register names */
> @@ -2254,6 +2257,9 @@ const rv_opcode_data rvi_opcode_data[] = {
>        rv_op_sspush, 0 },
>      { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
>        rv_op_sspopchk, 0 },
> +    { "vfncvtbf16.sat.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
> +    { "vfncvt.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
> +    { "vfncvt.sat.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
>  };
>  
>  /* CSR names */
> @@ -3630,7 +3636,10 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                      case 21: op = rv_op_vfncvt_rod_f_f_w; break;
>                      case 22: op = rv_op_vfncvt_rtz_xu_f_w; break;
>                      case 23: op = rv_op_vfncvt_rtz_x_f_w; break;
> +                    case 25: op = rv_op_vfncvt_f_f_q; break;
> +                    case 27: op = rv_op_vfncvt_sat_f_f_q; break;
>                      case 29: op = rv_op_vfncvtbf16_f_f_w; break;
> +                    case 31: op = rv_op_vfncvtbf16_sat_f_f_w; break;
checkpatch reports:
ERROR: trailing statements should be on next line

The QEMU coding style requires that the statement after 'case' should be
on a new line. Please reformat as:

    case 25:
        op = rv_op_vfncvt_f_f_q;
        break;
    case 27:
        op = rv_op_vfncvt_sat_f_f_q;
        break;
    case 31:
        op = rv_op_vfncvtbf16_sat_f_f_w;
        break;

Thanks,
Chao

>                      }
>                      break;
>                  case 19:
> -- 
> 2.52.0
> 
> 

