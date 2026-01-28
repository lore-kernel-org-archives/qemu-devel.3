Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9989D46C15
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 23:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlEnH-0008TH-BX; Wed, 28 Jan 2026 18:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnE-0008PO-PU
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:48 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vlEnD-0001ir-Al
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 18:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769642267; x=1801178267;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n4k/dBndX6PazD52gFOh8+8Xc/EV6fspDOZfLr8VGQk=;
 b=FY/Zj2kXo1ir93e/CPS2xHpjP/9VHu1DcxYpXF7S1iAkNK/cmKEnvagK
 XYdDy4O3RS+tSJH5VNpa/P8pKfg7bppmev2pyPY3xiM7DyBQ/7WLvEC4h
 xuMANoktjj8xjup27yYVzcItMHsoT+pVkISSlRGtFyU6w8UvFEAPfJJWZ
 qiYD5bYbyDnKIbtuercIFLJXKMaZYIm6ENLxVIHD8h8H99L36ujUL/TDu
 x0xiC9iAxc7TwXDzZmdkyfPqVx9JWccur9puDHDaOaRjING4Md92kED2S
 fLTuM2Ezi5S0PR13AcBHpY976Isr8Mg3JW13Z0Bu7ip9Vgb3VbCaLPilr g==;
X-CSE-ConnectionGUID: 86zV6b3pTduK3xQHlZ2ldg==
X-CSE-MsgGUID: cNImTeVgTxGF1CmGbtRx5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462335"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="73462335"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:41 -0800
X-CSE-ConnectionGUID: sjmY/ywyTQucpE4h6sBdAw==
X-CSE-MsgGUID: s19KMWBaStm58hq2kDHykw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208001778"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 15:17:40 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 07/11] target/i386: Make some PEBS features user-visible
Date: Wed, 28 Jan 2026 15:09:44 -0800
Message-ID: <20260128231003.268981-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128231003.268981-1-zide.chen@intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Populate selected PEBS feature names in FEAT_PERF_CAPABILITIES to make
the corresponding bits user-visible CPU feature knobs, allowing them to
be explicitly enabled or disabled via -cpu +/-<feature>.

Once named, these bits become part of the guest CPU configuration
contract.  If a VM is configured with such a feature enabled, migration
to a destination that does not support the feature may fail, as the
destination cannot honor the guest-visible CPU model.

The PEBS_FMT bits are not exposed, as target/i386 currently does not
support multi-bit CPU properties.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Add the missing comma after "pebs-arch-reg".
- Simplify the PEBS_FMT description in the commit message.

 target/i386/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d3e9d3c40b0a..f2c83b4f259c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1618,10 +1618,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, NULL, NULL,
+            NULL, NULL, "pebs-trap", "pebs-arch-reg",
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, "full-width-write", NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "full-width-write", "pebs-baseline", NULL,
+            NULL, "pebs-timing-info", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.52.0


