Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE2EECD6C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCkc-0002pW-U7; Wed, 11 Feb 2026 11:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vqCXv-0007IZ-UM
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:31 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vqCXu-0003RG-Fv
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:31 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id CFAB520B7168;
 Wed, 11 Feb 2026 07:54:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFAB520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1770825269;
 bh=QH6UHXYQ+dOZh6tJso4Fx+5mIUvLVzJLRpbtD3BCFPg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nHTpjhl78ihohyXam97gIJWooGvfepaLmyTXxbEkDcwio+A3+oBZDyfbVhGrmcboq
 /QWlQOTdtS/y/8EPGjcLGEKcnV7qxnaqhNzdSnCgs49wKGjKp3p1zkdR2GzRGmjgUt
 iD9Tv0eyC73wLmb2N/y0RkgguTxF+JkppkQ4kn8k=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH 06/10] target/i386/mshv: change cpuid mask to UINT32_MAX
Date: Wed, 11 Feb 2026 16:54:06 +0100
Message-Id: <20260211155410.203883-7-magnuskulke@linux.microsoft.com>
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

The current implementation would only override the feature bits that are
enabled, however we also want to consider disabled features, hence all
bits are set on the masks in the hypercall argument.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 9fa93d2db1..b862a7ff6a 100644
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


