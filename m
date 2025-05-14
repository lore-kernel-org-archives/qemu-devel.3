Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F5AC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7UH-00074m-NZ; Wed, 14 May 2025 04:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UG-0006wU-1B; Wed, 14 May 2025 04:29:12 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UE-0006H0-BE; Wed, 14 May 2025 04:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211351; x=1778747351;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VUxtdUfmhxC4kgSCPUeYsW2tnM9jTM6sDutnbwjMyCw=;
 b=a8LF1fLEbdFLddG5G5WTpfqVfPYOn/RhV35VUdyEKPJSu28oMMEnS2Op
 9wwcVAPd/b++BEZ3Z4868oQeTre30WaN0bI4uNDL2le01fLTenACuwtu2
 /fp8FLHkcRqDHz5ikBbhOuFRVnLeTOnODQyw5UBxgmVSDUe3zSorQHMiB
 0JH0WYdtOBXNmM2g7FCgTRQKGGo8kAqRktLk1MsukPXIB84EiAvpkkErw
 kWyfVTJl/KUo01HsSpXm6ksNC5CrDHDxNCNBk0ViTfm0CVjqxvRPXGekV
 toeU8KiEZnKPFgE6xydLzEOoTLP+kDQw87vaq3riq9hYkSzeNI698uW09 A==;
X-CSE-ConnectionGUID: o4gswYsDSH2a5OnRU92uLg==
X-CSE-MsgGUID: wQp5iozeTYOneB1N4PIv8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505603"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505603"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:29:09 -0700
X-CSE-ConnectionGUID: 3+cZ8mfbSR+Hh4ug4IYxcQ==
X-CSE-MsgGUID: EkYN1IWVT2aZfK9zgJY7eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065842"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:29:06 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 7/9] hw/core/resetcontainer: Consolidate
 OBJECT_DECLARE_SIMPLE_TYPE
Date: Wed, 14 May 2025 16:49:55 +0800
Message-Id: <20250514084957.2221975-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514084957.2221975-1-zhao1.liu@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

The QOM type of ResettableContainer is defined by
OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES, which means it doesn't need
the class!

Therefore, use OBJECT_DECLARE_SIMPLE_TYPE to declare the type, then
there's no need for class definition.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/core/resetcontainer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/resetcontainer.h b/include/hw/core/resetcontainer.h
index 23db0c7a8806..daeb18c1ea81 100644
--- a/include/hw/core/resetcontainer.h
+++ b/include/hw/core/resetcontainer.h
@@ -20,7 +20,7 @@
 #include "qom/object.h"
 
 #define TYPE_RESETTABLE_CONTAINER "resettable-container"
-OBJECT_DECLARE_TYPE(ResettableContainer, ResettableContainerClass, RESETTABLE_CONTAINER)
+OBJECT_DECLARE_SIMPLE_TYPE(ResettableContainer, RESETTABLE_CONTAINER)
 
 /**
  * resettable_container_add: Add a resettable object to the container
-- 
2.34.1


