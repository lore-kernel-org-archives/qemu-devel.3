Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879C1D5B16F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpk-0003AD-KC; Tue, 29 Oct 2024 04:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpi-00039O-KO
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:44:10 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpf-00084o-PI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191448; x=1761727448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aWuVA8jXTgROPvzCv0HI/sDiOJnUcWrgVtA/4tuc5rQ=;
 b=WYq2dSHkyyX/j+S8lWl7HIKuM1GgqSwozMxvxDhtQ0/KvXuTYr89ROuP
 wkGtbfjPZORdzIV910GWaocqKrzsLzXaxKaSpt4fyemQJdxuxLrbECits
 pfGxJgFInxkiiRs4ejM7p3xqeCmCMyQRqK6hvGUUD2wM9SccGYZp9R0zm
 AHftTfGe/2zUgB4GoWzUQOs0yWqsgY3RPTKUms5nPI4iy+0bh3TkWlwt7
 Yjj8ePxEKRyow5wEOSdoHBTXPz13Tyie28nRtMP+nGL77AIzAOxDMUGrf
 HIjjEDkY4sNOJfIE3pp22CFerlYUk/EQHA6EVnUzGbGq7zajRLeEP3WaS g==;
X-CSE-ConnectionGUID: hKII+bPbTPa6ruthqMCpTg==
X-CSE-MsgGUID: 8bU91NukSRqFKN1XmLdjqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592841"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592841"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:48 -0700
X-CSE-ConnectionGUID: KxmAUw+GT9SVEvfJKYKqOg==
X-CSE-MsgGUID: RakfL7METJab0/cN9hzdcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847245"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:47 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 16/16] qom/object: Deprecate type_register()
Date: Tue, 29 Oct 2024 16:59:34 +0800
Message-Id: <20241029085934.2799066-17-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
References: <20241029085934.2799066-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

At present, type_register() and type_register_static() are identical,
although their documentation expects the *_static variant to accept
the Typeinfo with the strings that have the static lifetime.

However, the code implementation doesn't have any check or guarantee for
static lifetime. In fact, this is unnecessary because type_new()
duplicates all strings, thereby taking ownership of them.

Therefore, type_register() and type_register_static() are redundant, so
one of them should be deprecated.

Since the changes required to deprecate type_register() are smaller,
choose to deprecate type_register() and delete the requirement about
string lifetime from the documentation.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 14 --------------
 qom/object.c         |  7 +------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 2af9854675c3..24c8e010c2de 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -880,24 +880,10 @@ const char *object_get_typename(const Object *obj);
  * type_register_static:
  * @info: The #TypeInfo of the new type.
  *
- * @info and all of the strings it points to should exist for the life time
- * that the type is registered.
- *
  * Returns: the new #Type.
  */
 Type type_register_static(const TypeInfo *info);
 
-/**
- * type_register:
- * @info: The #TypeInfo of the new type
- *
- * Unlike type_register_static(), this call does not require @info or its
- * string members to continue to exist after the call returns.
- *
- * Returns: the new #Type.
- */
-Type type_register(const TypeInfo *info);
-
 /**
  * type_register_static_array:
  * @infos: The array of the new type #TypeInfo structures.
diff --git a/qom/object.c b/qom/object.c
index 11424cf4711b..c08e7ab652d9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -175,17 +175,12 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
     return ti;
 }
 
-TypeImpl *type_register(const TypeInfo *info)
+TypeImpl *type_register_static(const TypeInfo *info)
 {
     assert(info->parent);
     return type_register_internal(info);
 }
 
-TypeImpl *type_register_static(const TypeInfo *info)
-{
-    return type_register(info);
-}
-
 void type_register_static_array(const TypeInfo *infos, int nr_infos)
 {
     int i;
-- 
2.34.1


