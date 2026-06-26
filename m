Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59575CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eo-0002Em-TR; Fri, 26 Jun 2026 06:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ek-0001jS-NT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ei-0005Oy-NZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpA0ZMYEARfbuoCSlWmOkhd8EMX7+Uh6D+r5pGTpStM=;
 b=bIjuNKSW1Jwqs04/GQ+53Xyaum/nLvxezug4QwR6STiF1r0Z9Egjzn8JaO+VABxbAwMIUT
 xOpxx6TiJdKa+x65mo7oq8Wv/8KSwYL0qt3SH2Id/Jt2cpz4jjcMeHNwFPFgy3DFdIha/O
 DjNwLC80GnR7+Tgo+AMxo1aYFEuT64c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-eBmzDWC2NUSFsMb92al2cQ-1; Fri, 26 Jun 2026 06:19:26 -0400
X-MC-Unique: eBmzDWC2NUSFsMb92al2cQ-1
X-Mimecast-MFC-AGG-ID: eBmzDWC2NUSFsMb92al2cQ_1782469166
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460153ce644so451106f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469165; x=1783073965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpA0ZMYEARfbuoCSlWmOkhd8EMX7+Uh6D+r5pGTpStM=;
 b=dTVBt2QqLYzy4S3RsKniBu83cGhfz8kmd+Xa9u5hQYHJR2Jd8DFNfkoTXLGSd/5zyU
 CakoqbHiglG17bDoS72QBsgkj6qn93t7P3jyoXcydou56MCRwJ6tasaSbN8ugE2tziQd
 wynuZ1rc01JIDodUgvQNfQOgtZSNiz+C/0fyKp43fQbfdB4+B0gP4nl60n1H/LlE0xuO
 CdET0yfIl6aq+hAeDaMtAyFmHmX4WDp1Lc1DRYKZapATZ8T796ul5yN1Je5wnXeHoDTV
 6eiLNpWxDkUxJRA5xBtr5C1fkMbxshhoBk6WsoUZs61M8SL6krr1qehKP52w6G6JeU21
 MCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469165; x=1783073965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UpA0ZMYEARfbuoCSlWmOkhd8EMX7+Uh6D+r5pGTpStM=;
 b=fQerfz59wewBxvJD6o+VsqTsvuAfTcQJvBcs5BP3bSsYQCNJpen5XuA/oTZl/7FxX6
 QP0Mf3UN8ozcu0RGQuZzI4qvn/fmhQVG5sW1+b1rrCZORLd7t3wuAkABClw9DhGPrq+8
 2/KOfusuJQ+xceEI7roiD0ItieYVNJTZzml/CPln+JPhTOOxCaXS4hkzZbSwNPHUEUT4
 XEKKY7GcgeyfEuR3vfUuElkPSkwYQ9jZCwHaOLg56kFmMiUmh1KbdiW9hkbcytrHRtzx
 75lTXYoC2vcWVnGzS4aNyUI+0saQ0xAp11B/8Pmekff06evbnDL4zcX5gHtlloeHObOE
 vFww==
X-Gm-Message-State: AOJu0YyxiX20JcbuzD6m9PD4zVZOXyzy8biysPyByDejsSqXoiBdVPRA
 w7SFb03cxSMSNqHD2KNeZaFk4QHnaZx6f2NgxzS9t7Lb2b7ErUlmSn3jyFC0UUybu/9rBddjUjk
 My0PIDgGht412QZyYXA/6XQUONJxeP7nmpuyGzcXEDe9TIII0A2f6zOCrIndlekhnrQUNAZXMdI
 uGmw7b93+E14K1iWPPDZ5Wua8X4PZ5lzLu07cmi4YS
X-Gm-Gg: AfdE7cnXe5Agp4f9tIhW+y99gR9uNWmSnDGjUrWBRmUqlmPS7LZil4YYeYWGayl9jwf
 utLNc0YG8rrNuV1hygx8NcxZFdSJ1TmqKOuPNKaHFx5V0zWOAqb5wBcbADkGf/p9CRBWNkGsFbJ
 3iPLgRrPC+y4qpec3w0cdrc46WdGYTAgA1tuAsoU3kTOmlUiYdkXT18Y1LiuBzS2cc11JFRET/f
 H++rc9Wn24wqReRJUnZAfIRhwwJu7rnfvevRiZaujgObF7aYDrQYCAs1Cr7qxSW0BSHtflDgjRB
 pRiZ7qRNpWXxkEtWv4hRKss3TAXi8W+HD93HdiajkY8GLVqdIfNnJafqoXH47v7u9O4u9/QVyoe
 U7Sz4KTWu0isnisHDD6zH0g57wkDGVTpGtC6wdfda1SjReN/A4385DnnOtPI5YzNQpgxuxbi6WW
 Rg/tJOVps561fvLOeP
X-Received: by 2002:a05:6000:2408:b0:46e:e2a0:9f54 with SMTP id
 ffacd0b85a97d-46ee2a0a0abmr4122059f8f.13.1782469165482; 
 Fri, 26 Jun 2026 03:19:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2408:b0:46e:e2a0:9f54 with SMTP id
 ffacd0b85a97d-46ee2a0a0abmr4121968f8f.13.1782469164859; 
 Fri, 26 Jun 2026 03:19:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c22c680fasm24258434f8f.34.2026.06.26.03.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 35/45] target/i386/mshv: hv_vp_register_page setup for the vcpu
Date: Fri, 26 Jun 2026 12:17:38 +0200
Message-ID: <20260626101748.1728079-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

When the vcpu is created, call mmap to configure access to the register page.

Update CPUArchState to store a pointer to the mmapped hv_vp_register_page.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260428135053.251200-5-dblanzeanu@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           |  9 +++++++--
 target/i386/mshv/mshv-cpu.c | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67e2ecf3251..e6a197602d8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1983,6 +1983,9 @@ typedef struct CPUCaches {
         CPUCacheInfo *l3_cache;
 } CPUCaches;
 
+struct kvm_msrs;
+struct hv_vp_register_page;
+
 typedef struct CPUArchState {
     /* standard registers */
     target_ulong regs[CPU_NB_EREGS];
@@ -2289,6 +2292,10 @@ typedef struct CPUArchState {
     QEMUTimer *xen_periodic_timer;
     QemuMutex xen_timers_lock;
 #endif
+#if defined(CONFIG_MSHV)
+    /* Shared register page */
+    struct hv_vp_register_page *regs_page;
+#endif
 #if defined(CONFIG_HVF) || defined(CONFIG_MSHV) || defined(CONFIG_WHPX)
     void *emu_mmio_buf;
 #endif
@@ -2315,8 +2322,6 @@ typedef struct CPUArchState {
     DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
 } CPUX86State;
 
-struct kvm_msrs;
-
 /**
  * X86CPU:
  * @env: #CPUX86State
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index a383e0ab104..67dfb3c42ab 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1906,6 +1906,18 @@ void mshv_arch_init_vcpu(CPUState *cpu)
                       + sizeof(hv_input_get_vp_registers)
                       > HV_HYP_PAGE_SIZE));
 
+    /* mmap the registers page */
+    void *rp = mmap(NULL, page, PROT_READ | PROT_WRITE,
+                    MAP_SHARED, mshv_vcpufd(cpu),
+                    MSHV_VP_MMAP_OFFSET_REGISTERS * page);
+    if (rp == MAP_FAILED) {
+        warn_report("register page mmap failed, falling back to hypercalls: %s",
+                    strerror(errno));
+        env->regs_page = NULL;
+    } else {
+        env->regs_page = (struct hv_vp_register_page *) rp;
+    }
+
     state->hvcall_args.base = mem;
     state->hvcall_args.input_page = mem;
     state->hvcall_args.output_page = (uint8_t *)mem + page;
@@ -1944,6 +1956,11 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     CPUX86State *env = &x86_cpu->env;
     AccelCPUState *state = cpu->accel;
 
+    /* Unmap the register page */
+    if (env->regs_page) {
+        munmap(env->regs_page, HV_HYP_PAGE_SIZE);
+        env->regs_page = NULL;
+    }
     g_free(state->hvcall_args.base);
     state->hvcall_args = (MshvHvCallArgs){0};
     g_clear_pointer(&env->emu_mmio_buf, g_free);
-- 
2.54.0


