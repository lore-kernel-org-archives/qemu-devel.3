Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99381C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZmC-0000qE-3U; Tue, 02 Jul 2024 05:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZm8-0000ZZ-Cd
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZm4-00018H-B5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:26:10 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3674e1931b7so2694159f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912366; x=1720517166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXCg3w5PVdeJgjz/MXSI7N25wc9KB2lQFNoBJeyQQpg=;
 b=Wo4NjNFrbZt8LAy5cJ9t/xD+9SAd3llgVHaiad0zYpPCo1rupOIoLWGnvo5HIldG4j
 ciVNSwEyFqyHotpYfdwAmrto9yahSenITRGTKtN7PmmmvoKy8So0IEZPSYGoRumeyLiL
 QYhQZs32rercr9Pg9Iop7SHmq5Yj0eyct9OWIysBEwts1Bf47IPkIOgvn/36Vdj9j/U1
 DrzsN/Nk3ip/3pEZgT6u2zJFbodPnHtPOVfAX2m9mBE8ThSAWGvMFxjcFePTE0yQp/3B
 jJ8vkdJxnqcz9NcFlDtzLy3lpUhpHJ9sWDpGDFVAKgfiO2LSksPq0BxjHWqLVYq63ys1
 pRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912366; x=1720517166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXCg3w5PVdeJgjz/MXSI7N25wc9KB2lQFNoBJeyQQpg=;
 b=GaO8fjjc8rQgfDZaOMtQFQcUSLVjEryeInUNYxQReYNPrZTzHXjvKX2ldQEq6FRQVy
 HjQCzoQUU2JO5jkDDuWim8r+q22iGdxc2EnseTpo8RnXDBzzkVRmwjnzbmBT8Pz6cxgY
 0Hn79cwNG7dDqygJ3zXHsIVq2eXwrBuE6az/8TGmQRXl128W8W/EKek0tg7u7W37Sx7/
 CJ34S6ARgBBtJER6C62JF22qmtoBX6B2Sjyz+UzDjgsh8x/O6hahPAkWEyge9EGh8sfQ
 XGtoxtkG4kl5zmdgEIvpDCBocxLhtRqiYdq5YNCYeywedkfBEBNYrkmLbnv0L4zZQBV+
 KqFg==
X-Gm-Message-State: AOJu0YxtgZiXWMLXYCdPNym92DDfKAgehH6T1YJwC4aEby52FTKp+qid
 SZwenz4bSZffbu478ZTcR6FJ50lRq8h4Vj7Ni1mDKqC+qhziLZn+0+aOZFDxSF0Q0skm984186J
 R
X-Google-Smtp-Source: AGHT+IGRelkJWuOrs1/KMBLz9CKBQ8J6DacU3uWDdbouPnGLVt49OPfJDWYKGCU+30pgic4jYuj5vQ==
X-Received: by 2002:a5d:525c:0:b0:35f:1d40:82fa with SMTP id
 ffacd0b85a97d-367756ad6f5mr4253182f8f.18.1719912366443; 
 Tue, 02 Jul 2024 02:26:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103366sm12572103f8f.102.2024.07.02.02.26.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:26:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 53/67] hw/sd/sdcard: Add sd_cmd_SET/CLR_WRITE_PROT handler
 (CMD28 & CMD29)
Date: Tue,  2 Jul 2024 11:20:36 +0200
Message-ID: <20240702092051.45754-54-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Message-Id: <20240628070216.92609-60-philmd@linaro.org>
---
 hw/sd/sd.c | 91 +++++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e1c799c117..384ce77b36 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -241,7 +241,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
         [38]    = "ERASE",
@@ -1512,6 +1511,48 @@ static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
 }
 
+static sd_rsp_type_t sd_cmd_SET_CLR_WRITE_PROT(SDState *sd, SDRequest req,
+                                               bool is_write)
+{
+    uint64_t addr;
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
+    if (!address_in_range(sd, is_write ? "SET_WRITE_PROT" : "CLR_WRITE_PROT",
+                          addr, 1)) {
+        return sd_r1b;
+    }
+
+    sd->state = sd_programming_state;
+    if (is_write) {
+        set_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
+    } else {
+        clear_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
+    }
+    /* Bzzzzzzztt .... Operation complete.  */
+    sd->state = sd_transfer_state;
+    return sd_r1;
+}
+
+/* CMD28 */
+static sd_rsp_type_t sd_cmd_SET_WRITE_PROT(SDState *sd, SDRequest req)
+{
+    return sd_cmd_SET_CLR_WRITE_PROT(sd, req, true);
+}
+
+/* CMD29 */
+static sd_rsp_type_t sd_cmd_CLR_WRITE_PROT(SDState *sd, SDRequest req)
+{
+    return sd_cmd_SET_CLR_WRITE_PROT(sd, req, false);
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
@@ -1602,50 +1643,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     /* Write protection (Class 6) */
-    case 28:  /* CMD28:  SET_WRITE_PROT */
-        if (sd->size > SDSC_MAX_CAPACITY) {
-            return sd_illegal;
-        }
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!address_in_range(sd, "SET_WRITE_PROT", addr, 1)) {
-                return sd_r1b;
-            }
-
-            sd->state = sd_programming_state;
-            set_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
-            /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
-    case 29:  /* CMD29:  CLR_WRITE_PROT */
-        if (sd->size > SDSC_MAX_CAPACITY) {
-            return sd_illegal;
-        }
-        addr = sd_req_get_address(sd, req);
-        switch (sd->state) {
-        case sd_transfer_state:
-            if (!address_in_range(sd, "CLR_WRITE_PROT", addr, 1)) {
-                return sd_r1b;
-            }
-
-            sd->state = sd_programming_state;
-            clear_bit(sd_addr_to_wpnum(addr), sd->wp_group_bmap);
-            /* Bzzzzzzztt .... Operation complete.  */
-            sd->state = sd_transfer_state;
-            return sd_r1b;
-
-        default:
-            break;
-        }
-        break;
-
     case 30:  /* CMD30:  SEND_WRITE_PROT */
         if (sd->size > SDSC_MAX_CAPACITY) {
             return sd_illegal;
@@ -2316,6 +2313,8 @@ static const SDProto sd_proto_spi = {
         [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
+        [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
+        [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2354,6 +2353,8 @@ static const SDProto sd_proto_sd = {
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
+        [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
+        [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
-- 
2.41.0


