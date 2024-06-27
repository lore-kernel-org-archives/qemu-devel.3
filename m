Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F90C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsGp-0006HO-JK; Thu, 27 Jun 2024 12:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsG4-0005bZ-RT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsG0-0000HV-Bx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:46:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-424ad289912so17749735e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506758; x=1720111558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6oigTn0Q2A4tjfIsZSpx2Wne2arec43lvnPbuSKAbM=;
 b=wYheyhJTyO76RBw01CuScM9mNw4uZzudnHzGOi27w4bxLkp+lBuaZUIKiBBb/9aiQp
 k99rjauM0ayRDdNNF6rAMiOdGu0qLEClwTOatZRyfBSw4HC6Dy5P7Htw7KOqdaDI/qXm
 XJhaZkpmVhR/7rI/UtpVsfNahvGFMQxnBAQSlbAIRIqkxVGeIDDDfqM+HX7wEotbdHB4
 tNkstZ5jOEx4azwfDSkv15zsYdf25PZz/md+s/xb7uL2Zpj3napwgGG5npinj/AJ01gN
 PwB2xRJkpEsNR6X3oosx/m5wA0GeNSq4Y5koJlcE1Tao8Oclg+qDVZW3JdWCrZ840wym
 aFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506758; x=1720111558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6oigTn0Q2A4tjfIsZSpx2Wne2arec43lvnPbuSKAbM=;
 b=ZD1K6BrNcrwkE9vhQ0ukGmPM2Sgtr+wqf5P/wBeNmlM8XEFX3ywIG+TzY4v3UdtqCr
 YIG/ooFGgCsEVJrWhN6Mv7bj4ccyC013y/PdT27IRQX03OTb0L6utBqk4kFv5hRg3fKw
 421BcVHPTKHCjLoqccs0DyubmzhI3mclISj6N1ewS+prdoNhTZLG3WTCfdLfMbmZgkt4
 ynjwgFp3par8hpeMyStFdIHBb38nZ2K9VRhyyX4rRRdvro9JHiB6gxYSwBDvA3smyXGl
 Gx8Tl78EHdl2iL/CPEsEemnbJCJQCzciifqzHiqFvhxa//FRx9W1Lz0FVYMoywOnNhJE
 crFQ==
X-Gm-Message-State: AOJu0YxnZjUAaiQZ7SSQNXxy+owyD3+zJEYVh2/sR03UgJGHGcjBMKQ8
 vuLOKZ5ahKDX9OwZOGSMVu0F/0MYn8XaurrnJbuzQCJhBWPMDxfNZXNLbUOQtQCTJpvRKvodGRu
 Pf60=
X-Google-Smtp-Source: AGHT+IGymQesBd6k53e+ir8M4bkAt1fWceEIGwr4LA3ang+Ib3Zh6jzLdgEZ3rQHrG7yolTfgETJqg==
X-Received: by 2002:a05:600c:5599:b0:424:ac90:8571 with SMTP id
 5b1f17b1804b1-424ac9085damr39082635e9.18.1719506757939; 
 Thu, 27 Jun 2024 09:45:57 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357ff4fsm2405881f8f.42.2024.06.27.09.45.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:45:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 13/21] hw/sd/sdcard: Add sd_cmd_SET/CLR_WRITE_PROT handler
 (CMD28 & CMD29)
Date: Thu, 27 Jun 2024 18:43:36 +0200
Message-ID: <20240627164345.82192-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164345.82192-1-philmd@linaro.org>
References: <20240627164345.82192-1-philmd@linaro.org>
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
 hw/sd/sd.c | 91 +++++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9d33113f11..a63213613b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -244,7 +244,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
-        [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
         [38]    = "ERASE",
@@ -1520,6 +1519,48 @@ static sd_rsp_type_t sd_cmd_PROGRAM_CSD(SDState *sd, SDRequest req)
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
@@ -1610,50 +1651,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
@@ -2314,6 +2311,8 @@ static const SDProto sd_proto_spi = {
         [17] = {2,  sd_spi, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
         [24] = {4,  sd_spi, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [27] = {4,  sd_spi, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
+        [28] = {6,  sd_spi, "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
+        [29] = {6,  sd_spi, "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2352,6 +2351,8 @@ static const SDProto sd_proto_sd = {
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


