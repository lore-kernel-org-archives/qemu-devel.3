Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067E7C02197
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teznZ-0006Ah-Hk; Mon, 03 Feb 2025 11:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teznX-00069N-UR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:47 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teznW-0001My-6I
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:47 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57B631F390;
 Mon,  3 Feb 2025 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uG/0ZJ/Xxz/BLzmofmRVTfCL163uK0fqQ/R0xWxfNxo=;
 b=O41wfcPUVjk4JE49MUh86GM9dKWXAzaFN6TUx6QxxSr9x4kJqMAEJogMAHwbcjFZ1yj8kc
 gqpw5dr1QPYvb9L/eiCVmM2+c/ZThl6oiciQrmZhXl4i0XEvbL8CvahElyJXo5h3jwfaBH
 QcpLFDaZ9/qRneObjJoNEKt6BzMB4sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601984;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uG/0ZJ/Xxz/BLzmofmRVTfCL163uK0fqQ/R0xWxfNxo=;
 b=kR9+AnhMsxxwILSnUS71EVP+GBha/KFGLY2MAtPtSk6qL9KkiEnB5NpXwiCSB5308GMLX+
 3WtgnME21C1VX6DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uG/0ZJ/Xxz/BLzmofmRVTfCL163uK0fqQ/R0xWxfNxo=;
 b=O41wfcPUVjk4JE49MUh86GM9dKWXAzaFN6TUx6QxxSr9x4kJqMAEJogMAHwbcjFZ1yj8kc
 gqpw5dr1QPYvb9L/eiCVmM2+c/ZThl6oiciQrmZhXl4i0XEvbL8CvahElyJXo5h3jwfaBH
 QcpLFDaZ9/qRneObjJoNEKt6BzMB4sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601984;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uG/0ZJ/Xxz/BLzmofmRVTfCL163uK0fqQ/R0xWxfNxo=;
 b=kR9+AnhMsxxwILSnUS71EVP+GBha/KFGLY2MAtPtSk6qL9KkiEnB5NpXwiCSB5308GMLX+
 3WtgnME21C1VX6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CB5813A78;
 Mon,  3 Feb 2025 16:59:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IC+yOv71oGfDdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 03 Feb 2025 16:59:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 1/6] libqos/fw_cfg: refactor file directory iteraton to make it
 more reusable
Date: Mon,  3 Feb 2025 13:59:33 -0300
Message-Id: <20250203165938.14320-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250203165938.14320-1-farosas@suse.de>
References: <20250203165938.14320-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

fw-cfg file directory iteration code can be used by other functions that may
want to implement fw-cfg file operations. Refactor it into a smaller helper
so that it can be reused.

No functional change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250120043847.954881-2-anisinha@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqos/fw_cfg.c | 67 +++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 89f053ccac..22435873d9 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -60,27 +60,18 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
-/*
- * The caller need check the return value. When the return value is
- * nonzero, it means that some bytes have been transferred.
- *
- * If the fw_cfg file in question is smaller than the allocated & passed-in
- * buffer, then the buffer has been populated only in part.
- *
- * If the fw_cfg file in question is larger than the passed-in
- * buffer, then the return value explains how much room would have been
- * necessary in total. And, while the caller's buffer has been fully
- * populated, it has received only a starting slice of the fw_cfg file.
- */
-size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
-                      void *data, size_t buflen)
+static bool find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
+                            uint16_t *sel, uint32_t *size)
 {
+    g_autofree unsigned char *filesbuf = NULL;
     uint32_t count;
-    uint32_t i;
-    unsigned char *filesbuf = NULL;
     size_t dsize;
     FWCfgFile *pdir_entry;
-    size_t filesize = 0;
+    uint32_t i;
+    bool found = false;
+
+    *size = 0;
+    *sel = 0;
 
     qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
     count = be32_to_cpu(count);
@@ -90,17 +81,43 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
     pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
     for (i = 0; i < count; ++i, ++pdir_entry) {
         if (!strcmp(pdir_entry->name, filename)) {
-            uint32_t len = be32_to_cpu(pdir_entry->size);
-            uint16_t sel = be16_to_cpu(pdir_entry->select);
-            filesize = len;
-            if (len > buflen) {
-                len = buflen;
-            }
-            qfw_cfg_get(fw_cfg, sel, data, len);
+            *size = be32_to_cpu(pdir_entry->size);
+            *sel = be16_to_cpu(pdir_entry->select);
+            found = true;
             break;
         }
     }
-    g_free(filesbuf);
+
+    return found;
+}
+
+/*
+ * The caller need check the return value. When the return value is
+ * nonzero, it means that some bytes have been transferred.
+ *
+ * If the fw_cfg file in question is smaller than the allocated & passed-in
+ * buffer, then the buffer has been populated only in part.
+ *
+ * If the fw_cfg file in question is larger than the passed-in
+ * buffer, then the return value explains how much room would have been
+ * necessary in total. And, while the caller's buffer has been fully
+ * populated, it has received only a starting slice of the fw_cfg file.
+ */
+size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
+                        void *data, size_t buflen)
+{
+    size_t filesize = 0;
+    uint32_t len;
+    uint16_t sel;
+
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        filesize = len;
+        if (len > buflen) {
+            len = buflen;
+        }
+        qfw_cfg_get(fw_cfg, sel, data, len);
+    }
+
     return filesize;
 }
 
-- 
2.35.3


