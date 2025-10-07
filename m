Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D1ECCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qo-0005wh-2l; Tue, 07 Oct 2025 10:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QH-0005kv-MM
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q1-0002BY-Gu
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so60036715e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846309; x=1760451109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oqOSdIyoTRGF9j3ueRLe762WG9LD45dvNpAF+YWxofo=;
 b=qRnMYsZ3LeLv0LI3xPdDXh59erDCw6HEzCOqOCwBRFSh4TdE8iOMDj5AODunvZbRuq
 M93clhskN+6qBzaa+3IQqx0J9KlOXK2nbJwQbwbKGS9RRTXCI9yE54BWHvL/d7Lt2n93
 1nkCcavatSrr714eQt1ZQR20XJw11thDguxxSiv99lSE6gpMzh5oEQSNMbZabMLVgAT2
 FNFcqoTj2fZLbvJEGybUJP9MMLXK43BGtqr1kRsisWIGa0SoYdXl8I0PyKT8opXbGMH1
 bP6CkaLJ3DtNYgxpuoHKQyCR+xet7zBBW6JJD8Vj+hCjrAK3zwdrB3NoU3hrYxJ1OZ8S
 4DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846309; x=1760451109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqOSdIyoTRGF9j3ueRLe762WG9LD45dvNpAF+YWxofo=;
 b=rAvdCLqMEjNnJiWDXbW+6s+ooVZzMi0+c8MxSyKKhLhPAHL0kgpnAlxMep92cIfdPL
 RNwy0WM8vTT/H6kY8IYZxUzeofCL4mKDKM125YLRTPlzYoB9DAgsiflgCjv7ZhwiuIBB
 mhid5H0bYEsdh8gHrVJxC5wRt/BYiiKp9BzasUkamDbl8Xj250EpgOfg7aew+rGUg6CE
 MRBMCNaTv93V5qPLGlguwD1t9q5x9xo8+ohqr+GwQP6xAjquPx2QZhICBwXhLTaYwWm/
 zOe3O4/YvzhcKhOs5HpCHNrxQUaYrl9fY7WEB/eaalWrUIeQFSLeAc0VmmVDsdAiwlD5
 AHSQ==
X-Gm-Message-State: AOJu0Yx9luWpac1I/m6Z216XSz3qzs9gThrvV9QKsSK2sEfLEEoDpD6I
 cqDdXI6rJlcjKHrWOkQugfHkYBhqwM/cBr/S9NWFh0VygXq9hmy48988XW/1bgNnI32EKBPPdzi
 UdNbW
X-Gm-Gg: ASbGncskduiA09DLHed3hR8iTxIUQRLNVm1a+z7BOvA/bG9l8poDSXO9M72zhEVI+yN
 uby0O48HDa0Bvj7EBgiOz5X27GGTAPDuFvvOQVdi5jD4bNiTQdzUrudG7VY6tGy1hVb2FAxq0ui
 ZXpGY4khaqLLJbwrxD9T8qHkD3CYG0Kh5vqUlEo9f42kOwcRHmnZbBQ0z3eylrgI0x5AzAvd7Jz
 b04rvVR0XkqWquxkC/4uvAyk8ik2eYLUTqqYDHguXq1n8LzQahpZpRySiNVUSUYv+G8LQGZ++Xl
 rBKa84z+6420mxVK9e3pBKt1XsCuYmwjZkkRT/ghaDhmOg94op51zkbTYMTYR/SYssuo+eKs8BU
 rR+1tYwkdAvqIZB1FhETz05O/NV0CXT5099Aua+Q8ouqdlm1smNyNSkP9PIzoyht4dWY=
X-Google-Smtp-Source: AGHT+IGn/KPI4GtJ1KNNumN9f0Ub+rvsM9CAOeLB/Tnu9MpIpWKjEIXIIt9/oqSFy4SmTJJFQVhh+Q==
X-Received: by 2002:a05:600c:609b:b0:45b:7be1:be1f with SMTP id
 5b1f17b1804b1-46e711469b0mr100051475e9.32.1759846308898; 
 Tue, 07 Oct 2025 07:11:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/62] hw/arm/xlnx-versal: add the mp_affinity property to the
 CPU mapping
Date: Tue,  7 Oct 2025 15:10:42 +0100
Message-ID: <20251007141123.3239867-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Luc Michel <luc.michel@amd.com>

Add a way to configure the MP affinity value of the CPUs given their
core and cluster IDs. For the Versal APU CPUs, the MP affinity value is
given by the core ID in Aff0.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-22-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index b4cad856dc2..ccb78fadd7f 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -90,6 +90,12 @@ typedef struct VersalCpuClusterMap {
     uint32_t qemu_cluster_id;
     bool dtb_expose;
 
+    struct {
+        uint64_t base;
+        uint64_t core_shift;
+        uint64_t cluster_shift;
+    } mp_affinity;
+
     enum StartPoweredOffMode start_powered_off;
 } VersalCpuClusterMap;
 
@@ -198,6 +204,10 @@ static const VersalMap VERSAL_MAP = {
         .num_cluster = 1,
         .num_core = 2,
         .qemu_cluster_id = 0,
+        .mp_affinity = {
+            .core_shift = ARM_AFF0_SHIFT,
+            .cluster_shift = ARM_AFF1_SHIFT,
+        },
         .start_powered_off = SPO_SECONDARIES,
         .dtb_expose = true,
         .gic = {
@@ -567,11 +577,16 @@ static DeviceState *versal_create_cpu(Versal *s,
     DeviceState *cpu = qdev_new(map->cpu_model);
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     Object *obj = OBJECT(cpu);
+    uint64_t affinity;
     bool start_off;
     size_t idx = cluster_idx * map->num_core + core_idx;
     g_autofree char *name;
     g_autofree char *node = NULL;
 
+    affinity = map->mp_affinity.base;
+    affinity |= (cluster_idx & 0xff) << map->mp_affinity.cluster_shift;
+    affinity |= (core_idx & 0xff) << map->mp_affinity.core_shift;
+
     start_off = map->start_powered_off == SPO_ALL
         || ((map->start_powered_off == SPO_SECONDARIES)
             && (cluster_idx || core_idx));
@@ -580,6 +595,7 @@ static DeviceState *versal_create_cpu(Versal *s,
     object_property_add_child(OBJECT(qemu_cluster), name, obj);
     object_property_set_bool(obj, "start-powered-off", start_off,
                              &error_abort);
+    qdev_prop_set_uint64(cpu, "mp-affinity", affinity);
     qdev_prop_set_int32(cpu, "core-count",  map->num_core);
     object_property_set_link(obj, "memory", OBJECT(cpu_mr), &error_abort);
     qdev_realize_and_unref(cpu, NULL, &error_fatal);
-- 
2.43.0


