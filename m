Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CC7CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKdB-0005he-Tr; Mon, 27 Oct 2025 06:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vDKd0-0005ey-Jd
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:39:08 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vDKcw-0000o0-I2
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:39:06 -0400
X-ASG-Debug-ID: 1761561536-1eb14e3d8960e50001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx2.zhaoxin.com with ESMTP id SbsFemwYB0zoAEcB (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 27 Oct 2025 18:38:56 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 27 Oct
 2025 18:38:56 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Mon, 27 Oct 2025 18:38:56 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.lan (10.28.24.130) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 27 Oct
 2025 18:21:40 +0800
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
Subject: [PATCH v2 2/4] target/i386: Add cache model for Zhaoxin Shijidadao
 vCPUs
Date: Mon, 27 Oct 2025 06:21:37 -0400
X-ASG-Orig-Subj: [PATCH v2 2/4] target/i386: Add cache model for Zhaoxin
 Shijidadao vCPUs
Message-ID: <20251027102139.270662-3-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
References: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.24.130]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 10/27/2025 6:38:55 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1761561536
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
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.149253
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
index c5853216dc..ffd1c727d5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3284,6 +3284,105 @@ static const CPUCaches yongfeng_cache_info =3D {
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


