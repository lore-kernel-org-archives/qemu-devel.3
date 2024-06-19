Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF40AC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 14:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJwHK-0004gL-4M; Wed, 19 Jun 2024 10:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwHD-0004eU-Ao
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:27:08 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwHA-00020h-9r
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718807224; x=1750343224;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oz4iYND1Xekpj8oEUN4s0fCw1gdhIu4WUfOqsSv9eIU=;
 b=aJb4jYZnWX41gVDgdYdHDA2pEI4nVUnm5iNvHs4+d8j6JeTmeFvVWY0N
 ps+JJVuXLyIEKHIuo0pL0tt77nnYL4W7a3L++3+C10mniUWMIO6XCsDZQ
 w4By4WkylZsAT6aV7FnE8ljoDUVlKVcMfUW5p2FAkO5uZesMHdMqdaidh
 3Nbdasf8JVHlJ2WoRvObtlql285SSn/eKYdkXLmj9/n1/0vv5lDKuF7+r
 jZGVDomshHw0BC7rBBSPB9jBaTrRteKNSYBQlFINrckLfSBkEKeSesAVM
 KTRtHoHHWUYU9MlnvzcoxIlJiSSDkYelUF9HpFUyhCKalaSdk3Q60tEXD Q==;
X-CSE-ConnectionGUID: inOJBt/0SKi7w9dqhhlNaw==
X-CSE-MsgGUID: zTxIZE8uTn2u9mrmXmdQWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15462615"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="15462615"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2024 07:27:01 -0700
X-CSE-ConnectionGUID: U3Jio1OsTL2sm4e7jE6NdQ==
X-CSE-MsgGUID: BsW4ZC82Rm6htGs+6aPKrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="41788935"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 07:26:59 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/3] target/i386/cpu: Use hex mask to check for valid cache
 CPUID leaf
Date: Wed, 19 Jun 2024 22:42:13 +0800
Message-Id: <20240619144215.3273989-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619144215.3273989-1-zhao1.liu@intel.com>
References: <20240619144215.3273989-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hexadecimal mask is more intuitive comparing to decimal.

Therefore convert the mask of bits 00-04 to hexadecimal value.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 365852cb99e1..c4d4048ec32a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6452,7 +6452,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * QEMU has its own number of cores/logical cpus,
              * set 24..14, 31..26 bit to configured values
              */
-            if (*eax & 31) {
+            if (*eax & 0x1f) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
                 *eax &= ~0xFC000000;
-- 
2.34.1


