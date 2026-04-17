Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097A9F8E4B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDdmh-000335-15; Fri, 17 Apr 2026 03:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wDdmf-00032W-8Y
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 03:38:37 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wDdmd-0007nr-MH
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 03:38:36 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-59e4989dacdso466349e87.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 00:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776411512; cv=none;
 d=google.com; s=arc-20240605;
 b=jGifuNj5yKxXIg1a52NR6msYiUd2w5/AJdAbBoJ8YS2mjkRhaJRhigWtlQ4N2KEr9k
 TFs3cNKwPuoSm9Cs8k5+URZ+pfKxvIGDKAEUlQDNPYCFOY11Pb/+l0ZKnW3/rhoszbuR
 ngfFHiZYJnis2DxMcbyHnrAUlv3MpIgf+azJWuySpi/A9uOvFoBliliSPCEIROQEu9OS
 8aZ4y65QVOUb89TSnJ+5h24LoTOQgPCwJ0xVQFeO+ZlCdYazjsbiDaVXOn+voGmyWaw/
 Yz9zkkp2HUCml+yzZvBO8iZ+VD2iIshCAL9AKuwm7FLJht30PLN+Wwj/iNSn35afpys2
 v2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V6xlnEn08C4wfvYI5fJpA3q+veEZmj2Rzh8YsBU5mpk=;
 fh=TMU3u2v19a90UpGEord3Afaw1exf65QNyxo3pCq/nD8=;
 b=JTRVE4uLxOsR3a1lmyVNaiMW6jqA8fHQoxgvDAI+1x2AP/fYTQ52NW5wL2ycIs4izX
 T47/emMeElhwrCMPpEfpYCGgMxrU2n9rLqqXuXIyci3s4EBtDa57NaYeXfWpM2eKdxGB
 0IwSM7jjDuePOMfaTEmGwuxWPMH+e64GUTj1govsgHy6QXE9o48Sbt4URkrwZgatjjCu
 mPc9NRwV4fITDSqTOGKnNyPV3lka/KsUWxaGbbbrNCVV238UyfL0ExTrggiBhNh3gX43
 00+oMW2iGGjbBWCjIZBhRk3Mm1uNr8omLFj7YDXbTfYVwsaqb/i+jHGqxijnGhhF+esU
 Zs0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1776411512; x=1777016312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6xlnEn08C4wfvYI5fJpA3q+veEZmj2Rzh8YsBU5mpk=;
 b=IqGuguQbnrTqZVVJH5bnNVgq5F4swY7FhCsmmHqKb5nFjb8eTUxlwiygEoUt4jhf9Z
 1gpANg8hM+zw53BrxVUHXJOqdvoeLlamMdsspyCWw9VS1k9GE4j4OjyGM0Vn4ejY6egb
 TcBawHCbKIMFgYpzUfhx2h5AHt0KlfuUUS5E9qGqK0koxmwH2NmF5ymbbOEeEnR8W9P8
 jtQ3iurnwkBOAjjm54xfo3Cx4YgSjaUxwB30PF/jA+ORugXHu320OaRtnXf9myldrZuE
 5nniGgVxdhtWu8ZmDIWq+e69l0dBMlPTJhCBHRf1FUEsQK+fXpYSYnKPNzyShXAGdU2m
 bjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776411512; x=1777016312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V6xlnEn08C4wfvYI5fJpA3q+veEZmj2Rzh8YsBU5mpk=;
 b=rm3FCaep7TQjygiyI+XTWoFbXvYpMTcyeMbTvjLMNLKqQXO73hjSni9Qtd1u7r3ocF
 WVODceI8ceUDiSbrBEuLukUbe15dBNaLCOBsGdEBdMH3Hm9DScwHqSRVBJfTx9Q5qJQ2
 26gLgEAy++JWGoMupZtIoaYMZi/svCMaQGE7H1J84Y5zi9UTEaDKgPKpbKpyxcwudT9z
 so9+k/zBCwK6o4eJ2ADQIgZsjQF7LkgQFyI3qGOinae5vr7K/dtUVoSIBIvfIqviG+Yc
 XZWuxHt63zAly2dpJ+KtcWYVOd8jUrUqJBMWbLNdwBy+pe5nHSvTNwWPVq8NCF/Rt7OT
 3Ykw==
X-Gm-Message-State: AOJu0YxRW00Gy1HDF0mbDXxoFLnUB8w3+XmQUd2XcVWALY9m2hlMk4W/
 EHoU9zofROxoGLvl4EnoMrxSMtfNYxlIy8tWf740Cuy/+YCxycfMzpba7fOf/YUXT5NQ5IM2EMU
 JEOTpFgmf/YiGx0+MrdNjK/R1bjIdwIuSvG2HlljDmg==
X-Gm-Gg: AeBDies/HnzdF1UYyvUMsGNMqejfL6elBm6d7McSnLg9yveW4vQ59IsSmHeUhUQATZ1
 knSAFRiFA3CcWXmNU6Ji3ZJlH5on6yi37W8hL7YdKIAoqZNaX5jl0hoN6Z3C8nU5yZCEyS3cibX
 LIvxZCauY658XUJE5geFU6DeSGeDn5Klsy9Dss5ruSXTzUU8d7YGwgA7f5Y4NBNY9psSV3FJa6E
 PLY+8VZ3NV/wSI1kXgaKEcHpkNsFAzja4HcLMOjPyZF9UaTe1XR8Ftwi2YuLVDA+0M7IgO4dXKN
 OA5MXbVsBrVoiro/Fu4frHgwerIwqFnsj1KsbXGXNrZuG6I=
X-Received: by 2002:a05:6512:3d27:b0:5a2:b3dd:7a74 with SMTP id
 2adb3069b0e04-5a4172e7af6mr540759e87.33.1776411512472; Fri, 17 Apr 2026
 00:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251113171604.3034161-1-max.chou@sifive.com>
 <20251113171604.3034161-3-max.chou@sifive.com>
In-Reply-To: <20251113171604.3034161-3-max.chou@sifive.com>
From: Anton Blanchard <antonb@tenstorrent.com>
Date: Fri, 17 Apr 2026 17:38:20 +1000
X-Gm-Features: AQROBzD55Vb_lVD7rfZ-GjO2BYroZwJT7jqzvXiGuNjCfbHPz5jrjBdB8RDQ3E0
Message-ID: <CAN7m+mDhEOzyvzf+VSFR_m2hYSQE3reTwYvhE=kPQ6v4YNraUA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] target/riscv: rvv: Apply vext_check_input_eew to
 vector reduction instructions
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=antonb@tenstorrent.com; helo=mail-lf1-x132.google.com
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

On Fri, Nov 14, 2025 at 4:16=E2=80=AFAM Max Chou <max.chou@sifive.com> wrot=
e:
>
> From: Anton Blanchard <antonb@tenstorrent.com>
>
> Handle the overlap of source registers with different EEWs for vector
> reduction instructions.

This patch has an issue - vs1 and vd are read/written as scalars so the
normal overlap checks in vext_check_input_eew are wrong. This hasn't been
applied upstream yet so I'll send a new patch shortly.

Anton

> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 422e1a21185..2d9cf27ef76 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3076,6 +3076,7 @@ static bool reduction_check(DisasContext *s, arg_rm=
rr *a)
>  {
>      return require_rvv(s) &&
>             vext_check_isa_ill(s) &&
> +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm=
) &&
>             vext_check_reduction(s, a->rs2);
>  }
>
> @@ -3092,7 +3093,8 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
>  static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
>  {
>      return reduction_check(s, a) && (s->sew < MO_64) &&
> -           ((s->sew + 1) <=3D (s->cfg_ptr->elen >> 4));
> +           ((s->sew + 1) <=3D (s->cfg_ptr->elen >> 4)) &&
> +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew + 1, a=
->vm);
>  }
>
>  GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_widen_check)
> --
> 2.43.0
>

