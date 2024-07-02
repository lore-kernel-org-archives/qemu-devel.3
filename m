Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03678C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZl9-0004kD-GH; Tue, 02 Jul 2024 05:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZks-0004Os-Na
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:25:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkr-0000Cu-0p
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-363826fbcdeso2296550f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912291; x=1720517091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=disMBuk3hJGg0W6cSmQCN+rvZQMEtFoRNmHfDWQp/Yk=;
 b=Um8eBSbTqfhbp1VtkcJ6W2N1BcQH0/YXDeGNEUIPx2vfiy7KrN/UW4hR0GEQuyWx1v
 b4thLZF1aSMUubAVpf8TuHMZhskyxEroQddpyUUF3V/fj5i3XiAOcKgifk4b8I61Ga/1
 SAaLKtlov+tthvw12LApNuR3ozrMTe7FxcpTwmDVwOGSdBmFGDktQ6LJTD/WfWs3QZCk
 MqzjSSTAf4Qlgs4TNrRlwy1bpcdrYjuP73JYamHKj9IpWMHQAO1vmc6s7j2M2Zfgj6qc
 OAX7p39MZELolUaQB8lXnFVr4zr2hWSXpFqrMO7188g/qnbNl7yzUcPaDTppO7+Yclxc
 rMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912291; x=1720517091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=disMBuk3hJGg0W6cSmQCN+rvZQMEtFoRNmHfDWQp/Yk=;
 b=QNhxbjVqChxkALFzy0PcHpFBMM/b3jcyrhNpz1p+qxdvBRKkaKpCCPBVhQgoJJ9GVl
 oolItuKJg2lTdV2SIaM2M3GbIZxEK7VMt4LaFs6HZW8CiWWRE9Q4Hs78/PX/ek7O5mse
 TJXOvG4BLVUfNz1OecbpQj3uI4pwd2cpK4hBAbwvoCLQO8kCHnm9WFl/06T7SX//qQ7I
 hYlD+EV+JCfYSEraZ2DKZUSFDivHZvu0+RdNk2nmktQD9zwq4NA4ICD4G2uehVUF8ypy
 k4NyhVoUnNvogevXp5Es/2nASzSJ+OkgyUaSZbyVD+E2aqnBNFn3d4/QM0e3XIUbr5bz
 sOFg==
X-Gm-Message-State: AOJu0YzLSkwp5D0I+vyAcFSMY1D+37ZRIpAnBvqs11GO2q6ItLcDX4Wy
 dQUnkQ5sUfS/8VDTXRX3i8ZEAUZcXvEVGIb+CBnN6vTDz4Ywpm+QQkXrkVe1hCF5msewtUWpfWy
 +
X-Google-Smtp-Source: AGHT+IEaz4YVrXcJ+xoMewIndu3gKf1NzhIM6+QQ4Pj1o1t3twXDzsysxjpLnJ3nTBIEHIH26Hopww==
X-Received: by 2002:a5d:4982:0:b0:35e:8364:f4d4 with SMTP id
 ffacd0b85a97d-36775728bd6mr4888040f8f.58.1719912290993; 
 Tue, 02 Jul 2024 02:24:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1688sm12672279f8f.60.2024.07.02.02.24.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:24:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 40/67] hw/sd/sdcard: Register Security Extension optional
 handlers
Date: Tue,  2 Jul 2024 11:20:23 +0200
Message-ID: <20240702092051.45754-41-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

See "Advanced Security SD Extension Specification" v2.00.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-47-philmd@linaro.org>
---
 hw/sd/sd.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index e050f3d5ef..54b9ec72e4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -250,14 +250,11 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
         [30]    = "SEND_WRITE_PROT",
         [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
-        [34]    = "SW_FUNC_RSVD",           [35]    = "SW_FUNC_RSVD",
-        [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
         [42]    = "LOCK_UNLOCK",
-        [50]    = "SW_FUNC_RSVD",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
-        [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
+        [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
@@ -2271,8 +2268,14 @@ static const SDProto sd_proto_spi = {
         [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
         [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
+        [34] = {10, sd_spi, "READ_SEC_CMD", sd_cmd_optional},
+        [35] = {10, sd_spi, "WRITE_SEC_CMD", sd_cmd_optional},
+        [36] = {10, sd_spi, "SEND_PSI", sd_cmd_optional},
+        [37] = {10, sd_spi, "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
+        [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
+        [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
     },
     .acmd = {
         [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
@@ -2291,6 +2294,10 @@ static const SDProto sd_proto_sd = {
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [34] = {10, sd_adtc, "READ_SEC_CMD", sd_cmd_optional},
+        [35] = {10, sd_adtc, "WRITE_SEC_CMD", sd_cmd_optional},
+        [36] = {10, sd_adtc, "SEND_PSI", sd_cmd_optional},
+        [37] = {10, sd_ac,   "CONTROL_ASSD_SYSTEM", sd_cmd_optional},
         [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
         [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
         [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
@@ -2298,8 +2305,10 @@ static const SDProto sd_proto_sd = {
         [47] = {1,  sd_adtc, "Q_WR_TASK", sd_cmd_optional},
         [48] = {1,  sd_adtc, "READ_EXTR_SINGLE", sd_cmd_optional},
         [49] = {1,  sd_adtc, "WRITE_EXTR_SINGLE", sd_cmd_optional},
+        [50] = {10, sd_adtc, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
+        [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
-- 
2.41.0


