Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B7210ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Cb-0007nY-E8; Fri, 27 Mar 2026 07:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CI-00076v-Rp
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CG-0008Nc-7q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:50 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43b95e5b3afso1067303f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610267; x=1775215067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+NND+DC3ZaHttRrG8gV6nmrowvOqHZWCsPNgUWAPHg=;
 b=IQT3bag1kNwaqchKmpNUPhjQ6ymAqdcSw0PXJkfBOBu1TvYIc2dfNXFDaFjuznCpWp
 Z54CBCGey0omDvkgtSLzC1DIgptbtQbsvnTPdDcL31oOakt90iVCwscRLyzWkhLRm1RQ
 2Y6kfc0UqGtb5wG1kHOt/UYiPPRPna9P8vbuivM+MfMVSP9tx+G1s70F8ohP4FJh33u8
 voYeVean2WhohpzHgCzh2AFvFAz5oT3C6fqXCDcl2F6v8anEN6XWt2IqtqCHrI949HNZ
 /zfPRUegFy++pRqNL7kQthPXOPsoHJICMlH79ku0nXV3j0N3j9NfgidzjE5PGzANC9ju
 wwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610267; x=1775215067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S+NND+DC3ZaHttRrG8gV6nmrowvOqHZWCsPNgUWAPHg=;
 b=Zu5MWv1AsI4BbqpRqnUviSZXU5uR/JIJT59Lj5ZgyD310khjRd2Q3QmBQrtrD1D+Ir
 UsaI0sQfJnqa1R0YFcGVxMJry16Q/Ew9S5mytn5t4+yVNnaoCKanEFAZ1DiZLRc9hpaq
 SN9MjOsfV8XMbKT3w3qjurLoD4O5g2yGZIUUaKn1bDJ35xkpF0IRd1Dr/uENDpi6KKag
 sNVx5qKq7hHTSVQb0ZexK4dGtQrlOFEftyF4o4THR9t7f6z03+CG4OgtY0UhD2gbVWUi
 ECNNHPtl0nMMF1ZDuHBRkN/lLCeLSxF/9WyAkZRZKOHM6tzRRU1sC+Eaf9aU/AL1dAdz
 qnAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyrkYqj6zZrJ5owhz0DbagqR8LLPEyXN7b51TxYmtmulfgCEoImQRXAK4gNoxi8hWRMgamHw+e3v84@nongnu.org
X-Gm-Message-State: AOJu0YwTi56koP6j6216805oPj7xfOTkU1GbXm36dkIpAdKlCNPXmybH
 ugnsueJcz0KcQoenhvdrloaYXR1CKVXA4f5htl4qEDEfdYsB+YKqm8O1x/2JzTO8wLk=
X-Gm-Gg: ATEYQzzFFhiRk0EVuLBlhGVOeoVZsa2bZVrpXyFyUXRysbuWIV6j/Rnk0h8ibGoHTNv
 qbm0xnt+8nBwVh3UUH19xUzp6NliAq5XNZwg4lehZLv7awaLLWEp3FEuwOTnvsuAhpNEokVuMhU
 teMf+qSsbZPNEutJqIrR1sUBAlELZP6SWdjKs8tgTBUiZdxI8B2AD3UjJor+YTCfdAHLqTSN6JZ
 JRwOME+ExhMuwyV1SlYq1a8+/yjharXyxpCj4vEux8CQqnL6jogzISz7mKgLMIIu6EoQEe7FIlo
 rdh3ih7WZ2nEB3nD+pz1Q2B9b4JLQZ1JA/GHAEoIUXaEWer4Q5XjqOppRUTQn5DLND6PZAdIvi7
 WMvC3+hX7aPLgQ8hGU/aBY9xUr1YZmyM8T5XFNjgDFlkBoTSgSWSMWVqCXbkZ1A/rthN+Ut86Az
 99v8wyTZjDcfyfbY362pFzw8HP1jgUEu+HihX5tGDBjhtVrPVJZcVHcbnvjR9Oq5Qju+c9XZf5I
 J1M0ylVFHjH3bJ+2SvzG+7AaHLFa4s=
X-Received: by 2002:a05:6000:1448:b0:43b:4f0c:aefd with SMTP id
 ffacd0b85a97d-43b9e9a0c82mr2934674f8f.23.1774610266525; 
 Fri, 27 Mar 2026 04:17:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 47/65] hw/intc/arm_gicv5: Implement Activate command
Date: Fri, 27 Mar 2026 11:16:42 +0000
Message-ID: <20260327111700.795099-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Implement the equivalent of the GICv5 stream protocol's Activate
command, which lets the cpuif tell the IRS to move its current
highest priority pending interrupt into the Active state, and to
clear the Pending state for an Edge handling mode interrupt.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5.c                | 58 ++++++++++++++++++++++++++++++
 hw/intc/trace-events               |  1 +
 include/hw/intc/arm_gicv5_stream.h | 23 ++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 605cf6fd6f..942f3eba2e 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1095,6 +1095,64 @@ uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
     }
 }
 
+void gicv5_activate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                    GICv5IntType type, bool virtual)
+{
+    GICv5 *s = ARM_GICV5(cs);
+    uint32_t iaffid;
+
+    trace_gicv5_activate(domain_name[domain], inttype_name(type), virtual, id);
+
+    if (virtual) {
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_activate: tried to "
+                      "activate a virtual interrupt\n");
+        return;
+    }
+
+    switch (type) {
+    case GICV5_LPI:
+    {
+        const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
+        L2_ISTE_Handle h;
+        uint32_t *l2_iste_p = get_l2_iste(cs, cfg, id, &h);
+
+        if (!l2_iste_p) {
+            return;
+        }
+        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ACTIVE, true);
+        if (FIELD_EX32(*l2_iste_p, L2_ISTE, HM) == GICV5_EDGE) {
+            *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PENDING, false);
+        }
+        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
+        put_l2_iste(cs, cfg, &h);
+        break;
+    }
+    case GICV5_SPI:
+    {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_activate: tried to "
+                          "activate unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->active = true;
+        if (spi->hm == GICV5_EDGE) {
+            spi->pending = false;
+        }
+        iaffid = spi->iaffid;
+        break;
+    }
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_activate: tried to "
+                      "activate bad interrupt type %d\n", type);
+        return;
+    }
+
+    irs_recalc_hppi(s, domain, iaffid);
+}
+
 static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 6475ba5959..636c598970 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -241,6 +241,7 @@ gicv5_set_pending(const char *domain, const char *type, bool virtual, uint32_t i
 gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t id, int handling) "GICv5 IRS SetHandling %s %s virtual:%d ID %u handling %d"
 gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
 gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
+gicv5_activate(const char *domain, const char *type, bool virtual, uint32_t id) "GICv5 IRS Activate %s %s virtual:%d ID %u"
 gicv5_spi_state(uint32_t spi_id, bool level, bool pending, bool active) "GICv5 IRS SPI ID %u now level %d pending %d active %d"
 gicv5_irs_recalc_hppi_fail(const char *domain, uint32_t iaffid, const char *reason) "GICv5 IRS %s IAFFID %u: no HPPI: %s"
 gicv5_irs_recalc_hppi(const char *domain, uint32_t iaffid, uint32_t id, uint8_t prio) "GICv5 IRS %s IAFFID %u: new HPPI ID 0x%x prio %u"
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index cc1c7cc438..7ac24f0f09 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -151,6 +151,29 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
 uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
                               GICv5IntType type, bool virtual);
 
+/**
+ * gicv5_activate
+ * @cs: GIC IRS to send command to
+ * @id: interrupt ID
+ * @domain: interrupt domain to act on
+ * @type: interrupt type (LPI or SPI)
+ * @virtual: true if this is a virtual interrupt
+ *
+ * Activate the IRS's highest priority pending interrupt; matches the
+ * stream interface's Activate command.
+ *
+ * In the stream interface, the command has only the domain and
+ * virtual fields, because both the IRS and the CPUIF keep track of
+ * the IRS's current HPPI. In QEMU, we also have arguments here for
+ * @id and @type which are telling the IRS something that in hardware
+ * it already knows. This is because we have them to hand in the cpuif
+ * code, and it means we don't need to pass in an iaffid argument to
+ * tell the IRS which CPU we are so it can find the right element in
+ * its hppi[][] array.
+ */
+void gicv5_activate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
+                    GICv5IntType type, bool virtual);
+
 /**
  * gicv5_forward_interrupt
  * @cpu: CPU interface to forward interrupt to
-- 
2.43.0


