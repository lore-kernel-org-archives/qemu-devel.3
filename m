Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409E7C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz9Jh-000826-Fn; Wed, 26 Aug 2026 04:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1wz9Jf-00081S-FH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:03 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ewanhai-oc@zhaoxin.com>) id 1wz9Jd-0001ZM-MH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:03 -0400
Received: from zhaoxin.com (unknown [127.0.0.1])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGR0b2KzcYn0h;
 Wed, 26 Aug 2026 16:48:47 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGQ4LhyzcYn0Y;
 Wed, 26 Aug 2026 16:48:46 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net
 [10.28.24.2])
 by zhaoxin.com (8.30) with ESMTP0ad83d5e363ad6b33aa432858fcc50d3
 Wed, 26 Aug 2026 16:48:45 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: [PATCH v4 4/4] target/i386: Enable new cryptographic features in
 YongFeng-v4
Date: Wed, 26 Aug 2026 16:48:38 +0800
Message-Id: <20260826084838.2107629-5-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
References: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=210.0.225.12; envelope-from=ewanhai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.001,
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

Add YongFeng-v4 with the SM2, CCS, RNG2, PHE2 and RSA feature pairs
enabled.

Link: https://lore.kernel.org/all/20260610023512.3690734-1-ewanhai-oc@zhaoxin.com/
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 70904810b5..0e842d0c80 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7208,10 +7208,7 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
         .features[FEAT_8000_0007_EDX] = CPUID_APM_INVTSC,
-        /*
-         * TODO: When the Linux kernel introduces other existing definitions
-         * for this leaf, remember to update the definitions here.
-         */
+        /* missing: PARALLAX/PARALLAX_EN, TM3/TM3_EN */
         .features[FEAT_C000_0001_EDX] =
             CPUID_C000_0001_EDX_PMM_EN | CPUID_C000_0001_EDX_PMM |
             CPUID_C000_0001_EDX_PHE_EN | CPUID_C000_0001_EDX_PHE |
@@ -7309,6 +7306,23 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 4,
+                .note = "with additional cryptographic features",
+                .props = (PropValue[]) {
+                    { "sm2", "on" },
+                    { "sm2-en", "on" },
+                    { "ccs", "on" },
+                    { "ccs-en", "on" },
+                    { "rng2", "on" },
+                    { "rng2-en", "on" },
+                    { "phe2", "on" },
+                    { "phe2-en", "on" },
+                    { "rsa", "on" },
+                    { "rsa-en", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ }
         }
     },
-- 
2.34.1



