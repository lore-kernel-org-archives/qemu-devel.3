Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D446AC44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkO9g-0001Sf-Il; Thu, 16 Jul 2026 11:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wkO9e-0001Ra-Ji
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:37:42 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wkO9b-0000fk-SO
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:37:42 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5b018fe8318so2986701e87.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 08:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784216257; cv=none;
 d=google.com; s=arc-20260327;
 b=r/SolIkHMPkbPUBOx0UNK4urWvU+cub7Apm66/6nphICFYkL2vA6iFlnAPAeBCJ7eE
 Ybk7qxM7+8AMUV27r3H3fjepOuhMcRmRO5KM+NM7jerVzzYpoug7cbgn/F/bUIKI3kkG
 u1nJ8g5YN9a3BNSBA/4sJhWxW0ppLy/Y4R8CtfI4RtpU078TcciaX3bOIjVNNk7C/281
 K7zHAJZ+Bz4sTU6zr4HtcXPgESYBHiLxSawVp0mz3gUqVFu0s3o0msWhB7Irm2O3NZg8
 GufWsgXLSb3wAlHTV2QQwiPAn+XAt60oKla19dj0cc3q4GOlpVWbqMeC8tmUOS0iVOkw
 Ue9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/OndQUDEFJBv6AGocQBsEBszmbMlldXolWnfGCtTlL0=;
 fh=aJcWuLTZckZ7gxoEuHF1/9IwFjMrLidnlAV2i0OG1HE=;
 b=iH1KCmhyrS1QfLKI76FV5sMiNIm3no0tl8MB1JOvjPir3wN7HUZdzg3pgkZ/W+wnDb
 KXsmFKOE6E3axKSMEu1u+NhvgwjwMfl1S1Ay16Z0QQIdobLN42QOQhl0dbQQZAjhFWw5
 lPvSFAQLtsN+FZQhaMZc4RG5f8f25JZ6VbbUxSYSSC57asiIlw8pWxY0RztDvTsCWNl9
 h/D4vBogH27UY1Yd/44nNBToc+2cb8BiErxo9HI2Kv1FE7WIHXGquv02r9+c2tCAZ4ku
 L5++BDdLZBdikt4DQnToSfgc04iinhZBkHlENJ/f5vdUlvw4g2hl93ss8ZzIyJf0y89g
 hueA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784216257; x=1784821057; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/OndQUDEFJBv6AGocQBsEBszmbMlldXolWnfGCtTlL0=;
 b=KZiBXKzpNFoMXplkMjWfPY5e2Days3916bkO5+sYjhHDCz/eUkolA7/xBVzvAbkAEn
 0E6dO9DVLvvvZNlyuHKVzohuwrWKWLBTjchZeNizrfNQAPK7PnGQ2gPYKfnk5ACExzhF
 gQRGdL1gd0ORfE+3cqeNnCz400wtMpjOO81W0qgwXvq9YTg2yI3jPG+P4eLla4QGam/j
 v84lk4i/rkdU924heFxJ+CnqBnBiVb/K7JDaqla0W0sG1bLkQPrQYgu7dbH6ljQEtxud
 UWO+lV2/5g6WxsjtRd75Xf+8ZYQcK3arun/Ps8Z6CitlEJZEJjxm4gVir5QiNQcRcIaT
 ge2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784216257; x=1784821057;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/OndQUDEFJBv6AGocQBsEBszmbMlldXolWnfGCtTlL0=;
 b=nP2iuzLPs0kbir+iI7ul38rte6T96vK3Pnb14VHzsGCURSiXlwFiVdzLgdPTyxCfrz
 TVz3TF5iXo+u5IFWkUOwWa+Fa5R+iHPYUAJybT/WqBOiXXO1Jkye94syiWFI+Q3QeLoz
 Jdi4UfzlLY5Nz3Lt0M+JaGdIXj8Sc6MYtp0rh05Yp5+BS9ck2biAggFTZ+8QFEbxfKBj
 DXrLVuDUZXlz9S/5becShDhe9uLu5hgWVGZdQqg9VrQgiuG0gqkBr8C4LkpwWBE56LwF
 0BFQTUVmefg3sP+uoPoKhJDlTMpH7hadOf9aRgDUn3CBerIKECtnCP+7DxMetZ7mE7BS
 gIkQ==
X-Gm-Message-State: AOJu0YwzaUeM4MOo8P39HgS3lBgUPgvLJ6jQ7TPOsUyGF9BBuln2Zx0k
 M+/0O4J12S0iEP4erRhUQJIo/sXlNg/rpemnRydXG90KKAVBXPiXuAU4dfZkJK0guTJ0oOtN8Ld
 Gp6esKDm3xlcYJDXzzK0FyIZTaqpiYFQ=
X-Gm-Gg: AfdE7ck5M2aBWr0HygwpttDzES8BqkKwUApTJWGmdI0ZsTOoFeuFZZ7xYZtbPH7P+2A
 jQav2L6CLi5OxmQ1BPqvqWaIjXR0BqTraNtsx4hnxlQM59cNCJXgUT8lfiodmZ0pOpxmBYMKcWi
 eCLuimYs3dmjnchFSz4cs27Gvgm7fQbV7i6yNmKE5NnXEU6bELJIf+SBA13LZ4RoOsi9yRpIqZO
 BFe+MkUyPnEh/EGMAn+cd15zuA27EeiOh0vkbE3UharS2lvNZAnB0+yM/9Ubq9cOZIb1tgrQVpl
 JKlqRXH29tjQaC8W9zm7
X-Received: by 2002:a05:6512:1443:20b0:5b0:129c:ed85 with SMTP id
 2adb3069b0e04-5b023563c99mr3688294e87.1.1784216257280; Thu, 16 Jul 2026
 08:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260523114128.2468754-1-mattst88@gmail.com>
 <28be5573-2b49-41c9-9d0e-d5077c2ed37d@tls.msk.ru>
In-Reply-To: <28be5573-2b49-41c9-9d0e-d5077c2ed37d@tls.msk.ru>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 16 Jul 2026 11:37:25 -0400
X-Gm-Features: AUfX_mzruxOrQ1thNwTEsczoLOpU-Il7kO6TtQns4uCCRyMKvfcKQ5MXhvGr2Rg
Message-ID: <CAEdQ38FHh3Vi8BKR_rSJ1SkBcA1ML+=g3m0ircZAU4mYeeYH+g@mail.gmail.com>
Subject: Re: [PATCH] linux-user/sh4: add VDSO support for sh4 and sh4eb
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x133.google.com
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

On Thu, Jul 16, 2026 at 4:06=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 5/23/26 14:41, Matt Turner wrote:
> > Provides replacement VDSO with sigreturn trampolines
> > (__kernel_sigreturn, __kernel_rt_sigreturn) and syscall stubs
> > (clock_gettime, clock_gettime64, clock_getres, gettimeofday).
> >
> > Both LE and BE blobs are committed and selected at compile time via
> > TARGET_BIG_ENDIAN. The BE variant requires an sh4eb-unknown-linux-gnu
> > toolchain; sh4-unknown-linux-gnu does not support -mb.
> >
> > CFI register numbers follow GCC's SH_DEBUGGER_REGNO:
> > PR=3D17, GBR=3D18, MACH=3D20, MACL=3D21, FPUL=3D23, FPSCR=3D24, FR0-15=
=3D25-40.
> > ---
> >   linux-user/sh4/Makefile.vdso    |  18 ++++
> >   linux-user/sh4/elfload.c        |  14 ++++
> >   linux-user/sh4/meson.build      |  12 +++
> >   linux-user/sh4/target_elf.h     |   1 +
> >   linux-user/sh4/vdso-asmoffset.h |  45 ++++++++++
> >   linux-user/sh4/vdso-be.so       | Bin 0 -> 2704 bytes
> >   linux-user/sh4/vdso-le.so       | Bin 0 -> 2704 bytes
> >   linux-user/sh4/vdso.S           | 142 +++++++++++++++++++++++++++++++=
+
> >   linux-user/sh4/vdso.ld          |  67 +++++++++++++++
> >   9 files changed, 299 insertions(+)
> >   create mode 100644 linux-user/sh4/Makefile.vdso
> >   create mode 100644 linux-user/sh4/vdso-asmoffset.h
> >   create mode 100755 linux-user/sh4/vdso-be.so
> >   create mode 100755 linux-user/sh4/vdso-le.so
> >   create mode 100644 linux-user/sh4/vdso.S
> >   create mode 100644 linux-user/sh4/vdso.ld
> >
> > diff --git ./linux-user/sh4/Makefile.vdso ./linux-user/sh4/Makefile.vds=
o
> > new file mode 100644
> > index 0000000000..272c5d262d
> > --- /dev/null
> > +++ ./linux-user/sh4/Makefile.vdso
> > @@ -0,0 +1,18 @@
> > +include $(BUILD_DIR)/tests/tcg/sh4-linux-user/config-target.mak
> > +
> > +SUBDIR =3D $(SRC_PATH)/linux-user/sh4
> > +VPATH +=3D $(SUBDIR)
> > +
> > +all: $(SUBDIR)/vdso-le.so $(SUBDIR)/vdso-be.so
> > +
> > +LDFLAGS =3D -nostdlib -shared -Wl,-h,linux-gate.so.1 \
> > +       -Wl,--build-id=3Dsha1 -Wl,--hash-style=3Dboth \
> > +       -Wl,-T,$(SUBDIR)/vdso.ld
> > +
> > +$(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
> > +     $(CC) -o $@ $(LDFLAGS) -ml $<
> > +
> > +CC_BE =3D sh4eb-unknown-linux-gnu-gcc
> > +
> > +$(SUBDIR)/vdso-be.so: vdso.S vdso.ld vdso-asmoffset.h
> > +     $(CC_BE) -o $@ $(LDFLAGS) $<
>
> Where this sh4eb-unknown-linux-gnu-gcc comes from?  For one,
> we don't have it in debian.  Can the same be produced with

I built it locally with Gentoo's crossdev tool.

>   sh4-linux-gnu-gcc -Wl,-EB -Wa,--big
>
> instead?  (Or -gcc -mb, which does not work on debian currenly).

I believe I ran into this as well, which led me to build a cross
toolchain myself. I didn't think to try `-Wl,-EB -Wa,--big`, but if
that works then it could have saved me some time :)

> I can pass this on command like as CC_BE=3D"..".
>
> But I know nothing about sh4, so dunno if this is the right
> thing to do.  It builds, but I don't have any sh4eb binary
> to test against.

I'm not anywhere near an expert in sh4, but it seems that big-endian
sh4 is super niche and uncommon. I wasn't even sure whether I should
bother implementing big-endian support here.

