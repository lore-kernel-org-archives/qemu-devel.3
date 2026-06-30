Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D00DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 03:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weOuv-0003qy-Dw; Mon, 29 Jun 2026 23:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1weOus-0003qq-Bm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 23:13:42 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1weOup-0004xm-SX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 23:13:42 -0400
X-UUID: a918968c743111f1aa26b74ffac11d73-20260630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:73ed7dae-0ecd-43e9-b4fd-0a627f164988, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-20
X-CID-META: VersionHash:e7bac3a, CLOUDID:4c8188da0a0040f07424b0111c771cad,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
 DM:1|19,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
 SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a918968c743111f1aa26b74ffac11d73-20260630
X-User: yujun@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yujun@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 38957374; Tue, 30 Jun 2026 11:13:26 +0800
From: yujun <yujun@kylinos.cn>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
	qemu-devel@nongnu.org
Subject: [PATCH] migration: Fix invalid %ud format and trace arg typo
Date: Tue, 30 Jun 2026 11:13:24 +0800
Message-Id: <20260630031324.43453-1-yujun@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=yujun@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Standard printf has no %ud conversion; glibc treats it as %u followed
by a literal 'd', so postcopy userfaultfd error messages printed event
values like "5d" instead of "5".  The same typo existed in two postcopy
discard trace format strings.

Also rename the misspelled ram_save_iterate_big_wait() trace argument
milliconds to milliseconds.

Fixes: 00fa4fc85b ("postcopy: Allow registering of fd handler")
Signed-off-by: yujun <yujun@kylinos.cn>
---
 migration/postcopy-ram.c | 4 ++--
 migration/trace-events   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f5ef93f193..980b938a4c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1368,7 +1368,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
                 }
             }
             if (msg.event != UFFD_EVENT_PAGEFAULT) {
-                error_report("%s: Read unexpected event %ud from userfaultfd",
+                error_report("%s: Read unexpected event %u from userfaultfd",
                              __func__, msg.event);
                 continue; /* It's not a page fault, shouldn't happen */
             }
@@ -1443,7 +1443,7 @@ retry:
                     }
                 }
                 if (msg.event != UFFD_EVENT_PAGEFAULT) {
-                    error_report("%s: Read unexpected event %ud "
+                    error_report("%s: Read unexpected event %u "
                                  "from userfaultfd (shared)",
                                  __func__, msg.event);
                     continue; /* It's not a page fault, shouldn't happen */
diff --git a/migration/trace-events b/migration/trace-events
index de99d976ab..3b1258c3bf 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -21,14 +21,14 @@ loadvm_postcopy_handle_run(void) ""
 loadvm_postcopy_handle_resume(void) ""
 loadvm_postcopy_ram_handle_discard(void) ""
 loadvm_postcopy_ram_handle_discard_end(void) ""
-loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
+loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %u"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
 loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
-qemu_savevm_send_postcopy_ram_discard(const char *id, uint16_t len) "%s: %ud"
+qemu_savevm_send_postcopy_ram_discard(const char *id, uint16_t len) "%s: %u"
 savevm_command_send(uint16_t command, uint16_t len) "com=0x%x len=%d"
 savevm_section_start(const char *id, unsigned int section_id) "%s, section_id %u"
 savevm_section_end(const char *id, unsigned int section_id, int ret) "%s, section_id %u -> %d"
@@ -119,7 +119,7 @@ colo_flush_ram_cache_begin(uint64_t dirty_pages) "dirty_pages %" PRIu64
 colo_flush_ram_cache_end(void) ""
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
-ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
+ram_save_iterate_big_wait(uint64_t milliseconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
 ram_load_start(void) ""
 ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
 ram_write_tracking_ramblock_start(const char *block_id, size_t page_size, void *addr, size_t length) "%s: page_size: %zu addr: %p length: %zu"
-- 
2.25.1


