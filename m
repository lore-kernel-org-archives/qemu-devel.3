Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1F3D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaW-000095-BJ; Thu, 29 Jan 2026 11:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaR-00005l-1n
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:39 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaP-0006bn-6p
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:38 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4359a302794so847197f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702976; x=1770307776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m6kwUe9BaqDGblH1gyyZA8b9OoCTMLMEJsEiSmfNnrk=;
 b=lz45EyudvP7ciMoY8hnKvnQgEnoU350bhDK0dR+qlTFhpzeXCyA3t09WsYTwwLl2ou
 iwSWjzlRHbYLLI/2kgboB+vjALK9mIqWw8xBRh+14Y9DtHexVNYn16scbip9AHJC+TIO
 NRxPmW2EeHAbseuGUoZ3EtxgziWYYbBs+/wpONnDok4RUhMZ+Yh/QtvNayFDlKQ4RnI2
 qg9MT0AXSQKBmPQ85NPT/+eZMHQS9GAhyhsUGRqYTsv9fxg1NZIU6qcm4pYS0KOl1z9B
 lmRmNNb/OKUnqdYZxYkWCoYJy6VywsO22DVTtS0iYRnIC70HwdW5i2y+w0uGz+AtA5Mg
 LV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702976; x=1770307776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m6kwUe9BaqDGblH1gyyZA8b9OoCTMLMEJsEiSmfNnrk=;
 b=h5QiuZfSf2PdGUC1779wFtdgqGpn102Otl3Ky4VqGSEamYhcc4nM/6tujn1/r+Lu22
 kR0+rXXvXenvnjKGtqt4YK+mJvkikN3gALWAuqvgGzu42vw9NDofrrLNHi/mXRomQ8iW
 VBMRY0wZJMxJ0FZRHhSCyEN+hMcW1LnEhk5UHF2r5rXG9IHthnVco9tT3S9Pm7irdfvJ
 AOltp9BBNgzMtiibxVgx6N06nnZwbEK3NQO5U2C58QmgcfQkOL0Em8yjp15FZUWt8KuP
 ltyrDYRohXlrbAIDUQi3yhmr8NhmdoJtA2Fn4fLjmgvd1d+bLpgq0mBc2UzTTdSLBspi
 wjnw==
X-Gm-Message-State: AOJu0YyCTHqNoBkprK5al/LskEr6zsRJz6kkVTKXokncf4OaENqZnA7h
 9hwDjAcVLVG1kiVQmWin6ow/3kRdoXP3TR5Yw+9YUbhcANSvc6j93c7c3ULG+1hmS/IZ7HbrC8H
 F/HF5+IY=
X-Gm-Gg: AZuq6aKUlGLgkn7w+6FK9yCb122MGv4R0itfzPRbIzFeObC2fmRw/amBL4ga4Rx3jul
 n61ydezaqjkuaNpgID4jJXka40iLWKDerxBWCXl0YKwWNSSvZav4AEJQ2ufoPes3PRMq5T0ATIs
 2kMkwXMl0lGurwGZdFsB0dZEHCmmiUATcJxJyaS12rV/LXuGG6dTbJ94PCR9luGhCSNChsKXitX
 dtvk0c/4WPrwb+KICu0dnlJtNFqX9YubsZlqpeu38U7CHBQv1vA2xJvmJu6pQeCC2hRMd/Hyw6V
 1YebSk5q0gVDukr2hl6apsfPIopoyEtRf3bUt2JhBQbGpVDlcJjyGZwbL6GNFANJzPI9dx/a+HJ
 GSiMcgXbWGqaOmttmjbzqW1UCRvjDxGKTHb/juVgJYlKt68rF9rmQ1Lp9l0dIctbDxP3iFF+uQv
 5EiEuG5VDsa1ujQx3JkcmJ3qjNHxZT4A==
X-Received: by 2002:a05:6000:2507:b0:431:a50:6ead with SMTP id
 ffacd0b85a97d-435f3a8654dmr180046f8f.20.1769702975456; 
 Thu, 29 Jan 2026 08:09:35 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/43] hw/arm/smmuv3: propagate smmuv3_cmdq_consume() errors to
 caller
Date: Thu, 29 Jan 2026 16:08:47 +0000
Message-ID: <20260129160917.1415092-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

smmuv3_cmdq_consume() is updated to return detailed errors via errp.

Although this is currently a no-op, it prepares the ground for accel
SMMUv3 specific command handling where proper error reporting will be
useful.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-14-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 67 +++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 95d44f81ed..ade2b43ab8 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1279,7 +1279,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
     }
 }
 
-static int smmuv3_cmdq_consume(SMMUv3State *s)
+static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
@@ -1547,42 +1547,44 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
 static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
                                uint64_t data, MemTxAttrs attrs)
 {
+    Error *local_err = NULL;
+
     switch (offset) {
     case A_CR0:
         s->cr[0] = data;
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
-        smmuv3_cmdq_consume(s);
-        return MEMTX_OK;
+        smmuv3_cmdq_consume(s, &local_err);
+        break;
     case A_CR1:
         s->cr[1] = data;
-        return MEMTX_OK;
+        break;
     case A_CR2:
         s->cr[2] = data;
-        return MEMTX_OK;
+        break;
     case A_IRQ_CTRL:
         s->irq_ctrl = data;
-        return MEMTX_OK;
+        break;
     case A_GERRORN:
         smmuv3_write_gerrorn(s, data);
         /*
          * By acknowledging the CMDQ_ERR, SW may notify cmds can
          * be processed again
          */
-        smmuv3_cmdq_consume(s);
-        return MEMTX_OK;
+        smmuv3_cmdq_consume(s, &local_err);
+        break;
     case A_GERROR_IRQ_CFG0: /* 64b */
         s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 0, 32, data);
-        return MEMTX_OK;
+        break;
     case A_GERROR_IRQ_CFG0 + 4:
         s->gerror_irq_cfg0 = deposit64(s->gerror_irq_cfg0, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_GERROR_IRQ_CFG1:
         s->gerror_irq_cfg1 = data;
-        return MEMTX_OK;
+        break;
     case A_GERROR_IRQ_CFG2:
         s->gerror_irq_cfg2 = data;
-        return MEMTX_OK;
+        break;
     case A_GBPA:
         /*
          * If UPDATE is not set, the write is ignored. This is the only
@@ -1592,71 +1594,76 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
             /* Ignore update bit as write is synchronous. */
             s->gbpa = data & ~R_GBPA_UPDATE_MASK;
         }
-        return MEMTX_OK;
+        break;
     case A_STRTAB_BASE: /* 64b */
         s->strtab_base = deposit64(s->strtab_base, 0, 32, data);
-        return MEMTX_OK;
+        break;
     case A_STRTAB_BASE + 4:
         s->strtab_base = deposit64(s->strtab_base, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_STRTAB_BASE_CFG:
         s->strtab_base_cfg = data;
         if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
             s->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
             s->features |= SMMU_FEATURE_2LVL_STE;
         }
-        return MEMTX_OK;
+        break;
     case A_CMDQ_BASE: /* 64b */
         s->cmdq.base = deposit64(s->cmdq.base, 0, 32, data);
         s->cmdq.log2size = extract64(s->cmdq.base, 0, 5);
         if (s->cmdq.log2size > SMMU_CMDQS) {
             s->cmdq.log2size = SMMU_CMDQS;
         }
-        return MEMTX_OK;
+        break;
     case A_CMDQ_BASE + 4: /* 64b */
         s->cmdq.base = deposit64(s->cmdq.base, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_CMDQ_PROD:
         s->cmdq.prod = data;
-        smmuv3_cmdq_consume(s);
-        return MEMTX_OK;
+        smmuv3_cmdq_consume(s, &local_err);
+        break;
     case A_CMDQ_CONS:
         s->cmdq.cons = data;
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_BASE: /* 64b */
         s->eventq.base = deposit64(s->eventq.base, 0, 32, data);
         s->eventq.log2size = extract64(s->eventq.base, 0, 5);
         if (s->eventq.log2size > SMMU_EVENTQS) {
             s->eventq.log2size = SMMU_EVENTQS;
         }
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_BASE + 4:
         s->eventq.base = deposit64(s->eventq.base, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_PROD:
         s->eventq.prod = data;
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_CONS:
         s->eventq.cons = data;
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_IRQ_CFG0: /* 64b */
         s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 0, 32, data);
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_IRQ_CFG0 + 4:
         s->eventq_irq_cfg0 = deposit64(s->eventq_irq_cfg0, 32, 32, data);
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_IRQ_CFG1:
         s->eventq_irq_cfg1 = data;
-        return MEMTX_OK;
+        break;
     case A_EVENTQ_IRQ_CFG2:
         s->eventq_irq_cfg2 = data;
-        return MEMTX_OK;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 32-bit access to 0x%"PRIx64" (WI)\n",
                       __func__, offset);
-        return MEMTX_OK;
+        break;
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
+    return MEMTX_OK;
 }
 
 static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
-- 
2.43.0


