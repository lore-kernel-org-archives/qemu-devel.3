Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D37CD4F35
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiwO-0000tO-PX; Tue, 12 May 2026 04:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwN-0000t8-1X
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:11 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiwL-0007UU-G5
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778576289; x=1810112289;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2jrOHcNmmoeG8OYa4BUw32tOAHy5w3m8RmqkoBb0zUo=;
 b=Zlr4C9SSzzgyGIpLQLc557rHj5nCzID7Uo7vJ3Ix/ofWznm3ciuZBDg/
 3+F71cAluGQ3q+UY2m7sclpcPnGEU4e1G6svETAZVCcbnDErmit0Wafd9
 ad8sD3pQVKRRJ40d0OvsXFrIpKClTeBYlkX9wV7WdctbLrKmBDk58LDXb
 liN+lDNsDoHH46RxsN6NdPfyGapIo6nLUdc+Xshzk6NVKcyZpbllGjoYj
 XxAaDAtfXuMdrKOBoGhAApX4+pRLJ2ZBiqjL5Pu24+1SkCxhutfYtc9Gr
 4hnk3+Vl9fyaLYiA1QOxOIoiO3J7YShoLNzcp93FE4tiF/TNN/lXsiv2T g==;
X-CSE-ConnectionGUID: YrFIOY73QGKi5QyXjbA4Gw==
X-CSE-MsgGUID: tjPccyNRQtavzF2BVF85Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78510938"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="78510938"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:58:09 -0700
X-CSE-ConnectionGUID: I5ZNqitCSOGs0h4p6z7yAw==
X-CSE-MsgGUID: ZoIDPVepTg+N+iWc63EU+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="242065557"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa004.jf.intel.com with ESMTP; 12 May 2026 01:58:07 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xiaoyao.li@intel.com
Subject: [PATCH v2 5/5] machine: Deprecate memory-encryption
Date: Tue, 12 May 2026 16:44:58 +0800
Message-ID: <20260512084458.622465-6-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512084458.622465-1-xiaoyao.li@intel.com>
References: <20260512084458.622465-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

We've had 'confidential-guest-support' for long enough that no one should
be using 'memory-encryption' anymore.

Deprecate 'memory-encryption' by adding notes in docs/about/deprecated.rst
and print a warning when 'memory-encryptio' is used.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/qemu-devel/aMPYkUsytGxLPIM7@redhat.com/
---
 docs/about/deprecated.rst | 7 +++++++
 hw/core/machine.c         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 5551bd12ad83..d60c7206ec4d 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -305,6 +305,13 @@ they want to use and avoids confusion.  Existing users of the ``spike``
 machine must ensure that they're setting the ``spike`` machine in the
 command line (``-M spike``).
 
+``memory-encryption`` machine property (since 11.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``confidential-guest-support`` instead. The ``memory-encryption`` object
+was an early implementation of memory encryption support in QEMU, but it has
+been superseded by the more comprehensive ``confidential-guest-support``
+object.
 
 Backend options
 ---------------
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63baff859f3d..baa275b87dcc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -490,6 +490,8 @@ static void machine_set_memory_encryption(Object *obj, const char *value,
     Object *cgs =
         object_resolve_path_component(object_get_objects_root(), value);
 
+    warn_report("memory-encryption is deprecated, use confidential-guest-support instead");
+
     if (!cgs) {
         error_setg(errp, "No such memory encryption object '%s'", value);
         return;
-- 
2.43.0


