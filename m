Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6321C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZjY-0007CT-UG; Tue, 02 Jul 2024 05:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjT-0006z2-Qt
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjO-0007KA-FU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso28540915e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912201; x=1720517001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McRtxYBX9h21CzT63G2Ji6yPLnYuFaXK4qV2KzZz24Y=;
 b=rWIhb1Gc5CcmEBdGvOx44czg/t2Ql88yyrz63LaRFmqzvJSwWizcVGyxXrojgd8ifX
 H/VryfpdbgKKgrqSDmS8i90114XfCIB/cmG1gBas41RJFd1qgkIBAtKeDrsTzBH48sYD
 JHt5PVS6f+RS5zqO2cksyMYXx3/guBRohtQtAjI0oxcRjoyteoHF++NRioivRP25Lj2z
 28SvlasUs4Qy7sIYoH4J8/TQ2J2RuvM7ZhQEcNCOP0xWoV9BeK4vDd/61nUVvNfLU6p1
 3bMRkJAiuUpGUa2mCBHhoAgDqVSNQxJqLsZ5WJYcD4c/TtNIrWKoqW4PaO6/danPLJ/O
 8TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912201; x=1720517001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McRtxYBX9h21CzT63G2Ji6yPLnYuFaXK4qV2KzZz24Y=;
 b=EfgZaGqvO+T8QbZyWaoLZfjoQGNCnFQYsEn/THad5zMIT5+yhCw2Nz+FyRqrqTgJSP
 uZWihSAxgEA9wtyfMdz1TA6Pi9Ytd1s3c+wheMaDM+eLc1VZxUViiKjeU1rezo86sOb+
 umSLDvR68kxPUQnwImggkwUgol0cP40h4qZ4w6EvqZj3VVHwF+Cz2T6LNgUxg0BwrPuK
 wmDVkbQ4zFdGXWPqDfuPhDnSmfuANyFarE0Lt4RMv2fbzzZZJkGjZ4i7MgC2ComqttrZ
 m3Tlywe+HKrpS/ms4FHlzZ5enTBcZRxsipXHey/O93xSFLfUCZU3Xki069CMEntZHrXq
 3Npg==
X-Gm-Message-State: AOJu0Yx2QDkq+tVITM2fQOFMNkEPRUfRQVMSoD5GPDf0jPYfZuE8Nynm
 VZRYdDH7lgO1A66Co7Km6N6ICuOp7UOg4KzS/40crDurhvoj04tOPrXFgl6h2XZAGFc6trDPilG
 S
X-Google-Smtp-Source: AGHT+IGSOrga8o9SbO0CCtndDPhCcElW3mgyq64EtmFk4IAlsLggVlbYtBeldR8eNMLv3efKGGnmQw==
X-Received: by 2002:a05:600c:5125:b0:425:672a:7683 with SMTP id
 5b1f17b1804b1-4257a08ded2mr45418635e9.41.1719912200855; 
 Tue, 02 Jul 2024 02:23:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b91bsm190911205e9.20.2024.07.02.02.23.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:23:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/67] hw/sd/sdcard: Duplicate WRITE_SINGLE_BLOCK /
 WRITE_MULTIPLE_BLOCK cases
Date: Tue,  2 Jul 2024 11:20:08 +0200
Message-ID: <20240702092051.45754-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

In order to modify the WRITE_SINGLE_BLOCK case in the
next commit, duplicate it first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-31-philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 990f038b79..b1acddca45 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1453,6 +1453,35 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Block write commands (Class 4) */
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
+        switch (sd->state) {
+        case sd_transfer_state:
+
+            if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr,
+                                  sd->blk_len)) {
+                return sd_r1;
+            }
+
+            sd->state = sd_receivingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
+
+            if (sd->size <= SDSC_MAX_CAPACITY) {
+                if (sd_wp_addr(sd, sd->data_start)) {
+                    sd->card_status |= WP_VIOLATION;
+                }
+            }
+            if (sd->csd[14] & 0x30) {
+                sd->card_status |= WP_VIOLATION;
+            }
+            sd->blk_written = 0;
+            return sd_r1;
+
+        default:
+            break;
+        }
+        break;
+
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
-- 
2.41.0


