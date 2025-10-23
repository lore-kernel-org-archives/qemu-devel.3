Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D908CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBv1X-0001LY-FQ; Thu, 23 Oct 2025 09:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1W-0001Kp-4I
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1S-0006Fa-SO
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:06:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so793976f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761224788; x=1761829588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ylvuf688MxbDh+xWuVO8cCat37R7AD8jYlsTF5cm0AQ=;
 b=T8MnXXWVmPSfAi7e9OrE53jLfT9R3mYypMSt+/LQfIk3W1Hqj1JKw6+E5PqjMCndSq
 SSuhiSFhBYKzRI5IUEZwK4wAF/4pMz75TexpZangnbwNXeiBdo+t1RRGZoSO5lwSaDXy
 tnibppcXdshD8/7BnzNsgiHoUIkr7B7zW52kWzdv0a0S/rV1TKVBGFD0r8rAIYbIWj+u
 8m/bOpkxgz0x6rgF8h96iInOyu+qtZNUqh4EzorlROXqlnXHhnPXgRtIplAjIAWQhi+y
 Qh8eDmBj2o9EbTHH/u0bBQ+/sfa5cxQP48Fg/n5k+K5xjDzn4HJjVDGBBPWbBJXzv1+j
 696A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761224788; x=1761829588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ylvuf688MxbDh+xWuVO8cCat37R7AD8jYlsTF5cm0AQ=;
 b=u69papRAi50GGGGU/gBU7e2WM2O0xeXcpdfpmIWriDsUauMh9dliph7l0MLIwC9C/5
 TKStIDt8Od2Mhkz5HoCU4N9KfPu1OH7VEx+YGmKEoYDx2redn4EBxsNmxZzXxlqNihKh
 8inkXsXY6oM/HTgycvSHsxNVYAAPQjUi0EmA1EXQ3XXxUVGE+uABw7u/k8m9vu1x7E13
 tqemN73CprZX65IDIrz89QTT+fxMhtfT3O+6fSp2419qFNgWpBz15Ef1ks6BeDeHvhiD
 fic/Vs0BgoBFXs7vNIZLap87LxWu0+IiA5D5eAZOxVXRHHP9ELyhPFdBWO7/UTXbVjxq
 0Znw==
X-Gm-Message-State: AOJu0YwKjzAojBzQ34PJrlsT3RKXe+cpw8ZZ2E7o+yU47+cyUnktOwRQ
 fEjrgGgmIYULMPfjKN18Bv6DWzcYoZe+cs2kl7emG85DAvehIJRiLwSbSFVh0cuJjuPYGGWAE2y
 1SAXvmJw=
X-Gm-Gg: ASbGncsgdJTuEsGNWeHArD/68VyyJGYj7MtWD6S8WX72KrhVzsmtG+RH2HNSGAIPnGw
 Q9n5MaeoBaNdOyASHB/3UnAx4kaE0xuAvauqRzuWSqTQqG7oO4xfqYbx5tmNIw0t6+zEVhXqfYZ
 1rPWVZyymwlS5nT72ZdBqeYfNdlE59meGONTFqeMLVNurJYET61ijbgj+i9nlw/xmi9Utls/H5i
 zK+FcxtyBX8XMle9VR86a6i07Oa2XVU8GDcpnRY3QVQlLIcgGaz1KlbhATY/GOy5CIGWLakVWfp
 wVUe//p0IaRXxDNKn/lSp0kZAK8a1nu4W0Va9GD9z4D/iH2ZQ5U8qiPk9ZzegzAp2up6swGy4jy
 dHskb+ZzfDuFTnb+Zc9RCKQQxqkvwx8XKhrtqiEU1GRCvzH6rQgldCHJ9ElaDdJy9vljhehDh3S
 sQj70r6pwyDZIPC2D2AgcaumNRawm+7CVsygbmNSZfjBuN+8XDXOyJZgCkGbXk5clqk7BMxOw=
X-Google-Smtp-Source: AGHT+IFlIHkStDkPc+/dZCWHm/OnHFDELZm4R4I2b6OVBpuibq1q4sm+mLYgBd7V+O5lu8LVm7rhPA==
X-Received: by 2002:a5d:5848:0:b0:3e9:f852:491 with SMTP id
 ffacd0b85a97d-42704dcefa6mr18029303f8f.56.1761224787635; 
 Thu, 23 Oct 2025 06:06:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898add96sm3872005f8f.30.2025.10.23.06.06.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 06:06:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 42/58] target/arm/hvf: Implement dirty page tracking
Date: Thu, 23 Oct 2025 15:06:18 +0200
Message-ID: <20251023130625.9157-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Notice writes to pages which are being monitored.  Mark the page dirty,
re-enable writes, and retry the instruction without emulation.

Assert the fault is not from a stage1 page table walk.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 52 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 77998ab90a6..cf4746c344a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -37,6 +37,7 @@
 #include "target/arm/trace.h"
 #include "trace.h"
 #include "migration/vmstate.h"
+#include "exec/target_page.h"
 
 #include "gdbstub/enums.h"
 
@@ -1880,9 +1881,10 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         uint32_t srt = (syndrome >> 16) & 0x1f;
         uint32_t cm = (syndrome >> 8) & 0x1;
         uint64_t val = 0;
+        uint64_t ipa = excp->physical_address;
+        AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
 
-        trace_hvf_data_abort(excp->virtual_address,
-                             excp->physical_address, isv,
+        trace_hvf_data_abort(excp->virtual_address, ipa, isv,
                              iswrite, s1ptw, len, srt);
 
         if (cm) {
@@ -1891,23 +1893,55 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
             break;
         }
 
+        /* Handle dirty page logging for ram. */
+        if (iswrite) {
+            hwaddr xlat;
+            MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
+                                                       NULL, true,
+                                                       MEMTXATTRS_UNSPECIFIED);
+            if (memory_region_is_ram(mr)) {
+                uint64_t ipa_page = ipa & TARGET_PAGE_MASK;
+
+                /* TODO: Inject exception to the guest. */
+                assert(!mr->readonly);
+
+                if (memory_region_get_dirty_log_mask(mr)) {
+                    memory_region_set_dirty(mr, ipa_page + xlat,
+                                            TARGET_PAGE_SIZE);
+                    hvf_unprotect_dirty_range(ipa_page, TARGET_PAGE_SIZE);
+                }
+
+                /* Retry with page writes enabled. */
+                break;
+            }
+        }
+
+        /*
+         * TODO: If s1ptw, this is an error in the guest os page tables.
+         * Inject the exception into the guest.
+         */
+        assert(!s1ptw);
+
+        /*
+         * TODO: ISV will be 0 for SIMD or SVE accesses.
+         * Inject the exception into the guest.
+         */
         assert(isv);
 
+        /*
+         * Emulate MMIO.
+         * TODO: Inject faults for errors.
+         */
         if (iswrite) {
             val = hvf_get_reg(cpu, srt);
-            address_space_write(&address_space_memory,
-                                excp->physical_address,
-                                MEMTXATTRS_UNSPECIFIED, &val, len);
+            address_space_write(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
         } else {
-            address_space_read(&address_space_memory,
-                               excp->physical_address,
-                               MEMTXATTRS_UNSPECIFIED, &val, len);
+            address_space_read(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
             if (sse) {
                 val = sextract64(val, 0, len * 8);
             }
             hvf_set_reg(cpu, srt, val);
         }
-
         advance_pc = true;
         break;
     }
-- 
2.51.0


