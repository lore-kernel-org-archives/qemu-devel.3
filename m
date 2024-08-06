Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5343FC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJgG-00076D-JW; Tue, 06 Aug 2024 08:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgE-0006zM-SD
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:46 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgD-0008T4-58
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:52:46 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52efbb55d24so1039430e87.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948763; x=1723553563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTxS6tVkh4S2hExOyR5WNEzapIPqKrrXzfqzZq+lw00=;
 b=JlzTNEyxf6eGLFfVQaDV/WIm+06jTFdjVgNVy4jQcT7AdA1ucBTdKzu2/gGWT63mHF
 qoWL5I7fjx7J3QKuYiQigtqsGmxryqt3jhIqZVliyT7LXQIt5avdnq2lHmL7EwPmhkDX
 MLPDoCUFIDg93BEJAHSh+HcPOLOxhHPOyqOOEvkfFYbFKOXhQ9zO8WK/Bqy8i08wovhu
 PZmtyIZviogvRmqFYq1edIodfXRx+sdYro9ilS40PA7p8wOAnn6fjtVC74dEEr0xTgxK
 3hvjqjfH/G915qP9VKk+0ENGfQJxEQ5JzvbLzthMYhqZQMb7yQP+TaMwTU8u5gi2npav
 oRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948763; x=1723553563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTxS6tVkh4S2hExOyR5WNEzapIPqKrrXzfqzZq+lw00=;
 b=QvHKoST3lZdvrFIVm3XGl1z3UC2LwlqnwgI58keSBiUHPij2wFDxZzlKt3lOY0HKGc
 6n5fCN11zb/8ELrmZxdmrjbZlVhPvaHAFx6zQ+kKMEbx0BSjg/SJkLv0tFv4hRhjZA5v
 dqKhyp8NcJ1Y1RrK/Eaum36CV83Jmsr90OlZdnBQWX5os5rPpKNvfggdWjRIr6Z64Vp/
 dXSGTKaReO+PE98qoSVuUjvhwq53Gn+IcVjU1F3jp5Zmz673CLHuVHnICN+POHO7Gnou
 ZxIFIWcSqmcJbmAVVSiN1G3ALNeU77LdI9p+VXvgFTj32hZQEvL8VY3yYOwagTzQ6SaR
 mAEQ==
X-Gm-Message-State: AOJu0YztEzsEmj43jHnpx1Qesbu1QKCfKftYyxCJdjeuZQKz9NScRGjt
 81dM9suXXd+3r8TQTCJKV8eOACC1JF/mivdMcF/mjI/yhCEK6uQ05eBIMwyFSJOE6KevhMcsGtw
 5
X-Google-Smtp-Source: AGHT+IGKF47uGF1tAQN2XYt9SevDhmcCU0dznHeowWVghcLolefA44GVYZ0+Gl6SQzwWZVgsvb0NYA==
X-Received: by 2002:a05:6512:4020:b0:52c:deb9:904b with SMTP id
 2adb3069b0e04-530bb3b46fcmr13250092e87.38.1722948763035; 
 Tue, 06 Aug 2024 05:52:43 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e83ec1sm545106766b.182.2024.08.06.05.52.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:52:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 07/28] hw/intc/loongson_ipi: Pass LoongsonIPICommonState to
 send_ipi_data()
Date: Tue,  6 Aug 2024 14:51:35 +0200
Message-ID: <20240806125157.91185-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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
Message-Id: <20240805180622.21001-8-philmd@linaro.org>
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


