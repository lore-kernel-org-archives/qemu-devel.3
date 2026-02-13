Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79246EF48C2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqk8j-0008QB-JO; Thu, 12 Feb 2026 22:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8i-0008OL-6V
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:44 -0500
Received: from p-west1-cluster4-host2-snip4-10.eps.apple.com ([57.103.65.151]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8g-0005ti-J0
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:43 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 897C018002DF; Fri, 13 Feb 2026 03:46:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954400; x=1773546400;
 bh=9sUcaeoz6C4CulqwK75rnnECZ/Yp9/cyUOcLGfOPaHE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AR0AxXROQDzB193Ge8KjhrVyS6btpJUj/TMsJuDK26Mszm+tG87FZ1mCa6AAszQRz5uLPjJMEHRz/txMggv1xg72thXuJoNOgJuPiBTS+6gFTWuEstcfp7TIsPWb3aK/wpM/GeX27gVFk4fIDCZtc43XJHHS4L9CvDyzl0KR3UH8RQkXJk48kgijjByqlS6iU+e0M46q0bL/qDA7k79oSbNxxsnQ9ZaFM1pOQn2OiSOfi9k+HZjx2gd8Y7QiD50ZZKInHZWTgZTAvHdiEPELbKZx7o1/EwWrXk5AalLf0d34u1sxqfu7o94fqG0B7qWeAUoaAPlPb7TwjNaIZer3dg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 3F0C318002E7; Fri, 13 Feb 2026 03:46:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 10/10] whpx: x86: optimise MMIO vmexit by only restoring
 needed registers
Date: Fri, 13 Feb 2026 04:45:53 +0100
Message-ID: <20260213034556.13471-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213034556.13471-1-mohamed@unpredictable.fr>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cNIj7Afb4kT9UpQebrC6E2oyeumOb4De
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNSBTYWx0ZWRfX8lFIho0EPRpj
 ogr6Gu6J9838YPGloZfJDY9bO5fGY5mzmqR4B9T0qMRWMTovznweoNyS1whQUKVeyuVJord5ymc
 /oEcW1AUIlyzz/eztnUTMWfO950AOh1LYMdUY53KOk6diDXOfE9Ekdxb79X9kBzCf+X9Iqo4MWp
 orPfzPv1bWKmCBLV+jBeyfcih+ohUdyAgKSxumkrLyf3yK05BInFOgVcItaJmLf2bGnQAubVV7r
 3OGAk/OCiuHq9V+LlyaSAvpbGRUm/Xq5Ya19QNWNyjHgX/5jPix5+QC+jr72E1V8QKdRJmkbyyf
 /LwIT9I4CNrvgRYhxeCrwCDFiCcOSctUawVnjn0VCgURtShmHbYkFGZU+7wBzA=
X-Proofpoint-GUID: cNIj7Afb4kT9UpQebrC6E2oyeumOb4De
X-Authority-Info-Out: v=2.4 cv=QPRlhwLL c=1 sm=1 tr=0 ts=698e9ea0
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=WklI_BSY2m36_CZppDAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1030 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130025
X-JNJ: AAAAAAABgZbtO77xBwNm/5KT6Ys/W//a3J9WytbP4X9T68gSIbwzsFVE2FUanxifmyop7iBbySJjr/+kg1x9MRyQhofQvFzm7VJjCUZV851b8pA38vqGQG9B4jUbviLoirJKGL9imwkID8DfYgs2JRMbCfZoS8N6kmaQjk5h7rKhs7fHdaHO1PMerA0ibexgANyyPrdKR/619FArZhmlzACTQ33J6zx9JJRxjU+wYFMzeJ8cWFQewC+BQPT6PM9Nqqy6OLMcGRm7LKJWpXyzyiVHPDjCY8DDLEYoisMB2NRaN+ZpDywn/yoXtWcxCfcM4PB+iyhAFQmBH+gMmWFS5v+xFBWNJGLT6kXeVgkw/HgcKtM/dYO8CD6aBu1QWQQ9CklTdoTHQHffHMdShRN7I5TozATJFwhzypO4E7YhxIvwLK/8Hx4Bm6u2shWre8Ht0mmJuZeuP4koxNDBq7LpSaVI1FgvpYN1C46siJ6NaGsYWQSGWq60y+EGHHCZTLPC1hJMetioaqgcwI0TgdG/+cMSUeBhjPNfZswsQwG/yYgr3sDRn/LabgoFICEXO4xa1fMJJgDf3G51powenhiLrnTz10i/5EvAuiYOBokHopdQ5VrKR4hmpvi+f/e3IwzsCE7tVTLrLb6BaQBPqYmJIIKHtEKxmgNPnYIugYAqnGJJS3VEnVu/db3JZKQZkpugLnToE4llUcrWMjN/TGZ0T7NL/jbVJw/8pGVOz8pg5gaelTBhqLY5AUOX0ufzU1O4pma37wN1ZBWTXZ4fnTii4MPwPEU4bW65rkANLtjyuBIzHahP
Received-SPF: pass client-ip=57.103.65.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-accel-ops.h |  8 +++++---
 target/i386/whpx/whpx-all.c     | 12 ++++++++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/system/whpx-accel-ops.h b/include/system/whpx-accel-ops.h
index ed9d4c49f4..469a3a4350 100644
--- a/include/system/whpx-accel-ops.h
+++ b/include/system/whpx-accel-ops.h
@@ -22,11 +22,13 @@ void whpx_cpu_synchronize_post_reset(CPUState *cpu);
 void whpx_cpu_synchronize_post_init(CPUState *cpu);
 void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+/* subset of runtime state for faster returns from vmexit */
+#define WHPX_SET_FAST_RUNTIME_STATE   1
 /* state subset only touched by the VCPU itself during runtime */
-#define WHPX_SET_RUNTIME_STATE   1
+#define WHPX_SET_RUNTIME_STATE   2
 /* state subset modified during VCPU reset */
-#define WHPX_SET_RESET_STATE     2
+#define WHPX_SET_RESET_STATE     3
 /* full state set, modified during initialization or on vmload */
-#define WHPX_SET_FULL_STATE      3
+#define WHPX_SET_FULL_STATE      4
 
 #endif /* TARGET_I386_WHPX_ACCEL_OPS_H */
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0e8fb0e72e..61251a2835 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -420,6 +420,13 @@ void whpx_set_registers(CPUState *cpu, int level)
         vcxt.values[idx].Segment = whpx_seg_q2h(&env->segs[i], v86, r86);
     }
 
+    /*
+     * This is a hot path called on every MMIO access.
+     */
+    if (level <= WHPX_SET_FAST_RUNTIME_STATE) {
+        goto skip_to_set_registers;
+    }
+
     assert(idx == WHvX64RegisterLdtr);
     vcxt.values[idx++].Segment = whpx_seg_q2h(&env->ldt, 0, 0);
 
@@ -529,10 +536,11 @@ void whpx_set_registers(CPUState *cpu, int level)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
+    skip_to_set_registers:
     hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
         whpx->partition, cpu->cpu_index,
         whpx_register_names,
-        RTL_NUMBER_OF(whpx_register_names),
+        idx,
         &vcxt.values[0]);
 
     if (FAILED(hr)) {
@@ -771,7 +779,7 @@ static int emulate_instruction(CPUState *cpu, const uint8_t *insn_bytes, size_t
     whpx_get_registers(cpu);
     decode_instruction_stream(env, &decode, &stream);
     exec_instruction(env, &decode);
-    whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+    whpx_set_registers(cpu, WHPX_SET_FAST_RUNTIME_STATE);
 
     return 0;
 }
-- 
2.50.1 (Apple Git-155)


