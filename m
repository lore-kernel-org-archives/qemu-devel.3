Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C7BF8DFF9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn3E-0007bL-AU; Fri, 17 Apr 2026 13:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2p-0006wZ-8F
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2k-0002PP-FK
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so12499885e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447107; x=1777051907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ke72IjMhlpeM5Zph56TJ0UtJ9eIRtrZU4oDNR1sGd5A=;
 b=X8/EfE1tcMCNoNoLdfVhmwa7QL6z5dUIkuyhfAc/DGNdG+cMh9sxgUDFwF0py0amfX
 sQ6pV2cBh6zz/ImbudwBblPGZZ+ed52t3vn/ecmiQY52UkrAqpe9JrpzVTEhWDE7HgJR
 XGXVQCyZxruOA//M1DFYnADluPnBDcRJo4eu0y0RI2oRClEB6af0xbQz3EOR2EivDsWv
 dxaSHa0ZzvfOqQaqRXyKMjQF97bvkiQRE/eDhZtk4176p+iPnrxt0kh580j/OLxErQD0
 SpWeYObNEWmc0XWtnc7pWAH2+JY5/kucTwqRNqVDQV9lrWj+VQtNNhDX5jBIcVkWIQXL
 3o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447107; x=1777051907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ke72IjMhlpeM5Zph56TJ0UtJ9eIRtrZU4oDNR1sGd5A=;
 b=ZRZGgTl/lx8Lk1CK0gU2wzH8DodtcftuT67GZthLT003AXtRWon8DgmS7xxsLQM+HC
 Z2iBsHQIU8K9UPUOjsdWYQbnuO9dl0zivy3mtsV0t9BeuNUCDXeaCMzsKQ6G4caMq7sq
 pbaNvrTaqr+f0cZdBxrtm578S9jc6GZsyftvxpWjrB47PneLJwtvSFwtA4pHP3q2VwB8
 wJimh9iqwdAhpUkLV3cP5ZdW73Hpnj1+o5Tsi5eHNbmAJ7C1il+5NTBGpAy0eH1agfV9
 3eGnH4rdSojZ2GCr/AjC5zyPyIOWE1M8cSLTlwQm53kWrOQWq4abdEMJ5EpmOEQdpZ18
 nOfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kh9eRAqnJieHWEHuUv8eTpI/EMveakHUOLJ3uqCdSpmQFzs9Mkvz+30zEOWXKlP5tdzf8B5pXuHea@nongnu.org
X-Gm-Message-State: AOJu0YyyPtfdA+4P6ppp42Q7mOyEwtCGgqnUM5m6DBpU2yMPhhNuPVd9
 9yzRrdL9pwqFLdHDRvHxoUTgcNHAxk8hUjZ83oeM2etNaqck03CKE1XI4c3Z0Mytkro=
X-Gm-Gg: AeBDievcriOtxvYl1wCEpl8qLfKEZwX/BzatjtubcX+d69A/p2nLKyq0AEvEgdNKd5t
 55uFufYiu6hNyjbvltO1HjRxO/eB5tdhCh7YjHnTja0cJbPLZzVMS5gc33Cj0NsP1Vi/4M4sMss
 8e6TBMh3TqRcYGliH1622+rSuDZwvJvVNzp9lucori6LF21uqgChtxN8B7dZNtixHWtUe5piA6I
 v2kEGOjQzj9IS+nael4oSMgmKQvf4xL9W2E7ujvzVEvkaFIdXis7DbiXqw498BpZ7hm8u5KWRWk
 b4j67c4QTWoLpy51FJvDOR1tpWGCgt+o3PEBsxIv7AqMNDtCQfOACogctAI/yfflQQqu06f+ETS
 t73uTSlMehnhJxU6jF4coP8/Dt4slSkIuHEoAeNdAPeR/Ipq9JWOiqxcOX6lH8/cb0OOTSLPOxA
 c6zQvkdkrBJdUMGBStdylK467ZT8KH/JlBVBGZSEm884cWwmFDiSV47L+r9QzbnIAtzf08fky3D
 YtglA8yb+BEnMYu999HCLdG0vUPGk4Jj2K9T8PSsg==
X-Received: by 2002:a05:600c:31a9:b0:489:95:3dd2 with SMTP id
 5b1f17b1804b1-48900953e9bmr1952275e9.8.1776447106681; 
 Fri, 17 Apr 2026 10:31:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 17/17] system/physmem: Use translate_for_debug() in
 cpu_memory_rw_debug()
Date: Fri, 17 Apr 2026 18:31:05 +0100
Message-ID: <20260417173105.1648172-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417173105.1648172-1-peter.maydell@linaro.org>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently cpu_memory_rw_debug() assumes page-granularity for translations,
and it works in a loop where each iteration translates for the vaddr
rounded down to a page boundary and then copies up to the end of the
page boundary.

Rewrite it to use the new cpu_translate_for_debug(): we no longer want
to round down the input address, and the boundary we copy up to is now
determined by the lg_page_size it returns rather than being assumed
to be page-sized.

This, together with the implementation of translate_for_debug for
Arm targets, fixes the bug where semihosting would incorrectly
fail to access parameter blocks that were in memory where the
start of the 4K region they were in was inaccessible due to MPU
region settings, even if the parameter block itself was readable.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3292
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/physmem.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index f2d9a4ff8f..45c3a926cf 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4036,28 +4036,38 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
 int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                         void *ptr, size_t len, bool is_write)
 {
-    hwaddr phys_addr;
-    vaddr l, page;
     uint8_t *buf = ptr;
 
     cpu_synchronize_state(cpu);
     while (len > 0) {
         int asidx;
-        MemTxAttrs attrs;
+        TranslateForDebugResult tres;
         MemTxResult res;
+        hwaddr blk_base, blk_size, l;
 
-        page = addr & TARGET_PAGE_MASK;
-        phys_addr = cpu_get_phys_addr_attrs_debug(cpu, page, &attrs);
-        asidx = cpu_asidx_from_attrs(cpu, attrs);
-        /* if no physical page mapped, return an error */
-        if (phys_addr == -1)
+        if (!cpu_translate_for_debug(cpu, addr, &tres)) {
+            /* Return error if no physical page mapped */
             return -1;
-        l = (page + TARGET_PAGE_SIZE) - addr;
-        if (l > len)
-            l = len;
-        phys_addr += (addr & ~TARGET_PAGE_MASK);
-        res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
-                               l, is_write);
+        }
+        asidx = cpu_asidx_from_attrs(cpu, tres.attrs);
+        /*
+         * Clamp the amount we read to not go beyond a page even if
+         * the CPU returned a larger lg_page_size, in case this access
+         * is to a memory-mapped IO region.
+         */
+        tres.lg_page_size = MIN(tres.lg_page_size, TARGET_PAGE_BITS);
+        /*
+         * Find the length in bytes from tres.physaddr to the end of the
+         * block whose size is 1 << tres.lg_page_size; we will access
+         * that much in one go.
+         */
+        blk_size = 1ULL << tres.lg_page_size;
+        blk_base = ROUND_DOWN(tres.physaddr, blk_size);
+        l = blk_base + blk_size - tres.physaddr;
+        l = MIN(l, len);
+
+        res = address_space_rw(cpu->cpu_ases[asidx].as, tres.physaddr,
+                               tres.attrs, buf, l, is_write);
         if (res != MEMTX_OK) {
             return -1;
         }
-- 
2.43.0


