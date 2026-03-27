Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5DF10ED65E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65CE-00072g-Er; Fri, 27 Mar 2026 07:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C3-0006nl-DT
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C1-000822-4T
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso24721415e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610252; x=1775215052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRt8V9U0CkppqZyopaw8OtekbF4DU6MQ2QG3S20WAVo=;
 b=HD2Rk4VLF+MKesBYtu3KOBYiU2uPGp05PKU3FmtxfBfVk8cPrgyNfzGJe1vtChdZwM
 mmKK3VWp0PtBC5skkDcA9XTCE0Fr8D6YOvxl2A0U9YgYffWHWYPZPF3J2UvrvdnyHQP2
 9M9SNMQ17AtcOyPREAJsWR3TD3fao7hCiCMGSUtty9QAk3r4j7FDfBuUUeaC+sMm5nuX
 1qZAM3cebaP6grLdxC7ZxLwUXos0065z0g34B3ykm20uijic2N0VKzdlIP/jw5x0jMrW
 Sj5uCv82Sugxk0Rn7NBbIXIVf1ucmp3jFgyyCZ1H4rfSeCv5Tm0zueiNia/i+H9ewT3d
 WghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610252; x=1775215052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aRt8V9U0CkppqZyopaw8OtekbF4DU6MQ2QG3S20WAVo=;
 b=PIDxYcUY9E421DM/yj33Run/k/14qidRqkJvkAyeg+Mz5uH/V+xMsUTM1a8FvVIk5f
 LsdqqxXLzhgvmBK34WsWrDtr5/wArdvKl60QJAluJ/1MacCJgzXVCReHXCttiv1lANKp
 hMfceNan1bLAU1mZHsWChCdfPyIt81p7v8F1qt42qF2rrazoptQZjEaw/OnQFE9xKHsm
 sfRH9Zbj/w0sWV9OFTitk6dnU8gINH1qh4+tgPJw8tswhQjyqvPxGVKOGfxIE8A7dS0V
 AikkP6KXojTargbKEb0/p6vLFbvRswk4X/lbr3dnBEIlgDzZbHcTfSZdWK0TtgDTl+Xt
 JKUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcoOjRh7Rv0M2HJ5kUV/o+OwHm7F7Kj8DvwUFVothuCRG2Qm+UeE3lJTpp0tXz3jTv/cAJLLlDHIfb@nongnu.org
X-Gm-Message-State: AOJu0YyFWe1TcwrXgJoexNW7skkEP5NHs39XDOwVAHYDAXpTHPzEsgf+
 ZJ3I5+2hC76OjCCh0dVh3Rg1irsWmlii+KjUtN9imIlxobDrVBAeTbgjQfhGzhQgsBE=
X-Gm-Gg: ATEYQzyRIrgQhON1TBANOzygRuF3+IekEozT5p5vpIhAqOh2qK/nWxuykQ3xqHxl6Iw
 h9qPrLE1RoMKFbnPQIFfZhMFviT6SfaHo/ogbIXxT4R24zRTDE07j1fEbGCdmFgn8u6lcqxEjIV
 j0VUmpXsHYlgXQsu0cbVPrQroKMcIWkMqubclyeTn8emKzNbvBhOWkUxuG3TiSe9J8fh7eMBVV9
 sXwx5wlnLEKY5Q8epIlinIE4/JqYFDV71Gt9swPjpFRMUgUTQ6w9t50CQN42U0MMQ1YwMv/rTZL
 4v8czQH6RuOa028Wcw75fwJ7pN75USuLVSBkhBHOrD4Igqd4tI8POF//LFFZg04ky/hkUKzH5Fl
 sBQ6PG2FME65VOR5HFXvfZT70GtY+OmwkTvdUDZOec6gKntGfwvDpxy9THkInj5TAdhoR5BoLjL
 Yz+Zyw++C8m3YtYcPZmbgOWZX6SOYpmY8DTkxWVD3FuEKeWTRViOrhQaws2Dz4d1r7s+eBcm4M1
 bLj4hOViGE2UPmXrS4SuIMsS2fkL6o=
X-Received: by 2002:a05:600c:1546:b0:487:4eb:d125 with SMTP id
 5b1f17b1804b1-48727ef0351mr33466895e9.9.1774610251476; 
 Fri, 27 Mar 2026 04:17:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 31/65] hw/intc/arm_gicv5: Implement IRS_PE_{CR0, SELR,
 STATUSR}
Date: Fri, 27 Mar 2026 11:16:26 +0000
Message-ID: <20260327111700.795099-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The IRS_PE_CR0, IRS_PE_SELR, IRS_PE_STATUSR registers allow software
to set and query per-CPU config.  Software writes the AFFID of a CPU
to IRS_PE_SELR, and can then read and write the 1ofN config for that
CPU to IRS_PE_CR0, and read the CPU's online status from
IRS_PE_STATUSR.

For QEMU, we do not implement 1-of-N interrupt routing, so IRS_PE_CR0
can be RAZ/WI.  Our CPUs are always online and selecting a new one
via SELR is instantaneous, so IRS_PE_STATUSR will return either
ONLINE | V | IDLE if a valid AFFID was written to SELR, or just IDLE
if an invalid AFFID was written.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5.c                | 39 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  1 +
 include/hw/intc/arm_gicv5_common.h |  1 +
 3 files changed, 41 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 7b0d9e16c4..a95a9dc16b 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -968,6 +968,21 @@ static void spi_sample(GICv5SPIState *spi)
     }
 }
 
+static bool irs_pe_selr_valid(GICv5Common *cs, GICv5Domain domain)
+{
+    /*
+     * Return true if IRS_PE_SELR has a valid AFFID in it. We don't
+     * expect the guest to do this except perhaps once at startup, so
+     * do a simple linear scan through the cpu_iaffids array.
+     */
+    for (int i = 0; i < cs->num_cpu_iaffids; i++) {
+        if (cs->irs_pe_selr[domain] == cs->cpu_iaffids[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
                          uint64_t *data, MemTxAttrs attrs)
 {
@@ -1091,6 +1106,24 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         /* Sync is a no-op for QEMU: we are always IDLE */
         *data = R_IRS_SYNC_STATUSR_IDLE_MASK;
         return true;
+    case A_IRS_PE_SELR:
+        *data = cs->irs_pe_selr[domain];
+        return true;
+    case A_IRS_PE_CR0:
+        /* We don't implement 1ofN, so this is RAZ/WI for us */
+        *data = 0;
+        return true;
+    case A_IRS_PE_STATUSR:
+        /*
+         * Our CPUs are always online, so we're really just reporting
+         * whether the guest wrote a valid AFFID to IRS_PE_SELR
+         */
+        v = R_IRS_PE_STATUSR_IDLE_MASK;
+        if (irs_pe_selr_valid(cs, domain)) {
+            v |= R_IRS_PE_STATUSR_V_MASK | R_IRS_PE_STATUSR_ONLINE_MASK;
+        }
+        *data = v;
+        return true;
     }
 
     return false;
@@ -1179,6 +1212,12 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_SYNCR:
         /* Sync is a no-op for QEMU: ignore write */
         return true;
+    case A_IRS_PE_SELR:
+        cs->irs_pe_selr[domain] = data;
+        return true;
+    case A_IRS_PE_CR0:
+        /* We don't implement 1ofN, so this is RAZ/WI for us */
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index b1c8ec4521..5510e6239a 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -68,6 +68,7 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
     memset(cs->irs_ist_cfgr, 0, sizeof(cs->irs_ist_cfgr));
     memset(cs->irs_cr0, 0, sizeof(cs->irs_cr0));
     memset(cs->irs_cr1, 0, sizeof(cs->irs_cr1));
+    memset(cs->irs_pe_selr, 0, sizeof(cs->irs_pe_selr));
 
     if (cs->spi) {
         GICv5Domain mp_domain;
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index ac0532abe8..34ad38c198 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -86,6 +86,7 @@ struct GICv5Common {
     uint32_t irs_spi_selr[NUM_GICV5_DOMAINS];
     uint32_t irs_cr0[NUM_GICV5_DOMAINS];
     uint32_t irs_cr1[NUM_GICV5_DOMAINS];
+    uint32_t irs_pe_selr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
-- 
2.43.0


