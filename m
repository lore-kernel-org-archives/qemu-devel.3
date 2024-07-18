Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC88C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURH0-0007P2-M0; Thu, 18 Jul 2024 09:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGy-000729-1V
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGw-0008UV-8B
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-36796d2e5a9so543759f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309653; x=1721914453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+d32bSTeFzLqie/ZHgjHuDft2M0Gh6Zwili0PkILqk=;
 b=B4jEpgXxmCIguxsABkkL8mrXmYXeZEC6vPRq+hH7I+r90/YGM/c55hIMvok6FIcFg2
 Iy3TTDUQFNV67o3bGER9j6TANaoBtDNKCvWkGpqc8B7mIMqDoJ6U+fvGJtWsG6IdL2up
 lzdBd53Yo+21YlDqfWdmS3x5F0a1LOsIdOBMEHGdp+kZiYQLyr4Ndyz8sx5VzS2CvbPY
 fFNsdUq6uTCCRmnubXzqcVrmf9gSqP3a5lenNZv5w46Ll+OeJhnnyJwo2xKUS5/GwHjc
 fUd/JpQIVkbn/71VKnWbBF9N6X6fduhtkGS60Eqp2GdU2XIqWm9ldnVg4+BlU/N57Wc1
 wlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309653; x=1721914453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+d32bSTeFzLqie/ZHgjHuDft2M0Gh6Zwili0PkILqk=;
 b=ZgFTfzQj0WyoaruthpTJivubFqMh7XKxyXRy9CfdJmLYpZqWufv71LyN6LescVSFjk
 0jSFb39+pf6J9ik//jaPlKe0DrGGVR403z1B3unzchYnap+5+OogAyODkhDXbjOIA/SH
 wh5hWgSYAbdg2TApMYw6cqX7sNOjCGU0DPUNN6naNz6OIfaa1/WiUw0t1fe8vC/bsCpj
 TC7V1iAuOq0Ez++VtUvEr01Yf0NANa6vcqS1rGaDuBn3icSCA76SXU+B0MHeYosfCFrO
 C9/botqtl8Cm1e2P7VFE/lvMtOaEI29Z231t03gC4dv2bWqEfNnQss3WFWwl01SR1UMx
 GqAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCbYSo1SkR0w7DNbSe3eRXSeb0ZeHAFNpNcYslIq8d9zup/IjSii2fclgIOMek12I9Ic1Csf5GY9DvtsTQa3+YL8EiErU=
X-Gm-Message-State: AOJu0Yxl5xPI0jmi4+w9cYYmz0xdnFD9GiRw0Sd2jh5yvL5+s9sEHlaR
 Ij/3xqh+WWYurKCOzTyVZXyrkKhX+YRKPQxDJdy4NgZmjQobqbSM/eWY1md20w4=
X-Google-Smtp-Source: AGHT+IHsfPR0WkIlbe0R309Wblippz0SbQoqvtPiamllscMOG2I6hRicr9hI+xuU2Yg0Fxxo7e7q5A==
X-Received: by 2002:a05:6000:1810:b0:367:89fc:bc11 with SMTP id
 ffacd0b85a97d-36831600383mr3798760f8f.10.1721309652749; 
 Thu, 18 Jul 2024 06:34:12 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccbe9sm14281390f8f.59.2024.07.18.06.34.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 10/19] hw/intc/loongson_ipi: Pass LoongsonIPICommonState to
 send_ipi_data()
Date: Thu, 18 Jul 2024 15:33:02 +0200
Message-ID: <20240718133312.10324-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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


