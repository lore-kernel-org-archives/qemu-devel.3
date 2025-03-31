Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B07C36013
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL8E-0002CZ-26; Mon, 31 Mar 2025 15:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL86-0002AY-7G
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:06 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL84-0003NH-4k
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:05 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so499764f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450542; x=1744055342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDZSaGy5ysIeynjvE+nHvYblpD0ykj+qs33uCPj2VTM=;
 b=OOf16HQY45sPV/M7vyK8/3mpLCRlIhc3cfLoJY/oyGAGqrGe8kAnR5eHuw4k/R2i6X
 x0BKzNAwswsodyrplC2sDjz8r9SAkfH2JhZkckiztkfOJw27OUHRQpyLBbNwUiVuWh5t
 6SV6923fb838JKOey5b95KnShDW64JpYZmHwn/rIzTLuM0Z7C3Nl811DBzgVUzLfG11Z
 7v/Ok2bFbxeYJTXhj3o/lovOd/WCH04fAa6jBIP/PBJiJ9SFO/ULsyc3gDK/vVCWKFvb
 dYqY6KI4U+PeHNHZbE/zvsm7rIUZq+tCZMXs0hNFU7bzjOTEbQQDK1pTbEACQAOOZ5JC
 y1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450542; x=1744055342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDZSaGy5ysIeynjvE+nHvYblpD0ykj+qs33uCPj2VTM=;
 b=CDQqR/skbYUZCqY65MVmxvXxFU5DokHOIowpKKbixajMMKsiLIEzQIFEZdCwH7T9xg
 UcbuMSb8nph5ZvbaXz6RMrwXCcZGcZEO7SkvIs1wr+iAQVgPxJFym7VGD0fElzK5dm+N
 W3qjAH3JzBbMrFBGSh4ZyEfsJcEjg33lA7Xq5aA8pNBkfdeFTjxXPMciSgbxraeCNsRh
 T0AIhM8+HzBH/NUBrGAJKIHpPHG64p3TAddU5quTCBIxZOKjUTCmwPp/lOFV5xWHoD6R
 HGEtygRvb+eGq8myq7HjewKlZ50JRv/8oRnte5k072fQELipgEZd41y1DYXAmxmbKhUV
 YCUg==
X-Gm-Message-State: AOJu0YwICYqBEO5TQL9Duo8cCgL1XeCCHvNZ8enNhdFsVvdqvpq9tcTy
 mFtVvpo02uc01bVwl+BL0nmVK48OUo+UKDosInIerdpLw6GoAM806yq5ibQRkBrPT6n3vDYBbjk
 C
X-Gm-Gg: ASbGncu8JaJZfYGQo8QlsX8dUzScaB8WmcYVrtqDOIzMggGihiBiw1AJdEhMa7mehgn
 1POop0DBHOL38RoiS0QbUfP7/4z81BsYWFiiNUzZ7eiO26E/3ZPR72Toc3Sd5QsNnOAbZCttXnZ
 LPxirTTp2HLX+NgJaTkIjDBs0eQvjSQOjzWVINkisXilwRkTv68oelvcj19A1Dbemd3YnRQivl9
 5TFjmkD4HEA170BUN3DBol67Pcb4X1iA92dDAwrIf8UZ21cXvZPuKJ70Y2FKB4R0w7vKxy5NwtL
 wuhp0aykBG25BS9UCrthJ4d5CUE3Lcbtg1QupspmRd0A+yvayCUYQyYluL/Ivxpjus6u5+JI92i
 6LYt9A74/WovQd4cYRey4Gu7kftG8Hg==
X-Google-Smtp-Source: AGHT+IEba6tOiAhLnKZ+S+zHnH33RFgzSVAEXFNiMT7lQntj6jfSz5+tFHPo5zxkt6UQwVLZgJBmVQ==
X-Received: by 2002:a05:6000:240a:b0:39c:142c:e889 with SMTP id
 ffacd0b85a97d-39c142ce891mr7426827f8f.27.1743450542117; 
 Mon, 31 Mar 2025 12:49:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658ac5sm11851493f8f.1.2025.03.31.12.49.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 08/23] hw/dma/i82374: Categorize and add description
Date: Mon, 31 Mar 2025 21:48:06 +0200
Message-ID: <20250331194822.77309-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250325224310.8785-5-philmd@linaro.org>
---
 hw/dma/i82374.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 9652d47adcd..0bf69ef399b 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -150,6 +150,8 @@ static void i82374_class_init(ObjectClass *klass, void *data)
     dc->realize = i82374_realize;
     dc->vmsd = &vmstate_i82374;
     device_class_set_props(dc, i82374_properties);
+    dc->desc = "Intel 82374 DMA controller";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static const TypeInfo i82374_info = {
-- 
2.47.1


