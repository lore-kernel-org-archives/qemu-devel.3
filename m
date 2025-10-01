Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD511CCA471
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFa-0005MD-Fg; Tue, 30 Sep 2025 21:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFM-0005JH-DP
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEr-00083F-JN
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso338479f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280554; x=1759885354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o21SQbmHJ5c7GKJfo1w8RsDWnLTVYYuhCdCc7+7iYhg=;
 b=YIO9J+KrmL96QSgo3783pq/q893m/yJarvyCp7D1uMFCdy2Fd152BAvVu2TECNUtOr
 apScjBxT/JDtCQCaJUSWzdORZDvyQNQ0L5O5EiXD8s8J1guV1d0s/IS97xJ42SY5VoNJ
 K/8QT0vu75CxGkP77AWoahKwvGHBb7pFyYPAMpArYvs3Lr2w1VwxRtcxS0Z8XMCUilEF
 JE4zSt4bd+c1x/EE1IQ99Zh6veF6GuhtEQEdMTHnz4s9C2jy5vyjpVEzHIgRQW4+iLqq
 bo8URDm3zUBeLxBmlHOuN9GIbtPnL/7+kFWCurCGcfOvYqq2bBXLUfSL+zXZ6Q2K0o5H
 tkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280554; x=1759885354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o21SQbmHJ5c7GKJfo1w8RsDWnLTVYYuhCdCc7+7iYhg=;
 b=sfyoeOQg7kXCGIQ6h+wpGvaVMqDDPoiTooyfs5qUKbs6D2HMZCvbq9p2YYTkncv/Si
 UPYb62oItDx/JhKsEL1GGDYF5zfjH2r1M0brlqi87To9ZQ/lDdDMkoHW/yghY3/oTxRn
 QY5DKVcTIJJ65/zhR39woz5oBqi1FKD21YpVcrCiXOmpqGvjTNNquNaJIsp+aMYYmf8r
 PzpKP4d9+Hdy18llvhXxfcaVgc7fH7DTxJJCC0izX2PRhKPqTgftHjZTJyN799H5GZr3
 /np0dY+RQnLj2f9dc1v96pGeaBCYv6XDhazgyhkiHJW/mAWUVgD70TvvewcEGUQYZddS
 8E4Q==
X-Gm-Message-State: AOJu0YwDnnJ7DCul4hl5oGhKVgsn5AfRVfidSN2566sHPwRYEAN6Ui0A
 c4pUeJMcN8uwVemIjCh1gU5zxEKuHioAI50inxrMmDobSQ///vlWP0JbDTsSuhqjIxdb1BdYISk
 DxdqCDdN5xg==
X-Gm-Gg: ASbGnctL97/nEQ2EZ6PJwWpIVK1TYQzSVUCR+zEfojVQH3nw7DzkjI3Nzzu32o99kvo
 EWhH+8m75XQOiD1KIaIQPsKdN/PstkOlzXmUJ3Lg5DE0/TsbgP5tuXUm3iH00se7vZlTaxAXFyW
 p+pgGIKobMs1qB8yIM8F8YIa3YuBhYSQscEq3Db7zfl2OSC7HVeC4yphY2LZICCWbhI7Q/He3ZQ
 n1VEW/dJngy/OvZhC3O38AwygmKC27Yc5KYqXKRyqtTLshWBxjacTJl3dkZKaof/9NZnKgm/qPi
 1REAVPFOIw8ITis2sAY3oMDXHAOzAU3xfzFA5Yci17J7sVq0NkRrHcCax6qA3C8PycQFoBlM5M4
 xs7UYW5jhggk0zWjqYCGyRgF3ft1X8w9Gzvbwl2VGV7cE8h6GOC0s1S+4af1zpznvgSNb6bpH5U
 mPIiY2+ODJRh/FsFVKugZ6u7z4yZIoGjVAA9eMcS1a414=
X-Google-Smtp-Source: AGHT+IFKH6S+0qB6r4/RQVzP5vbIJk7BN/G8gLBzoKRJmf/V1TTep5dRu4XD49WOztrcdBIL24geCg==
X-Received: by 2002:a5d:5d87:0:b0:3fd:271d:e2a5 with SMTP id
 ffacd0b85a97d-4240f823772mr5992988f8f.11.1759280553959; 
 Tue, 30 Sep 2025 18:02:33 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:32 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 09/24] hw/intc/arm_gicv3_common: Migrate & check
 'GICv3CPUState' accessibility mismatch
Date: Wed,  1 Oct 2025 01:01:12 +0000
Message-Id: <20251001010127.3092631-10-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

At the source, administratively disabled vCPUs may lack a CPU VMSD: either they
were never realized (never enabled once), or they were realized and later
disabled, causing the VMSD to be unregistered. Such vCPUs are not migrated as
CPU devices. However, the GICv3CpuState for all vCPUs is still migrated to the
destination VM and must be checked for mismatches in their CPU interface
accessibility.

To preserve correctness, migrate the per-vCPU `gicc_accessible` bit as part of
the GICv3 device state, and fail migration on load if a mismatch is detected.
Administrators must ensure that the number of possible vCPUs and the number of
administratively disabled vCPUs remain consistent across hosts.

Changes:
 - Add `VMSTATE_BOOL(gicc_accessible)` to the per-vCPU GICv3 state.
 - Add `post_load` hook that checks for mismatch in disabled vCPUs by verifying
   GIC CPU interface accessibility.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/core/qdev.c             | 17 +++++++++++++++++
 hw/intc/arm_gicv3_common.c | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/qdev-core.h     | 15 +++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8e9a4da6b5..23b84a7756 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -326,6 +326,23 @@ bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp)
                                    errp);
 }
 
+bool qdev_enable(DeviceState *dev, BusState *bus, Error **errp)
+{
+    g_assert(dev);
+
+    if (bus) {
+        error_setg(errp, "Device %s does not supports 'enable' operation",
+                   object_get_typename(OBJECT(dev)));
+        return false;
+    }
+
+    /* devices like cpu don't have bus */
+    g_assert(!DEVICE_GET_CLASS(dev)->bus_type);
+
+    return object_property_set_str(OBJECT(dev), "admin_power_state", "enabled",
+                                    errp);
+}
+
 int qdev_get_admin_power_state(DeviceState *dev)
 {
     DeviceClass *dc;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index f4428ad165..9139352330 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -84,6 +84,15 @@ static int gicv3_post_load(void *opaque, int version_id)
 {
     GICv3State *s = (GICv3State *)opaque;
     ARMGICv3CommonClass *c = ARM_GICV3_COMMON_GET_CLASS(s);
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    /* ensure source and destination VM 'maxcpu' count matches */
+    if (s->num_cpu != ms->smp.max_cpus) {
+        error_report("GICv3: source num_cpu(%u) != dest maxcpus(%u). "
+                     "Launch dest with -smp maxcpus=%u",
+                     s->num_cpu, ms->smp.max_cpus, s->num_cpu);
+        return -1;
+    }
 
     gicv3_gicd_no_migration_shift_bug_post_load(s);
 
@@ -127,6 +136,32 @@ static int vmstate_gicv3_cpu_pre_load(void *opaque)
     return 0;
 }
 
+static int vmstate_gicv3_cpu_post_load(void *opaque, int version_id)
+{
+    bool src_enabled, dst_enabled;
+    GICv3CPUState *gcs = opaque;
+    CPUState *cs = gcs->cpu;
+
+    if (!cs) {
+        return 0;
+    }
+
+    /* we derive the source vCPU admin state via GIC CPU Interface */
+    src_enabled = gicv3_gicc_accessible(OBJECT(gcs->gic), cs->cpu_index);
+    dst_enabled = qdev_check_enabled(DEVICE(cs));
+
+    if (dst_enabled != src_enabled) {
+        error_report("GICv3: CPU %d admin-state mismatch: dst=%s, src=%s;"
+                     " Aborting!", cs->cpu_index,
+                    dst_enabled ? "enabled" : "disabled",
+                    src_enabled ? "enabled" : "disabled");
+
+        return -1;
+    }
+
+    return 0;
+}
+
 static bool icc_sre_el1_reg_needed(void *opaque)
 {
     GICv3CPUState *cs = opaque;
@@ -187,6 +222,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .pre_load = vmstate_gicv3_cpu_pre_load,
+    .post_load = vmstate_gicv3_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(level, GICv3CPUState),
         VMSTATE_UINT32(gicr_ctlr, GICv3CPUState),
@@ -208,6 +244,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
         VMSTATE_UINT64_2DARRAY(icc_apr, GICv3CPUState, 3, 4),
         VMSTATE_UINT64_ARRAY(icc_igrpen, GICv3CPUState, 3),
         VMSTATE_UINT64(icc_ctlr_el3, GICv3CPUState),
+        VMSTATE_BOOL(gicc_accessible, GICv3CPUState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b1d3fa4a25..855ff865ba 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -589,6 +589,21 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
  */
 bool qdev_disable(DeviceState *dev, BusState *bus, Error **errp);
 
+/**
+ * qdev_enable - Power on and administratively enable a device
+ * @dev:   The device to be powered on and administratively enabled
+ * @bus:   The bus on which the device is connected (may be NULL for CPUs)
+ * @errp:  Pointer to a location where an error can be reported
+ *
+ * This function performs both administrative and operational power-on of
+ * the specified device. It transitions the device into ENABLED state and
+ * restores runtime availability. If applicable, the device is also re-added
+ * to the migration stream.
+ *
+ * Returns true if the operation succeeds; false otherwise, with @errp set.
+ */
+bool qdev_enable(DeviceState *dev, BusState *bus, Error **errp);
+
 /**
  * qdev_check_enabled - Check if a device is administratively enabled
  * @dev:  The device to check
-- 
2.34.1


