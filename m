Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEDCC52D6D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV29-0000Wu-CJ; Thu, 01 Aug 2024 08:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV25-0000E2-3w
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV20-00017v-Kd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:48 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 268E321A09;
 Thu,  1 Aug 2024 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpMXSRZM8PA0rsDxqY3ONpV7hSLIaFgfRg7eSfun0Uo=;
 b=iJh37q7L6m+PKEBvSbD6bsqcYvN6a+2dwhav7CNIsedzFoOGrhdkOcjWpgRq9d0vk2TYws
 DxLsIOcuhvN5N15MBkgG6vWpUp2XqMp7+curB5qzd4cLkaYjf6ZO9Uqzy3dPtmpXdCeKLK
 OYyZcOgZwh8sZNQZvib11ZBk6wz1QYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpMXSRZM8PA0rsDxqY3ONpV7hSLIaFgfRg7eSfun0Uo=;
 b=z5rHPtbxoHYDQEd0fl+MWhRna4loiSbPJTxWiGG0YZzedL+aV1vn9ItS3gA3ZkFMf/Yy5k
 k7qHT6Igc7i3zbDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpMXSRZM8PA0rsDxqY3ONpV7hSLIaFgfRg7eSfun0Uo=;
 b=iJh37q7L6m+PKEBvSbD6bsqcYvN6a+2dwhav7CNIsedzFoOGrhdkOcjWpgRq9d0vk2TYws
 DxLsIOcuhvN5N15MBkgG6vWpUp2XqMp7+curB5qzd4cLkaYjf6ZO9Uqzy3dPtmpXdCeKLK
 OYyZcOgZwh8sZNQZvib11ZBk6wz1QYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpMXSRZM8PA0rsDxqY3ONpV7hSLIaFgfRg7eSfun0Uo=;
 b=z5rHPtbxoHYDQEd0fl+MWhRna4loiSbPJTxWiGG0YZzedL+aV1vn9ItS3gA3ZkFMf/Yy5k
 k7qHT6Igc7i3zbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9C3213946;
 Thu,  1 Aug 2024 12:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kFSrHx2Bq2YEYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 12:35:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 14/14] migration/multifd: Move ram code into multifd-ram.c
Date: Thu,  1 Aug 2024 09:35:16 -0300
Message-Id: <20240801123516.4498-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801123516.4498-1-farosas@suse.de>
References: <20240801123516.4498-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

In preparation for adding new payload types to multifd, move most of
the ram-related code into multifd-ram.c. Let's try to keep a semblance
of layering by not mixing general multifd control flow with the
details of transmitting pages of ram.

There are still some pieces leftover, namely the p->normal, p->zero,
etc variables that we use for zero page tracking and the packet
allocation which is heavily dependent on the ram code.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/meson.build   |   1 +
 migration/multifd-ram.c | 400 ++++++++++++++++++++++++++++++++++++++++
 migration/multifd.c     | 384 +-------------------------------------
 migration/multifd.h     |   5 +
 4 files changed, 408 insertions(+), 382 deletions(-)
 create mode 100644 migration/multifd-ram.c

diff --git a/migration/meson.build b/migration/meson.build
index 5ce2acb41e..0d1c79cffa 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -21,6 +21,7 @@ system_ss.add(files(
   'migration-hmp-cmds.c',
   'migration.c',
   'multifd.c',
+  'multifd-ram.c',
   'multifd-zlib.c',
   'multifd-zero-page.c',
   'options.c',
diff --git a/migration/multifd-ram.c b/migration/multifd-ram.c
new file mode 100644
index 0000000000..81dda140b5
--- /dev/null
+++ b/migration/multifd-ram.c
@@ -0,0 +1,400 @@
+/*
+ * Multifd ram code
+ *
+ * Copyright (c) 2019-2020 Red Hat Inc
+ *
+ * Authors:
+ *  Juan Quintela <quintela@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/ramblock.h"
+#include "exec/target_page.h"
+#include "file.h"
+#include "multifd.h"
+#include "options.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+
+static MultiFDSendData *multifd_ram_send;
+
+size_t multifd_ram_payload_size(void)
+{
+    uint32_t n = multifd_ram_page_count();
+
+    /*
+     * We keep an array of page offsets at the end of MultiFDPages_t,
+     * add space for it in the allocation.
+     */
+    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
+}
+
+void multifd_ram_save_setup(void)
+{
+    multifd_ram_send = multifd_send_data_alloc();
+}
+
+void multifd_ram_save_cleanup(void)
+{
+    g_free(multifd_ram_send);
+    multifd_ram_send = NULL;
+}
+
+static void multifd_set_file_bitmap(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = &p->data->u.ram;
+
+    assert(pages->block);
+
+    for (int i = 0; i < pages->normal_num; i++) {
+        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], true);
+    }
+
+    for (int i = pages->normal_num; i < pages->num; i++) {
+        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], false);
+    }
+}
+
+static int ram_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    uint32_t page_count = multifd_ram_page_count();
+
+    if (migrate_zero_copy_send()) {
+        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
+    }
+
+    if (!migrate_mapped_ram()) {
+        /* We need one extra place for the packet header */
+        p->iov = g_new0(struct iovec, page_count + 1);
+    } else {
+        p->iov = g_new0(struct iovec, page_count);
+    }
+
+    return 0;
+}
+
+static void ram_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    g_free(p->iov);
+    p->iov = NULL;
+    return;
+}
+
+static void multifd_send_prepare_iovs(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = &p->data->u.ram;
+    uint32_t page_size = multifd_ram_page_size();
+
+    for (int i = 0; i < pages->normal_num; i++) {
+        p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
+        p->iov[p->iovs_num].iov_len = page_size;
+        p->iovs_num++;
+    }
+
+    p->next_packet_size = pages->normal_num * page_size;
+}
+
+static int ram_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    bool use_zero_copy_send = migrate_zero_copy_send();
+    int ret;
+
+    multifd_send_zero_page_detect(p);
+
+    if (migrate_mapped_ram()) {
+        multifd_send_prepare_iovs(p);
+        multifd_set_file_bitmap(p);
+
+        return 0;
+    }
+
+    if (!use_zero_copy_send) {
+        /*
+         * Only !zerocopy needs the header in IOV; zerocopy will
+         * send it separately.
+         */
+        multifd_send_prepare_header(p);
+    }
+
+    multifd_send_prepare_iovs(p);
+    p->flags |= MULTIFD_FLAG_NOCOMP;
+
+    multifd_send_fill_packet(p);
+
+    if (use_zero_copy_send) {
+        /* Send header first, without zerocopy */
+        ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                    p->packet_len, errp);
+        if (ret != 0) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static int ram_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    p->iov = g_new0(struct iovec, multifd_ram_page_count());
+    return 0;
+}
+
+static void ram_recv_cleanup(MultiFDRecvParams *p)
+{
+    g_free(p->iov);
+    p->iov = NULL;
+}
+
+static int ram_recv(MultiFDRecvParams *p, Error **errp)
+{
+    uint32_t flags;
+
+    if (migrate_mapped_ram()) {
+        return multifd_file_recv_data(p, errp);
+    }
+
+    flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+
+    if (flags != MULTIFD_FLAG_NOCOMP) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_NOCOMP);
+        return -1;
+    }
+
+    multifd_recv_zero_page_process(p);
+
+    if (!p->normal_num) {
+        return 0;
+    }
+
+    for (int i = 0; i < p->normal_num; i++) {
+        p->iov[i].iov_base = p->host + p->normal[i];
+        p->iov[i].iov_len = multifd_ram_page_size();
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
+    }
+    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+}
+
+static void multifd_pages_reset(MultiFDPages_t *pages)
+{
+    /*
+     * We don't need to touch offset[] array, because it will be
+     * overwritten later when reused.
+     */
+    pages->num = 0;
+    pages->normal_num = 0;
+    pages->block = NULL;
+}
+
+void multifd_ram_fill_packet(MultiFDSendParams *p)
+{
+    MultiFDPacket_t *packet = p->packet;
+    MultiFDPages_t *pages = &p->data->u.ram;
+    uint32_t zero_num = pages->num - pages->normal_num;
+
+    packet->pages_alloc = cpu_to_be32(multifd_ram_page_count());
+    packet->normal_pages = cpu_to_be32(pages->normal_num);
+    packet->zero_pages = cpu_to_be32(zero_num);
+
+    if (pages->block) {
+        strncpy(packet->ramblock, pages->block->idstr, 256);
+    }
+
+    for (int i = 0; i < pages->num; i++) {
+        /* there are architectures where ram_addr_t is 32 bit */
+        uint64_t temp = pages->offset[i];
+
+        packet->offset[i] = cpu_to_be64(temp);
+    }
+
+    p->total_normal_pages += pages->normal_num;
+    p->total_zero_pages += zero_num;
+
+    trace_multifd_send_ram_fill(p->id, p->total_normal_pages,
+                                p->total_zero_pages);
+}
+
+int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
+{
+    MultiFDPacket_t *packet = p->packet;
+    uint32_t page_count = multifd_ram_page_count();
+    uint32_t page_size = multifd_ram_page_size();
+    int i;
+
+    packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
+    /*
+     * If we received a packet that is 100 times bigger than expected
+     * just stop migration.  It is a magic number.
+     */
+    if (packet->pages_alloc > page_count) {
+        error_setg(errp, "multifd: received packet "
+                   "with size %u and expected a size of %u",
+                   packet->pages_alloc, page_count) ;
+        return -1;
+    }
+
+    p->normal_num = be32_to_cpu(packet->normal_pages);
+    if (p->normal_num > packet->pages_alloc) {
+        error_setg(errp, "multifd: received packet "
+                   "with %u normal pages and expected maximum pages are %u",
+                   p->normal_num, packet->pages_alloc) ;
+        return -1;
+    }
+
+    p->zero_num = be32_to_cpu(packet->zero_pages);
+    if (p->zero_num > packet->pages_alloc - p->normal_num) {
+        error_setg(errp, "multifd: received packet "
+                   "with %u zero pages and expected maximum zero pages are %u",
+                   p->zero_num, packet->pages_alloc - p->normal_num) ;
+        return -1;
+    }
+
+    p->total_normal_pages += p->normal_num;
+    p->total_zero_pages += p->zero_num;
+
+    if (p->normal_num == 0 && p->zero_num == 0) {
+        return 0;
+    }
+
+    /* make sure that ramblock is 0 terminated */
+    packet->ramblock[255] = 0;
+    p->block = qemu_ram_block_by_name(packet->ramblock);
+    if (!p->block) {
+        error_setg(errp, "multifd: unknown ram block %s",
+                   packet->ramblock);
+        return -1;
+    }
+
+    p->host = p->block->host;
+    for (i = 0; i < p->normal_num; i++) {
+        uint64_t offset = be64_to_cpu(packet->offset[i]);
+
+        if (offset > (p->block->used_length - page_size)) {
+            error_setg(errp, "multifd: offset too long %" PRIu64
+                       " (max " RAM_ADDR_FMT ")",
+                       offset, p->block->used_length);
+            return -1;
+        }
+        p->normal[i] = offset;
+    }
+
+    for (i = 0; i < p->zero_num; i++) {
+        uint64_t offset = be64_to_cpu(packet->offset[p->normal_num + i]);
+
+        if (offset > (p->block->used_length - page_size)) {
+            error_setg(errp, "multifd: offset too long %" PRIu64
+                       " (max " RAM_ADDR_FMT ")",
+                       offset, p->block->used_length);
+            return -1;
+        }
+        p->zero[i] = offset;
+    }
+
+    return 0;
+}
+
+static inline bool multifd_queue_empty(MultiFDPages_t *pages)
+{
+    return pages->num == 0;
+}
+
+static inline bool multifd_queue_full(MultiFDPages_t *pages)
+{
+    return pages->num == multifd_ram_page_count();
+}
+
+static inline void multifd_enqueue(MultiFDPages_t *pages, ram_addr_t offset)
+{
+    pages->offset[pages->num++] = offset;
+}
+
+/* Returns true if enqueue successful, false otherwise */
+bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
+{
+    MultiFDPages_t *pages;
+
+retry:
+    pages = &multifd_ram_send->u.ram;
+
+    if (multifd_payload_empty(multifd_ram_send)) {
+        multifd_pages_reset(pages);
+        multifd_set_payload_type(multifd_ram_send, MULTIFD_PAYLOAD_RAM);
+    }
+
+    /* If the queue is empty, we can already enqueue now */
+    if (multifd_queue_empty(pages)) {
+        pages->block = block;
+        multifd_enqueue(pages, offset);
+        return true;
+    }
+
+    /*
+     * Not empty, meanwhile we need a flush.  It can because of either:
+     *
+     * (1) The page is not on the same ramblock of previous ones, or,
+     * (2) The queue is full.
+     *
+     * After flush, always retry.
+     */
+    if (pages->block != block || multifd_queue_full(pages)) {
+        if (!multifd_send(&multifd_ram_send)) {
+            return false;
+        }
+        goto retry;
+    }
+
+    /* Not empty, and we still have space, do it! */
+    multifd_enqueue(pages, offset);
+    return true;
+}
+
+int multifd_ram_flush_and_sync(void)
+{
+    if (!migrate_multifd()) {
+        return 0;
+    }
+
+    if (!multifd_payload_empty(multifd_ram_send)) {
+        if (!multifd_send(&multifd_ram_send)) {
+            error_report("%s: multifd_send fail", __func__);
+            return -1;
+        }
+    }
+
+    return multifd_send_sync_main();
+}
+
+bool multifd_send_prepare_common(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = &p->data->u.ram;
+    multifd_send_zero_page_detect(p);
+
+    if (!pages->normal_num) {
+        p->next_packet_size = 0;
+        return false;
+    }
+
+    multifd_send_prepare_header(p);
+
+    return true;
+}
+
+static MultiFDMethods multifd_ram_ops = {
+    .send_setup = ram_send_setup,
+    .send_cleanup = ram_send_cleanup,
+    .send_prepare = ram_send_prepare,
+    .recv_setup = ram_recv_setup,
+    .recv_cleanup = ram_recv_cleanup,
+    .recv = ram_recv
+};
+
+static void multifd_ram_register(void)
+{
+    multifd_register_ops(MULTIFD_COMPRESSION_NONE, &multifd_ram_ops);
+}
+
+migration_init(multifd_ram_register);
diff --git a/migration/multifd.c b/migration/multifd.c
index d5be784b6f..99197d6174 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -96,20 +96,7 @@ struct {
     MultiFDMethods *ops;
 } *multifd_recv_state;
 
-static MultiFDSendData *multifd_ram_send;
-
-static size_t multifd_ram_payload_size(void)
-{
-    uint32_t n = multifd_ram_page_count();
-
-    /*
-     * We keep an array of page offsets at the end of MultiFDPages_t,
-     * add space for it in the allocation.
-     */
-    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
-}
-
-static MultiFDSendData *multifd_send_data_alloc(void)
+MultiFDSendData *multifd_send_data_alloc(void)
 {
     size_t max_payload_size, size_minus_payload;
 
@@ -131,17 +118,6 @@ static MultiFDSendData *multifd_send_data_alloc(void)
     return g_malloc0(size_minus_payload + max_payload_size);
 }
 
-void multifd_ram_save_setup(void)
-{
-    multifd_ram_send = multifd_send_data_alloc();
-}
-
-void multifd_ram_save_cleanup(void)
-{
-    g_free(multifd_ram_send);
-    multifd_ram_send = NULL;
-}
-
 static bool multifd_use_packets(void)
 {
     return !migrate_mapped_ram();
@@ -152,141 +128,6 @@ void multifd_send_channel_created(void)
     qemu_sem_post(&multifd_send_state->channels_created);
 }
 
-static void multifd_set_file_bitmap(MultiFDSendParams *p)
-{
-    MultiFDPages_t *pages = &p->data->u.ram;
-
-    assert(pages->block);
-
-    for (int i = 0; i < pages->normal_num; i++) {
-        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], true);
-    }
-
-    for (int i = pages->normal_num; i < pages->num; i++) {
-        ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], false);
-    }
-}
-
-static int ram_send_setup(MultiFDSendParams *p, Error **errp)
-{
-    uint32_t page_count = multifd_ram_page_count();
-
-    if (migrate_zero_copy_send()) {
-        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
-    }
-
-    if (multifd_use_packets()) {
-        /* We need one extra place for the packet header */
-        p->iov = g_new0(struct iovec, page_count + 1);
-    } else {
-        p->iov = g_new0(struct iovec, page_count);
-    }
-
-    return 0;
-}
-
-static void ram_send_cleanup(MultiFDSendParams *p, Error **errp)
-{
-    g_free(p->iov);
-    p->iov = NULL;
-    return;
-}
-
-static void multifd_send_prepare_iovs(MultiFDSendParams *p)
-{
-    MultiFDPages_t *pages = &p->data->u.ram;
-    uint32_t page_size = multifd_ram_page_size();
-
-    for (int i = 0; i < pages->normal_num; i++) {
-        p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
-        p->iov[p->iovs_num].iov_len = page_size;
-        p->iovs_num++;
-    }
-
-    p->next_packet_size = pages->normal_num * page_size;
-}
-
-static int ram_send_prepare(MultiFDSendParams *p, Error **errp)
-{
-    bool use_zero_copy_send = migrate_zero_copy_send();
-    int ret;
-
-    multifd_send_zero_page_detect(p);
-
-    if (!multifd_use_packets()) {
-        multifd_send_prepare_iovs(p);
-        multifd_set_file_bitmap(p);
-
-        return 0;
-    }
-
-    if (!use_zero_copy_send) {
-        /*
-         * Only !zerocopy needs the header in IOV; zerocopy will
-         * send it separately.
-         */
-        multifd_send_prepare_header(p);
-    }
-
-    multifd_send_prepare_iovs(p);
-    p->flags |= MULTIFD_FLAG_NOCOMP;
-
-    multifd_send_fill_packet(p);
-
-    if (use_zero_copy_send) {
-        /* Send header first, without zerocopy */
-        ret = qio_channel_write_all(p->c, (void *)p->packet,
-                                    p->packet_len, errp);
-        if (ret != 0) {
-            return -1;
-        }
-    }
-
-    return 0;
-}
-
-static int ram_recv_setup(MultiFDRecvParams *p, Error **errp)
-{
-    p->iov = g_new0(struct iovec, multifd_ram_page_count());
-    return 0;
-}
-
-static void ram_recv_cleanup(MultiFDRecvParams *p)
-{
-    g_free(p->iov);
-    p->iov = NULL;
-}
-
-static int ram_recv(MultiFDRecvParams *p, Error **errp)
-{
-    uint32_t flags;
-
-    if (!multifd_use_packets()) {
-        return multifd_file_recv_data(p, errp);
-    }
-
-    flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
-
-    if (flags != MULTIFD_FLAG_NOCOMP) {
-        error_setg(errp, "multifd %u: flags received %x flags expected %x",
-                   p->id, flags, MULTIFD_FLAG_NOCOMP);
-        return -1;
-    }
-
-    multifd_recv_zero_page_process(p);
-
-    if (!p->normal_num) {
-        return 0;
-    }
-
-    for (int i = 0; i < p->normal_num; i++) {
-        p->iov[i].iov_base = p->host + p->normal[i];
-        p->iov[i].iov_len = multifd_ram_page_size();
-        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
-    }
-    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
-}
-
 static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {};
 
 void multifd_register_ops(int method, MultiFDMethods *ops)
@@ -299,18 +140,6 @@ void multifd_register_ops(int method, MultiFDMethods *ops)
     multifd_ops[method] = ops;
 }
 
-/* Reset a MultiFDPages_t* object for the next use */
-static void multifd_pages_reset(MultiFDPages_t *pages)
-{
-    /*
-     * We don't need to touch offset[] array, because it will be
-     * overwritten later when reused.
-     */
-    pages->num = 0;
-    pages->normal_num = 0;
-    pages->block = NULL;
-}
-
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
 {
     MultiFDInit_t msg = {};
@@ -375,34 +204,6 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
     return msg.id;
 }
 
-static void multifd_ram_fill_packet(MultiFDSendParams *p)
-{
-    MultiFDPacket_t *packet = p->packet;
-    MultiFDPages_t *pages = &p->data->u.ram;
-    uint32_t zero_num = pages->num - pages->normal_num;
-
-    packet->pages_alloc = cpu_to_be32(multifd_ram_page_count());
-    packet->normal_pages = cpu_to_be32(pages->normal_num);
-    packet->zero_pages = cpu_to_be32(zero_num);
-
-    if (pages->block) {
-        strncpy(packet->ramblock, pages->block->idstr, 256);
-    }
-
-    for (int i = 0; i < pages->num; i++) {
-        /* there are architectures where ram_addr_t is 32 bit */
-        uint64_t temp = pages->offset[i];
-
-        packet->offset[i] = cpu_to_be64(temp);
-    }
-
-    p->total_normal_pages += pages->normal_num;
-    p->total_zero_pages += zero_num;
-
-    trace_multifd_send_ram_fill(p->id, p->total_normal_pages,
-                                p->total_zero_pages);
-}
-
 void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
@@ -430,85 +231,6 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
                             p->flags, p->next_packet_size);
 }
 
-static int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
-{
-    MultiFDPacket_t *packet = p->packet;
-    uint32_t page_count = multifd_ram_page_count();
-    uint32_t page_size = multifd_ram_page_size();
-    int i;
-
-    packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
-    /*
-     * If we received a packet that is 100 times bigger than expected
-     * just stop migration.  It is a magic number.
-     */
-    if (packet->pages_alloc > page_count) {
-        error_setg(errp, "multifd: received packet "
-                   "with size %u and expected a size of %u",
-                   packet->pages_alloc, page_count) ;
-        return -1;
-    }
-
-    p->normal_num = be32_to_cpu(packet->normal_pages);
-    if (p->normal_num > packet->pages_alloc) {
-        error_setg(errp, "multifd: received packet "
-                   "with %u normal pages and expected maximum pages are %u",
-                   p->normal_num, packet->pages_alloc) ;
-        return -1;
-    }
-
-    p->zero_num = be32_to_cpu(packet->zero_pages);
-    if (p->zero_num > packet->pages_alloc - p->normal_num) {
-        error_setg(errp, "multifd: received packet "
-                   "with %u zero pages and expected maximum zero pages are %u",
-                   p->zero_num, packet->pages_alloc - p->normal_num) ;
-        return -1;
-    }
-
-    p->total_normal_pages += p->normal_num;
-    p->total_zero_pages += p->zero_num;
-
-    if (p->normal_num == 0 && p->zero_num == 0) {
-        return 0;
-    }
-
-    /* make sure that ramblock is 0 terminated */
-    packet->ramblock[255] = 0;
-    p->block = qemu_ram_block_by_name(packet->ramblock);
-    if (!p->block) {
-        error_setg(errp, "multifd: unknown ram block %s",
-                   packet->ramblock);
-        return -1;
-    }
-
-    p->host = p->block->host;
-    for (i = 0; i < p->normal_num; i++) {
-        uint64_t offset = be64_to_cpu(packet->offset[i]);
-
-        if (offset > (p->block->used_length - page_size)) {
-            error_setg(errp, "multifd: offset too long %" PRIu64
-                       " (max " RAM_ADDR_FMT ")",
-                       offset, p->block->used_length);
-            return -1;
-        }
-        p->normal[i] = offset;
-    }
-
-    for (i = 0; i < p->zero_num; i++) {
-        uint64_t offset = be64_to_cpu(packet->offset[p->normal_num + i]);
-
-        if (offset > (p->block->used_length - page_size)) {
-            error_setg(errp, "multifd: offset too long %" PRIu64
-                       " (max " RAM_ADDR_FMT ")",
-                       offset, p->block->used_length);
-            return -1;
-        }
-        p->zero[i] = offset;
-    }
-
-    return 0;
-}
-
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
 {
     MultiFDPacket_t *packet = p->packet;
@@ -581,7 +303,7 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
  *
  * Returns true if succeed, false otherwise.
  */
-static bool multifd_send(MultiFDSendData **send_data)
+bool multifd_send(MultiFDSendData **send_data)
 {
     int i;
     static int next_channel;
@@ -642,61 +364,6 @@ static bool multifd_send(MultiFDSendData **send_data)
     return true;
 }
 
-static inline bool multifd_queue_empty(MultiFDPages_t *pages)
-{
-    return pages->num == 0;
-}
-
-static inline bool multifd_queue_full(MultiFDPages_t *pages)
-{
-    return pages->num == multifd_ram_page_count();
-}
-
-static inline void multifd_enqueue(MultiFDPages_t *pages, ram_addr_t offset)
-{
-    pages->offset[pages->num++] = offset;
-}
-
-/* Returns true if enqueue successful, false otherwise */
-bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
-{
-    MultiFDPages_t *pages;
-
-retry:
-    pages = &multifd_ram_send->u.ram;
-
-    if (multifd_payload_empty(multifd_ram_send)) {
-        multifd_pages_reset(pages);
-        multifd_set_payload_type(multifd_ram_send, MULTIFD_PAYLOAD_RAM);
-    }
-
-    /* If the queue is empty, we can already enqueue now */
-    if (multifd_queue_empty(pages)) {
-        pages->block = block;
-        multifd_enqueue(pages, offset);
-        return true;
-    }
-
-    /*
-     * Not empty, meanwhile we need a flush.  It can because of either:
-     *
-     * (1) The page is not on the same ramblock of previous ones, or,
-     * (2) The queue is full.
-     *
-     * After flush, always retry.
-     */
-    if (pages->block != block || multifd_queue_full(pages)) {
-        if (!multifd_send(&multifd_ram_send)) {
-            return false;
-        }
-        goto retry;
-    }
-
-    /* Not empty, and we still have space, do it! */
-    multifd_enqueue(pages, offset);
-    return true;
-}
-
 /* Multifd send side hit an error; remember it and prepare to quit */
 static void multifd_send_set_error(Error *err)
 {
@@ -860,22 +527,6 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
-int multifd_ram_flush_and_sync(void)
-{
-    if (!migrate_multifd()) {
-        return 0;
-    }
-
-    if (!multifd_payload_empty(multifd_ram_send)) {
-        if (!multifd_send(&multifd_ram_send)) {
-            error_report("%s: multifd_send fail", __func__);
-            return -1;
-        }
-    }
-
-    return multifd_send_sync_main();
-}
-
 int multifd_send_sync_main(void)
 {
     int i;
@@ -1679,34 +1330,3 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
                        QEMU_THREAD_JOINABLE);
     qatomic_inc(&multifd_recv_state->count);
 }
-
-bool multifd_send_prepare_common(MultiFDSendParams *p)
-{
-    MultiFDPages_t *pages = &p->data->u.ram;
-    multifd_send_zero_page_detect(p);
-
-    if (!pages->normal_num) {
-        p->next_packet_size = 0;
-        return false;
-    }
-
-    multifd_send_prepare_header(p);
-
-    return true;
-}
-
-static MultiFDMethods multifd_ram_ops = {
-    .send_setup = ram_send_setup,
-    .send_cleanup = ram_send_cleanup,
-    .send_prepare = ram_send_prepare,
-    .recv_setup = ram_recv_setup,
-    .recv_cleanup = ram_recv_cleanup,
-    .recv = ram_recv
-};
-
-static void multifd_ram_register(void)
-{
-    multifd_register_ops(MULTIFD_COMPRESSION_NONE, &multifd_ram_ops);
-}
-
-migration_init(multifd_ram_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index 19a43d46c0..2197d0b44f 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -265,6 +265,8 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 }
 
 void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
+bool multifd_send(MultiFDSendData **send_data);
+MultiFDSendData *multifd_send_data_alloc(void);
 
 static inline uint32_t multifd_ram_page_size(void)
 {
@@ -279,4 +281,7 @@ static inline uint32_t multifd_ram_page_count(void)
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
 int multifd_ram_flush_and_sync(void);
+size_t multifd_ram_payload_size(void);
+void multifd_ram_fill_packet(MultiFDSendParams *p);
+int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
 #endif
-- 
2.35.3


