Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA498CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAd2-0001zr-Vn; Sun, 10 May 2026 16:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAd1-0001zi-Hi
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:19:55 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAd0-0007aV-1t
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:19:55 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-95cc8ac98bfso787150241.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778444393; cv=none;
 d=google.com; s=arc-20240605;
 b=A6PFS1arOLUEQE5p8EuRrydLQlSboAUwx3O4GwR9+PmB981le2Dfyu2AEh5FGydAFK
 AgypMHHBnZmXiPeqCmYn0QamLGAMOhL7yQNEL3uj1oYLtkfepZZsYriauHLz/NHuVYJ+
 KDpbiCt91MvcU4Py5W/4IrEGbxz1toPvzX3GLa8tLc251+vn1uanCf/JAU6yMjZcfW8L
 zBTHDnaWgONsY2OVfoQTSq8h0EQv8AyjRsMgMIF4JrE1EkYcHreEzEbXX5AZFtsVsQf9
 FODQsfFXlsjbDGW1cWfbmk5pFfd6BwKkYEwyOSSeoHo4iXQNQskNjVZRaVZHtZt2xanG
 /ppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U7yr0DdjuYuFCKOJsgOjp2fJGowaiR391m2zc6rjHDc=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=DU7G7/gcapr4oLtmNOcb+EjUb4Jv7keCkSgTN+h/dHNnzeJPGFrSbUTJsvuK0frbPK
 DHnzI0XqZsq+BMVN2Gm36zP8gmZWyUoYglrXhFIZpoNiXRJGkvdR6/l9wONKC53cWYAd
 Obab8t56Z2mOoia3Citj7lyeB4Qik0W4QA7wMt+aBTgGjhLSbh9bGDIWJKhPTnZrAGI/
 xejMIq1S1NILoBXEToxz2c27rcejGtpCs1FFExn5h9DCt933FxlCrVt5MkmziEk6vgQ9
 CAcdbhX5Ry9mt0L8KDEYHmTSKffMaaxc3AJCQTWX2craYlS9bQnkoxsDaD/qU2K9Y5vX
 xARg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778444393; x=1779049193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7yr0DdjuYuFCKOJsgOjp2fJGowaiR391m2zc6rjHDc=;
 b=rpwXnh1JYnLWL82UTkjwR5c1hieqsn2NTsdr8D/Pb19BIvI3Obkg7Wf/TqZQ39iFdC
 hw64G/e/1ap/OYAsqtfL04d54mPYAOenfASmAMEiWY7IvMqItUbvC4r0WWlu1f8Fi4Gr
 LzSp3vW7gnplYUBd+P5Ll3ZXCUEiLaVKAABFmgCl6r1uIyKPhvB//G8d+xBBpq1xRNU5
 GY/OMOiFmIli4rGKqOk3BI9txlrmB3dNcusL9Uyud5U77gTETu7iS8PivKh/IEaG720F
 X/egl1ISS4BTE1LPeyw0+tJrFZt9gM06sLjgMx+gifM/tWmPZQMTVefV1gnjwM3v1jxE
 frfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778444393; x=1779049193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U7yr0DdjuYuFCKOJsgOjp2fJGowaiR391m2zc6rjHDc=;
 b=LXZZJZbKW0y40NZpmVofll5hYZ0KIyQuLLJ7fYlitf2Aw2qe2hrNO4OJBuB4FEl7G6
 psAhE3zLASRXXRNnMxtlmYuL4qbAUzcWtaQs6FBYlI9lRHco2rdAyIeajmX4rtvMGZRC
 RHxMCN5vO/3vznQZ8ku+h9k03v2d1et0SQhQtx4UYkeFm3c76kcsveKm8uz2PkHmcyTm
 qWRvfPN9o2/GS2xgYr8uIUnh6HslJs8cUVnZXYBR0IR+fvULR3/zPxIs0sDsPZs3LeN4
 LoCaOqTj6aQxml+Y/xJ78rlXQD5DNRZGBNokeWbNcK2gKCROBjEcFs9a+B7uAJbmyIp/
 ZuBw==
X-Gm-Message-State: AOJu0YxOIbV3dja4OUnY7X8bXamX1s9RvNKds9NKth4RB8yE51jVgMr8
 c3vxHoqvWmhPQWo1Lo1Yzbrh/Bu3jDTmhtPExtLMHvBn9moogQaIPmvIf+EWdIjLyeTMUkg5Lus
 U1DgifVa8qmCqszUtYIGdMWFD2ruJAcHIKf8g1OE=
X-Gm-Gg: Acq92OFmesM59jqhh9E8kNIrZD7hymU6Y6FEj2xns+mHqKH+L/qzt/bicH6kXsS4v8I
 r5vrNPvW20OMf7J+d+/M6+xlWRdguZPDWU3D8H+F6Jon3ZOgUf99zDGeK/z42HyOiwYgfx+jJ9G
 aut9xw3QYlhGlh0Zx7JDX2oyAzlcH0ncCWAHq8Gog8Ju8g4/+cTGu8I1e19qPnb1kjDza0pLCC5
 VSYxYBbQVpUIVquxkh6zcJ+YpJYkuh+mxrr36wmNv89qqMroA+qtGFWKxLl1+FbrPJwOZpv0hi2
 xalK4fWQyF3U6Jah8vMWaiZ4ly4p/bLZcIm0WAR5Z/rgGePsPzAanUMrmk1uwQlwmpeWlQ==
X-Received: by 2002:a05:6102:8551:20b0:631:26f6:7016 with SMTP id
 ada2fe7eead31-63126f6a89bmr5351296137.28.1778444392766; Sun, 10 May 2026
 13:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
 <20260509-mips-octeon-missing-insns-v2-v4-11-d669dcd05c2f@gmail.com>
 <f2af3df7-75a4-4a7c-9009-ea42e7a0988b@linaro.org>
In-Reply-To: <f2af3df7-75a4-4a7c-9009-ea42e7a0988b@linaro.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:19:41 -0600
X-Gm-Features: AVHnY4IunlRpnFkP6vj83otS0WdU0-nBP0M7si_6QBxCmtpjWDFVsT087gjE-Hs
Message-ID: <CADvTj4pMFpXftMtZzjw3YN7fCsAJkS79Um1vRgN9S3BLu8E4Dg@mail.gmail.com>
Subject: Re: [PATCH v4 11/32] target/mips: add Octeon SAA instruction
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ua1-x929.google.com
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

On Sun, May 10, 2026 at 1:37=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/9/26 21:13, James Hilliard wrote:
> > SAA is an Octeon+ instruction that atomically adds rt to the naturally
> > aligned 32-bit word at base and discards the old memory value.
> >
> > Add an Octeon+ feature bit, enable it for Octeon68XX, and implement the
> > common SAA/SAAD translator with TCG atomic_fetch_add_i64.  The MemOp
> > selects the word or doubleword transaction size.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v2 -> v3:
> >    - Split SAA out of the combined Octeon arithmetic and memory
> >      instruction patch.  (requested by Richard Henderson)
> >
> > Changes v3 -> v4:
> >    - Gate SAA/SAAD behind an Octeon+ feature bit.  (reported by Richard
> >      Henderson)
> >    - Use the i64 TCG atomic add path for both word and doubleword sizes=
.
> >      (suggested by Richard Henderson)
> > ---
> >   target/mips/cpu-defs.c.inc         |  2 +-
> >   target/mips/mips-defs.h            |  1 +
> >   target/mips/tcg/octeon.decode      |  4 ++++
> >   target/mips/tcg/octeon_translate.c | 19 +++++++++++++++++++
> >   4 files changed, 25 insertions(+), 1 deletion(-)
>
> I beg your pardon here.  Given that we implement only Octeon68XX, which i=
s Octeon3,
> there's not really a need for new feature bits.  For clarity, we could re=
name INSN_OCTEON
> to INSN_OCTEON3, but that's not really necessary either.

You're right that a separate INSN_OCTEONP bit does not buy us much while
QEMU only has one Octeon CPU model, so I'll drop that in v5.

One small correction: Octeon68XX corresponds to CN68XX / Octeon II, not
Octeon III. My understanding is roughly:

  CN3XXX -> original Octeon
  CN58XX -> Octeon / Octeon+
  CN68XX -> Octeon II
  CN7XXX -> Octeon III

Some later patches model Octeon III-style state/forms because existing
binaries/toolchains use those encodings and QEMU has no separate Octeon
III CPU model today. But for SAA/SAAD, I agree the extra feature bit is
not worth carrying in this series.

>
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>
>

