Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BE3ECD6F7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 23:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqJQC-0007mH-Lo; Wed, 11 Feb 2026 18:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqJQB-0007m0-CM
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:14:59 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqJQ9-0000i9-MI
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:14:59 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ab3b0e49a8so598935ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 15:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770851696; cv=none;
 d=google.com; s=arc-20240605;
 b=EmPJbZy258ofkulSKbUOf0oopQ6WHHmZnfs2u2AtmZQXfHSIn6hPGlh/5YgqWq/sfk
 3g0uvU3e8RAe5R6uQNWHTtsko+h4PubfHQBpirk28qEPB21jjn31HyD5DirKiOFZL4rW
 HmqYhtx6g4hK3MdMODDvhgEkJiEyQSICVdD08NMymaoM2fKH5IZJ33kBjw4z3fYjUmRp
 1hs1uSg2aLzsDYr5ukSFKvCwz0CDJeMISYCalIM+f9RhNVnvRPHu7/9EEZyJlDNWAKRC
 J+AhCwCjI3epLfVLljo9zXnfIpm2y7shsYXDuceAfWQx2VpWZB7kHr/CcnaAx413sZzx
 T/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WSh7IOdcaRWA42fnPT2AQSSW1C7NXyIbQ0S6m1mod04=;
 fh=MiUykc4xDWO2e/LYwoZUK61hIp05Jo/JXb0Ee+A7oFI=;
 b=U1zJvoTZqyMLz/x+dFxFrCl9OM9IXC6+MO0Fmihwdk1TTaeppOGAtBp3mtenwYY0jS
 sMjEfbCtdcqy5kdhlyUbd2DTvB/2rj891ijhipMlPzxCI8aewmBauafiQb2QQdpc3Io9
 bdIZ81trtG8gD4gGPxw2noD58iSW/EsFGpn4LW+Yuqk970WSvO94bRjy/tk7d5OD8XO5
 F/jBiCGm6Vpf7qKBUG5PzLwvvYvslv+/5izme75SzC+lWes8H3JDwXr08zqY/+vfXgRk
 bgxVQ0yppY53OBszh1lK0QK8s+MXIh2DptGycFmapE9uXgR+G+Vt4CrUX12g747wk83L
 3vZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770851696; x=1771456496; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WSh7IOdcaRWA42fnPT2AQSSW1C7NXyIbQ0S6m1mod04=;
 b=bkgShBInvqpdsV0lLoZvvpxpAdGRlEiGWv+GOaeSdcOZwj8QUPj1C850bLlbmDv3as
 CXrbLnA/pHx96kAP8QoOXn4ur6l1e8pB6YwOuDtyGIhCVAAji+yQDsKDofCXkgHvjcIZ
 30bmRotRi+qIUzcT42vXMhbieC33cRfBT14RNs8BrNGujwjT6J7l7XJhfv3DrVGy/N4x
 UHLBGHEkRNLylBql7BJ1GFonwS6m9LL07nyr64zctIAf1qQj1Bq21cTV7gT3wLMkHC8A
 Pez48mwLW+kI+Hd2vMjOTh+WYrPJLCtcD99mLdXKrMclB7JDSnjPZB14YRFxgO2TlEzK
 mZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770851696; x=1771456496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSh7IOdcaRWA42fnPT2AQSSW1C7NXyIbQ0S6m1mod04=;
 b=qWBdEMC8K6wyfBj2YioC9/4CbsVJX3YuohUm/ahp5aSrwNMQRxr6D14LigFUpGXi37
 9sbUYmksXT8TOp30EPD2bXwmlGYw60PH3m1M6fIDVCV5fqhr+U00Dq/Qv6vNf3Mt/5mb
 Sqnhwpozv0wrR+ZoYFQzRj4Te4pnjPbzXoKKZqgApZQbtyT1QSebVNgt5Q7xFCLvr+D8
 qJVNuDPdG/EGUMkjbgVTo/G42sXhaZN+0186FV/5SMHfGEPus2jhvFShHas4AC5QNXS6
 JE+jbaK/ieM2VE3PWy4xNJBw/n8lfGul5s8RdBrnf2ahcgGwQm9Rth2Ro5MFdfB1FWwS
 At1Q==
X-Gm-Message-State: AOJu0Ywa8I2wvgl4SJxLXEJB+7ksQmBjET44qnuF2+ZqTpX+nhk9AjrB
 fe94aV1yG2DIKWX2VUXTQyP1sRiOQeziNQDkrduG7/vRwsgJb7xmgV08OE09QSOh8kngHjxMVwc
 fLet/unIPgHwtiS8FXhT1XWTglGecKVw=
X-Gm-Gg: AZuq6aJOOMm1RThV5CsVBjqXcXZw+ucMedEbKNwQkWf5iywwrK/rki4I18MOOqED4Bd
 idD897mvtkyGEwd3D05OcwpWLPWOmUm3+ee9BIWZwrkGHevzCaIW3/uvailOV7d1N/J/iFD0M8X
 AGZga84VSWTjzsDmGJeRf6pDBDjn1+veHYx2zdvTBjw+WtKdI7VPWYAooNxIGgFzQycrPTdeNi/
 idngNPu6laToLItPKRuu8Y7ShxJAqlx0OOsQObHWTjGEIx9p8C8OdhJ15Hml1GdTXfY2eM/IR1z
 r6CprYZlO06cU1BzMQo1bhboB1YteNpmJCfFQYbqP7qhiCZjrg==
X-Received: by 2002:a17:902:c947:b0:2aa:d506:d189 with SMTP id
 d9443c01a7336-2ab39c57471mr5827935ad.34.1770851695552; Wed, 11 Feb 2026
 15:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
 <20260211221953.4099441-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260211221953.4099441-5-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 11 Feb 2026 16:14:44 -0700
X-Gm-Features: AZwV_QhFXKmm7A3IqCGAA_JC_6mzSF1mboiCbh1t_Y_RAfLYsJqYneV-_Kh7lKo
Message-ID: <CAATN3NoLYUxF8gj+M0gv=-_meDoubaCmwh=rXXUjpCGrrqRhRg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] target/hexagon: Detect register write conflicts
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex@alexrp.com
Content-Type: multipart/alternative; boundary="000000000000436e6a064a948aa5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000436e6a064a948aa5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 3:20=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> A conflict exists when any GPR is written by multiple instructions and
> at least one write is unconditional.  This catches (1) two unconditional
> writes to the same GPR and (2) an unconditional write combined with a
> predicated write.
>
> Add HEX_CAUSE_REG_WRITE_CONFLICT and map it to SIGILL.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2696
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/hexagon/cpu_loop.c       |   1 +
>  target/hexagon/cpu_bits.h           |   1 +
>  target/hexagon/decode.c             |  54 +++++++++
>  target/hexagon/gen_trans_funcs.py   |  10 ++
>  target/hexagon/insn.h               |   4 +
>  target/hexagon/translate.c          |  10 +-
>  tests/tcg/hexagon/Makefile.target   |   1 +
>  tests/tcg/hexagon/multiple-writes.c | 169 ++++++++++++++++++++++++++++
>  8 files changed, 248 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/hexagon/multiple-writes.c
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000436e6a064a948aa5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 11,=
 2026 at 3:20=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">A conflict exists when any GPR is wr=
itten by multiple instructions and<br>
at least one write is unconditional.=C2=A0 This catches (1) two uncondition=
al<br>
writes to the same GPR and (2) an unconditional write combined with a<br>
predicated write.<br>
<br>
Add HEX_CAUSE_REG_WRITE_CONFLICT and map it to SIGILL.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2696" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2696</a><br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0linux-user/hexagon/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
=C2=A0target/hexagon/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 54 +++++++++<br>
=C2=A0target/hexagon/gen_trans_funcs.py=C2=A0 =C2=A0|=C2=A0 10 ++<br>
=C2=A0target/hexagon/insn.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
10 +-<br>
=C2=A0tests/tcg/hexagon/Makefile.target=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0tests/tcg/hexagon/multiple-writes.c | 169 +++++++++++++++++++++++++++=
+<br>
=C2=A08 files changed, 248 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/multiple-writes.c<br></blockquot=
e><div><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:lta=
ylorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</d=
iv></div></div>

--000000000000436e6a064a948aa5--

