Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DDAC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZi9-0001CT-96; Tue, 02 Jul 2024 05:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZi3-0001B7-4e
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhy-0006SF-Fn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-424ad289949so28596435e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912112; x=1720516912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGAqlXXmWHNhTh9vgnZWCBaKbJgiHWhA9edkrjy7PcE=;
 b=Ak49Db7zbTHvDl8yDot8XOnyehNXcLQNBGbjbwYuqSuBk4DWQIF/mE4Mc59MgU/5aT
 2Dww1kBNkTQGrkXWhvER05zKobR9Gh0pEK2FlUIeNeVnzMDvqcZ5lftDhIyeFNDpeVa0
 VPcmzB7pRksBQUfv6atbHZn2OmxJ1tt88q527+XLniC/GRhQctDariVb5Zq9BrKRhMAS
 4G92+lUEgrODE1wh+wcP0us2nOBqiPW8aTBN82US4kTRutqtr5kpp9fClXup2vA7aCih
 GB80jxj/y4rFJFn8ox4p15vapOeHHKyfOhQrowwb7WCIjoVrtPDCwk07E+J/N+WMKB9Z
 0Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912112; x=1720516912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGAqlXXmWHNhTh9vgnZWCBaKbJgiHWhA9edkrjy7PcE=;
 b=VaZys4X3z21yRy8Mwd+PsqvGQm9lXeI8XDEKJD2SgLy285Apn+uA5k6OYYMAi/T8Rq
 bW7/SXwyuq7fQTyT7sXSVYmjxsA/GSdIUBZ+LFYdcmTeGVfVtp7rOpHDkqsOjfdKnPI5
 JZydVybksNxF5Ad678T+zvWLjEuHV3oqxnuIGOV1Ej5HqjNPHDYOq+8os8y7bETHpqL5
 a2OvWcUODhQNfBWwrgmwbTnWQu0irIKRZCJ5KoLSpiD+yAlrkCavO1wJE4//VeHFC7gG
 w9huUaB4mQYgvz6s3d9cnaQfRc5TpfvB9t/+ewEGrrsApPDOh09csMW0cPibK1qHy8cb
 dz5A==
X-Gm-Message-State: AOJu0YyiqFWaBi9DVQTNefCNWXie+vheSwat2A+DMqu5INtIDK52SuXM
 TfizepVBGVneSlx2bJC5yM77IsOVZiHWNwrMzWd3V2U2KVqBxyungRONG2t2WQuX3TO9Oz8ffAT
 S
X-Google-Smtp-Source: AGHT+IHQJifoKcqTa8dDVQmj1rRhk+XofTXeCiT3xFEJviYT9/2UvnbYF49qTp76g8ymgpcGDuZLJQ==
X-Received: by 2002:a7b:cbd2:0:b0:425:5eec:d261 with SMTP id
 5b1f17b1804b1-4257a02805dmr62707875e9.34.1719912112410; 
 Tue, 02 Jul 2024 02:21:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257a2f7451sm132918665e9.0.2024.07.02.02.21.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/67] hw/sd/sdcard: Simplify sd_inactive_state handling
Date: Tue,  2 Jul 2024 11:19:53 +0200
Message-ID: <20240702092051.45754-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Card entering sd_inactive_state powers off, and won't respond
anymore. Handle that once when entering sd_do_command().

Remove condition always true in sd_cmd_GO_IDLE_STATE().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-12-philmd@linaro.org>
---
 hw/sd/sd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 824cb47856..30c1d299d4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1078,10 +1078,8 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 /* CMD0 */
 static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_inactive_state) {
-        sd->state = sd_idle_state;
-        sd_reset(DEVICE(sd));
-    }
+    sd->state = sd_idle_state;
+    sd_reset(DEVICE(sd));
 
     return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
@@ -1580,7 +1578,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_ready_state:
         case sd_identification_state:
-        case sd_inactive_state:
             return sd_illegal;
         case sd_idle_state:
             if (rca) {
@@ -1801,6 +1798,11 @@ int sd_do_command(SDState *sd, SDRequest *req,
         return 0;
     }
 
+    if (sd->state == sd_inactive_state) {
+        rtype = sd_illegal;
+        goto send_response;
+    }
+
     if (sd_req_crc_validate(req)) {
         sd->card_status |= COM_CRC_ERROR;
         rtype = sd_illegal;
-- 
2.41.0


