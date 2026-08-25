Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F066C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyqv-0005l5-1e; Tue, 25 Aug 2026 17:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqs-0005jb-VE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:38 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqp-0004zE-IA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 9D7D2807E9;
 Wed, 26 Aug 2026 00:38:30 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-4KqgaEA0; Wed, 26 Aug 2026 00:38:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693909;
 bh=8G20p+W2Adz7jxrPL+OIkEO5r+t8H0Lgux1UNKC7w5o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=unBvowX0GXQAXzL+MOsLZRPCRhdwW7wsY3aDKr5f3NosSd4eFKWABnqQ6j+MX6+KB
 qzb6/aaCfBZXcfg/Qo+8P4LxNZg66LqWBbMwsZcCmMSG/KvdoAQjDrjfJK0MvDZ6F3
 eJIrtizaP0dcUDki54VdznKmX1lfdugWVcJmTPAQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 01/30] tests/unit/test-vmstate: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:41 +0300
Message-ID: <20260825213811.3725682-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
 tests/unit/test-vmstate.c | 118 ++++++++++----------------------------
 1 file changed, 30 insertions(+), 88 deletions(-)

diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index df1fb4c7780..23f31730703 100644
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
-    } else{
-        g_assert(!qemu_file_get_error(f));
+        qemu_fclose(f);
+        return -EINVAL;
     }
+
+    g_assert(!qemu_file_get_error(f));
     qemu_fclose(f);
-    return ret;
+    return 0;
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
@@ -863,8 +826,6 @@ static void test_save_q(void)
 
 static void test_load_q(void)
 {
-    int ret;
-    Error *local_err = NULL;
     TestQtailq obj_q = {
         .i16 = -512,
         .i32 = 70000,
@@ -894,10 +855,7 @@ static void test_load_q(void)
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
@@ -1015,29 +973,29 @@ static void destroy_domain(gpointer data)
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
@@ -1073,7 +1031,7 @@ static const VMStateDescription vmstate_iommu = {
     .name = "iommu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_load = iommu_preload,
+    .pre_load_errp = iommu_preload,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(id, TestGTreeIOMMU),
         VMSTATE_GTREE_DIRECT_KEY_V(domains, TestGTreeIOMMU, 1,
@@ -1239,8 +1197,6 @@ static void diff_iommu(TestGTreeIOMMU *iommu1, TestGTreeIOMMU *iommu2)
 
 static void test_gtree_load_domain(void)
 {
-    Error *local_err = NULL;
-    int ret;
     TestGTreeDomain *dest_domain = g_new0(TestGTreeDomain, 1);
     TestGTreeDomain *orig_domain = create_first_domain();
     QEMUFile *fload, *fsave;
@@ -1253,11 +1209,7 @@ static void test_gtree_load_domain(void)
 
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
@@ -1360,8 +1312,6 @@ static void test_gtree_save_iommu(void)
 
 static void test_gtree_load_iommu(void)
 {
-    Error *local_err = NULL;
-    int ret;
     TestGTreeIOMMU *dest_iommu = g_new0(TestGTreeIOMMU, 1);
     TestGTreeIOMMU *orig_iommu = create_iommu();
     QEMUFile *fsave, *fload;
@@ -1373,10 +1323,7 @@ static void test_gtree_load_iommu(void)
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
@@ -1498,8 +1445,6 @@ static void test_save_qlist(void)
 
 static void test_load_qlist(void)
 {
-    Error *local_err = NULL;
-    int ret;
     QEMUFile *fsave, *fload;
     TestQListContainer *orig_container = alloc_container();
     TestQListContainer *dest_container = g_new0(TestQListContainer, 1);
@@ -1513,11 +1458,8 @@ static void test_load_qlist(void)
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
@@ -1534,22 +1476,22 @@ typedef struct TmpTestStruct {
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
@@ -1562,8 +1504,8 @@ static const VMStateDescription vmstate_tmp_back_to_parent = {
 
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
2.43.0


