Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DC5FF8869
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLOM-0008RI-AO; Mon, 27 Apr 2026 08:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNq-00086D-NN
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNk-0005g9-Gv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483487335c2so99993805e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294090; x=1777898890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Ad8L4DaKuABGGpSrYonhMaeLrwN0x/B0x2CwuHI6n8=;
 b=ZKGycC0+UiKiT5WGZ5nOcnZ2kxt0h0zV6eppkYmi5VFRCKy/iOxoLMKkLM64vxY8mW
 cC6ryXRs+rca3CJEUUkALSzLFM8jQC/ac64G8yvxfTaD8Bwxsosj5S+55Hyc+r1WNxVH
 qQODasctDGPEDv0owWIjarGtj70iVmGMczH/qQsSaxhTbyx8bNRWntG5sGMbG70WjUec
 50d2Ks5j6QQV3jHniu+tHkuw4HEW8yur4bvB3rjXReybizPweTOGgPTDON4vOYuPaDra
 T3N+PIs7gOUdK9Z6fBWoo9F6UpFE5gzpEBaY0IGcUnN2NnOuAJ95MODUivDALb0Ji2iM
 Tfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294090; x=1777898890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Ad8L4DaKuABGGpSrYonhMaeLrwN0x/B0x2CwuHI6n8=;
 b=ceaZhvBJQi/oDJeCs7rHGyT6d0NKxpgymCXn5Wo+47RUUIzgP00BK6S60JEs5QQ4oz
 PAgobc7yc5R/JiemjfgH0+c1RZ6eVCr31EP31rMmK3F46Do9eNRSinBldL4e0arFtq2/
 AOHJMWWa3xtVXkIv2wi3K4uwqBx0u0pB2Zj0Yabj5UMKJHOzQvUJJO/p4miVvLBXmgb5
 LTnXmWPC9DnXcCtgBGKTor7cg31+a79uftE7qBmt5hdoBuvMrcecdE82X7lhnQVQ9U+U
 P9tQXQGYWuoLGA2PMQ17GGI4vmLqd7T49+c3RQeuxdO2dtO+9BgU5WiGwlyztfKmU0i/
 FmaQ==
X-Gm-Message-State: AOJu0YxOUf/PqYWsN0f2OnuK8Hk6vIUCkhrv5QqSmx1EB9L/Vue2cYc3
 7BRoSiBIZQ5Of1FXBSFhzSxOri0DasW+KbKUtw9MUT7itgRbB9o0nv/6Q1I0ABFSG/zG/kUs3LK
 lrgmy
X-Gm-Gg: AeBDietTs39YykfPSyeJke4Ug0MGkdRDEjWBo4n+zs+EJfKKkv+6AckPWaS1vGNFLWI
 MjpWKWYlYDSG3fRkQksRecpSOfvzAa0lfB7bUVoP8bD9Ax+PYFnyvrfPWmxusanUpAukSJzvUNB
 LVRUTvq5kem7sDCkfWeCZ/Pmo9ZgejMUCdc881sCQFvIC8EB8V3wvhOnmI/7wnvwgx2CsCR1bUi
 ux4AXGCzGG9lnyJP/WLCgVdZWV3gI9FTr6VJrpLSKT/NDK4ftxpG2nVFKHveVh6mexG38WKtUcD
 QK43usLbn+vd0jDjMXM6dfK9Rqv8mi1qlwhnpGtSYps/bMZGCW8OYjIBpmKT5KbbkARsz6pNs2T
 E5FrPB07bQCwpDTvPmf3RYFFmqm1qqMkLb30In1oVaYJxWktxARMsPQOMdaPTpvboGXPlgQkWx3
 eRk9reMdH00cfrUeJ1F2zoXuz+ykKOWAA40CIU+SLw9FNUncizEuXTcSVjV2mXeZtAChjGVO/8m
 PUTlTPg5uG/RzSq7EoBrpDii0oWaPWfMmu25kyh4Q==
X-Received: by 2002:a05:600c:2e56:b0:488:d243:8da9 with SMTP id
 5b1f17b1804b1-488fb73b2d3mr370322475e9.1.1777294090074; 
 Mon, 27 Apr 2026 05:48:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/63] target/arm/machine: Handle ToleranceOnlySrcTestValue
 migration tolerance
Date: Mon, 27 Apr 2026 13:47:07 +0100
Message-ID: <20260427124738.966578-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Pass the value of the incoming register to
handle_cpreg_only_in_incoming_stream and check whether there is
a matching ToleranceOnlySrcTestValue tolerance.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260420140552.104369-4-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/machine.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index b2bf129334..8dc766d322 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1079,12 +1079,15 @@ static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
  * no cpreg mig tolerance is matched for this @kvmidx
  * Return true if the migration should eventually fail
  */
-static bool handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
+static bool
+handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx, uint64_t value)
 {
     g_autofree gchar *name = print_register_name(kvmidx);
 
     if (arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
-                                          0, 0, ToleranceNotOnBothEnds)) {
+                                          0, 0, ToleranceNotOnBothEnds) ||
+        arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
+                                          value, 0, ToleranceOnlySrcTestValue)) {
         trace_tolerate_cpreg_only_in_incoming_stream(name);
         return false;
     }
@@ -1137,7 +1140,9 @@ static int cpu_post_load(void *opaque, int version_id)
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
             fail = handle_cpreg_only_in_incoming_stream(cpu,
-                                                        cpu->cpreg_vmstate_indexes[v++]);
+                                                        cpu->cpreg_vmstate_indexes[v],
+                                                        cpu->cpreg_vmstate_values[v]);
+            v++;
             continue;
         }
         /* matching register, copy the value over */
@@ -1160,7 +1165,8 @@ static int cpu_post_load(void *opaque, int version_id)
      */
     for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
         fail = handle_cpreg_only_in_incoming_stream(cpu,
-                                                    cpu->cpreg_vmstate_indexes[v]);
+                                                    cpu->cpreg_vmstate_indexes[v],
+                                                    cpu->cpreg_vmstate_values[v]);
     }
     if (fail) {
         return -1;
-- 
2.43.0


