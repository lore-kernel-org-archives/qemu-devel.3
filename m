Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1D2CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstR-0002w8-Tv; Tue, 28 Oct 2025 19:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstP-0002vV-B3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:19 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDst8-00014M-FX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:19 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6D40E81727;
 Wed, 29 Oct 2025 02:13:54 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-BZNXFpHN; Wed, 29 Oct 2025 02:13:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693234;
 bh=NZZux5qx2us8NWhaN9HZ/+ms++4266YHMgSH/roMby4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=S6adQcjh1V2r0657ovalazXt8/r2jC5B+uALHfIrYFiRdPQZ1Wd8W2QBcll3vgeLm
 PnfmwR+eECMAouwUosZ6xVvUHer19cqUIl+mKLv1zyxX3/wIpQr7Bxg5xOvY7pbmt7
 9YfJ3kBTmlMFsKDYsyZ7yuqPEb9SAnCcmghIf7Sc=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 03/22] tests/unit/test-vmstate: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:27 +0300
Message-ID: <20251028231347.194844-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/unit/test-vmstate.c | 116 ++++++++++----------------------------
 1 file changed, 29 insertions(+), 87 deletions(-)

diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index cadbab3c5e..2379b369cd 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -67,14 +67,9 @@ static QEMUFile *open_test_file(bool write)
 static void save_vmstate(const VMStateDescription *desc, void *obj)
 {
     QEMUFile *f = open_test_file(true);
-    Error *local_err = NULL;
 
     /* Save file with vmstate */
-    int ret = vmstate_save_state(f, desc, obj, NULL, &local_err);
-    if (ret) {
-        error_report_err(local_err);
-    }
-    g_assert(!ret);
+    vmstate_save_vmsd(f, desc, obj, NULL, &error_abort);
     qemu_put_byte(f, QEMU_VM_EOF);
     g_assert(!qemu_file_get_error(f));
     qemu_fclose(f);
@@ -112,7 +107,6 @@ static int load_vmstate_one(const VMStateDescription *desc, void *obj,
                             int version, const uint8_t *wire, size_t size)
 {
     QEMUFile *f;
-    int ret;
     Error *local_err = NULL;
 
     f = open_test_file(true);
@@ -120,15 +114,16 @@ static int load_vmstate_one(const VMStateDescription *desc, void *obj,
     qemu_fclose(f);
 
     f = open_test_file(false);
-    ret = vmstate_load_state(f, desc, obj, version, &local_err);
-    if (ret) {
+    if (!vmstate_load_vmsd(f, desc, obj, version, &local_err)) {
         error_report_err(local_err);
         g_assert(qemu_file_get_error(f));
+        qemu_fclose(f);
+        return -1;
     } else{
         g_assert(!qemu_file_get_error(f));
+        qemu_fclose(f);
+        return 0;
     }
-    qemu_fclose(f);
-    return ret;
 }
 
 
@@ -362,8 +357,6 @@ static const VMStateDescription vmstate_versioned = {
 
 static void test_load_v1(void)
 {
-    Error *local_err = NULL;
-    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 30,             /* c */
@@ -374,10 +367,7 @@ static void test_load_v1(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .b = 200, .e = 500, .f = 600 };
-    ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 1, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    vmstate_load_vmsd(loading, &vmstate_versioned, &obj, 1, &error_abort);
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 200);
@@ -390,8 +380,6 @@ static void test_load_v1(void)
 
 static void test_load_v2(void)
 {
-    Error *local_err = NULL;
-    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 20,             /* b */
@@ -405,10 +393,7 @@ static void test_load_v2(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj;
-    ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 2, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    vmstate_load_vmsd(loading, &vmstate_versioned, &obj, 2, &error_abort);
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
     g_assert_cmpint(obj.c, ==, 30);
@@ -442,16 +427,10 @@ static const VMStateDescription vmstate_skipping = {
 
 static void test_save_noskip(void)
 {
-    Error *local_err = NULL;
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = false };
-    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
-                                 &local_err);
-    if (ret) {
-        error_report_err(local_err);
-    }
-    g_assert(!ret);
+    vmstate_save_vmsd(fsave, &vmstate_skipping, &obj, NULL, &error_abort);
     g_assert(!qemu_file_get_error(fsave));
 
     uint8_t expected[] = {
@@ -469,16 +448,10 @@ static void test_save_noskip(void)
 
 static void test_save_skip(void)
 {
-    Error *local_err = NULL;
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = true };
-    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
-                                 &local_err);
-    if (ret) {
-        error_report_err(local_err);
-    }
-    g_assert(!ret);
+    vmstate_save_vmsd(fsave, &vmstate_skipping, &obj, NULL, &error_abort);
     g_assert(!qemu_file_get_error(fsave));
 
     uint8_t expected[] = {
@@ -494,8 +467,6 @@ static void test_save_skip(void)
 
 static void test_load_noskip(void)
 {
-    Error *local_err = NULL;
-    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 20,             /* b */
@@ -509,10 +480,7 @@ static void test_load_noskip(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .skip_c_e = false };
-    ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    vmstate_load_vmsd(loading, &vmstate_skipping, &obj, 2, &error_abort);
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
@@ -525,8 +493,6 @@ static void test_load_noskip(void)
 
 static void test_load_skip(void)
 {
-    Error *local_err = NULL;
-    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 20,             /* b */
@@ -538,10 +504,7 @@ static void test_load_skip(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .skip_c_e = true, .c = 300, .e = 500 };
-    ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    vmstate_load_vmsd(loading, &vmstate_skipping, &obj, 2, &error_abort);
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
@@ -781,8 +744,6 @@ static void test_save_q(void)
 
 static void test_load_q(void)
 {
-    int ret;
-    Error *local_err = NULL;
     TestQtailq obj_q = {
         .i16 = -512,
         .i32 = 70000,
@@ -812,10 +773,7 @@ static void test_load_q(void)
     TestQtailq tgt;
 
     QTAILQ_INIT(&tgt.q);
-    ret = vmstate_load_state(fload, &vmstate_q, &tgt, 1, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    vmstate_load_vmsd(fload, &vmstate_q, &tgt, 1, &error_abort);
     char eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(tgt.i16, ==, obj_q.i16);
@@ -933,29 +891,29 @@ static void destroy_domain(gpointer data)
     g_free(domain);
 }
 
-static int domain_preload(void *opaque)
+static bool domain_preload(void *opaque, Error **errp)
 {
     TestGTreeDomain *domain = opaque;
 
     domain->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
                                        NULL, g_free, g_free);
-    return 0;
+    return true;
 }
 
-static int iommu_preload(void *opaque)
+static bool iommu_preload(void *opaque, Error **errp)
 {
     TestGTreeIOMMU *iommu = opaque;
 
     iommu->domains = g_tree_new_full((GCompareDataFunc)int_cmp,
                                      NULL, NULL, destroy_domain);
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_domain = {
     .name = "domain",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_load = domain_preload,
+    .pre_load_errp = domain_preload,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(id, TestGTreeDomain),
         VMSTATE_GTREE_V(mappings, TestGTreeDomain, 1,
@@ -991,7 +949,7 @@ static const VMStateDescription vmstate_iommu = {
     .name = "iommu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_load = iommu_preload,
+    .pre_load_errp = iommu_preload,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(id, TestGTreeIOMMU),
         VMSTATE_GTREE_DIRECT_KEY_V(domains, TestGTreeIOMMU, 1,
@@ -1157,8 +1115,6 @@ static void diff_iommu(TestGTreeIOMMU *iommu1, TestGTreeIOMMU *iommu2)
 
 static void test_gtree_load_domain(void)
 {
-    Error *local_err = NULL;
-    int ret;
     TestGTreeDomain *dest_domain = g_new0(TestGTreeDomain, 1);
     TestGTreeDomain *orig_domain = create_first_domain();
     QEMUFile *fload, *fsave;
@@ -1171,11 +1127,7 @@ static void test_gtree_load_domain(void)
 
     fload = open_test_file(false);
 
-    ret = vmstate_load_state(fload, &vmstate_domain, dest_domain, 1,
-                             &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    vmstate_load_vmsd(fload, &vmstate_domain, dest_domain, 1, &error_abort);
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(orig_domain->id, ==, dest_domain->id);
@@ -1278,8 +1230,6 @@ static void test_gtree_save_iommu(void)
 
 static void test_gtree_load_iommu(void)
 {
-    Error *local_err = NULL;
-    int ret;
     TestGTreeIOMMU *dest_iommu = g_new0(TestGTreeIOMMU, 1);
     TestGTreeIOMMU *orig_iommu = create_iommu();
     QEMUFile *fsave, *fload;
@@ -1291,10 +1241,7 @@ static void test_gtree_load_iommu(void)
     qemu_fclose(fsave);
 
     fload = open_test_file(false);
-    ret = vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    vmstate_load_vmsd(fload, &vmstate_iommu, dest_iommu, 1, &error_abort);
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(orig_iommu->id, ==, dest_iommu->id);
@@ -1416,8 +1363,6 @@ static void test_save_qlist(void)
 
 static void test_load_qlist(void)
 {
-    Error *local_err = NULL;
-    int ret;
     QEMUFile *fsave, *fload;
     TestQListContainer *orig_container = alloc_container();
     TestQListContainer *dest_container = g_new0(TestQListContainer, 1);
@@ -1431,11 +1376,8 @@ static void test_load_qlist(void)
     qemu_fclose(fsave);
 
     fload = open_test_file(false);
-    ret = vmstate_load_state(fload, &vmstate_container, dest_container, 1,
-                             &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    vmstate_load_vmsd(fload, &vmstate_container, dest_container, 1,
+                      &error_abort);
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(eof, ==, QEMU_VM_EOF);
@@ -1452,22 +1394,22 @@ typedef struct TmpTestStruct {
     int64_t diff;
 } TmpTestStruct;
 
-static int tmp_child_pre_save(void *opaque)
+static bool tmp_child_pre_save(void *opaque, Error **errp)
 {
     struct TmpTestStruct *tts = opaque;
 
     tts->diff = tts->parent->b - tts->parent->a;
 
-    return 0;
+    return true;
 }
 
-static int tmp_child_post_load(void *opaque, int version_id)
+static bool tmp_child_post_load(void *opaque, int version_id, Error **errp)
 {
     struct TmpTestStruct *tts = opaque;
 
     tts->parent->b = tts->parent->a + tts->diff;
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_tmp_back_to_parent = {
@@ -1480,8 +1422,8 @@ static const VMStateDescription vmstate_tmp_back_to_parent = {
 
 static const VMStateDescription vmstate_tmp_child = {
     .name = "test/tmp_child",
-    .pre_save = tmp_child_pre_save,
-    .post_load = tmp_child_post_load,
+    .pre_save_errp = tmp_child_pre_save,
+    .post_load_errp = tmp_child_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT64(diff, TmpTestStruct),
         VMSTATE_STRUCT_POINTER(parent, TmpTestStruct,
-- 
2.48.1


