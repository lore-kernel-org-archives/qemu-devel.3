Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CC2C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n4e-0002Zt-Oi; Wed, 16 Sep 2026 06:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n42-0008QQ-Az; Wed, 16 Sep 2026 06:40:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n3z-0002Li-MD; Wed, 16 Sep 2026 06:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554957; bh=M0H3Ac6vh+pqzQ+Xk78MpEPRiI2f/IWvMxLbMdJFKws=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hA7i79FyLkDKvjsmqDZaovrCSeJrKdRH0exY/D7bcJxaNYMS1RxcAPj1E9X/JZVGb
 a89+YejJaITlSdqWYdS7XpOyAhCB3RoyP0gKjJdQN5Y8lbcusAHTrAg/B56xuGLo4m
 YBzT67x7fmFWyRgQBjHfUkystQzyXZt+78HoJsoTGp6aAL1Rq8WfSyr9mmFnJUg7QZ
 s4uuA9kfJe3c6KxImRxAf1voe37/N5bYI6D9U+OaprdRZ9x1dqHb2Hyq8y8j+lrYM6
 kZ50LzWc/FhHOCpoMz7gnQRCJ+qq1MfabJG+a5BGTyB59QLqRUtJAjrsOUMIWgbjXn
 Q1oXT8o8JMlmg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ECCBF1D5826;
 Wed, 16 Sep 2026 13:35:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B7AC8429F94;
 Wed, 16 Sep 2026 13:36:40 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A19F35A841; Wed, 16 Sep 2026 13:36:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 48/56] hw/display/qxl: hold ssd.lock while replacing
 ssd.cursor
Date: Wed, 16 Sep 2026 13:36:06 +0300
Message-ID: <20260916103622.684817-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

qxl_spice_reset_cursor() unrefs qxl->ssd.cursor and installs the hidden
cursor without holding qxl->ssd.lock. Every other writer of that field
takes it: qxl_render_cursor(), display_mouse_define() and
qemu_spice_cursor_refresh_bh().

The unlocked path runs on a vCPU thread, reached from ioport_write() on
QXL_IO_DESTROY_PRIMARY and QXL_IO_DESTROY_PRIMARY_ASYNC, and holds only
the BQL, which the SPICE display worker never takes. Unlike
qxl_hard_reset(), it leaves that worker running.
spice_qxl_reset_cursor() does round trip through the dispatcher, but the
worker is free again as soon as it returns, so it can enter
qxl_render_cursor() and unref the same QEMUCursor a few instructions
later. Both threads then drop one reference for what is a single
reference, freeing a cursor that another user still holds. The store to
ssd.cursor races the same way, and a guest that keeps this up also ends
up waiting forever in qxl_fence_wait().

A guest reaches this by switching QXL mode while it also updates the
pointer shape.

Fixes: 958c2bceba06 ("qxl: fix cursor reset")
Cc: qemu-stable@nongnu.org
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260903192647.2677279-2-den@openvz.org>
(cherry picked from commit 2c43897356ac10dcce76a0287de8f9561c84fe82)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 384b8767b8e..c4f547e88bd 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -294,10 +294,12 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
     qemu_mutex_lock(&qxl->track_lock);
     qxl->guest_cursor = 0;
     qemu_mutex_unlock(&qxl->track_lock);
+    qemu_mutex_lock(&qxl->ssd.lock);
     if (qxl->ssd.cursor) {
         cursor_unref(qxl->ssd.cursor);
     }
     qxl->ssd.cursor = cursor_builtin_hidden();
+    qemu_mutex_unlock(&qxl->ssd.lock);
 }
 
 static uint32_t qxl_crc32(const uint8_t *p, unsigned len)
-- 
2.47.3


