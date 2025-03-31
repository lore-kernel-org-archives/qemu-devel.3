Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E5DC36011
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL8J-0002FP-N2; Mon, 31 Mar 2025 15:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8I-0002DL-89
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8F-0003Oa-5h
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:17 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso3835018f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450553; x=1744055353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mD0e9eaGkTJvGMcL9mwV8iKKrD2iOxihpH1h0trc4fc=;
 b=Ei8XRNFETqeH1A392YQZiVuoU7MqOuJ3VdvFKE4ra8aFvus1t1Lq95kdzAEsySFFtW
 8qKHFS6JPXBhSyy28d2eAoN4G4X8QHcAYsaYyjEmrNQFx8IhLoYrXWQSAPpOUuH5RD26
 JWNLUlZmXxdEVDG9BDrcXeAUdfPKi9thoZqSnFeb7044iiYX2SqgCcHT2Hyn+H6yAujQ
 0PdH9UTuAoV8AK9V5fSlDKB6tNwKRFUkbU+bbi5eqycgQjVnz5fpwhFjHQQI3g19yf5f
 +63U9swgPGtqp+HnChnxnFN4Jgr7rrDmtwwJvQXfBMpiXad0c3h5FXA1ZxdmdqxJRA/3
 cBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450553; x=1744055353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mD0e9eaGkTJvGMcL9mwV8iKKrD2iOxihpH1h0trc4fc=;
 b=oBP1wRW/YlEy6plL3057Xo/dVj2z9wYE7X25t2XV4Q9kwIPYwxCzLgw8eBIfleEmDC
 dQrotX2AzjIbEELDSGbaMUbadpsVnnmFNzt6gma7OU7FYBmyDBOkGzQV1FxmUp00JTZj
 RInWiSsXieUZeao+4FUajaMci8FfD26caLKAXQgeehbaYnUjUxbjSQTFpvF1IK8nouNc
 krMXJr5IloiLkcbQ5NBWiDP6GXvzzhQF2X7+YVTnd7GnN7cxf979/oXUO1dUQhoQnRqI
 Zkd44rhjyDwTtRJhAyA0QKbEjxkmajMqiWl6Nl96ZtVQNqzplCn6Afo4ux4qZpUWr5+V
 DmSg==
X-Gm-Message-State: AOJu0YyKnO//UCQqxaxuWOuxKbUjBFm120m4NzZHeiB2z0eqHKLUYxsJ
 KInWnsnIIzySPayxy3Oe1XYa6gJ6qeTy7F1UmdQyk7yykz1vEbv5Z4L9ffYpofHL1H15YZa7rQ7
 +
X-Gm-Gg: ASbGncvJscd/rWZ5Ey+qOTI4Jd4Q4XFdh0CvKaK5u2b8p5ISPboZunXdzdg7Cji9Ecd
 yyaXnY/iDY/KW9OEsdFQR70l0Ap705eZN3VYKqopGtgZ4NDs40JmA5SXymeG1YooAh5uVa8qL9h
 vgNmVUDA+q6bUbwJ0AFc06zRf41YX1b+WLhjmYgMi5Qn06eW4WRqny37soSO5hKuUCWQuazO/1A
 UtV8qpgutxLc3tpFdoVA2dmsKVvH2PcHMYinx/mrru1Wvl0p+VAZ69hiOPOOoNwyfP5BJDKXgHJ
 lTyzcWvW/Ke/ha+2Dzi/UBl3rdD/oL6fsJCHgNRy9UzhPL+1GA8ula2B42lYtgbIPXKVcbZXQqn
 E5wAKoLFvYDzT88q9IVs=
X-Google-Smtp-Source: AGHT+IFXROkSkKz3JCfCd33F3RKZJxbLX7Wq5cUlH7iZqRTSZM/w7DJ9aGwNUgWT7xxlILsoabgmPg==
X-Received: by 2002:a05:6000:2a12:b0:39c:1258:2dca with SMTP id
 ffacd0b85a97d-39c12582df9mr4812112f8f.59.1743450553193; 
 Mon, 31 Mar 2025 12:49:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e097sm11895081f8f.80.2025.03.31.12.49.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 qemu-stable@nongnu.org,
 Frederik Du Toit Lotter <fred.lotter@canonical.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/23] hw/rtc/goldfish: keep time offset when resetting
Date: Mon, 31 Mar 2025 21:48:08 +0200
Message-ID: <20250331194822.77309-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Currently resetting the leads to resynchronizing the Goldfish RTC
with the system clock of the host. In real hardware an RTC reset
would not change the wall time. Other RTCs like pl031 do not show
this behavior.

Move the synchronization of the RTC with the system clock to the
instance realization.

Cc: qemu-stable@nongnu.org
Reported-by: Frederik Du Toit Lotter <fred.lotter@canonical.com>
Fixes: 9a5b40b8427 ("hw: rtc: Add Goldfish RTC device")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250321221248.17764-1-heinrich.schuchardt@canonical.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/goldfish_rtc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 0f1b53e0e4d..d83cc264814 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -239,15 +239,8 @@ static const VMStateDescription goldfish_rtc_vmstate = {
 static void goldfish_rtc_reset(DeviceState *dev)
 {
     GoldfishRTCState *s = GOLDFISH_RTC(dev);
-    struct tm tm;
 
     timer_del(s->timer);
-
-    qemu_get_timedate(&tm, 0);
-    s->tick_offset = mktimegm(&tm);
-    s->tick_offset *= NANOSECONDS_PER_SECOND;
-    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
-    s->tick_offset_vmstate = 0;
     s->alarm_next = 0;
     s->alarm_running = 0;
     s->irq_pending = 0;
@@ -258,6 +251,7 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
 {
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     GoldfishRTCState *s = GOLDFISH_RTC(d);
+    struct tm tm;
 
     memory_region_init_io(&s->iomem, OBJECT(s),
                           &goldfish_rtc_ops[s->big_endian], s,
@@ -267,6 +261,11 @@ static void goldfish_rtc_realize(DeviceState *d, Error **errp)
     sysbus_init_irq(dev, &s->irq);
 
     s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
+
+    qemu_get_timedate(&tm, 0);
+    s->tick_offset = mktimegm(&tm);
+    s->tick_offset *= NANOSECONDS_PER_SECOND;
+    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
 }
 
 static const Property goldfish_rtc_properties[] = {
-- 
2.47.1


