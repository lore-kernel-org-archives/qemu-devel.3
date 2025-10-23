Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345CDCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBueb-00020C-Rs; Thu, 23 Oct 2025 08:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBueX-0001ml-R0
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:42:50 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBueU-0001am-R3
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:42:49 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4e2d2d764a3so6385081cf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761223361; x=1761828161; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rofAI/4qWf5zCtx5Cnfa2mUjU5mb96zHd5mznPItKGo=;
 b=cT1RzsKj8JDXmWrHwZ+HtZuULpqOnMFcMH3Vjz8RqJ9JVOUkjmMpDOBA5jZirkfT2D
 C0XyRrTIViwLBtQiOjZV5sjaU/LVSmlvTmr0/kHzjp+x8hJ1HA7RdA+JpNPo2RT/3PUx
 mv10EYhJyD8SRy6iIqWgoIgUp69gWxbpEvrJAisBE+0cuoiF+z5++ZIoI6m1SynmJl19
 ghMV5qJihyMu+q32XaIJYX6ZQm895LDTQCe5FKiC5BtmVdP9AGoRS0AjyJ9DVvw1beSu
 UPpFXBkVNTniBiMs7svC0kcTSfKZNqXszS++mCzxRha+V+vV+TeWX4A68XwVgJYvb23X
 YLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761223361; x=1761828161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rofAI/4qWf5zCtx5Cnfa2mUjU5mb96zHd5mznPItKGo=;
 b=DyBZxJd1oWYnix5LptF/DM9VxJHlVLEC83ZwUqKMx/mqr0v1hpG46iE/7mGEPWRBFW
 XMEasd1DqQycGkFn+c9n5eshnycbeqRH7U+kYpHZ26dZ/dc+dIdGhRlsXiL/qMHG8g5w
 Pi1dVgMhXUFa/WDx8aFF6gHYz75EsSzcsU3xuClccuazw4XIYaZ5Ie53Er3CgJWPTQCQ
 afZ9DbDT6yw/W+/Si8fsesEvWc9EoOOveaz2Lip+bxk9EO5qFgi1MW66lc2Pj0ceax1Z
 Cly4iYwA34akmxPZoiEwIThD8Gn6W0x8T0URFNMIDUdRQEZw6O8lDyNWdY7SvP1uecBd
 1UFg==
X-Gm-Message-State: AOJu0Yw9HDmiaxWw/Qhu2qkmUyODB2Wl9yBxITBWQiPv4xWbPG5sudc0
 /2uG8Rm5eMMiIcMWPLd+83KjMABEN9pyHYRV1GXhFC2IVjH4UR6BrLGy9HEs4A/Hp2HpIRed4MX
 CJHgby+flYAordBMVj4d4rEi9OkLrcLI=
X-Gm-Gg: ASbGnctVrhXsaIlDSvGjOd7+cHGzZCGCoLi6CFe4S8AH8Y9iYheSKPHIafFNBdXoKWg
 X9NHezVBKjfqj8OwiRiZCy0J3hpVqPEEkmTRzJ2dRKyfEBVQDksTpuf61HI29iUcyKWuDR2DAX9
 87GpXaR3o0a4mM4zO1iqSGX0GtXKwyA5tqvQyUNp5/vZ5LeGlv8q089S0Z1Eo2B/BIB9S7j4PF6
 Yw2yVlblvKzGmaR4OTnarghm+YnOAV5COYuLvmfUv4XOe/uDX/6EgKPIpfxXHDOBlrIMOFU8kN4
 8rWgThfFjiGAnrlXnROaa0cEiArqeOShJJZeiw==
X-Google-Smtp-Source: AGHT+IFGHsXepv1T1F851b5vyo6zfi7aBdM4llwPG2/J9+RJg2iacAWCYyeF5nh69wLx7zG6rJXqXdTR1qlbANihI44=
X-Received: by 2002:a05:622a:1813:b0:4b7:95da:b3c7 with SMTP id
 d75a77b69052e-4eb8153dba4mr25501651cf.48.1761223361297; Thu, 23 Oct 2025
 05:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <56a2ea44-7633-4858-8b04-def663322af0@nutanix.com>
In-Reply-To: <56a2ea44-7633-4858-8b04-def663322af0@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Oct 2025 16:42:29 +0400
X-Gm-Features: AS18NWAhXgb3RUU5P83lzrmYAM8urOFhyT1GX041H970e-FPiUUzV8ON7DWdZY0
Message-ID: <CAJ+F1CLLdJiCrn6o+gGSMUN4mc4d2AohveT=2gSM5FtwZL=-TQ@mail.gmail.com>
Subject: Re: The impact of vdagent migration support patches on windows SPICE
 agent
To: Lucas Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

Hi

On Thu, Oct 23, 2025 at 3:29=E2=80=AFPM Lucas Kornicki
<lucas.kornicki@nutanix.com> wrote:
>
> Hello,
>
> I've found that using -chardev qemu-vdagent with a windows 11 guest
> and win32/vd_agent
> (https://gitlab.freedesktop.org/spice/win32/vd_agent), results in
> non-functioning copy paste.
>
> Further investigation reveals that messages such as clipboard-grab are
> being sent from qemu, but they do not reach the guest agent because the
> VirtIOSerialPort has been closed from the host side
> (host_connected=3Dfalse). This is likely a result of the CHR_EVENT_CLOSED
> event call done by vdagent_clipboard_reset_serial, which appears to be a
> deliberate measure to force a guest reconnect (?).
>
> This has only become a problem with the introduction of commit
> f626116f9897b95f68e5514a08098d590349c22e (factor out clipboard peer
> registration), as it has changed the execution flow by moving the notify
> =3D=3D NULL, check inside the peer registration function
>
> -    if (have_clipboard(vd) && vd->cbpeer.notifier.notify =3D=3D NULL) {
> +    if (have_clipboard(vd)) {
>           qemu_clipboard_reset_serial();
> -
> -        vd->cbpeer.name =3D "vdagent";
> -        vd->cbpeer.notifier.notify =3D vdagent_clipboard_notify;
> -        vd->cbpeer.request =3D vdagent_clipboard_request;
> -        qemu_clipboard_peer_register(&vd->cbpeer);
> +        vdagent_clipboard_peer_register(vd);
>       }
>
> This change has created a new execution path that makes it possible for
> vdagent to "self invoke" the vdagent_clipboard_reset_serial if it
> receives caps from guest twice, which wasn't possible previously due to
> the notify =3D=3D NULL check. It just so happens that win32/vd_agent does=
n't
> handle the disconnect too well, while also enacting this exact scenario
> by first sending a CAPS request of it's own, and then replying to the
> CAPS request of qemu, leading to device closure.
>
> Was it the original intention of commit
> f626116f9897b95f68e5514a08098d590349c22e to enable such behavior?

That regression is unintentional.

Is it enough to change:
-    if (have_clipboard(vd)) {
+    if (have_clipboard(vd) && vd->cbpeer.notifier.notify =3D=3D NULL) {

to revert the behaviour? Are you working on a fix?

thanks a lot for the report!


--=20
Marc-Andr=C3=A9 Lureau

