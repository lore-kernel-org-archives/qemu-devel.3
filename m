Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A410EEC2AF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXc-00072b-6i; Mon, 23 Feb 2026 18:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXZ-00070W-Sf
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:37 -0500
Received: from qs-2002d-snip4-11.eps.apple.com ([57.103.87.171]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXX-0004Rh-J7
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:37 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 31B4818003AD; Mon, 23 Feb 2026 23:40:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890034; x=1774482034;
 bh=A04BlxLz7/khJrSYJAsW3ORmDALVzlVjhIJh6HzuFL4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WWHMCzCtVh0nISSgReieykXTIpLXNlak9hB91jaemVLPJwLqUaXphZotYDnxqOQh/l7aMg6SN3LuEMTGkVdtgHTMkozUEAxMCRRGqNBJSOnwjVNi68JNwDSRSCPuS5p0j/MDjPp75/3IbDym0e3F/Vh6HNCrUFxmUs3yANzmcih5yhifsLwqZQYPEHxt6IYLsjDM4aKWSwj7UW3bCqalzUy15IVMLc/BAe0uVd//i9SgR1QGqqR0bVxUMrvMQlPs1O3NPHe3sFmqGC2Z7F1L6KgaY+HKkZGo0ISjaM0YHT26BP1CxcCwymREJTt7RSrNHTeqefNWX992rNViFpN+Uw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 3D1961800149; Mon, 23 Feb 2026 23:40:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 20/28] hvf: i386: save/restore CR0/2/3
Date: Tue, 24 Feb 2026 00:39:42 +0100
Message-ID: <20260223233950.96076-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX2krZbXSEOvpo
 ANOikxIzn7GKbyewMzptgx3Acwa6atw7E0FbORXe7zfiCdO81b5bIiyAIDHacXjbVi3fZ0ASzmK
 QxEdmqi07pQ+Kwb8JlYVMUmSmcY23BXwdLZPZKIgGqUDU3P3OyjZtg6CsDjqHenpCv/3nOrlvTo
 4ty3nlgjQtJnUJm9W7HtIxG9+3lLF126g6Le7b3mSJM2ZeQuFTkrhuEs2SMjlPDd/pmzem4RvG0
 muBAv8sYjli6lDe9dex47SPEDc/lIaLiEEA6H8tPosafhuryQAOWcx6bIdMieEQVs3hzn+/BhQi
 VemCxVzGT/Bs7hLRDGwh+ZBs9hjQpcEs4XCHVlPapgDI08Sf3HZPsDIPv1JldM=
X-Authority-Info-Out: v=2.4 cv=VPjQXtPX c=1 sm=1 tr=0 ts=699ce572
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8nbFswGFAu2En9I1cXwA:9
X-Proofpoint-ORIG-GUID: -4Hw4PnpnnNES3VH6PLfmsNBBQ217DVq
X-Proofpoint-GUID: -4Hw4PnpnnNES3VH6PLfmsNBBQ217DVq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=747 suspectscore=0 clxscore=1030 lowpriorityscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602230206
X-JNJ: AAAAAAABAcRhMu8TKMajChsZJDFZWdgnwYEjzUfWzxXjaYeGsIVikJ1hCj631O+QZKvsDy6TyJVCGTgrX7DIuxTYAae/0w6qde2yco+4qRG3WtT/6j+pRL1RW9rBROvCeB86PXiTGK6eE6HFZ88LS3r3f//ZoRKGQAMKwcIAMSjnfSnvm3ef5up9zFUAOMqXRRDqWZgC5/mX3Uff0pvvraFPVI5Gac7bWhJ5zncy4ReyKAyS6yXVnie/ghmd6pgFOldXn6osBU2fDq6Q+inhcG23hb9yFknGy10X2zJaG/ryp/6R24/6vfLwuTicxdCLewOxjiyNUFPcFWRsKYiGkMdLw2fMwLt5N7LF4uTjv/R2qahj9s8T6cHEYDl0Nm0tV3xlFhx1aDaOmEB4EmsO+ZsIh0XKPMUACOHvecWO1nQL54wq9bu7RYXiU8tlAPXc6hbySeH8PRLeF9sQ+69L/NY+Nxr8kTeT+WH0z/nsU+FutcPEX0Eok8wkdfvjfw842EK5y64Gf+T32uHZFMn2+vcYOQTBJ/81iy64DmjxNeeq/ks9FuFcDvqJu+qMNrN8097uhoalBjAN8MIMho/83/B3kyNaEvw09KSTJMwYTQdTuI5o66aeLu0PKa8eNQuIq79NuTPUfw3OnFxmu9N/+Lqu2nP+t8m0YsqbJhAWBJrQx2N4qPAS/tZ2PoYNr4RGzqXrk1DbegOgDWlrjdWxO1aqf3NIVkjNGUzLTAglPB7vZzQQeAr9aK/8/ZDLP1Mc8ozovtV9kwxVUaVDKjLTAwJc0A==
Received-SPF: pass client-ip=57.103.87.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

For symmetry, save/restore the same set of registers even when not needed.

CR2 save/restore needed as page faults injected to the guest imply modifying CR2.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/hvf/hvf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index fb039ff7bd..a70f8461b0 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -477,7 +477,19 @@ static void hvf_load_crs(CPUState *cs)
 
     env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
     env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
+    env->cr[2] = rreg(cpu->accel->fd, HV_X86_CR2);
 }
+
+static void hvf_save_crs(CPUState *cs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    wvmcs(cpu->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
+    wvmcs(cpu->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
+    wreg(cs->accel->fd, HV_X86_CR2, env->cr[2]);
+}
+
 void hvf_load_regs(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -794,6 +806,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
             decode_instruction(env, &decode);
             exec_instruction(env, &decode);
             hvf_store_regs(cpu);
+            hvf_save_crs(cpu);
             break;
         }
         break;
@@ -837,6 +850,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         assert(ins_len == decode.len);
         exec_instruction(env, &decode);
         hvf_store_regs(cpu);
+        hvf_save_crs(cpu);
 
         break;
     }
@@ -942,6 +956,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         decode_instruction(env, &decode);
         exec_instruction(env, &decode);
         hvf_store_regs(cpu);
+        hvf_save_crs(cpu);
         break;
     }
     case EXIT_REASON_TPR: {
-- 
2.50.1 (Apple Git-155)


