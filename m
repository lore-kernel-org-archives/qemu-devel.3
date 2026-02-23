Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE266EEC2AE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXb-00071k-Gz; Mon, 23 Feb 2026 18:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXY-0006zG-TW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:36 -0500
Received: from qs-2002h-snip4-4.eps.apple.com ([57.103.87.205]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXX-0004Re-BZ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:36 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 CCB3018003AE; Mon, 23 Feb 2026 23:40:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890033; x=1774482033;
 bh=IYoDu1Lf/5IVuiCOr/JCatr7nNqgDdTH9YXn2YCe0wI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZCsEWU2WBjlJlJORXETj42gcYbQq/BTa/MPaVfdYJKq2o0gzFjA6RwCmCKzoVV0Jrxl1gRklYlUW4Y3Ia8aXncW0yAfI6vHiOZ9i91EfzzKfemWj01RkGTRevPX/KZZFKEL213OMxN4Sy5H15K1VBpvAJ+B/ANt9T5b/qwJKsT+HJX9gMsxruc6smqlJNJSiV2OXY6l64fPLvh4Xu7m7GXANV9sYH9IdMRQW4AlLp8NuhmXnCY6hguOpaU+q3CqUt/ScX/bKjoLYPMnqQjri+utzr1Xh/1xMoukfvKDy32yQJiiMD1z4gkf3EldJiQYVW7eYoxK95y1azcSF9HeShA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 571571800395; Mon, 23 Feb 2026 23:40:28 +0000 (UTC)
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
Subject: [PATCH v6 18/28] target/i386: emulate: 5-level paging for the page
 table walker
Date: Tue, 24 Feb 2026 00:39:40 +0100
Message-ID: <20260223233950.96076-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX0c2lWgE76uzI
 8wdeOUiounPL+tFOYmXImn6leI3RGDSr3zn94sELMY7WVEQzbBNXi0AxaGmhU0aTKZEI6ysduHC
 EL7diL21PfNeHXFXqcgkJMiwzJq93A4wDM74o/688VofZDjJLb2xHUj8CxCMsndVbDduUUCkZt1
 9L9Ws5Kgb+I9GUcZPa7RBgMJUfuUd4G1Op2i3MPiR2FSpEQ/D3irKUYsHpiRJtgtZzPWoBfKggK
 +Ymn2vG2HOmj0Bz5+rIbDzptVfbgeWlP0LHZOPZVoOANYGhCYBYQ6skKs7HluDEb5iS4vxoeT8E
 h4S6bm7EttMGnLasoVAgu9++KQ2vls0UDppXitFlm5PnFxvRzzOhqtv1nhtOnM=
X-Authority-Info-Out: v=2.4 cv=PZryRyhd c=1 sm=1 tr=0 ts=699ce56f
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=A61MTNvy9Chr7HSFv3YA:9
X-Proofpoint-ORIG-GUID: kI5Q1hNpvC8-IcxPw1xWngOrAhcIKrz0
X-Proofpoint-GUID: kI5Q1hNpvC8-IcxPw1xWngOrAhcIKrz0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1030 lowpriorityscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABdImDRWC7hS7H8K7QAMIo6Xhv69XRtQrowP88b0tU3I2PgigQdcpVUMCnMRswLD8CYEAd6aom9mRCKYa2VvABaYcrRDXEElepzbSsi+Dm59+VmYR9FLV9Tbg+QPKg7lq6caTEaoBI6oIuKUPLpVafsNXKVVNtg/X+cc6cbNBDEelSPBubW2wMjnzn8oMSBeZmJjFxVaM9Cfv3M8NDYq6O9ENjKGIhDJ5z9PFxi8vQ4ct/jX0l0O9fxXv6PYFHdHPfBnLQT95IFGBVxi5wgn4jsR0koPaLsizmBqzomV9ut7pxjG/Zs27iNVWU2ZLir+q4V9DcG2w2ezL4GNom/zy3MABhsM2F4almHqp8fDWOiD2runLSuMVXvfDcNjA1wPDaQIgRtwNUpSM3WzgmUBQjMFi3UEU3dR/25iWj0PQObtpXJO+HqDc+n/gjsco6ip5n83t2Z3BmcBCQnmWV6kF5lj9owGPBhB79CR55/kKGFefmCd3FAiuI922uu9Oo/rQg+ASL7z4r2Zq1YS6ATDbGROb/ofpzEQjK5Jo4Ec77f1vJ48OQJ3gCa+E1yb5NxOKyCCEGabgwyMPcvVOKNZaHZmdE0ihULbx5QskacXK335qmR4WIm6D2yAUCT6IORWoO6PO9J+txxC44B18qmjtdrwYCes8NPKfi0x7j5o/drI3g09Aj6EV35RlL6uxFrR3se645gLG5HVcb+uDdKhxXlDHg9TWfEo3euOAFDvl7who8f8Mo0uACFGgIxiWCNKNo8vrLcvcIsyR7lji3gRTT5nSYDLZzw2F1Ng==
Received-SPF: pass client-ip=57.103.87.205;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86.h         | 1 +
 target/i386/emulate/x86_helpers.c | 8 ++++++++
 target/i386/emulate/x86_mmu.c     | 3 +++
 target/i386/hvf/x86.c             | 5 +++++
 4 files changed, 17 insertions(+)

diff --git a/target/i386/emulate/x86.h b/target/i386/emulate/x86.h
index 73edccfba0..caf0e3be50 100644
--- a/target/i386/emulate/x86.h
+++ b/target/i386/emulate/x86.h
@@ -263,6 +263,7 @@ bool x86_is_protected(CPUState *cpu);
 bool x86_is_real(CPUState *cpu);
 bool x86_is_v8086(CPUState *cpu);
 bool x86_is_long_mode(CPUState *cpu);
+bool x86_is_la57(CPUState *cpu);
 bool x86_is_long64_mode(CPUState *cpu);
 bool x86_is_paging_mode(CPUState *cpu);
 bool x86_is_pae_enabled(CPUState *cpu);
diff --git a/target/i386/emulate/x86_helpers.c b/target/i386/emulate/x86_helpers.c
index 0700cc05ef..7bdd7e4c2a 100644
--- a/target/i386/emulate/x86_helpers.c
+++ b/target/i386/emulate/x86_helpers.c
@@ -236,6 +236,14 @@ bool x86_is_long_mode(CPUState *cpu)
     return ((efer & lme_lma) == lme_lma);
 }
 
+bool x86_is_la57(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t is_la57 = env->cr[4] & CR4_LA57_MASK;
+    return is_la57;
+}
+
 bool x86_is_long64_mode(CPUState *cpu)
 {
     error_report("unimplemented: is_long64_mode()");
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index b82a55a3da..35987a897a 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,6 +56,9 @@ static int gpt_top_level(CPUState *cpu, bool pae)
         return 2;
     }
     if (x86_is_long_mode(cpu)) {
+        if (x86_is_la57(cpu)) {
+            return 5;
+        }
         return 4;
     }
 
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 2fa210ff60..e98f480f41 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -138,6 +138,11 @@ bool x86_is_long_mode(CPUState *cpu)
     return rvmcs(cpu->accel->fd, VMCS_GUEST_IA32_EFER) & MSR_EFER_LMA;
 }
 
+bool x86_is_la57(CPUState *cpu)
+{
+    return false;
+}
+
 bool x86_is_long64_mode(CPUState *cpu)
 {
     struct vmx_segment desc;
-- 
2.50.1 (Apple Git-155)


