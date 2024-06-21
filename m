Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3951C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZJH-0000r5-Sk; Fri, 21 Jun 2024 04:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJF-0000iH-Ac
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJD-00007E-PP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4218180a122so12903105e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957266; x=1719562066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZVdw7g4FFY2EyPpj/GEhmJmZqJuSFbYAj+AqUiDdB4=;
 b=ThyGybpkX6USi5XO9h/o3RA9MADSAZd2ZkiNEQB3/if2BMuWtkRt/cz6oTf/7GDuvh
 idk2jRYd7J384BNqB6sEXJxdpopYCufPk0C8wLq7EXtDe1GvVXw/3H5jGljCGaGCo96x
 tj9fE2OA9ntLW/oiC2fTL5v5mV7tmoup2EGiCLYu7pVYMrlwo1CwQt45NwAeqT6WpvjT
 Nt7RDvCqm+k+p0L+EBXaNdhWalIq602mGkZ8q37JyfTwF5vbe4UODQHa1LCCXnMq+g2y
 YIQFLJ4Ji4xOa5ikWQSXWTauojChSKiRNNHW3E+DWgc0Zk5riLjoHV87As44ZtawWC+z
 1xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957266; x=1719562066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZVdw7g4FFY2EyPpj/GEhmJmZqJuSFbYAj+AqUiDdB4=;
 b=I0KEEQ5ZGykww3uG6Jze3p4F96toCjs49YTHCgCAI3W6PwwMXzwzocTT7OujYK7CL6
 RjjCpeJH6n4Yd+QuMPd1N6+SrW64nK3oQ6R0TZ11Hap9z5Jg3Rl4QESaDJGjyDtoskFU
 JW9/idgOTkfX+HURlFWGgRuZLb6JLSPZlDApnL74T32isn5nBlkkeLLt77ev0HcLoIed
 UkgvcHgHiKewNXVEoumV5xUdNHyOK87sW9G9IrYJNygi5VAJQGIdGDLwE1H39NW9Y9wl
 YZX+fpqSfFf7sfF5eFbooLgZ/2qx6TAktQoIZANsf5VB/5/g/39HgihrRuuwQ5lc40MZ
 HJGg==
X-Gm-Message-State: AOJu0YzxsqFttmPSGMKbDncuhXSLw2yb4d9boz4LjJD/GFiWmiWLasgP
 GYopGeoNhCK1+mMEvR9H1rpHXxds26TfHG1Cbo0+LlnMvyhRTkEMF2FEhZmAjfqG+ku6an7YOup
 z
X-Google-Smtp-Source: AGHT+IHhVh1/7gwxlIA1WJjOQSjlj/YTHTc0qn/ahDv3YxqFUhtRDOs82oiAy2kjym8Z5BhM3g+MCA==
X-Received: by 2002:adf:f6c5:0:b0:360:93d4:c4e0 with SMTP id
 ffacd0b85a97d-363171e1995mr6478167f8f.5.1718957265914; 
 Fri, 21 Jun 2024 01:07:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9c158sm977420f8f.56.2024.06.21.01.07.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 18/23] hw/sd/sdcard: Add sd_invalid_mode_for_cmd to report
 invalid mode switch
Date: Fri, 21 Jun 2024 10:05:49 +0200
Message-ID: <20240621080554.18986-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Having the mode switch displayed help to track incomplete
command implementations.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 75 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1df16ce6a2..8d63a39a54 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -180,6 +180,17 @@ static const char *sd_version_str(enum SDPhySpecificationVersion version)
     return sdphy_version[version];
 }
 
+static const char *sd_mode_name(enum SDCardModes mode)
+{
+    static const char *mode_name[] = {
+        [sd_inactive]                   = "inactive",
+        [sd_card_identification_mode]   = "identification",
+        [sd_data_transfer_mode]         = "transfer",
+    };
+    assert(mode < ARRAY_SIZE(mode_name));
+    return mode_name[mode];
+}
+
 static const char *sd_state_name(enum SDCardStates state)
 {
     static const char *state_name[] = {
@@ -1015,6 +1026,15 @@ static sd_rsp_type_t sd_invalid_state_for_cmd(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+static sd_rsp_type_t sd_invalid_mode_for_cmd(SDState *sd, SDRequest req)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: CMD%i in a wrong mode: %s (spec %s)\n",
+                  sd_proto(sd)->name, req.cmd, sd_mode_name(sd->mode),
+                  sd_version_str(sd->spec_version));
+
+    return sd_illegal;
+}
+
 static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown CMD%i for spec %s\n",
@@ -1154,18 +1174,14 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 6:  /* CMD6:   SWITCH_FUNCTION */
-        switch (sd->mode) {
-        case sd_data_transfer_mode:
-            sd_function_switch(sd, req.arg);
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
+        if (sd->mode != sd_data_transfer_mode) {
+            return sd_invalid_mode_for_cmd(sd, req);
         }
-        break;
+        sd_function_switch(sd, req.arg);
+        sd->state = sd_sendingdata_state;
+        sd->data_start = 0;
+        sd->data_offset = 0;
+        return sd_r1;
 
     case 7:  /* CMD7:   SELECT/DESELECT_CARD */
         rca = sd_req_get_rca(sd, req);
@@ -1289,33 +1305,24 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     case 13:  /* CMD13:  SEND_STATUS */
         rca = sd_req_get_rca(sd, req);
-        switch (sd->mode) {
-        case sd_data_transfer_mode:
-            if (!sd_is_spi(sd) && sd->rca != rca) {
-                return sd_r0;
-            }
-
-            return sd_r1;
-
-        default:
-            break;
+        if (sd->mode != sd_data_transfer_mode) {
+            return sd_invalid_mode_for_cmd(sd, req);
         }
-        break;
+        if (!sd_is_spi(sd) && sd->rca != rca) {
+            return sd_r0;
+        }
+
+        return sd_r1;
 
     case 15:  /* CMD15:  GO_INACTIVE_STATE */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->mode) {
-        case sd_data_transfer_mode:
-            if (sd->rca != rca)
-                return sd_r0;
-
-            sd->state = sd_inactive_state;
-            return sd_r0;
-
-        default:
-            break;
+        if (sd->mode != sd_data_transfer_mode) {
+            return sd_invalid_mode_for_cmd(sd, req);
         }
-        break;
+        rca = sd_req_get_rca(sd, req);
+        if (sd->rca == rca) {
+            sd->state = sd_inactive_state;
+        }
+        return sd_r0;
 
     /* Block read commands (Class 2) */
     case 16:  /* CMD16:  SET_BLOCKLEN */
-- 
2.41.0


