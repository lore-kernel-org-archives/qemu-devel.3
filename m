Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C3D10ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65C0-0006io-C2; Fri, 27 Mar 2026 07:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bs-0006Xt-CV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bq-0007vw-Eq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b94a19fdso1876603f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610241; x=1775215041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFlZReDv+qQIw0DAeaun7wzY8NaJlNVkqk/yf85M5x8=;
 b=FzXQNF5U3EXkaEvMJ30UM51QB5TtiGoN7cTXZyGpM7C43HHKsJDCs4/nCrUlZjjA8r
 PkUFktMjuEGcnviwHNq2DvdSi74x0L/JOsmmz0kyS+b+t8oIwoGa+H4I6lrRbSmSItWX
 2Xgnk5mz7+6S+VFZX2AjyMzAcw1foAP5V7pCqqM9DRz4la4bL/HeMxxgZA5d/+vc4btO
 mzylHFFJTBOfydFOHBQeDWEPUV1MeBg8sPLRVotoZYuvQgSFJTsmLfep1WFlIDeXFbYJ
 nIqrCNyL6r7J/TIIQjtVbPgHIduJPY3uMJaG/B1yy37yPBOmyuR8pTnOAEhavQz7hdCD
 /ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610241; x=1775215041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iFlZReDv+qQIw0DAeaun7wzY8NaJlNVkqk/yf85M5x8=;
 b=G7wdtU+dcCr1HTixW5yO5Zgm0F5Yhlc8U/8ctUApwkt2KQdpHcTE2BG9jo6SIYKREo
 ICJ1+tkWkZHCwINXWxiN0gEW1ksNn8kIaUmlTuTmL7KGcNrsMLwy2AV32Vj+ewcZOz/6
 qeFqENuBUoJVVL9RuCPynStyMmM3sduJPiNWkp01JI3DJROTqQuO4U94HDbeuboEbNk/
 u6eBBzOZ1OZyLfYBRMmNoLviU6AGyAfZg7jTzP2OJVBfGk1qRhhgsVKX5NBjiFtr8DAH
 SM7n2ZC6NWQj1fBiVxzwDBC12uBVihVaA0iaVJStMbk5ESaM3+pjREKRi4wjjEWYYu3D
 voYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg8L1Nj1ZxcaW6lqabVnLMN7LHMImIY10uoSy7e3xkezgdQqOKjCKA9CBwWzZEGB0wr132CGuVicBu@nongnu.org
X-Gm-Message-State: AOJu0YwEC6ZhIkeJluQJfgshJPUIFCG6Urq2oq4v2UhH+JD81geFxFbw
 3TFhZUOQvHRX/ZK2bzrLRWdSMyc64lTsq8JNR9nvTYzaPyvnBIriyz7+tVml8EQMom4=
X-Gm-Gg: ATEYQzx3Yt+mcsxwfFe9y9X5vWB8AGKvmijCq13CZ5NAQkUol977yaESGdMhEivic/2
 EduiwrACu7gSAv+c2OCa/wsHPdGyEGL4/LquXOZXn37V8WSJJ/+WUBxhOGBCgoCKGzDD77wgVGa
 I/Tvyi2e+/nE3o89z90LaJ+y4VZz9AejkmKEHjakV76Hrljn1zRnp5CnnwstuOyx0OvANowqy/l
 ITamfGX2gb5OLaYjdWdaT8NmwLiFqnfc80c4sn+UMnGd43G2NXfJUlGV9yTFR0Q1GGYpf3vyURt
 4afMeyaImhYESweFRw0uCtP0pcE2wQzBL9jt1I06H5QDSHWASvPEm2c0Hbxqp0dqMrQu3aWa+Vg
 N+wavGXiCK7hhfLug0pX34klqhm0NJEr12lmsrXS6SPPEbab4cHJS9Ac4stm7Djm6eKTLrTxNW9
 4kAmLrVMh3sYvtDirGnpnOo8XTWsD1rEEb32jHhqIRcHeC0h3xeTcYI2eu+WrpGQQx8H+tSUQFh
 WQqIG+JpYK1jH2z4FmdAAukpCoXdmA+jo96DNsVEg==
X-Received: by 2002:a05:6000:2892:b0:43b:47bc:c147 with SMTP id
 ffacd0b85a97d-43b9ea66f1fmr3345875f8f.45.1774610240765; 
 Fri, 27 Mar 2026 04:17:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 20/65] hw/intc/arm_gicv5: Implement IRS_MAP_L2_ISTR
Date: Fri, 27 Mar 2026 11:16:15 +0000
Message-ID: <20260327111700.795099-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

The IRS register IRS_MAP_L2_ISTR is used by software to tell the IRS
that it has updated the address in an L1 IST entry to point to an
L2 IST. The sequence of events here is:
 * software writes to L1_ISTE.L2_ADDR for some L1 ISTE which is
   not valid (i.e. where L1_ISTE.VALID is 0); it leaves VALID at 0
 * software writes to IRS_MAP_L2_ISTR with some INTID that is inside
   the range for this L1 ISTE
 * the IRS sets IRS_IST_STATUSR.IDLE to 0
 * the IRS takes note of this information
 * the IRS writes to the L1_ISTE to set VALID=1
 * the IRS sets IRS_IST_STATUSR.IDLE to 1 to indicate that the
   update is complete

For QEMU, we're strictly synchronous, so (as with IRS_IST_BASER
updates) we don't need to model the IDLE transitions and can have
IRS_IST_STATUSR always return IDLE=1.  We also don't currently cache
anything for ISTE lookups, so we don't need to invalidate or update
anything when software makes the L2 valid.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3588f3323f..7d654a91e6 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -497,6 +497,43 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
     }
 }
 
+static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
+    uint32_t intid = FIELD_EX32(value, IRS_MAP_L2_ISTR, ID);
+    hwaddr l1_addr;
+    uint64_t l1_iste;
+    MemTxResult res;
+
+    if (!FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID) ||
+        !cfg->structure) {
+        /* WI if no IST set up or it is not 2-level */
+        return;
+    }
+
+    /* Find the relevant L1 ISTE and set its VALID bit */
+    l1_addr = l1_iste_addr(cs, cfg, intid);
+
+    l1_iste = address_space_ldq_le(&cs->dma_as, l1_addr, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        goto txfail;
+    }
+
+    l1_iste = FIELD_DP64(l1_iste, L1_ISTE, VALID, 1);
+
+    address_space_stq_le(&cs->dma_as, l1_addr, l1_iste, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        goto txfail;
+    }
+    return;
+
+txfail:
+    /* Reportable with EC=0x0 if sw error reporting implemented */
+    qemu_log_mask(LOG_GUEST_ERROR, "L1 ISTE update failed for ID 0x%x at "
+                  "physical address 0x" HWADDR_FMT_plx "\n", intid, l1_addr);
+}
+
 static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
@@ -683,6 +720,9 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
             cs->irs_ist_cfgr[domain] = data;
         }
         return true;
+    case A_IRS_MAP_L2_ISTR:
+        irs_map_l2_istr_write(s, domain, data);
+        return true;
     }
 
     return false;
-- 
2.43.0


