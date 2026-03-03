Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38BFEDEBFD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY82-0004hB-UR; Tue, 03 Mar 2026 17:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY80-0004fv-NP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:08 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY7z-0002Pc-5F
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so69991315e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576525; x=1773181325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tDkacrofsQyynIL5aV6S8J0KmjfmKGV0MBvFQ9/O94=;
 b=FkRdlkWSmWAKpWZD33PmjCG/DMHTpgGWSp6Dtk4hMPuJ1LpHLIiW85/YVKy8cdUsIO
 lwfDnDFM3/f1JZfOc9vwfXOjyswgDrAxOnBQ+/cgfZLSAaD2/NRkO8AYcGdrn97tMWFN
 VDdTpOyRStjeQ+RC+0rPu9eAXIzg7gbdkxT0oddNUCtKlxW2CRWipCmLzc6AUy+Zz1yv
 cEsgEnJ9dOXPi/tPhv+VlRhurjeY8R+0KrcimZoHB4gOyB06vorJU5Y8arSMQ3czec93
 g6GQrNT0ZX9RBrzAWPwdTvthmWD5qke7Qj2IcfjLtWy63dH6YlEDdgtxZvTSbsHeGyBW
 0gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576525; x=1773181325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2tDkacrofsQyynIL5aV6S8J0KmjfmKGV0MBvFQ9/O94=;
 b=n5pOT625uNBaaPNF5+AM0SgOejfV8YoHMoPXMq4viYsTEiDquhNPcs7sUkfg0ohoka
 Woud13OYLrKeGcu6XBA+Cy6A2BXkBgVMMr3E9Txs5A8d1wEzBYGiQZ+X2vkXPbLAGpRz
 M/f4NYDj8d6a52jFSwhuU8wTLMYdjDUX1oSexamKuy9BiZR2JfVzIc03WeQJZVSDTz4a
 Hofo1lgkHGoCBPwWGfXHg+yPONj8yVachaKD6hBj74yurXpVO2NJqOh3FzVDDsnFr2Yu
 wTxRS8u7vhHGpJ24WvbnB/eAu23I1qWinKszLj55KSxdIcOLr4ncyg8aaJv6UmpeTTtj
 kVow==
X-Gm-Message-State: AOJu0Yyx6siO/MHq4FipEmfgySDHMzIPAiFyIvOaFhq/geYYZs1dKxgx
 RE1VqjfB5TgO2FF5uwWYDY+cSKlkvATQCzOz+FokwhDGkSR75nt1E7YWKARyzw==
X-Gm-Gg: ATEYQzyISsmz7R50o+qbEiC+zhtZrkh9drH2Sn57hGF1ulpVPJDOu9UWccFHetwA3EV
 45z/lVokpBDfKGqMofwm+8C+t2dJ/HRwdc3fE3zf6i+pmJQhHyu2dbGPGc3DwbdHPyQ05ms2U0u
 6jEQiFjIoihDaY0efs6Roabff1YsL4YgybFx4OToldVE3/f6GVxW9xu/2NXnBX7xdKxdQVFBxCt
 AHj5X/CswHPM5jxeonNX9GUzHEPotSIsOojzeKk6x/Tj6Zktx8rFpDqf/lRQeIROejRRFE5SHHa
 ddAvrvpeIltRocqRtwzjDvWQIh0jhB7TxaJaNQ7QD1OfziLZGU1g3jfTD3nDfCwMRKsdy3Yyw80
 Cm4juW+t6+vWPUhU/CvfKnzrqCYVyG9jfs0pbMPxMcSsD2Xqbd4JlUuO36OMApoOc0Ng23xWPrP
 KNeI4us4W+69kDbQi3odFvDyumYx/5Zh9Q+Er036q5YWa5i6omYAOu9oj1A1GNteXjMKm/AzuYA
 Ir/MxYQldpQKgqoacluEqEikkVEP48=
X-Received: by 2002:a05:600c:6095:b0:483:54cc:cd89 with SMTP id
 5b1f17b1804b1-483c9bb1dfemr296528495e9.9.1772576525328; 
 Tue, 03 Mar 2026 14:22:05 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:04 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 03/13] util/fifo8: Make all read-only methods const-correct
Date: Tue,  3 Mar 2026 23:21:33 +0100
Message-ID: <20260303222143.142741-4-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Allows these methods to be used in const contexts, i.e. where the parent
of the fifo itself is const. This is in particular useful for Rust code.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/fifo8.h | 10 +++++-----
 util/fifo8.c         | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 4f768d4ee3..6b476b404e 100644
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
index a26da66ad2..cc4f590b7a 100644
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


