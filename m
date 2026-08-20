Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DF7C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzhu-0006tq-3e; Thu, 20 Aug 2026 06:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzho-0006rL-O9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhm-0008MU-RU
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-480033bdcf4so1263856f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220541; x=1787825341; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QChQ+CxzTsz1lHSirgNALaNLeAgh/SinPCaywT1bKt8=;
 b=H7vuxUuBHAQ7PtsRk5gbi9LHNVcebOYYS3k5HKnWYzfjTRJu2WDuB4HgIhZNXkYR9b
 pzFt32NCwUUj8iv/RURTR6FhriThw3X5qqyZr80gcl+6HINQA617bZ+zmeFSECoQ191j
 RuaPm8tmLap6r8onl91jIjKfIYeYyKzr5SQ1TwpxRP2CgilZ9nfze6Up6vLPP1nY2aJy
 P28nj43PugMgM22VbLkApgHzRpe3Rhut9DtUnI7NNc73dQEXRcUFIAQ/S9h/kT3EQfQI
 1psTwHunR6ZIBpNW8gNQu8nFygODZVO1pH+HxE72OuStqASXD6SvvV6OFOzl42EV0wnU
 N0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220541; x=1787825341;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QChQ+CxzTsz1lHSirgNALaNLeAgh/SinPCaywT1bKt8=;
 b=k/cyNDEQ4P++VGab/xAqZesQ1vh7URMW5HUF3ZsxO1pdgKxd6pCYVzh1woEtBMdyz5
 9PHjKmsuROgjj/83U8KESo2Lb6cs9kE3/fq6//wiBpd8Fq+oNmHmjQaA6ISU71Y604Sq
 gNcHJi9/p6pGk2OHz7zXcDseolWUNgA+9iQhTOcD9GoTFVC8EtxiHIi5EuMAstuCb9aP
 18rScfcXBHzN4Fvw73+HFIrC5x70a+7umimUEz2oGZRjplnYDeIjNSnGXaCUdoNO99sa
 aqCbGK81lDJ3uHZ5WICOtQZ9YyT2sUSuoz2qf3/IodZRL4m/fgTUePmRJksvDIbLe70d
 YqfQ==
X-Gm-Message-State: AFuF++mLdfSHWIZmFzmtNWrC9EXdLP91ZeaJYXZkx71PTl69kviOscZt
 Vxm2WXTTngZHv52fiRYw6zlvrKd3TbUiHW4WhxfZ11ab9QW7LFWedD6NGVlpjrfd4ur9n1Dc1wG
 CjgDV
X-Gm-Gg: AR+sD11kkYDslQD7+O5GFxZwqtdpBAMVhCTm5VHoegCH2b4mQyWt7DUkQLNfLYMYJuf
 uZz8akanmYEseDkySq8+icwZazJxSi431gZ2p5j2e2fFyT9KcQJRy7GrPFUeQF2733soP8qv7C+
 TTZBdXJf55rxBCx/xE36zl8lQVkAqNhwmogWNPRzDV5z5kOhVQQCUWxhv3oaInqw0xXmpjJJfs+
 rEHPo8iof+qjtKBhVfv7/WE+FHUp7RKsCekww3wAq5xB5Ei77SlC/LnCVZV8uIJTGpHLP7Kjpe3
 mKjJ8JqL+rGnaeE7GoCKM1YqsGFTLRWnac2aTk5OedQ10YEb/2omOb3IOniv9Nm9LEpD9Bdj3QT
 4buYPoH4ZEi3SLXYdbOXHPEDsNnOzUEM6n1d18UmjKx4hirL3W++8XISHEC+gHrEpJjYTjEORIo
 EfhAYGywDUT2dXcR4VTOX/GhEM2N5zUiBVo42FKPtoHTgxxMHl86Nd62120w==
X-Received: by 2002:a5d:64e6:0:b0:474:530:9d with SMTP id
 ffacd0b85a97d-482b1fd894bmr19893867f8f.13.1787220541035; 
 Thu, 20 Aug 2026 03:09:01 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:00 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 07/17] hw/ide: factor out the IDENTIFY DEVICE current
 geometry words
Date: Thu, 20 Aug 2026 12:08:34 +0200
Message-ID: <20260820100844.411717-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=den@openvz.org; helo=mail-wr1-x433.google.com
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

From: Denis V. Lunev <den@openvz.org>

Words 54 to 58 of IDENTIFY DEVICE describe the CHS translation in effect
and the capacity it addresses. Both ide_identify() and
ide_cfata_identify() fill them the same way while building their cached
data.

Move them into ide_identify_chs(), so that the next change can refresh
them in place once the translation changes, the way ide_identify_size()
does for the capacity words.

No functional change.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 292908fb1c..e5fd570575 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -110,6 +110,18 @@ static void put_le16(uint16_t *p, unsigned int v)
     *p = cpu_to_le16(v);
 }
 
+static void ide_identify_chs(IDEState *s)
+{
+    uint16_t *p = (uint16_t *)s->identify_data;
+    unsigned int cur_sec = s->cylinders * s->heads * s->sectors;
+
+    put_le16(p + 54, s->cylinders);
+    put_le16(p + 55, s->heads);
+    put_le16(p + 56, s->sectors);
+    put_le16(p + 57, cur_sec);
+    put_le16(p + 58, cur_sec >> 16);
+}
+
 static void ide_identify_size(IDEState *s)
 {
     uint16_t *p = (uint16_t *)s->identify_data;
@@ -128,7 +140,6 @@ static void ide_identify_size(IDEState *s)
 static void ide_identify(IDEState *s)
 {
     uint16_t *p;
-    unsigned int oldsize;
     IDEDevice *dev = s->unit ? s->bus->slave : s->bus->master;
 
     p = (uint16_t *)s->identify_data;
@@ -158,12 +169,7 @@ static void ide_identify(IDEState *s)
     put_le16(p + 51, 0x200); /* PIO transfer cycle */
     put_le16(p + 52, 0x200); /* DMA transfer cycle */
     put_le16(p + 53, 1 | (1 << 1) | (1 << 2)); /* words 54-58,64-70,88 are valid */
-    put_le16(p + 54, s->cylinders);
-    put_le16(p + 55, s->heads);
-    put_le16(p + 56, s->sectors);
-    oldsize = s->cylinders * s->heads * s->sectors;
-    put_le16(p + 57, oldsize);
-    put_le16(p + 58, oldsize >> 16);
+    ide_identify_chs(s);
     if (s->mult_sectors)
         put_le16(p + 59, 0x100 | s->mult_sectors);
     /* *(p + 60) := nb_sectors       -- see ide_identify_size */
@@ -321,7 +327,6 @@ static void ide_cfata_identify_size(IDEState *s)
 static void ide_cfata_identify(IDEState *s)
 {
     uint16_t *p;
-    uint32_t cur_sec;
 
     p = (uint16_t *)s->identify_data;
     if (s->identify_set) {
@@ -329,8 +334,6 @@ static void ide_cfata_identify(IDEState *s)
     }
     memset(p, 0, sizeof(s->identify_data));
 
-    cur_sec = s->cylinders * s->heads * s->sectors;
-
     put_le16(p + 0, 0x848a);                    /* CF Storage Card signature */
     put_le16(p + 1, s->cylinders);              /* Default cylinders */
     put_le16(p + 3, s->drive_heads);            /* Default heads */
@@ -350,11 +353,7 @@ static void ide_cfata_identify(IDEState *s)
     put_le16(p + 51, 0x0002);                   /* PIO cycle timing mode */
     put_le16(p + 52, 0x0001);                   /* DMA cycle timing mode */
     put_le16(p + 53, 0x0003);                   /* Translation params valid */
-    put_le16(p + 54, s->cylinders);             /* Current cylinders */
-    put_le16(p + 55, s->heads);                 /* Current heads */
-    put_le16(p + 56, s->sectors);               /* Current sectors */
-    put_le16(p + 57, cur_sec);                  /* Current capacity */
-    put_le16(p + 58, cur_sec >> 16);            /* Current capacity */
+    ide_identify_chs(s);                        /* Current C/H/S and capacity */
     if (s->mult_sectors)                        /* Multiple sector setting */
         put_le16(p + 59, 0x100 | s->mult_sectors);
     /* *(p + 60) := nb_sectors       -- see ide_cfata_identify_size */
-- 
2.53.0


