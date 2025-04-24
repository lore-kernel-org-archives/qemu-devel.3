Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6996CC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kxY-0006VH-SE; Wed, 23 Apr 2025 21:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwi-0004da-QA
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwg-0005Kq-7a
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224171d6826so6272405ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456404; x=1746061204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6H/GoAoFwszVT4TvnJT7Vzq/vNV9Nxqb0K+QM0Htps=;
 b=SryFA+KZ8Bnz2IkFafX1A1SE3EogIQGy0hr5JZ+HIOkk+VPASsffdGNufsiOmgsKH+
 IcB6hproCBABxRzGhomM3rJwhQ7TLH1Re61pnTzBct8W1NghyIRx/Vx53JDEzEYNHfQX
 wuyGcRRE7vPD1WS4xMbXRrXRPHfcj8pRC2aEjD5QdhNUabTvgR9FAcBzdY2Z9UT5DGVU
 fXWBduuQ03af2I3Ws09JwZNxAxdTS+7oFetkFoyYN2+56nPugsuEvvdg1dIM8IPTMNmt
 rCyhiBtJcUDU6suTFtNtCRWL7lDXeMZwZEjd3fJfUoqVETu5xWfxfDKDWRLfTHSJS8yg
 BPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456404; x=1746061204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6H/GoAoFwszVT4TvnJT7Vzq/vNV9Nxqb0K+QM0Htps=;
 b=o6JYzqQgfbg+gGwdnblgWJF7zy1wLoUNsRLGGzhtcv/fNJA3p3J+OgB+paf0xUaZ6l
 Ms7wCbgMSfyX1WpxTnpE/NUQyiJPKciHhshw4xKfu+to7ovWVgc+2RqOUjKGpkM7PLwO
 QIVOfQCjPKh+M790IuZHEboLTBIYWex1UhAVdx4OEhH5N5rDI03On7u4TJrL2OSIxP5/
 b8E/0cmN/uFfkydj2NUXvAgOTIWjWG+EUCS5dqG9J+6QbDUecPw14lNjWB6RZ6xaKQY6
 n40dKWeHAGVNlhuRmOuFqMcC5iDxH5mpiddPVSbmeY49oxHh9DdtIZ6IAo5prWyIqzWN
 YiQg==
X-Gm-Message-State: AOJu0Yy1l23bpju8tIfZXvbQ41s/Kr3NA9cBbv+LSUM8e3fZHlUHCLTg
 6iDyMBow6uhKvUFtMbthq8Y1m9UW0XXJon/08tK/u5q9/tK2bEwhN0liebrM8CFbHEFi/q9I6fz
 6
X-Gm-Gg: ASbGncuNu2pq9KNq7tBABzg4gJq8aMJe2OtypkN1QIO5VhbuUT8LLQqFySgu1ZLIRO+
 wPwiwtLQNQMdwOWbhiKnDyYRsemqP4HTdUmIyUAsZc5hNTnBhFMuGMOniJfwl5zsI/3QraZidnc
 Ec9zA6gdCQLlN5IsMSd81yXVkisWg9Oyy1f53cO3e0sS55PEj9TXggj1BxN5C0Tufgtm3Kwv/2g
 lVOISL1ckQZyb1WyYNyCidvBMSKl1CUUjrS1L76hQRwIB5ZlBRtfyV2iio5DaqugoD810i9sAOB
 I/fg2cSYVlNq/WDDbi7nW5X579ZXhQG2frrIbY/qPZvSf0EP4/t4+w/nPuO642t7vyxX5ev6slo
 =
X-Google-Smtp-Source: AGHT+IECDi52F8uCsyVyTfRHSyJF7HOLJEopd7cm0y85zSfixquBMIA0bWQfGJauVKhz0D3jysnttQ==
X-Received: by 2002:a17:903:3d07:b0:220:e023:8fa6 with SMTP id
 d9443c01a7336-22db3db9284mr7710685ad.50.1745456403682; 
 Wed, 23 Apr 2025 18:00:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 122/148] hw/arm/digic_boards: prepare compilation unit to be
 common
Date: Wed, 23 Apr 2025 17:49:07 -0700
Message-ID: <20250424004934.598783-123-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-27-pierrick.bouvier@linaro.org>
---
 hw/arm/digic_boards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 2492fafeb8..466b8b84c0 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -80,7 +80,7 @@ static void digic4_board_init(MachineState *machine, DigicBoard *board)
 static void digic_load_rom(DigicState *s, hwaddr addr,
                            hwaddr max_size, const char *filename)
 {
-    target_long rom_size;
+    ssize_t rom_size;
 
     if (qtest_enabled()) {
         /* qtest runs no code so don't attempt a ROM load which
-- 
2.43.0


