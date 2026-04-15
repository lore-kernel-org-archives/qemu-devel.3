Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAE0F43858
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD3cX-0006zf-78; Wed, 15 Apr 2026 13:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wD3bR-0006Y1-Dp
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:00:47 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wD3bJ-0005wV-C9
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:00:32 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id C163720B7135;
 Wed, 15 Apr 2026 10:00:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C163720B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776272427;
 bh=3qKH/AOjRjhm/x8a9eu7OnZ3TkDZ/w2V+YOycx7vrL0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M2MDa9pSUuL1QlHXZY+VKOnV/SpE8hN8MpdlL4nDXxHh5puk8M0ZP97rakmerMWd9
 sjnoSRhkshUiOwADDMjnXqeWqgYercp3b0nScS3hfsF79JeUio0oZCiXvgYvAzQJ3v
 BQWxY8x47jnw4PyKuXYqw0Jyz5dgiFnkRN8dPoA0=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v5 4/9] target/i386/mshv: change cpuid mask to UINT32_MAX
Date: Wed, 15 Apr 2026 19:00:07 +0200
Message-Id: <20260415170012.520934-5-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415170012.520934-1-magnuskulke@linux.microsoft.com>
References: <20260415170012.520934-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The current implementation would only override the feature bits that are
enabled, however we also want to consider disabled features, hence all
bits are set on the masks in the hypercall argument.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
---
 target/i386/mshv/mshv-cpu.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 4183727a86..e42b5a614d 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -538,22 +538,17 @@ static int register_intercept_result_cpuid_entry(const CPUState *cpu,
         .input.always_override = always_override,
         .input.padding = 0,
         /*
-         * With regard to masks - these are to specify bits to be overwritten
-         * The current CpuidEntry structure wouldn't allow to carry the masks
-         * in addition to the actual register values. For this reason, the
-         * masks are set to the exact values of the corresponding register bits
-         * to be registered for an overwrite. To view resulting values the
-         * hypervisor would return, HvCallGetVpCpuidValues hypercall can be
-         * used.
+         * Masks specify which bits to override. Set to 0xFFFFFFFF to
+         * override all bits with the values from the QEMU CPU model.
          */
         .result.eax = entry->eax,
-        .result.eax_mask = entry->eax,
+        .result.eax_mask = 0xFFFFFFFF,
         .result.ebx = entry->ebx,
-        .result.ebx_mask = entry->ebx,
+        .result.ebx_mask = 0xFFFFFFFF,
         .result.ecx = entry->ecx,
-        .result.ecx_mask = entry->ecx,
+        .result.ecx_mask = 0xFFFFFFFF,
         .result.edx = entry->edx,
-        .result.edx_mask = entry->edx,
+        .result.edx_mask = 0xFFFFFFFF,
     };
     union hv_register_intercept_result_parameters parameters = {
         .cpuid = cpuid_params,
-- 
2.34.1


