Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B5AEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKb-0002Gk-6T; Mon, 23 Feb 2026 12:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKY-00027a-FC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKV-0000C0-SH
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483a233819aso44119505e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866162; x=1772470962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JwcHn/CjQkHfmGibiCn3O/oR20qiscSiOE7DixcXUno=;
 b=lUaBDTDqUrWwC0ckv1WCsTRChyfWaIblI2vrbWiz2PdUdP419gKsPb3FjdtZKSgm+N
 pRMsOwC0wBULgjaQ6hkVARDcGrqev4AcIAno+oDfsZRHMjiXLorebPYRpMX/nNeJayED
 tE1irGwSEKSN9t8OotP61Q0lKHQJDmDJn93/Jhs2Kj6QVkrXgnaufMCAZ37ghIZEyH3p
 dYb/V1l3e8v9v4Dfg3YhkuOCp6E9BM0SzLBa889bhc5g/LRxf08m8tzxE1kPW+xrSMPw
 fxkbW7meoxfOfx+8ioCTnvtbZhCTgsxQBubKZcjnnc5pBFJDWZU0LMZk1Lr77h1PWDzD
 qdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866162; x=1772470962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JwcHn/CjQkHfmGibiCn3O/oR20qiscSiOE7DixcXUno=;
 b=eGWQR3cZ2vwb2Z/j859vTk1pCJDImcgI2c/2KxP9uLVa9CviwdXdRy6M7J9Z8hfv80
 vfoXxy76mLuwfAm1upcrgrntKSpHR0cURwq4Ah7ESWn8sLWqy8ikUqVXSJDngAJLt+Dq
 JzFIaEdxhldO/BrBAvvcvkonrfeXsER3AsE1Q8fnNOwHAsQiF8x/m2KB2P9kBIIAMZmf
 CZbP2E/maTW8Xl6fqqr5KrtYUJx2Wt7lYx47c1rtq+sFU7/oZ5tw1TJaTBghjyQUQjOL
 /MzNKq/wNSkU7/rH50tQKAMPlwaDMyBNXALQN8gHZdalJK42j+J4hq/+NhpVTIXSd6NT
 YE8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfV0154MIOqS+QxtE52z6vdWZoWN3UGax4WjAuxyZwOw1mRwMjp/EhWhowoJcr5YkhOHkZpNDosBIV@nongnu.org
X-Gm-Message-State: AOJu0YwGytjlG+DCFycsnNCK/813OlmV/Ck0dQ027kWPod8xWYhr+Z2n
 SEeO4XtDvMRauCvcIf31zlzcErLhRYyHrpmxt5TOGe7J9McsCsM1LFgt0LR9LiZsNHQ=
X-Gm-Gg: AZuq6aJ8/FHz7sM+nTXE1zrW6T2WMJSnt5zsIzE/JKloTOPD2wf84goXr6wmHZyf6W+
 QH59QoD77eBBIFNOMUloeN/xkEsrNJ79qnmwjIadUxcBKpFSURvO6Z9t+ZqrviVpCMuGY2VRcbY
 67RKPYLN7N5fJ+3JqyCaFaN9D9TzYDAZwoI61kxf4/qdnHemnyFI8UlPjlpYEgTZVX+I87YT4wz
 kpdlAmJtdkvX6aJSGOHg2SBt82kzZ7k/y66FJ2sAK445Ltb4KGg8TIiz2NTggiCvCbg50ZCuznq
 6vclPQl+bhpqWunqrimE+m552wyqx8/iti5yd+MryciLnOxghIbDfM5xOSaPYmP0DI9+GouFUCO
 MOLM/fzqYLccedLQXTkBpsy3Bmb1ojGCidlABHuAbJ3PsubWKcdftUgZLZYbjqfUSzOffUgS3yg
 rIJhlqaROqjGoFdTUapseiCV5ljKk8rVVe5NBy+y4bRK2W8CMGEwjeh4EeJtJEHZxdom4SRtPjc
 ml33CwedClbMNnYoAuLfGLExZE9Lgw=
X-Received: by 2002:a05:600c:3147:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-483a962e3e2mr138417725e9.22.1771866161175; 
 Mon, 23 Feb 2026 09:02:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 23/65] hw/intc/arm_gicv5: Make gicv5_set_* update SPI state
Date: Mon, 23 Feb 2026 17:01:30 +0000
Message-ID: <20260223170212.441276-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
 hw/intc/arm_gicv5.c                | 59 ++++++++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_common.h | 40 ++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3c6ef17573..4d99200122 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -478,6 +478,18 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id,
                       "priority of a virtual interrupt\n");
         return;
     }
+    if (type == GICV5_SPI) {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
+                          "priority of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->priority = priority;
+        return;
+    }
     if (type != GICV5_LPI) {
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
                       "priority of bad interrupt type %d\n", type);
@@ -508,6 +520,18 @@ void gicv5_set_enabled(GICv5Common *cs, uint32_t id,
                       "enable state of a virtual interrupt\n");
         return;
     }
+    if (type == GICV5_SPI) {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
+                          "enable state of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->enabled = true;
+        return;
+    }
     if (type != GICV5_LPI) {
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_enabled: tried to set "
                       "enable state of bad interrupt type %d\n", type);
@@ -538,6 +562,18 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id,
                       "pending state of a virtual interrupt\n");
         return;
     }
+    if (type == GICV5_SPI) {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
+                          "pending state of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->pending = true;
+        return;
+    }
     if (type != GICV5_LPI) {
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
                       "pending state of bad interrupt type %d\n", type);
@@ -568,6 +604,17 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
                       "handling mode of a virtual interrupt\n");
         return;
     }
+    if (type == GICV5_SPI) {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
+                          "priority of unreachable SPI %d\n", id);
+        }
+
+        spi->hm = handling;
+        return;
+    }
     if (type != GICV5_LPI) {
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
                       "handling mode of bad interrupt type %d\n", type);
@@ -607,6 +654,18 @@ void gicv5_set_target(GICv5Common *cs, uint32_t id, uint32_t iaffid,
          * IRM=1 the same as IRM=0.
          */
     }
+    if (type == GICV5_SPI) {
+        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
+
+        if (!spi) {
+            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
+                          "target of unreachable SPI %d\n", id);
+            return;
+        }
+
+        spi->iaffid = iaffid;
+        return;
+    }
     if (type != GICV5_LPI) {
         qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_target: tried to set "
                       "target of bad interrupt type %d\n", type);
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index c29eab2951..1a1d360c68 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -191,4 +191,44 @@ static inline bool gicv5_domain_implemented(GICv5Common *cs, GICv5Domain domain)
  */
 const char *gicv5_class_name(void);
 
+/**
+ * gicv5_raw_spi_state
+ * @cs: GIC object
+ * @id: INTID of SPI to look up
+ *
+ * Return pointer to the GICv5SPIState for this SPI, or NULL if the
+ * interrupt ID is out of range. This does not do a check that the
+ * SPI is assigned to the right domain: generally you should call it
+ * via some other wrapper that performs an appropriate further check.
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
+ * interrupt is unreachable (which can be because the INTID is out
+ * of range, or because the SPI is configured for a different domain).
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


