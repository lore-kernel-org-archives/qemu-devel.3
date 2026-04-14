Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F97BF9D0EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiPj-0006BR-7j; Tue, 14 Apr 2026 14:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPN-00065p-PP
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:45 -0400
Received: from pv-2005i-snip4-10.eps.apple.com ([57.103.66.200]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPL-0006TX-H2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:45 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPS id
 309CF18000A5; Tue, 14 Apr 2026 18:22:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776190962; x=1778782962;
 bh=H55iPnzts7qCVmoBJ9TP4r+Lt8OW7TgpBaoEUQHYL2o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VrykrCOB9H7MgObmRL9mUlzJN7CzWedoV1snUy1feQosOjODOINnHqTqAovPzLhfsDxBrqlfkAotT6G5yZEPc6zaTkQ2jY178Heb8RceEM4Y+8xnKLhL9g7COsccBw3QauJjRC2fWsXitW9u2JXwGkHMAeZYWNDHqK1r9hzNwzIAy75m/t3GZSiK1TSkWTV1pnK5+xD3vOkVXmYH+FO345HKn8B4244fJWfbBDNJdg4nsuzgdDVenCNINUkT9v3hHTuMR5SE+GKGbFDotIt8ZbYBahqUCIJyAlUVy7vNu1eLaJoX0KHe9LtLk/+bR/JovZxknBmBL4gGee1Twz3Eyw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPSA id
 3AEC218001F3; Tue, 14 Apr 2026 18:22:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/7] whpx: i386: unknown MSR configurability
Date: Tue, 14 Apr 2026 20:22:26 +0200
Message-ID: <20260414182231.18776-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260414182231.18776-1-mohamed@unpredictable.fr>
References: <20260414182231.18776-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=eurSD4pX c=1 sm=1 tr=0 ts=69de85f1
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9z_AL-2ZILZrMqfKHsQA:9
X-Proofpoint-GUID: VmnGIc_BjCs2wDpOi-EmYpdF8eXejgal
X-Proofpoint-ORIG-GUID: VmnGIc_BjCs2wDpOi-EmYpdF8eXejgal
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MiBTYWx0ZWRfX0gJf44td70Jx
 TPVztUtOgVvADpr6L1wyoS41lNj5XaqlRZGjKciqR01Ba7UIYGPtmqEOzXPpxy4+9xUB1UiMUET
 ldvWUfXEi4MIjcd8FItK2kwit4o4/FIKTLk34x5ZZNj0mWFROz1RJz5qWVsZeslXOm6rlMnNcrF
 2popnsjpvPtpUtwS30t3RikNfrcionnwKYoHM4PC5iOFUuleOiPL4gK6k/4n0lOOfKaIKl+7me7
 XkrTilOPlwQwmNzZQi05KIFF5oLalWIe2eZebiWVeP3RlcLynTkwkY2zysUb9mQtK/OCUF7uo1H
 N8gHH9leih0PcQ0scrVr2O9/NY74xQDON9OmqUfVbMOeBuU8HEv2XFiSM9BaQw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1030
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140172
Received-SPF: pass client-ip=57.103.66.200;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 56a789c5fd..b248afb5e7 100644
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


