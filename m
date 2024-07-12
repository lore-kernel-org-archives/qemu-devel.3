Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA71C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJ7o-0005Fa-05; Fri, 12 Jul 2024 12:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7g-00055t-JR
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7e-0001zZ-J6
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:52 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52e99060b0dso2395189e87.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720801666; x=1721406466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXx6w/D78X+t+qnSkczpOs9wEizLZ3KClTSUA0/rCmI=;
 b=YprpmLTWiOL6z1AMt0810rSZhXbHHLKx/L1BiqNEWzaq86x/5p52J6L6VSWXd36WlE
 mHpPiUknIDqLdBWlv1KtHAq+lFgVp+R2sYfsTmY06iVa8ZZe/JDr12/Aewz6gAqJRb7C
 HxgIcH5SP4wGdAcl+i/t/XVP35QlUwHC8f8kHxe1mYtbJfKDKbO/zu2dsxW/NPmPgxLu
 MnoviDFY4pMUeNxkoldtL71yfcC+PIUlq0gdxJqNIPcX6emAZ+zny+kXDHJK6RMZNDDH
 GRjj4wqoC/2HBNflpenAY5qASRJdh/5BWsLyl4NsetlIg699S9TgwgiQRM2FhXCAlVrs
 24BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801666; x=1721406466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXx6w/D78X+t+qnSkczpOs9wEizLZ3KClTSUA0/rCmI=;
 b=sdt0YgUvwit+d9jt9K4//BY+2QLmp19Xfwhf83mnIxOPVmGDBItrDKrCaO8IBV5k7h
 9SDysR7WTD2xBeUbnxti4G/XIftVkz2YYjBBvuFG5oRzOfWP8ubRH/ggDC4M0f/ZVt0u
 zA+g9JSKshYhrSdmorPT1DYbW+KYk2N68KGRAiSYaMUEG0KrSEQZzGpMqWuX1rAUPlnu
 YnrQ/0h7LRcfQS6pkbCGDDv29wAJvBsV9F+oroEEVzSxL8lY/TYCoND4oMMokB/D5QjJ
 5Gk7ZwudqEEySJA4PIygLYc+2+6psXFcqo6Xm9I6YZf/Y2WyJkmcQJpB5a+2UpdBZB9W
 UfHg==
X-Gm-Message-State: AOJu0Yx1t6/ZZBTIe6fhgScyXzVpPxF0Tui4F7cAMkriUtpFps6l4NJi
 sty45xYAyLftvivEQo6K15AveUilpqy36d/0QTQBvDVsawkdopYQieMKLNd7qax3XIv3AXNay9+
 n
X-Google-Smtp-Source: AGHT+IHB8BzJJ7JrdE9TzBacSdf29s3rZnMr8keCAGgiUNefphHGliszee6RjwReDwck0eyemnQ4Cg==
X-Received: by 2002:ac2:5b01:0:b0:52c:dc6f:75a3 with SMTP id
 2adb3069b0e04-52eb99a310bmr6993970e87.40.1720801665937; 
 Fri, 12 Jul 2024 09:27:45 -0700 (PDT)
Received: from localhost.localdomain
 (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr. [176.184.54.152])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2679b1sm27598995e9.15.2024.07.12.09.27.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jul 2024 09:27:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v49 04/11] hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR
 handler (CMD3)
Date: Fri, 12 Jul 2024 18:27:12 +0200
Message-ID: <20240712162719.88165-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240712162719.88165-1-philmd@linaro.org>
References: <20240712162719.88165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

From: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8a23e9eb23..ab502d19b8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1280,6 +1280,20 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+static sd_rsp_type_t emmc_cmd_SET_RELATIVE_ADDR(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_identification_state:
+    case sd_standby_state:
+        sd->state = sd_standby_state;
+        sd_set_rca(sd, req.arg >> 16);
+        return sd_r1;
+
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD6 */
 static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
 {
@@ -2445,6 +2459,7 @@ static const SDProto sd_proto_emmc = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
-- 
2.41.0


