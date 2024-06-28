Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9342C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5fc-0005Um-Um; Fri, 28 Jun 2024 03:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fR-0004fv-L7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:13 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fP-0000tL-Hf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:09 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eaa89464a3so2279001fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558305; x=1720163105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vHrlK0ssSPoiMv6JdxaV3fer0W42cR0Lk/0TJKW1fyM=;
 b=v+LyBQ2ujnCM/IWL39NRPfLWAWv24mpi7J0dIQBpHeqgJuXcqthH3XUNvunWaIhuqw
 yt/eWkJE86qcL6VNRrhyyCkgT/Y3gLmZnAmYq4kNebnmcm9mtqjZ/87v9+J2H/OiYtaX
 mE14S/essPEif7yKaY7ENoFUPmSN70o57/vQblu472psovJ7OnxQl0NBI8nZODdUlk0O
 WDKQPQpNr3O4/CZQSDyJkpbSyxjLhNxRJhgu7pMfxLfydc1ewS1MXgwaot0foE+eP4Az
 LB2hchnt7vVFtEmXCn0618xz0vdamtQgOehWP6vFRYs/QfNZZl8G6UEGNb33ozIOdeqK
 wusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558305; x=1720163105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHrlK0ssSPoiMv6JdxaV3fer0W42cR0Lk/0TJKW1fyM=;
 b=LYhkHQc+nz8RVsxnMCZMgqAKBoUTn+TA3rBQuAweqFPkQA3qdrhS5aJyMHjjzI2XMx
 tDGa2h31jtdhqLzRe7bj6ZhsVMiz4Gh22ChjiQbfwoM5egAaOa5ZIU1pXv/A2ADC2Bnw
 QVxWf9BVDG7Fh5Af03NxASTiqCmc2fDM0RH71Q4GFfGj+O9NkusvFDxb2LSE+GY0b/kx
 O4iz+31NyZbtuS30w2nwhvMBnd3/3crxt30N0+xhLluWmpvm23A9zwgi4ID4XDqPCPgI
 s4OEck2VdRDjQoKIY5tTILDkZ+N5UHQv+QGNZf4WyXFeAeX8mUipCHCtAvbNVYhf7KnY
 R07g==
X-Gm-Message-State: AOJu0YxxuO/wf+rPjYt86tM4QnN7mIRjsc5/n50MMlcJZy5/JqSZzaKV
 6Oyv5X3/IwbFWYqsv4S3DgwFN3cMFcrnWGZjsHrE3r6nUTENtNt4vySkKc8zmnh/DWMwQbYOYXT
 S/Rs=
X-Google-Smtp-Source: AGHT+IGTanHS0A4AAM7lp4h+Munz65o8IScOywEusJWLprettV3WfHTMhh5UeVs3cTKe5lLyQNP2Jw==
X-Received: by 2002:a2e:3c03:0:b0:2ec:4529:9690 with SMTP id
 38308e7fff4ca-2ec57967b72mr91283161fa.3.1719558305105; 
 Fri, 28 Jun 2024 00:05:05 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3b8c0sm21400365e9.2.2024.06.28.00.05.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 26/98] hw/sd/sdcard: Convert SD_STATUS to
 generic_read_byte (ACMD13)
Date: Fri, 28 Jun 2024 09:01:02 +0200
Message-ID: <20240628070216.92609-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ccf81b9e59..1c4811f410 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1703,10 +1703,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 13:  /* ACMD13: SD_STATUS */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, 0,
+                                         sd->sd_status,
+                                         sizeof(sd->sd_status));
 
         default:
             break;
@@ -2136,6 +2135,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
+    case 13: /* ACMD13: SD_STATUS */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
     case 30: /* CMD30:  SEND_WRITE_PROT */
@@ -2143,13 +2143,6 @@ uint8_t sd_read_byte(SDState *sd)
         sd_generic_read_byte(sd, &ret);
         break;
 
-    case 13:  /* ACMD13: SD_STATUS */
-        ret = sd->sd_status[sd->data_offset ++];
-
-        if (sd->data_offset >= sizeof(sd->sd_status))
-            sd->state = sd_transfer_state;
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-- 
2.41.0


