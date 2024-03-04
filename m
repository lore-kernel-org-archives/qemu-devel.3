Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ABAC54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8X-0004VJ-CD; Sun, 03 Mar 2024 20:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7y-0002Qb-1Y
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7t-0002Qw-Lb
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DL5BNu1/lR7kXIS2bjgMtJyUQxodIRBqqeTZL0wzwjI=;
 b=c8QHFRnvTqg38GwJz2asPXen7Wk74ypT7we/LkTb7yrSdNSWXEZaKmjgX5jLrvnT17wBRh
 mZMbr7iXUzUNS+H25TAwsIOO6e/xUgY88/X4mr5kbWNDZHbBOJEf5Jb8xdXcDDNvIOJ+MM
 G+XQIA5j62s7LxoiWT6oqtqGVPEJE1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-zQkPDTbnNgGQJqpO3k9LVQ-1; Sun, 03 Mar 2024 20:28:17 -0500
X-MC-Unique: zQkPDTbnNgGQJqpO3k9LVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1478388D129;
 Mon,  4 Mar 2024 01:28:17 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1D2340C6EBA;
 Mon,  4 Mar 2024 01:28:13 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 22/27] migration/multifd: Prepare multifd sync for mapped-ram
 migration
Date: Mon,  4 Mar 2024 09:26:29 +0800
Message-ID: <20240304012634.95520-23-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

The mapped-ram migration can be performed live or non-live, but it is
always asynchronous, i.e. the source machine and the destination
machine are not migrating at the same time. We only need some pieces
of the multifd sync operations.

multifd_send_sync_main()
------------------------
  Issued by the ram migration code on the migration thread, causes the
  multifd send channels to synchronize with the migration thread and
  makes the sending side emit a packet with the MULTIFD_FLUSH flag.

  With mapped-ram we want to maintain the sync on the sending side
  because that provides ordering between the rounds of dirty pages when
  migrating live.

MULTIFD_FLUSH
-------------
  On the receiving side, the presence of the MULTIFD_FLUSH flag on a
  packet causes the receiving channels to start synchronizing with the
  main thread.

  We're not using packets with mapped-ram, so there's no MULTIFD_FLUSH
  flag and therefore no channel sync on the receiving side.

multifd_recv_sync_main()
------------------------
  Issued by the migration thread when the ram migration flag
  RAM_SAVE_FLAG_MULTIFD_FLUSH is received, causes the migration thread
  on the receiving side to start synchronizing with the recv
  channels. Due to compatibility, this is also issued when
  RAM_SAVE_FLAG_EOS is received.

  For mapped-ram we only need to synchronize the channels at the end of
  migration to avoid doing cleanup before the channels have finished
  their IO.

Make sure the multifd syncs are only issued at the appropriate times.

Note that due to pre-existing backward compatibility issues, we have
the multifd_flush_after_each_section property that can cause a sync to
happen at EOS. Since the EOS flag is needed on the stream, allow
mapped-ram to just ignore it.

Also emit an error if any other unexpected flags are found on the
stream.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240229153017.2221-20-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 18620784c6..329153d97d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1362,14 +1362,18 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
             if (migrate_multifd() &&
-                !migrate_multifd_flush_after_each_section()) {
+                (!migrate_multifd_flush_after_each_section() ||
+                 migrate_mapped_ram())) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_send_sync_main();
                 if (ret < 0) {
                     return ret;
                 }
-                qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-                qemu_fflush(f);
+
+                if (!migrate_mapped_ram()) {
+                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+                    qemu_fflush(f);
+                }
             }
             /*
              * If memory migration starts over, we will meet a dirtied page
@@ -3111,7 +3115,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
+        && !migrate_mapped_ram()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
 
@@ -3242,7 +3247,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 out:
     if (ret >= 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
-        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
+        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
+            !migrate_mapped_ram()) {
             ret = multifd_send_sync_main();
             if (ret < 0) {
                 return ret;
@@ -3334,7 +3340,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section() &&
+        !migrate_mapped_ram()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
@@ -4137,6 +4144,12 @@ static int ram_load_precopy(QEMUFile *f)
         invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
 
+    if (migrate_mapped_ram()) {
+        invalid_flags |= (RAM_SAVE_FLAG_HOOK | RAM_SAVE_FLAG_MULTIFD_FLUSH |
+                          RAM_SAVE_FLAG_PAGE | RAM_SAVE_FLAG_XBZRLE |
+                          RAM_SAVE_FLAG_ZERO);
+    }
+
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr;
         void *host = NULL, *host_bak = NULL;
@@ -4158,6 +4171,8 @@ static int ram_load_precopy(QEMUFile *f)
         addr &= TARGET_PAGE_MASK;
 
         if (flags & invalid_flags) {
+            error_report("Unexpected RAM flags: %d", flags & invalid_flags);
+
             if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
                 error_report("Received an unexpected compressed page");
             }
@@ -4210,6 +4225,10 @@ static int ram_load_precopy(QEMUFile *f)
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_MEM_SIZE:
             ret = parse_ramblocks(f, addr);
+
+            if (migrate_mapped_ram()) {
+                multifd_recv_sync_main();
+            }
             break;
 
         case RAM_SAVE_FLAG_ZERO:
@@ -4250,7 +4269,12 @@ static int ram_load_precopy(QEMUFile *f)
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
             if (migrate_multifd() &&
-                migrate_multifd_flush_after_each_section()) {
+                migrate_multifd_flush_after_each_section() &&
+                /*
+                 * Mapped-ram migration flushes once and for all after
+                 * parsing ramblocks. Always ignore EOS for it.
+                 */
+                !migrate_mapped_ram()) {
                 multifd_recv_sync_main();
             }
             break;
-- 
2.44.0


