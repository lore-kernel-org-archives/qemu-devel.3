Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599BEC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8t-0002hL-AO; Tue, 25 Jun 2024 01:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8r-0002ZK-2S
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8p-0001gy-HQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-362f62ae4c5so2925350f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294894; x=1719899694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5P7HyM7CLqMyqYOTJNfxbyYOLKZqsQ3trYZWJFhWDzE=;
 b=jUxo+UMRrb4lQQJOA1iKG8vA2k7OE0McSg16cyQRGH+1+H5Md9XTIrKFhWTCxvoLyV
 kXwPTFiGFI3ItGHq1B0mzAIhpPNzpA33/znaQq9PjrOnTOgBPL4V2vgYkY8Vr4sZJCPV
 198lvfcNO65oumKNZXtKj5NtijfAyZA3IKKOY+Tlah6JkqF7joS++UGEsNWgmmPkCspZ
 YAa4abh71wSTaamug3R0u4vLILfbrzaCRafdK5JwdM1PMpL+dJch7xQVv8LyWfrHViiy
 lYhpcxQGiQgPbZ7DOh8oI8bOUNQS/Mv4bhdyKctnopFX8XvTTA3D/QZPTE+JnR9CB6Gs
 rgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294894; x=1719899694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5P7HyM7CLqMyqYOTJNfxbyYOLKZqsQ3trYZWJFhWDzE=;
 b=VWeSlgYHBoIUFMDM5ICNwZmy1GC+FQLFJ/iz7sAHetQhKckY3zRatP5ViXA4B6ap7h
 ztBrHpTB/Moj2lqqUMxp2+nzs7lbtfUn0X4fpfMZ9VHwzcrCOjPU7DlQFSdshI9uEFEq
 PSnN8qB8i9dbi++4wWc1BLLE8CvVuZR2n1gi4+ev3EgqNXUqbdeCXEd4zgxCKHdEz+lU
 i+Ae5R4rq/pnQKAgLIEIJZjZvOIh34lTau5n3zw0QtsboldA7KwKDUoFR9byK9fQdOjP
 6doz7geRbVu3t/jta6Z2OUAtN+gt/+EDqJaOUb8TtejBMPBeN4V62ut8CDcvnpK2yibf
 NiNQ==
X-Gm-Message-State: AOJu0YxRO6xpaHdLCKCI33yYxAoV3EdzGPqvV1GYAcWqF1g24EAWHEH6
 R8FR96BACp/LZUsEJrTuXNYaho4NAxlmVCVIgsFz/4KotSSQToavlVtZCEfI6drEcLV+44IX7FS
 y
X-Google-Smtp-Source: AGHT+IEAlgGMpHRcV9j43LCtCz2MJYI2Au6h0fZSPqtRVLGMXc/0FJ3cHCluLTMK6HzHOlQ+UjboVw==
X-Received: by 2002:a05:6000:b0c:b0:366:dfc4:3790 with SMTP id
 ffacd0b85a97d-366e34a3d7dmr6074472f8f.0.1719294893836; 
 Mon, 24 Jun 2024 22:54:53 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366e88c0c38sm7509752f8f.32.2024.06.24.22.54.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 10/12] hw/sd/sdcard: Simplify sd_inactive_state handling
Date: Tue, 25 Jun 2024 07:53:51 +0200
Message-ID: <20240625055354.23273-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Card entering sd_inactive_state powers off, and won't respond
anymore. Handle that once when entering sd_do_command().

Remove condition always true in sd_cmd_GO_IDLE_STATE().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 36955189e8..fce99d655d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1072,10 +1072,8 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
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
@@ -1570,7 +1568,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         switch (sd->state) {
         case sd_ready_state:
         case sd_identification_state:
-        case sd_inactive_state:
             return sd_illegal;
         case sd_idle_state:
             if (rca) {
@@ -1791,6 +1788,11 @@ int sd_do_command(SDState *sd, SDRequest *req,
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


