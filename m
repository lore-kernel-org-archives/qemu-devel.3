Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFCEC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUkJ-0001Jm-R1; Mon, 27 May 2024 03:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUji-0008NH-1e; Mon, 27 May 2024 03:25:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBUjb-0006Nr-8p; Mon, 27 May 2024 03:25:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB6BD6A4CD;
 Mon, 27 May 2024 10:25:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 365BCD846A;
 Mon, 27 May 2024 10:24:36 +0300 (MSK)
Received: (nullmailer pid 52918 invoked by uid 1000);
 Mon, 27 May 2024 07:24:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 16/21] target/loongarch/kvm: Fix VM recovery from disk
 failures
Date: Mon, 27 May 2024 10:24:26 +0300
Message-Id: <20240527072435.52812-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240527072014@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Song Gao <gaosong@loongson.cn>

vmstate does not save kvm_state_conter,
which can cause VM recovery from disk to fail.

Cc: qemu-stable@nongnu.org
Signed-off-by: Song Gao <gaosong@loongson.cn>
Acked-by: Peter Xu <peterx@redhat.com>
Message-Id: <20240508024732.3127792-1-gaosong@loongson.cn>
(cherry picked from commit 0eb285c3627b5406dd91bfa3b47402e5de92123f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: adjust context for v8.2.0-205-g2d23bb1a3805
  "target/loongarch: Constify VMState in machine.c")

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 1c4e01d076..5a7df713e2 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -125,8 +125,8 @@ const VMStateDescription vmstate_tlb = {
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
@@ -191,6 +191,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
                              0, vmstate_tlb, LoongArchTLB),
 
+        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
+
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription*[]) {
-- 
2.39.2


