Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EE5E83EE9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXnO-0001RO-FR; Wed, 04 Feb 2026 02:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vnXnL-0001Jk-8C; Wed, 04 Feb 2026 02:59:28 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vnXnJ-0006fH-SY; Wed, 04 Feb 2026 02:59:27 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D4BF58083B;
 Wed, 04 Feb 2026 10:59:23 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b69::1:1a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id lwj54n0AFCg0-mJihOebZ; 
 Wed, 04 Feb 2026 10:59:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770191963;
 bh=Qsul4O4z95xq9yphmhSiylpmeGjeIrFHxIxrbO2rFYY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=cQD0cs39i5F+N5cTn8DwI3051eRMMeK2ybrrsIZfj5ezMf2HHWpJJUM7J5HYZNuIn
 x9/aEX7FNDFsPXfoSoQ9V1OjTSiisFrjVIXURHO15AUXPP6KzlmmaglN9hQ7mGgKco
 UaolJJlULQbfhjpDGzk8wcOOO7C/Smg8vBglCI30=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH 4/4] hw/usb/core.c: reorder usage and assertion of p->ep
Date: Wed,  4 Feb 2026 12:57:54 +0500
Message-Id: <20260204075754.21078-5-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204075754.21078-1-heifetz@yandex-team.com>
References: <20260204075754.21078-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reorder the code so the assertion of p->ep occurs before it is
used in the subsequent lines.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 hw/usb/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index b3f811c513..9572a870cc 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -423,10 +423,10 @@ void usb_handle_packet(USBDevice *dev, USBPacket *p)
         p->status = USB_RET_NODEV;
         return;
     }
+    assert(p->ep);
     assert(dev == p->ep->dev);
     assert(dev->state == USB_STATE_DEFAULT);
     usb_packet_check_state(p, USB_PACKET_SETUP);
-    assert(p->ep != NULL);
 
     /* Submitting a new packet clears halt */
     if (p->ep->halted) {
-- 
2.34.1


