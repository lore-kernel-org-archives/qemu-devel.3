Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9E606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=R8qGFG/8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQiae-0003k2-UQ; Tue, 10 Nov 2026 04:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xQiab-0003jD-CG
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 04:56:29 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xQiaZ-0004nX-K4
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 04:56:28 -0500
Received: from laptop.localdomain (unknown [81.196.141.39])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3BAE320B7169;
 Tue, 10 Nov 2026 01:56:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BAE320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794304583;
 bh=ntLjdW/MmqC2nG46W/sqXowqt4r14nluTg+4QyLOY9E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R8qGFG/81FDZehjs0Ms7Po71YdBbKW/u9oJUzXGHB3tn0SprV+HgRQiWZ6YabZ7Uc
 s2Hr3mjJ4RGEVHzZ70ZHKK294+FdEsZEVCBLtHn+OsIByGocgH7IShrF7xikjwixdB
 sEsJAdPPfBaKrkIzX5gAkzFuK2LKujJhpDgNNJ0Q=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH v2 1/3] i386/cpu.c: Adjust minimum xlevel to 0x8000_001E when
 TOPOEXT is enabled
Date: Tue, 10 Nov 2026 11:56:15 +0200
Message-ID: <20261110095617.50713-2-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110095617.50713-1-dblanzeanu@linux.microsoft.com>
References: <20261110095617.50713-1-dblanzeanu@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This ensures the guests can discover the AMD cache and processor topology leaves
when TOPOEXT feature is enabled.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 target/i386/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4d4..e443132ce9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9911,6 +9911,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
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
2.54.0


