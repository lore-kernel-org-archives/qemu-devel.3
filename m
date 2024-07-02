Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35088C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZmc-0002q3-PG; Tue, 02 Jul 2024 05:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmU-0002lv-S5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmS-0001YU-8O
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-424ad991c1cso34899725e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912390; x=1720517190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFulJ2oO2h99eDTEiqTYqq780MTJhbquTUdeCChl0+Y=;
 b=n14tGp0lWBgxOmhjjGu2zvZZGlY1qS6wucB5LzlCzyJc6Mopa2t8gVFVRV9RLys7LO
 13yAYKgTSnDkZdBjEDNviaZPu7kYfND/a/71kiuWMejF7L3BFziMeEHzuCRRb/5GN5sU
 Qj6oC1ShciFmsfbfDCWR9xONiU73iJmjU/f/9p80aL0qk6cURLJA6HOFwZIb0OstJmqC
 LtfS3Dvpbshu0GfsV2sZDV7TdvyiLfs8ti87cSZoQynAifkpfxn1EY+DEdPbjiKT6glM
 K2e5TfQ0h1pdAOBTqt0oni9SmsMFux9XpWu67Cyzp7znVEBv0a4JwG3nKjLQ1aT26DI7
 KFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912390; x=1720517190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFulJ2oO2h99eDTEiqTYqq780MTJhbquTUdeCChl0+Y=;
 b=QktO8A7WJgjaqCwfFoFuSsyYYc7jkpTqmSViFoVl9g0noG+LDIEGJTXoqsbjWaUJyJ
 h03t4sUQXa9lFIP0wwuBTOpRZkn+/n/1/UeBDItEippR9w1uwbcKDachSiJh8k2csLP7
 6mKKKGKE7m0TZb/yLdz1g541mQGwGRLOD1e0dQWCM+gmuWHUMqncLYV+mO3nZBwdyMeh
 +0y7l26IDu7IFPU1pzGWKOH22bANgXOpprY5yyg1itS3TBCSd+f2px6Md/a4Ua3legUf
 oq+E3BsXY8wvhwH/jNTGsSEkvMqI/+Y8nDkVnLC47SJ2tA3Cmi3wSVi94L0QQtIydT+h
 C8yQ==
X-Gm-Message-State: AOJu0YxXNnEub4S4ulb6PCqWuv/EPe6cwz8d0XCDwB5c47t3iZ8Gz9ma
 V5wknVsSQ8GpOlqgHo3I2Sjo8wmfP+NOApiPaYIgIn1Qdmc3GpI3Sn6PadBqRVISvNsmeHcp5Ri
 v
X-Google-Smtp-Source: AGHT+IGWpZeEh8ZZtCuVoeddHoAPB4Q99kNHb4BHL2wUwl2DzUfZDYOiJ2DuqlJQIgh/heVh8X70hg==
X-Received: by 2002:a5d:4b4f:0:b0:360:9a40:3dd8 with SMTP id
 ffacd0b85a97d-367757301b1mr6133651f8f.65.1719912389920; 
 Tue, 02 Jul 2024 02:26:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b098426sm188322325e9.32.2024.07.02.02.26.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 57/67] hw/sd/sdcard: Add sd_cmd_LOCK_UNLOCK handler (CMD42)
Date: Tue,  2 Jul 2024 11:20:40 +0200
Message-ID: <20240702092051.45754-58-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Message-Id: <20240628070216.92609-64-philmd@linaro.org>
---
 hw/sd/sd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index be9437141a..da344589f2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -242,7 +242,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
         [40]    = "DPS_spec",
-        [42]    = "LOCK_UNLOCK",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
@@ -1611,6 +1610,12 @@ static sd_rsp_type_t sd_cmd_ERASE(SDState *sd, SDRequest req)
     return sd_r1b;
 }
 
+/* CMD42 */
+static sd_rsp_type_t sd_cmd_LOCK_UNLOCK(SDState *sd, SDRequest req)
+{
+    return sd_cmd_to_receivingdata(sd, req, 0, 0);
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1699,10 +1704,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Lock card commands (Class 7) */
-    case 42:  /* CMD42:  LOCK_UNLOCK */
-        return sd_cmd_to_receivingdata(sd, req, 0, 0);
-
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
         rca = sd_req_get_rca(sd, req);
@@ -2318,6 +2319,7 @@ static const SDProto sd_proto_spi = {
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
         [38] = {5,  sd_spi, "ERASE", sd_cmd_ERASE},
+        [42] = {7,  sd_spi, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
         [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
@@ -2362,6 +2364,7 @@ static const SDProto sd_proto_sd = {
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
         [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
         [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
         [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
         [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
         [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
-- 
2.41.0


