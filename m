Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DE2C38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3z-0005Ui-Ge; Fri, 05 Jul 2024 18:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3y-0005Qe-II
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3w-0007kx-TU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42573d3f7e4so14029075e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217151; x=1720821951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Th3CS4MKIZyT42kt1vOQOIlX1Ja0EBFyU/d3ve8Oa9s=;
 b=Qznj61u35OyR2k/3HZPmCamZQ9pGXNd5lvYBXUqaeVKB8D1AVWOdD1Nfb091diXQnj
 mauVPz/3YZcXxkBGBukFl/vjCHeGSNu6sBCCxKjmcKil8KTiC+YFD3ZQe0CG935UtvoV
 Wh4dxHbYGWQf95vOf0TB2PU718ds9EWaVKr3qoU1blZbuhOHdOzpa9MsGHvQIng35nFT
 YmNWy0ZlL8MPhEWucikwK390t74CmIn+DYQpNwM3sEhmZNWx8Q6qxYT7B/WaUCLeGlGW
 ZTYLPbx4DtJTeDmn+fSavy230trQYsRlKi/qji7cfOPDFTABIpQh0sRV/xiiQavwgeR4
 o66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217151; x=1720821951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Th3CS4MKIZyT42kt1vOQOIlX1Ja0EBFyU/d3ve8Oa9s=;
 b=Cfq9Qyp5cyExb4Iinoi9RAMA5fOoQMe695DOQC6+fAvEK1PghFJpcvXNmyiuMrXAas
 n06S5hznkr4EAq6bZAOfdp0nZ0olwhWuB5TO3H8ZwbRfScaQXvr7uPEO+icEiWQIkLyr
 8ljYqbiSIf5eb5xay/ala4kqRjUMIfxLYg7IYWPrmnLKHtPFyYrvZ+sqYbUwRFoxi7GM
 BvXJ9bKxEkRQ+qYOPQhMRvfy6xZvH9gqQmSJqVkVmF/cRTGRwXw9Ni48XbiMXx8txbp0
 EXM9Z2IFoeH36FLugTYLUn7lKDMvP04EAyuRCmOfHyxMGnO4ypJDNh2IcvQ9mDvVer5q
 LBcg==
X-Gm-Message-State: AOJu0YyTnVoYJgvJ1n6XjBn5NnTzdV9BYOG8BOldSlhQP6Scu5eOf3Hc
 dDcBO8zE+kMBItvmtR2z3emsTxp59te7hrooDUMJMbO+uQXyZq1/PBpFewAiULx24Cxa7sdMBQa
 m
X-Google-Smtp-Source: AGHT+IFcPfYikTA5jO361zuxIl4pJ8eOa1BkCH7Gar61CCTiP5qp1VgaWgd4YBXWRDPzGftGntaGJA==
X-Received: by 2002:a05:600c:28c:b0:425:618b:3a4a with SMTP id
 5b1f17b1804b1-4264a468bdemr44202955e9.25.1720217151203; 
 Fri, 05 Jul 2024 15:05:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678fbe89cdsm8568941f8f.61.2024.07.05.15.05.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 14/16] hw/sd/sdcard: Cover more SDCardStates
Date: Sat,  6 Jul 2024 00:04:32 +0200
Message-ID: <20240705220435.15415-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
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

So far eMMC will only use sd_sleep_state, but
all all states specified for completeness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-81-philmd@linaro.org>
---
 hw/sd/sd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9e6b9c9c63..ecb1b2f405 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -76,7 +76,9 @@ enum SDCardModes {
 };
 
 enum SDCardStates {
+    sd_waitirq_state        = -2, /* emmc */
     sd_inactive_state       = -1,
+
     sd_idle_state           = 0,
     sd_ready_state          = 1,
     sd_identification_state = 2,
@@ -86,6 +88,9 @@ enum SDCardStates {
     sd_receivingdata_state  = 6,
     sd_programming_state    = 7,
     sd_disconnect_state     = 8,
+    sd_bus_test_state       = 9,  /* emmc */
+    sd_sleep_state          = 10, /* emmc */
+    sd_io_state             = 15  /* sd */
 };
 
 #define SDMMC_CMD_MAX 64
@@ -203,13 +208,19 @@ static const char *sd_state_name(enum SDCardStates state)
         [sd_standby_state]          = "standby",
         [sd_transfer_state]         = "transfer",
         [sd_sendingdata_state]      = "sendingdata",
+        [sd_bus_test_state]         = "bus-test",
         [sd_receivingdata_state]    = "receivingdata",
         [sd_programming_state]      = "programming",
         [sd_disconnect_state]       = "disconnect",
+        [sd_sleep_state]            = "sleep",
+        [sd_io_state]               = "i/o"
     };
     if (state == sd_inactive_state) {
         return "inactive";
     }
+    if (state == sd_waitirq_state) {
+        return "wait-irq";
+    }
     assert(state < ARRAY_SIZE(state_name));
     return state_name[state];
 }
-- 
2.41.0


