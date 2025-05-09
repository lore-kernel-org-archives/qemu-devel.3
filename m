Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EC4C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 21:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDV78-0004t0-O2; Fri, 09 May 2025 17:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDV76-0004sS-P2
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:18:36 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDV74-0004KW-Sj
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:18:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC8792116A;
 Fri,  9 May 2025 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746825509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEKfYdSyd1SP/UWLsx8u/eySzvrQPfyY/7QJE8d7mFg=;
 b=HYHDXTzcryzuNkWtzM2Nsg+PDN06O6X7tryzf8Ay7qnCjq2ROJn1K6PTC2hLLD1eF+CXNY
 PRPTIZsx18I9Ys+EEAnIR885t2de917wqCRVOWeuReEkoZmwxaRpaXu0peiDvU2VUfsFJt
 gH6rsEniWXpSR2qDL1VGadTbmNO84Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746825509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEKfYdSyd1SP/UWLsx8u/eySzvrQPfyY/7QJE8d7mFg=;
 b=jCwW1KAj9G289EJWaK2WWoPTW59M7HRWeOSEUPNz1z37X0hRE7BTU732TTpcyEWu2bihY2
 tFOYC8tBRBoUwwDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746825509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEKfYdSyd1SP/UWLsx8u/eySzvrQPfyY/7QJE8d7mFg=;
 b=HYHDXTzcryzuNkWtzM2Nsg+PDN06O6X7tryzf8Ay7qnCjq2ROJn1K6PTC2hLLD1eF+CXNY
 PRPTIZsx18I9Ys+EEAnIR885t2de917wqCRVOWeuReEkoZmwxaRpaXu0peiDvU2VUfsFJt
 gH6rsEniWXpSR2qDL1VGadTbmNO84Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746825509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEKfYdSyd1SP/UWLsx8u/eySzvrQPfyY/7QJE8d7mFg=;
 b=jCwW1KAj9G289EJWaK2WWoPTW59M7HRWeOSEUPNz1z37X0hRE7BTU732TTpcyEWu2bihY2
 tFOYC8tBRBoUwwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BD5613931;
 Fri,  9 May 2025 21:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iFBELiNxHmjkNwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 May 2025 21:18:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/3] tests/qtest/libqos: Avoid double swapping when using
 modern virtio
Date: Fri,  9 May 2025 18:18:20 -0300
Message-Id: <20250509211821.23684-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250509211821.23684-1-farosas@suse.de>
References: <20250509211821.23684-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The logic in the qvirtio_read/write function is rather a headache,
involving byte-swapping when the target is big endian, just to
maybe involve another byte-swapping  in the qtest_read/write
function immediately afterwards (on the QEMU side). Let's do it in
a more obvious way here: For virtio 1.0, we know that the values have
to be little endian, so let's read/write the bytes in that well known
order here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250430132817.610903-1-thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqos/virtio.c | 44 ++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 2e7979652f..5a709d0bc5 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -25,49 +25,63 @@
  */
 static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, uint64_t addr)
 {
-    uint16_t val = qtest_readw(qts, addr);
+    uint16_t val;
 
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap16(val);
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        qtest_memread(qts, addr, &val, sizeof(val));
+        val = le16_to_cpu(val);
+    } else {
+        val = qtest_readw(qts, addr);
     }
+
     return val;
 }
 
 static uint32_t qvirtio_readl(QVirtioDevice *d, QTestState *qts, uint64_t addr)
 {
-    uint32_t val = qtest_readl(qts, addr);
+    uint32_t val;
 
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap32(val);
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        qtest_memread(qts, addr, &val, sizeof(val));
+        val = le32_to_cpu(val);
+    } else {
+        val = qtest_readl(qts, addr);
     }
+
     return val;
 }
 
 static void qvirtio_writew(QVirtioDevice *d, QTestState *qts,
                            uint64_t addr, uint16_t val)
 {
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap16(val);
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        val = cpu_to_le16(val);
+        qtest_memwrite(qts, addr, &val, sizeof(val));
+    } else {
+        qtest_writew(qts, addr, val);
     }
-    qtest_writew(qts, addr, val);
 }
 
 static void qvirtio_writel(QVirtioDevice *d, QTestState *qts,
                            uint64_t addr, uint32_t val)
 {
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap32(val);
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        val = cpu_to_le32(val);
+        qtest_memwrite(qts, addr, &val, sizeof(val));
+    } else {
+        qtest_writel(qts, addr, val);
     }
-    qtest_writel(qts, addr, val);
 }
 
 static void qvirtio_writeq(QVirtioDevice *d, QTestState *qts,
                            uint64_t addr, uint64_t val)
 {
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap64(val);
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        val = cpu_to_le64(val);
+        qtest_memwrite(qts, addr, &val, sizeof(val));
+    } else {
+        qtest_writeq(qts, addr, val);
     }
-    qtest_writeq(qts, addr, val);
 }
 
 uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t addr)
-- 
2.35.3


