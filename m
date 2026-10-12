Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D589CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGICx-00072y-SU; Mon, 12 Oct 2026 11:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xGICt-00072K-Ex
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:44:56 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xGICp-0004ao-Nx
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:44:53 -0400
Received: from laptop.localdomain (unknown [81.196.141.65])
 by linux.microsoft.com (Postfix) with ESMTPSA id E053020B7166;
 Mon, 12 Oct 2026 08:44:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E053020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791819887;
 bh=xVZvn5X9JVCVl0mXu+bnJCmFQ+gW0cd4rx7jbHsRzF4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ssk6ZVRVGHf6N1PmWsa4d6xBP/To1uWw2SRQvedHAZl1b/1BMWC7AGXEmso3kPuLh
 ecz9Tjh8bwbJEQCCDhF4vdZYV5ycym40rYDesdSZjytHUbouOcnspLUxx4iZHgA26F
 AZI1ErFDdzENeM6G79YuZHojtk3xHhtAX2t29l4E=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PATCH 1/2] i386/cpu.c: Adjust minimum xlevel to 0x8000_001E when
 TOPOEXT is enabled
Date: Mon, 12 Oct 2026 18:44:41 +0300
Message-ID: <20261012154442.306511-2-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012154442.306511-1-dblanzeanu@linux.microsoft.com>
References: <20261012154442.306511-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
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

This ensures the guests can discover the AMD cache and processor topology leaves
when TOPOEXT feature is enabled.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 target/i386/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 74eebeabd7..f1d8a35766 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9879,6 +9879,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
     }
 
+    /* TOPOEXT requires CPUID[0x8000001D] and CPUID[0x8000001E] */
+    if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
+    }
+
     /* SEV requires CPUID[0x8000001F] */
     if (sev_enabled()) {
         x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
-- 
2.53.0


