Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD884C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXm-0002Vw-AM; Mon, 24 Jun 2024 09:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXa-0002Li-K0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:28 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXY-0005HY-UK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:26 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52cd628f21cso3302778e87.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234922; x=1719839722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3kIXqxbyj4EO+8ab6+OipvibcTKTQuRzHPmi/RkZhY=;
 b=g1TaVrMvsOlIOrBgoZw4ZNXRvilrw2b9lVbFQFqf4gji8sN/iiOL4oRQyNewKNVUx7
 8RqseZJDqxMcnl8XvBu/cEm3xXXb1PBBSVCvo4lMfYiogPCFt2eJv025cnQPVcwRcyRx
 WZl7Bz0VAoVkKbVVTfr8Q94hAhXLPZlxcFveshFAoCgqod/daqGCkiBUP1LjgaNxZBL0
 G6fvKB7ugBpzjBvSJCAOA4KJGkiAs1bZpytA4UHhR10TkY3AmS2UnwptfN6TZM07BJjt
 kglTYEJCrWsCOMpgV6XqfiGklfuNwWO3usgNp6d+bCJBzQLiyXzBFXGSTrnX0hHRP0W+
 nYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234922; x=1719839722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A3kIXqxbyj4EO+8ab6+OipvibcTKTQuRzHPmi/RkZhY=;
 b=VXMxTKIA2nUMoR4xi/bDkHwZoksoMZm+AIsgAFlfrizxjmqd3caFvPIYkwyNL4t5s1
 mOmVnJDHPZQ3n0VLACpEubIg4Y7fvYpDkEy05DJqkWGP5sKi7awaomLdDgVQ9dmwPr+Z
 alZH27V2enoDlPjaI7fsCFRvtEojtqDcV0+Sb8c6BZjiCnJe5xllxWyl/YDJSCbDb/xb
 xbuvheBoOqVHAvzCat2feonT8kVQVVNx5sF37oWC3mR4SVp3RO2JR3v8aPxSNhJAYIrB
 UTXiimX3gtxn9525mfi7PK7JnnJHg73B60MIWHsDzZLLYGh1Vw4YDQYD+e8QeKhXIwjJ
 3kXQ==
X-Gm-Message-State: AOJu0YzytvjpT/tE3jZnDXA9ErmAPZ3VdxGUCP4upOfe/+BWBlo6vAji
 0rtw2gYemwFx3axttHnHqMXX3FWQO5tZClGm+W+VlKDTdNoVHr8QGUw/r+Q8//IKEyUpQc1RC2I
 X
X-Google-Smtp-Source: AGHT+IEc2PsUM5CjYLN1s5ACKJ1yrZtiZhRYueq+WV//jL7bJXWgZ1GHNeX4BRss9iMnBP/a3vWPVA==
X-Received: by 2002:a19:911e:0:b0:52c:de9e:194 with SMTP id
 2adb3069b0e04-52ce1835b48mr2368094e87.28.1719234922215; 
 Mon, 24 Jun 2024 06:15:22 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366ed18dfeesm4046705f8f.93.2024.06.24.06.15.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/19] hw/sd/sdcard: Use registerfield CSR::CURRENT_STATE
 definition
Date: Mon, 24 Jun 2024 15:14:28 +0200
Message-ID: <20240624131440.81111-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Use registerfield-generated definitions to update card_status.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-6-philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a14c5ff147..64270dec0f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1788,8 +1788,8 @@ int sd_do_command(SDState *sd, SDRequest *req,
          * (Do this now so they appear in r1 responses.)
          */
         sd->current_cmd = req->cmd;
-        sd->card_status &= ~CURRENT_STATE;
-        sd->card_status |= (last_state << 9);
+        sd->card_status = FIELD_DP32(sd->card_status, CSR,
+                                     CURRENT_STATE, last_state);
     }
 
 send_response:
-- 
2.41.0


