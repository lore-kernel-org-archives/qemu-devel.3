Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C357FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZib-0002GL-Pt; Tue, 02 Jul 2024 05:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiX-0001vP-5S
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:29 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZiS-0006Wf-92
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:28 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52cdcd26d61so4431993e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912142; x=1720516942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00CPRUcf9kqsnaJEo5PoDWaoJdXP5EBP+kdhrOAEpVg=;
 b=g8JDhn083tRCZOOZFJncHu6VEEb7MBas+6U01vp8iZ21i6l2bvCl2b48ioMqvRUXWE
 nlSy5fuEmo75I36ooKedHLpZuqMUVg6do4A3b7UUj4F5bKPfEC0/FFLjdYyPHkD1drp8
 6UvoWMU69p3or8WyPiTXmSr7g+CVDcbddQQL8j3OwUJ3JaWapizYyMMSNliZe+S6swQU
 Lfe7mW4xkvjoPTIyFBmRNKng//BqVYkgUh9ZGdGYilRiR4rFLyCJugV/VHnGsXeRBDkl
 ++rhZdPc5tNxRv+AtMd0nycuyR+QXo+b3Hjssl4u9eygUyDVgEc8cPDinZhmdfUJJk/v
 FBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912142; x=1720516942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00CPRUcf9kqsnaJEo5PoDWaoJdXP5EBP+kdhrOAEpVg=;
 b=m3APZoudO30uwF6NM2rkC3qECEMvvQ54pk9mMmzi8x8aUigphX16O0rD0GK8Ly9pKr
 YAFv9shjYXBsAHTqaO8zUNOa+/BKO/8hgK/KRROZiaTGtATrl/P5HRK3KqlV82mFXmZq
 OpxEckkRnWpIAkRBcgGxbVCWh3pV21BHhsOYgm9D0hPPuKrjq/RnmJVqqyT1Fw2vmjTM
 Oj8i5/V0GEsbQhoDznb4Ge64hthXVqLBbyjel2z1wVOyz97PLru8tDANT2joGY19m8ca
 IQCEn2sfeuJAOyg1BKusTar5L/P+yIoBRnVaZi6dV4o4xMy/IxELI4yd8A+wo9P7YqMV
 syMg==
X-Gm-Message-State: AOJu0YwgwdyNec58vQ8OuB46hwjeRGqhVEzD/q7MglpLTS5q+WbKzVN5
 HmDdXY1ukEVsVXJZJIKPm67nIwtLz31eGH3TcVDacMmYGJzwtcp/oxgJhGRD/PMMksFzGWyMheP
 F
X-Google-Smtp-Source: AGHT+IEYqGysloQ+ZPEVXlYj7v7gJ5ypQZ+Rv7mCI9l97RKyJr6p6KvAP8kjZCJBdKlCZOqdvrtmLw==
X-Received: by 2002:a05:6512:b84:b0:52c:820e:a7e7 with SMTP id
 2adb3069b0e04-52e826fb7bcmr5301284e87.50.1719912142153; 
 Tue, 02 Jul 2024 02:22:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36784e3e0f5sm1416879f8f.11.2024.07.02.02.22.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/67] hw/sd/sdcard: Convert SWITCH_FUNCTION to
 generic_read_byte (CMD6)
Date: Tue,  2 Jul 2024 11:19:58 +0200
Message-ID: <20240702092051.45754-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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
Message-Id: <20240628070216.92609-20-philmd@linaro.org>
---
 hw/sd/sd.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 60235d3898..b073700180 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1081,7 +1081,6 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 }
 
 /* Configure fields for following sd_generic_read_byte() calls */
-__attribute__((unused))
 static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            uint64_t start,
                                            const void *data, size_t size)
@@ -1235,10 +1234,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         }
 
         sd_function_switch(sd, req.arg);
-        sd->state = sd_sendingdata_state;
-        sd->data_start = 0;
-        sd->data_offset = 0;
-        return sd_r1;
+        return sd_cmd_to_sendingdata(sd, req, 0, NULL, 64);
 
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
         rca = sd_req_get_rca(sd, req);
@@ -1938,7 +1934,6 @@ send_response:
 }
 
 /* Return true when buffer is consumed. Configured by sd_cmd_to_sendingdata() */
-__attribute__((unused))
 static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
 {
     *value = sd->data[sd->data_offset];
@@ -2128,10 +2123,7 @@ uint8_t sd_read_byte(SDState *sd)
                            sd->current_cmd, sd->data_offset, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= 64)
-            sd->state = sd_transfer_state;
+        sd_generic_read_byte(sd, &ret);
         break;
 
     case 9:  /* CMD9:   SEND_CSD */
-- 
2.41.0


