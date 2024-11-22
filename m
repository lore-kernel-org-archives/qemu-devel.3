Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41677E65D35
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 08:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEPRI-0000S2-N6; Fri, 22 Nov 2024 03:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tEPRC-0000R7-Pr
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:54:52 -0500
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tEPRA-0005TL-40
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:54:50 -0500
X-ASG-Debug-ID: 1732265683-086e2312d603820001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx1.zhaoxin.com with ESMTP id 4zMdX0nuWe36phMh (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 22 Nov 2024 16:54:43 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Nov
 2024 16:54:43 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264]) by
 ZXSHMBX1.zhaoxin.com ([fe80::3066:e339:e3d6:5264%7]) with mapi id
 15.01.2507.039; Fri, 22 Nov 2024 16:54:43 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:21:38 +0800
From: EwanHai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH RESEND v4 4/4] target/i386: Mask CMPLegacy bit in
 CPUID[0x80000001].ECX for Zhaoxin CPUs
Date: Fri, 22 Nov 2024 01:21:35 -0500
X-ASG-Orig-Subj: [PATCH RESEND v4 4/4] target/i386: Mask CMPLegacy bit in
 CPUID[0x80000001].ECX for Zhaoxin CPUs
Message-ID: <20241122062135.479200-5-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122062135.479200-1-ewanhai-oc@zhaoxin.com>
References: <20241122062135.479200-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 11/22/2024 4:54:41 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1732265683
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2287
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.133532
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zhaoxin CPUs (including vendors "Shanghai" and "Centaurhauls") handle the
CMPLegacy bit similarly to Intel CPUs. Therefore, this commit masks the
CMPLegacy bit in CPUID[0x80000001].ECX for Zhaoxin CPUs, just as it is done
for Intel CPUs.

AMD uses the CMPLegacy bit (CPUID[0x80000001].ECX.bit1) along with other CP=
UID
information to enumerate platform topology (e.g., the number of logical
processors per package). However, for Intel and other CPUs that follow Inte=
l's
behavior, CPUID[0x80000001].ECX.bit1 is reserved.

- Impact on Intel and similar CPUs:
This change has no effect on Intel and similar CPUs, as the goal is to
accurately emulate CPU CPUID information.

- Impact on Linux Guests running on Intel (and similar) vCPUs:
During boot, Linux checks if the CPU supports Hyper-Threading. For the Linu=
x
kernel before v6.9, if it detects X86_FEATURE_CMP_LEGACY, it assumes
Hyper-Threading is not supported. For Intel and similar vCPUs, if the
CMPLegacy bit is not masked in CPUID[0x80000001].ECX, Linux will incorrectl=
y
assume that Hyper-Threading is not supported, even if the vCPU does support=
 it.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ae8e9ccfc7..2474ebbafc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7089,12 +7089,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
=20
         /* The Linux kernel checks for the CMPLegacy bit and
          * discards multiple thread information if it is set.
-         * So don't set it here for Intel to make Linux guests happy.
+         * So don't set it here for Intel(and other processors
+         * following Intel's behavior) to make Linux guests happy.
          */
         if (threads_per_pkg > 1) {
-            if (env->cpuid_vendor1 !=3D CPUID_VENDOR_INTEL_1 ||
-                env->cpuid_vendor2 !=3D CPUID_VENDOR_INTEL_2 ||
-                env->cpuid_vendor3 !=3D CPUID_VENDOR_INTEL_3) {
+            if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {
                 *ecx |=3D 1 << 1;    /* CmpLegacy bit */
             }
         }
--=20
2.34.1


