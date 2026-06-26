Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50210CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3ea-0000ts-UZ; Fri, 26 Jun 2026 06:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eT-0000Sc-8S
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eR-0005Mj-6w
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWzuLmfM5mOqM+9k40W+ZwF1xU/OB7680Gl9q1U09qY=;
 b=W5vZKDJLk7IB3ppiGD3Y+Vd1L6axU1tibn2k3VQCbytazhRl9a5/g04ZAsBsdVQwWokAGg
 m0PJS3kDoxtkIRCA1Oiuc9cBCsN4jXHNGgGQ40X+iOMv7V9nAA3ROa32bAyu5tAC1uRWPH
 1EPyalJZ4AdY8Ct4TxkqNJ9u/sCm6Lw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-SbyUcD7OMqye3qL-If5fVw-1; Fri, 26 Jun 2026 06:19:09 -0400
X-MC-Unique: SbyUcD7OMqye3qL-If5fVw-1
X-Mimecast-MFC-AGG-ID: SbyUcD7OMqye3qL-If5fVw_1782469148
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-492488f8583so8532025e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469148; x=1783073948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWzuLmfM5mOqM+9k40W+ZwF1xU/OB7680Gl9q1U09qY=;
 b=ZthsGFDPc2OLTQqzpAOnGkoUV3LQ4Rkk4n3MCoLbfAh0m4RJ9Y1bWQPz8eTCQEp0yo
 g3y1oXnhxyyPmhkE84LBN206RERsW6o4UpF0pRAHZarny3JNrhsa6AD6bGYlEtV9JT2c
 89MzCuUx1lgVerkw4HX1uJmCauOZB7qX5KPJSA4MJ+Gc5Dl5EeN5T9+yVR4DOa/pfTvM
 zhS1UTjqgLhPtvSGCUErxLNniCSdf7K8eGcTI7hkgc4mgKLjUqoLbeBkBXgJOWKqG6Yl
 k25lMFwwn4v64PKixs8sRaAsZDOaiR0k5znLSZDwyK+gpu8e4SdX6cnsGIk4hXjBZJcI
 PGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469148; x=1783073948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hWzuLmfM5mOqM+9k40W+ZwF1xU/OB7680Gl9q1U09qY=;
 b=aisZo/4glAA/VzUxJMg0/3yH5/T5rHizz/VL1JHlKx5ZnNSz9s7nqRHBKRIv44KSN3
 CVcuzlE1UG7iEqUvoB6uQqdjR8eo1SynQ2OkbEiXo5YjybAAntHSG8U28wwTYHiuvG+n
 GQ13xZGeKB/O+mdVAJNuvUEL5fd5GV63sXR7bZxFjZv+oXxMEtmLI3IJ0MRn4RkuD3vV
 GWYq/Ina5xN2iN1OnGReWtTq+iNShfTwMCYwTlSlAZVkMSdL5keiwkIxsCdvzsUmNW9Q
 AJlXFuo73Hnzhs6SoSKVkHG90g/85HF99/uHrZhG/DHp+q5a0Ol/9vUfty3LSlhn3tua
 joOw==
X-Gm-Message-State: AOJu0YzYKIOYrraNNq/bAkXMaXyXrMrUK2OtLfidm0fU4cKhcUAwLsgd
 wONv2en3kOZmmKoXqKk2e9dPQBASYq5wybmrSb2Y60RuTBJZDT+62tl4tX/eA3Kohy64oudWItK
 OJ5QWxZXRCmuHaaJtA5n2/bUkUXZtpZM8tOMMt3KEws2rkgDQCOvRjDJj19PMjVmHjbuOdXMtrx
 yj9z9um+Uv2JkTh3kBMSSBVqrXOUqZTebAnQSvw/Lk
X-Gm-Gg: AfdE7cljZlJo0Zm6IH35eB1sQsuSe2NjzUsqWy6RxkfL7Cg3lEXUqWsV4KdX2dGEXGr
 Kng3WaEXwILbMd0nefp/6uSq4GdXE9lkBAuiuYUJVMqPfNegNC9Uo78msgSxQIon+KfddrLoHza
 beLH8i7NiaZa63hjQutr8XOK8eNDyyz2AolbpS/SoN1IIcB6QCSCp0tRoZ+ecrXd5gfi/8aohE1
 jaA6fZpb+Sue73DplgeZhWmJRX8/AgZHu11JK2D/AOagTSy881yxFr5m/1ghOeQLBmkstsJJ4RP
 zv1gdN5U4BTZjCyetJAkiyvaPsGpRqlOut7W9ieuUDanowuedtQYaTjeU5MWqUHDa/gLrog9Cqk
 lZLAIQXDZnyKoo4jsD0CQcvCdpvrKAGGM2n+aHTEJgK32V/UZk1+Pn7QJ0qk1j+JgFfYVedVGne
 g70Pb0qM3EhNkc08f2
X-Received: by 2002:a05:600c:c4aa:b0:492:3445:ecf8 with SMTP id
 5b1f17b1804b1-4926685fe2dmr88348825e9.3.1782469147940; 
 Fri, 26 Jun 2026 03:19:07 -0700 (PDT)
X-Received: by 2002:a05:600c:c4aa:b0:492:3445:ecf8 with SMTP id
 5b1f17b1804b1-4926685fe2dmr88348105e9.3.1782469147339; 
 Fri, 26 Jun 2026 03:19:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fce5a8sm66578015e9.3.2026.06.26.03.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 28/45] target/i386/mshv: migrate XSAVE state
Date: Fri, 26 Jun 2026 12:17:31 +0200
Message-ID: <20260626101748.1728079-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

We implement fn's that roundtrip XSAVE state in migration. We are using
the xsave_helper routines to move individual components from CPUX86State
to an xsave_buf and then we have to compact the buffer to XSAVEC format,
which is what the hypervisor expects.

And the same applies in the other direction for restoring state from the
hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-32-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 100 +++++++++++++++++++++++++++++++++++-
 target/i386/meson.build     |   2 +-
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 9f513a0e436..bbf874f6413 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -112,6 +112,78 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
 
 static int set_special_regs(const CPUState *cpu);
 
+static int get_xsave_state(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    void *xsavec_buf;
+    const size_t page = HV_HYP_PAGE_SIZE;
+    size_t xsavec_buf_len = page;
+
+    /* TODO: should properly determine xsavec size based on CPUID */
+    xsavec_buf = qemu_memalign(page, xsavec_buf_len);
+    memset(xsavec_buf, 0, xsavec_buf_len);
+
+    struct mshv_get_set_vp_state args = {
+        .type = MSHV_VP_STATE_XSAVE,
+        .buf_sz = xsavec_buf_len,
+        .buf_ptr = (uintptr_t)xsavec_buf,
+    };
+
+    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, &args);
+    if (ret < 0) {
+        error_report("failed to get xsave state: %s", strerror(errno));
+        return -errno;
+    }
+
+    ret = decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
+    g_free(xsavec_buf);
+    if (ret < 0) {
+        error_report("failed to decompact xsave area");
+        return ret;
+    }
+    x86_cpu_xrstor_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    return 0;
+}
+
+static int set_xsave_state(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    void *xsavec_buf;
+    size_t page = HV_HYP_PAGE_SIZE, xsavec_buf_len;
+
+    /* allocate and populate compacted buffer */
+    xsavec_buf = qemu_memalign(page, page);
+    xsavec_buf_len = page;
+
+    /* save registers to standard format buffer */
+    x86_cpu_xsave_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    /* store compacted version of xsave area in xsavec_buf */
+    compact_xsave_area(env, xsavec_buf, xsavec_buf_len);
+
+    struct mshv_get_set_vp_state args = {
+        .type = MSHV_VP_STATE_XSAVE,
+        .buf_sz = xsavec_buf_len,
+        .buf_ptr = (uintptr_t)xsavec_buf,
+    };
+
+    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, &args);
+    g_free(xsavec_buf);
+    if (ret < 0) {
+        error_report("failed to set xsave state: %s", strerror(errno));
+        return -errno;
+    }
+
+    return 0;
+}
+
 static void populate_fpu(const hv_register_assoc *assocs, X86CPU *x86cpu)
 {
     union hv_register_value value;
@@ -717,6 +789,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_xsave_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = get_vcpu_events(cpu);
     if (ret < 0) {
         return ret;
@@ -1263,6 +1340,11 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    ret = set_xsave_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = set_vcpu_events(cpu);
     if (ret < 0) {
         return ret;
@@ -1817,9 +1899,10 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     AccelCPUState *state = cpu->accel;
-    size_t page = HV_HYP_PAGE_SIZE;
+    size_t page = HV_HYP_PAGE_SIZE, xsave_len;
     void *mem = qemu_memalign(page, 2 * page);
     int ret;
+    X86XSaveHeader *header;
 
     /* sanity check, to make sure we don't overflow the page */
     QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
@@ -1833,6 +1916,17 @@ void mshv_arch_init_vcpu(CPUState *cpu)
 
     env->emu_mmio_buf = g_new(char, 4096);
 
+    /* Initialize XSAVE buffer page-aligned */
+    /* TODO: pick proper size based on CPUID */
+    xsave_len = page;
+    env->xsave_buf = qemu_memalign(page, xsave_len);
+    env->xsave_buf_len = xsave_len;
+    memset(env->xsave_buf, 0, env->xsave_buf_len);
+
+    /* we need to set the compacted format bit in xsave header for mshv */
+    header = (X86XSaveHeader *)(env->xsave_buf + sizeof(X86LegacyXSaveArea));
+    header->xcomp_bv = header->xstate_bv | (1ULL << 63);
+
     /*
      * TODO: populate topology info:
      * X86CPUTopoInfo *topo_info = &env->topo_info;
@@ -1857,6 +1951,10 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     g_free(state->hvcall_args.base);
     state->hvcall_args = (MshvHvCallArgs){0};
     g_clear_pointer(&env->emu_mmio_buf, g_free);
+
+    qemu_vfree(env->xsave_buf);
+    env->xsave_buf = NULL;
+    env->xsave_buf_len = 0;
 }
 
 uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 80062d1d0d8..b4fbf8a5374 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -12,7 +12,7 @@ i386_ss.add(when: 'CONFIG_KVM', if_true: files('xsave_helper.c', 'host-cpu.c'))
 i386_ss.add(when: 'CONFIG_HVF', if_true: files('xsave_helper.c', 'host-cpu.c'))
 i386_ss.add(when: 'CONFIG_WHPX', if_true: files('xsave_helper.c', 'host-cpu.c'))
 i386_ss.add(when: 'CONFIG_NVMM', if_true: files('host-cpu.c'))
-i386_ss.add(when: 'CONFIG_MSHV', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_MSHV', if_true: files('xsave_helper.c', 'host-cpu.c'))
 
 i386_system_ss = ss.source_set()
 i386_system_ss.add(files(
-- 
2.54.0


