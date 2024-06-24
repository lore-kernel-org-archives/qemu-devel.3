Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4650CC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjYq-0004rp-Gh; Mon, 24 Jun 2024 09:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYL-0004OP-UF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:14 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYK-0005ap-3R
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-362f62ae4c5so2491215f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234970; x=1719839770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHRr6B3uuTd3EFTNdg9fHFN+Zyvmx7WRQ/X+xj1mCi4=;
 b=gqBOqknQ/OIPJxDm3WWkgHhOi6csfteVs4louhsZw6C/BYDtx3Bzunaz3alzCoPYQv
 mIusBWY9bhlP6I4fNerJjoGcXk4tuq8hJtW1V9JIYlOk+LcSWE92R5OT4vsiB7DPTysa
 eKGdcgqVrfzQ+r+lIiX+QpQQNlGezTev4bTdasjPy45VM569XSiujIOgUi5t28o9U3sT
 T2yWw1jcgSON8Xf3o8p03G3JPPN89aRH93EeMDKInZilOTsbSuWL7O3uAn1TZPtgzATI
 n4R9d+zY0axZM+bdO0FGfQramUzzMk4Ades6n9pFzyyxlJgwNtZjKgd+fIsbUlTV3KTE
 4TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234970; x=1719839770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHRr6B3uuTd3EFTNdg9fHFN+Zyvmx7WRQ/X+xj1mCi4=;
 b=KG40Mj5ni/CYOG057/iMD3t+ZbpmfyCF+bizrGJRGH50dT7K5bE8ei6dXVAKh4NqZV
 vo/Et3iUNzsvgw6u9hXjhMJZP3pFzs7uV9TP3Ym0c+d87KKCm2YO3WzI9hPw98fCBPH2
 lYzkdMEttewIejtxm3T7cfuJPY63TuXcmOWg71NPjjyP03m/RY7BhAiaPOJMjDi+n+jA
 uYbkSg31paGX6hhSqbRwOd1olKUES5AMbpy5NybBNY+7CC8i709z7E2r4uGH8MpY1gxi
 VIetKKJIlIb4I8T0J1+jYgCIqr+aaoJq02yH0lvCqNEgS5pHB4fE7uQQDA92mIQFawkP
 vAKg==
X-Gm-Message-State: AOJu0YwR5j7J/RyccM1DBQlSY3yPu9k3p4uGMRx51fJiuvVMMai7HV5E
 9f129PpipTR6EE/vNIN5h/19wByAdXAqZoKgXscOnxeRXcl1jAQLlZUHJk2MDHBtRMKgZicyxM9
 x
X-Google-Smtp-Source: AGHT+IERn+fMNW0WYrw6V3UBcWIEEfdj89cCClvSkzcNO7C7hAJJgrLWZeluXp4cEF2HafnF+Mr/lg==
X-Received: by 2002:a5d:690e:0:b0:365:aec0:e191 with SMTP id
 ffacd0b85a97d-366e32956e7mr4379778f8f.21.1719234970345; 
 Mon, 24 Jun 2024 06:16:10 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f6da6sm10006561f8f.12.2024.06.24.06.16.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:16:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/19] hw/sd/sdcard: Only call sd_req_get_address() where
 address is used
Date: Mon, 24 Jun 2024 15:14:37 +0200
Message-ID: <20240624131440.81111-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

It will be useful later to assert only ADTC commands
(Addressed point-to-point Data Transfer Commands, defined
as the 'sd_adtc' enum) extract the address value from the
command argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-18-philmd@linaro.org>
---
 hw/sd/sd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 51ab7cd003..3e4eb656e1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1114,7 +1114,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
-    uint64_t addr = sd_req_get_address(sd, req);
+    uint64_t addr;
 
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
      * However there is no ACMD55, so we want to trace this particular case.
@@ -1239,7 +1239,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
             sd->state = sd_sendingdata_state;
             memcpy(sd->data, sd->csd, 16);
-            sd->data_start = addr;
+            sd->data_start = sd_req_get_address(sd, req);
             sd->data_offset = 0;
             return sd_r1;
 
@@ -1263,7 +1263,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
             sd->state = sd_sendingdata_state;
             memcpy(sd->data, sd->cid, 16);
-            sd->data_start = addr;
+            sd->data_start = sd_req_get_address(sd, req);
             sd->data_offset = 0;
             return sd_r1;
 
@@ -1339,6 +1339,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
         switch (sd->state) {
         case sd_transfer_state:
 
@@ -1359,6 +1360,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     /* Block write commands (Class 4) */
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
         switch (sd->state) {
         case sd_transfer_state:
 
@@ -1417,7 +1419,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         if (sd->size > SDSC_MAX_CAPACITY) {
             return sd_illegal;
         }
-
+        addr = sd_req_get_address(sd, req);
         switch (sd->state) {
         case sd_transfer_state:
             if (!address_in_range(sd, "SET_WRITE_PROT", addr, 1)) {
@@ -1439,7 +1441,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         if (sd->size > SDSC_MAX_CAPACITY) {
             return sd_illegal;
         }
-
+        addr = sd_req_get_address(sd, req);
         switch (sd->state) {
         case sd_transfer_state:
             if (!address_in_range(sd, "CLR_WRITE_PROT", addr, 1)) {
@@ -1461,7 +1463,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         if (sd->size > SDSC_MAX_CAPACITY) {
             return sd_illegal;
         }
-
+        addr = sd_req_get_address(sd, req);
         switch (sd->state) {
         case sd_transfer_state:
             if (!address_in_range(sd, "SEND_WRITE_PROT",
-- 
2.41.0


