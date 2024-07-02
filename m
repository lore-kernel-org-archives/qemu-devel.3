Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E7DC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZlF-0005KB-83; Tue, 02 Jul 2024 05:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZlA-0004qF-Km
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:12 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZl8-0000FQ-HB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:12 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ec5fad1984so55054121fa.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912308; x=1720517108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1S0cqs0T2pBpC9otbYCEZV3ST8t5p98azNZmcVeDSZg=;
 b=t3VxfJKJuGfF6HrYCXhMPtl4lB/9Vlm1gly4aRkRkhFhC4hk2DMIjssp72Kah0UboJ
 t1lwE2vbl6kDQXH+HuUS0wy5I0qxQ+4C5dmR09KudJYqmQ9ThYQ5cXVVk9NYhoodWqn1
 nhyXpWm26dVuJYQOOUT5hoIQf6WFtBClZuTGgoI3+t8spDpyuB4/37SlHOTFjAiQVLnX
 hGtsiJnbrzpxvGikdKXWqzEndar6DkIfKpVrj6kkLKGtY9eh8MrWUMPCaJDsZ26RP4gy
 9ewaHyy4vd+C57zmEWd5pzEZpQuffh13g7lxLQhzxpm0c2PqWO81gA59vsD5O2IKHdEW
 6Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912308; x=1720517108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1S0cqs0T2pBpC9otbYCEZV3ST8t5p98azNZmcVeDSZg=;
 b=YgPi2Bax+q0/vr42zR0qb2BwMYbGAS9CLcURvcbrmSrSU2lzP9qXdJrcJpqbD4LpL8
 tUVD7fMk8lyXlSSnd2FumLtcvdxPSi/zAoUuFAGsNIs99qY9meALo4GA84gVk6v4maq3
 +x/twS27xuIPX849VPuA+A/7oZZpR6gFc4zdvizDumE51xReXx+KLNDOIEoo5IUxCsll
 5dgfu7aG8Ebq2IV9KVrAA0OKsTLeQLT1LjtR0n2MlV4i6eIphb94KTiFCRoCvRi9Z53C
 /VUPsqbZNgUb3P35AkO0typHWQmb3q04zSlasZXHSPj1BhdjZtZXq6uMRuvDyC/Nw6Ma
 SU+Q==
X-Gm-Message-State: AOJu0YySOhJ9iiz1iGnmyocalyDoQwXQ+aW5qU3RkIIKtMVwhOjqM4WQ
 ik7kMaYOsP9V11kjY9DLTVKLjySw5oUpaBJZdbGrxrYkrZ572Xsv86bnklPX9DH53XyweDAzIJf
 7
X-Google-Smtp-Source: AGHT+IHGVbWUxYYq/VOG0QijueQz8Q7hW3kgfoijxPPeYt6h2INV1RB6X5flXN8wDmYQKPSlvMD/MA==
X-Received: by 2002:a05:651c:a0b:b0:2ec:3e02:9737 with SMTP id
 38308e7fff4ca-2ee5e3809d7mr73730801fa.2.1719912308381; 
 Tue, 02 Jul 2024 02:25:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a94csm189496255e9.33.2024.07.02.02.25.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:25:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 43/67] hw/sd/sdcard: Add sd_cmd_SEND_IF_COND handler (CMD8)
Date: Tue,  2 Jul 2024 11:20:26 +0200
Message-ID: <20240702092051.45754-44-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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
Message-Id: <20240628070216.92609-50-philmd@linaro.org>
---
 hw/sd/sd.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f83ae4ed18..1bde4c9f7f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -237,7 +237,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
 static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
+                                             [9]    = "SEND_CSD",
         [10]    = "SEND_CID",
         [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
                                             [15]    = "GO_INACTIVE_STATE",
@@ -1295,6 +1295,27 @@ static sd_rsp_type_t sd_cmd_DE_SELECT_CARD(SDState *sd, SDRequest req)
     return sd_invalid_state_for_cmd(sd, req);
 }
 
+/* CMD8 */
+static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
+{
+    if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
+        return sd_cmd_illegal(sd, req);
+    }
+    if (sd->state != sd_idle_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    sd->vhs = 0;
+
+    /* No response if not exactly one VHS bit is set.  */
+    if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
+        return sd_is_spi(sd) ? sd_r7 : sd_r0;
+    }
+
+    /* Accept.  */
+    sd->vhs = req.arg;
+    return sd_r7;
+}
+
 /* CMD19 */
 static sd_rsp_type_t sd_cmd_SEND_TUNING_BLOCK(SDState *sd, SDRequest req)
 {
@@ -1361,24 +1382,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
-    case 8:  /* CMD8:   SEND_IF_COND */
-        if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
-            break;
-        }
-        if (sd->state != sd_idle_state) {
-            break;
-        }
-        sd->vhs = 0;
-
-        /* No response if not exactly one VHS bit is set.  */
-        if (!(req.arg >> 8) || (req.arg >> (ctz32(req.arg & ~0xff) + 1))) {
-            return sd_is_spi(sd) ? sd_r7 : sd_r0;
-        }
-
-        /* Accept.  */
-        sd->vhs = req.arg;
-        return sd_r7;
-
     case 9:  /* CMD9:   SEND_CSD */
         rca = sd_req_get_rca(sd, req);
         switch (sd->state) {
@@ -2280,6 +2283,7 @@ static const SDProto sd_proto_spi = {
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_spi, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
+        [8]  = {0,  sd_spi, "SEND_IF_COND", sd_cmd_SEND_IF_COND},
         [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
         [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
         [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
@@ -2304,6 +2308,7 @@ static const SDProto sd_proto_sd = {
         [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
         [6]  = {10, sd_adtc, "SWITCH_FUNCTION", sd_cmd_SWITCH_FUNCTION},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
+        [8]  = {0,  sd_bcr,  "SEND_IF_COND", sd_cmd_SEND_IF_COND},
         [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
-- 
2.41.0


