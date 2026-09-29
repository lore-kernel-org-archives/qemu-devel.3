Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5B2CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhMy-0001tu-CG; Tue, 29 Sep 2026 19:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhMv-0001tV-8N
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:36:17 -0400
Received: from mail-lr2-x0e.google.com ([2a00:1450:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBhMt-0006H3-4x
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:36:16 -0400
Received: by mail-lr2-x0e.google.com with SMTP id
 38308e7fff4ca-3a65fd1534aso24637901fa.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790724973; cv=none;
 d=google.com; s=arc-20260327;
 b=JFEBSJ2YeOCh0EwRDdVivG5Jkyx5h3U/HPAwQwMuO8bd/1jL1MDS7IWQCN4SfzzGnO
 dHtl17vAZaLEjIIDFphOuNrxYYnaW8rWAnDuYQ5Zppl9mKk0rJ6MNv2Fgn53BS/r+oOx
 9HHRus0pSbdseHYsEJzd5CHBC0LEejDcC7ni6FqJyCCeu/T5aq+B6Z4fLHqf66AXzitL
 hTINj8STfIjnvy4miK1R0slU6truXEJF6tMNrlwkWIO/t0haLa+osnDR7X8MUxGbrpJc
 iGv+uDIizT2HkTwGSACpR2THsM75wO8eXJvbjH1WYKU/n2R4adhNgFt5Ft9Jo8m6xpDr
 7jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9PHAzyROmCPf4pV0MFG5UONeM1gRMUx1HyrNNf5/Jb8=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=C0kdGdYDWj3MwV8deaErB2wgub0eh+YeyGz+0wNtL2tCHd1zloxno9wNba1jQSLwjK
 tkpPFV4JRmhJtcbkDBbOb/YrHcJJuKVopDpc9k9C0yXXmnTxFiHgeXQ01BsHfYZRoJKA
 DfA8ePX2EEhCVMghBRNAJz6XUT4FpD/z1LlvH3PX8BXAruCan6olqQ71ETTaaC1k3YW3
 bALsrXipYzVG8nu/IpFvYIspUWlLFrtEHPr9kxCSlxoFqYN+LmzK0zKNnJ4zXiNr+zC7
 1WVMv/o3njxR2po2W19RDX0C9wWo8X7AnIa/BFvD/lG5SVMQEPQHihu5hN4BY/d1QEhH
 WmOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790724973; x=1791329773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9PHAzyROmCPf4pV0MFG5UONeM1gRMUx1HyrNNf5/Jb8=;
 b=LaApnRt5OxLc1wsRkGcRo1HRLviDNN2NnFMf/zG24AKVMPX7v1EDPmZOxIZd0iRZNK
 +9chTeS2YuScH0swKs0aMMYViRjk8XDuijJQ2kkQpGJtWU+yQth5gdSnIruJt0nyzBH8
 Ixil544F2eAJGGwMRVYBf4R66QUmeS27odwh5fcChJB+0otDZm76rNqYXchxnMsHkDQz
 dB4114vuq95jei+2mF0aOYIhsbJ5qERwYC7wW1YsN+unOw8enew1+G93+/bxdCf6EE9H
 3ogmsCy356JWSJUZlGEtO0101WHVnxygOVelkOZjnopHDi8J7cFw/CsokVD87/bDRC9H
 GmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790724973; x=1791329773;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9PHAzyROmCPf4pV0MFG5UONeM1gRMUx1HyrNNf5/Jb8=;
 b=PkQ4fMCJ8wcJp9m/7Tr/GXEjRcMy/mJrqtxJQ9R7rxeGAuiZsxfRwWZFd/JUDWSYUV
 xOJX0EIA8QW1plVoQvQVwOzD2WcBFWhfuzTvt49zKjaUePxK3KFcSqFYjVW3nLDom02G
 4UMhbLAzsk+Eqen8JMrrE5rxm9pwIDUZwhNduT19z3KQiNH/yBQoyDyRchs9sA30dSdP
 dw4uTix1Ey+Sj+zybqLvZhPAjNS+tPNCGybGPxRTkdVWdrcTzlOBQjRTe5oBS0o559F8
 iHgpPztKSElurgmMGTdCtByIASTB8cxxgftGOXxS6jAqAMAxIK/QlMVEZ6U4dZGdLHgt
 wOAw==
X-Gm-Message-State: AFq9FYL2Orf18Hqvjtiaqesw0xCGc7PEQavmf3bcDqkp6/LDC+/qFl7H
 v23yGlGlnzNLba6eFgpltdwXgi/b+qKxpernCdDXDfjAk4yUAy+xiHNuhE86F4LD5/fNVFRDWfJ
 LG8L3GLflzCC39qu6vM22sJXJu5qeswg=
X-Gm-Gg: AYBFou1zitcSo7/snNPaEAFDlOG5PSsZptCjcVs+CFnP5YqbK24q7hT5IaL6gZY2wtx
 Mu+u1cBdnNiGfUBPpjwOykcRlAsG4v0bX5uBdIoVf8YfIeSxfrCDcIcgI3igrdN7S/C4Nxo5ogc
 P4VGmfvdfU/+BhsDySPLSoLB04BgBQ7Xo/By1ohkpPscEUK/96AKw7dfvMSgzSz2UfX+i3FTacK
 h0czxfs+cDWw/nKPhOO0FZ2pRpZ339x2Rxy/6DSTzTLPjpFOuco3SsKTUXS9O10LMwRykQVcKGU
 bnl2sD7j+2BnCQyP1byM0+rM9fuycTBjqQMUOXjTBrPfjo/vYUpB6yxzRD5YMEb/SL1qefYCp54
 O1kO6tSE3guyMnQ==
X-Received: by 2002:a05:651c:2214:b0:3a6:5b0b:3288 with SMTP id
 38308e7fff4ca-3a77178cfedmr2363411fa.6.1790724972979; Tue, 29 Sep 2026
 16:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-16-richard.henderson@linaro.org>
 <CAEdQ38HDzHj=RZUqj8TDYSf2FJZFACGT75p2PTZB1iCyw4q0_Q@mail.gmail.com>
In-Reply-To: <CAEdQ38HDzHj=RZUqj8TDYSf2FJZFACGT75p2PTZB1iCyw4q0_Q@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 19:36:00 -0400
X-Gm-Features: AclHuK_CbwonPlFhoWyWh5tm2Cyf3wF_7_xpobWleCbVkWyk8T-rLMJ_D4zCMBY
Message-ID: <CAEdQ38Hsd0NbND4cb=7wPH61vqfU0iSLfv3S3qaVo8C+SVXcQg@mail.gmail.com>
Subject: Re: [PATCH v5 015/101] tcg: Generic expansion of tcg_gen_subi_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:38::e;
 envelope-from=mattst88@gmail.com; helo=mail-lr2-x0e.google.com
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

On Tue, Sep 29, 2026 at 5:53=E2=80=AFPM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Sun, Sep 27, 2026 at 5:00=E2=80=AFAM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  include/tcg/tcg-op-common.h  |  2 --
> >  include/tcg/tcg-op-def.h.inc |  1 +
> >  tcg/tcg-op.c                 | 15 +++++----------
> >  3 files changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> > index 8444044ed57..ff15e3b88ae 100644
> > --- a/include/tcg/tcg-op-common.h
> > +++ b/include/tcg/tcg-op-common.h
> > @@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned =
meminfo);
> >  /* 32 bit ops */
> >
> >  void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
> > -void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> >  void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> >  void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> >  void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
> > @@ -225,7 +224,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
> >  /* 64 bit ops */
> >
> >  void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
> > -void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> >  void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> >  void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> >  void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
> > diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.in=
c
> > index 51d5ec6e06a..55249c4dd6f 100644
> > --- a/include/tcg/tcg-op-def.h.inc
> > +++ b/include/tcg/tcg-op-def.h.inc
> > @@ -7,3 +7,4 @@ DEF1(discard, TCGV)
> >  DEF2(mov, TCGV, TCGV)
> >  DEF2(movi, TCGV, TINT)
> >  DEF3(sub, TCGV, TCGV, TCGV)
> > +DEF3(subi, TCGV, TCGV, TINT)
> > diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> > index 2865de65d39..9bcf79ccbfc 100644
> > --- a/tcg/tcg-op.c
> > +++ b/tcg/tcg-op.c
> > @@ -399,6 +399,11 @@ void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTe=
mp *src1, TCGTemp *src2)
> >      tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
> >  }
> >
> > +void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t s=
rc2)
> > +{
> > +    tcg_gen_addi(type, dst, src1, -src2);
>
> Double check me on this, but since src2's type changed from int32_t to
> int64_t, I think this will produce a value that isn't sign-extended
> for I32.
>
> E.g. for I32 with src2 =3D=3D INT32_MIN this now produces 0x80000000
> rather than the 0xffffffff80000000 the old code produced.
> tcg_constant_internal() doesn't canonicalize, so we end up with an I32
> constant that isn't sign-extended, which optimize.c assumes can't
> happen.
>
> Going to make a quick sweep over the rest of the series to look for
> this issue specifically.

Found similar cases in 087 and 096. If this is a real problem, it
might be simplest to sign-extend I32 values in tcg_constant_internal()
rather than fix each caller?

