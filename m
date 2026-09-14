Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF042C88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x634r-0000qd-K5; Mon, 14 Sep 2026 05:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634R-0000he-NA; Mon, 14 Sep 2026 05:33:53 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634M-0000S6-Sx; Mon, 14 Sep 2026 05:33:49 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9WXEZ020350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:32:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=O5wDgXC/TuaFHn1dcGoYTVezrrNNB83UDSJG4TY3Oyo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378360; v=1;
 b=rtoouPYCadezWfB6yc131UGlYHIuD1NFayTaA8z2OphmB4LUUn5JMs7kmhJtE5El
 XgLyccwX3Ox2T+HZuorZ/RCbMRc2TJ5zgpzqwgJV2V3sSf739fFX3zEWXDegEb0n
 HjqjVhns5XATbUEXvQpEUWrOuL8HbIB1d+jeLM8zwl55e92fkV1wxEQvgEhfebNf
 IXs1mMiDM9QPVIc6eabwc2itrKOORm1z2WbxfuhAnRUBGvodh2FQfj1beeciGGCI
 0719JJ1Tzr4H1S3bA0Tk1EAzXYykF/WjUFpoaXrxqHPQ8wAfUieA7H6NLk8vmhDC
 23euKPbwQJscgvRbQjQ5uQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:31:52 +0900
Subject: [PATCH v4 4/4] hw/qdev: Introduce the realizing phase
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-qdev-v4-4-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
References: <20260914-qdev-v4-0-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260914-qdev-v4-0-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5563;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=M+YVSnl+FD4HvWRd/TW0KV+djv8mwPLa3roXX6sR2bk=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9by/QYrdQsXXv550ldCdpc6e67E8nuenGpRLt98lsVFM
 raZs6l2lLIwiHExyIopsqQU7ebWiK79VJgQ3wIzh5UJZAgDF6cATGR3LsP/sj8BTwMyJh4omX9H
 sPV52MRVb9T7uIsU7q6SPGLRIG2xmJFhmj9zm0n6ktWXdpsnqBRqhM5sc9N7skPixu4wvk3xcSv
 YAQ==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

qdev currently permits reentrant realization of the same device, but
supporting it adds complexity to device implementations. It is untested
and likely broken.

Add the realizing phase, and move the device to the new phase before
invoking realization callbacks, preventing another realization attempt.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 qapi/common.json       |  6 ++++--
 include/hw/core/qdev.h |  6 +++---
 hw/core/qdev.c         | 11 +++++++++++
 tests/unit/test-qdev.c | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index f3218b846ce8..c77fc6b01a2a 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -14,15 +14,17 @@
 #
 # @initialized: the initial phase
 #
+# @realizing: the phase during realization
+#
 # @realized: the phase after realization
 #
-# @retired: the phase entered when unrealization begins or
+# @retired: the terminal phase entered when unrealization begins or
 #           realization fails after starting
 #
 # Since: 11.2
 ##
 { 'enum': 'DevicePhase',
-  'data': [ 'initialized', 'realized', 'retired' ] }
+  'data': [ 'initialized', 'realizing', 'realized', 'retired' ] }
 
 ##
 # @IoOperationType:
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index a0aa7e3f6e35..0d10410f6f06 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -31,9 +31,9 @@
  * 3) device realization
  *
  * #TypeInfo.instance_init may not fail. #DeviceClass.realize can
- * fail, returning error information to the caller, and must be re-entrant.
- * A device's realize method will not be called after realization, even
- * if realization fails or the device is later unrealized.
+ * fail, returning error information to the caller.
+ * A device's realize method is called at most once, even if realization
+ * fails or the device is later unrealized.
  * #TypeInfo.instance_init should add instance properties but must not
  * have any side effect not contained in the instance, since it happens
  * during device introspection already. Any operations without special
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ca150ecad023..63b87f20d645 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -511,6 +511,11 @@ static void device_set_phase(Object *obj, int value, Error **errp)
         return;
     }
 
+    if (old_value == DEVICE_PHASE_REALIZING) {
+        error_setg(errp, "The device is currently realizing");
+        return;
+    }
+
     if (old_value == DEVICE_PHASE_RETIRED) {
         error_setg(errp, "A device cannot transition from retired to another phase");
         return;
@@ -527,7 +532,13 @@ static void device_set_phase(Object *obj, int value, Error **errp)
         error_setg(errp, "A device cannot transition from another phase to initialized");
         return;
 
+    case DEVICE_PHASE_REALIZING:
+        error_setg(errp, "The realizing phase cannot be set via property");
+        return;
+
     case DEVICE_PHASE_REALIZED:
+        qatomic_set(&dev->phase, DEVICE_PHASE_REALIZING);
+
         if (!check_only_migratable(obj, errp)) {
             goto fail;
         }
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index bb1049fa9919..14935f4d3d9e 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -10,6 +10,8 @@ typedef struct MyDev MyDev;
 DECLARE_INSTANCE_CHECKER(MyDev, STATIC_TYPE,
                          TYPE_MY_DEV)
 
+#define TYPE_REENTRANT_REALIZATION "reentrant-realization"
+
 struct MyDev {
     DeviceState parent_obj;
 
@@ -58,6 +60,25 @@ static const TypeInfo my_dev_type_info = {
     .class_init = my_dev_class_init,
 };
 
+static void reentrant_realization_realize(DeviceState *dev, Error **errp)
+{
+    g_assert_false(qdev_realize(dev, NULL, NULL));
+}
+
+static void reentrant_realization_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = reentrant_realization_realize;
+}
+
+static const TypeInfo reentrant_realization_type_info = {
+    .name = TYPE_REENTRANT_REALIZATION,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(DeviceState),
+    .class_init = reentrant_realization_class_init,
+};
+
 /*
  * Initialize a fake machine, being prepared for future tests.
  *
@@ -118,6 +139,15 @@ static void test_qdev_realize_after_unrealization(void)
     object_unref(mt);
 }
 
+static void test_qdev_reentrant_realization(void)
+{
+    Object *obj = object_new(TYPE_REENTRANT_REALIZATION);
+
+    qdev_realize(DEVICE(obj), NULL, &error_fatal);
+    object_unparent(OBJECT(obj));
+    object_unref(obj);
+}
+
 static void test_qdev_retry_realization(void)
 {
     MyDev *mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
@@ -159,6 +189,7 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&my_dev_type_info);
+    type_register_static(&reentrant_realization_type_info);
     test_init_machine();
 
     g_test_add_func("/qdev/free-properties",
@@ -170,6 +201,9 @@ int main(int argc, char **argv)
     g_test_add_func("/qdev/realize-after-unrealization",
                     test_qdev_realize_after_unrealization);
 
+    g_test_add_func("/qdev/reentrant-realization",
+                    test_qdev_reentrant_realization);
+
     g_test_add_func("/qdev/retry-realization",
                     test_qdev_retry_realization);
 

-- 
2.55.0


