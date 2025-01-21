Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4F8C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFdy-0002Rz-E7; Tue, 21 Jan 2025 09:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taFdw-0002RV-9a
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:54:16 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taFdu-0000Fh-JH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737471255; x=1769007255;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hzkRQW1tMtQqA8HGZWYRR3sxXchMV0xu6kHeBEiv5xA=;
 b=etppdqAF1YPiCri8Vpeho9Q44Su3oGbLI1nRYRjQK4bEsPS7NuXfQNhZ
 I4O6pNkGp4hYUnSDLADYzhvbdP1laSOe4JCj0oIMvBWivnVftn+pvQhNn
 ft+6zA0t54F8sNcTsGid3dJb5BSgeG7Af70sPcu1ErDKKIUPyfq/b2LcS
 CjFgFSjrUJF1m9mYGwfw//scPgBOY6f/9rHsi7K0IWyduVmQT1wESE/ai
 hOkYJNcNgd2+sBSkDIcWXJH4Z4CSOv0jj2ltTlvM85ebvFIrOTFUkZP0i
 H7fdotho0ae+kojL2rLaPWTk7S41oX09/PoRbeBGD69jfyxfb9hsYm4Vo Q==;
X-CSE-ConnectionGUID: rgpxHEimTESIqAEuGrZc+w==
X-CSE-MsgGUID: ASwGQUppSs+uYtDABblb/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37763523"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="37763523"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 06:54:12 -0800
X-CSE-ConnectionGUID: vVgDB5KfRSSKg+vKKs0BZg==
X-CSE-MsgGUID: cqiVkptPQv29k05jKz+2cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="106639891"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 21 Jan 2025 06:54:10 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 2/2] memattrs: Check the size of MemTxAttrs
Date: Tue, 21 Jan 2025 23:13:22 +0800
Message-Id: <20250121151322.171832-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121151322.171832-1-zhao1.liu@intel.com>
References: <20250121151322.171832-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Make sure MemTxAttrs is packed into 8 bytes and does not exceed 8 bytes.

Suggested-by: Philippe Mathieu-DaudÃ <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Since MemTxAttrs has been well pakced as 8 bytes, only check if it
   exceed 8 bytes.
---
 include/exec/memattrs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 4fde4eee8439..060b7e713149 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -64,6 +64,8 @@ typedef struct MemTxAttrs {
     uint16_t _reserved2;
 } MemTxAttrs;
 
+QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) > 8);
+
 /* Bus masters which don't specify any attributes will get this,
  * which has all attribute bits clear except the topmost one
  * (so that we can distinguish "all attributes deliberately clear"
-- 
2.34.1


