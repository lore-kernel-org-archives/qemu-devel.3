Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AC1C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZka-0003kR-3t; Tue, 02 Jul 2024 05:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkW-0003Ug-IT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkT-0000AI-8t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42578fe58a6so19197785e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912267; x=1720517067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBHa6mNek3D9ym3Q87IBUwFBzBOdC5TAXndf6AluXYE=;
 b=K10Y1QbVj8xLvNe0o6ZE0fwXkSTa2wJ3eFNKziO+HCLeXAi0ubXLwPaYQ23Qh0XqIq
 FR4KPEgqu49qZa9JiLLZdhnL3FJxWav/WEpaZgM4rQMsNtjvw3FPup9sc+pyoxrSuN8O
 MRMVl5CwiwVy5B994S9mjLeQySWTVuG0CZDTH1PmASkBLTBfc9SvzvTVNOlhamH10SsK
 596fJDkhhaE6MbINHDQxP4s05b3tuMQdLQrsGOHgq1pDx1tfsSbSwcKWGsLM4MhnoCfO
 ZWWYMd6ZXw6WbBRN5Pxt+ChFM7koAwa5rEt4ZB++JTjqGf8zTExHTErwWQ6camzz9aQa
 taug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912267; x=1720517067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBHa6mNek3D9ym3Q87IBUwFBzBOdC5TAXndf6AluXYE=;
 b=cpPnFE+39DHJmM8AUSFLG74W2SvMOCfiPh2E2v/RrkqPvZAmGZ+x6xE3bbFygi3GM/
 hfOiiyeujeMxmK63EGgDb4A28gN/9jxe4Zw9Yq6bSC1RfOlD6MInYJVRo72GVIQg7A8r
 7AgkpC+L9LIG/DYVqGj+PpmLFjS5WZdexSYNqc7NWfAXOvU7p1nr+kQrkg4Gt/I5ZeXx
 bF+4dMCW64Xbcty0bC+Oy14g4HFVz+wRhbFIdckFiwrY7IXFfVeUzARNtgg2OXnNlb0b
 LkzJ+//MoKg6VKkHBrhi171trINIVNXevgbVdCTdx4mH9jzjqGxIF6ac82ohHRh39qED
 uqaQ==
X-Gm-Message-State: AOJu0Yx+xBFU2b/yUj4y33u8s9Q2GPgrzky2IcqcCiRSaSPgnJKe+2pK
 kaPEjoJgX5ZwMQZRrgHVLzXXp/YnV027ieXu1LBf2a+ikaj1cmGITPNscVs3MLUrOLjfOFT7R/s
 +
X-Google-Smtp-Source: AGHT+IHFkC/GD+27ERFvRsryG70pTGtkEADrgjcDrubK0lv/W0Khl8ppmFIG8qnq/jtS/TA7i4u0yg==
X-Received: by 2002:a05:600c:2252:b0:424:a823:51d9 with SMTP id
 5b1f17b1804b1-4257a06e036mr52075535e9.30.1719912267536; 
 Tue, 02 Jul 2024 02:24:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103d00sm12672880f8f.99.2024.07.02.02.24.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:24:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/67] hw/sd/sdcard: Remove SEND_DSR dead case (CMD4)
Date: Tue,  2 Jul 2024 11:20:19 +0200
Message-ID: <20240702092051.45754-37-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The CSD::CSR_IMP bit defines whether the Driver Stage
Register (DSR) is implemented or not. We do not set
this bit in CSD:

    static void sd_set_csd(SDState *sd, uint64_t size)
    {
        ...
        if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
            ...
            sd->csd[6] = 0xe0 |     /* Partial block for read allowed */
                ((csize >> 10) & 0x03);
            ...
        } else {                    /* SDHC */
            ...
            sd->csd[6] = 0x00;
            ...
        }
        ...
    }

The sd_normal_command() switch case for the SEND_DSR
command do nothing and fallback to "illegal command".
Since the command is mandatory (although the register
isn't...) call the sd_cmd_unimplemented() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-43-philmd@linaro.org>
---
 hw/sd/sd.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 68e6944263..c25e376b35 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
+                                             [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
         [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
@@ -1148,7 +1148,6 @@ static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 }
 
 /* Commands that are recognised but not yet implemented. */
-__attribute__((unused))
 static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
@@ -1304,16 +1303,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 4:  /* CMD4:   SEND_DSR */
-        switch (sd->state) {
-        case sd_standby_state:
-            break;
-
-        default:
-            break;
-        }
-        break;
-
     case 6:  /* CMD6:   SWITCH_FUNCTION */
         if (sd->mode != sd_data_transfer_mode) {
             return sd_invalid_mode_for_cmd(sd, req);
@@ -2291,6 +2280,7 @@ static const SDProto sd_proto_sd = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
+        [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
     },
-- 
2.41.0


