Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3CDCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9B4-00023k-JZ; Mon, 15 Sep 2025 09:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9AY-0001nk-9E; Mon, 15 Sep 2025 09:22:59 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy9AI-00071b-U3; Mon, 15 Sep 2025 09:22:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B545F807B2;
 Mon, 15 Sep 2025 16:22:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:130::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GMPC4o1FuGk0-LQP1Hafh; Mon, 15 Sep 2025 16:22:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757942548;
 bh=46EE0QcsyOI2Tn/0Y+0C6uxt96PVLoxVw5eCSI98RF4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=y1iieFI5mnoEpLakA+gzIMobdvCYUqrub1XNzMCdtscMkea1Bxel7Jwrpn3IZaCFM
 PIFIUj2PqfTYnM/XZeMsNH4NeEWSho3eSvLGuZs8JMUZ7UeRtAGRGuRYaf1BQLkUN8
 aYqYA9JtkDMvbDPIH7AxAsSfG8PlkSm3o+lrXLwQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 13/13] chardev: close an fd on failure path
Date: Mon, 15 Sep 2025 16:22:10 +0300
Message-ID: <20250915132211.135095-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915132211.135095-1-vsementsov@yandex-team.ru>
References: <20250915132211.135095-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

There are at least two failure paths, where we forget
to close an fd.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 chardev/char-pty.c    | 1 +
 chardev/char-serial.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index fe6bfb043d..b066f01412 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -350,6 +350,7 @@ static void char_pty_open(Chardev *chr,
 
     close(slave_fd);
     if (!qemu_set_blocking(master_fd, false, errp)) {
+        close(master_fd);
         return;
     }
 
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index c622d758db..4c6ca713eb 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -272,6 +272,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
         return;
     }
     if (!qemu_set_blocking(fd, false, errp)) {
+        close(fd);
         return;
     }
     tty_serial_init(fd, 115200, 'N', 8, 1);
-- 
2.48.1


