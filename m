Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1209AECD6C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCkf-0002pn-9g; Wed, 11 Feb 2026 11:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vqCY5-0007NC-9u
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:41 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vqCY3-0003Sn-T9
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:41 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2D83620B7168;
 Wed, 11 Feb 2026 07:54:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D83620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1770825278;
 bh=HkpGIAxAdQuzfCrev9KQdB7pHBPey4VgXUf/LiB3/ZA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZsuVw4evXQXHAL1y1HpNXhZOxfcJ/ECPdYpbsvENzG8IpSt3a3lUTiHPmOlidsi+0
 iASIc82W0XwNS48yB1bIevqp5laeUrG+S9+AcnYMNqW4xmEEnPuOw3A0SSKJBr/9wT
 GZTZfIWfdiG1DO0D76ocKsHgoz4/wGvWMwPBuV1E=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH 10/10] target/i386/mshv: filter out CET bits in cpuid
Date: Wed, 11 Feb 2026 16:54:10 +0100
Message-Id: <20260211155410.203883-11-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Feb 2026 11:07:32 -0500
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

e46dcef1d0 introduced CET_U/CET_S xstate bits in the ExtSaveArea. The
response in EBX of a 0x4,1 cpuid query will contain a size contingent on
what the guest enabled in the IA32_XSS MSR (compacted xsave size).

Since the MSHV accelerator currently responds with static answers to
0x4d cpuid queries, we'll have to disable those bits, even if the host
supports them.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 3a7d9237cd..4d64c54bc6 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1781,6 +1781,25 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
     if (func == 0x01       && reg == R_ECX) {
         ret &= ~CPUID_EXT_VMX;
     }
+
+    /*
+     * MSHV currently uses static CPUID intercept results for leaf 0xD.
+     * However there are feature-responses that are dynamic based on what a
+     * guest enables in XCR0 and XSS, such as CET shadow stack.
+     *
+     * A guest which doesn't know about those features yet would encounter an
+     * unexpcted CPUID[0xD,1].EBX (compactes XSAVE size) and either fail
+     * or gracefully degrade by not using XSAVE at all.
+     *
+     * To avoid this, we filter out supervisor xstate features.
+     */
+    if (func == 0x07 && idx == 0 && reg == R_ECX) {
+        ret &= ~CPUID_7_0_ECX_CET_SHSTK;
+    }
+    if (func == 0x07 && idx == 0 && reg == R_EDX) {
+        ret &= ~CPUID_7_0_EDX_CET_IBT;
+    }
+
     return ret;
 }
 
-- 
2.34.1


