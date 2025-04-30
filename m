Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE76EC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 06:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA0lN-0001Zh-A7; Wed, 30 Apr 2025 02:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1uA0kt-0001PP-SB
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:17:30 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@proxmox.com>)
 id 1uA0kr-0004Dk-9B
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 02:17:15 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9E37E4A9CC;
 Wed, 30 Apr 2025 08:17:03 +0200 (CEST)
Date: Wed, 30 Apr 2025 08:17:02 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Message-ID: <1296247985.8162.1745993823015@webmail.proxmox.com>
In-Reply-To: <CAJ+F1CKhzKaREBBJv30GfPGMqLLZKh2EW2fCcKwUr6GejkiVgQ@mail.gmail.com>
References: <20250428080336.2574852-1-dietmar@proxmox.com>
 <20250428080336.2574852-9-dietmar@proxmox.com>
 <CAJ+F1CJ7=qGN6FiWjK2kQUv8gf_QaFrHDDJCEMOgAkQ_OkuE5A@mail.gmail.com>
 <1225009485.7178.1745842083490@webmail.proxmox.com>
 <CAJ+F1CKhzKaREBBJv30GfPGMqLLZKh2EW2fCcKwUr6GejkiVgQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] h264: stop gstreamer pipeline before destroying,
 cleanup on exit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev75
X-Originating-Client: open-xchange-appsuite
Received-SPF: pass client-ip=94.136.29.106; envelope-from=dietmar@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> On 29.4.2025 07:17 CEST Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.co=
m> wrote:
>=20
> =20
> Hi
>=20
> On Mon, Apr 28, 2025 at 4:08=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.c=
om> wrote:
> >
> > > In file included from /home/elmarco/src/qemu/include/ui/console.h:4,
> > >                  from ../system/runstate.c:54:
> > > /home/elmarco/src/qemu/include/ui/qemu-pixman.h:10:10: fatal error:
> > > pixman.h: No such file or directory
> > >    10 | #include <pixman.h>
> > >       |          ^~~~~~~~~~
> >
> > Just noticed that after updating to latest qemu.
> >
> > The following change fixes the problem, but I an not
> > sure if we can simply depend on pixman there?
>=20
> That shouldn't be a problem. Alternatively, perhaps split the vnc API
> in ui/vnc.h ?

Turned out I just need to move the code to vl.c (we already call vnc_init_f=
unc from there) ...


