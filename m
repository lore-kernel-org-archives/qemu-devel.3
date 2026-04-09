Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5C5F364B6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAwUH-0003dk-HI; Thu, 09 Apr 2026 17:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wAwUD-0003cz-Cl
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:00:27 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wAwUB-0003kG-5z
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:00:25 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-951a4e8d1b5so379497241.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 14:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775768421; cv=none;
 d=google.com; s=arc-20240605;
 b=joc2bzhsYfobYCJ65NMJcmoayOltSOYmOBYVZqDifmuS/AWmZVlxzKBF/qON3J36by
 7btZ6Duz6RlRpi9H3V8QjTi50sly1tSbdcp4uma1wa3YIXG9fZusHE8TjkE3f8Xo85wS
 MxzuVsGUg2cx3Gymb02dnkPYoHuBPiVnypVYa0oIz/KzDBbb5/N4Cn9nQpge9pavBvuG
 5FDLo/CM7t6oinnFHZzuReuaSE0U1bZYMc1iRAshLH4y7U0B0JYjgmZU0dFgIZ32UzAn
 FQzsZd5zIwaV0AHPq9rSxZ3hdc5aHaA+IVQjTcZOKimTCCHZ2kvLBVafmnxMMRCiJ00w
 rDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uBcqEMShb2pCBQGj/7zGpFmCDx6PjKYsootyagL8btc=;
 fh=6WPaczp89kVEvyqQhTtoSourPaOeS62pIBkgOKSIhVk=;
 b=cq9GbBYzXtuHNHUbanKHPD0muUIHBXcJXDlZ72pTEbZiRATlw4IVuGHY6udGR+kGaQ
 ykEuoLhw5zs4r6hTeLg2TZYCnKXsXO/iKmHpU9SzhnMMqARF7FJMcxueWngxq4gOb4zP
 bOCdcCVWr7fm6v6oUY3vOPkAEUwyvJbgic1XwHPg9mwQf9PPhymHDcN7A08oAyRDAc7J
 rp4hxbAHa3G2SpqEYYtuZgP8hz9heGt2kNP7QTSYuDOPNMUckXvMMHb7+YDG23vXMpkM
 OMJlhO5FG5hpBWhfkfIa4FT9UuHgvyg+S+C6sPQ3vDnYYNxc0T8VssHEF3vAvglCFKgw
 6kIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775768421; x=1776373221; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBcqEMShb2pCBQGj/7zGpFmCDx6PjKYsootyagL8btc=;
 b=q1pqz+Fb0i573BUNagLxu3Ka2U1DksuUTGNIrWStuSrn99Bz9eavbxhjbJ4fYgPHkP
 zuyBf0oCGTqT5dYRyySzeysBPocb88TebYbPIkHWjDPVWH8bYewm3FfBn0uLpjmaHg9j
 9rBn3Nop/mkVNiQq6nag8Z94RDB6MMfPCl6l2VakQ+B0HC7viC0oCdSLGzoGV5mdhHWW
 +BVnflw0+90wMD8yFgEaJICENGDW+sJX09+AOIukM1mg4V5JvoyBBL8PxM0LPZKgSvli
 SmzW87HQ66C+B6Hit4LlcP7h/fZEkb5n6zl6pJCUg/6ECpTS+DpSm3D75Ncy2lD0nbPF
 C+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775768421; x=1776373221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uBcqEMShb2pCBQGj/7zGpFmCDx6PjKYsootyagL8btc=;
 b=qz6qDqs8IW9+mBhjOjZkr5q+RxwgbeMwGb6krHVWWqTAWQkJi/yA0CCgGi04I1gx1P
 HP1IHqkkz8In15vOeea2QhZTV7fZkIilSFDLaLG/cSVib6m3JqdekWV/XMP51+wFLDXA
 dlFK+zjR9wmNYwRaCqcFDgUW1/DUW6mpnHWpoBpJ197m5XcC4XtaNUS7HMuh25xZwrtW
 tVVvSa9yZ4a4EhuHJqp0iKKRk7KjMZ85i3sVTh542uNbG2YbrXMK2630A2vGxYq4uozs
 Xk5sk/yL5kLJn51Ehszn2yyybi8SdS2402qw5+ce5YayjdY7vZ4sioyzciWtKUluwEfa
 2jWQ==
X-Gm-Message-State: AOJu0YzENBaKajusG0pl96ezy3u7meClpFW2sI2T/sw9dEPpRWbyfakZ
 E1BZibuA2VSwwxl7aZ/gQgDTFEnmMCXqh45Q07NQtjEfEDCN6adKP+C+mOkagoV+Kt/wg3rPyqL
 jMiBxpewK/jEkqVRQ9X14Z1udbYJQCSw=
X-Gm-Gg: AeBDieuRmgFSsiH1usRNU8j1V30zyMiudlVUZrhQXplHpez/OKTy+03d6JLoe1hzQQO
 8lb8VE/e/8c/yVvPho7s3L9e9JLImnoK6xrIIOxq6qOAUFg62hONGyFt0AiHBGzs2PizKvM/WoR
 NBS6nikv1/WPzlgvs9OewqPU46vfa+4rSYp/SxprpHHF/it3lkw+fwjkk/tfGicDSezkjItTSjJ
 1diqOEshjGL9QP5ErM79Dbu8wSN7ND8C28EDaNMmx3mYNcYJMawthdD8dVA8Z6OUJFkI95eTRUW
 Jl89Ra3KQnztNXLMK2aR+EkAOXE6nDxqJM2Ue0xOM0ay7M0kPkIro3A2is+FS4awIJ35Og==
X-Received: by 2002:a05:6102:c46:b0:5f5:4055:4556 with SMTP id
 ada2fe7eead31-609fe7a6cc1mr282046137.4.1775768420833; Thu, 09 Apr 2026
 14:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260408184228.44242-1-james.hilliard1@gmail.com>
 <CAFEAcA_Jt3SmuTiLWxuVQuktAG=M5C-Ux7OYKcGwPUBSETegew@mail.gmail.com>
 <CADvTj4rMoQi-ic=q=TJ5Dz6_GhHhR=JNhMoRhfKCFAuZzhUpzw@mail.gmail.com>
 <CAFEAcA_JPnWh22zhb+ajr76oKtFRoCZSZpsVW51m08eWrMZS5w@mail.gmail.com>
In-Reply-To: <CAFEAcA_JPnWh22zhb+ajr76oKtFRoCZSZpsVW51m08eWrMZS5w@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 9 Apr 2026 15:00:09 -0600
X-Gm-Features: AQROBzBLf2oPNiezj7TWcx30qCbRg-QJLt-c-PeaFo2ZCkhZav4PwOz43PNFsiM
Message-ID: <CADvTj4qUY6=b56LeHb+fZBEdvFPPR9dMFkYEjNhtN=BipOaEog@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mips: keep k0 in sync with CP0_UserLocal
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ua1-x92d.google.com
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

On Thu, Apr 9, 2026 at 2:17=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 9 Apr 2026 at 20:47, James Hilliard <james.hilliard1@gmail.com> w=
rote:
> >
> > On Thu, Apr 9, 2026 at 10:17=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > On Wed, 8 Apr 2026 at 19:43, James Hilliard <james.hilliard1@gmail.co=
m> wrote:
> > > >
> > > > MIPS glibc startup expects the thread pointer to be live in both
> > > > CP0_UserLocal and k0. linux-user already updates CP0_UserLocal for
> > > > cpu_set_tls() and TARGET_NR_set_thread_area, but it leaves gpr[26]
> > > > unchanged.
> > > >
> > > > A guest can therefore successfully execute set_thread_area() and st=
ill
> > > > reach __pthread_initialize_minimal() with k0 =3D=3D 0, faulting on =
the
> > > > first TLS-relative store.
> > > >
> > > > Make cpu_set_tls() synchronize k0 with CP0_UserLocal, and route the
> > > > MIPS set_thread_area syscall through cpu_set_tls() so all guest TLS
> > > > updates follow the same path.
> > >
> > > Where does the kernel do this? Looking at the mips set_thread_area()
> > > https://elixir.bootlin.com/linux/v6.19.11/source/arch/mips/kernel/sys=
call.c#L87
> > > it looks like it sets CP0_UserLocal plus the tp_value field in the
> > > thread_info struct; and I can't immediately see anywhere where it
> > > would read either CP0_UserLocal or tp_value and put it into k0.
> >
> > So this seems to be something used by the vendor SDK for Octeon1
> > but not Octeon2 and Octeon3 targets, kinda strange/annoying.
> >
> > I also found this:
> > https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02026.html
>
> Ah, nice find.
>
> > It's in the Octeon vendor kernel here looks like:
> > https://github.com/MarvellEmbeddedProcessors/Octeon-Linux-kernel-4.14/b=
lob/5c48e5031fbd86361e8185f6c530ffcfa5c9a60d/arch/mips/kernel/syscall.c#L94=
-L96
>
> Mmm. We emulate the upstream kernel, not vendor forks, so
> we wouldn't want to set k0 here I think.

Yeah, I was trying to see if there was some sort of way to trivially
identify binaries that require this k0 support and autoenable a quirk
but I didn't find anything, maybe it would make sense to have a
separate runtime target for enabling this k0 quirk since it seems a
lot of octeon binaries require it?

>
> -- PMM

