Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9212C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZmw-0003TQ-Ju; Tue, 02 Jul 2024 05:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmn-00037z-BP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmj-0001aC-Cf
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-366de090da9so1961797f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912407; x=1720517207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZj5eYp/kb8EVrafSTzyBAO6e70CoLy2x/MnndJCff4=;
 b=ZEaqyu4B7CZ623jBRJ7EdAJGf3xfD4S9psP8Fok95D9ySsrdruXukwmI9fEusWP2/v
 Oi1v55pzYRWLAlMMX28uYzfLqFBnWt003BAwyIuWByVTo77qnmN/Sh1aG8i6FdxEWA28
 suDjRvlOis805xNqSjJatpEyzPj/x3jW7EuJfsOnndDDwzvnoLvaPEY3pycMkjwPCda6
 hClpBxHOYxKVeVC/cy1dHK/9XqhH9U6PRxL5LWFcPaPfAaLTPTyn9Btkb+0EszPf2e1x
 lUN9XHzpYMkhWM9faDVugRcLXPdRsIFkIJ4Su/5/gzPyJIgYHzGZnqdTtIK31mRvzFL/
 tDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912407; x=1720517207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZj5eYp/kb8EVrafSTzyBAO6e70CoLy2x/MnndJCff4=;
 b=UvufVBsX0cVkKv6GlvB2rA8DR4K9eHdDYqZqfg17vMTIOecisa+bhYTkzVvVuL14CH
 z6iQyWxn/LqZiZ+yG1kZQCyNR+cY91vthTznxFTWoponTYsV40ta7h6Ul8ewDvFhbgOb
 rfC7JAQqazc3vScaeoi3lu7D/Un5WX84K1M1roy5mXsKpYFw5DNOUlo+Eu/nI0noImWC
 XW0FppIgKz4ewW60Lu0rK1i1mwQjSu2IGOL5ef3pCECOyTT1lJH5L6RSSVIzGbXS29uZ
 8BDcSpZgN1XQAf0Hg5RUYU9LWfEg87RV38FWgWquKCEf0v11YRoKdDKXi2QfWQ9LPB12
 RxcQ==
X-Gm-Message-State: AOJu0YxtYWm4E4I14/ZrruoAetuRNXDrCQO5ddo8M9PBDSiB56SCCOAW
 0rjE2uUlIY92X4siJAV/imfL83esxT6nQmppLLfX3FmO1V2EqJTNkFOPM8l7/E9A0FY+VyQ+gAI
 B
X-Google-Smtp-Source: AGHT+IFcsraeTBqPQxNuI6yzv20lYVGH9/jd7ZncftZGiTWWa5mMixsZf6rLps4GzhzSiu2UNY7rUQ==
X-Received: by 2002:a05:6000:2a7:b0:362:d382:2569 with SMTP id
 ffacd0b85a97d-3677571c841mr4911201f8f.44.1719912407081; 
 Tue, 02 Jul 2024 02:26:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e12d7sm12654967f8f.51.2024.07.02.02.26.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 60/67] hw/sd/sdcard: Add spi_cmd_CRC_ON_OFF handler (CMD59)
Date: Tue,  2 Jul 2024 11:20:43 +0200
Message-ID: <20240702092051.45754-61-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-68-philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 08fb3cf9d3..31cebe609c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1647,6 +1647,12 @@ static sd_rsp_type_t spi_cmd_READ_OCR(SDState *sd, SDRequest req)
     return sd_r3;
 }
 
+/* CMD59 */
+static sd_rsp_type_t spi_cmd_CRC_ON_OFF(SDState *sd, SDRequest req)
+{
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint64_t addr;
@@ -1750,9 +1756,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
         break;
 
-    case 59:    /* CMD59:   CRC_ON_OFF (SPI) */
-        return sd_r1;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "SD: Unknown CMD%i\n", req.cmd);
         return sd_illegal;
@@ -2330,6 +2333,7 @@ static const SDProto sd_proto_spi = {
         [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {0,  sd_spi, "READ_OCR", spi_cmd_READ_OCR},
+        [59] = {0,  sd_spi, "CRC_ON_OFF", spi_cmd_CRC_ON_OFF},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
-- 
2.41.0


