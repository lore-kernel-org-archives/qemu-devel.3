Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEFFCA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 15:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD1OI-0006wP-Tv; Sat, 03 Oct 2026 11:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xD1OD-0006vY-Gw
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 11:11:06 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xD1OB-0002Rl-Lz
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 11:11:04 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ace0741488so3788397b3.3
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 08:11:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791040262; cv=none;
 d=google.com; s=arc-20260327;
 b=i0XXraAR+FGztVrgnN5vRgx5C74vfY5t4t5lHq50PD1YHwqtllsoGtoECJFEZSzOBK
 Q4zEwQ3vcs/0CYrEFlqxiS76Fl1X0zhtTrc3g2PftJCoIlhM+x/tDCb3bs/ZWcPSkUvv
 tVS10ISWQDQLgvxjzyiOHkHqBQkIrA5LEK0WtsQW5U0hHx06lwdlv6tDxkzDW45brr1N
 RDWldFPLXhs4tMPfMHFE3HYzdSqMjy1uowpdJBMoedjNQOkekUns7aTFgeprxjWHBW0u
 OWRXpBO/jItGvsqlhY8jCZu4X/CE1eTMV5LkMfQGYnVUItFpEV6XzGabyVL8JiQ7I3H3
 5L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IXMLEeSvrR2sm51qEcoQbJwXKKauC9cXF71YJk1dZxU=;
 fh=G3pTxZtypzZ1v34NCtmdB7h6uDkf4TMWh+OXNx8vYRg=;
 b=M7C9IPeH7IHvV++NjkFF19lviH3Ky6RBJ2ypzO/kd2kqYqTfqI+nhdGm5jzYgJ++Ah
 WZNc+XDaSxS4486jlVNBTYdgPl5eVaD1+pBMaNpf1Sae1n7LNHaUsCWVTGtJvYo82Vq7
 HtXB6IVzoRpmZQgb19crH14FRMTD+3aM5l8+rCpzxm1fN2X9hT8QLgBAKk6+B8pSbR36
 adJhhs5s3S0lhAhoZs8KrvTVD9d0VblUo8M68HVTkqWFnDEJ7MHOZnIkNcftt/yTZqNC
 muAaRMG6B+LoEh6sLfKrTSa/6TTk2NP4OyjeEMUePOPYu2Mvdl9SU9+TZG3nugi7eJyP
 A/Kg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791040262; x=1791645062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IXMLEeSvrR2sm51qEcoQbJwXKKauC9cXF71YJk1dZxU=;
 b=jen2syKAqDoxS774CExEd5P3MfrPn0tIeKZoxyFLqORreq5j0FE7D6+zDSOjqSjbm5
 s8rCuNkehMQR6r5Y9n/qABpLqunrFXO36CoCVbpP8mTa31NwRAsKaYrlt0S9WOnvSOVC
 QTxRV+rM3s2hE45S/sI84bopbbB5Me11+nBpAQO6srKx+JZyneaZIc+JUfauzWs00MOp
 2vczeCKjT8wof3B2I+tpbkWzKYNBKdxpSbLcWWuJL8UD7JHX8L4v+Q0QQ1JqWfTB0gd/
 Rs7bSvfbp6LkYhYdqyJ1PU/n/pERpB2B50sWM+ghjdPRI62YcnnjfXJTB+ZzgMbyvFe3
 FgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791040262; x=1791645062;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IXMLEeSvrR2sm51qEcoQbJwXKKauC9cXF71YJk1dZxU=;
 b=rcWTK6x52WtllotU4H2ggXXPbQLOLSScuIX9usnpZu2MJjiaaLfR+KsoxpNHPcdg/D
 99TXl2MuUseEudHPfJ5Pv6nlBgIcaPbnyRxhA8AI9AR9aKu867cjgD+i/nqsP2tpxlaX
 yM7GLHNliCzungdIKa04/H+MfVXFJ9Cp3w+X0Z1pqiBzxr8vAun0HLlv54frA/k2Sz97
 1kS/FPz2hOJegKYnWpUTSu9AOp+Fgz7vofWTC7saW75ugByLp6MMxPFIcoWaoZ8aYmYm
 XuLHnGNdZahlZ/rOHDcUBRjh1cslnUD1wCCpqK9QbCL97eiWM0fnUe2wquDkHdpywdr8
 wL7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIGVYUJ9SamCHPwfHwgSvzcixt8/+PCIm4O4tMuQExBdKdgxzGeZl0ljZnq04YVD3zi3/sEEahC9ea@nongnu.org
X-Gm-Message-State: AFq9FYKNxAUlalbAKjhj4Sa9EUZvB5A1TAKokyfQisxmMrwgSmZdv+jv
 syRoZQ+khtDoX6GdNoOiXGF5m1oqSYj/I7kyLk0KCWRzgRXzD4d98l8vpTvNL3+zlDQyh4nJKQI
 2wqvB4vgwEKHYT64FGsRyKoZGBRWo4Tc=
X-Gm-Gg: AYBFou1JnbvdsJSlP5inPmGuxluM1D1amb6VVzgPX0OYkhkQWQXypzqV9cuIN43CvgH
 LocylLVAa3hNwoBlRrPQObzKxIvir25RPMdh6M87/x548ZmMiD0DM3/tWobu8mql+yi9ZMiymMG
 +KLOubjrEM2g35l2OibjpHDb9XSr0iCgN4aSnJPF/38Zz+hm2dymJUYC6nXy606SBpxlBHjPl33
 b0DhiLjiLjJ8c6pFTtaHTPZSMelFDhtEfgNV9CKWmqAOuYwVVkp96LNjbSydoZKJB3V+oUoNnYB
 SrTGYOFJBBZWtsgg9931L/DPtjViZsHX7RFkcv+ErBGHe6I4F4BsneXSmP6gYNFN4eEc3Jm8lox
 Yqp1qJkugcsZk0jk=
X-Received: by 2002:a05:690c:e1c9:10b0:872:1e2e:b4c5 with SMTP id
 00721157ae682-8ae951f63c3mr6389107b3.18.1791040262344; Sat, 03 Oct 2026
 08:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-18-bin.meng@processmission.com>
 <20260930-bulgur-dab-28a151f39dc3@wendy>
In-Reply-To: <20260930-bulgur-dab-28a151f39dc3@wendy>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 3 Oct 2026 23:10:50 +0800
X-Gm-Features: AclHuK9Suxe_RtofqfVpOKWmMH1eiLRatpfqk2q86BAr3GxraXi81gUg1hrJuXA
Message-ID: <CAEUhbmUofH0+3ymRfoR2Var9X_L_zTr--CLYgWtn1L2p1MuwjA@mail.gmail.com>
Subject: Re: [PATCH v2 17/24] hw/riscv: pfsoc: Correct PolarFire SoC DDR
 aliases
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Sep 30, 2026 at 5:31=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Fri, Sep 04, 2026 at 11:57:36PM +0800, Bin Meng wrote:
> > The 64-bit cached and non-cached windows alias the complete physical
> > DDR from offset zero. Treating them as only the portion above 1 GiB
>
> This is not strictly true, how these regions overlap depends on how the
> FPGA itself is configured. In the past, the regions were set up
> sequentially and someone may choose to set their device up that way if
> they want to, provided they change their devicetree to match.
>
> I think the change is worth making, but the commit doing so should cite
> reality and explain that this aliasing is the case in the reference
> designs provided by microchip, not present it as the whole truth.
>
> Ditto for the comment.

Will update the commit message and comment in v3.

>
> > leaves valid Icicle Kit memory nodes unbacked with the board's 2 GiB.
> >
> > Map both high windows over the full machine RAM.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > Reviewed-by: Chao Liu <chao.liu@processmission.com>
> > ---
> >
> > (no changes since v1)
> >
> >  hw/riscv/microchip_pfsoc.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >

Regards,
Bin

