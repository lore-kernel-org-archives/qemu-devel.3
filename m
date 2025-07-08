Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA74EC83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG4W-0008IJ-HV; Tue, 08 Jul 2025 17:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZEx2-0004cB-03
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:30:07 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZEwz-00088G-4q
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:30:03 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-32f3ef6178bso7181571fa.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752006599; x=1752611399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gt2m6Pn6JVQPqk/mSrP0CK0ENC9R9D3MSBFUWpA9k1g=;
 b=S8e6WaRg1WL26cSSAy/oe3L7anUfVUtEWGXPd0/PuSk2zLfQQM2SmcMkLcBVuMSuQR
 LbEvvOeJZ4ZZDlsIeKfRFCnmt1Fm1GykTZOZidIzkR1gQ63IcPV5LQpOW1+4n6+XxQjf
 eisPi/M9fdymjrBwEhqD5k9cSJlZcjyB/yC0OovOJrwPSGls8Xy+u6yVuDDc7x+VdLQ+
 P05dRh33hOXGsW3JQWBoPYQT9pLy6A7jP4sTIOZKdmOsDyOqB/RdqAAJHNN6iuNGE1gl
 qqsKw3ypsA+aIiST+hsvV82bebp7dtCkjKdZLi8OTeKqpjQioiuWaTSdA1cJlSQT/yYT
 QOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752006599; x=1752611399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gt2m6Pn6JVQPqk/mSrP0CK0ENC9R9D3MSBFUWpA9k1g=;
 b=GpeXlt0Rh1VeoEOzIIc6hWgfjigoDewLByx1yPcmxkgFqHLModUzG/WSJWd1BTi5Cc
 kjtvhT1Xmpy/CIgX8qFcMYlac322y0kNRQlO4+76g/dPypja6VP7ijjuuZ5soyvtH0UB
 IqMilgg4QJKRDl/jcbik4fXwDAR9548eDZtc8sRme9UpW9V+NrmQ2kBae/QeFMYBEQO5
 rmB4Ef9d948/vLGyvz6SSgRlnyKtoZr+0ue3rYwCr5alImpN5SBs5dxhNf28FRCZ+CbW
 ck8Y46OqKk93qtXWcr0N7Hr9pMo1FRWIXWzEh7cvX85NL/A/1IodV16S6e+o6/R9SBND
 6qmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDv0nCuHG62vccev9OuAnBfUu3yOYBpuXn7SniSzHzwoakMRFiW3a5djj0fGpLLFcnvsm6u7292xho@nongnu.org
X-Gm-Message-State: AOJu0Yy+r1K9roD/9zFwsG5r/HKgTdk9okeLSEdveeGJpmjXDrm7S/N/
 WBadEQFIuGGrP5CRwMCjHyqonS6RVojiNo0tsdsUpDTeJGgYvhQhd8FQkQTx8o5pjWshLncwqL3
 kA1oC
X-Gm-Gg: ASbGncsrMZ2OB+d9f7GtOYauHoWIkpQTzD3MIRX84TfHxsOwCmBKPbi3AvdjxctuJlv
 qqBUL+l7XsIvHy/sq0N7RUoWjNnXF57OQB+XiGp+vIl7sD1QGjMgAAmukj2gJwN/53oUbLtacQ4
 iO5Hb+oNebBf7qYd9CEE3R5LjQYwHKX54mBJgybwtwvxDhAI/M1yYlJBCrNeHk+1bl+0h0+Eqa9
 vNies5JI03w169A7y1lzVaNpVCmrdt/ZcDsoLZOAh6hy+Gthe69fz49Gg94j5bS83gM2neSmfjk
 ZlEQ6FMeSGi16lxsUO0V4JnQ6bLIegzn9qm7ORZ4yslq0Ypeg2tYBKkLbBDlpya9d+n2
X-Google-Smtp-Source: AGHT+IE+L0yyX0pqFiJ3uAV6sFE1o6IeVh74gnbcE4SKwIJoSVN52SpMbF87UHOdIMUbTOSf5tVLwQ==
X-Received: by 2002:a05:6000:2209:b0:3a3:7115:5e7a with SMTP id
 ffacd0b85a97d-3b5ddebd150mr2232338f8f.42.1751975563813; 
 Tue, 08 Jul 2025 04:52:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd4a68ebsm19731255e9.39.2025.07.08.04.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:52:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 2/3] hw/intc/arm_gicv3_kvm: Migrate GICD_TYPER2
Date: Tue,  8 Jul 2025 12:52:37 +0100
Message-ID: <20250708115238.667050-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708115238.667050-1-peter.maydell@linaro.org>
References: <20250708115238.667050-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

The GICD_TYPER2 register is new for GICv4.1.  As an ID register, we
migrate it so that on the destination the kernel can check that the
destination supports the same configuration that the source system
had.  This avoids confusing behaviour if the user tries to migrate a
VM from a GICv3 system to a GICv4.1 system or vice-versa.  (In
practice the inability to migrate between different CPU types
probably already prevented this.)

Note that older kernels pre-dating GICv4.1 support in the KVM GIC
will just ignore whatever userspace writes to GICD_TYPER2, so
migration where the destination is one of those kernels won't have
this safety-check.

(The reporting of a mismatch will be a bit clunky, because this
file currently uses error_abort for all failures to write the
data to the kernel. Ideally we would fix this by making them
propagate the failure information back up to the post_load hook
return value, to cause a migration failure.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2:
 * fix comment missing bracket
 * fix reset handling so this works on GICv4.1 hosts
 * move get/put code to be with the other GICD regs
---
 include/hw/intc/arm_gicv3_common.h |  6 ++++++
 hw/intc/arm_gicv3_common.c         | 24 ++++++++++++++++++++++++
 hw/intc/arm_gicv3_kvm.c            | 25 +++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index a3d6a0e5077..bcbcae1fbe7 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -267,6 +267,12 @@ struct GICv3State {
     GICv3CPUState *gicd_irouter_target[GICV3_MAXIRQ];
     uint32_t gicd_nsacr[DIV_ROUND_UP(GICV3_MAXIRQ, 16)];
 
+    /*
+     * GICv4.1 extended ID information. This is currently only needed
+     * for migration of a KVM GIC.
+     */
+    uint32_t gicd_typer2;
+
     GICv3CPUState *cpu;
     /* List of all ITSes connected to this GIC */
     GPtrArray *itslist;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 1cee68193ca..7b09771310e 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -275,6 +275,29 @@ const VMStateDescription vmstate_gicv3_gicd_nmi = {
     }
 };
 
+static bool gicv3_typer2_needed(void *opaque)
+{
+    /*
+     * GICD_TYPER2 ID register for GICv4.1. Was RES0 for
+     * GICv3 and GICv4.0; don't migrate if zero for backwards
+     * compatibility.
+     */
+    GICv3State *cs = opaque;
+
+    return cs->gicd_typer2 != 0;
+}
+
+const VMStateDescription vmstate_gicv3_gicd_typer2 = {
+    .name = "arm_gicv3/gicd_typer2",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = gicv3_typer2_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(gicd_typer2, GICv3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gicv3 = {
     .name = "arm_gicv3",
     .version_id = 1,
@@ -304,6 +327,7 @@ static const VMStateDescription vmstate_gicv3 = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gicv3_gicd_no_migration_shift_bug,
         &vmstate_gicv3_gicd_nmi,
+        &vmstate_gicv3_gicd_typer2,
         NULL
     }
 };
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3be3bf6c28d..8e34d08b415 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -405,7 +405,16 @@ static void kvm_arm_gicv3_put(GICv3State *s)
         }
     }
 
-    /* Distributor state (shared between all CPUs */
+    /* Distributor state (shared between all CPUs) */
+
+    /*
+     * This ID register is restored so that the kernel can fail
+     * the write if the migration source is GICv4.1 but the
+     * destination is not.
+     */
+    reg = s->gicd_typer2;
+    kvm_gicd_access(s, GICD_TYPER2, &reg, true);
+
     reg = s->gicd_statusr[GICV3_NS];
     kvm_gicd_access(s, GICD_STATUSR, &reg, true);
 
@@ -572,7 +581,10 @@ static void kvm_arm_gicv3_get(GICv3State *s)
         }
     }
 
-    /* Distributor state (shared between all CPUs */
+    /* Distributor state (shared between all CPUs) */
+
+    kvm_gicd_access(s, GICD_TYPER2, &reg, false);
+    s->gicd_typer2 = reg;
 
     kvm_gicd_access(s, GICD_STATUSR, &reg, false);
     s->gicd_statusr[GICV3_NS] = reg;
@@ -707,6 +719,7 @@ static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type)
 {
     GICv3State *s = ARM_GICV3_COMMON(obj);
     KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
+    uint32_t reg;
 
     DPRINTF("Reset\n");
 
@@ -719,6 +732,14 @@ static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type)
         return;
     }
 
+    /*
+     * The reset value of the GICD_TYPER2 ID register should be whatever
+     * the kernel says it is; otherwise the attempt to put the value
+     * in kvm_arm_gicv3_put() will fail.
+     */
+    kvm_gicd_access(s, GICD_TYPER2, &reg, false);
+    s->gicd_typer2 = reg;
+
     kvm_arm_gicv3_put(s);
 }
 
-- 
2.43.0


