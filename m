Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF773606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=EVYjIXCX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6D-0003Ny-Aq; Fri, 27 Nov 2026 01:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5M-0007ta-JG; Fri, 27 Nov 2026 01:05:29 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5K-00064H-N4; Fri, 27 Nov 2026 01:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759043; bh=G32NmwwE3O3jWIIx3Rw7vVoj0aOymLDgg7DioxknVjU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EVYjIXCX9yZaWZKM5zN65EeLLIAD9tuJ2vALevnx6KFxvQL+JFJzmZjtcHX7dyenz
 CO0lEJZYLjkgKqf5blHF4PCgvIF1Jdvs2g7zne0ZKUeeCGtxgZxrc1pUd6qaNMRc7E
 1Sb7GmenGX5He6CawC4m1f7SupovwuqmQQ9cjxvufTdwRTGv9Deq1rtff9IcMZYIbt
 S91VOC+eK6lYf3tWH8uU6ipXrwF3hL6hWhKve36wOynCIVGcHbtP8Uzh6n8erxL3BV
 1yyDnS4rSUT7VBqk4oksokcGeAJKKZITC11iD50Wdy/G5SzypNsvxNWrmQSYvgnnyv
 2e4gqlUiSsuRw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D09851EA34F;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CD99C46997A;
 Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B17F2CF2EC; Fri, 27 Nov 2026 08:57:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Guo <guobin@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 093/152] hw/usb/u2f: validate ring buffer indices
 on migration load
Date: Fri, 27 Nov 2026 08:53:51 +0300
Message-ID: <20261127055709.39630-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Guo <guobin@linux.alibaba.com>

The U2F key pending_in ring buffer uses uint8_t start/end/num indices
over a 32-entry array, all serialized in the vmstate.  A malicious
migration stream can inject values >= U2FHID_PENDING_IN_NUM (32),
causing an out-of-bounds heap read in u2f_pending_in_get() on the
first USB IN token after migration completes.

Add a post_load callback to validate the restored indices and reset
the ring buffer to empty on any out-of-range value.  Pending packets
are non-critical (the device will regenerate them), so resetting the
ring is preferable to rejecting migration entirely.

As defense-in-depth, also add a bounds clamp in u2f_pending_in_get()
so that even if corrupted state somehow reaches the consumer path,
the index is folded into range before array access.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4483
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260916092342.2447-1-guobin@linux.alibaba.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 09f671d8041f98253d0f4d6e7fbb1c8e2f1fa1e8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/u2f.c b/hw/usb/u2f.c
index d6291852f63..9ca9879f3e0 100644
--- a/hw/usb/u2f.c
+++ b/hw/usb/u2f.c
@@ -228,6 +228,11 @@ static uint8_t *u2f_pending_in_get(U2FKeyState *key)
         return NULL;
     }
 
+    /* Clamp to valid range in case of corrupted state (e.g. migration) */
+    if (key->pending_in_start >= U2FHID_PENDING_IN_NUM) {
+        key->pending_in_start %= U2FHID_PENDING_IN_NUM;
+    }
+
     index = key->pending_in_start;
     key->pending_in_start = (index + 1) % U2FHID_PENDING_IN_NUM;
     --key->pending_in_num;
@@ -301,10 +306,36 @@ static void u2f_key_realize(USBDevice *dev, Error **errp)
     key->ep = usb_ep_get(dev, USB_TOKEN_IN, 1);
 }
 
+static int u2f_key_post_load(void *opaque, int version_id)
+{
+    U2FKeyState *key = opaque;
+
+    /*
+     * Validate pending_in ring buffer indices restored from the migration
+     * stream.  An attacker-controlled stream could inject values >= 32
+     * (U2FHID_PENDING_IN_NUM), causing out-of-bounds heap access in
+     * u2f_pending_in_get() on the first IN token after migration.
+     *
+     * Reset the ring on any invalid value: pending packets are non-critical
+     * (they will be regenerated by the device), so rejecting migration
+     * entirely is not necessary.
+     */
+    if (key->pending_in_start >= U2FHID_PENDING_IN_NUM ||
+        key->pending_in_end >= U2FHID_PENDING_IN_NUM ||
+        key->pending_in_num > U2FHID_PENDING_IN_NUM) {
+        key->pending_in_start = 0;
+        key->pending_in_end = 0;
+        key->pending_in_num = 0;
+    }
+
+    return 0;
+}
+
 const VMStateDescription vmstate_u2f_key = {
     .name = "u2f-key",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = u2f_key_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, U2FKeyState),
         VMSTATE_UINT8(idle, U2FKeyState),
-- 
2.47.3


