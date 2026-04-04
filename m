Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2653D73094
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 15:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w92Zs-0008Lc-C3; Sat, 04 Apr 2026 11:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w92Zr-0008LE-2C
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 11:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w92Zo-0000AL-LF
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 11:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775315179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LfCJ2OXVz3/DRbZF8aGQaeBQp92M2qw2t5GANaDaGc=;
 b=FoY+RPhA2lAAH5GaB6r16ec/HZY/7ScPGuZi7poPpcmby+8hhMnGu1DZBMfwvhWy+M26LT
 fjs7GJgqoIWqlYi4y+M3t7ESkRH8M98Y6YxnKNAbkvRo+INz+QLv/JbUKNqJVoxiIcMp7W
 fymu1Kf6ETQpZsD695B006cK89A2FIw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-x4WgC8hbOB-BElocot93hg-1; Sat, 04 Apr 2026 11:06:17 -0400
X-MC-Unique: x4WgC8hbOB-BElocot93hg-1
X-Mimecast-MFC-AGG-ID: x4WgC8hbOB-BElocot93hg_1775315176
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b62da7602a0so1512993a12.2
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 08:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775315176; cv=none;
 d=google.com; s=arc-20240605;
 b=gDIgkvoMaBnwyZV3g+YknRcg+hssv4RFGbmxzxvyWfV+DDntlN86s69YwvAJM5yz87
 JQceyHO1soznLQOxsvQDIIPijr1j/dRsO5ypqbN6Sl6AmH1lPyNFaUuEipsjNhbj8rE/
 Wgn3xnaDGde0T9XtGLo7YTQKOtA9QpVrcKeYR+Lf2bFtfxviw2p4zLYvhen+9ZRauY5z
 9+AcecM1pfZNzfDEW5gE0DvmiULrd0O2p8/CfbeZoE5JhC1bOble56DKu+fxF8wSsXuZ
 J57cNA0hGlupvGy23WbkCFIQT8YQ2SYH+09zHkww+n3iOnZ7srRH9qaTRcYJ/jdQWuBG
 KShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5LfCJ2OXVz3/DRbZF8aGQaeBQp92M2qw2t5GANaDaGc=;
 fh=1AedghrWfmWpwJgSv40d1VSkXxo09sTYmGNkJXFOGS0=;
 b=hH4RTzfTY21iMl+SWqszrCxkDWXCB6ZQXlSYtZKAKDHEN8dB4EA26r/lWJE202XwK8
 y234J8WCRZMJAfK3yzcsiuQtFE19laOq7bLYKieYUjzeV+asgtWxEkcumeY3WrOJtxn+
 fnZiL5X+fjD/zW8teL+20u5WyxV9IbpW5D13tE4bJEH4aIRDSzgrn2sNnuXeQcY8w2/y
 r8m8SmbgPWGkwJw9SBj/jp6Q5O5gnTEheeJBfXNzxFN4DhcaTu2uctpvr8nL+FdGyDdb
 dT7fUbgN1QgL2ophSuzo7Y99VLQnsiCGyUIwcSNZvgc+DFNMjzrZqUPBgPXZDtOVahoW
 7iig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775315176; x=1775919976; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LfCJ2OXVz3/DRbZF8aGQaeBQp92M2qw2t5GANaDaGc=;
 b=jXpjDx/2eUXOcr1MdBSYi2gMfBc2vXSOJKq8Ea4KRorjVAEqc7b/7khUwFvKCEnn3j
 M5+FUcL03bTRrZT+6QnuGSV31hcyUtUWvttCPS4LURrmg1e2GJr3eCTR51pZDQUHhFyA
 VDMvXX/0eWbJ/sEH2j9sUV6K81LbWpSrkDEABEb9CQ7Spj7+CV7Tw08+WkiTDD8V7ldU
 h8aB9XE4vdyu7AUdP0YeBMgMXPgIb2iKvAeLNUz7IY5SuJZ6pi99tcSKSbUHMsNOpnDg
 pCocF3Cgxj86RdDVWTW7MOJ85NkZMvxRIKCMPogUzuIxh3yfa9IMz9I2ibE+cW8tCpU0
 Wjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775315176; x=1775919976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5LfCJ2OXVz3/DRbZF8aGQaeBQp92M2qw2t5GANaDaGc=;
 b=fITqFhu+hkLXBWJxrk8JtRmu7r0Q7XymLQWTxKffM9IWep6mW8MCCdXKZL4wv+S6De
 IfM0xQ50STfmznP4pThKeuYhbyD9GYxRdZLEnEuS9iPKpU/2x5NZx3d+jzg94w+LIiU4
 3laGU2cdzZQnsgsQ2tNuQ4Xctx1ugT2bh1Xyh/MpIuYWQ/lX57+rNi8ZuKiByYjOskCm
 WrtqILi3io2oJGwtC0HBKRlAiWeU4EOPtUYEdmoIjWmDrMrllyFil1DRKowJSKYLDwj2
 viempK6mVnmCsSjqmz8GdplxHGNuIh/lUeyixrRIVrI1Q0ptHRC1TekxIphPaxPhbokj
 eFAg==
X-Gm-Message-State: AOJu0YxsjSWhj7rORBo4gQQms8BLsQfCo1wah3ftCiXFTDYWYfN0fmWR
 bN/IaWxLBOBr80kf8/VVEh8MbuFJVT3vflpU5LftB7S/EANh4Z3sjqE/scJ8FZ4P4i+1RLHiQQ9
 VUbU8CNN6MpovYrSreU3jDYQQZJ9hiVRpEpqcIZvbtGzlUBBxZu9xPLIcO8Ufb0baYn1uf5lBzU
 dn5mfLkwvw+COr5+Dx8Z/TzDkEwymhtWu4blEGfkE=
X-Gm-Gg: AeBDieufO9bM8/vVPosGKrgm5CMcVfNLsnFPUUNFD3SVm+sulZ+YthZBeckRg41tgDU
 U682qy4wH/Gxp55ljvkkr/W4P/UXEW8533ONwzQJXB6ZI664EJhxpWBBnvISQHL3RXSz8leqMVi
 J2eXA16zkE5m8ER6k5CXBKPLc9YYwlNR5AW4Aizrf3lqfydF4nJgw+F4FVqYirBnL0osr1dlAEL
 VFltpDgoY4guV3cQSXK2CJ7hVR2fNm7qGhekKLxFHWeL8Tcp9w8bGwsgtkT7insUCLvHRqaD8N2
 XSKHlHVTULexFHZKdv5cwdQ=
X-Received: by 2002:a05:6a20:a11a:b0:398:c170:1c7 with SMTP id
 adf61e73a8af0-39f2f12b4f9mr6716910637.26.1775315176183; 
 Sat, 04 Apr 2026 08:06:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11a:b0:398:c170:1c7 with SMTP id
 adf61e73a8af0-39f2f12b4f9mr6716883637.26.1775315175690; Sat, 04 Apr 2026
 08:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-54-48eb1dcf7b76@redhat.com>
 <58fd247c-d4e7-cc42-de42-bd4333574439@eik.bme.hu>
In-Reply-To: <58fd247c-d4e7-cc42-de42-bd4333574439@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 4 Apr 2026 19:06:04 +0400
X-Gm-Features: AQROBzB8vTFEcfGDnF7e7sZGM7wrvWSLIjhFrCykoUR5SvRmFiAm3eztm3xwASA
Message-ID: <CAMxuvaxgrv0=4r+5Ark6A8qDJiYhL7NMR+HLebiFJWCiBT-z+g@mail.gmail.com>
Subject: Re: [PATCH 54/60] ui/console: rename public API to use consistent
 qemu_console_ prefix
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Tue, Mar 17, 2026 at 3:46=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 17 Mar 2026, Marc-Andr=C3=A9 Lureau wrote:
> > Rename the display and graphic console public functions to follow a
> > consistent qemu_console_ (or qemu_graphic_console_) naming convention.
> >
> > The previous API used a mix of prefixes: dpy_, graphic_hw_,
> > graphic_console_, console_has_, and update_displaychangelistener().
> > Unify them under a common qemu_console_ namespace for better
> > discoverability and consistency.
> >
> > The main renames are:
> > - dpy_gfx_*() / dpy_text_*() / dpy_gl_*() =E2=86=92 qemu_console_*()
> > - dpy_{get,set}_ui_info() =E2=86=92 qemu_console_{get,set}_ui_info()
> > - graphic_hw_*() =E2=86=92 qemu_console_hw_*()
> > - graphic_console_*() =E2=86=92 qemu_graphic_console_*()
> > - console_has_gl() =E2=86=92 qemu_console_has_gl()
> > - update_displaychangelistener() =E2=86=92 qemu_console_listener_set_re=
fresh()
>
> Is the qemu_ prefix really needed here or if so would something shorter
> like qcon_ do instead of qemu_console_? With short line limits long names
> cause a lot of line wraps. I think just console_ as already used by some
> of these already would do and be less churn but no strong opinion on any
> of these.

It helps if the structure and its associated functions share the same prefi=
x.

Iow, QemuConsole with qemu_console_foo() associated functions.

If we renamed QemuConsole to QCon, we would lose readability.

So yeah, longer lines, but an IDE can fill it for you and reflow the code.


