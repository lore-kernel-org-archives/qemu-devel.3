Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9860A262B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=oLuqA6Z6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVsqL-0002p2-ER; Tue, 24 Nov 2026 10:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xVsqJ-0002o6-Eq
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:54:03 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xVsqH-0008FV-QS
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:54:03 -0500
Received: from laptop.localdomain (unknown [81.196.141.97])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6D8A520B7170;
 Tue, 24 Nov 2026 07:53:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D8A520B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795535636;
 bh=CfaOSz3FiLQShzz3iWKvkgoqb6sBzNcN+Xv4HeIjTw8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oLuqA6Z66Zmx5aSyTCGuELOsD/Z18Zu6pQdE/Xnvrm4o3mlI18BvmoUv2YtQA9RoS
 RIkTJjPrvdTzNWJhsstrZNq0ysI3wK0xJNzZfY8GdctR7yXZrbyo7lMe3YEUy8POBX
 /b+QdxddnC3vJ6GktySPOqm7Ab/x7bYNtpqfosR4=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PATCH v3 2/2] target/i386/mshv: Initialize the extended CPUID limit
 for host/max CPUs
Date: Tue, 24 Nov 2026 17:53:48 +0200
Message-ID: <20261124155348.165875-3-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1.vfs.0.0
In-Reply-To: <20261124155348.165875-1-dblanzeanu@linux.microsoft.com>
References: <20261124155348.165875-1-dblanzeanu@linux.microsoft.com>
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

Initialize cpuid_min_level from the host visible extended CPUID maximum
for host/max CPUd, following kvm's initialization pattern.

Let feature expansion determine xlevel while preserving explicit CLI
limits and named CPU models defaults.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 79fe357c13..5b13c0915e 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -2564,8 +2564,15 @@ int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
 static void mshv_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
+
+    if (xcc->max_features) {
+        cpu->env.cpuid_min_xlevel =
+            mshv_get_supported_cpuid(0x80000000, 0, R_EAX);
+    }
+
     mshv_cpu_xsave_init();
 }
 
-- 
2.48.1.vfs.0.0


