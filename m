Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63A5CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mtx-00068Y-AK; Thu, 16 Oct 2025 08:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mtt-00065u-3N
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mtm-000878-BV
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so3522175e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616954; x=1761221754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+6gexP1/asyF00baE5jYVsYkot+6QG6gZHm7RtPxrqk=;
 b=gzOLpQM3TzNKfu8nV3j29WQMhA7GzA3GqJVID+8p5efCIw7Tqwit6RC88GvpbOPJQn
 jBSKSGBvj4N72SFsMOYehTXMZzquTewoLTxg2vRAskNQ8ed1fk6+CLG+ged9gOZtBnj/
 lF8jM253mupv2szs3Vg8KarFo6eeTOFWvQjQBGttly/h8bAVsaA5vopN1YWaBr9SCcAz
 COsZ/NETCihqyZ7T/r7ZwXWp1ly+ZRiv4bW1PgdOwTs4xtYmVy5CZePVVGOWOC7wVLxx
 LhjKOdmwtiwQT9zLWpY4KyVndc/MIk4351rOL9nFM894I4UfG8OhB9y5qhiJ3/OWktpi
 AsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616954; x=1761221754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6gexP1/asyF00baE5jYVsYkot+6QG6gZHm7RtPxrqk=;
 b=jwajNebsACVwphP6e8kvwXiQtziHRLF4VFrXzb4ya7GrpbAhnfz54Evfc/2GpAA3El
 FQRZjGwF19//bDAT3MBsb6fVzY6Lt7zxzY7I21EKGpv5FMBWeeVcY7RSz1IN2Q4lz2dt
 XwVTcNHLbrH+LaVNomh620F4XYpBtwFCx/wSCryNoexg/r13fqWE2tqARzLKvw/wpnSR
 ButXvWgj/NLNXJ1aVS18xBzoCXG7gelmbY3eyuupsA5AzVaeF0eaifGnIPLwWdLf3HmW
 tz+0KQZLZPUZITL+HBsReoyZEQWOgcsLEkL4L/D7L3SWk+/vaRSEfUWqkIi7jio4iP92
 UMIw==
X-Gm-Message-State: AOJu0Yx26emPZ/zLYXxD4DcUFmlxBPZh1t/jwKcsSjC+g571GxcQ4J6U
 ZYH36yeut2YigJ5GHjkXbRmbjUxbK81pxAFmZIWksmsIggf1px9gCaty+2HNU/9X37f0rN99z19
 W3j1A8zE=
X-Gm-Gg: ASbGncvQwth4X76VZWB7o+BuCT3Bkn0QW/4XCmsfq+YCeK23b2ppSkTNCcysWstzYVy
 QbNarhhhfHZuCm+RiXkRYfrCPQkQQR9lCfh/xtHCYjXuehQLgq5XJ+1K4KiXmmzhkSJvuokwMh5
 oC7OIIDl8KZTpfE2ZgiP6F9YrKyq6YHi1xDer4atq7tHSRspbuIhI5KfO92UJOl5bDckYCUTQd/
 CYiHhItqTstdljsDzO5Lx9jXc5uL4h5k0VMti1cazVf4Bv2+umtmLEUMjFxtG/Cs8FcpmwnRrpZ
 vL2LoF3uALBKE9krLqAvtymsbwr/T7LPNU9fEdXOBzK0X3tANs1gtnshN4s6nsgmek5b6pWhc0z
 rxnO5yqQ+Q9C09HF6Bb4NKqgiG/8v3vH7kvvCqEh9WmGK8oJ0L8MCnsOiKWkjvUxpcA/XleOQ1/
 kPb39xM5Axqptn+IJukdQ49B+FxsAM4GicfaabolZk6IbJwQ7iviaIC0AIOUFV1+KV
X-Google-Smtp-Source: AGHT+IHzxNPaHE6Gg5JxivvSwS6YHLN6OEfHh6wMt74V0k0wONNY0z2cdQVFF66ZlSQVvmXPFlZCZA==
X-Received: by 2002:a05:600c:524c:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-46fa9b08f16mr251343975e9.31.1760616953748; 
 Thu, 16 Oct 2025 05:15:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c831asm21912455e9.13.2025.10.16.05.15.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:15:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/75] target/hppa: Use hwaddr type for HPPATLBEntry::pa
Date: Thu, 16 Oct 2025 14:14:20 +0200
Message-ID: <20251016121532.14042-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
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

HPPATLBEntry::@pa is a physical address, use the appropriate type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009101040.18378-2-philmd@linaro.org>
---
 target/hppa/cpu.h        | 2 +-
 target/hppa/trace-events | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 672ab3750c8..869a75876e2 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -187,7 +187,7 @@ typedef struct HPPATLBEntry {
         struct HPPATLBEntry *unused_next;
     };
 
-    target_ulong pa;
+    hwaddr pa;
 
     unsigned entry_valid : 1;
 
diff --git a/target/hppa/trace-events b/target/hppa/trace-events
index a10ba73d5d4..01761a4559b 100644
--- a/target/hppa/trace-events
+++ b/target/hppa/trace-events
@@ -1,13 +1,13 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # mem_helper.c
-disable hppa_tlb_flush_ent(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%lx"
-disable hppa_tlb_find_entry(void *env, void *ent, int valid, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p valid=%d va_b=0x%lx va_e=0x%lx pa=0x%lx"
+disable hppa_tlb_flush_ent(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
+disable hppa_tlb_find_entry(void *env, void *ent, int valid, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p valid=%d va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
 disable hppa_tlb_find_entry_not_found(void *env, uint64_t addr) "env=%p addr=%08lx"
 disable hppa_tlb_get_physical_address(void *env, int ret, int prot, uint64_t addr, uint64_t phys) "env=%p ret=%d prot=%d addr=0x%lx phys=0x%lx"
 disable hppa_tlb_fill_excp(void *env, uint64_t addr, int size, int type, int mmu_idx) "env=%p addr=0x%lx size=%d type=%d mmu_idx=%d"
 disable hppa_tlb_fill_success(void *env, uint64_t addr, uint64_t phys, int size, int type, int mmu_idx) "env=%p addr=0x%lx phys=0x%lx size=%d type=%d mmu_idx=%d"
-disable hppa_tlb_itlba(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%lx"
+disable hppa_tlb_itlba(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
 disable hppa_tlb_itlbp(void *env, void *ent, int access_id, int u, int pl2, int pl1, int type, int b, int d, int t) "env=%p ent=%p access_id=%x u=%d pl2=%d pl1=%d type=%d b=%d d=%d t=%d"
 disable hppa_tlb_ptlb(void *env) "env=%p"
 disable hppa_tlb_ptlb_local(void *env) "env=%p"
-- 
2.51.0


