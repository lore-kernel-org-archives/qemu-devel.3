Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FABC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZiu-0003uI-OW; Tue, 02 Jul 2024 05:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZis-0003kg-Fr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZie-0006Y5-D7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:22:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4256eec963eso27758645e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912154; x=1720516954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMKhvT1FGVOx323MVuTarj+/Z918eObPJs1bE9cIdjE=;
 b=y/ICYbk2DFgRAQ7/GP3L1w7BVKWdD2KDhjCMFJ7YVjKCpTCriBv/iUcnmj9ojfas70
 DcxWDCgierEWzP4+iPrBiK1fIbBz4aIx9EoxjhULvCOkHOg39EI1VwwOr3Pw6An3NRI0
 kycA29KrGjWY86pWlQPsTFg7QIr6WGhHc8jS6/AG5ifCEfN4u+Sz4X966y3a5U8gB03b
 J57nZ2+p/QpT1ohSKTYAxf8lYpOOQeDHrzjRuNgrjJYtajg7zHoWG73eKu0CLkSvsHIQ
 Nww/Lpxd92xtLpzjuAsIB1q7ON0AiMze2HzX+WdKEKmYdKbi/xX+M5WIV4cqxqIDLjEt
 hr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912154; x=1720516954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMKhvT1FGVOx323MVuTarj+/Z918eObPJs1bE9cIdjE=;
 b=O571jRmKdNhcJnuy8PxcSDFK5jHLc4Zgek5lNM1JcLR1hbtS7txEbtRm2dHzQJTVat
 337bn0NXt2cxVqQq/AodJ5tcV1309Y8IR6k1t8uJw71kZYBrHq+WKPDgxPK/VP3P+Sq/
 dFxKd+uNq//SJB17MPD/qR/ll+p8JMaj3UCSgML9wKaLeVqModzCPHK8F7cD+bM4jeaW
 KC9qOJIGPcDF14mCLEc0Z9F5k4s3f2Ap2P14N0/lfRZswU1sIuZh4nXJeGhzHCSEevpk
 3d8Co55QwnXnrTCMVJlZrWVQSj04emaB8MP5x7i67UCY2r7K7A75fpiA+T3pndBYHNGz
 jiig==
X-Gm-Message-State: AOJu0YwrXEGSYkUes69RzZJp5iaskw9QnRnE81XR98sZSNGtIZdKJKNP
 hVLAv7euBLOOCM4VfPneYhgeltHk1iodm5uR7QjgCYa+yr4og9F/HQPzyztSzPjq87xtmV4sN9u
 F
X-Google-Smtp-Source: AGHT+IEy/rWtSgHu0txcdpSeJYKxKSXEjbrUbRQ+9pbbq1RBLLvrY3pbwZl7EdwESn3vcNsAC2zfSw==
X-Received: by 2002:a05:600c:181b:b0:421:7bed:5274 with SMTP id
 5b1f17b1804b1-4257a02f7f0mr58623805e9.10.1719912153756; 
 Tue, 02 Jul 2024 02:22:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257cdf4982sm110284735e9.47.2024.07.02.02.22.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/67] hw/sd/sdcard: Duplicate READ_SINGLE_BLOCK /
 READ_MULTIPLE_BLOCK cases
Date: Tue,  2 Jul 2024 11:20:00 +0200
Message-ID: <20240702092051.45754-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In order to modify the READ_SINGLE_BLOCK case in the
next commit, duplicate it first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-22-philmd@linaro.org>
---
 hw/sd/sd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6b02e0a178..43e0a2d925 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1390,6 +1390,24 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
+        switch (sd->state) {
+        case sd_transfer_state:
+
+            if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
+                return sd_r1;
+            }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
+            return sd_r1;
+
+        default:
+            break;
+        }
+        break;
+
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
-- 
2.41.0


