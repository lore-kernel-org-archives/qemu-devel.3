Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99866C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdW-0005WI-Jo; Tue, 15 Sep 2026 13:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdR-0005Rm-1e
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:57 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdP-0003X5-E8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:56 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48583cc7ab1so1619843f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492074; x=1790096874; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jSMbeBzCA9SMAxy4NxgAHn7W6+xd0zoEKOQFxoiweYM=;
 b=KFTQWbGQahZdB7dHX/SgZKIurlygk0Whxo1IKuknZEM1zjYPBdthfAA80B0LcRCxzQ
 fsS2HUC2DK1X4hl5Gl6x5d3CllpYGAvf//y/zKuXBEri9SPRfKje8xIAQ80M12A1YUB0
 U1YjpoiSK5bYtGVt8amVjg5lrrKRuYsw068BIGZ8b+LwYgYsepwkHZGOl8/PL8HvNh8S
 OpCbAqn+7AV9XO/dicuG8654/g7YMPEN1NO1CNUYTMQuB8vXkklppn2AXhqcvAgtCmqy
 KG6SYiXaduojxyOPC3AJxfHZoTe9yksjtK04CREsYK4BhUmn2jAPmYWmQ8+I3rH5uFq1
 CG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492074; x=1790096874;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jSMbeBzCA9SMAxy4NxgAHn7W6+xd0zoEKOQFxoiweYM=;
 b=lm84074pPaM2iMpfYwxwDb4kjMiwJ2ppN1NCUkpIp9DBr2SKqzJ7uu3tdg3gZqNWEl
 wwF80weACqQVaRt5KWBny5a9YhRFq4W09R0M1yZoRqDt2o56EnsMUo7WNACuFc8dLk7h
 Q2ETqZUguJaWktl1YLaV+v4eRn/8BQgRQ7eS1GtbLPnS066UMmFLtMO58bCsabPT9ph1
 hNEGJGUOOlTGAMItESBcS+Zv17PUX028H3g+aiZcaXm6PlcR94u6d5T9Jsspbz4I866V
 Ic60V2TLxkfhmow8yfd1AsPuMNCosUjhopTnnRmnrd13AVRWbcgLAWtT4XGbA1wwfJbX
 Y+KA==
X-Gm-Message-State: AFuF++kvE6sUPkjAhBn2nlZcZDzDQoHsNZE8LJHzzh398Qs7HMncLFIh
 JI6c22ioYdw1CvYNcMnzrXioSOAne8RrPafUrTNMoedcmWQwHeJ6Dx7t5M1zP/Gos2buNgCqvnZ
 FVnkXhFE=
X-Gm-Gg: AYBFou303VNIEXX/6yesGY9oU0VhDOSD9rh7ZsW6P4pjRhjXg/gfTDkddFUJ3aT0CfQ
 BNbdvLj69W4aqofZJHgAq55ShlpHK9uguiJtftNRAuzfRxJrTrJTXJd0kqo7KLshVTI7ZYMi5F9
 xLSn/3M7Jkv7sFEBG78QuPM+9lc4NUrlAy2pgBjX9qaBtiIId2HqRqxgok40OkShloLtSpikCpZ
 OfWhbCvIxej7QAhEzF4p8fORdQoVyLYvQXrRkbG2BGuQMq4vVhhM2siInSMUuivYVdcG66WTmYN
 RgWDCQbpn2XjZ3kZpxBHSnEdWgy59Bfmg3bkmWxqKUHlwHV/OVkNXbfjcXJS5Ku/1Uihn32U6Vp
 ppnEtSfbLiuCGWA5NVPupdg4qGIwghEdZf+QA1PObiJKfgK6MpRqyqb6pQISllVy6ztyDwKRKOj
 w5TEhIAQBiy2zJPxxUamHqy9ngM9DdfPKSLRhCM7F1mUr6klZYhmq2ylJ/yYVw92LcFZmprgxQ1
 X5yAFHJJzvHAOsWnMlD03cI5NpNE3mhB+sjcFMpIYoxCkIq3QUuemf6mqbKr8kYMhbqbHnAfT9I
 9eJg
X-Received: by 2002:a05:6000:3c8:b0:486:fcdb:ee5a with SMTP id
 ffacd0b85a97d-48702ab93a1mr10620683f8f.15.1789492074112; 
 Tue, 15 Sep 2026 10:07:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] hw/misc/bcm2835_powermgt: free wdog timer on finalize
Date: Tue, 15 Sep 2026 18:07:29 +0100
Message-ID: <20260915170735.425445-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The wdog_timer allocated in instance_init  is causing ASAN to report a
leak when the object is destroyed (e.g. during qom-test and
device-introspect-test).

Add an instance_finalize handler to free it.

Fixes: 21fcfb604608 ("hw/misc/bcm2835_powermgt: implement a real watchdog timer")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_powermgt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index 7b01be48bb7..1de5a55a4f5 100644
--- a/hw/misc/bcm2835_powermgt.c
+++ b/hw/misc/bcm2835_powermgt.c
@@ -152,6 +152,13 @@ static void bcm2835_powermgt_init(Object *obj)
                                  bcm2835_powermgt_expire, s);
 }
 
+static void bcm2835_powermgt_finalize(Object *obj)
+{
+    BCM2835PowerMgtState *s = BCM2835_POWERMGT(obj);
+
+    timer_free(s->wdog_timer);
+}
+
 static void bcm2835_powermgt_reset(DeviceState *dev)
 {
     BCM2835PowerMgtState *s = BCM2835_POWERMGT(dev);
@@ -177,6 +184,7 @@ static const TypeInfo bcm2835_powermgt_info = {
     .instance_size = sizeof(BCM2835PowerMgtState),
     .class_init    = bcm2835_powermgt_class_init,
     .instance_init = bcm2835_powermgt_init,
+    .instance_finalize = bcm2835_powermgt_finalize,
 };
 
 static void bcm2835_powermgt_register_types(void)
-- 
2.43.0


