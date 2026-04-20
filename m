Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A8F5580B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6T-0007An-7Q; Mon, 20 Apr 2026 06:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6Q-00079Z-KB
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:42 -0400
Received: from p-west3-cluster6-host4-snip4-10.eps.apple.com ([57.103.75.23]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6O-0000dj-RV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:42 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 66B97180045A; Mon, 20 Apr 2026 10:43:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681818; x=1779273818;
 bh=6dRDJ5VEmS78xsRk6kMHBpp9Wu7kQoHjBWY816Egd9Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZiqMaEhERnaCG8BBDaSaBRanydfmEXgOfWTwKXKrYtbhDEoGSzDKpRIjO36TBOG5pPHEJeBws2HhjHjt+uIQQ+pAV6bNFTTP0G1sa3Aw2X1lKur9SFJhx1mfJwSj4RXmi7dZlZDHg9d3/0lTKo686wTVdA7Ml8MjnoPxADNYBbax5A8GyIIVYxMdVwlzQaA3IzKoOsS+035LImh1rQF9R3jNUjUVL0wrv07aTcrMCFeOu/iI/I+HDRqtF0iHkoHNWEoBiPYIEcPYu5AFKrXK1aIAciK1z6M5ialSCxJ3lU5wrt0UbLWHkUX3qAIVHZfCcglFyIUMB/yYgQCuGzb1QQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 D21F21800478; Mon, 20 Apr 2026 10:43:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 17/38] whpx: i386: unknown MSR configurability
Date: Mon, 20 Apr 2026 12:42:27 +0200
Message-ID: <20260420104248.86702-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PDCmDiPyhYelfMhsgCs4mxLsG49E4L6c
X-Authority-Info-Out: v=2.4 cv=DOGCIiNb c=1 sm=1 tr=0 ts=69e60359
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9z_AL-2ZILZrMqfKHsQA:9
X-Proofpoint-ORIG-GUID: PDCmDiPyhYelfMhsgCs4mxLsG49E4L6c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX9Zq935l7r8mP
 vlaUDFA3GpOv4YI3ojqIp7m3nXUhBecmS38s/+K7J9Cd6QT6Es5ZaRdSsYFWtn4dQKBsUmfUQcx
 N0G4e7MnRvx2W9Zd3L7VHfMzO3o0NHiRcYo+BVtZxvUpCESjNi+79HBuFai56uMpvflSx1BtYy7
 GAqp523lUjnBh3twSWTbsBAnZzZFaf5amr8xtgkUhKbVIy9MhwH4f0lSgExvHj4zqgp6fBwNyvK
 2RAmkN/sYGD0xd01mtV4lx92WKr0Ip6b6UsngLF7DV9wdG0k4Z0m16XFbgY30iZAPJVJwKgMgVt
 iRpQ+U+M45w73RK6+PWHifpZLCguFPukGyvcZvfu8+tmQKdUaXRJRcMTlk8T1g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.75.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an option to inject back a GPF for unknown MSRs.

Keep it on by default for now as Linux expects accesses to some
AMD-specific MSRs to always succeed when on an AMD host.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       | 38 ++++++++++++++++++++++++++++++++++
 include/system/whpx-internal.h |  1 +
 target/i386/whpx/whpx-all.c    |  4 ++++
 3 files changed, 43 insertions(+)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 59be996aef..706871f138 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -505,6 +505,38 @@ static void whpx_set_hyperv(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_unknown_msr(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        whpx->ignore_unknown_msr = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->ignore_unknown_msr = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->ignore_unknown_msr = true;
+        break;
+    default:
+        /*
+         * The value was checked in visit_type_OnOffAuto() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
 static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
@@ -538,6 +570,11 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "hyperv",
         "Configure Hyper-V enlightenments");
+    object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto",
+        NULL, whpx_set_unknown_msr,
+        NULL, NULL);
+    object_class_property_set_description(oc, "ignore-unknown-msr",
+        "Configure unknown MSR behavior");
 }
 
 static void whpx_accel_instance_init(Object *obj)
@@ -552,6 +589,7 @@ static void whpx_accel_instance_init(Object *obj)
     whpx->hyperv_enlightenments_required = false;
     /* Value determined at whpx_accel_init */
     whpx->hyperv_enlightenments_enabled = false;
+    whpx->ignore_unknown_msr = true;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index cf782cf5f8..86639627b3 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -47,6 +47,7 @@ struct whpx_state {
     bool hyperv_enlightenments_required;
     bool hyperv_enlightenments_enabled;
 
+    bool ignore_unknown_msr;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0d72e93621..550f30d50a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2048,6 +2048,10 @@ int whpx_vcpu_run(CPUState *cpu)
                     vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
             }
 
+            if (!is_known_msr && !whpx->ignore_unknown_msr) {
+                x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+            }
+
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
                 cpu->cpu_index,
-- 
2.50.1 (Apple Git-155)


