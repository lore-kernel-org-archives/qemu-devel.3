Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F060FCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN20d-0005pU-57; Wed, 13 May 2026 01:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wN20b-0005oE-4q
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:19:49 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wN20Z-0005YQ-EO
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:19:48 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b936331786dso799483966b.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778649586; cv=none;
 d=google.com; s=arc-20240605;
 b=e5NhslYBIBwZ1e/9T/9jzJfA6fV2TSczqvbNewg+pk7bgejueeECWGL37nW2evg77Q
 c5SCg31c6np902Yg02zlIlVF2FI8mduyK3wTkbEibUq5mt9y5Y+3PISpSIzfpQf/1xFx
 TWFT1Hg30StuJKdLqVNLssm6W4pmvYrYJ4e6dwIw1bihMODGTUFpg71a6QVuxP1odeRA
 PcnM1KYpgpsdj5Y7rKipHzvgNrxYFl5x+BcVeMP25ZzW9N4dwFQvZrCJ+VDWsdnfLHGq
 VOnWso3mPd0xGTZoK0UAskK4/C4gYZgU0/wVzM8c02zmTKE+JH36UiCe90xrxv5LLwfy
 H0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NQGORLbFNyzAhp6Hb8oF9+O1JXJ9W03RDFg8nf+J0hE=;
 fh=CcR3C6UciAMzQsjP9eJH1hXnPzcf1tfpxRCDf0g8+j8=;
 b=OmRRFq6dKERNoavRATx8SQg6RlW37isJ+C4ZGPGxp+icSHyU3ackBCQFJBZ0GIv/rE
 ftuyrQVoNIVIq7Rm9AZNDrVmJ+kwau9yTJD2YZWOq6c6WQR/jX7+WyTLe7wpvL3VENjJ
 QnzcFIFMAxNuD2I1Hb23D0keto0fpeIqdzY2keDzJQRvAMOjNtFRjE8+hJeaLuqyyDQg
 lSkyhCH0K830j0f8L1w0kfLAFVexrZYxEbVn3VWyweLjPPxaLpcF0AFvM+XBRO999+yp
 oVILLbxmSkLY4G6ySA2ZPnLSZGdlaJs/vvw9GekPxeIbBQvh7h/o/jMxMTeRtd6p9I26
 CMvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778649586; x=1779254386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQGORLbFNyzAhp6Hb8oF9+O1JXJ9W03RDFg8nf+J0hE=;
 b=IAfkmtNQs/EbR/W05UAKZC5we8iSK6Ax02Vjipl3heO4/EVMc6CFDqYlmvT3rCEPLO
 wt9oHw+L/lPcCzZWrzy6r3IxXOf7JEyxMkFSFIlAmp3IkV62xVxmNau++TZWZYpBso8E
 RQ0eejsN+NB5avi3kGWDEM22kWnV6dRlnaV9MS7fPQplxl5+VV51Sd9fm1fu1Ez7gcHR
 hX6XS34qRyO0mt5JUaGdeh7CGhWPfG0uezFQ0/aoaUOLJddOdNI33meT0fcO5rXQGgWJ
 XtCfLdoB4J5uYu/W0APvpXODmV0qucGJp5zMyi6l0hgIcrOsd05rBUi4J+WocDSqy2iR
 IYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778649586; x=1779254386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NQGORLbFNyzAhp6Hb8oF9+O1JXJ9W03RDFg8nf+J0hE=;
 b=G8+yexQhqKB3SghCxSKRG5oxoTD4kBfDi9zSyvTRVZsc79anA3faraOf3rHFewxP0j
 3KVguwgSSFA/qjENbZVTitaGmh5iBpnl3niOb4ortq9s+gcnWYmtPJFCZ0NT486n1pTq
 VDoEA7WIAsevtbbPNUWBJaX5qWVs4giLZWx+toCzUsBYoy2Bz+jNIclY1MaRDkdNu+b0
 uxViFMuEV4ajEMH6BYyS9a939j3GKt1goOs/Os3CnVS14FuvYzr88DAf6wkevdLEj/hR
 Rc+3P+9tiW425HeTGuRq1qwD308+Uiw9q2+4QcgaXleE1RUEbWDD6shZyeL2Zxdzszfv
 rgcg==
X-Gm-Message-State: AOJu0YzrNBv7y6yVYhWmv+eTQz5uX/dyN4nmHDt1CCoI/X6mgg0jqiYD
 6tanT2f/Gt43vz1Ogl2MMA8m5LXcW1XFOj9Zdn+oZnFR/qclpPq/WGrrBKVGuvftMXihf9Am1ap
 evHUH5xurWngzt1GNnaDpys2fc+2xtQc=
X-Gm-Gg: Acq92OGaQj7cp+T1T898swh0JFH++vFH8i4tkI36JcYIjYTSextQFdVWUng6AJKI5Xg
 Bx8rhNUmUE2EQEcHR8hrhZv7SxvrVWWLsqcM4KPdg7kEL8fDv8i9EwGoRELnxWQx2OdJBHJdaO+
 XwmAG9yQZ1GfVlGDIbB+b76QhtgNMGrTw8J7nGiHaN2cFfX7k8eLNpce3Yg5GAWaZi5g6Bncm65
 LipChitAvUDoxYP0aJ2akPy8F4Er8Ms0Y0LOtv62S1g71yjuziwcrUvGSNhR34Hdt53/YDkdMKa
 guSPOvO6iJHqtMFDL0E7qgIz+FvFrCo3DjvuOxmvjBIGTIGy
X-Received: by 2002:a17:906:d54f:b0:bd2:124c:c5d0 with SMTP id
 a640c23a62f3a-bd3c1836837mr98248066b.42.1778649585420; Tue, 12 May 2026
 22:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260417080328.31918-1-antonb@tenstorrent.com>
In-Reply-To: <20260417080328.31918-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 15:19:18 +1000
X-Gm-Features: AVHnY4IY-g_wQsZVE3wc8JGUzy3Bk4ExnOvtUuaovaHeU5yk70YLZw1e3PagU1U
Message-ID: <CAKmqyKOdQpK04bTxQ96_xiUiCCisbdX5P69DHuMpbj5uYsEdwA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Handle source overlap of vector
 widening reduction instructions
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 liujingqi@lanxincomputing.com, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Apr 17, 2026 at 6:06=E2=80=AFPM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> Widening reductions read vs2 as a vector of SEW elements and vs1[0] as a
> scalar of 2*SEW. The ISA does not allow the same vector register to be re=
ad
> with different EEWs, so they must not overlap.
>
> vs1 is read as a scalar from element 0, so it is treated as a single vect=
or
> register (independent of LMUL) when checking overlap.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.c.inc | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 4df9a40b44..d9a0027e0b 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3062,6 +3062,7 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
>  static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
>  {
>      return reduction_check(s, a) && (s->sew < MO_64) &&
> +           !is_overlapped(a->rs1, 1, a->rs2, 1 << MAX(s->lmul, 0)) &&
>             ((s->sew + 1) <=3D (s->cfg_ptr->elen >> 4));
>  }
>
> --
> 2.34.1
>
>

