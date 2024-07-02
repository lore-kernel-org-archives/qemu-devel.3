Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EACC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZmG-0001RG-Mr; Tue, 02 Jul 2024 05:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmF-0001E6-AK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:19 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZmD-0001Ms-AG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:19 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ec61eeed8eso49000261fa.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912372; x=1720517172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBeUcx8Psy1taypQO+9k0SQLPvz0ZTjNS5TGwOTNSRg=;
 b=kroOfv6hra57WSTQe2NV5IkKK7iIWGkfVWUzeEu98k0qsc818NhemVDUJ2w1/1mMxC
 ZJ7FtJWtHa8ZlzctQliVYBYhxAecYj9L4IOUkke0ia8IkkTRpHwu0Py6tGiBhVp3Uzjr
 KtToLKekIqBDdrdtm66BLRx1ywKaxjgLadQ5gGahETWUnx4dn5ZRviUthDH1WeSW5avd
 WOLJZ7kWva5xrYYd/z+I5/2GMZwKA5+B6zx3XGZvXifihkvzSIdiVHJuxpTeG+k78nfL
 IRdFaUrqF1uKQEoLomzS1rg5lp+Af41zCJmQguRMx0Y2pOxgbXyDxgR6rPJdhO76PcK0
 7c5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912372; x=1720517172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cBeUcx8Psy1taypQO+9k0SQLPvz0ZTjNS5TGwOTNSRg=;
 b=QuOhZFtxNFfk1kn4D+yI/G+OcK1nGe/d8iQ0L7xCg8pprpXcGynYNNJpTnwOpqIhJU
 O+Ip5F6CJFCTMALFlsWB0/0Z3c7anmXL23EsEINMRIPRdSBJ1nX4TDsK8gb5xYqBGJg7
 ANBUOPmE2PUnkayqFhyd9cgpG1WfSYnTd7n/W6GEuVWUTQHpYx3/2oil8lzmxfe208g2
 vvPrlV+z2g9o08NUU+4Lw3SwUitkBcATgwXpD9l2MoYf4BI2n3eJeev2DhIucD6FB6xO
 xS+lvOQ9HHXsy0wkWM4Oy5iRMzP/HLbv5iggSwTm5xgxXvPVXVvfZC31AqLSicofCzlM
 WmHA==
X-Gm-Message-State: AOJu0YysZDUt5/QvVjWyS2bmbEyDfSFSRVfwDUhT/LwOXz63bYOaHnZG
 KOX4wrt8aqdTQFPQIrD819505vZwpuFCwh2x3+zzJwuks4i/IxDuH2OEEGAEZ5pFc9Uuf9lFe/3
 t
X-Google-Smtp-Source: AGHT+IGGEVveWCeQ2w4pmDyt0FpoGY0fV+eAkgyCRjWiymeuo6H7v5CoEW5CcOcitZzWEAcUugW3gQ==
X-Received: by 2002:a2e:b951:0:b0:2ec:5685:f068 with SMTP id
 38308e7fff4ca-2ee5e358fa9mr43497391fa.17.1719912372257; 
 Tue, 02 Jul 2024 02:26:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257fb4fabdsm96420595e9.46.2024.07.02.02.26.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 54/67] hw/sd/sdcard: Add sd_cmd_SEND_WRITE_PROT handler (CMD30)
Date: Tue,  2 Jul 2024 11:20:37 +0200
Message-ID: <20240702092051.45754-55-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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
Message-Id: <20240628070216.92609-61-philmd@linaro.org>
---
 hw/sd/sd.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 384ce77b36..b205cc4692 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -241,7 +241,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
@@ -1553,11 +1552,33 @@ static sd_rsp_type_t sd_cmd_CLR_WRITE_PROT(SDState *sd, SDRequest req)
     return sd_cmd_SET_CLR_WRITE_PROT(sd, req, false);
 }
 
+/* CMD30 */
+static sd_rsp_type_t sd_cmd_SEND_WRITE_PROT(SDState *sd, SDRequest req)
+{
+    uint64_t addr;
+    uint32_t data;
+
+    if (sd->size > SDSC_MAX_CAPACITY) {
+        return sd_illegal;
+    }
+
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    addr = sd_req_get_address(sd, req);
+    if (!address_in_range(sd, "SEND_WRITE_PROT", addr, sd->blk_len)) {
+        return sd_r1;
+    }
+
+    data = sd_wpbits(sd, req.arg);
+    return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
     uint64_t addr;
-    uint32_t data;
 
     sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
@@ -1642,26 +1663,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 26:  /* CMD26:  PROGRAM_CID */
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
-    /* Write protection (Class 6) */
-    case 30:  /* CMD30:  SEND_WRITE_PROT */
-        if (sd->size > SDSC_MAX_CAPACITY) {
-            return sd_illegal;
-        }
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!address_in_range(sd, "SEND_WRITE_PROT",
-                                  req.arg, sd->blk_len)) {
-                return sd_r1;
-            }
-            data = sd_wpbits(sd, req.arg);
-            return sd_cmd_to_sendingdata(sd, req, addr, &data, sizeof(data));
-
-        default:
-            break;
-        }
-        break;
-
     /* Erase commands (Class 5) */
     case 32:  /* CMD32:  ERASE_WR_BLK_START */
         switch (sd->state) {
@@ -2315,6 +2316,7 @@ static const SDProto sd_proto_spi = {
         [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
+        [30] = {6,  sd_spi, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2355,6 +2357,7 @@ static const SDProto sd_proto_sd = {
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
+        [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


