Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C0DC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0N-0001wU-NJ; Tue, 25 Mar 2025 18:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txD0J-0001by-Ae
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txD0G-00074H-By
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:15 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso3423837f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942651; x=1743547451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DK+uWh0VCKgLvFlRmYU1/+eCsypc6Q9Oe4mzDQEUpcU=;
 b=uegHxEdlSfbpWcRVBdukpVBBHylh13PVvAPZQVcJbbRjyw2yWCjpAszeIwck3tjbtS
 5x7zQcKDEPatHXomGY549ElqZ9Qbstcjpv+dTbVZnLYhi/gVRRl3tt6vfV4RwOru0Mwu
 f+byCT/Igsw8GdRNXLZPEg+2ZbXEPS2KZNBTfvF/zW6zs4Tb+SFGokvrY6FKkL6izLJ1
 Rj7xEccrwwl9f/0XPjKURTSA1xwIjPiApICUTX6Ay34Cg9gMrX1rl6Mg/tXoZZO51Eue
 4HtW6NO4kPkU1vP0Y13AUn4wpU5jXswwM6M5FnmopmB7T+YAsVFqU9Wv7Dae6vRU17M2
 4h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942651; x=1743547451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DK+uWh0VCKgLvFlRmYU1/+eCsypc6Q9Oe4mzDQEUpcU=;
 b=X+g8KF4CVaaAeusx8xwTxdLAV0awmfmccfuWBMoLHDIHJ6v/mGXkK1KvxV5r9FjnNc
 9H6KXYutylbgfeqCDnShM+Wi1RkrUWQ2cnB6qnTPu+hL7NhO9SY/36bChW3r139Uh4S8
 TPFEGgqHi/2ds4g495B9PcKj29oTE+Png7c75SsQ6COfJCnpIpJB1XRF1NZCB+xGxMD4
 wIHLlMsaneD9E6uYe1INw2v+S5uEEqn7brpuwvs3ZVmDrIvuVqfxhw9GLOZwBsAEW3CO
 4i0+JYTROnSIVHblPvtidhTTNZC4Wu7NsthiMAxKSWca1czTP8wIh8pN1JKnW495fkHH
 4rtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8290l/gS3oH20gfAR48wUTmIoG1p0pQ1ZlcGGYw/vBdBlNNwmRhnIyTrtn4P8lYIMTpzPeYdqrAC2@nongnu.org
X-Gm-Message-State: AOJu0YxXxqHumgEopd3RG5d+ljiq83ZgBrdCH8WTJ3ZDJXQv1ky27LdU
 Bi6C0aZnsR8yrjngiJcfxyH4tn1o0+X3PkWAmJ53GQqzZNW/Fk5bmkZ4IW1BKkQVkTRLq9JmROu
 a
X-Gm-Gg: ASbGnct3GHPLmj37bPhT1FOi64wPwm7/7oPR9K16s5fDs09V/FVR90r75E10tDSTLEA
 XpubduYYJLmOIepQoq299f6DMntiyepUaApaoti8V9b9Bi/G1r3jqA2cqLCBeb+QVH/cc98gq4U
 JYHUsQYB5f3qkoSPatdgwubJvgZweRSBXyCh9Zalcz0MtvUwZ3S/eJxSuEJTDxxc0G4UtcVN9nI
 NPaanc7TucZPuWErRwljkxVxoJTdhbD2RnBUioBxCV0sCYDIitcptTXlvBrA53XOgbgfBblsV3F
 pX7qJvK8Yza2g6cs65AxD3Hwgm5eVE40m2dWx4H29i2E1Frv6diLrizLzCQi2TgInjZSFCHUvxP
 4u0RowpChJnkCchlUwMU=
X-Google-Smtp-Source: AGHT+IF4MxQTwQeGiFzb6zn4OeYNagVxliRZXRWdOlUF+YSpV2v/ejwNFMuO5oIMwmK710nmV2L+gw==
X-Received: by 2002:a5d:598c:0:b0:391:3aaf:1d5f with SMTP id
 ffacd0b85a97d-3997f9595f6mr16437604f8f.52.1742942650628; 
 Tue, 25 Mar 2025 15:44:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f32fcdsm218803915e9.7.2025.03.25.15.44.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:44:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 10/12] hw/rtc: Categorize and add description
Date: Tue, 25 Mar 2025 23:43:08 +0100
Message-ID: <20250325224310.8785-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/ds1338.c  | 2 ++
 hw/rtc/m41t80.c  | 2 ++
 hw/rtc/rs5c372.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 8dd17fdc07c..56162917c1b 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -230,6 +230,8 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
     k->send = ds1338_send;
     device_class_set_legacy_reset(dc, ds1338_reset);
     dc->vmsd = &vmstate_ds1338;
+    dc->desc = "Maxim DS1338 RTC";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static const TypeInfo ds1338_types[] = {
diff --git a/hw/rtc/m41t80.c b/hw/rtc/m41t80.c
index 96006956798..55f52d95c51 100644
--- a/hw/rtc/m41t80.c
+++ b/hw/rtc/m41t80.c
@@ -99,6 +99,8 @@ static void m41t80_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "ST M41T80 RTC";
     dc->realize = m41t80_realize;
     sc->send = m41t80_send;
     sc->recv = m41t80_recv;
diff --git a/hw/rtc/rs5c372.c b/hw/rtc/rs5c372.c
index 5542f74085a..98067ad06d1 100644
--- a/hw/rtc/rs5c372.c
+++ b/hw/rtc/rs5c372.c
@@ -216,6 +216,8 @@ static void rs5c372_class_init(ObjectClass *klass, void *data)
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "Ricoh RS5C372 RTC";
     k->event = rs5c372_event;
     k->recv = rs5c372_recv;
     k->send = rs5c372_send;
-- 
2.47.1


