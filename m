Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EB8E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 01:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKSLx-0002T1-B3; Sun, 08 Dec 2024 20:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benh@kernel.crashing.org>)
 id 1tKSLu-0002Qh-RF
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 20:14:22 -0500
Received: from gate.crashing.org ([63.228.1.57])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@kernel.crashing.org>) id 1tKSLr-0005CX-OW
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 20:14:22 -0500
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4B91CAex000559;
 Sun, 8 Dec 2024 19:12:11 -0600
Message-ID: <f88fb00840ff7a64a8edb620f55c41ac0af4a5cb.camel@kernel.crashing.org>
Subject: Re: [PATCH-for-9.2? v2 1/2] hw/display/vga: Do not reset
 'big_endian_fb' in vga_common_reset()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Date: Mon, 09 Dec 2024 12:12:10 +1100
In-Reply-To: <46kzowk6brtwqrelpplth2l4axeyrqj3n3inzfnwavbtw7ls3c@vdssph2yubx2>
References: <20241129101721.17836-1-philmd@linaro.org>
 <20241129101721.17836-2-philmd@linaro.org>
 <21c5e930-d7ee-4dd8-a238-862f4db87849@linaro.org>
 <2f6a993cd0e12c2bf903440f9f921d7af58bee36.camel@kernel.crashing.org>
 <yqxiqgaazxuvvtx3onfqlndx2t2sa3i7iykufkl56r45iwyusj@xatjov5qiea2>
 <ffac691bd93fee5192b8e91b03171422e5df0a1b.camel@kernel.crashing.org>
 <46kzowk6brtwqrelpplth2l4axeyrqj3n3inzfnwavbtw7ls3c@vdssph2yubx2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=63.228.1.57;
 envelope-from=benh@kernel.crashing.org; helo=gate.crashing.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 2024-12-06 at 10:28 +0100, Gerd Hoffmann wrote:
> >=20
> > OPAL (well skiboot) doesn't display anything anyways (or at least
> > it
> > didn't when I wrote it :-). It just boots Linux as a bootloader. So
> > as
> > long as Linux itself sets the register it should be fine.
>=20
> Oh, mixed up the firmware names, it's SLOF not OPAL.
>=20
> sorry for the confusion,

Looking at SLOF source, it doesn't know about the endian register at
all indeed, it also doesn't put an endian propery in the device-node,
and probably expects the fb to be BE on reboot. Gosh I also wrote that
code... a looong time ago, I had forgotten all about it.

On SPAPR where endian *is* switched, qemu will also switch the endian
of the framebuffer on an explicit mode switch via the H_SET_MODE
hypercall. But afaik that does NOT include a reboot (at least from 10mn
browsing the code).

So I think the patch will have the effect of breaking the framebuffer
in SLOF on reboot when using SPAPR with an LE OS.

Something like this might work around it:

--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1737,6 +1737,9 @@ static void spapr_machine_reset(MachineState *machine=
, ResetType type)
=20
     spapr_clear_pending_events(spapr);
=20
+    /* Switch VGA to big endian */
+    spapr_pci_switch_vga(spapr, true);
+
     /*
      * We place the device tree just below either the top of the RMA,
      * or just below 2GB, whichever is lower, so that it can be

I can't test right now, I might later this week, ping me if you don't
hear from me.

Cheers,
Ben.


