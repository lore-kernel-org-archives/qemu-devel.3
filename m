Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F7EE784BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 04:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYcja-0004O5-Mr; Wed, 24 Dec 2025 23:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vYcHj-0000H2-HF; Wed, 24 Dec 2025 22:45:07 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vYcHh-0002R7-5g; Wed, 24 Dec 2025 22:45:07 -0500
DKIM-Signature: a=rsa-sha256; bh=R5SE7ijkLWVtoR1GyJ0BYJJbbZJ8IL73XPO+lp/c9C0=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1766634301; v=1;
 b=HGHwLfcmJEsCE0y1riVbwZfxAd3dA8pUwN+kG5Ea3TM+rRdQ/vgxdIUDTwTDvCYCHxsCdBul
 uN6zVFw7nxwiqhjbfSkFjDgSvnFH5tFURXXjhWpY3Ig8LjaWGTHpR8DJmxDmlLcxS66jlDpL2n2
 2qr7RY0t0Z/DLqW19tkQ+/S9UtYOFrdcVz43VDH3B7qPOt4KfhyespcMi5rHSt7sYTaSbzDAL8O
 HvjjzCohCN2XykFalwlP1HhuR9NgiYHQDECc4KgDaBEmetceuVt7+w8mwrCZ+wit9m0Sh5GT089
 inPQxwY6+Ivfppv5kcdKAww92FYc2v9a4hkiQ+HXybP5g==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id EBD6224690;
 Thu, 25 Dec 2025 03:45:00 +0000 (UTC)
From: ~emckean <emckean@git.sr.ht>
Date: Wed, 24 Dec 2025 22:28:18 -0500
Subject: [PATCH qemu] hw/arm/max78000: Fix num-irq to match hardware
 specification
Message-ID: <176663430090.23028.16926971585326050904-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Dec 2025 23:13:52 -0500
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
Reply-To: ~emckean <emckean@protonmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ethan McKean <emckean@protonmail.com>

The MAX78000 user guide Section 5.2 and Table 5-1 specify 119 interrupt
entries. The previous value of 120 was based on a misreading of the
table which spans three pages, with entries 0-104 on pages 102-103 and
the remaining entries 105-118 on page 104.

Signed-off-by: Ethan McKean <emckean@protonmail.com>
---
 hw/arm/max78000_soc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 7f1856f5ba..1e2f66428d 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -88,13 +88,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Err=
or **errp)
=20
     armv7m =3D DEVICE(&s->armv7m);
=20
-    /*
-     * The MAX78000 user guide's Interrupt Vector Table section
-     * suggests that there are 120 IRQs in the text, while only listing
-     * 104 in table 5-1. Implement the more generous of the two.
-     * This has not been tested in hardware.
-     */
-    qdev_prop_set_uint32(armv7m, "num-irq", 120);
+    qdev_prop_set_uint32(armv7m, "num-irq", 119);
     qdev_prop_set_uint8(armv7m, "num-prio-bits", 3);
     qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
--=20
2.49.1

