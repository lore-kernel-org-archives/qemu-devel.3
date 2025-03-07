Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DF9C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcF6-0000jN-II; Fri, 07 Mar 2025 13:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcF4-0000io-3v
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:14 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tqcF1-0004Z1-Gw
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:16:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 830371F441;
 Fri,  7 Mar 2025 18:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCyu6U659hl4+BbhYS269+FXsnwSQqSXTjYAb5axr/s=;
 b=AwPEwXEVPViUgxwRmDv+iFsFGeYL/0sxfXj1mlFeD5IpedAyPF452KnoHbpqqFGPZppZPT
 Dvo1QbiKX2rN7A04K6fzNYcIxC1r26VsgSXVy0ALaxMGs7mEzfCt2gEAQA7axReIelyiDt
 iR1VK1mxoAMcovYvnoX0xtqDwLi89Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCyu6U659hl4+BbhYS269+FXsnwSQqSXTjYAb5axr/s=;
 b=KFVa/qgtUAQOlE5RX3g9YF1PcCKtKKLt6biiMK3YOkh8V45TS7DqRF3v1h7dliYi+DGhHD
 oFXGPc95Ux4QgxCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qlzBqS9O;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ya1DQomK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741371363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCyu6U659hl4+BbhYS269+FXsnwSQqSXTjYAb5axr/s=;
 b=qlzBqS9OVE7vMsQR9IpiJDrAwZLJg866cGXWc6qqIAWnNpAvLiJ8PLzHO8VyDjpVMUvxSQ
 0ma+xJuw7Ez32UaisQMDcLxFzZnMfjyiRisP5s4umwvG59bQuFseYYzm8DFY/RCxbB7hsI
 mJh3hKJYkMkFB2g6mC808G/wYoQvhTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741371363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCyu6U659hl4+BbhYS269+FXsnwSQqSXTjYAb5axr/s=;
 b=Ya1DQomKB0PQprrhVj8IUVoIPku062oURgpA+7KyIu3dpa2fYoTrrXb7jFXjGGxMEh4/xt
 gs1AdUXTy17lxrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E59513A22;
 Fri,  7 Mar 2025 18:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2M9DN+E3y2dNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Mar 2025 18:16:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 4/8] migration: check RDMA and capabilities are compatible on
 both sides
Date: Fri,  7 Mar 2025 15:15:47 -0300
Message-Id: <20250307181551.19887-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307181551.19887-1-farosas@suse.de>
References: <20250307181551.19887-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 830371F441
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

Depending on the order of starting RDMA and setting capability,
they can be categorized into the following scenarios:
Source:
 S1: [set capabilities] -> [Start RDMA outgoing]
Destination:
 D1: [set capabilities] -> [Start RDMA incoming]
 D2: [Start RDMA incoming] -> [set capabilities]

Previously, compatibility between RDMA and capabilities was verified only
in scenario D1, potentially causing migration failures in other situations.

For scenarios S1 and D1, we can seamlessly incorporate
migration_transport_compatible() to address compatibility between
channels and capabilities vs transport.

For scenario D2, ensure compatibility within migrate_caps_check().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20250305062825.772629-3-lizhijian@fujitsu.com>
[fixup comment alignment]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 30 ++++++++++++++++++++----------
 migration/options.c   | 21 +++++++++++++++++++++
 migration/options.h   |  1 +
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d46e776e24..22dd966970 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -259,6 +259,24 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
     return true;
 }
 
+static bool
+migration_capabilities_and_transport_compatible(MigrationAddress *addr,
+                                                Error **errp)
+{
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        return migrate_rdma_caps_check(migrate_get_current()->capabilities,
+                                       errp);
+    }
+
+    return true;
+}
+
+static bool migration_transport_compatible(MigrationAddress *addr, Error **errp)
+{
+    return migration_channels_and_transport_compatible(addr, errp) &&
+           migration_capabilities_and_transport_compatible(addr, errp);
+}
+
 static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
 {
     uintptr_t a = (uintptr_t) ap, b = (uintptr_t) bp;
@@ -750,7 +768,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(addr, errp)) {
+    if (!migration_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -769,14 +787,6 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         }
 #ifdef CONFIG_RDMA
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        if (migrate_xbzrle()) {
-            error_setg(errp, "RDMA and XBZRLE can't be used together");
-            return;
-        }
-        if (migrate_multifd()) {
-            error_setg(errp, "RDMA and multifd can't be used together");
-            return;
-        }
         rdma_start_incoming_migration(&addr->u.rdma, errp);
 #endif
     } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
@@ -2208,7 +2218,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     }
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(addr, errp)) {
+    if (!migration_transport_compatible(addr, errp)) {
         return;
     }
 
diff --git a/migration/options.c b/migration/options.c
index b0ac2ea408..1f3602839d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -448,6 +448,20 @@ static bool migrate_incoming_started(void)
     return !!migration_incoming_get_current()->transport_data;
 }
 
+bool migrate_rdma_caps_check(bool *caps, Error **errp)
+{
+    if (caps[MIGRATION_CAPABILITY_XBZRLE]) {
+        error_setg(errp, "RDMA and XBZRLE can't be used together");
+        return false;
+    }
+    if (caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        error_setg(errp, "RDMA and multifd can't be used together");
+        return false;
+    }
+
+    return true;
+}
+
 /**
  * @migration_caps_check - check capability compatibility
  *
@@ -611,6 +625,13 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    /*
+     * On destination side, check the cases that capability is being set
+     * after incoming thread has started.
+     */
+    if (migrate_rdma() && !migrate_rdma_caps_check(new_caps, errp)) {
+        return false;
+    }
     return true;
 }
 
diff --git a/migration/options.h b/migration/options.h
index 762be4e641..82d839709e 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -57,6 +57,7 @@ bool migrate_tls(void);
 
 /* capabilities helpers */
 
+bool migrate_rdma_caps_check(bool *caps, Error **errp);
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
 
 /* parameters */
-- 
2.35.3


