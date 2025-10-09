Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68446CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQu-0008Tb-VB; Thu, 09 Oct 2025 03:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQt-0008TK-Cf
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQp-0004RC-Pu
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4e5WisuIRnKwgKzQaGFn0q2ckBCBWWEQciLxXlj8bI=;
 b=fZlqNFIDNffSakYKU91KfA5Qr+CNHYq+MHnGy6aILAvJaH6S4Spmbq2ZMhjjfAJIkrsxsG
 ncgpKBRwaDAsnQ5C93mRlwMSRt7wgyWsi6JBRnCt5m1z0AGQDSndh4v8P+SW6Wk8U1LYVx
 JlaDGx+UoSyQuEnIG6mKeSnvcnsQlUE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-ClWHQkEdMEG328XoGDkzBA-1; Thu, 09 Oct 2025 03:51:20 -0400
X-MC-Unique: ClWHQkEdMEG328XoGDkzBA-1
X-Mimecast-MFC-AGG-ID: ClWHQkEdMEG328XoGDkzBA_1759996279
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ece14b9231so517135f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996278; x=1760601078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4e5WisuIRnKwgKzQaGFn0q2ckBCBWWEQciLxXlj8bI=;
 b=MNUJ/Xf2i4y1SVaYArDLle1ZJb+fIZ8AMwnEikR/yyVICk3iNDDKHMurJeYcsolD9n
 HSTq6xJcP6Nl/mMsJddz3QL7EQBNosboRt9ugJ+wt9hTVal4RpYihIm2qHA6LpB2eIxS
 NXw8v30yZFapd0nG25B9j3XBZsZVFGmS9Wk995NKHNvuETHTSTpi6ml37V697J0UOU/k
 /oWFHlxFROkRVjCHFl33uG180RXQt8UFlw7VtDHmHAeuw5BPq/OoUKdTI49sFQ60Yz/Q
 fxO4ZaCQB6f/DuR+OEJyaaKSJlhfkEy1SF8OQlAI4I1EkTehJNL23keg6dUPQAfO/zLz
 ibBQ==
X-Gm-Message-State: AOJu0YxXLc6QXZp3dPL8S3naBwsLLvYng1HXnQ5wwffAGllerfvy8DkW
 hPWfwa7lVBT0C2tIn7nvHpSPIMiE70R/T6iBfu9urdSZ1lj77BTA0rDShoikhuNuUwgYUv+kWWv
 bHwh9R2psFDT6A6G0x08IsXKnSg49t3AqMajiyfVOh8PVJCRs508e9CCNUZPEY40v7lVpUAsyuC
 uxtkIAuC1Km89f3kQtBOznAwgG1LicVFitGOIgPciLajE=
X-Gm-Gg: ASbGnctYDLS6hJBhBVsFiCSirY9hpnjf3ALbSeOUURDfR0bzRn0D0eE247TaxAu77Wv
 3wP/TEmEj6PeFUm2VVBqcx8s72ekTHX0rCPlSENBIGkiVOVR53Wy8FKqksIPYSkDCD20CSRYy4a
 LMojd0u+sFmzINa0nQHH+JFSOS9tQMR0tee00rn1kfuqpzqtFPAQTtL5yiw2WvjPi7M6/+rt6PM
 yxBw/eIUClEUUyjeigZqLcSt0qGYfVV2zrQGi06zyWjQ4R3nRoFVupzwx0RbKdu5kUslZLwHXEG
 MPrVN6DD7xx2Se5Z4ASjn+b+Kx3NQUPg3tPL8adpyve+tWaLuty2IiTH3QPzP+S6L5KBLwobFC1
 NRxXAUlCdbwTd6VpzF2mFR7jZWSaClUUMURwS6HApxZQJZg6k
X-Received: by 2002:a05:6000:60f:b0:411:f07a:680b with SMTP id
 ffacd0b85a97d-4266e8d8a7dmr4377795f8f.33.1759996278011; 
 Thu, 09 Oct 2025 00:51:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE++XMu4ekhBRSyEQC3OxsD4S2QcrcWTzHbtqJp7O30pX0J0x7ufZdn7fF/oEbfwFBdfBYUcQ==
X-Received: by 2002:a05:6000:60f:b0:411:f07a:680b with SMTP id
 ffacd0b85a97d-4266e8d8a7dmr4377770f8f.33.1759996277595; 
 Thu, 09 Oct 2025 00:51:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8acc4csm32951297f8f.16.2025.10.09.00.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 23/35] target/i386/mshv: Set local interrupt controller state
Date: Thu,  9 Oct 2025 09:50:13 +0200
Message-ID: <20251009075026.505715-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

To set the local interrupt controller state, perform hv calls retrieving
partition state from the hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-18-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 117 ++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 8b10c79e547..0fe3cbb48d8 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/memalign.h"
 #include "qemu/typedefs.h"
 
 #include "system/mshv.h"
@@ -21,6 +22,7 @@
 #include "hw/hyperv/hvgdk.h"
 #include "hw/hyperv/hvgdk_mini.h"
 #include "hw/hyperv/hvhdk_mini.h"
+#include "hw/i386/apic_internal.h"
 
 #include "cpu.h"
 #include "emulate/x86_decode.h"
@@ -562,6 +564,114 @@ static int set_cpu_state(const CPUState *cpu, const MshvFPU *fpu_regs,
     return 0;
 }
 
+static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to get partition state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int get_lapic(int cpu_fd,
+                     struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = get_vp_state(cpu_fd, &mshv_state);
+    if (ret == 0) {
+        memcpy(state, buffer, sizeof(*state));
+    }
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to get lapic");
+        return -1;
+    }
+
+    return 0;
+}
+
+static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
+{
+    return ((reg) & ~0x700) | ((mode) << 8);
+}
+
+static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to set partition state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_lapic(int cpu_fd,
+                     const struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    if (!state) {
+        error_report("lapic state is NULL");
+        return -1;
+    }
+    memcpy(buffer, state, sizeof(*state));
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = set_vp_state(cpu_fd, &mshv_state);
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to set lapic: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_lint(int cpu_fd)
+{
+    int ret;
+    uint32_t *lvt_lint0, *lvt_lint1;
+
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+    ret = get_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        return ret;
+    }
+
+    lvt_lint0 = &lapic_state.apic_lvt_lint0;
+    *lvt_lint0 = set_apic_delivery_mode(*lvt_lint0, APIC_DM_EXTINT);
+
+    lvt_lint1 = &lapic_state.apic_lvt_lint1;
+    *lvt_lint1 = set_apic_delivery_mode(*lvt_lint1, APIC_DM_NMI);
+
+    /* TODO: should we skip setting lapic if the values are the same? */
+
+    return set_lapic(cpu_fd, &lapic_state);
+}
+
 /*
  * TODO: populate topology info:
  *
@@ -573,6 +683,7 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
                         uint64_t xcr0)
 {
     int ret;
+    int cpu_fd = mshv_vcpufd(cpu);
 
     ret = set_cpu_state(cpu, fpu, xcr0);
     if (ret < 0) {
@@ -580,6 +691,12 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
         return -1;
     }
 
+    ret = set_lint(cpu_fd);
+    if (ret < 0) {
+        error_report("failed to set lpic int");
+        return -1;
+    }
+
     return 0;
 }
 
-- 
2.51.0


