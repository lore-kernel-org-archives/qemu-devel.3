Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A565CA0FFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 14:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk34u-0004r7-Vj; Fri, 30 Aug 2024 10:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34t-0004mD-9D
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34q-0004Zm-8t
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-371a6fcd863so1283137f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725029894; x=1725634694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5m93k8r6P9crCpqy8j86ZMz12VwEi3ZCriS1fWHYtsA=;
 b=CUEY7ju4/4W3lBadB916noG3on1jgBmwgRaCSx5bEitmjQwgpn0vqfdwwNv30qUOoL
 5d1jr/eIedytQDWg9+7u8+ubp9CBchzGIW1QHd1Qi5DIfcjjQNrc/TWvHj1U6k1/9wF1
 ZKcgodRNcdRGBVR5GwH8477HZQ9XZWQBCnyW2ZzuOY5R6TXjXbIJLxO3NqdOytMiiP59
 agFHq18+WqELFrp3tkwod0LX0XWyRIG9uz+6lk/km8/sqi8kJjakGAP1nXB9pvhugrj8
 10AsiO5bENnIJXcBgWY1DslzLZMcK5Ye7uML9zjlaWC6Kdc6YSftXYgSL6nH6KYZPuq8
 E89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029894; x=1725634694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5m93k8r6P9crCpqy8j86ZMz12VwEi3ZCriS1fWHYtsA=;
 b=bqJ8dLyzSek9JnAFKNYkkjEKp2ga3uRUpgjK4gX3KANXYPivl7pm7XrOwrZTmuIpko
 zogd6u8AAeSypsRuc8ShDDMzke8P14/YHEJPhwJKDN0pK/4xCFYddDmDJLSAs6FCak9i
 cGZlQeW+CAyowcXYBPickHoFIJjrQE8dYm6QkR/RqtVG1yT1WsyBb6M2bk4t2vqHWYYz
 Fjj/AWR4AppBSP26PW1yrS5GqkkyPmP+NBo4Y9dfNM1utlBI/KkLAbkCj3KnnW5ojEru
 TWPdD6TEzt7xN92bnOW62yf1wUWbk374VURzJ+b7cDzAYNLTXMAB8Fjd0TaLNkBqjJO/
 qACw==
X-Gm-Message-State: AOJu0YyJFhy9Vghd9gMURwS/6tDWQtD0cd48XvZpHEcNCAJbpS4ye4I9
 uZHoGi3ECaIdVJdwBNsMEP7AHjXUaQngsC5UxRZ7wfyD0qt7OLaY3V9GrVI75js5XGG1zHssbB6
 +
X-Google-Smtp-Source: AGHT+IHp6p5UWHFUFNXb7osm0QtFLNxy2E5D7VdUd5GLh/XFm0QpGHCRgUa5zMEpcvUBiFW6pRkFVg==
X-Received: by 2002:a5d:598c:0:b0:371:899b:5c5 with SMTP id
 ffacd0b85a97d-3749b54d9dfmr4362703f8f.27.1725029894541; 
 Fri, 30 Aug 2024 07:58:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm49022345e9.0.2024.08.30.07.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:58:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 01/11] hw/s390/ccw-device: Convert to three-phase reset
Date: Fri, 30 Aug 2024 15:58:02 +0100
Message-Id: <20240830145812.1967042-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Convert the TYPE_CCW_DEVICE to three-phase reset. This is a
device class which is subclassed, so it needs to be three-phase
before we can convert the subclass.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/s390x/ccw-device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index a7d682e5af9..14c24e38904 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -44,9 +44,9 @@ static Property ccw_device_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void ccw_device_reset(DeviceState *d)
+static void ccw_device_reset_hold(Object *obj, ResetType type)
 {
-    CcwDevice *ccw_dev = CCW_DEVICE(d);
+    CcwDevice *ccw_dev = CCW_DEVICE(obj);
 
     css_reset_sch(ccw_dev->sch);
 }
@@ -55,11 +55,12 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCWDeviceClass *k = CCW_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->realize = ccw_device_realize;
     k->refill_ids = ccw_device_refill_ids;
     device_class_set_props(dc, ccw_device_properties);
-    dc->reset = ccw_device_reset;
+    rc->phases.hold = ccw_device_reset_hold;
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
 }
 
-- 
2.34.1


