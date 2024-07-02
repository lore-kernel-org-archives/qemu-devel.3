Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502ABC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZm6-0000QX-LA; Tue, 02 Jul 2024 05:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZly-0008Pq-Sl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZls-00012E-T8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4257a390a4eso19067455e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912355; x=1720517155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYL5paPpv6jEUEf+c2iXnwTu+YdBcD9M6q75+huuwI4=;
 b=MIRVXuV2oDuI7C7/1sEZ4LpEVjW+vzM0VWG7hLKSNPru1P9sFvxorYvODxDOJ3YcHv
 lXdWek3OsqNNmwk57dBrVCc/R1EO6nb/56F0JVWGe9FIVQ9qaTSTnMfOu9Gmkupa0WCk
 thM04EwjWkZfB56GmuuSBs3qGiGIKR8K1T4GhXk0WDLpcfqi+tYv0Vg+uVZcbZkkAgbb
 /oVlS02gVtx6TPhccGyxkBmuRUSet8sbggfI8VB2P3NsbKWwqHLd3WyOQLfgUXCmHg/Z
 +Eep+If+S+fMkqar8O8sabtN37NbxsJcA5Rniv1N58rV22v37Si4mryjgZugbTFckrsu
 zAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912355; x=1720517155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYL5paPpv6jEUEf+c2iXnwTu+YdBcD9M6q75+huuwI4=;
 b=wuJAB4BsPwNujAAmZfbzoR8u/1rJpl014V+UBwHhRC9eWr0Qaqkj6vEPCjsc53865L
 nSU/zHQ5N1aXqO+JY2rUa3ztntLFyQbwwLI7xC6D3Wo/w7pWtGU5dDnSDhSj2xRPL2SW
 5PuShWEeuLnpdhgFX7CB1M3DWLnLHc4wkgo+PvOpi/4ViqRJq3Bfu9O86ZL82bO+EciK
 TdwTM3jVYOhbMBaBakgMYSE/9hHpvwUF+SyafMO5N7aFIXnf/4YjzdH2dnjR6zxBEWCg
 Gow51PuA3AIr/bGzmlBkezz4jvn6r4IgwOr60tM8cvHE+gDnEld76gYiSRzTcCKzI7S8
 xREQ==
X-Gm-Message-State: AOJu0YytC9oq9L/bH4EiondWUCjb75l/DfNptyR+ThfLPY7LaUXJ6S5E
 wa2joIkTtP/b84PYD7BC6bnP/1XR614cNN6fI8SuSenbphGMfbkAIsY5emItzF7BY9Uo8dIPMTh
 r
X-Google-Smtp-Source: AGHT+IH2q+jd3fMCredma8Zo0CO3qFCcEuCojOXH+YoMNa5QLu49k6W7N+6Dy446tOtiG5TvVpvhhw==
X-Received: by 2002:a7b:cbd2:0:b0:425:5eec:d261 with SMTP id
 5b1f17b1804b1-4257a02805dmr62785395e9.34.1719912354928; 
 Tue, 02 Jul 2024 02:25:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1430sm12682288f8f.52.2024.07.02.02.25.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 51/67] hw/sd/sdcard: Add sd_cmd_WRITE_SINGLE_BLOCK handler
 (CMD24)
Date: Tue,  2 Jul 2024 11:20:34 +0200
Message-ID: <20240702092051.45754-52-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20240628070216.92609-58-philmd@linaro.org>
---
 hw/sd/sd.c | 57 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3f5cc0c55c..02a1203691 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -239,7 +239,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
         [18]    = "READ_MULTIPLE_BLOCK",
                                             [21]    = "DPS_spec",
-        [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
+                                            [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
@@ -1479,6 +1479,33 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     return sd_r1;
 }
 
+/* CMD24 */
+static sd_rsp_type_t sd_cmd_WRITE_SINGLE_BLOCK(SDState *sd, SDRequest req)
+{
+    uint64_t addr;
+
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+
+    addr = sd_req_get_address(sd, req);
+    if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr, sd->blk_len)) {
+        return sd_r1;
+    }
+
+    if (sd->size <= SDSC_MAX_CAPACITY) {
+        if (sd_wp_addr(sd, addr)) {
+            sd->card_status |= WP_VIOLATION;
+        }
+    }
+    if (sd->csd[14] & 0x30) {
+        sd->card_status |= WP_VIOLATION;
+    }
+
+    sd->blk_written = 0;
+    return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1536,32 +1563,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     /* Block write commands (Class 4) */
-    case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-
-            if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr,
-                                  sd->blk_len)) {
-                return sd_r1;
-            }
-
-            if (sd->size <= SDSC_MAX_CAPACITY) {
-                if (sd_wp_addr(sd, sd->data_start)) {
-                    sd->card_status |= WP_VIOLATION;
-                }
-            }
-            if (sd->csd[14] & 0x30) {
-                sd->card_status |= WP_VIOLATION;
-            }
-            sd->blk_written = 0;
-            return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
-
-        default:
-            break;
-        }
-        break;
-
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
@@ -2310,6 +2311,7 @@ static const SDProto sd_proto_spi = {
         [13] = {0,  sd_spi, "SEND_STATUS", sd_cmd_SEND_STATUS},
         [16] = {2,  sd_spi, "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2346,6 +2348,7 @@ static const SDProto sd_proto_sd = {
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


