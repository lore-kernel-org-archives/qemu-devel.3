Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5548DD47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghrQ-0008Cy-Ok; Fri, 16 Jan 2026 06:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghr8-00081S-0L
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghr6-0005pc-Da
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso12969075e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562343; x=1769167143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aaDCuoO92f4Vf69cn2iypqC0aQgUpS+QpOm8Ne49+7s=;
 b=ZOjrq8OB+PkYF6eWi0RpsIpflXFmSDvp67U7eYuCa2Ld5e3cWZ2Oca1GL3AKlDhGaH
 xjoTKZnBuUZfxnM6xcFxOs94To2LvN/xxYsnfkayo13KoszrPmonRpwP8Bc8bIBA9Unc
 svKFundAKi1TJrBrrmdRRFaFiRMK+31mF8dVtDKYxxOPuHEMKweF+y2GwOHQy8yyjtvn
 9AYld2CDojvXDHCTBpoI6yGGgNKYlFOFhEeU9NoHfa2Tfi6ELwolMrJp/AIKu1W+smC/
 CwCy9vN6BB7PXbgukyOSeL113R+7E3unYi1+G9UMPrpKeScuCLItmYyCUvFn/JQm0+zm
 uLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562343; x=1769167143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aaDCuoO92f4Vf69cn2iypqC0aQgUpS+QpOm8Ne49+7s=;
 b=r1+4F6dAqQuFQEjabAga0S8EVwmoS5pbKT0v/t2D87/jvM8bS7foalq4F1E0A5JJku
 FbvGstllYVCbSzTeps86iSO9ZfbUJm0JTEJh1SGvjJ16pZgWMAihPWXtSbRHv45iNqMU
 xUW1dSv0svZgzjEk0fbwBcn7XEJJfLlfbZBH4ALK/vADIEhp3rcJ+8NuLEKmyPC/QODn
 PSXm8J1eb+3FK6X/oAWQzRug2RVFdn38QpTsHISmOGe3xlUB/VmpSlAVH8j5LdmoYMlw
 iyzReHn5TnZcWh0+tB7ST48DGnCasFI0ACuxBxMapC2TIucXSd4WBLdf7WjkUO6e3rKb
 1eyw==
X-Gm-Message-State: AOJu0YzW8X/BKf9sSMZ7kVz6wlVFdaE/nQBV4R1xorp/+nz9gA80i21/
 VGXuMzVCSItoiZ59yMDEGplJZDYgZillpdVFPqtwu7W+q8Jtbbm2ynHb2QMy9wCcJ9325DX1UrB
 FA4Pt7ZI=
X-Gm-Gg: AY/fxX484biZMuIN6kqGGJbos7oXLiyyp4jfuCTivIeDL2UcoiknKKcE1N2GgJOXDmZ
 LfdYRhQk7SWcHkgar6SLFsTA9esWxtN5nH4pDCRDoQcOoHrViZUTggMa0LkZyQ65qUiYfn3C8XX
 GSWvvh+qy1LkKICzrmlnCMq87nPx0r4QC0wAMmvr62y0hYyLDPaWgTAKcHD7K26tOQWI3pPJ4uH
 zaGO9TGzf3IfqcJkvbBwH1uhFNt+dVxa3rqMG0NL/CmtJVM5T1uCVjsxGGOyznQi7VO7cSxYP5k
 SQjlE25zM2Z/KVtrwpEaC/9zWxWZQ09JaAscOTRScEJAwI6tm6eFEvsxYb0jVDA7XVHnUDusU8b
 H8o1L1/TAPw77OAfbnwJykhLt29eeb/jWfnlZ1os18PCsVK2qUuajdyGn+KxGyRuZ7nQBl+7iBv
 dUyAt2im2KlCb+cjYZOdhb0pCqQRUi5dH4swnEOW5K8bsylJEnDp1ERGoP3eTx
X-Received: by 2002:a05:600c:1d0a:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-4801e343051mr35811995e9.24.1768562342598; 
 Fri, 16 Jan 2026 03:19:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm4696524f8f.32.2026.01.16.03.19.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:19:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/30] accel/hvf: Create hvf_protect_clean_range,
 hvf_unprotect_dirty_range
Date: Fri, 16 Jan 2026 12:17:45 +0100
Message-ID: <20260116111807.36053-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20251103101034.59039-2-philmd@linaro.org>
---
 include/system/hvf_int.h |  3 +++
 accel/hvf/hvf-all.c      | 25 +++++++++++++++++++++++++
 accel/hvf/trace-events   |  1 +
 3 files changed, 29 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 3d2be4092ef..5a57691885f 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -89,6 +89,9 @@ int hvf_arch_get_registers(CPUState *);
 /* Must be called by the owning thread */
 void hvf_arch_update_guest_debug(CPUState *cpu);
 
+void hvf_protect_clean_range(hwaddr addr, size_t size);
+void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
+
 struct hvf_sw_breakpoint {
     vaddr pc;
     vaddr saved_insn;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 77f4e4e4f30..741b4bdc4fb 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -58,6 +58,31 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
     abort();
 }
 
+static void do_hv_vm_protect(hwaddr start, size_t size,
+                             hv_memory_flags_t flags)
+{
+    hv_return_t ret;
+
+    trace_hvf_vm_protect(start, size, flags,
+                         flags & HV_MEMORY_READ  ? 'R' : '-',
+                         flags & HV_MEMORY_WRITE ? 'W' : '-',
+                         flags & HV_MEMORY_EXEC  ? 'X' : '-');
+
+    ret = hv_vm_protect(start, size, flags);
+    assert_hvf_ok(ret);
+}
+
+void hvf_protect_clean_range(hwaddr addr, size_t size)
+{
+    do_hv_vm_protect(addr, size, HV_MEMORY_READ | HV_MEMORY_EXEC);
+}
+
+void hvf_unprotect_dirty_range(hwaddr addr, size_t size)
+{
+    do_hv_vm_protect(addr, size,
+                     HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
+}
+
 static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
 {
     struct mac_slot *macslot;
diff --git a/accel/hvf/trace-events b/accel/hvf/trace-events
index 2fd3e127c74..f989da59492 100644
--- a/accel/hvf/trace-events
+++ b/accel/hvf/trace-events
@@ -5,3 +5,4 @@
 # hvf-accel-ops.c
 hvf_vm_map(uint64_t paddr, uint64_t size, void *vaddr, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08"PRIx64" vaddr:%p flags:0x%02x/%c%c%c"
 hvf_vm_unmap(uint64_t paddr, uint64_t size) "paddr:0x%016"PRIx64" size:0x%08"PRIx64
+hvf_vm_protect(uint64_t paddr, size_t size, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08zx flags:0x%02x/%c%c%c"
-- 
2.52.0


