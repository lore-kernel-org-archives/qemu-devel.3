Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEB0C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfXGy-000892-IB; Wed, 28 Feb 2024 22:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfXGw-00088H-Nj
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:39:50 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfXGv-0001yM-2l
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709177989; x=1740713989;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p6QH4TugmX7PtxN3cuvjGcehp8Eor7bXsS9qNgtb5A4=;
 b=PZvYZDWCUPYjoWdPUwt53IW4RRHGA1HDTmtw6jdr8v39WuhSyRgFlz3J
 5kbZIoibC8+kJgIYWVagCggzMzdr5Q6hZdsBN36oCmPZMFqKIPqaaifHt
 NV8l+R16WCJhJ6MKBATqi7Ht4js+o6NLgDvawIaaID8d4pzYm62/J2Pz3
 RYBDQkMpKurF/OwM07oPKo9fvPpFgK6UsINZcsATjm2ld5tW6Fr3Rpj+g
 IDr2PcuJkcjlS/cgZoB7RpZp0sRN8/AE+/0yb6Uyd1XJygc8+uaxqYrR6
 RfAqAMxzKhP45q2g+SpFjteaZ2RdxP6Z/0we9Tg5Dt7lbGqMiL/c6gMS+ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21082854"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; d="scan'208";a="21082854"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 19:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7592533"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 19:39:44 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/2] qom/object_interfaces: Remove local_err in
 user_creatable_add_type
Date: Thu, 29 Feb 2024 11:37:39 +0800
Message-Id: <20240229033739.1123076-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229033739.1123076-1-zhenzhong.duan@intel.com>
References: <20240229033739.1123076-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In user_creatable_add_type, there is mixed usage of ERRP_GUARD and
local_err. This makes error_abort not taking effect in those callee
functions with local_err passed.

Now that we already has ERRP_GUARD, remove local_err and use *errp
instead.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 qom/object_interfaces.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 255a7bf659..165cd433e7 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -81,7 +81,6 @@ Object *user_creatable_add_type(const char *type, const char *id,
     ERRP_GUARD();
     Object *obj;
     ObjectClass *klass;
-    Error *local_err = NULL;
 
     if (id != NULL && !id_wellformed(id)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identifier");
@@ -109,20 +108,20 @@ Object *user_creatable_add_type(const char *type, const char *id,
 
     assert(qdict);
     obj = object_new(type);
-    object_set_properties_from_qdict(obj, qdict, v, &local_err);
-    if (local_err) {
+    object_set_properties_from_qdict(obj, qdict, v, errp);
+    if (*errp) {
         goto out;
     }
 
     if (id != NULL) {
         object_property_try_add_child(object_get_objects_root(),
-                                      id, obj, &local_err);
-        if (local_err) {
+                                      id, obj, errp);
+        if (*errp) {
             goto out;
         }
     }
 
-    if (!user_creatable_complete(USER_CREATABLE(obj), &local_err)) {
+    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
         if (id != NULL) {
             object_property_del(object_get_objects_root(), id);
         }
@@ -130,7 +129,6 @@ Object *user_creatable_add_type(const char *type, const char *id,
     }
     return obj;
 out:
-    error_propagate(errp, local_err);
     object_unref(obj);
     return NULL;
 }
-- 
2.34.1


