Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47561C52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb271-00077r-H6; Mon, 05 Aug 2024 14:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb270-000739-CF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:14 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26y-0006PW-J0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:07:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3684407b2deso5805145f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881231; x=1723486031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3YLnD1bvOSagZksuJngTTm11SWw5YIwVbzELXEazT0M=;
 b=QfjR9fNn2wtc6YoJbTsfAnh71LF6GXFykA5xlRn3L9uqYusU3d9aYiMQvkCzCQLq+p
 zDKHOQEw9yQepjEwhY2ICSV5SwYL+PIIEowfs99lyMbuwYpKfD4blDRp2Fjh62q1FQQ3
 Eef3oY8K5OP3zhxSGEzB6oHyMTxASU9Gi1Yzaoo7GCIbrqgfWhnTw6QeecFXsyXTCDtX
 Qu9nls1D+tjxncnbncuXhLpMOG+BAlAuJPPxEqyN5B4Z/bxmr85ILT1c2S7nY03VmjiZ
 GKVTJ1zntDKywA7gT/M2CNnvV86vk7X7PFnphnT+eWodl2c+euPXkNcjJarmXdQJAkee
 nNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881231; x=1723486031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YLnD1bvOSagZksuJngTTm11SWw5YIwVbzELXEazT0M=;
 b=kWiSvpAyAq0fRkZwBWpHnQm4MrUZwaB0bAU2JA1Ltx/58coDxLJLDIAL9twkkXl9/e
 UDwReFYQKBtCHFz8FxIhwUUX8Y2ykEkPdjvmEzXC46nPPLOEwzFf//o9u7RG/Lek76cj
 +5f21dHClmKpTHsECskX5FEgXzVT7wAJdIq39C6p17TSBLlC8N2MQcmshi2tYO/3scie
 qv+KNt2sYS51h2HBP/bywdyyTgmewRvFh/mhly2NA/JpLRTNhHGAmbP7Ph62HwZGKkRu
 FswUzFUWIg8WpUAUWlBqVEv/DtaSEop12xitv86docQVqBSFs9hVfJPjNYMoC1jN++Ed
 FP0A==
X-Gm-Message-State: AOJu0YyoztHnMCbjKQeQqqy5VHLaO2JXHk6BEnJschL2dmfeH4Mc5Zto
 onOYaTouTZmxBfw3ccHd2k3wWKH7JibwFL8UcFN4Luws0hoizTk9+U8Jki7knlZhVBw/gNYny+p
 7
X-Google-Smtp-Source: AGHT+IGZ4/PwpNZYdsl0lQ0tszh8B129ZHIaEdjb9QK8y7/DXciHEvqV7qPKN7ZqRsnwNtEg7AGXtw==
X-Received: by 2002:adf:fa02:0:b0:367:993e:874f with SMTP id
 ffacd0b85a97d-36bbc0ecfd1mr7877810f8f.34.1722881230676; 
 Mon, 05 Aug 2024 11:07:10 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06e100sm10685978f8f.98.2024.08.05.11.07.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:07:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 07/15] hw/intc/loongson_ipi: Pass
 LoongsonIPICommonState to send_ipi_data()
Date: Mon,  5 Aug 2024 20:06:14 +0200
Message-ID: <20240805180622.21001-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-11-philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 347bc26729..8bf16f26d4 100644
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
2.45.2


