Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D4AC30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kx-0001yC-49; Fri, 28 Jun 2024 03:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kv-0001vg-8M
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kt-0004qg-Fe
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42561c16ffeso2634965e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558646; x=1720163446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tQQUBf2F5gPlbKVK01VAnUB30JlRnWbK2EOrpmfwvjQ=;
 b=p61dGOnnnzVL+prLyzdv7hPaL7+sumEbP9wERl+KilYBSRd+54EX2cLWg3TPlxlBRK
 uu4e4naZb4JPgEcCyy7fTMVJTuSZL889XM1G/GjaxitYOS+aTTi+X/jAeCWZYLXNGaAV
 xeYfbhX7qpdM1qz+2AKtuIXr2TPa4b+kuoorZruO6wJpZBJH1BqvscSWWSiuLxUBt3+p
 XYaSAT4vNd+F2aJiemZsHA5cG1N3MylWg6kIOD5EIw9wyhpfne/UJW5J498zMsoArXeB
 fqr+B13xgwGETAQM0BMCScE+sUfXyduJjB5ecNIQdHV8UU5tOaZFCbQYToLkayxfMlB8
 2YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558646; x=1720163446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQQUBf2F5gPlbKVK01VAnUB30JlRnWbK2EOrpmfwvjQ=;
 b=BIY8pS2jMLrS/mRnwxfWyBnwBrvkmcM9qiXK+roRad3eHukzO+a+uAUxpUd99V3AfZ
 +ssMh7FTaNuGvjxbHL8VEPiUKLmf7wxofcSeosdgoXv/RaWrf04OMaQWFmAJicd2L2M8
 2nr2eeSyoe6t8Sge069dIhmIOFXcTkb8uvd/lKzqPIV4x0xI2QAL2toqHNrV/LIj4tuI
 xVmLZslYmyFXz86FsVsmyU7ED/Zo0G9CIMcVJBHtxXcDBhr7XO+N5UdvP6nkveJmsTpH
 pBAzXpOBfTgouTHJFKYI1O3ZmN9ZCu5juOovvTaPgbl/6taevh6501z6II4NdUaBXRDC
 NvJQ==
X-Gm-Message-State: AOJu0YxLCq0cZCWnbSVO+7b3XP4HmTWXlUO7QCCzPMsLI18eyeiO9Lcv
 rxoiBB9Q77443lAJGDWYbQFCWBacS+dEY6gCfU70J8rxbuzgZjncFyy7AAby/B8BMaT9zvPbcju
 cSNc=
X-Google-Smtp-Source: AGHT+IGAWotyhJokWRgGpi9FIYu20SX81AXVSZPwHViCXb0tOR/fRbUBcTlLS3pF1mg5vjZ6uBYdLw==
X-Received: by 2002:a05:600c:17d7:b0:424:a49a:ff0a with SMTP id
 5b1f17b1804b1-424a49affc2mr70916865e9.15.1719558645706; 
 Fri, 28 Jun 2024 00:10:45 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a94csm21336575e9.33.2024.06.28.00.10.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 87/98] hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument
 on eMMC (CMD23)
Date: Fri, 28 Jun 2024 09:02:03 +0200
Message-ID: <20240628070216.92609-88-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The number of blocks is defined in the lower bits [15:0].

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2dc0209482..7c6f5ccc72 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -171,12 +171,18 @@ struct SDState {
 static void sd_realize(DeviceState *dev, Error **errp);
 
 static const SDProto sd_proto_spi;
+static const SDProto sd_proto_emmc;
 
 static bool sd_is_spi(SDState *sd)
 {
     return sd->proto == &sd_proto_spi;
 }
 
+static bool sd_is_emmc(SDState *sd)
+{
+    return sd->proto == &sd_proto_emmc;
+}
+
 static const char *sd_version_str(enum SDPhySpecificationVersion version)
 {
     static const char *sdphy_version[] = {
@@ -1479,6 +1485,9 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     }
 
     sd->multi_blk_cnt = req.arg;
+    if (sd_is_emmc(sd)) {
+        sd->multi_blk_cnt &= 0xffff;
+    }
     trace_sdcard_set_block_count(sd->multi_blk_cnt);
 
     return sd_r1;
-- 
2.41.0


