Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64244FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrH-0005Pr-Vx; Thu, 30 Apr 2026 05:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINrB-0005Ac-KW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqy-0002kL-7m
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so6808405e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541916; x=1778146716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNtoNR8zwSaxp92UruVR20bb34aPvKjX5U1Njv0t9eU=;
 b=dwHdPbSmuiYdOi55FdKawJhr7wyiK4UdY2WY2ukR6+CYKlEHqzbx3oxi6lqwuDU6bB
 t7f7Ho0zNHAHBH5u2JP5p11EZMlg+L28lW1ZyYDPYEogmiXuGs9bc+XOMryBYsgNiv0T
 1CTErAMovwkLuySD1B7vgf8MCKtkrBERt2F82xOX1UGWNp+FWs+5CwUHgTf5rIiujp41
 vY1a0AKs7YJwk6Wbz1wQxV7i4znDUCuWtSZFyvTCmGEDxQDEM3A6Lr41SdXQqiLw98tD
 dYsVGMQYabqRPEAtGn0XDRXaHQGswmXOOrH2i4xAQR6HDt0R2ZKLF9E/QVEBZ0Y/cHy/
 6dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541916; x=1778146716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZNtoNR8zwSaxp92UruVR20bb34aPvKjX5U1Njv0t9eU=;
 b=p6S/vNgsz5F3gIHBPj6TDmvwzOlQUooKKYEKg/PHpuO+4Dw/IjSj578p96lQDVvOh8
 PDvC3qwdB75VppWqnNjYWY4ZogAA/EN0cP60Rw1huPLaXT6Lz6/g6HeZpS2edH4cNyM4
 e6ETIp1vBFRw0rmD5H6owlhsQgilAZiTby1HSwPHK2TF+2nF4uxqsD2ggs7G0q1ek98L
 hRikmE7ZkF+waQHewiwJNsLsJhITWckNTTBL7qw846TEFEDpYUyl1OEU49Abnq4/cEkr
 oQ2P0RyfYwmLZzkWGMN2A3ioAXB/wPSSO0eGCZj0lPi/T4aPf9m6e3yO4QOC5+1fr+R1
 T76A==
X-Gm-Message-State: AOJu0Yzh5QI3ErSQclq4oKISgLbP0gAuvQ0omQB87C+0Bg+0Xmg/anxi
 LnLC7X5WiUwovjrDcBEaNjJ8wnuCuk+56lFXid7pI5LtrAgjqi9TVjIfCYsCYygZ9iXR3Pkpbbi
 2H/QK
X-Gm-Gg: AeBDieuajgj3QwvECA72OZWZBPgMqknQqa5NrAB7DgcU241zGDmIbT+dh8SioiiwqpT
 hI2U3zYxiZd9lHRgzyV8p/S0aKWuJ8B/waJLMlEvbuxTfjI5By0BCnrfRkytIdmT801PjLjkCbK
 k59JdStqX0vm5U2sVTpRY/8miH0UYrEyPZDSMmy9FpVbm21hCu2g/32Oi5mWqQjb+zU2vXBZrqw
 vUS9N4HLozlZAtkrOowS2BfnNKjE67sP3yMUZ86+dmL0cxisn60tlyQWirDHQ3UWnydgbJDAKUP
 Bws9G825j72wTtzhfOQSpVK4sorca4V/Q2ceEOlwHbMdyouaj8DyCRQbpQmG0gx+LUSyZ9CSVun
 xymJnO/UhbdAMWoPp3Pcb6LuQc2HvMmWp12zdrX0potJBcM8mAwQKhLRQT4GR80cldRCJTBmybg
 ddcr5nN8TiJ0ZizZXM5fteopo5HF/VrlBdpIM2EnaOna8ME37m/LSHWfdKiPba35ll7InVUg6S2
 0BcCGhVX/FLPWyK+NqBK80N2PQOpBm883w1BnkJEQ==
X-Received: by 2002:a05:600c:4fc8:b0:488:ffad:6728 with SMTP id
 5b1f17b1804b1-48a84451ac5mr37835485e9.19.1777541915355; 
 Thu, 30 Apr 2026 02:38:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
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
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 18/25] system/physmem: Use translate_for_debug() in
 cpu_memory_rw_debug()
Date: Thu, 30 Apr 2026 10:38:03 +0100
Message-ID: <20260430093810.2762539-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Message-id: 20260417173105.1648172-18-peter.maydell@linaro.org
---
 system/physmem.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 652b03ad5f..7bcbf87573 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4030,28 +4030,38 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
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


