Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BB3F532C3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 01:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4qhk-0004Ei-SG; Mon, 23 Mar 2026 21:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1w4qhf-0004EL-8u
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 21:37:09 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1w4qhX-0007mp-Pq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 21:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774316220; x=1805852220;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8MoQj/Jwj/c46KuWxiQseY4hG9a2CoIudL7iHqewPug=;
 b=LsNQfcAVVB8l9NU7WZN5cozzQcRfHv0bJIOFSPhki2oHgspeaV0qGAAx
 ZW2pCRhElPlXekANiVtlRg6J0JVvX1/3qh6JxgtIUJOPXafW0uwVjM2Ks
 F++d+0Z1WoTDMxuV075APGK0PjiOLROYRT4ZBPjK8jvDr650oX2Y2qrHD
 XT6vN4dXUqL1GFCFM4xzvoaxHARwyZN9OzUVhq67WWtfOtlX6uUnYpoe8
 w/Wg4uQS3Zi7kEWaQyid4eBYJNVeMepymvfbrt+s/gL+F+z0uyu4nQ8Fy
 xC3rpcZloH0kqsAdN7Us3kwUkHfZofDXiqEhOw57hsLjQ2YhEAw89L8yu A==;
X-CSE-ConnectionGUID: mWe/HoBBS8aEF6bJFbaneA==
X-CSE-MsgGUID: /BJX1I6aSo65cdo07VzBqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="77933590"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="77933590"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 18:36:54 -0700
X-CSE-ConnectionGUID: DiwySRPfSe63jLxGMhsJ0A==
X-CSE-MsgGUID: 86lxT+xnTfCOqgcVq2Xh+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="219328888"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by fmviesa006.fm.intel.com with ESMTP; 23 Mar 2026 18:36:52 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] i386/tdx: Fix the UAF issue in tdx_fetch_cpuid()
Date: Tue, 24 Mar 2026 09:23:13 +0800
Message-ID: <20260324012313.1580760-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix the UAF issue by reading the returned size before freeing the
fetch_cpuid structure.

Link: https://lore.kernel.org/r/758d7f2c-938f-49cb-89fc-980fc8e020b2@weilnetz.de
Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4cae99c281ac..e578110df4da 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -847,8 +847,8 @@ static struct kvm_cpuid2 *tdx_fetch_cpuid(CPUState *cpu, int *ret)
         fetch_cpuid->nent = size;
         r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid, &local_err);
         if (r == -E2BIG) {
-            g_free(fetch_cpuid);
             size = fetch_cpuid->nent;
+            g_free(fetch_cpuid);
         }
     } while (r == -E2BIG);
 
-- 
2.43.0


