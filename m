Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639CAC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRLt-00021p-OJ; Thu, 16 Jan 2025 10:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLp-00020u-56
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLn-0008Jn-HA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so10440275e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039601; x=1737644401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgiFcB97yHnaap/C1gN2qw1BdcOfgw1ZCK0YAaOeFGA=;
 b=GRGjilp1VvdmSymeJGJXIcOYvIuUq4c7Y2sZOQX+4vccRzWxJtn4NRujgAQvMJVa2N
 +L1h6A3YZT7Xixy30SAYrU0ESXb6og/2sznDp/ugK1Huf0ZwZOpUqIMXVEZS2tcpobzb
 GkDHpMxtoMW+afQz9mqd6i3R3N+OS9eh0puplZIVCQVjAQUVQMQMISRiccVc98VOZtcg
 zIzA8RbD1yy4CCNdeqUb+CtolNzYtb4Y00wZtpBCXUxkVfqC0mUjNeOtlNn2Gjmd2O6N
 t4v77V59lYj1gqKCzt4wcDSWCbK0HHHnMvfn+DVJNUP+9a+bJcHnasmMTga7qrDLszvv
 wplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039601; x=1737644401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgiFcB97yHnaap/C1gN2qw1BdcOfgw1ZCK0YAaOeFGA=;
 b=G3uW519/xTZR5/6mvnrG+oGiUxN7yU3TFPSRLjyHV2Xf49Rhy315BEOYwvAEwZhKQr
 XDXmYhCuv9bQbf1QiMOuDHhYNb86azpRB5mY6uosgp0cJQ2OIOsHaI/7cHCbUEi9fF7e
 NponV5E3wqBL2dpsi5lykmhYUEi1eU5Jf8jrlIvROmLaGHBRDRwGhzjhXfDOPaC4h/y9
 weIZ3joVoHeLoi8EjIbrtvsNyWIRfjkYbJAsW2hlHIRFaRw5nGpw3runEswpLa9t7jVR
 m1XPUJOy3ZOFYcqNJHbQ3Le5PZGVdJpFofa8w5v477kGM7WbVXpuc5kQR69Z4eE+no8W
 lOIg==
X-Gm-Message-State: AOJu0YxAkNIwxoMteeH8RKLkZ4i1Fw+9llBU8ShtwE93r9StRSU71HZQ
 Olh4wp72u23LLuVf0mbWErcJmoHg/ep7d3ekPDCB+P7yHHazJBVl1Lg6ulM+SnUJrQdRUrQjcbx
 dT/I=
X-Gm-Gg: ASbGnctOpsk3RsQ04sTggvKZCfjmAY7XfiT5ShD3Qfsw83mpEuN72lD8wBpa7NVZ0M7
 OaTkNXwgHsFeJpFU2md8ZstJDvKlyB5PWPnunPv2FAorH9XfjbZmx2zZ+f4pNgC6vc/XXZUMW3p
 AeUfmunRjeXXYtw7xfexk5QC95A+DrQaRcUKBgVWPO58pfuEUvDp65bIOgsP7C97h9bGlBdUmj3
 2i6RDHK69cKmMjAXICo+vn2cuWHPlA6Th5RujW1zo+1s6VNA5IMf2uETQdlxcCtX3JcZsw9+/M8
 FVbl8FQa9+i1IoDu0aue1nLuvGfVhnY=
X-Google-Smtp-Source: AGHT+IEZPXs3p6L5It9y2YBNTNHF2fnv3JnWnizHHfLuam9vb8UlC2aAEpoA0zw6zNCSdkd898/rxQ==
X-Received: by 2002:a05:600c:1987:b0:434:fddf:5c0c with SMTP id
 5b1f17b1804b1-436e2679e05mr321645785e9.4.1737039601405; 
 Thu, 16 Jan 2025 07:00:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a414sm84377f8f.47.2025.01.16.07.00.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 03/13] hw/arm/virt: Remove
 VirtMachineClass::disallow_affinity_adjustment
Date: Thu, 16 Jan 2025 15:59:34 +0100
Message-ID: <20250116145944.38028-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The VirtMachineClass::disallow_affinity_adjustment
field was only used by virt-2.6 machine, which got
removed. Remove it and simplify virt_cpu_mp_affinity().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h |  1 -
 hw/arm/virt.c         | 30 +++++++++++++++---------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 27c5bb585cb..5d3b25509ff 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -117,7 +117,6 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
-    bool disallow_affinity_adjustment;
     bool no_its;
     bool no_tcg_its;
     bool claim_edge_triggered_timers;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0080577e1a9..53f4a96e517 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1759,24 +1759,24 @@ void virt_machine_done(Notifier *notifier, void *data)
 
 static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 {
-    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
+    uint8_t clustersz;
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
 
-    if (!vmc->disallow_affinity_adjustment) {
-        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
-         * GIC's target-list limitations. 32-bit KVM hosts currently
-         * always create clusters of 4 CPUs, but that is expected to
-         * change when they gain support for gicv3. When KVM is enabled
-         * it will override the changes we make here, therefore our
-         * purposes are to make TCG consistent (with 64-bit KVM hosts)
-         * and to improve SGI efficiency.
-         */
-        if (vms->gic_version == VIRT_GIC_VERSION_2) {
-            clustersz = GIC_TARGETLIST_BITS;
-        } else {
-            clustersz = GICV3_TARGETLIST_BITS;
-        }
+    /*
+     * Adjust MPIDR like 64-bit KVM hosts, which incorporate the
+     * GIC's target-list limitations. 32-bit KVM hosts currently
+     * always create clusters of 4 CPUs, but that is expected to
+     * change when they gain support for gicv3. When KVM is enabled
+     * it will override the changes we make here, therefore our
+     * purposes are to make TCG consistent (with 64-bit KVM hosts)
+     * and to improve SGI efficiency.
+     */
+    if (vms->gic_version == VIRT_GIC_VERSION_2) {
+        clustersz = GIC_TARGETLIST_BITS;
+    } else {
+        clustersz = GICV3_TARGETLIST_BITS;
     }
+
     return arm_build_mp_affinity(idx, clustersz);
 }
 
-- 
2.47.1


