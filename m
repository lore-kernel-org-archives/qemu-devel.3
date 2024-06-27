Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7845C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsAW-000328-QY; Thu, 27 Jun 2024 12:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsAT-0002pr-Ch
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:40:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsAJ-0007B2-59
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:40:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42561c16ffeso13608125e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506405; x=1720111205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8MZ6mDUZDTzEHMhB6amOhsFMea88t3Iug/OVUXgLHk=;
 b=nyIWwoFQj97vio3Q/DVDtQKN1qy6wevdFZ01B2rGvAOtPi1dmNgkq+I3TGLYllPf5T
 jCBnA5CRdu5bj+4tbsc48C+f4TjTRNC3Kj3ALcHDGnEeIXxPI4pJ38PyDJOdjzbPNJWB
 DiriMu7WGcq6QCYGh+cBHsAiD64JAGV0b701vVV1jEWddw+cBa6bF9yCivtBFAGjRpDA
 HldaINXLxig5ZSGf4R+nF8WDiveDA3zn4AWUunokNIe6aJk3idSopcycfXB2n2tCmBhg
 k+xZr6eyQYwgJF7debx9OWbuWoZpIOAv/O151iDV1Fasgi1B74Ggg+BlSr/o4B0mype0
 Oh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506405; x=1720111205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8MZ6mDUZDTzEHMhB6amOhsFMea88t3Iug/OVUXgLHk=;
 b=A2aC+RWggtbzqlZ+b+3x9RD8ZAXzckKel5PAefY5XdbvlTLB1+8SRsfneo71P+Obc/
 ebXJXsdhcKIzncQssw3HAy7C/DbV0djbB0mUPn3Os5YOR1J2C7WcohvkZZvjmGc9eiqf
 nxKlr7znSpLLGHPbrPNU62ENv/URKkMOYou4miKOx0LnLPdJA25IsgLObY6YZHxHtm9o
 gFqSlrR/Zkn/mQcDzF2CHNfG/k7z0+GeeC8vUDNjK3N/S9H/HDELfcfZLFagr70d+BYV
 5ZekH3JBsxReN8UH+XgZ7JstWnwomekzb3zp3HdykJK5PM6aw1fVF1ggOqiUEd4MVFsV
 su8A==
X-Gm-Message-State: AOJu0YyJFmpwpNogE6dwLWg1ZekijQAr0AGjxHew3u+CmcNCVu+RRtfm
 Wzc86BD7K0xocA6QugvPh6vNGuHmO2ibQEq706pbCumxlKmSMCUxcvAszDjLcwDu4ym9d0tqPS2
 ixVU=
X-Google-Smtp-Source: AGHT+IFASbCFBjpGiWVDsNWkrlHZ73fhz2u9Xj8DTnsiMAfK+PxGDrjDb9t5Isl35i7+klHHRNIX+Q==
X-Received: by 2002:a5d:640a:0:b0:360:791c:aff2 with SMTP id
 ffacd0b85a97d-366e95dc73emr8915932f8f.47.1719506405159; 
 Thu, 27 Jun 2024 09:40:05 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674369ed92sm2386851f8f.105.2024.06.27.09.39.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:40:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH 07/11] hw/sd/sdcard: Remove SEND_DSR dead case (CMD4)
Date: Thu, 27 Jun 2024 18:38:39 +0200
Message-ID: <20240627163843.81592-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163843.81592-1-philmd@linaro.org>
References: <20240627163843.81592-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 hw/sd/sd.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a816493d37..097cb0f2e2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -240,7 +240,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
+                                             [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
          [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
         [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
@@ -1153,7 +1153,6 @@ static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 }
 
 /* Commands that are recognised but not yet implemented. */
-__attribute__((unused))
 static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
@@ -1312,16 +1311,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
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
@@ -2289,6 +2278,7 @@ static const SDProto sd_proto_sd = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
         [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
+        [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
     },
-- 
2.41.0


