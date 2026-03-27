Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80EF10ED65E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65C1-0006lF-Ke; Fri, 27 Mar 2026 07:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bw-0006eC-Kq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:28 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bu-0007xa-MQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso1506705f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610245; x=1775215045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYcKb44qcAOTmabDFzYmilElxXC21N5X3c+i6UPowFQ=;
 b=cFUR6h7yibghqmmfZ2pV8rWCQD+uH1o+kEyrdZxu3L83JnvFJwsT9BwEnsrTjLiBUR
 DMosyWvux2f/IhphisJMzTvU3BNYEhLtU5HJFCTjOLks4eG/PnOYbS/bb1gIlGU90Z3x
 MxZyT4TyEH7X3KF2mYCSMO5X3vZoc8Auz4Ps15F09l313XmtQidbA8brHOh+AiGtdjI1
 527WhV5demsxpHanP3p0QdGFhhosqa3VlmaVnjEQ2J28z1WbMiyXYVo2NdJKvKlygAjh
 MmolrT4JnVaBRsWpHvZM2d3P0FIChhtCihrEc3eaGsLjLE30wgR1vrPIotyuxoWfvICo
 rgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610245; x=1775215045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZYcKb44qcAOTmabDFzYmilElxXC21N5X3c+i6UPowFQ=;
 b=hbXgx70R4a8giKC0uzbpzKbbIPK0a6SgaP3xw0LwM8+0VKWUVrL4OrzXNAu3Khi9qf
 PTytbk4+XwBWoEhlD6L0KecrEzkA9Ow7hlRs3Ymj4r79XFdHezooi1cdm196QCDg+wtl
 zjljjaN1We2SHAsskXQ/RL4CWVCRKsAKylA4CORFBTvmCOVs9fSJBWOelYCxBqOY+7gw
 Oyv1LV/iK1SqHGiVI/DsMonDbsws9uJKM6sSLnNeH7GDVFiQ0vLQnGecSQRr355xeyaH
 EBzJca31ob/lVwtdYA7404n3k/7QCe1iRg/Gvx4yt0/OE8NJZXK8hrECrDTRH1TEK0RV
 KTbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm+ynUnxBfcwjAtUXRrU431oFqX3YgH53LX0Xt6W3nFKehQGvlNjZvp52QDr1viEMsZvgcHpivDeRB@nongnu.org
X-Gm-Message-State: AOJu0YwReedtTmb00xktd6iyQvCUmWEMmMzdVJH2egAMBYwoX/3/DmZw
 mEvscBgGJrS98nm5pUG2gxMNfNl45tSzxSzETUl+TtlmPednOBgDWrXX2ff6DyjBrhs=
X-Gm-Gg: ATEYQzxRcLdgV2brasLkgzjZ1A02vulcTOerD8i/ipSgcoWfMTKnLzXpzbN+X2u2E1I
 VOocluSSACAqAI5p2OhoOP+xCCWyaCEo0NlVWl/Hqms4Ul3jz/zdJ0eCQxCJaxExcDa5S/VcBCj
 IMMOegoSPrmBCiFd1GpS+BX11ayhI/jFMIf8DWiIPG38bKxUjUh4dd2k1nolerL7LCW3KuVy8Uc
 ngf97mAkfypHlMtzbHPtTNMePlu2UQmpojOqEFtse3NaiwNdgJgE1OyDcqzGAwh3SWBqMim/6zC
 /wYVVOeWKFDAje4XZZTPeJhOSZtbUtojy1PGr5sUZnaKi+wKrmIAYbzz5SGPfvPZ+tnUY0DiK1f
 5/QsNS2odwM+qlK/4bwfnardSAL2n2Qvjm7H7Eq9Gp4jfTUuc2msFqgzS7fNs/JD/vUPeZo/bVl
 Civ8KOZqEdMXulAvkdO87C8IaDdJdC+Iug54ZYC3nzkDK9f4vXk3w/AExksMLp79+eBtOLV1/0h
 3wn+Vfdp/1T9feeOC9W63AslUt+iPE=
X-Received: by 2002:a05:6000:1ac9:b0:43b:4e01:4aa9 with SMTP id
 ffacd0b85a97d-43b9e9d5b91mr3339888f8f.10.1774610244950; 
 Fri, 27 Mar 2026 04:17:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 24/65] hw/intc/arm_gicv5: Make gicv5_set_* update SPI state
Date: Fri, 27 Mar 2026 11:16:19 +0000
Message-ID: <20260327111700.795099-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The GIC CD* insns that update interrupt state also work for SPIs.
Instead of ignoring the GICV5_SPI type in gicv5_set_priority() and
friends, update the state in our SPI state array.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 64 ++++++++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_common.h | 40 +++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index d1eb96fce0..9ca1826253 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -490,6 +490,19 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
+                          "priority of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->priority = priority;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
                       "priority of bad interrupt type %d\n", type);
@@ -524,6 +537,19 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id, bool enabled,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
+                          "enable state of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->enabled = true;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
                       "enable state of bad interrupt type %d\n", type);
@@ -558,6 +584,19 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
+                          "pending state of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->pending = true;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
                       "pending state of bad interrupt type %d\n", type);
@@ -593,6 +632,18 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
+                          "priority of unreachable SPI %d\n", id);
+        }
+
+        spi->hm = handling;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
                       "handling mode of bad interrupt type %d\n", type);
@@ -642,6 +693,19 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
         put_l2_iste(cs, cfg, &h);
         break;
     }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
+                          "target of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->iaffid = iaffid;
+        break;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
                       "target of bad interrupt type %d\n", type);
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index d3f4999321..a81c941765 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -189,4 +189,44 @@ static inline bool gicv5_domain_implemented(GICv5Common *cs, GICv5Domain domain)
  */
 const char *gicv5_class_name(void);
 
+/**
+ * gicv5_raw_spi_state
+ * @cs: GIC object
+ * @id: INTID of SPI to look up
+ *
+ * Return pointer to the GICv5SPIState for this SPI, or NULL if the
+ * interrupt ID is out of range. This does not do a check that the SPI
+ * is assigned to the right domain: generally you should call it via
+ * some other wrapper that performs an appropriate further check.
+ */
+static inline GICv5SPIState *gicv5_raw_spi_state(GICv5Common *cs, uint32_t id)
+{
+    if (id < cs->spi_base || id >= cs->spi_base + cs->spi_irs_range) {
+        return NULL;
+    }
+
+    return cs->spi + (id - cs->spi_base);
+}
+
+/**
+ * gicv5_spi_state:
+ * @cs: GIC object
+ * @id: INTID of SPI to look up
+ * @domain: domain to check
+ *
+ * Return pointer to the GICv5SPIState for this SPI, or NULL if the
+ * interrupt is unreachable (which can be because the INTID is out of
+ * range, or because the SPI is configured for a different domain).
+ */
+static inline GICv5SPIState *gicv5_spi_state(GICv5Common *cs, uint32_t id,
+                                             GICv5Domain domain)
+{
+    GICv5SPIState *spi = gicv5_raw_spi_state(cs, id);
+
+    if (!spi || spi->domain != domain) {
+        return NULL;
+    }
+    return spi;
+}
+
 #endif
-- 
2.43.0


