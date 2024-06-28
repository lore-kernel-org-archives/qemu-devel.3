Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF38C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5gG-0000Bw-1W; Fri, 28 Jun 2024 03:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gB-0007rZ-RA
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:57 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5g9-0003Cp-6s
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-366df217347so208912f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558350; x=1720163150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lRVCvBojEsyxAg7JZRES3P5o6lr6YCg7S7r2PnPDGt0=;
 b=X9QapbV/e5yFZDq9ITff/b+khrLeetST0d/GdlsCYMaPe+Btu3m7Ppy1mCBdqMLgHd
 sibK1ZWE87dDGSruNI8jzXosiVKWypZJ1B8QQHUQ+Na13wekQ+3a3Yt42h22Vm/ypFsA
 FTtLK5yrMiXPc2F0TID3FWKS7x5522L59e+fSFX9E4dBnHRJLiCdW3RGjvEhhHgpjA5B
 57mf3dOpCFlZvsbInB5lBecISjBK1S1xPu8Jeqem3j5WGQ67LnjCpEB0uOBbmdSDYjRQ
 H8QCKA/a0BhbC6AGzzzRmPGQfg+Ak4vptShTWxY1jQZ+q8VE3wWPLmPqOgM8KJYbv2WZ
 DJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558350; x=1720163150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRVCvBojEsyxAg7JZRES3P5o6lr6YCg7S7r2PnPDGt0=;
 b=Ynn4VlmNsIiY3Sg/H3YMp7e4UGx/kxvVhVt2PFMdacqjcdkF0TS6mWuzoZD21Nq2hU
 xuMVbmne9sWA5c3DLzAsTkMKFyNhn9W4DmEshWa96IJoZpxRH7cEC0XwcSkjxuYeV3q1
 p12nuIz2ZqaFiSXwb/UqINqvBiZuA+C6o52xfoDI2z/lfw9LC3EYMfx/0Cj8Kf0GQmQX
 3lbYUl2Rq0wzX3olOh2k6O7lDMcwjtGEjQ/+pXF1TX2YEbO8AJILerSRvFUxgnFhgXSE
 wfMIQP4BErTElc96/Pkiqs4TlqliHqCFzUFYdEarlhouP+1kxlOhn4c4lbBbjtdO3dcO
 9OfQ==
X-Gm-Message-State: AOJu0YxLc+dPMkDS9NNAhsrkzrjecPS5ApEUffuvzsiYXmOKPaL7tVsn
 668cWORpL2rbZXaZjsiHa4hmScOjT0DW7psFiMo+G3r3s/RuRXEjpyb3mMyXcHC07A1O9TtTQIe
 rmcY=
X-Google-Smtp-Source: AGHT+IFc9Ge/38i3D2GnHG4fGornYYEx7Yukr7zX557f8i9CYAj0rbzQnazwlFGnRo19pZtxmFpsEg==
X-Received: by 2002:adf:f98c:0:b0:360:73b0:e58e with SMTP id
 ffacd0b85a97d-366e9492ca0mr9116033f8f.26.1719558350581; 
 Fri, 28 Jun 2024 00:05:50 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd784sm1348789f8f.7.2024.06.28.00.05.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 35/98] hw/sd/sdcard: Convert GEN_CMD to generic_write_byte
 (CMD56)
Date: Fri, 28 Jun 2024 09:01:11 +0200
Message-ID: <20240628070216.92609-36-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
---
 hw/sd/sd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0cb528b0b2..f9708064d0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1657,14 +1657,12 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 56:  /* CMD56:  GEN_CMD */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->data_offset = 0;
             if (req.arg & 1) {
                 return sd_cmd_to_sendingdata(sd, req, 0,
                                              sd->vendor_data,
                                              sizeof(sd->vendor_data));
             }
-            sd->state = sd_receivingdata_state;
-            return sd_r1;
+            return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->vendor_data));
 
         default:
             break;
@@ -2109,9 +2107,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd->vendor_data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->vendor_data)) {
-            sd->state = sd_transfer_state;
+        if (sd_generic_write_byte(sd, value)) {
+            memcpy(sd->vendor_data, sd->data, sizeof(sd->vendor_data));
         }
         break;
 
-- 
2.41.0


