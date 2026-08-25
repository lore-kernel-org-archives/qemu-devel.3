Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BFAC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyrE-0005vi-Hm; Tue, 25 Aug 2026 17:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrD-0005vH-Hp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:59 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyrB-00057o-QH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 389C3C0962;
 Wed, 26 Aug 2026 00:38:56 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-unjOXrR1; Wed, 26 Aug 2026 00:38:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693935;
 bh=lSGcV4CN3muTEJ3v+Jy/X7vfKCkrj8mQ8Jiw/LwoRME=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IQgNB5BR00fL6zU7txE8MkXHxpjdNbZXW9eNEcIhtxzvlV2GPqo638pQfh0PnaLR/
 ISJmzK8fc6HOzZsyGyy657Fi1pZ/8r4fDookOiEHm+wO8iJxd0wUIoByHJRvS3Y5wN
 KXNZCC1lb7NHIDXPCcX9qNe2mlfwRSjE/jH0iIW4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 26/30] mips/machine: move to new migration APIs
Date: Wed, 26 Aug 2026 00:38:06 +0300
Message-ID: <20260825213811.3725682-27-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 target/mips/system/machine.c | 49 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index bd1e4002cfd..dc8a9920e5a 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -22,8 +22,8 @@ static int cpu_post_load(void *opaque, int version_id)
 
 /* FPU state */
 
-static int get_fpr(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field)
+static bool load_fpr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     int i;
     fpr_t *v = pv;
@@ -31,11 +31,11 @@ static int get_fpr(QEMUFile *f, void *pv, size_t size,
     for (i = 0; i < MSA_WRLEN / 64; i++) {
         qemu_get_sbe64s(f, &v->wr.d[i]);
     }
-    return 0;
+    return true;
 }
 
-static int put_fpr(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_fpr(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc, Error **errp)
 {
     int i;
     fpr_t *v = pv;
@@ -44,13 +44,13 @@ static int put_fpr(QEMUFile *f, void *pv, size_t size,
         qemu_put_sbe64s(f, &v->wr.d[i]);
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_fpr = {
     .name = "fpr",
-    .get  = get_fpr,
-    .put  = put_fpr,
+    .load = load_fpr,
+    .save = save_fpr,
 };
 
 #define VMSTATE_FPR_ARRAY_V(_f, _s, _n, _v)                     \
@@ -145,8 +145,9 @@ static gboolean put_octeon_llm_tree_entry(gpointer key, gpointer value,
     return false;
 }
 
-static int put_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
-                               const VMStateField *field, JSONWriter *vmdesc)
+static bool save_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
+                                 const VMStateField *field,
+                                 JSONWriter *vmdesc, Error **errp)
 {
     QTree *tree = *(QTree **)pv;
     OcteonLLMTreePutData data = { .f = f };
@@ -157,11 +158,11 @@ static int put_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
         q_tree_foreach(tree, put_octeon_llm_tree_entry, &data);
     }
 
-    return 0;
+    return true;
 }
 
-static int get_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
-                               const VMStateField *field)
+static bool load_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, Error **errp)
 {
     QTree **treep = pv;
     uint32_t nnodes = qemu_get_be32(f);
@@ -178,13 +179,13 @@ static int get_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
         mips_octeon_llm_store(treep, addr, value);
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_octeon_llm_tree = {
     .name = "octeon_llm_tree",
-    .get = get_octeon_llm_tree,
-    .put = put_octeon_llm_tree,
+    .load = load_octeon_llm_tree,
+    .save = save_octeon_llm_tree,
 };
 
 #define VMSTATE_OCTEON_LLM_TREE(_f, _s) {                         \
@@ -210,8 +211,8 @@ static const VMStateDescription vmstate_mvp = {
 
 /* TLB state */
 
-static int get_tlb(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field)
+static bool load_tlb(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     r4k_tlb_t *v = pv;
     uint16_t flags;
@@ -240,11 +241,11 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size,
     qemu_get_be64s(f, &v->PFN[0]);
     qemu_get_be64s(f, &v->PFN[1]);
 
-    return 0;
+    return true;
 }
 
-static int put_tlb(QEMUFile *f, void *pv, size_t size,
-                   const VMStateField *field, JSONWriter *vmdesc)
+static bool save_tlb(QEMUFile *f, void *pv, size_t size,
+                   const VMStateField *field, JSONWriter *vmdesc, Error **errp)
 {
     r4k_tlb_t *v = pv;
 
@@ -275,13 +276,13 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
     qemu_put_be64s(f, &v->PFN[0]);
     qemu_put_be64s(f, &v->PFN[1]);
 
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_tlb = {
     .name = "tlb_entry",
-    .get  = get_tlb,
-    .put  = put_tlb,
+    .load = load_tlb,
+    .save = save_tlb,
 };
 
 #define VMSTATE_TLB_ARRAY_V(_f, _s, _n, _v)                     \
-- 
2.43.0


