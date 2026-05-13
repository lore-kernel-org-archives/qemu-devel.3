Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60896CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN1vt-00041d-Vu; Wed, 13 May 2026 01:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wN1vh-0003zN-Sx
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:14:48 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wN1ve-0002vC-44
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:14:45 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so235163766b.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778649280; cv=none;
 d=google.com; s=arc-20240605;
 b=kHPEXyOAJlpRtAcdTK+TAE3MXMVUtxbn5nJBDONJlbXFGhGqwKdZ92RdiIUKE5yr9w
 1hhJs8x6r8F0sNp3+mgWjenFEtkXeSGDAEPPFyOnJuyD712t48/l2M4OcwNRTysor2iT
 kiH3YxyCHFYPkeXPJSehRbrSbuEtwjS1cN8oKGOwaRKEW/3r0zMuBd47Q7n9jVGF+5os
 SSwAucA4KhvzoNORNBigBxDjZoCsEMvFFhfTdOoknHJFasCfdqha/o0a9zZ29ti2x2Nn
 MvXNoXhNmP5MPFtNAXslW2IllQKFwhfrtJSaVRN43LtkSaUajz42S2VfPv5bt1gQU9P8
 0Ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5CF9uGkBl38oIdYHDG2lcNPSJxYAZNVKCCFrmO5Od3M=;
 fh=CcR3C6UciAMzQsjP9eJH1hXnPzcf1tfpxRCDf0g8+j8=;
 b=URbLbs4BSiMHYaHH4XgE5XwUGdSKanFMlQegvCw3x4h0Z3khsRLlrhxapp3sNbuE4u
 kmuBKdLO3uUnKkrNxMdiCO/pMQL65MjREBOPmefuUsatR2qD2IzCnhbi/wnyz6NBvtAn
 U198kuBtLg0ip0L5vBnSm81J7tVTTs2e7tPg7/MwHul6sMmcTqGD+X8a9G9fXP57VByo
 nsSvVRoUpS0fnaXOUfA7ESp2t55OfvlsG8ATLW5Ac5HTFQEfowwxpnhshcFwEbOVkacO
 KK/lMJwAa8f07e6aj+dqYg2XScc7H8F1I0gxXJTxTABAQRjS1Vc2PhIyy9zsY0TTkGEF
 161g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778649280; x=1779254080; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CF9uGkBl38oIdYHDG2lcNPSJxYAZNVKCCFrmO5Od3M=;
 b=pAE/7Jq9GROwQM9Jl/CJ04/6qQyqS1vXyj+CtS3hPZZiTDKiQqKDSWyZJcHoFmq4Hs
 Y9Rf5bv46KBm33K0/SMlV/Bct998ezBDsp3iA9BtE6kTKNlP+MeODN10qy5cOzsaihsR
 z3xsDutPFfWnnRobq0ryQOAdURY9rKtwXswNxP52D19H2mGuCzCSHNjp1iNQ3dwSJ0d/
 lVS6XcMYH3geONmRvHcCIXU7Qk4E9abZufZ2quW1RkG1aCr7dENmRyuxSaD0QWI1KScR
 lpJoCbquoro0iX50qg0uum4tEZFLTon1QeKf48sjq0B0UI9D5dmCvsLPhNi2QcZg+DRq
 E/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778649280; x=1779254080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5CF9uGkBl38oIdYHDG2lcNPSJxYAZNVKCCFrmO5Od3M=;
 b=AI/DVj0TagHO1JX1dgU3F5d94ftvIa0a9vba0xlcwTsyqs+lTqdlC2xIkP3dhVDAKk
 xRro/zXHEve91Pi1bLiAQl0izH4DcQCpMnq/cziWRE/ROk0YSzICRvl9POKx/NAZ4J5j
 ZNYQq+VqEs9xbzW/7q1OaJOdS2uF3KsTBB9h5rfyfyLxgvc4J1DWEdTK7GgiwifZtrA7
 Dia5kMdg5q8YTKKumF37tvd93S4GuU0r6xMlBlMXjVSU8Kwsyl+bETL87WoTPD4nqvBW
 iqvCVexbojRAQ7+FDSlxsy8PJnDOU31/JyhXF4ROfj7tutT2dVp9EndWPIdSgLUnuePj
 Vg9g==
X-Gm-Message-State: AOJu0YylpP522qXbqdjDfjs9LeucX3jQcM/ntj4vMpdoq0zQH3Y5o08r
 lAWznvUvk93/hIEd8bTwMFF4/xmnZWRtDnWzW7nzqM9j7pLtrzSLBIIQDb2pyFtBI8nWW6XAbPR
 tpTj3ZBis85NCTZjRedKmxGw2euaOeMc=
X-Gm-Gg: Acq92OG102FYJzczdeSqgx36lacvBg/Nj/sQ6hmsHris1d3r73TvL6+65LxQhjPOD2f
 mwu9R3q5d+oFfJ6Km8EUrPtD1YycTX37KpcvjzMzlGTNIuyEXUWpEuu4kOV3lUQErAXEIZdSz3g
 yHZWbjIKHKvCYWnbXmBTbhLP4S7/B5bOGBu5XdVOcFBwd/jZnHFx9IbCeG7N1nB4bmcf0TclhBP
 XbC62EU0lwhNFq0zNQ/4cb5JZY5tlNHYdhGj0flnqiTMsW1DHpM/lfY9jeaG+XlDByhknOQI0az
 3hPyySz0RXS23j3jYGvrrphgBJmZjYYOyWA71Q==
X-Received: by 2002:a17:907:86a2:b0:bc5:10ad:4a52 with SMTP id
 a640c23a62f3a-bd3c11f77d0mr99881366b.26.1778649280090; Tue, 12 May 2026
 22:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260417080328.31918-1-antonb@tenstorrent.com>
In-Reply-To: <20260417080328.31918-1-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 15:14:13 +1000
X-Gm-Features: AVHnY4KvWzyyBpF5oXX3iitAcjpIg5l6Y4znnGjhtnUmqkBgaTVj4nSDESHabpU
Message-ID: <CAKmqyKMOd=hu+0u=QiqrOk2YfJM+EsETPFUG7Cyiivxuzmjpfg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Handle source overlap of vector
 widening reduction instructions
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 liujingqi@lanxincomputing.com, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

I assume this resolves https://gitlab.com/qemu-project/qemu/-/work_items/32=
08

>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

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

