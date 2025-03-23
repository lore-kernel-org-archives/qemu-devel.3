Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F0EC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twUCY-0006CJ-2M; Sun, 23 Mar 2025 18:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twUCW-0006Bx-8i
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:53:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twUCU-0007XV-JT
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:53:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so25346095e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742770428; x=1743375228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1KHNrrY3K/vdoC9XP1C5J3isdbm5fngy1BLw2WR1DQE=;
 b=IHN92gNlFybOPUWhE5m9ug+t9B23h95LTdElgadgJLHxyA7X6YX4AnSZjhKhyhEp/j
 WT06GWC1Rc0c0p2eh4nCDv0FT6UTpD6IhDval8OnK4Xox+R2rOpaj8fYLy/hB7BoXIWA
 Ja8ur0Ux1LsBWBZznyNhzka6Zd8qpa7fEqoz6p6ilUUJsBOXq77ggm0CCxbBQf87QoqT
 NOn/SFWBodCyBmRKHkpWANKXKG6IvIDWPoSWHcm1oEis7E4pmw7vG3OdKrBytxtU2miP
 94uCKOoFyEwO+wj5MJuuaaDZ6Ceje4ELhJQm1LlmGwDUVQhFpW7EjTyfhH4Ap4Fqn91I
 ZcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742770428; x=1743375228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1KHNrrY3K/vdoC9XP1C5J3isdbm5fngy1BLw2WR1DQE=;
 b=qeaRwMJuQVg4U82EJEvhdResDh+r0dcQfwp+nIyrlieki3Vbbi/kEXsgvkanizgBUv
 2RuZuKXJOwYxlbQCNNX1qg7xsz0cUdDplHyuHx9DMu9KgojP3nepvMZj9Z+vmYUQycmU
 ZxsDUb+w0WideGWriwqIWkF2z6J1hRvWMUPoZcTic6y1mUhfIu/fo3QuMxljwfBbInFn
 3/e8ynqPLkhvMhfUej7vRHrOAuHdweq87yy6IVdvkT665H7/vVVGj2zixJqnajfWJVOG
 q7Im8WIZUNU+RM7w9fYkA8P9uTFksV/xs6CvzuQ1aWN+u6XHAHmrJ5H7C1ULGaV1AcXx
 WGdA==
X-Gm-Message-State: AOJu0YxKKlQ9Rx2i3veDPm+bpAvA7DIr5FRQ6u2Yz63B9uu/yzpBTeYi
 jksvK/kwVkDp0VAel0KjYQGtlOD5+jRL9OTCexwPy26NISHxgyxxFtBu4R0PeWK2Gkc9BFRQFTK
 a
X-Gm-Gg: ASbGncuWa8wk4WyCtI3mdQFHmx4Pu09rxkKUxJyHbNreNdZf0hSliDjVh88ZqEC8/08
 mJpmE6Vj6IGic/oOCUhr3YxFKiIm1BoEeSiVwR3VbJWVpVjwAy8R5MJh3lvrPNx2hFQToDAI1TE
 BKi+YubN6zALClxuRtdFFhxiS6YwL0NQVqPl7GOJ1Cgj9Root0dWdG409k4BLdKPRqbM20ioSsu
 thIb8U8cBDBuY7/12T+Yk12hYCbHPB54jujIcCgLnaGC+wiRJb3sf+d1a2DRK/q1lUVtoZ8Kc4Z
 sK/2dKT8fSiG4RmmxUPYmuMVnk77ymMxuZYSqbCj3Vv01ZoBV1yOCjF9b8H4BsGi3oScsCUokRF
 KdHnVTX0j0JWmaISJEBRLp9PLZSxAwPQic38=
X-Google-Smtp-Source: AGHT+IEPBbYzW9EhSAu1UAH5pmUFXrgbY6usUwdTTyhvhFvg5l/mkrO/0URdKGSgfh8qfaSh5pAEnA==
X-Received: by 2002:a05:600c:470f:b0:43c:fe15:41e1 with SMTP id
 5b1f17b1804b1-43d509e190fmr97577425e9.4.1742770428383; 
 Sun, 23 Mar 2025 15:53:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e66a7sm8977198f8f.76.2025.03.23.15.53.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:53:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1] accel/tcg: Extract range_within_page() helper
Date: Sun, 23 Mar 2025 23:53:46 +0100
Message-ID: <20250323225346.35708-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

To ease code review, factor range_within_page() out.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cputlb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b6713efdb81..91d185021a4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -657,6 +657,11 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
     tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
 }
 
+static bool range_within_page(const CPUState *cpu, unsigned bits, vaddr len)
+{
+    return bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE;
+}
+
 static void tlb_flush_range_locked(CPUState *cpu, int midx,
                                    vaddr addr, vaddr len,
                                    unsigned bits)
@@ -772,7 +777,7 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (range_within_page(cpu, bits, len)) {
         tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
         return;
     }
@@ -810,7 +815,7 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
      * If all bits are significant, and len is small,
      * this devolves to tlb_flush_page.
      */
-    if (bits >= TARGET_LONG_BITS && len <= TARGET_PAGE_SIZE) {
+    if (range_within_page(src_cpu, bits, len)) {
         tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
         return;
     }
-- 
2.47.1


