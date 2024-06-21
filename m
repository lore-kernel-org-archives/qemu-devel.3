Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DDDC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZHv-00059p-3L; Fri, 21 Jun 2024 04:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHr-00057W-TH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHq-0008GQ-7r
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42249a4f9e4so12843885e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957180; x=1719561980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbChd25f9YN3YwZXuq6CJAvDiqEwoBqyQKCDjART3V0=;
 b=AbaGj36m5az4uu41ve9BC/Tim5s49yR3lsoIRdJYgwN5imTmxraE8cf5X6yM3xZay6
 IZcZmX4zZ+b1QMIcNWrFo4gSYjZ3i8at4buHDdyp779x2z9BWrZX/j+qrBdWrsM+7pgD
 9sCVtmake10yGvBBV/5U5jhTkNhi+C0Jo6b6idrlqgAGcP5gLSOmBGApHx0cZM/K05Qi
 Hr7q9yXQWBcmLPmtHx7RtbukcPzJg/LZ+UMCl4T3OWeAKEnLM9ygn6OFdpG8/GMFM+7R
 dti9eZfyeaJON6V2MBgM1u5pVueI5AuxvBRfdNXQrGqSIthUzqjexmQ3UA5m8Y8/BgZl
 o0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957180; x=1719561980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbChd25f9YN3YwZXuq6CJAvDiqEwoBqyQKCDjART3V0=;
 b=aXUCYf+keP7Ldcaoi9KljzCXQrwq+n9N2M232O8N6Hi8yhnj1I8NjIaL+0ZLLNIz2x
 Qu0y/7jGQV/89Afly76HeEHEoXg4trfbXfoaeLHKMuoS6yTY/TpbPXENPnbL40cv/yX8
 i7IBCccL9kGAWQW8PbvC/4MgsmF72W9LHYYhrZQNykGZPLwGO/4Fg4iNsrEzlpiZKdog
 BuD5mpxi5dIfTSPVpDqYCha3haWDayGW8Ja+8MFaEYy2DMx7Hk7SW26s2rUm5YPzZqs9
 vUw8d0fRoiIYmf02IXjnoLxlMLuC2dpZiAFhRDST9nT7ThHlcX6MxcMJiusZBWjq8PiN
 0POQ==
X-Gm-Message-State: AOJu0Yw4wsR7wvcJIcn5enP7jG+Rzzoqa23360A3xUnMAFW2WpUD220E
 +kbPqhhW1Y5QUeCS0alpLBtjZ5jAqjNtyrzjBmi1Q10GR+Y1Zdes/xuto7qnCJvgzTHnd+82Bgo
 b
X-Google-Smtp-Source: AGHT+IHhhcXzKikBEYhnnB91GXmWdkc2LnzpwmX9DW1wKCZyBJ4p0NyCnqyrNxsQZg5X2a/H5AR4fg==
X-Received: by 2002:a05:600c:1615:b0:420:2cbe:7efd with SMTP id
 5b1f17b1804b1-42475298bd5mr61901915e9.31.1718957180681; 
 Fri, 21 Jun 2024 01:06:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0c5485sm53288665e9.21.2024.06.21.01.06.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH 04/23] hw/sd/sdcard: Use HWBLOCK_SHIFT definition instead of
 magic values
Date: Fri, 21 Jun 2024 10:05:35 +0200
Message-ID: <20240621080554.18986-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 331cef5779..c528c30bcf 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -596,7 +596,7 @@ static void sd_reset(DeviceState *dev)
     } else {
         sect = 0;
     }
-    size = sect << 9;
+    size = sect << HWBLOCK_SHIFT;
 
     sect = sd_addr_to_wpnum(size) + 1;
 
@@ -822,8 +822,8 @@ static void sd_erase(SDState *sd)
 
     if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
         /* High capacity memory card: erase units are 512 byte blocks */
-        erase_start *= 512;
-        erase_end *= 512;
+        erase_start <<= HWBLOCK_SHIFT;
+        erase_end <<= HWBLOCK_SHIFT;
         sdsc = false;
     }
 
-- 
2.41.0


