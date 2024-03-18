Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CAAC54E68
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 03:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm3lr-0002y9-Lq; Sun, 17 Mar 2024 23:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rm3lq-0002xj-8i
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:34:42 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rm3lo-0002tD-0b
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710732880; x=1742268880;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qCfBZ1GyPomLTC4f3lRL18KLkS/jDfyHNLok+VS22dA=;
 b=GibwcUT2EzTDcfF5Z0f/YfszHz2MAM6MKjsHTvPEEUDq6TJGSWPv8ix4
 bvstFNBCOUlZU20aedp4KtMZ7WypFaNPbDidDMFFgPL2h2mjOQSL0QoGM
 i9kopY650eRJXu/YlEb7Q7c5HlWGU3IP8dEgAPBheOz5kTiFGhKJ2pm6S
 0c6vZqpnbmznSmjWGIh9C4rSn9ETQ//9Pb0T84UrWg1u2rykDBEoyJfAJ
 cETzPt5OPkfsgIUc9DA3ZESvCLr/bfNc+XFE5ZrQzgVUIMAXqVwkh29Nr
 7wbJ/EnRZmFe2WQhIfVItV3tuA4+L5S60rCt3aYb/xPMpysvoMZ7gXBpW A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5403681"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5403681"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 20:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="13275396"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2024 20:34:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 zhao1.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 3/3] qom/object_interfaces: Remove local_err in
 user_creatable_add_type
Date: Mon, 18 Mar 2024 11:32:10 +0800
Message-Id: <20240318033211.459006-4-zhenzhong.duan@intel.com>
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

In user_creatable_add_type, there is mixed usage of ERRP_GUARD and
local_err. This makes error_abort not taking effect in those callee
functions with &local_err passed.

Now that we already use ERRP_GUARD, remove local_err and pass errp.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 qom/object_interfaces.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e17e2de46d..2067bf2230 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -84,7 +84,6 @@ Object *user_creatable_add_type(const char *type, const char *id,
     ERRP_GUARD();
     Object *obj;
     ObjectClass *klass;
-    Error *local_err = NULL;
 
     if (id != NULL && !id_wellformed(id)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identifier");
@@ -112,16 +111,16 @@ Object *user_creatable_add_type(const char *type, const char *id,
 
     assert(qdict);
     obj = object_new(type);
-    if (!object_set_properties_from_qdict(obj, qdict, v, &local_err)) {
+    if (!object_set_properties_from_qdict(obj, qdict, v, errp)) {
         goto err;
     }
 
     if (id != NULL && !object_property_try_add_child(object_get_objects_root(),
-                                                     id, obj, &local_err)) {
+                                                     id, obj, errp)) {
             goto err;
     }
 
-    if (!user_creatable_complete(USER_CREATABLE(obj), &local_err)) {
+    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
         if (id != NULL) {
             object_property_del(object_get_objects_root(), id);
         }
@@ -129,7 +128,6 @@ Object *user_creatable_add_type(const char *type, const char *id,
     }
     return obj;
 err:
-    error_propagate(errp, local_err);
     object_unref(obj);
     return NULL;
 }
-- 
2.34.1


