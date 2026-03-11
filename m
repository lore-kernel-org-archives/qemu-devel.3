Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F334106286C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Hqj-0006jx-UX; Wed, 11 Mar 2026 07:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w0Hqi-0006jI-7E
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:35:36 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w0Hqg-0006GZ-6x
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:35:35 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.53])
 by linux.microsoft.com (Postfix) with ESMTPSA id A43E620B710C;
 Wed, 11 Mar 2026 04:35:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A43E620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1773228933;
 bh=N5ZBicZO4ATJraH5IwOK76osUl0f+i5tz5Iv6Uq39+o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mUG4yOt20G+NMFVA8ClLf+wfzNZNX95LIMOEtdesqei3hzzKqE2jrVGTrkMAaj4Uq
 1ACDKsLHRiPK06Ggvi2iEaKV/tmb2vYH1Q2nnKg64CVGVSDeV6SAJl1D8+scQZSMC+
 gk7QcPCihtKQQTIwfmLxrXulHvsIxeDEMjeaKjJc=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2 8/9] target/i386/mshv: filter out CET bits in cpuid
Date: Wed, 11 Mar 2026 12:35:04 +0100
Message-Id: <20260311113505.1177878-9-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index ee25eb5f6f..2c66a52709 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1663,6 +1663,25 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
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


