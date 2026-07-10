Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753AEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8HN-0006rV-Us; Fri, 10 Jul 2026 06:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wi8HN-0006rN-6y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:16:21 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wi8HL-0006Oo-QX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:16:20 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c0c70.dip0.t-ipconnect.de
 [62.156.12.112])
 by linux.microsoft.com (Postfix) with ESMTPSA id 60E4820B7170;
 Fri, 10 Jul 2026 03:16:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60E4820B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783678572;
 bh=Ap1AGdm2urEO2qR8Nc2JiIOZF+4iUaECLj3pRkt9gko=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sU3YP/Vo4H0EUNT3rRSdU7r0qOVqQKc4fdjWaA7eBL3WyqUFFgBk5CDKItNp1zKPy
 K4X1W4xNjDy7CUU1zEo7U7cSnviq2FLmAmaH0J6Hl3s/jrd8c5IRiEwAafeNNk4ixS
 LflCWZnylJEtjxrPzFyPkOt3P5lj6+O9S1fNzvqw=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: [PATCH 11/12] target/i386/mshv: toggle fpu/xsave migration
Date: Fri, 10 Jul 2026 12:15:33 +0200
Message-Id: <20260710101534.664604-12-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
References: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

MSHV exposes overlapping legacy FP/SSE state through two paths:
explicit Hyper-V FPU/XMM + registers and VP XSAVE state. There can
be subtle inconsistencies across migrations when XSAVE is written after
FPU state.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index bff1ac9d17..f528dd2b9a 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1057,7 +1057,7 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
-    ret = get_fpu(cpu);
+    ret = get_xsave_state(cpu);
     if (ret < 0) {
         return ret;
     }
@@ -1072,7 +1072,7 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
-    ret = get_xsave_state(cpu);
+    ret = get_fpu(cpu);
     if (ret < 0) {
         return ret;
     }
@@ -1551,7 +1551,7 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
-    ret = set_fpu(cpu);
+    ret = set_xsave_state(cpu);
     if (ret < 0) {
         return ret;
     }
@@ -1567,7 +1567,8 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
-    ret = set_xsave_state(cpu);
+    /* INVARIANT: legacy FPU state must be restored after XSAVE */
+    ret = set_fpu(cpu);
     if (ret < 0) {
         return ret;
     }
-- 
2.34.1


