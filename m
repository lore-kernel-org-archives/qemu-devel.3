Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C21CF3943
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srHUd-0007ec-Uy; Thu, 19 Sep 2024 09:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUU-00078G-Sc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:39 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1srHUQ-00060C-UT
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=Ms2aBAQ13vf0pUFCc2B0msBVzqbN2IXx+OGBi5iEVWk=; b=sCaWngQK1cv1KaXT
 nYVu+vgsWJLvBnHFQ0IcHWRnY7x7FJ1EPo6La4sFs7S1zyCILWW8OFUYVK8c66neS7qJP5wdHc1/w
 ss+jqlZWJhQnbiEuk8bFvYI51X0Rvfgudy4nIa7/5Y8Cw9CoOV+ZCsAN6g1qUvSQaoO8YMYQCpBNF
 /T8vI0SKfIiU5y4X1mL0Dw1VbFD3SIoJ6Qz9zLjjbcrvrbChW63hM5nLqJVO+LUPh9YDl0/jlQJSY
 r48jfUR2fv/6OKpVThE2jys1lWLtu8ccohqMKIQmEVPsKEoMcEwU03onLBGXNkmwdw4SmmVjXlRGN
 G7GjPonexS0qK4GhdQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1srHUN-006QOJ-2y;
 Thu, 19 Sep 2024 13:46:31 +0000
From: dave@treblig.org
To: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 6/7] migration/postcopy: Use uffd helpers
Date: Thu, 19 Sep 2024 14:46:25 +0100
Message-ID: <20240919134626.166183-7-dave@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240919134626.166183-1-dave@treblig.org>
References: <20240919134626.166183-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

Use the uffd_copy_page, uffd_zero_page and uffd_wakeup helpers
rather than calling ioctl ourselves.

They return -errno on error, and print an error_report themselves.
I think this actually makes postcopy_place_page actually more
consistent in it's callers.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 migration/postcopy-ram.c | 47 +++++++++++-----------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 1c374b7ea1..e2b318d3da 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -746,18 +746,9 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                          RAMBlock *rb)
 {
     size_t pagesize = qemu_ram_pagesize(rb);
-    struct uffdio_range range;
-    int ret;
     trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
-    range.start = ROUND_DOWN(client_addr, pagesize);
-    range.len = pagesize;
-    ret = ioctl(pcfd->fd, UFFDIO_WAKE, &range);
-    if (ret) {
-        error_report("%s: Failed to wake: %zx in %s (%s)",
-                     __func__, (size_t)client_addr, qemu_ram_get_idstr(rb),
-                     strerror(errno));
-    }
-    return ret;
+    return uffd_wakeup(pcfd->fd, (void *)ROUND_DOWN(client_addr, pagesize),
+                       pagesize);
 }
 
 static int postcopy_request_page(MigrationIncomingState *mis, RAMBlock *rb,
@@ -1275,18 +1266,10 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
     int ret;
 
     if (from_addr) {
-        struct uffdio_copy copy_struct;
-        copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
-        copy_struct.src = (uint64_t)(uintptr_t)from_addr;
-        copy_struct.len = pagesize;
-        copy_struct.mode = 0;
-        ret = ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
+        ret = uffd_copy_page(userfault_fd, host_addr, from_addr, pagesize,
+                             false);
     } else {
-        struct uffdio_zeropage zero_struct;
-        zero_struct.range.start = (uint64_t)(uintptr_t)host_addr;
-        zero_struct.range.len = pagesize;
-        zero_struct.mode = 0;
-        ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
+        ret = uffd_zero_page(userfault_fd, host_addr, pagesize, false);
     }
     if (!ret) {
         qemu_mutex_lock(&mis->page_request_mutex);
@@ -1343,18 +1326,16 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
                         RAMBlock *rb)
 {
     size_t pagesize = qemu_ram_pagesize(rb);
+    int e;
 
     /* copy also acks to the kernel waking the stalled thread up
      * TODO: We can inhibit that ack and only do it if it was requested
      * which would be slightly cheaper, but we'd have to be careful
      * of the order of updating our page state.
      */
-    if (qemu_ufd_copy_ioctl(mis, host, from, pagesize, rb)) {
-        int e = errno;
-        error_report("%s: %s copy host: %p from: %p (size: %zd)",
-                     __func__, strerror(e), host, from, pagesize);
-
-        return -e;
+    e = qemu_ufd_copy_ioctl(mis, host, from, pagesize, rb);
+    if (e) {
+        return e;
     }
 
     trace_postcopy_place_page(host);
@@ -1376,12 +1357,10 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
      * but it's not available for everything (e.g. hugetlbpages)
      */
     if (qemu_ram_is_uf_zeroable(rb)) {
-        if (qemu_ufd_copy_ioctl(mis, host, NULL, pagesize, rb)) {
-            int e = errno;
-            error_report("%s: %s zero host: %p",
-                         __func__, strerror(e), host);
-
-            return -e;
+        int e;
+        e = qemu_ufd_copy_ioctl(mis, host, NULL, pagesize, rb);
+        if (e) {
+            return e;
         }
         return postcopy_notify_shared_wake(rb,
                                            qemu_ram_block_host_offset(rb,
-- 
2.46.1


