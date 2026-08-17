Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC82CC5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4KZ-0006bj-95; Mon, 17 Aug 2026 16:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KI-0006X3-Jl
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KE-0006fi-1i
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso3838285f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999972; x=1787604772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jfEtcL003Vrun0MO0uyBo2c3FO9pifWtza7WvadbGZw=;
 b=kAKq1xg6A4SLDhW9OcXFTZAH7GgEljSBLUiAN8p1wmmOXG+f+xg/OeQYo5+QeKnjWj
 KvO9f7VRADyIa12628kiTjv0bz2B3YToW3ncYFXx2tz7UEt9/u8G5QrbOFUN0u6w0cQq
 2ZrioQncIxpXqQK1Fm0tbvprAYLbMv8dnnR8HGuWdMMl3ss7NILX/wautST7eagD3lke
 /Rve2fGPJ6v8A86C19ILQ9FEfFjiTxoC1BepDx+btN4Z/jP5WaIlxsQ4pdSMppE0wA6M
 ylmGI0TWRPS2FVKR2gH9UHlYQSNg28M0VzbzNjsxbygKUDseC11cqmj93vDxP6JRqa3R
 83+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999972; x=1787604772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jfEtcL003Vrun0MO0uyBo2c3FO9pifWtza7WvadbGZw=;
 b=A8TtTrOPwG7rLiJ344XGmLksIM3prUqNPU61nwsyPXfPrKyPcj5Saq3VVqDUc08oMo
 kNhzorPQba9mKLogka5w6ys+u0/zIqAz/+oZ7Ejgn7EJtCqUqLZoxipq+/uWszFx9Iry
 QHmg+3EsbRPz8ldtsf4ZtmbgH1ZpU5qlf4fkVJX3WzX0fRv5MxcAbgcH/xyxfuzB+yW9
 WbOJomd5WfPqbBCqH5X0X9S/3XqzGppxNl4KUZURRwDpPuRc9xBD7vPWGa4C95PVworG
 7O+9aZupKD8E/POMQXRg0YRWC47hNOA4o6GS2uGqLNPpTjR7vz4pyvuOLuPOPngmsqKR
 G5uw==
X-Gm-Message-State: AOJu0Yx+bRcpBXOmXkrbNPx1bFlCqUF82LI2rTkHdTZsa6LLI4aeNxaC
 lTSnH0lKY/nsuTo06QTVNKmzn7A7UkVVyXJtdrMfz27utyAXyxbsgCfmY8Q1/joNsIWKv33mqpi
 8wMsg
X-Gm-Gg: AR+sD114h7CEuDu2QLAwLaOFmgX5k2pFqloMGyqC3or10HFsYWo2DJm1Do/urC2sPTc
 a3Nu9r4iDhGAHMAT7kdme2xNfYpkTCBx8xTRLqIr7FJfjWPJvd+SPuDgxKxr8LJD0JIJIBSYkaD
 ILgt5ZTHwEhoWTeh/1ERYUMtoNs0gY+Ry4HI0weCdp/xfJgEeo5UFb8uKqcLI75w6Xjg1TNW3ry
 ZDaaYAmtu1NiSFrAZp3TLour9VREy9CeH81DriMlaqwW/VPsPpp48dMGoE4x2RK1DYEnaC9S3vi
 ls/rlT0bq+tDYkQ+YeJIci15O4joSbOruBDb+Z4qd/KWZ2PwI1VwSEIg0V+KzYdcN30Gl6oR+Az
 /Z4cTIGykornK0aO0AhGFQDAwagVnoNjmaTA0/Y/5hQtHAHixIsWQ5riCtamJd3PU9N1rPmnAr9
 iiHvXOvkLZmWzZ/UhwtksxUCrQiJUnZgnupqqxuqJhW6QhFj10mA==
X-Received: by 2002:a05:600c:c3cd:20b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-499a277e9bbmr638105e9.3.1786999971915; 
 Mon, 17 Aug 2026 13:52:51 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:50 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 05/15] hw/ide: report the default CHS translation in IDENTIFY
 DEVICE
Date: Mon, 17 Aug 2026 22:52:32 +0200
Message-ID: <20260817205242.1199851-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=den@openvz.org; helo=mail-wr1-x434.google.com
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

IDENTIFY DEVICE words 1, 3 and 6 describe the default CHS translation,
and ATA-5 8.16.8 requires INITIALIZE DEVICE PARAMETERS to leave them
alone; the translation in effect is described by words 54 to 56 instead.
Words 3 and 6 were filled from s->heads and s->sectors, which the command
replaces, so a guest that selected a translation of its own was told that
its choice was what the drive came with, and could no longer find out the
default. Word 1 is already right, as no command changes s->cylinders.

Report s->drive_heads and s->drive_sectors, which ide_init_drive() keeps
for exactly this, along with the retired word 4 derived from them. The
CompactFlash data labels those words as the default geometry too, and
INITIALIZE DEVICE PARAMETERS is accepted for CFA drives, so fix both.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 747fa71677..befbab9486 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -138,11 +138,12 @@ static void ide_identify(IDEState *s)
     memset(p, 0, sizeof(s->identify_data));
 
     put_le16(p + 0, 0x0040);
+    /* Words 1, 3 and 6 describe the default translation (ATA-5 8.16.8) */
     put_le16(p + 1, s->cylinders);
-    put_le16(p + 3, s->heads);
-    put_le16(p + 4, 512 * s->sectors); /* XXX: retired, remove ? */
+    put_le16(p + 3, s->drive_heads);
+    put_le16(p + 4, 512 * s->drive_sectors); /* XXX: retired, remove ? */
     put_le16(p + 5, 512); /* XXX: retired, remove ? */
-    put_le16(p + 6, s->sectors);
+    put_le16(p + 6, s->drive_sectors);
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
     put_le16(p + 20, 3); /* XXX: retired, remove ? */
     put_le16(p + 21, 512); /* cache size in sectors */
@@ -332,8 +333,8 @@ static void ide_cfata_identify(IDEState *s)
 
     put_le16(p + 0, 0x848a);                    /* CF Storage Card signature */
     put_le16(p + 1, s->cylinders);              /* Default cylinders */
-    put_le16(p + 3, s->heads);                  /* Default heads */
-    put_le16(p + 6, s->sectors);                /* Default sectors per track */
+    put_le16(p + 3, s->drive_heads);            /* Default heads */
+    put_le16(p + 6, s->drive_sectors);          /* Default sectors per track */
     /* *(p + 7) := nb_sectors >> 16 -- see ide_cfata_identify_size */
     /* *(p + 8) := nb_sectors       -- see ide_cfata_identify_size */
     padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
-- 
2.53.0


