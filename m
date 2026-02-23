Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09030EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKd-0002Ja-Fl; Mon, 23 Feb 2026 12:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKc-0002HX-2G
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKZ-0000EA-Dg
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso39664775e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866166; x=1772470966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A4hIy6Kcu/S1hR9Ar9eqjjFF1c+deS8g8DeFKzdYWAM=;
 b=HUeFNmkGKpfMKKJ6SEsY5yyuiRBZDsyYz684Los8NW+Tsj/+a9i4gW2NbVW3GiNs6x
 VIa6rmBI0/N4DEc5u+ozKcofhzqAgQ51yniH4J/aooCNEAehypt0u3RbHbYx+OApdKrK
 NNfH6xcqQRWHcZcznRVwO3PcNe2ue8fvao9HULgRVNB+FMQc+axl7m1qYtm73YURWV2V
 In4ZxGmp8dkuVJ08tkcQCzLLmyQi+d1ld3AWAjOeWadnlKEN0DcMrVN0kUe3SLX3TjHT
 8pc+uufbot/f8p0t4TozW5Wa8VMD6BeiyIUbgFWfpmGTKvmhh9AyU9J7rlOyZVnHNoQ0
 wUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866166; x=1772470966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A4hIy6Kcu/S1hR9Ar9eqjjFF1c+deS8g8DeFKzdYWAM=;
 b=nPoK71sPFZVC63kM+/fQ3JxcjQXXTCDxA8+CZAw7DHvsTuhvRnuiT04b6LdC8h4E/H
 3syZ4Q/TQiY7h2GaNtToTPoKYvyiJpkmR5q31pM68fNmnCFCL3AtSPNlWLhM4sPdNZO8
 ifVP9ZJZ9vmBZEQIdSskSIF/DrD7V3DvX8qnxox66c9sVvuqMurd67QWP1+8cxp3bKoe
 c1nhk/C7IchMjp0lylarK8fZvnD9iJ8yug06BPSosQ0RAiDpCJedimc3dGAIDBikHgM2
 rMfLO3A9TPrdKYvSSCGTEMAbBZ37XKQdSkbhM1VjrA9X8UerzTo0R/1c+prLT8inkI29
 xr6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhIBBt9tXR6YQXSjFa2+5tVSVwvS1J7Ixv0IqAQ0+STRkRmguMvIRSDSOJ1ysA8/3tb9IF4rcOjqQV@nongnu.org
X-Gm-Message-State: AOJu0YzHSB/2XVsxw0Nuab9PU+8tVptf0fNfL7RI0m9FjEWMzQbfSwNb
 Xi+O4etJJG/MLcaTqp9cVNGJZMkU0AQaRJyrskP2sZ+lWNYFOBSzZIs4Q+AffzyiKOU=
X-Gm-Gg: AZuq6aJ7n9CHeOkyWYlR0EYEXgfF2tR1ekeCHpLGKugppF7YvWitY/yeJNTclRvWaJM
 LFOoByjxM+lJYkJ+Vw9b+IWeJ6tJIXogWMPSQ7Y2zW0MMjN/lvMPPghTvIrQxqL//wX3rY98Oci
 1RCYVMYJuKRMXBSZ9tEwXBLTbZSgv70OHMDrBmPJjU8NXmYU7lY6pPzA9CRKUnSDNxbnP9mK13b
 wcx6/I7yTSYhnYVRdv6ySKcUCYoxOdRFJdFqFA+XMYeO0w0TpPIxZMcxgTYqS7Cx9JHYOLA1BHd
 7SokPIhPOxTFyDiLknzGZdEUnMcYUZ4HbgoUVQEQziAjq7aiTr8WNG9dUFx+LjlDzRh7Tx8ZgMz
 Mitm56lYhivOT5KyWx5tj6uPSHre26n9p0fba0NiPryhhTWlM+2JZd9haZxNaLj7GQ2ngwPq6sq
 xKGiX/L4JJZVd3k64AoZtLDZh/RjTmgNAuKyyUcw23HOI0MN84vGdfImANu77uy5j4WQMKHmmir
 aU6HAHomBjRuWFQLEJ/ApjFCGYW+XYjwb4Ow5rUbQ==
X-Received: by 2002:a05:600c:3b0a:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-483a963df7amr151995955e9.33.1771866165623; 
 Mon, 23 Feb 2026 09:02:45 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 27/65] hw/intc/arm_gicv5: Update SPI state for CLEAR/SET events
Date: Mon, 23 Feb 2026 17:01:34 +0000
Message-ID: <20260223170212.441276-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

When an SPI irq line changes level, this causes what the spec
describes as SET_LEVEL, SET_EDGE or CLEAR events.  These also happen
when the trigger mode is reconfigured, or when software requests a
manual resample via the IRS_SPI_RESAMPLER register.

SET_LEVEL and SET_EDGE events make the interrupt pending, and update
its handler mode to match its trigger mode.  CLEAR events make the
interrupt no longer pending.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++
 hw/intc/trace-events |  1 +
 2 files changed, 60 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 9f4d44f975..d1baa015d1 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -908,6 +908,28 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     }
 }
 
+static void spi_sample(GICv5SPIState *spi)
+{
+    /*
+     * Sample the state of the SPI input line; this generates
+     * SET_EDGE, SET_LEVEL or CLEAR events which update the SPI's
+     * pending state and handling mode per R_HHKMN.
+     * The logic is the same for "the input line changed" (R_QBXXV)
+     * and "software asked us to resample" (R_DMTFM).
+     */
+    if (spi->level) {
+        /*
+         * SET_LEVEL or SET_EDGE: interrupt becomes pending, and the
+         * handling mode is updated to match the trigger mode.
+         */
+        spi->pending = true;
+        spi->hm = spi->tm == GICV5_TRIGGER_EDGE ? GICV5_EDGE : GICV5_LEVEL;
+    } else if (spi->tm == GICV5_TRIGGER_LEVEL) {
+        /* falling edges only trigger a CLEAR event for level-triggered */
+        spi->pending = false;
+    }
+}
+
 static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
                          uint64_t *data, MemTxAttrs attrs)
 {
@@ -1055,7 +1077,24 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     {
         GICv5SPIState *spi = spi_for_selr(cs, domain);
         if (spi) {
+            GICv5TriggerMode old_tm = spi->tm;
             spi->tm = FIELD_EX32(data, IRS_SPI_CFGR, TM);
+            if (spi->tm != old_tm) {
+                /*
+                 * R_KBPXL: updates to SPI trigger mode can generate CLEAR or
+                 * SET_LEVEL events. This is not the same logic as spi_sample().
+                 */
+                if (spi->tm == GICV5_TRIGGER_LEVEL) {
+                    if (spi->level) {
+                        spi->pending = true;
+                        spi->hm = GICV5_LEVEL;
+                    } else {
+                        spi->pending = false;
+                    }
+                } else if (spi->level) {
+                    spi->pending = false;
+                }
+            }
         }
         return true;
     }
@@ -1068,6 +1107,17 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
             }
         }
         return true;
+    case A_IRS_SPI_RESAMPLER:
+    {
+        uint32_t id = FIELD_EX32(data, IRS_SPI_RESAMPLER, SPI_ID);
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (spi) {
+            spi_sample(spi);
+        }
+        trace_gicv5_spi_state(id, spi->level, spi->pending, spi->active);
+        return true;
+    }
     }
     return false;
 }
@@ -1236,8 +1286,17 @@ static void gicv5_set_spi(void *opaque, int irq, int level)
     /* These irqs are all SPIs; the INTID is irq + s->spi_base */
     GICv5Common *cs = ARM_GICV5_COMMON(opaque);
     uint32_t spi_id = irq + cs->spi_base;
+    GICv5SPIState *spi = gicv5_raw_spi_state(cs, spi_id);
+
+    if (!spi || spi->level == level) {
+        return;
+    }
 
     trace_gicv5_spi(spi_id, level);
+
+    spi->level = level;
+    spi_sample(spi);
+    trace_gicv5_spi_state(spi_id, spi->level, spi->pending, spi->active);
 }
 
 static void gicv5_reset_hold(Object *obj, ResetType type)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 409935e15a..4c55af2780 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -241,6 +241,7 @@ gicv5_set_pending(const char *domain, const char *type, bool virtual, uint32_t i
 gicv5_set_handling(const char *domain, const char *type, bool virtual, uint32_t id, int handling) "GICv5 IRS SetHandling %s %s virtual:%d ID %u handling %d"
 gicv5_set_target(const char *domain, const char *type, bool virtual, uint32_t id, uint32_t iaffid, int irm) "GICv5 IRS SetTarget %s %s virtual:%d ID %u IAFFID %u routingmode %d"
 gicv5_request_config(const char *domain, const char *type, bool virtual, uint32_t id, uint64_t icsr) "GICv5 IRS RequestConfig %s %s virtual:%d ID %u ICSR 0x%" PRIx64
+gicv5_spi_state(uint32_t spi_id, bool level, bool pending, bool active) "GICv5 IRS SPI ID %u now level %d pending %d active %d"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
-- 
2.43.0


