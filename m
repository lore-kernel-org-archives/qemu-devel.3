Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD22106289F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0JPW-0000oF-MG; Wed, 11 Mar 2026 09:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JPR-0000mq-Bm; Wed, 11 Mar 2026 09:15:33 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JPN-0000Mu-I4; Wed, 11 Mar 2026 09:15:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id EEA3D8062A;
 Wed, 11 Mar 2026 16:15:27 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:d28::1:5])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MFGaO30AdeA0-YDaVl7co; Wed, 11 Mar 2026 16:15:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773234927;
 bh=tzPB6fjysN2r3rjRlnKTgZ2tmMc0GDYMM+Hwo4GReow=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=E5T7HrTXts1T37eZB7F797F26v9igZitn8mA7PVQhD+P7hhXoB0ahmqUnIyCplk2A
 waX8Car8zPvh4Hv0jHqfMrm9g7gVK2gILFYUojkjKNI78q595I9F9EYsZpFCCAs7Dz
 InNLvmlEUHLXyBN+uQu7/XmLxzJKFOxeyMgiLgts=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v4 4/4] hw/usb/core.c: reorder usage and assertion of p->ep
Date: Wed, 11 Mar 2026 18:15:22 +0500
Message-Id: <20260311131522.58600-5-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311131522.58600-1-heifetz@yandex-team.com>
References: <20260311131522.58600-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/usb/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index b3f811c513b..9572a870cc0 100644
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


