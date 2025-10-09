Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B332CCD18C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nbu-0005Y7-CD; Thu, 09 Oct 2025 06:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nbs-0005XQ-2Q
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:10:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nbn-00078y-R4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:10:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso618252f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004647; x=1760609447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eje4YWkqKgg8NBiuIwNMBnlRUEmEtxWTgD+7Ffa7cA8=;
 b=dbwntN8ktMuD74Sp3dYdB2QrKPc0OOzJI8JbB+qR4f05w/o2FrpU7gdSl2AheiwapE
 2Np0ngHVAbNYnsNU4JtzZ/cQdtIzroE8bR39uI07nhwpuaAE2Gee6Thhp+8aytS7VYfH
 cJpvyUo9otvLs8fo8zEH5lOCkfbe6UAUBRfO5avmqyehjV6+hP3JblRZyoMSbcrIIM/v
 7cb7LfpEFtJdeXW0ol7EiZFdCQV54luH/ndjCs35/MInxXy3Y1GcOGltEIenvjFFmR87
 qyK0kJWodokwRbNvNScgRXQGP5YmXhrZFouShE7UhWxuZltAMR9UFUyT2CMChFJCtr/x
 ZYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004647; x=1760609447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eje4YWkqKgg8NBiuIwNMBnlRUEmEtxWTgD+7Ffa7cA8=;
 b=u8IirkduflbbCHAXLKJQaJe0BW/dV3hW5lwSZJQKLhDHCWN2aGT2p6PwtF+dgWp9wE
 QGh1E1ERwZNV5p2JA6AV/i4zi5M3za8iaJflVErpnb7TzvLpNQUGpedARzp9WpUraGzU
 q3RIxohN9dj1QUyHkNzRKiSLku0Y9Y4tFuJy3r/MW2m+S28i2B2NqY+QEJw28THKgcRF
 Q0GgbUPBu/cepl3IpwTwTNb9NDwCHpnkElJYDmBv/wuE1YVtpjnwSmIRw8reSBGYTW8n
 wpAqy1JEJIWRYT3+ceDght9hDq9AMZIK2Bc+SXZvBlbrFPe80IjbZlGJ4s34IzS+jLKg
 U9/A==
X-Gm-Message-State: AOJu0Yy6azrTQbWYoxJBHOnqgifO/bfcQuK4k9v6s0KgC5jyClnOXGdv
 KoSh+a5KgHpENXCtG+Dst4TZJ5RXvVd7SkcYkjJh//9B4j8lF2Y/vfuv1Vm8WFY6hbKYXwsj9O4
 fTAc5T3QB/A==
X-Gm-Gg: ASbGncvjpwG3Wl6zP8BAZSO56hDWjH7tXf5gODv8quxXbSNB36smwv4DnLZ9a/Mr7w4
 qwM/T/AAL6cb2K6qJNoLLhONy4N9YujL6giLtdIULablVCl0QKO/BdNrXjTOuuUBuAh18vaH46Y
 r6a33JqIkJfp9u3qmwo1fVNq0prDCOBGPoFUOoXxKUm1FmS2bDUeSWTJfnwrKC+j4cNPoZxUJsm
 R5zPgWb8ry1LhMBqJ2kZ8apZqRI3fHcUupux0gODiGilyrjEpDKpOuNMJppRJYLSTeExvRainUX
 i8n/B0oqiADfq7TpxIYhMlO8Za9Hu+CalfWJ4mcmf/Q4mFBucTeF6xpQ8kb8EvdnPshlFEl41Aj
 RZulSIotm50oUj1nqddjstVxX3T8d8yi7VgGb9tvnCTY4h9xy/8fATPgPWThMLHqCNGqvpojYQ1
 IQsD9TvG+pBIB8sNi7YneNvNiD
X-Google-Smtp-Source: AGHT+IGrWxnOWaQi+NZYGYjo8hXLvScl3QI1rpdJZKjsOXDuHr7XKG3BK+48NHwTvUnjahU6wbaq/Q==
X-Received: by 2002:a05:6000:4210:b0:3f2:b077:94bc with SMTP id
 ffacd0b85a97d-42666ac4119mr4038348f8f.4.1760004646619; 
 Thu, 09 Oct 2025 03:10:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab6343d1sm33423735e9.8.2025.10.09.03.10.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:10:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/9] target/hppa: Use hwaddr type for HPPATLBEntry::pa
Date: Thu,  9 Oct 2025 12:10:31 +0200
Message-ID: <20251009101040.18378-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
References: <20251009101040.18378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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


