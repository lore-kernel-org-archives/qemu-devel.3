Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0755CE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLbz-0007IB-2e; Sun, 22 Dec 2024 08:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaX-0005qs-QV
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:43 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaW-0000l7-CK
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=5g1hj/XSpIt4KoSrK8XrF9el+i1hz155MivVbNqV5wQ=; b=QETG9HEzNz8fmp86wKbDT0bN42
 rcg/mfqFdF8Ylhr8bT1ZSM3GltuRmwcIIxz49XoFanVyl5Kbj3JL59yhL5QfjhD2Y5SvqYbGGm8K+
 8UfbJE+3VzjOFyoiy8fj6uEv4OYUN5CCwSW5Tn48MSDygzGqHKQsuyhMX+Y919HbTAgE3chNgLv+o
 rb9aik3z4roFMkzzlPB8swn8bX4phDOnjRJfvHZuitpsdVSSpgyx1AUnCYEZYTi94m+R/Rnql8lo2
 POkGTOuXayz7iDgUVjT0y2SODiCV9eScV9Nbnd7mi3a9OKNb6GoY6RijTuja0C17v56kQvcs0/iw1
 66DlKwZZfo7wGqhVK3/l8GLxhg4MJniRKwWJIOgS5bCDFWLWhgiOYCWd3Xd7C7rLXBKcYkr1MPK8v
 iTIORzt0pY3nnjA0T81R6yD/wxUiNUwZ+WOdIHrvEP/FCPqyrzwLAwJtbwRXsWpLi9tdnlGehjoEY
 mJHbInbgGDK9A4YwgFoZFJLrDKTYZyT8ZZnzuMV9Ksi7kpODE+BZz2qGt9qnrOYURTxujwFaE9IRt
 66IMqs9QUyYcXZ5NS08rgoXbP86EbW20G7qpxcVjCcUCAtNcEZ6XaQCzJv6eeurXSxpsczyAGRLOb
 SmtOyTOLP6F2nG1jkg+WP/F9aVQPmQlqvcF1/RRJY=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZh-0002L7-M2; Sun, 22 Dec 2024 13:00:53 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:56 +0000
Message-Id: <20241222130012.1013374-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 17/33] next-cube: convert next-pc device to use Resettable
 interface
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/next-cube.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index de697c3e2b..61d0cb8327 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1009,9 +1009,9 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void next_pc_reset(DeviceState *dev)
+static void next_pc_reset_hold(Object *obj, ResetType type)
 {
-    NeXTPC *s = NEXT_PC(dev);
+    NeXTPC *s = NEXT_PC(obj);
 
     /* Set internal registers to initial values */
     /*     0x0000XX00 << vital bits */
@@ -1140,12 +1140,13 @@ static const VMStateDescription next_pc_vmstate = {
 static void next_pc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "NeXT Peripheral Controller";
     dc->realize = next_pc_realize;
-    device_class_set_legacy_reset(dc, next_pc_reset);
     device_class_set_props(dc, next_pc_properties);
     dc->vmsd = &next_pc_vmstate;
+    rc->phases.hold = next_pc_reset_hold;
 }
 
 static const TypeInfo next_pc_info = {
-- 
2.39.5


