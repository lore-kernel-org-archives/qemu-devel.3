Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1719C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMgX-0007m4-Cy; Thu, 18 Jul 2024 04:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgJ-0006xW-5i
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgH-0004v4-7c
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-36798ea618bso314414f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721292003; x=1721896803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcjSxPAzKxhH+dpnOyTqicwIlTcohXs+GfUPxVSqVy8=;
 b=xWFQrn2ZO/VnM5Lz1Ld/Z1fKxpdvtWj1fugBcoKaALj1hF0ClfiZO5pA9chSJbE18B
 cFzuvWjh5iKOP6j/gUzQTcsvjdk3pAy1ualvU7poiyN47zrXR5xQATjhuHjHpuyI0giu
 WBhEULfkARknpL4O98VnCRwFo0oqd2fLmTEKsLuddxs/2pOlYFOzHKgd+x+jIegcPLzi
 /mtm4iUhQ5SmiIsitNfpwRDIh85lp/Cb1qObfLPrV/cWdmgvDhCOs+AdOcDG/na6w2Va
 gK2WhDmPLCduZR26UjwzWuOtYocetpWikHdarl0W6Lkwc3aFNj1gIrd+UQBb26HQt40r
 c+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721292003; x=1721896803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcjSxPAzKxhH+dpnOyTqicwIlTcohXs+GfUPxVSqVy8=;
 b=wNFK9MlEkODbY1nyQHP2RthJD/9t5s1/6NhjZKZBqX4GEg0nYTXo9+dgSAXKnZ7aoH
 Fvy3hkJSoE2KYyGnaPFkoxYI2XmcaNQqOMdnIGRNrg38LE2nlN2wxnjWynS1SjRXPu5G
 lNDEtoeEym0juKTuygjzIgnzFq0yoLLkjel2XZlzQQU0wQy8HxQm9SPwdA4s57+UKmO6
 xO1SNdVWndwoFqB+VPPhz/dmitGByKT6CBdglCjv9eixVgmKjdSyHX14A/UOrU9luMSR
 cfPWep/2GwdBq64wskZ4MKFsF40Y7UdeGWiIlzyfiENCq89ymV34LYjmh1FohNeP+9o1
 kjIw==
X-Gm-Message-State: AOJu0YytpxkdN37ZJlR4j9lRt7MhpBMIPVkujyWvfmL0r7O1gPlehVIe
 EVznkmvl7cpnBz+AOq4UQcI7UNCtRry2TKQrNMyJ+KO/v9cBA/8cFCaC6dhscto2h1mPPJF3o4v
 K0/c=
X-Google-Smtp-Source: AGHT+IHuV22C6+fJaoG0llBEQeHcNHs2XxWaHI8+/Ctl1xgFfoHiRcYVDocU6B5YfSMRdW+tQM0C4A==
X-Received: by 2002:adf:9b86:0:b0:368:3f6a:1dec with SMTP id
 ffacd0b85a97d-3683f6a1fc2mr2024381f8f.9.1721292003209; 
 Thu, 18 Jul 2024 01:40:03 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccad8sm13651982f8f.60.2024.07.18.01.40.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:40:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 10/18] hw/intc/loongson_ipi: Pass LoongsonIPICommonState to
 send_ipi_data()
Date: Thu, 18 Jul 2024 10:38:34 +0200
Message-ID: <20240718083842.81199-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

In order to get LoongsonIPICommonClass in send_ipi_data()
in the next commit, propagate LoongsonIPICommonState.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongson_ipi.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index f3d1f031bc..a54db87638 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -88,8 +88,8 @@ static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
     return NULL;
 }
 
-static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
-                          MemTxAttrs attrs)
+static MemTxResult send_ipi_data(LoongsonIPICommonState *ipi, CPUState *cpu,
+                                 uint64_t val, hwaddr addr, MemTxAttrs attrs)
 {
     int i, mask = 0, data = 0;
     AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);
@@ -119,7 +119,8 @@ static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
     return MEMTX_OK;
 }
 
-static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
+static MemTxResult mail_send(LoongsonIPICommonState *ipi,
+                             uint64_t val, MemTxAttrs attrs)
 {
     uint32_t cpuid;
     hwaddr addr;
@@ -134,10 +135,11 @@ static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
     /* override requester_id */
     addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
     attrs.requester_id = cs->cpu_index;
-    return send_ipi_data(cs, val, addr, attrs);
+    return send_ipi_data(ipi, cs, val, addr, attrs);
 }
 
-static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
+static MemTxResult any_send(LoongsonIPICommonState *ipi,
+                            uint64_t val, MemTxAttrs attrs)
 {
     uint32_t cpuid;
     hwaddr addr;
@@ -152,7 +154,7 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
     /* override requester_id */
     addr = val & 0xffff;
     attrs.requester_id = cs->cpu_index;
-    return send_ipi_data(cs, val, addr, attrs);
+    return send_ipi_data(ipi, cs, val, addr, attrs);
 }
 
 static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
@@ -249,15 +251,16 @@ static const MemoryRegionOps loongson_ipi_iocsr_ops = {
 static MemTxResult loongson_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
                                         unsigned size, MemTxAttrs attrs)
 {
+    LoongsonIPICommonState *ipi = opaque;
     MemTxResult ret = MEMTX_OK;
 
     addr &= 0xfff;
     switch (addr) {
     case MAIL_SEND_OFFSET:
-        ret = mail_send(val, attrs);
+        ret = mail_send(ipi, val, attrs);
         break;
     case ANY_SEND_OFFSET:
-        ret = any_send(val, attrs);
+        ret = any_send(ipi, val, attrs);
         break;
     default:
        break;
-- 
2.41.0


