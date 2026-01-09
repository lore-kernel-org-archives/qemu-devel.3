Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83260D232C7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 02:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve21D-0000wl-KY; Thu, 08 Jan 2026 21:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1ve21B-0000vz-Jv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:14:25 -0500
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1ve219-0002N4-CR
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:14:25 -0500
X-ASG-Debug-ID: 1767924857-1eb14e7c0408680001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id 5YpCVMNVOchdNMiA (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 09 Jan 2026 10:14:17 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 9 Jan
 2026 10:14:17 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Fri, 9 Jan 2026 10:14:17 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ewan-server.zhaoxin.com (10.28.44.15) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 9 Jan
 2026 10:10:28 +0800
Received: by ewan-server.zhaoxin.com (Postfix, from userid 1000)
 id 19E7C2D00059; Thu,  8 Jan 2026 21:10:28 -0500 (EST)
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
Subject: [PATCH v3 1/3] target/i386: Add cache model for Zhaoxin Shijidadao
 vCPUs
Date: Thu, 8 Jan 2026 21:10:26 -0500
X-ASG-Orig-Subj: [PATCH v3 1/3] target/i386: Add cache model for Zhaoxin
 Shijidadao vCPUs
Message-ID: <20260109021028.83985-2-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
References: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.44.15]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 1/9/2026 10:14:16 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1767924857
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3328
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.152762
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
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

Zhaoxin "Shijidadao" vCPUs require built-in cache enumeration in QEMU
to properly report CPUID leaf 0x4 and 0x80000005/0x80000006 when
'host-cache-info' is disabled.

This patch defines the L1/L2/L3 cache parameters for the Shijidadao
architecture, preparing for use in both client and server models.

Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 37803cd724..1c85445f48 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3423,6 +3423,105 @@ static const CPUCaches yongfeng_cache_info =3D {
     },
 };
=20
+static const CPUCaches shijidadao_cache_info =3D {
+    .l1d_cache =3D &(CPUCacheInfo) {
+        /* CPUID 0x4.0x0.EAX */
+        .type =3D DATA_CACHE,
+        .level =3D 1,
+        .self_init =3D true,
+
+        /* CPUID 0x4.0x0.EBX */
+        .line_size =3D 64,
+        .partitions =3D 1,
+        .associativity =3D 8,
+
+        /* CPUID 0x4.0x0.ECX */
+        .sets =3D 64,
+
+        /* CPUID 0x4.0x0.EDX */
+        .no_invd_sharing =3D false,
+        .inclusive =3D false,
+        .complex_indexing =3D false,
+
+        /* CPUID 0x80000005.ECX */
+        .lines_per_tag =3D 1,
+        .size =3D 32 * KiB,
+
+        .share_level =3D CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache =3D &(CPUCacheInfo) {
+        /* CPUID 0x4.0x1.EAX */
+        .type =3D INSTRUCTION_CACHE,
+        .level =3D 1,
+        .self_init =3D true,
+
+        /* CPUID 0x4.0x1.EBX */
+        .line_size =3D 64,
+        .partitions =3D 1,
+        .associativity =3D 16,
+
+        /* CPUID 0x4.0x1.ECX */
+        .sets =3D 64,
+
+        /* CPUID 0x4.0x1.EDX */
+        .no_invd_sharing =3D false,
+        .inclusive =3D false,
+        .complex_indexing =3D false,
+
+        /* CPUID 0x80000005.EDX */
+        .lines_per_tag =3D 1,
+        .size =3D 64 * KiB,
+
+        .share_level =3D CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache =3D &(CPUCacheInfo) {
+        /* CPUID 0x4.0x2.EAX */
+        .type =3D UNIFIED_CACHE,
+        .level =3D 2,
+        .self_init =3D true,
+
+        /* CPUID 0x4.0x2.EBX */
+        .line_size =3D 64,
+        .partitions =3D 1,
+        .associativity =3D 8,
+
+        /* CPUID 0x4.0x2.ECX */
+        .sets =3D 1024,
+
+        /* CPUID 0x4.0x2.EDX */
+        .no_invd_sharing =3D false,
+        .inclusive =3D true,
+        .complex_indexing =3D false,
+
+        /* CPUID 0x80000006.ECX */
+        .size =3D 512 * KiB,
+
+        .share_level =3D CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache =3D &(CPUCacheInfo) {
+        /* CPUID 0x4.0x3.EAX */
+        .type =3D UNIFIED_CACHE,
+        .level =3D 3,
+        .self_init =3D true,
+
+        /* CPUID 0x4.0x3.EBX */
+        .line_size =3D 64,
+        .partitions =3D 1,
+        .associativity =3D 16,
+
+        /* CPUID 0x4.0x3.ECX */
+        .sets =3D 32768,
+
+        /* CPUID 0x4.0x3.EDX */
+        .no_invd_sharing =3D false,
+        .inclusive =3D true,
+        .complex_indexing =3D false,
+
+        .size =3D 32 * MiB,
+        .share_level =3D CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 /* The following VMX features are not supported by KVM and are left out in=
 the
  * CPU definitions:
  *
--=20
2.34.1


