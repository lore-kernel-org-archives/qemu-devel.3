Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A06C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVGDq-0006XW-NX; Sat, 20 Jul 2024 15:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sVG95-0000Go-Vg
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:53:31 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1sVG93-000819-Sd
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:53:31 -0400
DKIM-Signature: a=rsa-sha256; bh=+5JdK00zmNyzGMlf9mULX4eNuF0EYZaLNA+KHhfeNvY=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1721505206; v=1;
 b=qAc2zz+df9wEeA8yFfIbvYpqjduGP7ST117xw0xJ9gTr9mgPJy/UZd6nIqBh9YS8iQUD/t9z
 5WS3jhksHvPYJkOWY0L2bMz7dg9l+UIBZT9sZPrerT81XFKzuRLujFOx1tFmm69T6Y9pYvFWedK
 bQvSaHuudsYHN5yFCqypIVAohtX/+TbcePj5bA49Q9JKBk9uNDJ1BguWK8oucUSeZ/NrrV1me42
 Y1FrJVh8bzm3Wb+d1JCtGG4my+wSHxDcnS2LC+NhusQ6jxCVQlpfvWMk253Riuc/S/SAh8G5ohE
 84CyU6jr2zHcFfGA22qrB8fMBVd5KQxXuo/BCD7dNfkxQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id AA39E201F1;
 Sat, 20 Jul 2024 19:53:26 +0000 (UTC)
From: ~katharine_chui <katharine_chui@git.sr.ht>
Date: Sat, 20 Jul 2024 20:14:20 +0200
Subject: [PATCH qemu] ui/gtk: Reuse input event slots for GdkEventTouch
Message-ID: <172150520664.2040.13953223569736513482-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 20 Jul 2024 15:58:24 -0400
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
Reply-To: ~katharine_chui <kwchuiaa@connect.ust.hk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Katharine Chui <kwchuiaa@connect.ust.hk>

There seems to be no guarantee as to how GdkEventTouch.sequence
would progress https://docs.gtk.org/gdk3/struct.EventTouch.html

In the case of steam gamescope session, touch input would
increment the number every touch, resulting in all touch inputs
after the 10th touch to get dropped

...
qemu: warning: Unexpected touch slot number:  10 >=3D 10
qemu: warning: Unexpected touch slot number:  11 >=3D 10
qemu: warning: Unexpected touch slot number:  12 >=3D 10
qemu: warning: Unexpected touch slot number:  13 >=3D 10
qemu: warning: Unexpected touch slot number:  14 >=3D 10
...

Reuse the slots on gtk to avoid that

Signed-off-by: Katharine Chui <kwchuiaa@connect.ust.hk>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index bc29f7a1b4..b123c9616d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1090,7 +1090,7 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEv=
entTouch *touch,
                                void *opaque)
 {
     VirtualConsole *vc =3D opaque;
-    uint64_t num_slot =3D GPOINTER_TO_UINT(touch->sequence);
+    uint64_t num_slot =3D GPOINTER_TO_UINT(touch->sequence) % INPUT_EVENT_SL=
OTS_MAX;
     int type =3D -1;
=20
     switch (touch->type) {
--=20
2.43.4

