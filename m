Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B67C5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 20:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMCA9-0005Py-CA; Mon, 02 Jun 2025 16:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uMCA5-0005Ph-SX
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 16:53:38 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uMCA3-0002WC-4F
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 16:53:37 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4a433f52485so141911cf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1748897613; x=1749502413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzdQblTmOzDV0GvtTYDmqvbc/h2In3nd8NJXMT5P42k=;
 b=cCXM20PK8CcWx07S5xk/lJAM3ZbF8wRVGhWY6GN/I295lglGPB4gUaWI0OPfzK6KAn
 Rdv6btSZgTicC8rZpTfd0e4s3zXUMEjY9q33BvUBXC6Rs9J2c9DuvfPbbJo4Bj1+1HdV
 lWtFll9cAKhFDcSH1HKcM4PLaRsHh7/93rltxA00eHQOAQ7WmQrdUB7LzalCDt8WJedw
 +aRM24gWoyQkIE1C/w4MjtgSpEF5KBMZrC9uuxC6FkalFmUV7PJdhiolH6ujAVx/Mg9d
 iYPDtp6xdErI0fLDOu5om74RPv37FHYqkD+bMtWfqQ/a+oroMAjRU90X616z+dl3u8or
 7G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748897613; x=1749502413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzdQblTmOzDV0GvtTYDmqvbc/h2In3nd8NJXMT5P42k=;
 b=FlCt9/Sx6ogRv8zUGI0M9s/KLpuX8ULei5g+UhVdNDLeCCYb6g90t+wweWvOub+cfl
 svN3WkjHAOn+C3QwgbBBAE16wf85/M3PxDZKdo3FqHb1MDbtMmZYFWZcD4jZ4Z4aSozU
 iq3dW/ail7lvO9BVfPm07+KR6OoS3c04OPv3kwwSXrMS+SmPLwW2/sypXNdoOqvuSxY4
 U3zCTB1bnljN2nCbaJziv7UmUGHARKkWIkEq2a7sN2id2xi8PpX5zP6FKpKebNnwjsdK
 1SFznYZOpqFUA9yrOBfGlSv6LixTb6JccHOZ6vRohsEMXFKA5NPXwylTnvlgzgjv6rZQ
 tzgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURf+J/WFTEh6fWvdMRLdy1SPEoUKO/lYEOOM4v5+4W4+natqTrs+jU+OvdTR3two0EtJwO/U1jQLY4@nongnu.org
X-Gm-Message-State: AOJu0YzvDxgzZLW0oW6hq8awygzwPjmDB4uvVzU/cRmI3aQJBnI5sDBX
 xtnFiHc4o6EAVavrrk1YSB2K+INyAgJB/wjqmO332qTgelFyb7pH1LIesFy4vRl176+YKhW2K/P
 /7069lC8YWqJDGcOSurIlz9UErLs0VAS+ZgA/aqNO
X-Gm-Gg: ASbGnctSccdiF9qcizZ8PiptpfmsO/pbAfGfTQB26VVHbPqENuhrpvWGDCpyemRGLuU
 GrLfjT2SqwGsGEXIiwOnulGSGTiI8xvSjSpbKohJ5Dbp4jdh5d/r9eihiwUDJcqu0YPIMHWcAyK
 7srBmhbkWdQMDFp7TVYsMDwBkLdDF0DqniKKycm+ID6BcvrGuoFp83CvXjsvQXAd/HifC9CZnz
X-Google-Smtp-Source: AGHT+IH3lOd70wNTOsruS0/ikOM/qDqFQBg7jtOd5p+og5/ARksi+HAuerNxHFyIdxmLUGMbmVmx//9NK60nuyixZGw=
X-Received: by 2002:a05:622a:558e:b0:494:58a3:d3d3 with SMTP id
 d75a77b69052e-4a599bf2d65mr870401cf.20.1748897612776; Mon, 02 Jun 2025
 13:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-3-pbonzini@redhat.com>
 <153c342a-428a-4620-bf91-52ebb4507b97@redhat.com>
 <b7e988ef-82da-43bc-8c57-3b49b3bf9529@linaro.org>
In-Reply-To: <b7e988ef-82da-43bc-8c57-3b49b3bf9529@linaro.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 2 Jun 2025 13:53:21 -0700
X-Gm-Features: AX0GCFuGobfd4jp3RNALPyISDV5esXIiELGRLBSkYExjsMPmeGibcMC1-HIAWdw
Message-ID: <CA+QoejVhjy26FraUUMRtZtNPRW6u2MM3T=6hyguttPgx8qpkpw@mail.gmail.com>
Subject: Re: [PULL 02/77] hw/arm: remove explicit dependencies listed
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -176
X-Spam_score: -17.7
X-Spam_bar: -----------------
X-Spam_report: (-17.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Pierrick,

For what it's worth, those files were also breaking on Ubuntu and Debian fo=
r me.
I had to explicitly `sudo apt install libfdt-dev` for it to work
again. I don't believe
it was installed at all previously, but QEMU was building and working corre=
ctly
without it being explicitly installed.

Thanks,
Nabih

Nabih Estefan (he/him) |  Software Engineer |
nabihestefan@google.com |  857-308-9574



On Mon, Jun 2, 2025 at 11:41=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Hi C=C3=A9dric,
>
> On 6/2/25 6:59 AM, C=C3=A9dric Le Goater wrote:
> > Hello Pierrick,
> >
> > On 5/30/25 09:11, Paolo Bonzini wrote:
> >> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Link: https://lore.kernel.org/r/20250521223414.248276-3-pierrick.bouvi=
er@linaro.org
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>    hw/arm/meson.build | 4 ++--
> >>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> >> index 5098795f61d..d90be8f4c94 100644
> >> --- a/hw/arm/meson.build
> >> +++ b/hw/arm/meson.build
> >> @@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: fi=
les('highbank.c'))
> >>    arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integr=
atorcp.c'))
> >>    arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit=
.c'))
> >>    arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
> >> -arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('m=
usicpal.c')])
> >> +arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [files('musicpal.=
c')])
> >>    arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('net=
duinoplus2.c'))
> >>    arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files(=
'olimex-stm32-h405.c'))
> >>    arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c=
', 'npcm7xx_boards.c'))
> >> @@ -79,7 +79,7 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files=
('omap_sx1.c'))
> >>    arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versati=
lepb.c'))
> >>    arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress=
.c'))
> >>
> >> -arm_common_ss.add(fdt, files('boot.c'))
> >> +arm_common_ss.add(files('boot.c'))
> >>
> >>    hw_arch +=3D {'arm': arm_ss}
> >>    hw_common_arch +=3D {'arm': arm_common_ss}
> >
> > This commit breaks building these files on Windows:
> >
> >       hw/arm/{boot.c,vexpress.c,imx8mp-evk.c,raspi4b.c}
> >
> > Error is :
> >
> >       fatal error: libfdt.h: No such file or directory
> >
> > Thanks,
> >
>
> Is libfdt available in your windows environment? If yes, is it in a non
> standard path?
> On my side, it built successfully, so I first need to reproduce this.
>
> Thanks,
> Pierrick
>

