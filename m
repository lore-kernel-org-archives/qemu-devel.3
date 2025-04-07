Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23943C3601A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hFi-0001OG-3T; Mon, 07 Apr 2025 03:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFf-0001Mt-AX
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:39 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFd-0005SK-M0
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744012238; x=1775548238;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=72seqPwiqtTTIfhrsv8Di6UixdAaQLoSv7f9LbSTVdM=;
 b=Z32cbCOfMp0ldLWzkpo2JkHTx7+drJIMVUUcl2MLka6Kc5YEf3jcq56b
 z5JH27u71O5t9xcK8QOr6xfqfbwGmTeSReot59VucFd4FaZe5mG2pdZFE
 CkxNKalMGz1GCeJoUwQpTQM0IxZpSh006+zZFmxpor7EVax0Xzf7JMD8J
 /gkqm7Ip4yK+cclzTbcG+UfE5i8eVrYFPPvFQYX5UgBp1r2875Nl64lqY
 lsham1nKgHcVJpvB3AjC4XeoV6KKEDyIzVLftgtRMItXgyWPAj8sGm0kZ
 f849Zm5mfrlG8KY3zltf+Ts2fcQf+FoulOu9lMy3bnjyJIdUyuFUWDXRs w==;
X-CSE-ConnectionGUID: Cgd+th4sTTaHv6aXQUZYiA==
X-CSE-MsgGUID: 3g56MbXtQ1KsiJwwUPeKTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="67857618"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="67857618"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:37 -0700
X-CSE-ConnectionGUID: uVjmCoGaRRmRYXxjCVAOLw==
X-CSE-MsgGUID: 4g4q8ObRQZijpc802CGgiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128405709"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:34 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v4 13/13] RAMBlock: Make guest_memfd require coordinate discard
Date: Mon,  7 Apr 2025 15:49:33 +0800
Message-ID: <20250407074939.18657-14-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250407074939.18657-1-chenyi.qiang@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=chenyi.qiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

As guest_memfd is now managed by ram_block_attribute with
PrivateSharedManager, only block uncoordinated discard.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v4:
    - Modify commit message (RamDiscardManager->PrivateSharedManager).

Changes in v3:
    - No change.

Changes in v2:
    - Change the ram_block_discard_require(false) to
      ram_block_coordinated_discard_require(false).
---
 system/physmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index fb74321e10..5e72d2a544 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1871,7 +1871,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         assert(kvm_enabled());
         assert(new_block->guest_memfd < 0);
 
-        ret = ram_block_discard_require(true);
+        ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
             error_setg_errno(errp, -ret,
                              "cannot set up private guest memory: discard currently blocked");
@@ -1895,7 +1895,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
              */
             object_unref(OBJECT(new_block->ram_block_attribute));
             close(new_block->guest_memfd);
-            ram_block_discard_require(false);
+            ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
@@ -2155,7 +2155,7 @@ static void reclaim_ramblock(RAMBlock *block)
         ram_block_attribute_unrealize(block->ram_block_attribute);
         object_unref(OBJECT(block->ram_block_attribute));
         close(block->guest_memfd);
-        ram_block_discard_require(false);
+        ram_block_coordinated_discard_require(false);
     }
 
     g_free(block);
-- 
2.43.5


