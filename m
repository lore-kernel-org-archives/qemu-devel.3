Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E202DCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9b4-0000uc-LW; Sat, 17 Oct 2026 14:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9ak-0000YK-A7; Sat, 17 Oct 2026 14:57:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9ai-0003gI-Pp; Sat, 17 Oct 2026 14:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263378; bh=RCLJBtu4un76A2/PxUP84DT7XnR+7pgRtnzWN4ApPLw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EhKEFjcPHJM1dAxdpp5bXcNn8dIx4Iqvd0PlX6XMawwZ/CSZJnGd/1Eua9q/Hnz+M
 52RXzQllZZDWCJ0KeiUsR0WnHqjkrYwpZIJtpt0dzkTjiCAkY743genXG/zgI8RN9r
 1OusBBdcZAiIiKpdObcDKO3OGXAn9dR5K4gxPqCelDMOYVuRBGwL8MBMVoBFLazojq
 BF5ZB6Rrb94MWpt4S1XYa6uA47F9z4+fPDx1AxVD/5Hl7ghsERWNDQoDkMAEXvo6Cr
 K2VJFOyrb+3DYokZlN22KLqVBqhyARtEIg5l4dREbiIXbGUUeUvKoZe6i4gRYprKXd
 tTJQijaH+Z+nQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CD21A1DE6B3;
 Sat, 17 Oct 2026 21:56:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D8BD644337E;
 Sat, 17 Oct 2026 21:56:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 19/63] hw/usb/dev-smartcard-reader: validate migrated
 fields in post_load
Date: Sat, 17 Oct 2026 21:54:35 +0300
Message-ID: <20261017185528.722197-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Validate fields loaded from the migration stream to reject crafted or
corrupt data before it can cause harm.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 665494c3ac0737e8067b6365f99c237bd5e5356a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 81b2905526..9d3e60e32e 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1360,6 +1360,26 @@ static void ccid_realize(USBDevice *dev, Error **errp)
 static int ccid_post_load(void *opaque, int version_id)
 {
     USBCCIDState *s = opaque;
+    int i;
+
+    if (s->bulk_in_pending_end - s->bulk_in_pending_start > BULK_IN_PENDING_NUM) {
+        return -EINVAL;
+    }
+
+    if (s->pending_answers_num > PENDING_ANSWERS_NUM) {
+        return -EINVAL;
+    }
+
+    if (s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
+        return -EINVAL;
+    }
+
+    for (i = 0; i < BULK_IN_PENDING_NUM; i++) {
+        if (s->bulk_in_pending[i].len > BULK_IN_BUF_SIZE ||
+            s->bulk_in_pending[i].pos > s->bulk_in_pending[i].len) {
+            return -EINVAL;
+        }
+    }
 
     /*
      * This must be done after usb_device_attach, which sets state to ATTACHED,
-- 
2.47.3


