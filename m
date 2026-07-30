Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EA3C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpKgx-0004kG-Sn; Thu, 30 Jul 2026 02:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1wpKgv-0004jz-Ra; Thu, 30 Jul 2026 02:56:29 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1wpKgt-0005nY-2E; Thu, 30 Jul 2026 02:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
 Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=vmH6LZYA7dgW3VJ5oU9JRv83yGTz/AQzry5ZWeTKcO8=; t=1785394587;
 x=1785999387; b=GjJBXTCNil7G5gOM+rxfdjFjVRqtmIRTeOuWqxsO03uQXglCyT05nXPTFcGTr
 TqNn+wmTJXIcSBccnfxChuTw84thsE8qaRkMxIC3TM/8+m2cF82suSh7qMPhDClqVTLr+IGd00CkC
 0L5yI5oP20CFOzAfklprOdTEHN3QCYr1op9NWm9chqMXYVdNY+4TGMkEh+U0JeiBW/oZ40TagnDGh
 G3yvdispNh9B4UpbgBcJGzfplGm2DS5Qy24ddLYkSRBSck07IiJZrRbcqmcyRTBiha5yYbuUoOaZX
 /SYIorRZnlLf3ulm0bcnya2ydBr+of07H1UKuVE/A87q9K0emw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.99) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1wpKgl-000000007aw-1hiX; Thu, 30 Jul 2026 08:56:19 +0200
Received: from p5dc558fe.dip0.t-ipconnect.de ([93.197.88.254]
 helo=[192.168.178.61]) by inpost2.zedat.fu-berlin.de (Exim 4.99)
 with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1wpKgl-0000000331E-0oMP; Thu, 30 Jul 2026 08:56:19 +0200
Message-ID: <0ba5e0c4f23d77c9a35be32632fb83a499a05f5c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] linux-user/sh4: allow full 32-bit address space
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Pierrick Bouvier	
 <pierrick.bouvier@oss.qualcomm.com>, Yoshinori Sato
 <yoshinori.sato@nifty.com>,  QEMU Stable <qemu-stable@nongnu.org>
Date: Thu, 30 Jul 2026 08:56:18 +0200
In-Reply-To: <c2c41ecb-db27-420c-94fd-c34135c77c09@tls.msk.ru>
References: <20260727114848.1041856-1-laurent@vivier.eu>
 <c2c41ecb-db27-420c-94fd-c34135c77c09@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 93.197.88.254
X-ZEDAT-Hint: PO
Received-SPF: pass client-ip=130.133.4.66;
 envelope-from=glaubitz@zedat.fu-berlin.de; helo=outpost1.zedat.fu-berlin.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Hi Michael,

On Thu, 2026-07-30 at 09:45 +0300, Michael Tokarev wrote:
> On 7/27/26 14:48, Laurent Vivier wrote:
> > On real SH4 hardware, the address space is split between user mode
> > (U0, 0x00000000-0x7fffffff) and kernel mode (P1-P4, 0x80000000-0xffffff=
ff),
> > so TARGET_VIRT_ADDR_SPACE_BITS was set to 31 for CONFIG_USER_ONLY.
> >=20
> > However, qemu-user does not emulate the MMU, so this limit is not neede=
d.
> > The only effect is to restrict reserved_va to 2 GB, causing OOM failure=
s
> > for memory-intensive builds (e.g. webkit2gtk on Debian sh4 buildds).
> >=20
> > Set TARGET_VIRT_ADDR_SPACE_BITS to 32 unconditionally, like most other
> > 32-bit targets. Also fix the TASK_UNMAPPED_BASE macro to use 1ull inste=
ad
> > of 1u to avoid undefined behavior when shifting by 32.
>=20
> Should I pick this one for the stable series too?  So it will find its
> way to debian too, for example, so sh4 buildd(s) will feel a bit better? =
:)

Yes, please. I have already built local packages with the patch that I am g=
oing
to deploy on the buildds once they have finished building the current queue=
.

If the patch is part of the official package, I don't risk accidentally rem=
oving
the patched package again with a future update.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

