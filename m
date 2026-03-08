Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7926AEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMlj-0001pW-R8; Sun, 08 Mar 2026 18:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMla-0001In-V3
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMlZ-0003dE-FO
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:38:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so17234975e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009507; x=1773614307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3zOV3qUmRo9bOigA0eOBWw/VAz+Y8n3y3THv+nRsqxQ=;
 b=RZnPagHF6P5KM5C6KKw4qPWZwG3ms3j5jATaBVQiRXfpJggT1MlohSUKRLSy3x6pnb
 3pYf1yN9nfnmSuxTlKiFZKVkwyvDLHp8H/yCGNy021DK1rwyUkEZsm0Eo00UJAKLy45w
 3T+efyKuxi9ZGIdw32+zk1lAmz0CODLl3nZuWYy60auHWSU6HzOhHsfPHclvy7dooYvL
 /kYe/QX4Nsr9bWZwgupqS1mcsMDGftxXG4pv/pG1aqVdHUUMnt5LZ4fu2ycf2gLlpShv
 fpDvLsBtLs2g7whemR0IOzG96xM2L+iJOF3TE9kxyJ9WZQDWrpj6C8Gzs7obDqKEiEIY
 ammA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009507; x=1773614307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3zOV3qUmRo9bOigA0eOBWw/VAz+Y8n3y3THv+nRsqxQ=;
 b=qSwpEyKjMWAUrTdPezgpySfJW7RN43MuASGJv1anfXz8To3XUyta6yAwds7Z20qYQb
 9JqkHCQp+r/bl5MHn/ohUKyXgNTj8pZ9AfmX6JEz129g+wkEStRvCfbPT6+lFWSXXCiI
 FR8FW5b3gtgdflrC8IhMaeA/yhi2xi6vNoZGY/JzJKSuSZtJWFbAZToMoS5hrcYulyA0
 SoDXxw1MKa4d5L6AsuHf/P7RIzzjJOYFMbwxk3Jz6HTfVyXnp7y2+JxMgFGEsIP7dTRE
 XJb/dQ+zwMFmkURlaDSe2BP0IpDBcOZ42gy6u5b2KLy+tcPZjPa/ipXcX8FHeK+go2pk
 EhbQ==
X-Gm-Message-State: AOJu0YygJ+edToHeeKmxFWKNnVC2W6LZpJ8J6y1NFYNHmMXXrN00aNoB
 UXifdQ0f5uI9jyoxJrcyxFL3FkUcb27OGUpG9Uan16Wbh9AWax7f+Q/8PGkIGEWoY1ovh45oGlI
 KXz+U760=
X-Gm-Gg: ATEYQzz3kSToSdN1prTrlvlSuENMINcQTpKjBiAHPz/Bzl34JY+zWr+xchUnh5a02fO
 8QWOVogUvJx45ZlK2I2EucLlKd9ZGs6FKwVrujtu3gPTgOPaTgEqlhdarnRi1XjxYDvpdcJcf/W
 z1fwA+lqQjFO3ZO0qpisize06meJmq9VjueLmK5wfz0knLObE3fOw0rjwiv1c0BeGl4cKGQlaNo
 yhk6Uv8vIo1kyHYU6lAuwqfgzMmmpIRHUrOCpotmPJHgZcdmBSy80pVpqiio6w0/Rgk3oOLBt5d
 2v0KivAcQTEH/UL4FBLriRsNsKNr6UnWp7QyktDjDtwF8FonM5cWhbKRH5KITmL5JaugkMwEtRV
 6Y4l0DFhYOpTGjPn3ZCAiiEhLcxZHzCapO64rZrVcT3DKuCCZDiCKqtvG+jp1iPGLglZ9eZM8xV
 SEaoAiQokwczwMeXOcQVKUr0huPnS0prH2ySF0MixKqISPzSEkQFcIA1vk9/fxmemvi3KPo3Oyg
 ROhMA==
X-Received: by 2002:a05:600c:46c3:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-4852695aeaemr165621675e9.20.1773009507180; 
 Sun, 08 Mar 2026 15:38:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852378de92sm109056735e9.0.2026.03.08.15.38.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:38:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/49] util/fifo8: Make all read-only methods const-correct
Date: Sun,  8 Mar 2026 23:34:18 +0100
Message-ID: <20260308223433.25503-35-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Allows these methods to be used in const contexts, i.e. where the parent
of the fifo itself is const. This is in particular useful for Rust code.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260305220911.131508-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h | 10 +++++-----
 util/fifo8.c         | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 4f768d4ee38..6b476b404ee 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -71,7 +71,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  *
  * Returns: The peeked data byte.
  */
-uint8_t fifo8_peek(Fifo8 *fifo);
+uint8_t fifo8_peek(const Fifo8 *fifo);
 
 /**
  * fifo8_pop_buf:
@@ -181,7 +181,7 @@ void fifo8_reset(Fifo8 *fifo);
  *
  * Returns: True if the fifo is empty, false otherwise.
  */
-bool fifo8_is_empty(Fifo8 *fifo);
+bool fifo8_is_empty(const Fifo8 *fifo);
 
 /**
  * fifo8_is_full:
@@ -191,7 +191,7 @@ bool fifo8_is_empty(Fifo8 *fifo);
  *
  * Returns: True if the fifo is full, false otherwise.
  */
-bool fifo8_is_full(Fifo8 *fifo);
+bool fifo8_is_full(const Fifo8 *fifo);
 
 /**
  * fifo8_num_free:
@@ -201,7 +201,7 @@ bool fifo8_is_full(Fifo8 *fifo);
  *
  * Returns: Number of free bytes.
  */
-uint32_t fifo8_num_free(Fifo8 *fifo);
+uint32_t fifo8_num_free(const Fifo8 *fifo);
 
 /**
  * fifo8_num_used:
@@ -211,7 +211,7 @@ uint32_t fifo8_num_free(Fifo8 *fifo);
  *
  * Returns: Number of used bytes.
  */
-uint32_t fifo8_num_used(Fifo8 *fifo);
+uint32_t fifo8_num_used(const Fifo8 *fifo);
 
 extern const VMStateDescription vmstate_fifo8;
 
diff --git a/util/fifo8.c b/util/fifo8.c
index a26da66ad2c..cc4f590b7af 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -71,7 +71,7 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
-uint8_t fifo8_peek(Fifo8 *fifo)
+uint8_t fifo8_peek(const Fifo8 *fifo)
 {
     assert(fifo->num > 0);
     return fifo->data[fifo->head];
@@ -157,22 +157,22 @@ void fifo8_drop(Fifo8 *fifo, uint32_t len)
     assert(len == 0);
 }
 
-bool fifo8_is_empty(Fifo8 *fifo)
+bool fifo8_is_empty(const Fifo8 *fifo)
 {
     return (fifo->num == 0);
 }
 
-bool fifo8_is_full(Fifo8 *fifo)
+bool fifo8_is_full(const Fifo8 *fifo)
 {
     return (fifo->num == fifo->capacity);
 }
 
-uint32_t fifo8_num_free(Fifo8 *fifo)
+uint32_t fifo8_num_free(const Fifo8 *fifo)
 {
     return fifo->capacity - fifo->num;
 }
 
-uint32_t fifo8_num_used(Fifo8 *fifo)
+uint32_t fifo8_num_used(const Fifo8 *fifo)
 {
     return fifo->num;
 }
-- 
2.53.0


