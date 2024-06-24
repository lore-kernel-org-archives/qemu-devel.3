Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3B3C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjY8-0003rH-LW; Mon, 24 Jun 2024 09:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjY6-0003cn-J9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjY4-0005Xp-RR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:58 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-362b32fbb3bso2930738f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234954; x=1719839754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZMgxVGycu8UCR6fk1Qn9uFvwvmJUGQDSX4skzfq58o=;
 b=Rah9nWw2jGg1E+C1rBbVQZHvJLAh1e6p7iCmnftlRMR+azz99L3OkhRmJ+2/NxV4iq
 fCR27sWYfQ/ok++U3TZiI832pyJ3U5RRTC92RntVXNQRScpBzy83WJMwbbfhrCHT5GAa
 ubbvdbcrvIwVXo6G64AnaRnPJ135FQSahvnozQQzIumhIo+yGNfSzZswFnBHGnyNyYrU
 c8ohBOUzcfxajy/y+HWa/0Tm3/y00NV+Xbod1BysWOZ69SM66HCkkwBJuTXLj/L51ihx
 SEWS3MVB5W9HhyUx5QC6QoykT3pZ27ro0bGqZKIIUPAC61vUgv3J/AcX4/nFD6OhmA7K
 fpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234954; x=1719839754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZMgxVGycu8UCR6fk1Qn9uFvwvmJUGQDSX4skzfq58o=;
 b=CsVEdAJBtAb3etXR8wkVdguKGj2V3JryOQMmqlZPvPqQ130LVBfkhVNhq18v+w3ugn
 GhZxWDYIBJDcnTk2SVFCJfidMUOQRhA5sbbT28gixk3odWx5Oqke5DDk2NgJXT/CV+6r
 rOJ7DLfKPTuciYGO81d436Z+BnpNGIs/ZfUqtMxtG9iddl8oVCaI9vzsQIX5j2LwDy4r
 6fwhyAkn9gSDFM9JQlJkasqJRvTIRDtSjp4qmvUWnBCmBH33XBl/DhEJetNFa2n3eihG
 ueZ0GOja3H7ZnrFO+AVDLgFiTbNVaAJZW5Taryd52V2bdtc0prvlINaA07JFbdDzWTDM
 AtaA==
X-Gm-Message-State: AOJu0Yxex8eELlMooBNQ0nGvjGJFUzRNbrnY4GLzdc0lvFeNJ+PkLSVw
 hCjnHj0Lmky5UKe3XAxC/wbZyUueYQH9MQmb18UgBgaqEaphZErMIHq7E1xZUP3B74AYEiS3lhK
 R
X-Google-Smtp-Source: AGHT+IG1wxI0mEsJtfyJYa1q2sytrtXFbHbPI1/6TvXJhzdV4v+DIDR/JQLSD4GwYQuo+UbmdCdhRA==
X-Received: by 2002:a5d:58fa:0:b0:35f:1b73:1d83 with SMTP id
 ffacd0b85a97d-366e7a08ba5mr3921036f8f.4.1719234954103; 
 Mon, 24 Jun 2024 06:15:54 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366bd575f6asm9398981f8f.6.2024.06.24.06.15.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/19] hw/sd/sdcard: Factor sd_req_get_rca() method out
Date: Mon, 24 Jun 2024 15:14:34 +0200
Message-ID: <20240624131440.81111-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Extract sd_req_get_rca() so we can re-use it in various
SDProto handlers. Return a 16-bit value since RCA is 16-bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-15-philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 04b141784b..b909a85d53 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -474,6 +474,14 @@ static void sd_set_rca(SDState *sd)
     sd->rca += 0x4567;
 }
 
+static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
+{
+    if (sd_cmd_type[req.cmd] == sd_ac || sd_cmd_type[req.cmd] == sd_adtc) {
+        return req.arg >> 16;
+    }
+    return 0;
+}
+
 FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
 FIELD(CSR, APP_CMD,                     5,  1)
 FIELD(CSR, FX_EVENT,                    6,  1)
@@ -1097,7 +1105,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
-    uint32_t rca = 0x0000;
+    uint16_t rca = sd_req_get_rca(sd, req);
     uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
 
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
@@ -1112,11 +1120,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     /* Not interpreting this as an app command */
     sd->card_status &= ~APP_CMD;
 
-    if (sd_cmd_type[req.cmd] == sd_ac
-        || sd_cmd_type[req.cmd] == sd_adtc) {
-        rca = req.arg >> 16;
-    }
-
     /* CMD23 (set block count) must be immediately followed by CMD18 or CMD25
      * if not, its effects are cancelled */
     if (sd->multi_blk_cnt != 0 && !(req.cmd == 18 || req.cmd == 25)) {
-- 
2.41.0


