Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0866CC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY6O-0004Ld-O8; Tue, 13 Oct 2026 04:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY42-00007K-JJ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3x-00082G-PO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so22524985e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880844; x=1792485644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fxZZyr5tqmX4RAAPXJIUMSNXuOO4bc4vIMg/smsoxD4=;
 b=TdxZ0gDjRFf0lUI9QzAAm6nmCCZdjR+L9T1QqPNDOh6M+Izlkx92H8w361Q6KmvG51
 fx0dnYG9bzDO/SiByauG9MbT8ArMW8BdmlSkRbq97fZVrUoltKdggwe+I8WupBI8VeNC
 L1iLqLFSX+qJ6YyM6sHz7O5PZfPYv/D/f0G7+ccTHDW+2Z4wCCxP/wQNYpKiq+j9LGwe
 fo9r3WgW05IhRxQi0g0/EI32jPoTGURLl8LRqJpQ3x7powNYTpK4PY7xyj87xqbSmIcK
 RtEBF86TD7Q8n2IbHSB00wqDZyX+B579mt5BWgnhMOwbxR1YOfLxHZEM0fw9ujdq2gwR
 X+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880844; x=1792485644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fxZZyr5tqmX4RAAPXJIUMSNXuOO4bc4vIMg/smsoxD4=;
 b=qpXqMD/7TyDOkbgz/feotZ3Ik7wqPCTDu5Fp/BfxCKTBUwUcu1mTTc7Pe2xSLNKoEV
 YEUJt06e6avhbS5snfh4W9Qnz/7MG5+wo6rKZlkbPrbIyaA4ejhJcgTygnh5Tde6jLuc
 uku8Imu35EXeX81BFuuY+j9mrkb0pI/5POO273HXosiUeVTDYAjjZape61zMSoIK5JgH
 N2psocKtICVO9FnDkaUF3qQ9YIG1YyJFiLmuKDOloPuNwUo6DI89YXM9hLZEBE+wiQI6
 AxoMECgymjD7GIU6gSeL1ZFQSGcbRNrI1wH5/yGFD6rdNcv82O6vkRr3eOdZUypt6FDT
 nU2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc9078Ij0+0E0m4oejsNbS25Wv/Gb3Y4iJvS126eYvGdPetvfrbV7zCTtDjHBdsAGukhWZ1GO2j6Lq@nongnu.org
X-Gm-Message-State: AFq9FYLEyeW/B5TpBTciJl8VvT18w/HhgJ2x+spoM+QQXEn2D8Z2uSQ4
 SU7SFaN1MbYuEE7fSeUJfCVtqrIoASy3/fTBY9Tqk1Pz/GwbF/8293gceg4TdCErCaw=
X-Gm-Gg: AYBFou0tvesLppovS0jHTKLK/eFAkBv1SyILshEu10RB+PbJLHpGMLhZlPR1/XyvlL2
 Lo1O9OYF+X+ebHYErYJZQrG/gPD872cAF8uNrxJKY4WIFjhWlBIEeeAn+PXalj1fVjvrfmRt98O
 VE2DaaosSjVPrfQtrxDNvlKwY52i4eXtIggPxqO58Yye3Fu0xUhBzJhIrsVu2snjKc56ajoNWxG
 TqN7kGjaoJSGSioyrxzAW74nO2nyykuI1Ai0AKtSGDgsbzgUz1CxQVD+q/f12Pn6Dz01kTsPrYN
 eIJBmL8wbhM807kqup3X7sIlbHpFay85OpsAcFGrCeae8CKigWuqaLKf9ITfqTNLLMaX5/6gzKw
 usWGmslCOiP3EzdiYXgAcPpH6zvZvxiON61JUfSQxmZf3oGCK6TXS1T/NN9+6+Wy9ob8+QoNOGe
 AAi1IyTuql9yBrMRmsu3sZPWtF78sHUl+3TbiLEXhPtLiFKX7kNMSKrKolqUn2CGwnk5N+A7ze5
 e5qNhcq6NsJhmfyl7vr2ktSS+C6XJuuxt4DhZWnwCTdAcM2BtYqpCkXlwgRYV6t1Zml1JnLpdVh
 4/pOLOwJk0w90g==
X-Received: by 2002:a05:600c:190a:b0:4a1:746e:589a with SMTP id
 5b1f17b1804b1-4a18e4aea54mr253139185e9.18.1791880843998; 
 Tue, 13 Oct 2026 01:40:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 51/86] hw/intc/arm_gicv5: Ask CPUs whether IRS needs
 virtualization support
Date: Tue, 13 Oct 2026 09:38:58 +0100
Message-ID: <20261013083933.1024405-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The GICv5 IRS must support virtualization if any CPU in the system
has EL2 (by spec rule R_KDSPG).  Add a has_virt field to the
GICv5Common struct to track this, and automatically set it if any
connected CPU has EL2.

We get the CPU to tell us whether it needs virtualization in the
return value of gicv5_set_gicv5state(); this allows us to maintain
the arm's-length relationship between the IRS and the CPU (and in
particular we don't need to include cpu.h in arm_gicv5_common.c, as
we would if we directly called arm_feature() there).

We could alternatively have provided a has-virtualization QOM
property, but then the board code would need to take care to
explicitly configure the IRS to match the CPUs.

(The GICv3 doesn't have an equivalent to this, because in the GICv3
design virtualization is handled entirely by the CPU interface and
software; in GICv5 the IRS has hardware support, to reduce the work
software needs to do.)

None of the code we are about to add in future commits that tests the
has_virt flag will be accessible until we remove the check in virt.c
that prevents creation of a machine with the GICv5 and an EL2 CPU, so
no behaviour will change until we have completed the entire
virtualization support feature and allow the user to select it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5_common.c         |  9 ++++++++-
 include/hw/intc/arm_gicv5_common.h |  2 ++
 include/hw/intc/arm_gicv5_stream.h | 15 +++++++++++----
 target/arm/cpu.c                   | 17 +++++++++++------
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index cfadfee4f05..17fd67b5ccd 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -176,11 +176,18 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
     }
 
     for (int i = 0; i < cs->num_cpus; i++) {
-        if (!gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i], i)) {
+        switch (gicv5_set_gicv5state(cs->cpus[i], cs, cs->cpu_iaffids[i], i)) {
+        case GICV5_CPUIF_MISSING:
             error_setg(errp,
                        "CPU %d (IAFFID 0x%x) does not implement GICv5 CPU interface",
                        i, cs->cpu_iaffids[i]);
             return;
+        case GICV5_CPUIF_PRESENT:
+            break;
+        case GICV5_CPUIF_NEEDS_VIRT:
+            /* R_KDSPG: IRS must implement virtualization if any CPU has EL2 */
+            cs->has_virt = true;
+            break;
         }
     }
 
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index a47f639e84c..d8f6f5d5db9 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -127,6 +127,8 @@ struct GICv5Common {
     uint32_t spi_base;
     uint32_t spi_irs_range;
     uint32_t spi_range;
+
+    bool has_virt;
 };
 
 struct GICv5CommonClass {
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index f6d32c6beca..ea27d6aec0f 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -16,6 +16,12 @@
 
 typedef struct GICv5Common GICv5Common;
 
+typedef enum GICv5CPUIFStatus {
+    GICV5_CPUIF_MISSING, /* CPU does not have GICv5 cpuif support */
+    GICV5_CPUIF_PRESENT, /* CPU has GICv5 cpuif */
+    GICV5_CPUIF_NEEDS_VIRT, /* CPU has GICv5, and needs virt support in IRS */
+} GICv5CPUIFStatus;
+
 /**
  * gicv5_set_gicv5state
  * @cpu: CPU object to tell about its IRS
@@ -27,11 +33,12 @@ typedef struct GICv5Common GICv5Common;
  * IRS must call this when it is realized, for each CPU it is
  * connected to.
  *
- * Returns true on success, false if the CPU doesn't implement the
- * GICv5 CPU interface.
+ * The return value indicates whether the CPU has a GICv5 CPU
+ * interface, and if it does whether it needs virtualization support
+ * from the IRS.
  */
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid,
-                          uint32_t cpuidx);
+GICv5CPUIFStatus gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs,
+                                      uint32_t iaffid, uint32_t cpuidx);
 
 /*
  * The architected Stream Protocol is asynchronous; commands can be
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4731d1cc7c4..62262d742a2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1215,20 +1215,25 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 }
 
 #ifndef CONFIG_USER_ONLY
-bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs, uint32_t iaffid,
-                          uint32_t cpuidx)
+GICv5CPUIFStatus gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs,
+                                      uint32_t iaffid, uint32_t cpuidx)
 {
     /*
-     * Set this CPU's gicv5state pointer to point to the GIC that we are
-     * connected to, and record our IAFFID and CPU index.
+     * Set this CPU's gicv5state pointer to point to the GIC that we
+     * are connected to, record our IAFFID and cpuidx, and let the IRS
+     * know if it needs to implement virtualization support.
      */
     if (!cpu_isar_feature(aa64_gcie, cpu)) {
-        return false;
+        return GICV5_CPUIF_MISSING;
     }
     cpu->env.gicv5.gicv5state = cs;
     cpu->env.gicv5.iaffid = iaffid;
     cpu->env.gicv5.cpuidx = cpuidx;
-    return true;
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
+        return GICV5_CPUIF_NEEDS_VIRT;
+    } else {
+        return GICV5_CPUIF_PRESENT;
+    }
 }
 #endif
 
-- 
2.43.0


