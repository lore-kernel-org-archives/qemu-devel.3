Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E44EC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZlW-0007Gs-2o; Tue, 02 Jul 2024 05:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlU-0007Ew-6K
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlJ-0000IQ-LR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-425680b1d3aso27252855e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912320; x=1720517120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vw2vdkreXbtxIWqVAzubzR0s305Wl62ih68f1l2Fwrw=;
 b=UhUpUBymf3npmi5uiv2Y6fq8DsLuUDKOxW98FihlxPZ88jJToGXkJt1tRYbgsZVmTM
 T6XFGe76qRXULUMtRFfwIR2XPJYsqo68n6Q8VO1OmG28RX/cK4oASCcOVc/qP5q2qjyG
 UUO9vEgReTqwRwmL45X7uyCv+QRth8BlyPeuoMWBkJKpaNdD3hKINBw64cr6jHWFWv2G
 hU8yJyt78O8WtfA+5oOhQYwkxH+8xmH+I4PEk9kMVHYvdHkmDPdgKwlu20gGI5v9OnSy
 WLgwxd6kAoIw5UFziK5Fxhexe52N70Na5SAr4dZ/Xbya+FFaBEd74bINwMzvsbvuZIaT
 jfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912320; x=1720517120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vw2vdkreXbtxIWqVAzubzR0s305Wl62ih68f1l2Fwrw=;
 b=ILJtwksB+jAuQRoEVg3KMf3nUHHlNbFz56P0n1jSyTdx025g1XMl+De6lAV+wp4YgK
 GnFGW11R1VbT38ZkuAnaAj0c/KEtrxKlM6KVt4LEQjxQMqT8Pz3pXRQaF0GFyxYSTUYC
 Ct+I4+3nd4LNLIDi6wKKq47rnO5vwbv8Fme9U95WkYWR9ydI2xi/PXVU79v5l0kUOlsR
 qwULyqn064QY7ClLWJWiscvqV/kOacPaAfmKdCEL9JJDU9oNSmWFXiuPOyDvcJsPUXbc
 GJ8y9NEsXnFOlCnWmK/GHwnaBsEhXh690xCpnpPTFQrQJ1e6icNy+4hLMcZOxhQ33Mla
 qXkg==
X-Gm-Message-State: AOJu0Yx1OJLldSTarm8iBKp58CHz9zF8/Wu3qIcfih1LhsdCPazPc3+i
 FpnROdAHE28juesOaCPbSaXIM6l9OcqxLYJse0eMCeX5t798VKW9JHuH0fy4OLrd1zTIZ/up8/J
 Y
X-Google-Smtp-Source: AGHT+IEQJ0Jq3sd0Fl5Eufcard/r+Zfq7i4YFs/AvM3itlmSlKnjEZ6Ge6RN3+JABjIV6RbsNjZEhQ==
X-Received: by 2002:a05:600c:2252:b0:424:a823:51d9 with SMTP id
 5b1f17b1804b1-4257a06e036mr52088665e9.30.1719912320009; 
 Tue, 02 Jul 2024 02:25:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a043a16sm12808371f8f.0.2024.07.02.02.25.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 45/67] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 &
 CMD10)
Date: Tue,  2 Jul 2024 11:20:28 +0200
Message-ID: <20240702092051.45754-46-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-52-philmd@linaro.org>
---
 hw/sd/sd.c | 50 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e372f88073..49fc79cf8a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1315,6 +1315,15 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
 }
 
 /* CMD9 */
+static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                 sd->csd, 16);
+}
+
 static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_standby_state) {
@@ -1325,6 +1334,15 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 }
 
 /* CMD10 */
+static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
+{
+    if (sd->state != sd_standby_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
+                                 sd->cid, 16);
+}
+
 static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
 {
     if (sd->state != sd_standby_state) {
@@ -1400,36 +1418,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 9:  /* CMD9:   SEND_CSD */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!sd_is_spi(sd)) {
-                break;
-            }
-            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                         sd->csd, 16);
-
-        default:
-            break;
-        }
-        break;
-
-    case 10:  /* CMD10:  SEND_CID */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!sd_is_spi(sd)) {
-                break;
-            }
-            return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                         sd->cid, 16);
-
-        default:
-            break;
-        }
-        break;
-
     case 12:  /* CMD12:  STOP_TRANSMISSION */
         switch (sd->state) {
         case sd_sendingdata_state:
@@ -2290,6 +2278,8 @@ static const SDProto sd_proto_spi = {
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
+        [9]  = {0,  sd_spi, "SEND_CSD", spi_cmd_SEND_CSD},
+        [10] = {0,  sd_spi, "SEND_CID", spi_cmd_SEND_CID},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


