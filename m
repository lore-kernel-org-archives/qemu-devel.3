Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5385C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TF-0004GW-5t; Wed, 17 Jul 2024 07:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2ST-0000rA-PA
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:36 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SQ-000716-B2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:29 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 2D1CE37962B; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 13/26] hw/display/apple-gfx: Defines PGTask_s struct instead
 of casting
Date: Mon, 15 Jul 2024 23:06:52 +0200
Message-Id: <20240715210705.32365-14-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

The struct PGTask_s is only forward-declared by the macOS
ParavirtualizedGraphics.framework and treated as opaque, which
means client code can safely provide its own definition.

This change does exactly that, renaming struct AppleGFXTask to
PGTask_s, but keeping the original typedef name. The upshot are
improved type safety and fewer casts.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index a23f731ddc..39e33ed999 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -62,13 +62,13 @@ -(uint32_t)mmioReadAtOffset:(size_t) offset;
 -(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;
 @end
 
-typedef struct AppleGFXTask {
-    QTAILQ_ENTRY(AppleGFXTask) node;
+typedef struct PGTask_s { // Name matches forward declaration in PG header
+    QTAILQ_ENTRY(PGTask_s) node;
     mach_vm_address_t address;
     uint64_t len;
 } AppleGFXTask;
 
-typedef QTAILQ_HEAD(, AppleGFXTask) AppleGFXTaskList;
+typedef QTAILQ_HEAD(, PGTask_s) AppleGFXTaskList;
 
 typedef struct AppleGFXState {
     SysBusDevice parent_obj;
@@ -384,19 +384,19 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         AppleGFXTask *task = apple_gfx_new_task(s, vmSize);
         *baseAddress = (void*)task->address;
         trace_apple_gfx_create_task(vmSize, *baseAddress);
-        return (PGTask_t *)task;
+        return task;
     };
 
-    desc.destroyTask = ^(PGTask_t * _Nonnull _task) {
-        AppleGFXTask *task = (AppleGFXTask *)_task;
+    desc.destroyTask = ^(AppleGFXTask * _Nonnull task) {
         trace_apple_gfx_destroy_task(task);
         QTAILQ_REMOVE(&s->tasks, task, node);
         mach_vm_deallocate(mach_task_self(), task->address, task->len);
         g_free(task);
     };
 
-    desc.mapMemory = ^(PGTask_t * _Nonnull _task, uint32_t rangeCount, uint64_t virtualOffset, bool readOnly, PGPhysicalMemoryRange_t * _Nonnull ranges) {
-        AppleGFXTask *task = (AppleGFXTask*)_task;
+    desc.mapMemory = ^(AppleGFXTask * _Nonnull task, uint32_t rangeCount,
+                       uint64_t virtualOffset, bool readOnly,
+                       PGPhysicalMemoryRange_t * _Nonnull ranges) {
         kern_return_t r;
         mach_vm_address_t target, source;
         trace_apple_gfx_map_memory(task, rangeCount, virtualOffset, readOnly);
@@ -433,8 +433,8 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         return (bool)true;
     };
 
-    desc.unmapMemory = ^(PGTask_t * _Nonnull _task, uint64_t virtualOffset, uint64_t length) {
-        AppleGFXTask *task = (AppleGFXTask *)_task;
+    desc.unmapMemory = ^(AppleGFXTask * _Nonnull task, uint64_t virtualOffset,
+                         uint64_t length) {
         kern_return_t r;
         mach_vm_address_t range_address;
 
-- 
2.39.3 (Apple Git-146)


