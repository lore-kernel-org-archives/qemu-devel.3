Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F714CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYyhU-0000jU-8L; Mon, 15 Jun 2026 00:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wYygk-0000dE-8D; Mon, 15 Jun 2026 00:12:47 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wYygf-0002Ut-LK; Mon, 15 Jun 2026 00:12:41 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65F4CEdf067027
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2026 13:12:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0eqFwQkqtR+nEulRgm3tM2eTrUW+AhUBLNz94eQVOCg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1781496739; v=1;
 b=rXn2/kcDS7Ecy55+EEIz+fg14MSKj6taMc8iuOFZ0hiD7TtgHIzu5BjrxK1e2CTA
 Ltrt1jyNNo+6sJQFmll+kIcU0s7aKO2wu0O2utpaRFudiQ1dRjM8nggXyYng6rWF
 m4tRx7Nw/xZn0N4MXdeCuW+HXs2dPK91tCIohB6JApP2VEL66qB/3FBcny3nZZpM
 cvR+TpXvDzSMQFbtTIwQQzmX8NC7jbaeiCqBlwiUk2GUG1unw9EphW/XnMDOI4JV
 TnyjFrrqavBspLRREH54AjeqEZd5kwSl0Wtk2q4MBqh67bDAW846Lh+yopB/GYpK
 SvVpsDIJiaCgR5/qfSSBTg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Jun 2026 13:11:06 +0900
Subject: [PATCH 1/2] qom: Reject temporary object resurrection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-embedded-v1-1-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=6155;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=PeveLOKGd+DH/AQHOXNpkUVbiSMs+UHfGxxm2/E25SQ=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5Z+9ULvu5GP78tdm2Ru9OvCMfW96fdN1qx8eqSv1dFik
 pSQyB+mjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIlwXWP4p/E4a+/qe0lOCzsb
 ny0+HqXnqRueKnv4p+p0sdqqWK6SVQx/Bbu4zlcKpLbv9TPjy+j8Lzzv9tmfs6dKhkntemTxy38
 WGwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If object_ref() is called during finalization, it will temporarily
"resurrect" the object. Although object_finalize() asserts that no
resurrecting reference remains before freeing the object, the assertion
cannot catch the case where the resurrecting reference is dropped before
freeing the object.

One way to catch this would be to add a check in object_ref() to reject
resurrecting references before they are created. However, object_ref()
is frequently called so it is better to minimize the overhead.

To avoid adding the overhead, change how the reference count is
represented and let an existing assertion detect resurrection. More
concretely, obj->ref now stores the current reference count minus 1. The
stored count is therefore 0 after object_initialize(), and the final
object_unref() decrements it from 0 to UINT32_MAX and starts
finalization. A resurrecting object_ref() will then trip the existing
obj->ref < INT_MAX assertion.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qom/object.h            |  4 ++--
 block/throttle-groups.c         |  2 +-
 qom/object.c                    | 15 ++++++---------
 tests/unit/check-qom-proplist.c |  8 ++++----
 4 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fcd0..c4dcf65dcf7f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1121,7 +1121,7 @@ GSList *object_class_get_list_sorted(const char *implements_type,
  * @obj: the object
  *
  * Increase the reference count of a object.  A object cannot be freed as long
- * as its reference count is greater than zero.
+ * as a reference remains.
  * Returns: @obj
  */
 Object *object_ref(void *obj);
@@ -1131,7 +1131,7 @@ Object *object_ref(void *obj);
  * @obj: the object
  *
  * Decrease the reference count of a object.  A object cannot be freed as long
- * as its reference count is greater than zero.
+ * as a reference remains.
  */
 void object_unref(void *obj);
 
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 4b1b1944c20a..3b2a89f5849d 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -962,7 +962,7 @@ static void throttle_group_get_limits(Object *obj, Visitor *v,
 
 static bool throttle_group_can_be_deleted(UserCreatable *uc)
 {
-    return OBJECT(uc)->ref == 1;
+    return OBJECT(uc)->ref == 0;
 }
 
 static void throttle_group_obj_class_init(ObjectClass *klass,
diff --git a/qom/object.c b/qom/object.c
index 0ac201de4c15..761eff1337e6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -497,7 +497,6 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
 
     memset(obj, 0, type->instance_size);
     obj->class = type->class;
-    object_ref(obj);
     object_class_property_init_all(obj);
     obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
                                             NULL, object_property_free);
@@ -560,11 +559,10 @@ bool object_initialize_child_with_propsv(Object *parentobj,
 
 out:
     /*
-     * We want @obj's reference to be 1 on success, 0 on failure.
-     * On success, it's 2: one taken by object_initialize(), and one
-     * by object_property_add_child().
-     * On failure in object_initialize() or earlier, it's 1.
-     * On failure afterwards, it's also 1: object_unparent() releases
+     * We want @obj's reference to be 0 on success, UINT32_MAX on failure.
+     * On success, it's 1: one taken by object_property_add_child().
+     * On failure in object_initialize() or earlier, it's 0.
+     * On failure afterwards, it's also 0: object_unparent() releases
      * the reference taken by object_property_add_child().
      */
     object_unref(obj);
@@ -668,7 +666,6 @@ static void object_finalize(void *data)
     object_property_del_all(obj);
     object_deinit(obj, ti);
 
-    g_assert(obj->ref == 0);
     g_assert(obj->parent == NULL);
     if (obj->free) {
         obj->free(obj);
@@ -1329,10 +1326,10 @@ void object_unref(void *objptr)
     if (!obj) {
         return;
     }
-    g_assert(obj->ref > 0);
+    g_assert(obj->ref < INT_MAX);
 
     /* parent always holds a reference to its children */
-    if (qatomic_fetch_dec(&obj->ref) == 1) {
+    if (qatomic_fetch_dec(&obj->ref) == 0) {
         object_finalize(obj);
     }
 }
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 89de92b7d91f..b5527dd52afd 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -351,7 +351,7 @@ static void test_dummy_createv_tree(void)
                               NULL));
 
     g_assert(err == NULL);
-    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
+    g_assert_cmpint(dobj->parent_obj.ref, ==, 0);
     g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
     g_assert(dobj->bv == true);
     g_assert(dobj->av == DUMMY_PLATYPUS);
@@ -375,7 +375,7 @@ static void test_dummy_createv_parentless(void)
                                          NULL));
 
     g_assert(err == NULL);
-    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
+    g_assert_cmpint(dobj->parent_obj.ref, ==, 0);
     g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
     g_assert(dobj->bv == true);
     g_assert(dobj->av == DUMMY_PLATYPUS);
@@ -414,7 +414,7 @@ static void test_dummy_createlist_tree(void)
                         NULL));
 
     g_assert(err == NULL);
-    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
+    g_assert_cmpint(dobj->parent_obj.ref, ==, 0);
     g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
     g_assert(dobj->bv == true);
     g_assert(dobj->av == DUMMY_PLATYPUS);
@@ -450,7 +450,7 @@ static void test_dummy_createlist_parentless(void)
                               NULL));
 
     g_assert(err == NULL);
-    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
+    g_assert_cmpint(dobj->parent_obj.ref, ==, 0);
     g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
     g_assert(dobj->bv == true);
     g_assert(dobj->av == DUMMY_PLATYPUS);

-- 
2.54.0


