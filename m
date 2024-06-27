Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F95C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrvv-0001dR-Uq; Thu, 27 Jun 2024 12:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvn-0001FP-FE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:08 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvl-0001sx-C9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:07 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52cdf4bc083so8634359e87.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505502; x=1720110302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrQTXcopwoxdy2+QKjolzASBZvpHRSjsIoJ+STiyvF8=;
 b=bh02eA8OoA7i+S3Muf2N4/heA+YwgiwrMGg2FkxAqwtW4/qBuBKQueVTyOG0lpE2IO
 QuuDCNMRv9pUhdcoKelJbirmrLFzsPtbdUtiqZSmEqayi/WYcyZu0iQr/Pbu95aU+LzP
 +bSJsArgyeadIfCmiXqoKZ5HIMN+7Spi4rArTs/xnuelLLqhbLqm5mX+UzxZk5JGK8HU
 qV429Wm99eP/fgsqOEPtzok98RCd6wSywtg8OMfl/7N5LnVDL+vcaa3ynArFCqmfAt+b
 4b0O90ZVS1GbryRfzc0bIdMFLNqbHkaKVrgr9DOfDVsWhKBBd7QyeLO/iyRze9WEH1C0
 j31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505502; x=1720110302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrQTXcopwoxdy2+QKjolzASBZvpHRSjsIoJ+STiyvF8=;
 b=VN18+hVfdSQeCAT1xX8MZaBeZz6kouiZnZwieg5PuHs0nbODkwXoNlfsywUSLLWp5u
 S5LBU16MPpvIgUHy/eMdcsNzqM+aGREUdfIvps1lBzLkINFxFKbpWVXisTwXcKLqoRQ1
 SSNCX7ib+WcS4AQZ4QpzcgGycbt6eD8qf2I7RB3CloMbSceCMDijIoZJCa795WtjVt9s
 LG7eATRMYSBD5J24gMqg5TYLoSBxtj7MDsqyhVKwkCjAWZp791SQJT7AUHZAdPvkqNP9
 hORptPRH7Ylf/Bkt3nhu7djOCMSjCimbXu2f6poQhQRA5dAU7IJ7XW9KDmXox5KJlsWt
 Iqpw==
X-Gm-Message-State: AOJu0YxjLexk9gqfhq8tGfvCWmG/qDVsDkCBCPlMP4g+FwDxDMvCm+vk
 EXNPz4hfbH/Qy3HpkhsYgXxnF4naQxa5JuZtMCgEk4aNiEXgSmsFXeiBvFuRsKTpcr4wgyGIVhM
 QhJk=
X-Google-Smtp-Source: AGHT+IFVInSIcNR0npaDmYdZJoWs9nn7TsAQUx5OMi6YRV4gIMxIMMyPzvzt7Lc2dm6YTqERnTJvAQ==
X-Received: by 2002:ac2:4c39:0:b0:52c:8c85:cb46 with SMTP id
 2adb3069b0e04-52ce064697bmr9932361e87.64.1719505502194; 
 Thu, 27 Jun 2024 09:25:02 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8246297sm76615625e9.8.2024.06.27.09.24.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:25:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 11/17] hw/sd/sdcard: Simplify sd_inactive_state handling
Date: Thu, 27 Jun 2024 18:22:26 +0200
Message-ID: <20240627162232.80428-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
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

Card entering sd_inactive_state powers off, and won't respond
anymore. Handle that once when entering sd_do_command().

Remove condition always true in sd_cmd_GO_IDLE_STATE().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fbdfafa3a6..7533a78cf6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1081,10 +1081,8 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
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
@@ -1579,7 +1577,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_ready_state:
         case sd_identification_state:
-        case sd_inactive_state:
             return sd_illegal;
         case sd_idle_state:
             if (rca) {
@@ -1800,6 +1797,11 @@ int sd_do_command(SDState *sd, SDRequest *req,
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


