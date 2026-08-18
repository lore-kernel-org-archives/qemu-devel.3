Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F7FC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGuy-0006ou-U1; Tue, 18 Aug 2026 06:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwGuw-0006o1-VT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:19:39 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwGuv-0003kf-Fu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:19:38 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-836cb2fa1bcso63822607b3.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 03:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787048375; cv=none;
 d=google.com; s=arc-20260327;
 b=Sa0uhJ5B66+jDE5nHTAC8tZYavdMm3PONYwcXL8R06OMl4aNEuh4SRX7SCA/zqeDFj
 7W9pqWh9em76NApV+Pdj8zlXUIMif6ALc1VQSXCXuOehYkERHnkZd3wEQUjf8LiKP2tW
 YrmRX0rpDD6tuAVDWFsPsX/0Ub+TfW6pdk1X1OJMMf9BOK1/7CQLE1JC5lqX4uxBGId2
 uvSxto/RMPu187tIJzob1UEe7tUbxhfZWceSf0d44kovgjsLQ7T2/+Xq8h/iKJvtuzjd
 Ag4JHALA9JoujOZf1aNUsEEZIGub/BqCfpG9F5o3RPKoEw6WtM3lk6v2LAyPMX/TyQs6
 pvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jrBsedDKpDRNYYCsmyo3Aev8UbFtnGnTfQEJ0D2UY1o=;
 fh=rRwEAwPkSZ0I452N0nR2YVKCsQWVAiaKmLym9qGnx7I=;
 b=BcvIB8aPTxW+KbBPXogAgobbS26M92yMCkE/rP6PJvRNh2yRjqYeUC4nNRpfI/RMXP
 c3ntYux9EA95N3NyJxQjKYNVG2BfD8FfMg39HhAhMI0xyLnciMdBEZDUzvs6R41A0z5P
 lVILbCGvt879ODMdFqTTQe151Z6DjXVSWZaw0jN0trzm3ANTC/Ebo79UKM4+ZoCvKpmB
 uM42RHSk29AGRTdBFZXGQErTaWqdrUKh9HHp6JIdgKyNBGXhUkfG/GzsMlYplFBkC30Y
 V51lbsmzmB/XxiPnkFjPCxuITNR2NsuAfziSq4FTqOreDssn1P5WgdNnxaT35Yz6kEs9
 dEYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787048375; x=1787653175; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jrBsedDKpDRNYYCsmyo3Aev8UbFtnGnTfQEJ0D2UY1o=;
 b=mVV+9uaZ0zRM2IwVgq3xEfFpnlIRZr0/K+UT3Oi475EJkFiRWCoughJ395c4sB3OGC
 exTkbzrfPaMdX05pyHjjFLcPlRydJXs2+SS4zfJoib9Nt0m3D0BWYl+5XccLescAlmZM
 pA9VLueHf1Twx2p+Y0pwMEJboXJfcTzxQyW1Oq/HplsRBGAg3Abi2rXmqEO8/OePnyxP
 eiXIb8ZX5WHcDZDb7xikx/7kPhlAyjgRyonGk7OSs0Q/6nhzQulPRfQekpac51Ki9wfZ
 4qyjvJHXKP+RT7L7jiU2iOfunJnMFOjhDtEuFOaK0Bx+/qXd1OAXTdHdoTr7e8RiM2Vb
 yB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787048375; x=1787653175;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jrBsedDKpDRNYYCsmyo3Aev8UbFtnGnTfQEJ0D2UY1o=;
 b=kRCThxrrOTZHKgzFMBr4V882Qx9+tiCytZdT4e4fAnAnSOvLt0sNPdpPQHQad/YkCK
 Aixsjyj3TS0px15qE8dBtGaPGLwuJmYrequYYELCuz+IwbK7h11/tvbP2aQtXs+kcgoS
 e2+SDykFe+e0ylrlP6ojgKWTTKJakYBfOPT/kPubfoluRC/i1axA1baK16lc1jcQ4y5e
 ubHHggjjkl33yYLBL/2RetvJg00zAObmm1PQM0E7EOiFvGJavPrw3KDQ4MJe4VhP1nfx
 R5TwGbb3Au/0D8QnwvdhxJgeDZChbKKKyqK/OEIVPUi6WsmG2enjPIwwvV8r3j1FJ48u
 ELYg==
X-Gm-Message-State: AOJu0YxQRFygZjKnHO5RdaTZ2xM2RUg2C3RLVJH+s5ZKRDPfFk+4lVjE
 9GJ7IqC53TuBVL+kcb5iFj0vCjKVXxu+l1FnEhxF4XXnIIUCAyRq8gYAN3eyPzMRK7MLfzcyzdU
 YSU2mS0wMW/8NJzCEQYrhcmHNw9KBsWl1b4pjNiY/tA==
X-Gm-Gg: AR+sD101MwWJtsJmsOVm4sqL9xtRdiPdYE6UNjo2qZFGJBhBcJgmcW4zFDKp8Tu5AzS
 1632lLPDBfztx3v7HWnex5ugBnvva+Mg2r1cCyFJeEuHx9H0Ls9bhqk93W9lhEcJM1+xjE212ke
 pZyrqIJPhtl5x1sOf83prfgCOKPnqJ+SrjZpKWdrByeHnH0S0T3SQD/DMdJV1CoNW74QitnlbEU
 yJBv3BBaiB/w8JZb90jQ29VH5PJQFgcZKKE2UXHGGFSX7WOrCKyjflWpvV1RYr9mGb+THzGm+BJ
 V50m+8gnXDkTdUflJqG4I+UH7ei5Xbe2tHg27aH5st7IEz3rFC+AFN0JayHB2nVLxAp/aDeRGMJ
 ZXJScRDzcaokIJbhmNz3HgN5VFgSFSQOvpG0ReXo=
X-Received: by 2002:a05:690c:a642:b0:830:90bf:9755 with SMTP id
 00721157ae682-8370c651a66mr79085407b3.4.1787048375423; Tue, 18 Aug 2026
 03:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260811191540.79882-1-richard.henderson@linaro.org>
 <20260811191540.79882-3-richard.henderson@linaro.org>
 <CAFEAcA98oxLs-w1PNuoM9mArit=toTCTucD5xOmN29Rbk6XBTQ@mail.gmail.com>
 <c931ce6c-1146-4bd7-8769-02e98ede0f82@linaro.org>
 <CAFEAcA91Gc7-n2SBvA-+vF2PemB6gqWFKKsoS9EPZ4Ks+N7awg@mail.gmail.com>
In-Reply-To: <CAFEAcA91Gc7-n2SBvA-+vF2PemB6gqWFKKsoS9EPZ4Ks+N7awg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2026 11:19:23 +0100
X-Gm-Features: AcwNN1XmBpty47ZunpgMfqGRsKbiWACOikpCho56Wg57R9AkpvvArMe1rQEksjc
Message-ID: <CAFEAcA8S-shexayOeP=jY-p0izYLvsdmLdFg8qfMVt4xRkC8Ew@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, yang.yanjun1@sanechips.com.cn, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 18 Aug 2026 at 10:29, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 17 Aug 2026 at 23:34, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 8/17/26 09:37, Peter Maydell wrote:
> > >> +    tcg_gen_addi_i64(diff, diff, -1);
> > >> +    tcg_gen_umin_i64(diff, diff, tcg_constant_i64((vsz >> a->esz) - 1));
> > >> +
> > >> +    /*
> > >> +     * Since we're bounded, pass as a 32-bit type.
> > >> +     * Sink the diff += 1 from above into the 32-bit type.
> > >
> > > Is it worth doing that? Hosts are all 64-bits now, and surely there's
> > > not going to be a perf or codesize difference between "add 1"
> > > on a 32-bit type vs a 64-bit type ?
> > Technically one byte difference on x86_64.
> > But we could drop the whole truncation thing it you like.
>
> I think mostly my feeling was that since the rearrangement of the
> umin() expressions above was already quite complicated, moving
> the last part of that down into the truncate-to-32-bits was
> adding extra complexity on top. Just doing the subtract-one in
> 64 bits and keeping the truncate would be fine, as then the
> two steps aren't interleaved with each other.

...but thinking more about it I don't think it's worth respinning
the series just for this, so I've added it to target-arm.next
(with some cc:stable tags).

-- PMM

