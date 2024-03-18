Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B7FC54E71
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 03:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm3lp-0002xI-BW; Sun, 17 Mar 2024 23:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rm3ln-0002wg-Mi
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:34:39 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rm3ll-0002tD-Mx
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710732878; x=1742268878;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pzEf35k2DAvA11DdvyXJyAX+HNKyy5imQlrRkrZgDHk=;
 b=bQ4mSpxG9XN0X2LgUkN+eTWDs0SAzVmfNtxdaA00sxTD6rFnvXvL3MLp
 o6ThAZJ4oOAS5Egdr28e+EB5KGejvv0eybu/lnaS0j5oybq3xiz/nFgqj
 PgBJ1+4rBqct/Iiwa48Ib7Zi4MdGErWgjapgM2h5QVyl2GM8pFPb9fr9f
 auShMPYX9co6iRXegrV+J/+vFaISsnKB0nHy14vKX+436O5n2VQh8Cr+6
 yzEHHrxwTT3sW9IDipPpWxAew+YDjHrUiFCf9C9k9Y5yOjHeBNDvQSd63
 R8OnEKhXs+SDezF1uRZ6Pbi5ywKb3ZaE8bqi56857CDWvdEt0/RtAoGYh Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5403674"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5403674"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 20:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="13275375"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 20:34:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 zhao1.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 1/3] qom/object_interfaces: Remove unnecessary local error
 check
Date: Mon, 18 Mar 2024 11:32:08 +0800
Message-Id: <20240318033211.459006-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318033211.459006-1-zhenzhong.duan@intel.com>
References: <20240318033211.459006-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The original error handling code indicates "local_err is always set",
and error_propagate() can handle the case that local_err is NULL.

Use err label instead of out label for error path.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 qom/object_interfaces.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e0833c8bfe..70179877f1 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -111,14 +111,14 @@ Object *user_creatable_add_type(const char *type, const char *id,
     obj = object_new(type);
     object_set_properties_from_qdict(obj, qdict, v, &local_err);
     if (local_err) {
-        goto out;
+        goto err;
     }
 
     if (id != NULL) {
         object_property_try_add_child(object_get_objects_root(),
                                       id, obj, &local_err);
         if (local_err) {
-            goto out;
+            goto err;
         }
     }
 
@@ -126,15 +126,13 @@ Object *user_creatable_add_type(const char *type, const char *id,
         if (id != NULL) {
             object_property_del(object_get_objects_root(), id);
         }
-        goto out;
-    }
-out:
-    if (local_err) {
-        error_propagate(errp, local_err);
-        object_unref(obj);
-        return NULL;
+        goto err;
     }
     return obj;
+err:
+    error_propagate(errp, local_err);
+    object_unref(obj);
+    return NULL;
 }
 
 void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
-- 
2.34.1


