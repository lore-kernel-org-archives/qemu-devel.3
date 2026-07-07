Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E040EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEW1-0001Qh-6r; Tue, 07 Jul 2026 18:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVy-0001OE-6M
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVw-0004By-CO
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cac59f8b64so1080825ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464219; x=1784069019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIviMsn5Rq1UtJcdpFZj4ZD1p4JzYpgAt1W5TU8JGlc=;
 b=h8XWKvN47fchmZVvZgLbJR/Cu3KWA8d9WpUTt1P15kZrxtnjFW67KTMj/tZpoWhV9P
 wUt+qAHSD5giKlSPO/y4Y4/WEJ8RjEsyUBbug3yzrQ5qvM2Y+3hJ30iIHwWkLZ0Y1rBa
 bEwMpWqEdpj5ZxlvWh9UGmmxIynLV3UlzQqrsgGUXMOP8PzzsWEiCZSPNS+MHlHjR2Tz
 /hk+oSKpsXRhZSFVon/eMOwXL5Ye3cMh/CCgDmj9pr5TEds3xUE2HRSecPnLeyR3HuDu
 qg4FvlYHmXgKZGh3J9cCh2c9gbJ02Xi879Sz0M7meBTIwbsVdu38ZRJzuIUu8g6tazd7
 yqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464219; x=1784069019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oIviMsn5Rq1UtJcdpFZj4ZD1p4JzYpgAt1W5TU8JGlc=;
 b=rEQo3eH89HxJW3dFdrjvE97fbn0FzzXPHmbB/F+hQp2eKNnehs8LN6WfNfM9W2tYj1
 kIlYJlKGVIZ3AzyoAcQ1pJtBV+jV75jFbIfmIc13KIyCXtvCcxYOmX9oP+ra9GkHetee
 7lxXxgpDyaqxD8mRFjBGntKEx072ZPWE7TsCmP61a5DdWuO4UENbXQIjj8qTZsB12aGC
 TRSH+u5LWEN9/R11An705r/jVFZSPzuIZue6MpCJJ0+7l1ZZ5QxL8fqB2tT4RC3weywW
 Em06AujWifGrfuFqWG6P8PdjYp6hpagnIVLhhQloM8Zy1r0ZeVQjcGU+bNjFGlA+CDe6
 5iXQ==
X-Gm-Message-State: AOJu0YyO+fcu8hISySw23hUFeay5EhMtn4uUSX2SPZHsS/IZqq6dzro1
 6Qq13DevHDiPrdArucBNoy6JusWkMjleDGM0q/fJeWGYzf+5gNO9Qbvpk3xjSCRMo+I=
X-Gm-Gg: AfdE7clFxSv8P+IqSSt/4pXYF8Dw0qAEqYZfNsMDysjfsOXqcS8jw1FDa6CrixFihpZ
 ydNiiBMxiEsYr/LFreNupwmRxZ7Z2RfnfsltvKDd20JW/fyQM6UQBu4Lm3BRt1oC/wEZatdNWOy
 GAIB0dw/9x7DSaJ1hChK+fuRRn3dNCje0BMSxZ5E4XWvZyn3+wOsiA8ZzDxHT9F0K5rA6egwtrk
 l6RQ3tDicXETEjrXdLtURn1nprZfWqRYcobF2dux6T6QtMg62Pv2M/h0oIiFwyO07yx+r5Jpy23
 KBPTcNXR26k+DMqBY7Yn9smQLh0XpdpfhCiEmElLUs5MGztQX+AfjLSEcWJDiqgcgVO4SRfpPhB
 4IparmubQJCFW/mIFw4rc0AzETQM2DKXVLFrmRaz4TLhYezb2tZEBy6iw7WbLNUoxSElVQ57VE7
 43ON3tcjY5cdY0fADumRO3/NBWeOhtGURgbw/HgFA=
X-Received: by 2002:a17:903:285:b0:2ca:f16c:87b3 with SMTP id
 d9443c01a7336-2ccbe62863cmr63699725ad.19.1783464219016; 
 Tue, 07 Jul 2026 15:43:39 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:38 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 14/25] target/arm/cpu: Set number of PMU counters in KVM
Date: Tue,  7 Jul 2026 16:42:55 -0600
Message-ID: <20260707224306.1202330-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a "num-pmu-counters" CPU parameter to configure the number of
counters that KVM presents to the guest. This is needed for Realm VMs,
whose parameters include the number of PMU counters and influence the
Realm Initial Measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/arm-qmp-cmds.c |  2 +-
 target/arm/cpu.h          |  3 +++
 target/arm/cpu64.c        | 41 +++++++++++++++++++++++++++++++++++++++
 target/arm/kvm.c          | 34 ++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 9ed65eb090d7..9350dc30d12f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -76,7 +76,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
     "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
-    "num-breakpoints", "num-watchpoints",
+    "num-breakpoints", "num-watchpoints", "num-pmu-counters",
     NULL
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d6f64daec2a3..50d482b09b0d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1178,6 +1178,7 @@ struct ArchCPU {
     /* Allows to override the default configuration */
     uint8_t num_bps;
     uint8_t num_wps;
+    int8_t num_pmu_ctrs;
 };
 
 typedef struct ARMCPUInfo {
@@ -2134,6 +2135,8 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
+FIELD(PMCR, N, 11, 5)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3f12009befa8..00b3511dcbc3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -737,12 +737,53 @@ static void arm_cpu_set_num_bps(Object *obj, Visitor *v, const char *name,
     cpu->num_bps = val;
 }
 
+static void arm_cpu_get_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        val = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+    } else {
+        val = cpu->num_pmu_ctrs;
+    }
+
+    visit_type_uint8(v, name, &val, errp);
+}
+
+static void arm_cpu_set_num_pmu_ctrs(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    uint8_t val;
+    ARMCPU *cpu = ARM_CPU(obj);
+    uint8_t max_ctrs = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
+
+    if (!visit_type_uint8(v, name, &val, errp)) {
+        return;
+    }
+
+    if (val > max_ctrs) {
+        error_setg(errp, "invalid number of PMU counters");
+        return;
+    }
+
+    cpu->num_pmu_ctrs = val;
+}
+
 static void aarch64_add_kvm_writable_properties(Object *obj)
 {
+    ARMCPU *cpu = ARM_CPU(obj);
+
     object_property_add(obj, "num-breakpoints", "uint8", arm_cpu_get_num_bps,
                         arm_cpu_set_num_bps, NULL, NULL);
     object_property_add(obj, "num-watchpoints", "uint8", arm_cpu_get_num_wps,
                         arm_cpu_set_num_wps, NULL, NULL);
+
+    cpu->num_pmu_ctrs = -1;
+    object_property_add(obj, "num-pmu-counters", "uint8",
+                        arm_cpu_get_num_pmu_ctrs, arm_cpu_set_num_pmu_ctrs,
+                        NULL, NULL);
 }
 #endif /* CONFIG_KVM */
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e4b4d5450c70..3d5e16a21cf5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -949,9 +949,43 @@ static void kvm_arm_configure_aa64dfr0(ARMCPU *cpu)
     }
 }
 
+#define KVM_REG_ARM_PMCR_EL0            ARM64_SYS_REG(3, 3, 9, 12, 0)
+
+static void kvm_arm_configure_pmcr(ARMCPU *cpu)
+{
+    int ret;
+    uint64_t val, newval;
+    CPUState *cs = CPU(cpu);
+
+    if (cpu->num_pmu_ctrs == -1) {
+        return;
+    }
+
+    newval = FIELD_DP64(cpu->isar.reset_pmcr_el0, PMCR, N, cpu->num_pmu_ctrs);
+    ret = kvm_set_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &newval);
+    if (ret) {
+        error_report("Failed to set KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    /*
+     * Check if the write succeeded, since older versions of KVM ignore it.
+     */
+    ret = kvm_get_one_reg(cs, KVM_REG_ARM_PMCR_EL0, &val);
+    if (ret) {
+        error_report("Failed to get KVM_REG_ARM_PMCR_EL0");
+        return;
+    }
+
+    if (val != newval) {
+        error_report("Failed to update KVM_REG_ARM_PMCR_EL0");
+    }
+}
+
 static void kvm_arm_configure_vcpu_regs(ARMCPU *cpu)
 {
     kvm_arm_configure_aa64dfr0(cpu);
+    kvm_arm_configure_pmcr(cpu);
 }
 
 /**
-- 
2.43.0


