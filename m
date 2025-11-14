Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3E8CEACC9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK08i-0000G0-UH; Fri, 14 Nov 2025 15:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02i-00077l-TF
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:15 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02g-0004xX-OV
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:12 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42bb288c219so224610f8f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150702; x=1763755502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hddejy+RqNyWzp8USy+9Z4LwK1QwF0we3BKzrWx+KAA=;
 b=NbXmXCdVKcnENsIgkz4YaXcn3YkXMB6n8XzFwu1lzo+ugIk/WUmJ2TnguhR29T/efX
 caLnoDRk+GgF6Sj5qV9ALtvhNIg4fwi8VMZ4qjThzsBFljDAp8IQu2AF4rRIDTSoP8xi
 9PigSKPaZaeYqhuBAkUJXUzfoCME1juB7veDUgqs+3cVVyIaqGXTdUga73N+HpkNyY1e
 AILdNzH5o8FbT7CPNxxruxBxzs7J7Mek0OkDChJ/jXAT8qOCrV56LlYB7eSghskxwz+V
 UOAy4NxRgObhAvkmdVvxUv+OaT+OuNW1FCjvavQdP+uzu0mJXmfcZyjJofbb7j61vrgV
 PJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150702; x=1763755502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hddejy+RqNyWzp8USy+9Z4LwK1QwF0we3BKzrWx+KAA=;
 b=k7DLwP6YFWw0EZYtIIeidpFhbVKk64e+A4MAuJcaYir5MiM2G/0MniOC/SPyW/abc6
 H3mmJo3AeDN3wBBsWWhe3cbHRWgqQxef2mLzefBNlJtMqeu/mfILDTdLOqLFkIdCnjwd
 wgvU2ajSC7F/rjhyHtevux+fjHiiryzMJFpTTlj4vy+1Le40jU4op+3KDNMv13NdprLs
 kE2WVAl7ZDF/4D1jhCm1F9/OG2W65bZkEPPvudCj0zxoQsidQZmDqqEsrM8kV22+MXny
 d2+/pLHiiq1VEQYQjPYpOjY7TlgzI2M5YSThGLRRO/49CNorWinLRADGZKoGI8uUokP8
 Z9mA==
X-Gm-Message-State: AOJu0YxEOEJp2YkvKoNmkxZkQG5ZI/fdsYEUjy5Ro0AKbWJ6mycqZW0m
 ggeOOgcM8JHg2hgrnI7VxnH+dGDKnGFmwh9nQYKyG7i1oGQEsYUapQtBjG+UUjn8IhQuzjnQ6qW
 rjidUHfWt0Q==
X-Gm-Gg: ASbGnctsJkggGlyYzVL873M+xCWzbC0RwESth8kILttq+v/qeUgR8QoXiDhOIZ9RhZE
 QxSV46gno/PSPFWjBu/eI0j56Bx/V/064i0Lt/Q3CWX9gaG4IyJsq7yOXoE+Aub8nqhgR3Qo64o
 rWbCWQuIskSTiLPR94zR38OnXDt9D16J7S//9iQZ4ouYKSJBL+vvpQCCa6IizpRFXbYxJJuHZfJ
 tV+JpBS7yskxG/+uqOD6usiNggMeIv+VEel6XTy/sJ5XJCuz/OVFR+fSGI2JfSpCRJ/15FHxU24
 ssXSysh3BJzhPHFFB35lSpk5QY9NQ1OtQOqbA7TgxY1qxF1KMm/7cuDpwmdoQFuWqcnLzHXLVpI
 ehLOGzj5TbJoK8HKZ+mavsmdYzja20Rt7X+XcVrgmCwA0sDlgf8ENlzTMGgcivGv7HZ0kpq3l5P
 2QaIvK18sXFkmumMDrUqQCC1fTgZfcvRh8nnTcg8CPQHzChwPvjA==
X-Google-Smtp-Source: AGHT+IGDONtp0J6nZTRzK9H2DD1QJ5+CcNMXYkRJxYRrthGWxeP1R26xNY3kSRe90kggshe49Ng9YQ==
X-Received: by 2002:a05:6000:2310:b0:42b:3131:5435 with SMTP id
 ffacd0b85a97d-42b5933e378mr4084346f8f.2.1763150702421; 
 Fri, 14 Nov 2025 12:05:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae98sm11715379f8f.2.2025.11.14.12.05.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:05:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 05/19] target/i386/hvf: Use address_space_translate in
 ept_emulation_fault
Date: Fri, 14 Nov 2025 21:04:07 +0100
Message-ID: <20251114200422.4280-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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


