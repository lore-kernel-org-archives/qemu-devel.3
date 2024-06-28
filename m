Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85556C30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5fX-0004r0-FW; Fri, 28 Jun 2024 03:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5f6-000464-UL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5f4-0007o0-Rq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:04:48 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-356c4e926a3so183213f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558284; x=1720163084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/+wPveokxEozPxxjAOxGefSnu5ni7iF2jFqdZAnOYY0=;
 b=jT9BuGRP9Pze08TyYB6ORGYUa8sIfX8QLhdn0JYaDHHf/bCmwlu5WXkJk5AniovYkY
 flCL7g5Wd5XjERMwJfTFTHbIexUVG8iuUUOeownAXEmVjFsUzM7VtLnEzx7QqlcXlHIV
 uezVWmCy7zxVcth3svm12i7kxZETlZJhZ4GX6+N+VLyIq9D9e2eP5Z02SQ0G+D5ZP84Q
 VN8fv7N0xZxjNkhBfzWuJsfQOcUARt+aFSPv0PBjjAE2k8JLjLdLZVSm2+x6kPlviSzP
 dHnF9w6eh534gNO9W5yARK8ac3ODJPEnEdlqmWomYkD5qnDcHy+J0O20YXoPWaMUURSu
 fJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558284; x=1720163084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+wPveokxEozPxxjAOxGefSnu5ni7iF2jFqdZAnOYY0=;
 b=SMGyozakxVxDLM2x/Dahwp//LL9ZeM1wxDOX1jgMPwaD+yeIzqFP3yMjN5m52dj04T
 JtIP/1W8lcVOFYwL4kUpbr5+rtlVniVzvAHcM5FsPP6+4sa4LbUtksZlGYM0gIghxsBy
 6oTZuOBIq23cilSv8YnN0U9UAEtk14yvDWa3rnUnsk0rIHXaFDWPeOGn+inP/0t6dWMb
 ry+sSCgrZ2SYOUOH9fpp4L+Jx3u8WOV9yGPOvWgHCUVxl31E823xWMoIvDDLWDfcRi6E
 RsW4hKP6CEXpBA2UJcDH2AqskHSr6qVTPa6gF0QMZsUqB0zh2DhCGR5x5QemChlCFGDX
 w6fQ==
X-Gm-Message-State: AOJu0Yw6lqnrkhym1yP/NVvCdqeNn/vuQ4VNq21QAuPJCulnp+4TfaxD
 h+ZcxJVsqCBb8rTzzc3MftoEG/ZMBGYMS41hAWf5ZOrxzEd3RL8sLdDesAt9Z1bYN/k60DxI3ij
 g7Og=
X-Google-Smtp-Source: AGHT+IEzcIv0cFZAuc7riOVOGPsLL77p/eCIglMGWeH1DN+zS1aVb++j1HjRKR/qPDVRiuit4BxfuQ==
X-Received: by 2002:adf:ce0c:0:b0:361:d3ec:1031 with SMTP id
 ffacd0b85a97d-366e94d152emr9964234f8f.31.1719558284590; 
 Fri, 28 Jun 2024 00:04:44 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd623sm1334871f8f.16.2024.06.28.00.04.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:04:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 22/98] hw/sd/sdcard: Convert READ_SINGLE_BLOCK to
 generic_read_byte (CMD17)
Date: Fri, 28 Jun 2024 09:00:58 +0200
Message-ID: <20240628070216.92609-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
 hw/sd/sd.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index dfcb213aa9..605269163d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1405,11 +1405,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
                 return sd_r1;
             }
-
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
-            return sd_r1;
+            sd_blk_read(sd, addr, sd->blk_len);
+            return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
 
         default:
             break;
@@ -2144,6 +2141,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
+    case 17: /* CMD17:  READ_SINGLE_BLOCK */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2154,16 +2152,6 @@ uint8_t sd_read_byte(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
-    case 17:  /* CMD17:  READ_SINGLE_BLOCK */
-        if (sd->data_offset == 0) {
-            sd_blk_read(sd, sd->data_start, io_len);
-        }
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= io_len)
-            sd->state = sd_transfer_state;
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-- 
2.41.0


