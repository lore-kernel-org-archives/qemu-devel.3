Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1D8C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5gq-0002x9-EW; Fri, 28 Jun 2024 03:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gn-0002X7-BM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:33 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gi-0003GH-HZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:33 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52cdf579dd2so268453e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558386; x=1720163186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W8MZ6mDUZDTzEHMhB6amOhsFMea88t3Iug/OVUXgLHk=;
 b=nCfxMW8nGlIedU12Wva6XOVhr02OSp/97twpqlJ3e4Zy29yC6WBztyEJp6QKjlVBKv
 qvjYtuzs8nwhKK5TXk29MPemeafaP+znRU4H4tHQ+j9bcHEOYaa+GZda9UWK8Z4FfA7Y
 EIFK8aoI3+GNndELIriaCYm0tnJqCfavR8RFOUZbnlpcgcZowxucvK3YKUeWpq9TpCI3
 UlWNQiPyUnOQ6UE23psRlzBttTp3cdbbAiAxUtWHir/qFffZQeCOj/LEjJms9FNk3rfT
 jI4HtDwUD9t8rxhgo/U7WGtoAVu+8tSszuWUDqNTaIYzsMD97KtIjZyAL+txxEbbLYCe
 /jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558386; x=1720163186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8MZ6mDUZDTzEHMhB6amOhsFMea88t3Iug/OVUXgLHk=;
 b=SNEFxYpyv0p+4rojpGK7tPFN8VbFM2aBAnxYBo4LesT9vjjjtbTFuvqjI9T7NbHrt7
 sYuqP6Jk7nd64uyb3brf+v+jhAQRcZGwhZvVqel0h9sCFuFFxyL2w9weHQ7+1PpklFFK
 kc357yN1VWDQLK5UzefZwCGTUR+ZUR0S4JCWwqU5MUNtHVQS3bfYljCii/cwRD4fRAIg
 ontJYwOAb4UAIGUNxVn6XlJpRWLQYbF4iQ3B2zl146d3iQOphCAO0B5kOi8lhFc7cjTo
 dNAuPppPzKWH89LPytoWO1+HhA7OW563GI4OzEMsFX9Px4lK1DOOghS16ugzeJtxq73M
 1wPw==
X-Gm-Message-State: AOJu0YzlLvY5w/tJXHyjKZHLO0Qic8fyZivcZpg0VG4LHCsg7cRwqi9s
 Sx1jSRK9eAYfLXVa2XB8qyI2LicIqk4zC2dq/Y9yt60Gi3LqSA614Y9S3TZaUOMVgfnKGvnOFuG
 YYmE=
X-Google-Smtp-Source: AGHT+IHeRMbgQJ2rJ3DsY15nZU+I+nHMEPb5fvLd3W7+mzOkQMpLaAGh09otk9zhIDTl13zNm7LaHg==
X-Received: by 2002:ac2:43ce:0:b0:52c:da39:e40d with SMTP id
 2adb3069b0e04-52cdf7f1581mr9240334e87.26.1719558386164; 
 Fri, 28 Jun 2024 00:06:26 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424a2abcfd0sm62312855e9.1.2024.06.28.00.06.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 42/98] hw/sd/sdcard: Remove SEND_DSR dead case (CMD4)
Date: Fri, 28 Jun 2024 09:01:18 +0200
Message-ID: <20240628070216.92609-43-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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


