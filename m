Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BAAC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnGq-0001Wy-5y; Wed, 07 Aug 2024 16:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGi-0001Oo-Rs
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:24 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGh-0006tO-7n
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:24 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso123729f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723062501; x=1723667301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TvYvkgtExP5sUQjhWB+PYXRtHHu4raSI4RPFwJP3Ws=;
 b=cQOFieRsWo3zFPryncg6Yzt2bYMHK3Fc2VarD4w8lkw/vBDA9E30FGvhsDpNk0z3lZ
 WEZd3jEqo+ZihC2+yWZolEY8vriE8AKzmqtyWR160PP/l0mVp2lvCnQ2DhT9RUGRLgrE
 4pdCQwWgHCAWp1YB33DoD8wae8q8qhG2zwYsyOJ9JkEZccm807u3wLRbzJFt8dWN6Igj
 dAdlxSCq3pPykHVw/q/Ib/C9M+TYS5uQqH7YsiQItL19gpiENCp4sT122+3TkMG/rGco
 VXhmVgpY3NQwDJxnVUFrwSnsDZ6SCcZ6iTQVu8TgOrHIOZNv06lEd/aePJ14B3oJNZtw
 r24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723062501; x=1723667301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TvYvkgtExP5sUQjhWB+PYXRtHHu4raSI4RPFwJP3Ws=;
 b=aAdJ7qdlfB39k5Y2eOR1L1YBuTVO/BamF2P+I2hFID7yVpIvcD+JclMuvHe/iNo7cv
 3B0l61fr3pVotsv9LagsixcjF/Ktnhj5Gd2NpjBqzt3pRDfsA6zN4qv3Tox+2SZtBLNO
 Qj+I+3hVleJSTUfuME0RpJ/5tS3cgfWrb3cJeJ///SBiuy2P32mDgG12Oyc05A4pcEj9
 x9qPIJyTcjPPQIX6TskRyzyaWXc33kBz41SaduxY5Uk2PK8Spl58ldUlbIBEjPpuVsdp
 jFszJoeMt9bqzRbRkCrnJB004Tom70O5V2pKme5Ums7OmoTenSF9ScNgPentZcdWMcWO
 Lotg==
X-Gm-Message-State: AOJu0YwCEchnN3dGOBNbEAWmUMPLg9+WRyh/Tvx5jvuSZ8+CWnIia1lr
 qrg70PBPKkTlICfrV58k2fIMLKdSDX2SGAbkGoDb1ilzKI1ijk/KIo0Pb3NVt0IuGNXJFnz22N6
 W
X-Google-Smtp-Source: AGHT+IHOyjy+7uKf5bPFYEQkCrY89yhGTbPxF6nC3jMe2anh6X3XRwl2576WDTJXCadyYi9NijXH2A==
X-Received: by 2002:a5d:5e11:0:b0:36b:cc42:29f9 with SMTP id
 ffacd0b85a97d-36bcc422dbcmr9853284f8f.51.1723062501267; 
 Wed, 07 Aug 2024 13:28:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc8esm16889501f8f.19.2024.08.07.13.28.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 13:28:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 2/4] hw/ssi/pnv_spi: Match _xfer_buffer_free() with
 _xfer_buffer_new()
Date: Wed,  7 Aug 2024 22:28:02 +0200
Message-ID: <20240807202804.56038-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807202804.56038-1-philmd@linaro.org>
References: <20240807202804.56038-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

pnv_spi_xfer_buffer_new() allocates %payload using g_malloc0(),
and pnv_spi_xfer_buffer_write_ptr() allocates %payload->data
using g_realloc(). Use the API equivalent g_free() to release
the buffers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ssi/pnv_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index c1297ab733..13a47f07e7 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -53,8 +53,8 @@ static PnvXferBuffer *pnv_spi_xfer_buffer_new(void)
 
 static void pnv_spi_xfer_buffer_free(PnvXferBuffer *payload)
 {
-    free(payload->data);
-    free(payload);
+    g_free(payload->data);
+    g_free(payload);
 }
 
 static uint8_t *pnv_spi_xfer_buffer_write_ptr(PnvXferBuffer *payload,
-- 
2.45.2


