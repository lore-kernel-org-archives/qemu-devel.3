Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FFCC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA82T-0006iu-6e; Fri, 25 Sep 2026 11:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82Q-0006i3-S7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:39 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xA82N-0004cA-Q2
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:40:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 560991FF47;
 Fri, 25 Sep 2026 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52DIgqmLX5fYoHFezqVp/OYQGAW7c+IKgzFrqII9PQ0=;
 b=p7cokc9KBcSwZp+eWeBuG3JQu1AlKriaFAI2lnGwJtJh50acVVwk4Uh2Fhcy0rpQqegIhx
 2JORQx/kfKql0R6xZ6eeHPuOwUqTeO+2vJlJlqm0ev1YQxmXE2I8mCKkqEq3YuMdgMheUn
 R7WcXdzrTQy933KphXWG+1SG+TTLeSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52DIgqmLX5fYoHFezqVp/OYQGAW7c+IKgzFrqII9PQ0=;
 b=4M9vO7Nup84m/6UuH5SoXlx41O/KfA55FAanivQCm90whWOoudLS6KTEf/+C2xxvcFiwY9
 G7OlzVZcMAYrMmDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790350826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52DIgqmLX5fYoHFezqVp/OYQGAW7c+IKgzFrqII9PQ0=;
 b=bzyQAFIAtdct8ABcODuJIXnbSLbkLIr5w/KKzf2clc23NbaaesD6/aoCSOUn0QIBPhZTL5
 DpRjLR0CgpHOHhqwj9z6upBcCq2L8LtXuSGZDnFl4ayTXmdl2B6uxZRlVdQKIEw043P8m9
 gryx5LrgezyV0W7bhVre7BZylJohhCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790350826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52DIgqmLX5fYoHFezqVp/OYQGAW7c+IKgzFrqII9PQ0=;
 b=MY9xTScGDR7XldHCzPJrYW7V516N2mFRPANcX9ZOh6LqSUSi14wyVOr7N35N7acaLCx8Q6
 6gdOjfly0J0yO6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A05213353;
 Fri, 25 Sep 2026 15:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xxRgCd2VtmqjOwAAD6G6ig:T9
 (envelope-from <farosas@suse.de>); Fri, 25 Sep 2026 15:40:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 08/19] migration/ram: Add RAM round synchronization notifiers
Date: Fri, 25 Sep 2026 12:39:59 -0300
Message-ID: <20260925154010.599247-9-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925154010.599247-1-farosas@suse.de>
References: <20260925154010.599247-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,bytedance.com:email,ionos.com:email,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Yanfei Xu <yanfei.xu@bytedance.com>

find_dirty_block() directly invokes multifd's per-round synchronization
when the RAM scan wraps.  Other transports need the same boundary to
order page versions.

Add a return-valued notifier for RAM round completion and register
multifd's existing synchronization through it.  This keeps the current
behavior while allowing other transports to synchronize at the same
boundary.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-nocomp.c | 24 ++++++++++++++++++++
 migration/ram.c            | 45 +++++++++++++++++++++++++++++++++-----
 migration/ram.h            | 12 ++++++++++
 3 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 9f7a792fa7..3067c19cc6 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -19,6 +19,7 @@
 #include "multifd-colo.h"
 #include "options.h"
 #include "migration.h"
+#include "ram.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -27,6 +28,28 @@
 
 static MultiFDSendData *multifd_ram_send;
 
+static int multifd_ram_round_notify(NotifierWithReturn *n G_GNUC_UNUSED,
+                                    void *data, Error **errp)
+{
+    RAMRoundNotifyData *round_data = data;
+    QEMUFile *f = round_data->file;
+    int ret;
+
+    if (!multifd_ram_sync_per_round()) {
+        return 0;
+    }
+
+    ret = multifd_ram_flush_and_sync(f);
+    if (ret < 0) {
+        error_setg(errp, "multifd RAM round synchronization failed");
+    }
+    return ret;
+}
+
+static NotifierWithReturn multifd_ram_round_notifier = {
+    .notify = multifd_ram_round_notify,
+};
+
 void multifd_ram_payload_alloc(MultiFDPages_t *pages)
 {
     pages->offset = g_new0(ram_addr_t, multifd_ram_page_count());
@@ -471,6 +494,7 @@ static const MultiFDMethods multifd_nocomp_ops = {
 static void multifd_nocomp_register(void)
 {
     multifd_register_ops(MULTIFD_COMPRESSION_NONE, &multifd_nocomp_ops);
+    ram_round_add_notifier(&multifd_ram_round_notifier);
 }
 
 migration_init(multifd_nocomp_register);
diff --git a/migration/ram.c b/migration/ram.c
index b7c406428e..e6db3bf523 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -470,6 +470,8 @@ typedef struct RAMState RAMState;
 static RAMState *ram_state;
 
 static NotifierWithReturnList precopy_notifier_list;
+static NotifierWithReturnList ram_round_notifier_list =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(ram_round_notifier_list);
 
 /* Whether postcopy has queued requests? */
 static bool postcopy_has_request(RAMState *rs)
@@ -500,6 +502,38 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp)
     return notifier_with_return_list_notify(&precopy_notifier_list, &pnd, errp);
 }
 
+void ram_round_add_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_list_add(&ram_round_notifier_list, n);
+}
+
+void ram_round_remove_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+static int ram_round_notify(QEMUFile *f)
+{
+    RAMRoundNotifyData data = {
+        .file = f,
+    };
+    Error *local_err = NULL;
+    int ret;
+
+    ret = notifier_with_return_list_notify(&ram_round_notifier_list, &data,
+                                           &local_err);
+    if (ret) {
+        if (local_err) {
+            error_report_err(local_err);
+        } else {
+            error_report("RAM round notifier failed: %d", ret);
+        }
+        return -1;
+    }
+
+    return 0;
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_SIZE) :
@@ -1410,12 +1444,11 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (multifd_ram_sync_per_round()) {
-                QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_ram_flush_and_sync(f);
-                if (ret < 0) {
-                    return ret;
-                }
+            QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
+            int ret = ram_round_notify(f);
+
+            if (ret < 0) {
+                return ret;
             }
 
             /* Hit the end of the list */
diff --git a/migration/ram.h b/migration/ram.h
index 41697a7599..84f10087e8 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -31,6 +31,7 @@
 
 #include "qapi/qapi-types-migration.h"
 #include "exec/cpu-common.h"
+#include "qemu/notify.h"
 #include "system/ram_addr.h"
 #include "io/channel.h"
 
@@ -95,6 +96,17 @@ void ram_handle_zero(void *host, uint64_t size);
 void ram_transferred_add(uint64_t bytes);
 void ram_release_page(const char *rbname, uint64_t offset);
 
+/*
+ * The RAM round notifier is invoked whenever the migration RAM core
+ * completes one full scan of guest memory.
+ */
+typedef struct RAMRoundNotifyData {
+    QEMUFile *file;
+} RAMRoundNotifyData;
+
+void ram_round_add_notifier(NotifierWithReturn *n);
+void ram_round_remove_notifier(NotifierWithReturn *n);
+
 int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
-- 
2.53.0


