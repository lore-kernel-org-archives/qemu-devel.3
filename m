Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5A0F513E4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGt2-0001BM-JX; Thu, 05 Mar 2026 17:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsr-00011M-Qc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:30 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsp-0002Eg-1e
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:29 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439c944bb62so1885506f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748564; x=1773353364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tDkacrofsQyynIL5aV6S8J0KmjfmKGV0MBvFQ9/O94=;
 b=RzWWzYSEQsXVw8WNGlmj6y/P3UK2Yrikma5ztfrudZ+2t2VQoQkvBEo0bJXjN8yL5e
 7mDAjh3eqAAgCw5B1MueTSJxeN6lCk9a4+vl4C7FPZXsE7YLHB8xvOB82/pRKvq7iwWP
 7P7TEMNm4E+B7Iq0VoUS9JUN9PU4mEZPXetcfydCPV1QXerSDcCEDFAtNGkFhK1JT9OA
 Dy7497elVmJERMmX72huhhljZ49TEH8JXUxB3NAgViUBLvg2JuclL9Lj67YE9EDsgLa/
 X+/NIxPtssd9HXRS1Y9RmZM87E3ymtYqn/BskDsdzsy7FBq/v5lPJ5qZXaX9J8kp1UG+
 qpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748564; x=1773353364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2tDkacrofsQyynIL5aV6S8J0KmjfmKGV0MBvFQ9/O94=;
 b=GAyf46Ih6D5nahTilShJ695rTjYGqAuSknb38JNi17bZ66iLxWPG0nyU+Uujt2Qb0D
 qcDqf8d336mCDpVGIYPC1nEJ6cwWQRs252f0ddf1g8zTsEgay1hINstmv5N73oDxNmOW
 VCBgSNi7FAspXWfEWX1bKOYf21bbRy6C5phc5qBv7Y+n1WRYTQQbPRxYhd+0IWeLN401
 KvX2octHs+CCT0XvEg37BVxVCixAnbC3+ZXarTCkOPX1jZFRv0w6jKgjhsmak1UZVZQA
 hv3/hcSRBE8TPNiNmtd0CP9vSpplAMiXXg8FufCqqN1ojKTWlcBpwSRDzVrsZiQfh/fs
 9rWQ==
X-Gm-Message-State: AOJu0YyJr6i9MvQAQHK8g+sDXZd3zDjIpJOZfULi8YFGtM+0rHP5IB4e
 sBF6agiHlKluZv74mLGkN5OtkkvVeOoBdKjLfZrhyrIswLKajFEEsPIuVx4g8A==
X-Gm-Gg: ATEYQzw6ffMk6Gt4G9qN9n5X10hvd1x1HgC4SXbzHXB1cNinSmmEWs9IlFcIOJK7kN1
 Kkm6JPYEDUqEGMKwxrZqon+fH3bhUgkGN023YjuPX/zA9IX3sQBVI7nA8SntlrV/i+NkQrbDweK
 hbHogSmC962iYvhjam2c3nU2qZZ+S1YeKJmwE+ii1FTq4utkIGamMKL1Tkx8yWdhPts9+c7AlsL
 +BpyZbOfaZQVCyeYGhh7PfnCW1y0cJqcwZwTQfxfm3cUx4JOS6j6gUWD17UeerXpH4z2X8w+Lvd
 2cuMjkGiWpt0ewMTc9fobHvNWHIy/aDOK2+nA42ro2PuQEVepar1SDgKM8PF4S94vcuFFDZ3Fv8
 BM6DuVsGEsmaMl6D5bOlNVruBIf15IirkLq4XZkZ6Df+CP6rgYsSmaiGCL21BdJfGyCD4FyO68Q
 YSHom2EXe6JWVdLUWd9YJ04ezwD9trTin262Yv/hByXShh3n0+KOYE5S57uq6aTdCzFD58dAICS
 Dv1iNF7l2VphpXqO+IGmi4FpSlsTJUGackwByPcKjNnKCU=
X-Received: by 2002:a05:6000:400a:b0:439:cbf7:2545 with SMTP id
 ffacd0b85a97d-439d725bb81mr2301794f8f.43.1772748564169; 
 Thu, 05 Mar 2026 14:09:24 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:23 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 04/14] util/fifo8: Make all read-only methods const-correct
Date: Thu,  5 Mar 2026 23:09:01 +0100
Message-ID: <20260305220911.131508-5-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42f.google.com
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


