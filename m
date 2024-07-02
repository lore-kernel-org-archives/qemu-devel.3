Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D85EC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZkp-0004KV-8p; Tue, 02 Jul 2024 05:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZkh-0004Bt-Jh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZke-0000B8-I7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:24:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-36532d177a0so2323182f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912279; x=1720517079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBNEOV+SuPOCA0UAQQw56j+dIx9/wiXRzt0fyiV5P8w=;
 b=o90qysjraVHbOFsngDjlV60Wt/wBfGVLdTAIjXX6k0OwKuif6cyunDkPjmkT/eD9VL
 S92k+2tOE9NRylOrZVg+8lQDSjicAc+Otm5oryBQNBdYUfiXgyDytZ2UIrcUY7BdJePY
 04aIg6KYF0EJZX+7hzJQINWYgzZ/Q3c6l2pWDusEgnzu/esj5Q71+egoUn6ohhK30zkN
 fkSSXOer3aPa4LKUDC7/RmjhOTRJRP7elPanwsJy72nfSM8vKScLH6k8dM89wm1GJ2s+
 m5P1trYMb7ymlNri1c8xcAFNEccEhAWY4vAfTIAu6WloJpoCe+p2cmylqxRwv9P0qjK3
 FIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912279; x=1720517079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBNEOV+SuPOCA0UAQQw56j+dIx9/wiXRzt0fyiV5P8w=;
 b=tgBZzlAadz5u+n5vLSnfzf6SHtbEj4+Nwy94E19lMIlr94ziAK/AsuM0u5+tXi6w7Y
 qP/kOyet0QpW9u+frMThrqMyBCWqDl0KYd5aZmS2AndyjfsayVZNTT/XtvnwX9tK1/x6
 Y346Wf6LIo5fKHdt2Us8N25sADO/Y1RL6tbQxgOSVws5GDh/2QHRz3rF6ni1XU+DMndn
 aCXExAvXL10VgdN6tj7L04zzN21SMj8fR8qJiJ6u7qnYjLkDMLuVAfDM8cClJr4p4gTt
 2p6IugvrZwntQtG7vmwXEMtg0PPT//1kT883IKq7LYdld9iXL158yChiClDGOZvmc7hB
 j1CQ==
X-Gm-Message-State: AOJu0YxezHDkr/L1wzowU2/rBD3JUrwB1MYQGxdgAbwQD/1mknFkKT4P
 sy+bldbIQ+xcH3XJKrywj5Vxb05UXR7+dujZwfePEsaVEXFEiEw4UCY9O7dY6PHKN5cxYUHKDAJ
 a
X-Google-Smtp-Source: AGHT+IFErg7G7wsPLl8W84UCWcRYiV82+zmBASthOJr/PnownlcQwvVaNPBY2S8Qgk/yRf5Nbpoe6w==
X-Received: by 2002:a5d:54c9:0:b0:367:6b05:356a with SMTP id
 ffacd0b85a97d-367756bb441mr4604682f8f.36.1719912278951; 
 Tue, 02 Jul 2024 02:24:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd663sm12752958f8f.3.2024.07.02.02.24.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:24:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 38/67] hw/sd/sdcard: Register optional handlers from spec v6.00
Date: Tue,  2 Jul 2024 11:20:21 +0200
Message-ID: <20240702092051.45754-39-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Message-Id: <20240628070216.92609-45-philmd@linaro.org>
---
 hw/sd/sd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b4fd863189..f8672b6603 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -255,15 +255,11 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
         [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
         [38]    = "ERASE",
         [40]    = "DPS_spec",
-        [42]    = "LOCK_UNLOCK",            [43]    = "Q_MANAGEMENT",
-        [44]    = "Q_TASK_INFO_A",          [45]    = "Q_TASK_INFO_B",
-        [46]    = "Q_RD_TASK",              [47]    = "Q_WR_TASK",
-        [48]    = "READ_EXTR_SINGLE",       [49]    = "WRITE_EXTR_SINGLE",
+        [42]    = "LOCK_UNLOCK",
         [50]    = "SW_FUNC_RSVD",
         [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
         [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
-        [58]    = "READ_EXTR_MULTI",        [59]    = "WRITE_EXTR_MULTI",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
@@ -2293,6 +2289,15 @@ static const SDProto sd_proto_sd = {
         [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
         [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [43] = {1,  sd_ac,   "Q_MANAGEMENT", sd_cmd_optional},
+        [44] = {1,  sd_ac,   "Q_TASK_INFO_A", sd_cmd_optional},
+        [45] = {1,  sd_ac,   "Q_TASK_INFO_B", sd_cmd_optional},
+        [46] = {1,  sd_adtc, "Q_RD_TASK", sd_cmd_optional},
+        [47] = {1,  sd_adtc, "Q_WR_TASK", sd_cmd_optional},
+        [48] = {1,  sd_adtc, "READ_EXTR_SINGLE", sd_cmd_optional},
+        [49] = {1,  sd_adtc, "WRITE_EXTR_SINGLE", sd_cmd_optional},
+        [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
+        [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
     },
 };
 
-- 
2.41.0


