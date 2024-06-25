Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA4BC30659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzO6-0008Em-VL; Tue, 25 Jun 2024 02:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzO4-0008DW-TU
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzO3-0005cf-AG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-424a2ad06f1so1883105e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295837; x=1719900637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvMkaMqLM5PVpCv4Vd4dHYUlgMEEODMLVtAtegzf7mU=;
 b=SWZw5uz7p2tQ5yhkbMCjHfe3a2wRxEw+YbwAZ0D1BcVa2l1KGM5W9ejzcXXeH6T42U
 q+lKbY19QjE3VpSmprW7toFJoW4ZECDpbhC5zYxDPEKmzvbTiyhK071DUVl0x4NjPmZ/
 di+Tjc27055GBld8lunUG1BmWqZuQrc5EILtwM/D005PtOyo5jY5DqXiLCbKGSKLmawQ
 OnrPzU+CqCHeJiNoE9ZYahR/UgilpySaecKnNlgKyM99A/Puo+K68G4Iqva9ItX/A6iv
 QJI92nggMGy/nhz0sOcYTZZWL2yb0Z0DAUErlE2Zi/mffcF0KtjJEqFMXmFtDpVSEF6c
 zvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295837; x=1719900637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvMkaMqLM5PVpCv4Vd4dHYUlgMEEODMLVtAtegzf7mU=;
 b=qsNth5IzF40BXgTgD+79lWLJr6soxEXh+MPCglNlTrHSKxK1MfINsF9T2ORx+foauv
 ebnC0CssDbSsyvQTeWuOiqazp/FuhjaA4ZbVU/wrYeFLher0tdCUfWuyxUL/ecLmRYQw
 /nsUxFRoj/3/VCBR6VCJ5Ty6KD+rAge6I/wC8eOliJGVpxNZKNildQUdXNbPLhvMKsSK
 pUWgjBU2tmHC5US1jXzfHR93FXoyl/jpIyYlVpm64xFigA5usldwjTxuSzGAkpCZoEcE
 AyyQoa0INmMynv/Eui7y9K+c6n/GApCsDWhcvLNaVEk/LkLfxxWs3Cv9/V14nDgs+Rnw
 W50Q==
X-Gm-Message-State: AOJu0Yyp3MZ5opYcx9wn7dUfyjwH+/5pgKCR9KAIm1EE8wkeYNZztzKf
 e8gWDs6UfDS+mfcF5JIqO8YXN/46ovPcCnrnaHDvj5Huxnf24YaH6lCDB9jCZ9yPhHVQYfq5+aF
 5
X-Google-Smtp-Source: AGHT+IEEf1Voc1AvnHUGsQ+qFtkqyVJNb7/3aDcTulfGSa0zfJ4sLnIuPwlTY70BEmrALzOWYL1R1A==
X-Received: by 2002:a05:600c:2212:b0:424:a2d9:67c5 with SMTP id
 5b1f17b1804b1-424a2d96a8emr4209055e9.16.1719295837690; 
 Mon, 24 Jun 2024 23:10:37 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c83e9sm11890515f8f.94.2024.06.24.23.10.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:10:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/11] hw/sd/sdcard: Convert SEND_CSD/SEND_CID to
 generic_read_byte (CMD9 & 10)
Date: Tue, 25 Jun 2024 08:10:07 +0200
Message-ID: <20240625061015.24095-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
 hw/sd/sd.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0011aa86da..346bd657a7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1290,11 +1290,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (!sd_is_spi(sd)) {
                 break;
             }
-            sd->state = sd_sendingdata_state;
-            memcpy(sd->data, sd->csd, 16);
-            sd->data_start = sd_req_get_address(sd, req);
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                         sd->csd, 16);
 
         default:
             break;
@@ -1314,11 +1311,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (!sd_is_spi(sd)) {
                 break;
             }
-            sd->state = sd_sendingdata_state;
-            memcpy(sd->data, sd->cid, 16);
-            sd->data_start = sd_req_get_address(sd, req);
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                         sd->cid, 16);
 
         default:
             break;
@@ -2108,15 +2102,9 @@ uint8_t sd_read_byte(SDState *sd)
                            sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
-        sd_generic_read_byte(sd, &ret);
-        break;
-
     case 9:  /* CMD9:   SEND_CSD */
-    case 10:  /* CMD10:  SEND_CID */
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= 16)
-            sd->state = sd_transfer_state;
+    case 10: /* CMD10:  SEND_CID */
+        sd_generic_read_byte(sd, &ret);
         break;
 
     case 13:  /* ACMD13: SD_STATUS */
-- 
2.41.0


