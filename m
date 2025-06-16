Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4017C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAUZ-0001Ey-DB; Mon, 16 Jun 2025 10:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRAU1-000163-9N
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATy-00040w-4d
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-450cf214200so39262575e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082800; x=1750687600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sj4CFhPbE7Fh5CPRnVAD3jRmQ3BeYvsxrXes/KZEpoQ=;
 b=LAiN1SP+pVGkN2EnZjn+Htif4VseWjDrywjeuBOI458D4mOaXuy7B/2Ux2EcJPuX4l
 h2kP87t0mSJILmP4GmSvAkj99kxWpHV4rlJrAYp2Hi5vTX9Wyj0EW/ulkdrN1iCYjxhT
 So9YVdVHekn9eJzMZUR/A6yn3tTspKQRnTTqPOoBqTekYDYf8O9xTs3Y/VoQXyKia3Ur
 VlKwMC1pRlv1H+drxkXvUA6Fo9L6sy/RFNh8zqWnozE5Tk9HSsQxlcUQocbM5/97Z/T4
 V92ZXpMcO7jbuBZuoHS1iRga7ZMg7nC5EdsCpPMi4+uHfEsGBmlDA7YsnW6AMXwxNDLa
 QW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082800; x=1750687600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sj4CFhPbE7Fh5CPRnVAD3jRmQ3BeYvsxrXes/KZEpoQ=;
 b=CgRR8MToHldddH0NxOdUm/pCthy7AvSG5do+6Tb5mUGg14zdw+ZaCkJRnsKaOZBaaC
 VppYT9OoJDWNnhKcdwAQD5/x/rlegmLJFKuX9IE3yue7lM4aryvEbaVk7lSJH+Ld4uF5
 hrQ+K+HgtYuwftnC3hi7ULpVVwA1h1WYE0yUCoXvi6j8RqJCPW8bjK7p2fQVvMbGuWXY
 wmwmv+aL8SIoJQ1nA03atvZZmH2JFfK9zKaete4WATG03Qt7qy9QV23d3p/SrKpluz/a
 V4dJMCfLr67aqKGFb5gvIKxbmrrNMblTcJdVB9HxHh3zVxKWJXG0REKmOlNftPWs0cww
 0vHA==
X-Gm-Message-State: AOJu0YxLPEb7WFomnGYE/pCtOXJq+NwWos3QWsfcFwN8VzADM+uKBHtE
 hJ60x1AeFPf4qOFM+R+EFEk8KG98J208qYckJPu+9eA2ERPfmIuTO4XPkylF1BxJFKuNOzKBhC0
 qpnw8
X-Gm-Gg: ASbGncvdHTG3oDyfmvKK3vsLAaBi2/TDd/J91NObcQW4zr7tIYPQTwqLxshZuGCxd6r
 aEAz7f7S3EySOIQhZ/w0kajj9eQO+WuAoTEMioYlgqznvyUajMyl95cP9excDHL/lgyeU553PjB
 HRmWkK1XLe/GbuxIT8NBzrXe8eSpjD2lBm23O0BQt31hMQvLH1HwzP6tUCrZ7yAs7IL0P7VthU/
 0caICvIKWNS3CKv/83HFO99aggp0T+kMdSvdnS6V1KQ+qtBIN2CbH6M/PWSYhhJvxBAylTa0chD
 4NRucgK6rhBZobg6n5fc+AS5fTKaWelixQlLM+1e77NHT7H2ipDFBE2000TvtdpGZY+i
X-Google-Smtp-Source: AGHT+IGFmhAVDSya/9P+SzwgzU2UrVfjD2n4LmwpgdeuGDLLgxykPCn9JQhHI3b6OdWVsESYDrNDnQ==
X-Received: by 2002:a05:600c:3513:b0:453:a88:d509 with SMTP id
 5b1f17b1804b1-4533ca7443cmr115999655e9.10.1750082800095; 
 Mon, 16 Jun 2025 07:06:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c192sm146561975e9.26.2025.06.16.07.06.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:06:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] hw/intc/arm_gic: introduce a first-cpu-index property
Date: Mon, 16 Jun 2025 15:06:28 +0100
Message-ID: <20250616140630.2273870-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616140630.2273870-1-peter.maydell@linaro.org>
References: <20250616140630.2273870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Frederic Konrad <konrad.frederic@yahoo.fr>

This introduces a first-cpu-index property to the arm-gic, as some SOCs
could have two separate GIC (ie: the zynqmp).

Signed-off-by: Clément Chigot <chigot@adacore.com>
Message-id: 20250526085523.809003-3-chigot@adacore.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: slightly expanded comment documenting GIC property]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gic.h        | 3 +++
 include/hw/intc/arm_gic_common.h | 2 ++
 hw/intc/arm_gic.c                | 2 +-
 hw/intc/arm_gic_common.c         | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index 48f6a51a70a..be923f7ed88 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -27,6 +27,9 @@
  *    implement the security extensions
  *  + QOM property "has-virtualization-extensions": set true if the GIC should
  *    implement the virtualization extensions
+ *  + QOM property "first-cpu-index": index of the first cpu attached to the
+ *    GIC (default 0). The CPUs connected to the GIC are assumed to be
+ *    first-cpu-index, first-cpu-index + 1, ... first-cpu-index + num-cpu - 1.
  *  + unnamed GPIO inputs: (where P is number of SPIs, i.e. num-irq - 32)
  *    [0..P-1]  SPIs
  *    [P..P+31] PPIs for CPU 0
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index 97fea4102d3..93a3cc2bf81 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -129,6 +129,8 @@ struct GICState {
     uint32_t num_lrs;
 
     uint32_t num_cpu;
+    /* cpu_index of the first CPU, attached to this GIC.  */
+    uint32_t first_cpu_index;
 
     MemoryRegion iomem; /* Distributor */
     /* This is just so we can have an opaque pointer which identifies
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index d18bef40fcc..899f1333633 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -59,7 +59,7 @@ static const uint8_t gic_id_gicv2[] = {
 static inline int gic_get_current_cpu(GICState *s)
 {
     if (!qtest_enabled() && s->num_cpu > 1) {
-        return current_cpu->cpu_index;
+        return current_cpu->cpu_index - s->first_cpu_index;
     }
     return 0;
 }
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 0f0c48d89ab..ed5be056452 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -350,6 +350,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
 
 static const Property arm_gic_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", GICState, num_cpu, 1),
+    DEFINE_PROP_UINT32("first-cpu-index", GICState, first_cpu_index, 0),
     DEFINE_PROP_UINT32("num-irq", GICState, num_irq, 32),
     /* Revision can be 1 or 2 for GIC architecture specification
      * versions 1 or 2, or 0 to indicate the legacy 11MPCore GIC.
-- 
2.43.0


