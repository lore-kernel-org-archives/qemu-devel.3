Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34673C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZJB-0000Kw-N2; Fri, 21 Jun 2024 04:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJ9-0008Vz-Pb
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJ8-00006Z-3L
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42172ab4b60so17211685e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957260; x=1719562060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRY+1ohspoSd94VnPHqa3ped6qMZHLQr+fY7mqCBqOo=;
 b=uoNsCivAPtjTeqM24po4apHb2hxNWXhF4njNivfLACjkapEqJCzQoe1fhPazTKnV9W
 MA7IOJ9M/pOoy40bD/ERRxHcd+Qy2bfvXuBG8N5EWImmjxUd2yWd4g3i3zf+c89Og441
 vzDC8H+U91L/p/vGjhJmr34fGsidSs50XeORG91QA4Mchz90SsBpTAW64qW0yKiIlrPs
 brqJ/Q5gK1TmTNcMKhNb5aSb7r9R9WqcwI+jmS0O2wwJYVonLC7c5xCIkCh55MCg2sq1
 uU+dt3vM/5P6NC55pyigab/LF8EIMYkh0XDVgM+k2yJ2jhkGWrGwLpYr7r1dQ1+qtfg7
 E9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957260; x=1719562060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRY+1ohspoSd94VnPHqa3ped6qMZHLQr+fY7mqCBqOo=;
 b=t4fbXyeBtchMZa+4nTqA8SMAD6Db/bvMpsz36kWmtDejbyunbwM12gCtboHWzEx3nz
 i/l3eQO31yqqpGsohe+sUhLhOnxwmX6FPzWZZs/cjlDMYYIGqjqqjr/TzZEPyr6iOu25
 lSn3vtvWgmkfmKNB4fuLIg8Kjqf8+asqMCM8QnFkRmrVL+Ql7yv9nwSkI4TOiMLWuGip
 hCfkXmq1k6uhxylYhIdsKNacnwYA87oPG6mAuq8oee+r2B9DniHRLsYF4PB2WC2NWtLj
 lOeLdGRinXLXJArcUIvTtPaDbtrZNG3baK37Yby3kJHPXNl6lNMa4vLxSGXzgpI5NavC
 7F6Q==
X-Gm-Message-State: AOJu0YwvjXouNqKODgMg787EjCYFiRx04bnxvcENX+/mP8am05rvJT34
 KN+FWWlGykyEUWP8OQobyyG2jKrIUQ259eOKiKoMSfOIuotzbGwprRjXH/cfSW3lh8gPmQym0/C
 S
X-Google-Smtp-Source: AGHT+IH31r+630bHuYtx5aBzBCMVZY8YoyyQJepeU1WQHAMxpevFgHrzUcOCAGM0QLWu5KI3hE3itQ==
X-Received: by 2002:a05:600c:3b25:b0:422:7dc7:fc23 with SMTP id
 5b1f17b1804b1-424752a5639mr51335615e9.41.1718957260063; 
 Fri, 21 Jun 2024 01:07:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248482f1c4sm2254535e9.10.2024.06.21.01.07.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 17/23] hw/sd/sdcard: Only call sd_req_get_address() where
 address is used
Date: Fri, 21 Jun 2024 10:05:48 +0200
Message-ID: <20240621080554.18986-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 hw/sd/sd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a0193a46ea..1df16ce6a2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1111,7 +1111,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
-    uint64_t addr = sd_req_get_address(sd, req);
+    uint64_t addr;
 
     sd->last_cmd_name = sd_cmd_name(req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
@@ -1237,7 +1237,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
             sd->state = sd_sendingdata_state;
             memcpy(sd->data, sd->csd, 16);
-            sd->data_start = addr;
+            sd->data_start = sd_req_get_address(sd, req);
             sd->data_offset = 0;
             return sd_r1;
 
@@ -1261,7 +1261,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
             sd->state = sd_sendingdata_state;
             memcpy(sd->data, sd->cid, 16);
-            sd->data_start = addr;
+            sd->data_start = sd_req_get_address(sd, req);
             sd->data_offset = 0;
             return sd_r1;
 
@@ -1337,6 +1337,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
         switch (sd->state) {
         case sd_transfer_state:
 
@@ -1357,6 +1358,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     /* Block write commands (Class 4) */
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
         switch (sd->state) {
         case sd_transfer_state:
 
@@ -1415,7 +1417,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         if (sd->size > SDSC_MAX_CAPACITY) {
             return sd_illegal;
         }
-
+        addr = sd_req_get_address(sd, req);
         switch (sd->state) {
         case sd_transfer_state:
             if (!address_in_range(sd, "SET_WRITE_PROT", addr, 1)) {
@@ -1437,7 +1439,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         if (sd->size > SDSC_MAX_CAPACITY) {
             return sd_illegal;
         }
-
+        addr = sd_req_get_address(sd, req);
         switch (sd->state) {
         case sd_transfer_state:
             if (!address_in_range(sd, "CLR_WRITE_PROT", addr, 1)) {
@@ -1459,7 +1461,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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


