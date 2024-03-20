Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEE8C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsKo-0004DH-Bk; Wed, 20 Mar 2024 05:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmsKh-00041r-4A
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:34:06 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmsKe-0003mG-MY
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710927240; x=1742463240;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w5bzMcqi3nP6R/BwxpmYoYX2X3RztKeGh8b/f0cv8W0=;
 b=NCXVhJhzRxbZZ9imEVN7u+uiELN63FThb8E0hG1sRbBwt8iiyfzfy7QI
 FK18aFBU9jD4ztWf6n4mLFQjh0BNOhMSs79o+daPGsrqC1hfwiCF1zin0
 liqtAX+pJZJo5XxS/ZBaJFWBAikN0qE9Pb5gE9NA3cuDd6NMHEKuXCiNk
 W6fWJWJpWPF3y3XKyMJRH4tFyR386pLrnHiqD6+OPO9M8DnQU85n1ctkI
 fQ4ZUySn+91IXa6eZVjAg2lFI4cepo0Slr5jZzorLxC08iYBYjfWqvjoI
 ieXV044eIOBVlM67i85ibsV++NZazKcdtYEHeEo6A8rj6TrRWTGfgtIpj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16483095"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="16483095"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 02:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="18562299"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 02:33:44 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, xiangfeix.ma@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 1/1] target/i386: Introduce Icelake-Server-v7 to enable TSX
Date: Wed, 20 Mar 2024 17:31:38 +0800
Message-Id: <20240320093138.80267-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320093138.80267-1-zhenzhong.duan@intel.com>
References: <20240320093138.80267-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

When start L2 guest with both L1/L2 using Icelake-Server-v3 or above,
QEMU reports below warning:

"warning: host doesn't support requested feature: MSR(10AH).taa-no [bit 8]"

Reason is QEMU Icelake-Server-v3 has TSX feature disabled but enables taa-no
bit. It's meaningless that TSX isn't supported but still claim TSX is secure.
So L1 KVM doesn't expose taa-no to L2 if TSX is unsupported, then starting L2
triggers the warning.

Fix it by introducing a new version Icelake-Server-v7 which has both TSX
and taa-no features. Then guest can use TSX securely when it see taa-no.

This matches the production Icelake which supports TSX and isn't susceptible
to TSX Async Abort (TAA) vulnerabilities, a.k.a, taa-no.

Ideally, TSX should have being enabled together with taa-no since v3, but for
compatibility, we'd better to add v7 to enable it.

Fixes: d965dc35592d ("target/i386: Add ARCH_CAPABILITIES related bits into Icelake-Server CPU model")
Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9a210d8d92..5f2191cd99 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3822,6 +3822,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 7,
+                .note = "TSX, taa-no",
+                .props = (PropValue[]) {
+                    /* Restore TSX features removed by -v2 above */
+                    { "hle", "on" },
+                    { "rtm", "on" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
-- 
2.34.1


