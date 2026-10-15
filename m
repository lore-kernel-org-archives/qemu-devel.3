Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCF8CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKe3-0006dq-Jp; Thu, 15 Oct 2026 08:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHKe1-0006dN-MZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:33:13 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHKdz-0006uZ-TV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:33:13 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ac525c1f05so22112337b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 05:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792067590; cv=none;
 d=google.com; s=arc-20260327;
 b=cc2/OUxKqXWKiI7nlVt0qptbf+4hjhDOJsnzGibIpOyUIJAlCLmG0u7T5AFjmIF3o1
 jA4qAKzC4VBWxSkVVQniyXEqbvVsTozl5z7UGSaae9k5q3cmfxFtSWEkiB2pOQK/nQBy
 Ca3P/G37QI2FhjNUL2HCEvxNFaSHLyjUEwieuqdZ4+ijWLe3xjbgSVjV5XzvgZYWwCzL
 aOnW2CavfAdoKGf1+MqqPn8qDtDxZgskNeJwaTCHJ+pZ2v8AouLkTd7hpC4T8MePnYSP
 4UtVMUWj/zJUljg1aHhHoKEmeBwKlfZE67LndW4I54m1vF7AtB9qjwc321jccd5dFYqk
 hldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m5KJty38CRnym4hNOjpybq5CBojULdf02RdOpPHIuhI=;
 fh=XmW5DwHH7KdBmHks6oyZfa2Ty8akJhmwY5UucegWl1I=;
 b=BbC3W0PiXWjfQh1QzgjS2vcqam0ZTUQ3FRiJwsfL2f3BDPnu/gmMa85eCTdp+Wy2RE
 f5KjwctiqLsftITt4hS7P1MVE+sSpCHLNnhMNOp4upHUdXuowf2cDhwtkCtxqvQ454RX
 5WsIb2dgiwoEGuWX1lE4NMdHfGmR6+gghoHjuwIIUtgV5C6Fx9HC9bKC3cRz2zV9j5IN
 Ddbl+PzKrGVkDpfU/QWY4MCYkTFS9Qk9+m3DPxOvg+FezSueMgfo1g7OesIt53IKYXCH
 o+Vj5RTX/mQ1o0wwtb1tH0wnmAOU/M/PUStX0+yxzkx4bFrx3urmrorrY8cp8W/N6PsR
 A1Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792067590; x=1792672390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m5KJty38CRnym4hNOjpybq5CBojULdf02RdOpPHIuhI=;
 b=ep7QsJ3rZ1RP9O/9Iz4qHjCEpVJlQQk9ZBmEOjsU0kfDhYBJh4k0wNBZLaigsHxQ+y
 6xyk+dcziDKcdi6sUiIgwJtPH8H/nqqWzi1YU0djaWroWTLyZxpfoy3euSRJp7v5B5mg
 CS+g3PWb2x9Q227FOohhEbQP8FEv6B+kNygzA6+b5PxuabYgZ5Tax+zgJtOTWhMRfsf1
 2ElvIRnoFQWP6hxrrZ3rvjorHSlJ2Z9S7oMG4xtnSUA5B0S6eK0Hzh5BVSouBv4Pj7rh
 zysWg0vPiI5Zm2cF+3PcHiE7kYps/urwIS/9fXF0cIaW491BBu97XX0IWvSeVfGWpB3T
 oIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792067590; x=1792672390;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m5KJty38CRnym4hNOjpybq5CBojULdf02RdOpPHIuhI=;
 b=JkjSLUSJOXQBeWcmlfE10m/Om5mMHI3+QGNsTiBQruB8xBhFM0cFgrsGSxmT7FtysO
 zC7ui+DxuKJU9DFQoBVlBEILwwM973kajcja4eJ2CTMDW0mXea6GUTwSWKUqWTJZFVBN
 96XVhJphubi9Ln70lUqikLWaw/lCBJLIjUGT/LnjsC5rAo9DZo2C4Q6Sscmvvd+zJeV8
 MLNYY/MvM8NoyjeSr8U85eZ/KscRmmCsMpphk9GiBFpniQArDmN/WtrVwyfqUfYpMEe2
 xyvm1lDLQyCD+cs8BkUfJS5h7RxnHYCHj75pCUfullFMBsyGZul6fMCGKgrI7YQKb8CD
 pfTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWCccsERffl8R+IEAmVMdKNY9XEOkRjpRpVkK7PiD8TT8F8vgVHCu3NiWudVA3Ikb0CiyPMB+073Nk@nongnu.org
X-Gm-Message-State: AFq9FYLKEzrZgaiNqca+VB45keel/zxN5jNoQx9pWFMAyHhKY5sortT0
 tQwlXIg+iOAqRxKdvPjqUTwDKdOtQRPua6A7dwYqwOAYiiOMF3ZCSxs8gK1K6z+M7gFLGzUtO8q
 clxCI+enPQuP4EK6MlVHm5fONZ3nhsh/o+t0Me/DNZQ==
X-Gm-Gg: AYBFou0+viaPd6Xv4SpjvDRAJrY4cs1aNDB0BxxvCdzdabEZKM0NztQtNwk2WyhlWWQ
 sE5j+aO2lILsD78C1nqnoGsHDmOp7JanR4B1VpOlSzTRn4qdauu1TdM1sQ3f4AsQH1Pgv6CZeof
 ZnU8Uts7HKb5tePjrlSo8WlD1J1wI566BQulJu7ixwTBRo2UIjgXJ0oGzIxtGRk7h0e5qPUY+NL
 NKTnPxrAQl8KaxhoJ2TpIEjDTY1Xn94IEGMLEwb4vqQFTtRkDZqY9gqVxCryjoju73TKU/33GsP
 eaRZvjPz1LhA0YnoVOyXEanbN2udX98htpYnG/za3Jj9MT6mwuQrQ2bWGJjJJ+uZJWgRvblvE5m
 rI14xHUmPRosHvQEXwV3wo9rAM85fCzGe1Q/Nv/M=
X-Received: by 2002:a05:690c:6604:b0:870:c600:686c with SMTP id
 00721157ae682-8b07edcea14mr84077067b3.18.1792067590213; Thu, 15 Oct 2026
 05:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-50-peter.maydell@linaro.org>
 <58c816ff-3678-479a-b8b0-df1f22a78486@oss.qualcomm.com>
In-Reply-To: <58c816ff-3678-479a-b8b0-df1f22a78486@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 13:32:57 +0100
X-Gm-Features: AclHuK_7gbDfABo9IfRt_T9m70qfaa-QSP6MlaMdKGdTnaNywL3T3qcKvgVfsiA
Message-ID: <CAFEAcA8sdXhM9+dBArALfMo0h-Dr6yCJv5JLHk+0iphPRT_=QA@mail.gmail.com>
Subject: Re: [PATCH 49/86] hw/intc: Move GICv5 register and data definitions
 into a header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 13 Oct 2026 at 12:05, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 13/10/26 10:38, Peter Maydell wrote:
> > We put the definitions of GICv5 IRS registers and guest-memory data
> > structures directly into arm_gicv5.c.  It turns out that there are a
> > few cases where we would like them outside that file (for instance
> > register reset is handled in arm_gicv5_common.c).
> >
> > Move the definitions to their own header file.
>
> There are pre-existing typo worth fixing before moving IMO.

Yep, good idea. (None of these are in registers the current
code is using, so they're harmless right now and don't need
a stable backport.)

> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/intc/arm_gicv5.c              | 270 +----------------------------
> >   include/hw/intc/arm_gicv5_regs.h | 286 ++++++++++++++++++++++++++++++=
+
> >   2 files changed, 287 insertions(+), 269 deletions(-)
> >   create mode 100644 include/hw/intc/arm_gicv5_regs.h
>
>
> > -REG64(IRS_VPE_SELR, 0x240)
> > -    FIELD(IRS_VPE_SELR, VM_ID, 0, 16)
> > -    FIELD(IRS_VPE_SELR, VPE_ID, 32, 16)
> > -    FIELD(IRS_VPE_SELR, S, 63, 1)
> > -
> > -REG64(IRS_VPE_DBR, 0x248)
> > -    FIELD(IRS_VPE_DBR, INTID, 0, 24)
> > -    FIELD(IRS_VPE_DBR, DBPM, 32, 5)
> > -    FIELD(IRS_VPE_DBR, REQ_DB, 62, 1)
> > -    FIELD(IRS_VPE_DBR, DBV, 63, 1)
> > -
> > -REG32(IRS_VPE_HPPIR, 0x250)
>
> Pre-existing (or maybe that changed since previous releases)
> this register is 64-bit.

I think I must have just copy-pasted it wrong.

> > -    FIELD(IRS_VPE_HPPIR, ID, 0, 24)
> > -    FIELD(IRS_VPE_HPPIR, TYPE, 29, 3)
> > -    FIELD(IRS_VPE_HPPIR, HPPIV, 32, 1)
>
> (thus the expanded HPPIV definitions might be wrong).

Luckily FIELD() doesn't depend on the REG32 vs REG64 macro
The only difference between REG32 and REG64 is how they define the
R_FOO constants, which I don't use in this series, which is
why this typo didn't have any visible effects.

thanks
-- PMM

