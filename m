Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDBFC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsgg-0004xQ-Ny; Thu, 27 Jun 2024 13:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsgc-0004Op-53
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:13:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsgP-0002OH-4q
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:13:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso13824875e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508394; x=1720113194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhSRW4lnt4/3qEqJkcY7/by3NHero7LaTXmV3ByZHOM=;
 b=pcG+9WWweX3UQzJMQrYeEaRDBjuZvThMS2zoZJEjDhVx4NSYmpza1ii0YnsD7ttks7
 NRBXhA9aacu4rqcwJ63H3n9IFJbzlhv+zUIRr9o546jShiRaHO4q4f9Ac8MAGl57yfRF
 7MkqtdVdbSE3SX681j755eI64f3OLeo1ZbaQt6URyzHIfPMVGBo8WRDzdKDOJlvzX1Un
 nsc/JUr2etSYZkRehC59+OSAh8JeNlrzFO/0EqrkS7HLyu4jerL2k+ZKBeyeJ3oqh2As
 r4bCQ8rVF5zM1Y/Z2bX7z824VNP14BPQNgIdYrULtUiqMvnSoB6o2drWzSXqG3qwdA9g
 rCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508394; x=1720113194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rhSRW4lnt4/3qEqJkcY7/by3NHero7LaTXmV3ByZHOM=;
 b=ET91wTgb+unCGgiCS3Tai7zyUZTaeoYbWDD+oGYvQipeZW6R0cwNXpy2q3YnBDINQ8
 Sj1ITbBkSpCOJitva0e5o3BBBAHcZTtsIChqvEEAoi4liAjdSCv1BAjLjvx+QS1iugBZ
 Q5DITAmhidyXzNSEDH07PZRNnenxOGzUFi9xJFE218dN048FlWM7Phod7E73wOFU8b5Q
 naA2MOz/ewQkFT3D3mtftjMxlhFoOAedZdpgeGwxh7OqfJNak8CzQMe3Gf71vNlOifS/
 K6l2J3q/Id015L3eXGg89YLEYaSH6F4j5AwLgwEcjSWLgiwjbitIi+uFA8K+fPcgttEj
 BPwg==
X-Gm-Message-State: AOJu0Yygg1VB7qvUcUO9+yDIzdoZpfiAU1Eb3Ym0flgx8TrsK3HWXYvJ
 fpbpH9pp9XAhCMv6E3ohwvFb2dM3VYbZcCScj58UAryLIlMC4z18B1+szJ9x4izqWWSXDUK+FxI
 JAUM=
X-Google-Smtp-Source: AGHT+IHNnGTYj4DHTlMlH+cqK16beN85M2TvK18WkFj3LRNaPiDlf5TtuxVqqRfKBybfblekQxlEtQ==
X-Received: by 2002:a05:600c:4f94:b0:424:90fa:6758 with SMTP id
 5b1f17b1804b1-42490fa6992mr98172235e9.5.1719508394091; 
 Thu, 27 Jun 2024 10:13:14 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097c2asm729665e9.38.2024.06.27.10.13.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:13:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 12/19] hw/sd/sdcard: Adapt sd_cmd_ALL_SEND_CID handler for
 eMMC (CMD2)
Date: Thu, 27 Jun 2024 19:10:52 +0200
Message-ID: <20240627171059.84349-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
[PMD: Use aspeed_emmc_kludge]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index dc692fe1fa..f875fcd741 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1218,7 +1218,13 @@ static sd_rsp_type_t emmc_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
 {
     switch (sd->state) {
+    case sd_idle_state:
+        if (!sd->aspeed_emmc_kludge) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+        /* fall-through */
     case sd_ready_state:
+        /* Bus always won */
         sd->state = sd_identification_state;
         return sd_r2_i;
     default:
-- 
2.41.0


