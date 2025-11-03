Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D34CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrYi-0004xt-PL; Mon, 03 Nov 2025 05:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrYg-0004va-IK
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:13:06 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrYT-0002vQ-PQ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:13:05 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47710acf715so20337205e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164769; x=1762769569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hddejy+RqNyWzp8USy+9Z4LwK1QwF0we3BKzrWx+KAA=;
 b=iUPdPKp94HWvR+qauFvAyMO6/wEH7JFrdUBy8h2bOsCFDVMGo7AIvToB8WOILRkLFj
 boDEH72xINXxCk0VVJmnGWTsHQwZzQ7l7MEVOGINepihn86+wxrESlr+Rh6kw5rkL7kW
 zofp/ZuC87RANrWfqn0NoFDTx+gEc/g8mElGxFzdMRYXsYDYQRwLRisW3moQ4fFtyhEX
 oVFvuD1LjXIBefi8PSxwgt8PFnkQONuf4WT26ZoQeuS80ErgCvr218/63B9YhJffAG14
 kQ2bNGRdV+P8T44YYHpGFEw/0iEwbzhxZHRZvjh41OguC3UNQ4iChDT91jcJ4EO4ncFH
 VNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164769; x=1762769569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hddejy+RqNyWzp8USy+9Z4LwK1QwF0we3BKzrWx+KAA=;
 b=HT7gilt4TXv9eboSv+jPLLNDP65VpAzBSMg3S3JOVufYI/gjVeXdtp7PkN1VHRIHut
 kYi7wofQifiJzoBvCJ/BReyxuQ6vYlx5E2fji5Y3Fb8GsaRSIWwQc6qCmJV1pImlscu5
 in40sClOp4qbwID6t2x9aa7uYa+uCy4tDGVLNhPhfHXR00N7W6kEtvNnrHgSE3sE9UX2
 1YdjWqGUtC7Pk8Apey5Qj+8cKYf2OrW+CcRNaQOIR0F7o2UauuQRutke0guaJb8XtKHb
 6Hvuy5AuT1ibrAvzYy+DnDDenZTjMW7ppdNOpNFR7/oXGSLVJMAtHKHzL8vCEtNaE/CL
 VKlg==
X-Gm-Message-State: AOJu0Yxsvr0zTiRu1CTETJhrYgv3CaMHfwPKUN30sHdRDTh+EeHQUNxE
 yTQpmTy8ApxfbVnScROEU0+pWbdYWKMczOfo9RbZFkKBewyMlIW3EzYakaLHb3f+tXOrAtvuhqF
 hM/5SpNo=
X-Gm-Gg: ASbGncuH/7M6FjgAdYDk/q+CsIZ+K1CvzCz5wz7BIZBxZG3tlkIatSls0OtT9fq3mL7
 OkNJGLh9MbKWCAAAV7vPSHhKlx92z5gwN9P6qQLWOfPVZ4003eG91YTs2Rz8EMr2yIfiGz7VEEE
 i47oVUBGwj9BoqpD7NlwYjlCIhjLRPdyPJ28ZklWD2Wl3ovRAZD0cg0DekMzy8ypJpQQKVJGojc
 aNpeTmo6ryiwIHNt75aTK5oawNYqtNWiFfD0FGuPg19D5QhRe/cqQ59Ev4YY9F5n32VbAewRWxI
 qIedCyffetcfsV9sr7zOCOYrcdIP958mwm6G6wT1Kb5oxsxqZma+XxftzRC39+1ic6GWJONH/TU
 +R7CdkQ6Ir524o5gHS13vmWGY35UUVAnautJ2y2C0iMd7cFGlNo6SrCuZ0ylELBJkg7qQ2SBPYO
 GYbaUXN3B5glR3+AodqchuSKmwztdj9l/pTNti5fFJbkJyYB2i6ICG4Jvore7hSg8mXYU5DQ==
X-Google-Smtp-Source: AGHT+IFlY39asyt24FXv7gpE4ECnU1pHD55fFXzazUblY7kazIn1omCLcl75SsgylZpTK5FDRdDa/w==
X-Received: by 2002:a05:600c:6303:b0:46e:4be1:a423 with SMTP id
 5b1f17b1804b1-477307b7e7amr93501465e9.1.1762164769020; 
 Mon, 03 Nov 2025 02:12:49 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c4af7c7sm149279335e9.7.2025.11.03.02.12.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:12:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 05/23] target/i386/hvf: Use address_space_translate in
 ept_emulation_fault
Date: Mon,  3 Nov 2025 11:10:14 +0100
Message-ID: <20251103101034.59039-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The hvf_slot structure is a poor replacement for properly
looking up a memory region in the address space.
Use memory_region_get_dirty_log_mask instead of HVF_SLOT_LOG.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index de06ec6125f..d0ee00425f0 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -119,9 +119,12 @@ void hvf_handle_io(CPUState *env, uint16_t port, void *buffer,
     }
 }
 
-static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
+static bool ept_emulation_fault(CPUState *cs, uint64_t gpa, uint64_t ept_qual)
 {
-    int read, write;
+    bool read, write;
+    MemoryRegion *mr;
+    hwaddr gpa_page = gpa & qemu_real_host_page_mask();
+    hwaddr xlat;
 
     /* EPT fault on an instruction fetch doesn't make sense here */
     if (ept_qual & EPT_VIOLATION_INST_FETCH) {
@@ -129,21 +132,22 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
     }
 
     /* EPT fault must be a read fault or a write fault */
-    read = ept_qual & EPT_VIOLATION_DATA_READ ? 1 : 0;
-    write = ept_qual & EPT_VIOLATION_DATA_WRITE ? 1 : 0;
-    if ((read | write) == 0) {
+    read = ept_qual & EPT_VIOLATION_DATA_READ;
+    write = ept_qual & EPT_VIOLATION_DATA_WRITE;
+    if (!read && !write) {
         return false;
     }
 
-    if (write && slot) {
-        if (slot->flags & HVF_SLOT_LOG) {
-            uintptr_t page_size = qemu_real_host_page_size();
-            intptr_t page_mask = -(intptr_t)page_size;
-            uint64_t dirty_page_start = gpa & page_mask;
+    mr = address_space_translate(cpu_get_address_space(cs, X86ASIdx_MEM),
+                                 gpa_page, &xlat, NULL, write,
+                                 MEMTXATTRS_UNSPECIFIED);
 
-            memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hvf_unprotect_dirty_range(dirty_page_start, page_size);
-        }
+    /* Handle dirty page logging for ram. */
+    if (write && memory_region_get_dirty_log_mask(mr)) {
+        uintptr_t page_size = qemu_real_host_page_size();
+
+        memory_region_set_dirty(mr, gpa_page + xlat, page_size);
+        hvf_unprotect_dirty_range(gpa_page, page_size);
     }
 
     /*
@@ -156,9 +160,6 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
         return false;
     }
 
-    if (!slot) {
-        return true;
-    }
     if (!memory_region_is_ram(slot->region) &&
         !(read && memory_region_is_romd(slot->region))) {
         return true;
@@ -764,7 +765,6 @@ static int hvf_handle_vmexit(CPUState *cpu)
     /* Need to check if MMIO or unmapped fault */
     case EXIT_REASON_EPT_FAULT:
     {
-        hvf_slot *slot;
         uint64_t gpa = rvmcs(cpu->accel->fd, VMCS_GUEST_PHYSICAL_ADDRESS);
 
         if (((idtvec_info & VMCS_IDT_VEC_VALID) == 0) &&
@@ -772,9 +772,8 @@ static int hvf_handle_vmexit(CPUState *cpu)
             vmx_set_nmi_blocking(cpu);
         }
 
-        slot = hvf_find_overlap_slot(gpa, 1);
         /* mmio */
-        if (ept_emulation_fault(slot, gpa, exit_qual)) {
+        if (ept_emulation_fault(cpu, gpa, exit_qual)) {
             struct x86_decode decode;
 
             hvf_load_regs(cpu);
-- 
2.51.0


