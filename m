Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1281ED12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbT-0004aP-Bf; Tue, 05 Nov 2024 06:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbR-0004ZR-1j
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:05 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbI-00078H-Fr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43155afca99so38981605e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805592; x=1731410392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ycb+wgMk/1SYEUhSnCxJadXCThlkM3LqVJU9a7bxvrY=;
 b=LuBllXfpqvEC5UrEAo1RDLgSwrgztruJzdXDStSapXoyvOb6vBYU3wCgLncP+qH27w
 mPn/MSN5Gcs1OUvqWZVD8ZBZdKm1USPQf7qn0NCDo1LV1dptFq1XREhn1mNSgx+0w0Hm
 BkIU+exa9c5EwtyJTmzJFtu/93bREgNzdmTXxfpadRDUAzK5zwvK9jYndyxAacPpCL2J
 5rpRW3i4W7X2Y2skBt7FAgxHFQ05mL/idOtYxxH6DmS/6IhQ9ibNJUCFUbb+ORlYlgHg
 /PM1iKblhLbNDLiYS47uPg+TXmijb34gpsqovEZitRXYVVnMGUCG4S0U1t6k72xp1PMA
 qQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805592; x=1731410392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycb+wgMk/1SYEUhSnCxJadXCThlkM3LqVJU9a7bxvrY=;
 b=mBX6/2WzKOdyWLwygAIc4mMwR2534FFzs2elqOLsnt0RJx9hPr+rQb3Eo91gfwsztU
 R8vY14N8N/04aG3LhT3yRy0A4WvcOsPrL4kpTYNYlafOgTspyd8zcZSvUndhXnzpQMrs
 rx27j8Jt9a9S2cDXXHpeK2btmrkQddc22BUk7L2czE1unE953jI/snFIKYinRP9U7meJ
 sdXizq+NfvVh9JWB0hrPrMKk52Uiq5QaVRyBDxyIR7x5UufvfM3j1g+rWSZiWq5m5/4/
 9vg+r3Uiw+5+G7kh7LbeOJNWRzldhWizqxwaP+lfbinjpxv4mCXRzj7gM1Z1VDVqqLRB
 aKNA==
X-Gm-Message-State: AOJu0YxuO+9CUuuIF7rVPZnZ6McBEONAPQNJ0hgTBi+K2JeJYugmMuDj
 1pkpCeEp0nAechFzQrab1OxIU0e5YYU8yAJYL5BAJ2Lo+Kbct91teLt6Ux2P989gIR/t9oEGIOQ
 o
X-Google-Smtp-Source: AGHT+IHfPVE/g7uAiQmA+FNeweopzrVg7qZHA8GA6IGesmOJ5RfNR7yu41jMra5YwL+i8ies4ekfug==
X-Received: by 2002:a05:6000:1868:b0:37c:f997:5b94 with SMTP id
 ffacd0b85a97d-381c7975472mr12664009f8f.12.1730805592551; 
 Tue, 05 Nov 2024 03:19:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/31] hw/rtc/ds1338: Trace send and receive operations
Date: Tue,  5 Nov 2024 11:19:30 +0000
Message-Id: <20241105111935.2747034-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20241103143330.123596-2-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/rtc/ds1338.c     | 6 ++++++
 hw/rtc/trace-events | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index a5fe2214184..929a92f7bda 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "sysemu/rtc.h"
+#include "trace.h"
 
 /* Size of NVRAM including both the user-accessible area and the
  * secondary register area.
@@ -126,6 +127,9 @@ static uint8_t ds1338_recv(I2CSlave *i2c)
     uint8_t res;
 
     res  = s->nvram[s->ptr];
+
+    trace_ds1338_recv(s->ptr, res);
+
     inc_regptr(s);
     return res;
 }
@@ -134,6 +138,8 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
 {
     DS1338State *s = DS1338(i2c);
 
+    trace_ds1338_send(s->ptr, data);
+
     if (s->addr_byte) {
         s->ptr = data & (NVRAM_SIZE - 1);
         s->addr_byte = false;
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index ebb311a5b0e..8012afe1021 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -22,6 +22,10 @@ pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
 aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 
+# ds1338.c
+ds1338_recv(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] -> 0x%02" PRIx8
+ds1338_send(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] <- 0x%02" PRIx8
+
 # m48t59.c
 m48txx_nvram_io_read(uint64_t addr, uint64_t value) "io read addr:0x%04" PRIx64 " value:0x%02" PRIx64
 m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%04" PRIx64 " value:0x%02" PRIx64
-- 
2.34.1


