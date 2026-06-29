Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23844C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we74q-0001PJ-0K; Mon, 29 Jun 2026 04:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1we74m-0001P4-PY; Mon, 29 Jun 2026 04:10:45 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1we74j-0003oh-H7; Mon, 29 Jun 2026 04:10:44 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65T8A8FN080280
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 29 Jun 2026 17:10:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=45A0yc7fdzoVpIaOAtzzsDwOKquOmy46iehdiNNBXeY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1782720620; v=1;
 b=Bj/+ZD8QdgUvVlbQiSYUC1wPU5wF5e3gCYPMZVx/KEcsUzoiLI2SRnC3RFxpuPBR
 E5iOlUqpWlTErxiJeJEykckol8a+j08F0Iwmgvug+Pvsi09Q5CSB+H9No25aVI34
 VoNSZ7VFd0nZOCzfHE8A/Bg9yzMhphabUGan5R617HUemj+hEESZfIveM2KeCZHk
 8ugI5Lo0fGOkWAkioaQIT+cU+rC024T9F8O6/7TZPNTyqg1aFR54AmTxWUtWj7D4
 gXWxSs4HQYhhetpm91EXfiZK8Og8zBhqgTlWbo5JxZHRggsm4rtWclbfaZ1Dr42z
 wlf12BKpJSXYt97KXhuPMg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 29 Jun 2026 17:10:06 +0900
Subject: [PATCH v7] target/arm: Always add pmu property for host and max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pmu-v7-1-939518c349be@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23My27CMBCF4VdBXteWPb5NuuI9Kha+BdyKOEogI
 kJ59xqiilbp8ozm++9kTENOI3nf3cmQpjzm0tVh33YknFx3TDTHuglwUNxAQ/vzlbqoW2MTBB0
 5qZ/9kNp8e1Y+DnWf8ngpw/yMTuJx/esnQTm1YBoB0iM6tY9u7vKNhXImj8AEL2SFWRFU1Mokk
 /IQZdQbJP9BsiIMNgjU6ADsBqlfCPiKVEXgwAO2xnNsN0j/IM0FVyvSVFCfmoDW2mDRbJB5IS3
 FikxF4L0JCOhikvthPLKQWWZXeilfc2EusM+eHJZl+QYzfaZhrAEAAA==
X-Change-ID: 20240629-pmu-ad5f67e2c5d0
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3881;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=NOddyoW1QSFprsadGPfRc4eDcTb4qMBeBLKW310x0/A=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5aTRrbu9kd61/XYdxjNilDIlmgpfTEp5c3FKvWX/lrbn
 SLqORI7SlkYxLgYZMUUWVKKdnNrRNd+KkyIb4GZw8oEMoSBi1MAJuK7h5HhEZvqG9vWKWkar6sl
 P3t3c7zjqDScdZhBPWRR6PT9N6/bM/z3MbBda37myMkIxSvcb+fxCUVyL5RhdV1eMGun/r6Os1O
 YAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

kvm-steal-time and sve properties are added for KVM even if the
corresponding features are not available. Always add pmu property for
"host" and "max".

Note that we still don't add the property for other CPUs that lack PMU.
This is because we do not know what a PMU version should be enabled
when the user sets the property to true while it is defined as an error
for the "host" or "max" CPU when the hardware accelerator is enabled and
the host doesn't have a PMU.

This fixes qtest-aarch64/arm-cpu-features on the hosts that supports
KVM but doesn't support PMU emulation.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v7:
- Reject pmu=on for "host" when PMU is unavailable.
- Handle "max" too, since it maps to "host" with hwaccel.
- Link to v6: https://lore.kernel.org/qemu-devel/20250531-pmu-v6-1-2bb6c828ade3@rsg.ci.i.u-tokyo.ac.jp

Changes in v6:
- Limited the scope of the change to the "host" CPU.
- Link to v5: https://lore.kernel.org/r/20250104-pmu-v5-1-be9c8777c786@daynix.com

Changes in v5:
- Rebased.
- Link to v4: https://lore.kernel.org/r/20240720-pmu-v4-0-2a2b28f6b08f@daynix.com

Changes in v4:
- Split patch "target/arm/kvm: Fix PMU feature bit early" into
  "target/arm/kvm: Set PMU for host only when available" and
  "target/arm/kvm: Do not silently remove PMU".
- Changed to define PMU also for Armv7.
- Changed not to define PMU for M.
- Extracted patch "hvf: arm: Raise an exception for sysreg by default"
  from "hvf: arm: Properly disable PMU".
- Rebased.
- Link to v3: https://lore.kernel.org/r/20240716-pmu-v3-0-8c7c1858a227@daynix.com

Changes in v3:
- Dropped patch "target/arm: Do not allow setting 'pmu' for hvf".
- Dropped patch "target/arm: Allow setting 'pmu' only for host and max".
- Dropped patch "target/arm/kvm: Report PMU unavailability".
- Added patch "target/arm/kvm: Fix PMU feature bit early".
- Added patch "hvf: arm: Do not advance PC when raising an exception".
- Added patch "hvf: arm: Properly disable PMU".
- Changed to check for Armv8 before adding PMU property.
- Link to v2: https://lore.kernel.org/r/20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com

Changes in v2:
- Restricted writes to 'pmu' to host and max.
- Prohibited writes to 'pmu' for hvf.
- Link to v1: https://lore.kernel.org/r/20240629-pmu-v1-0-7269123b88a4@daynix.com
---
 target/arm/cpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 86aae36ae552..4a4bed525359 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1345,11 +1345,11 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    if (value) {
-        set_feature(&cpu->env, ARM_FEATURE_PMU);
-    } else {
-        unset_feature(&cpu->env, ARM_FEATURE_PMU);
+    if (value && !arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
+        error_setg(errp, "'pmu' feature is not supported");
+        return;
     }
+
     cpu->has_pmu = value;
 }
 
@@ -1529,6 +1529,7 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
 static void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    ARMCPUClass *acc = ARM_CPU_GET_CLASS(obj);
 
     /*
      * Some features imply others. Figure this out now, because we
@@ -1585,6 +1586,10 @@ static void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
+    }
+
+    if (cpu->has_pmu || !strcmp(acc->info->name, "host") ||
+        !strcmp(acc->info->name, "max")) {
         object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
 

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20240629-pmu-ad5f67e2c5d0

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


