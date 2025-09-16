Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8149CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVXD-0006VU-0y; Tue, 16 Sep 2025 09:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVW0-0005QO-QK; Tue, 16 Sep 2025 09:14:41 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVVq-0006a2-Dm; Tue, 16 Sep 2025 09:14:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CB4B6C0263;
 Tue, 16 Sep 2025 16:14:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:16c::1:b])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5EQRob1Gj0U0-3my5EPvY; Tue, 16 Sep 2025 16:14:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758028458;
 bh=U0iIBse8ZC8ENtg6o1H6rx8s5OyGvuvA2kcUutepzk4=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=Wt6JiF/oig+D6kxMkAJQpg7UeOgTxxpZIj1OH39s4DySwZaPBUxATOtlRoWkzXfC1
 aJdP5nGT3XPAGAS2i2bhQz42m+rqy0r4sbG21oPyMG15nyenURrPlBj/TR5Mj4+rp0
 PlgP5hnz6frSRRKb0lAAiqNY+AUbAfryFVDwVDyA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 12/13] chardev: close an fd on failure path
Date: Tue, 16 Sep 2025 16:14:01 +0300
Message-ID: <20250916131403.368343-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250916131403.368343-1-vsementsov@yandex-team.ru>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


