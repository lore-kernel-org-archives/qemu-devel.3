Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46010CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmw-0001aq-3i; Sat, 30 Aug 2025 11:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fc-00061E-P0
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fb-0004no-2f
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:34:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-770530175b2so2071525b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506845; x=1757111645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XkK8vg61qwmI34q6ceU14P1e/6apOaEvxBAxU5ibvs=;
 b=OYxj7k5KEXuO6m4UP7YBX65Xs0h6lrWc/X7jiaZYpYVWDz5mZsXXCceqNn0xdzX+qW
 pAxtwO/YqreE1L4cwiIYn7xpY3jNNQWqcOZks51p7THAFo68R89BwrlboioiMAH/eZVB
 XlyZAGKDyc4UZZjf0lQxM/Ur/YGYG6v9ZWQ35hp0/sKRrCPZEtfnyPhINc59qQi1SUYs
 sN9WPnxVZ9eeq/VqXgTECHlsLnEhu1YPq2g7/H9MabcF03gqw21O5F21ioIQMPSXPMOu
 s21cVy/cDPOdd9lVfvytwNLoS3PyyI5avbRz/vqDiBs2JCfaGGnZrtyKruRwSZzw2e4d
 031g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506845; x=1757111645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XkK8vg61qwmI34q6ceU14P1e/6apOaEvxBAxU5ibvs=;
 b=M62uuSG5d9ukvWfCwZboflV4mkfoj2zAy+lYEI97MUSLon3LyQWMwdG5KegxAN7yYk
 Pwf4cHdb1kPyEGyleJCOQk61ZFFRhgcVqxPBQ43TN+lMCtAuDvi5yQJ+AWKH+kjVVBTt
 AFcNzwztNxucwjRjCfLmsDhYG/DS1dbm0eD6P3hU4RI+ltdQ2svI4/22sfsMh1iZIS9Y
 EUr4KY97luifSPferGlSpHzRQ5/t93BOsZSXslCPliXzfGKPaXtvn6cDWMAjIyz/N1JT
 oXp1CEoSc1mUJHLwB8+V6nRQYm6PISo3vMH4TwIL8xSjpUuaSHYOb+9ejDgVkThwGaIE
 +H9A==
X-Gm-Message-State: AOJu0YxTe+x8x5LBDMfUnDObJ6XgcZVtScexiT/shgCv6hxTunuG6yCZ
 md2iBNlIXN+BiXNOqMFH4i9AWpzbrYOxbIJVot/Vhp29t9DD+3YN099aU/Ontyv3zuhV+pUyZT/
 T4+qOwdI=
X-Gm-Gg: ASbGncvSI5yP+nwbqJ3cLwV/h1sIQeg7TkFQIXqet+3vFFjEzU8YRp4vknxP/btf74G
 z58IbLF/dRKUj0NMCwKJ1PWrp1QQ0axJvCwHZ/BQR2r/TIq0f/IgJVy/WuOtxIRJXKjyDU9OhVz
 B+lpDbmaSpeWXIqYy0bjT7rGqrikkRISvpMILaUB7oh63zYGg+RBiOf7Bl9Hr/yvSwN+Jn7/Ek4
 Ym3ngb08nsYAeGC8nCE5z22pR75VANWYlITY/pgrs8TiRhZonhs4aLgFY/slD/6zq0jsm1JQL48
 v4qxG8G9oetN4acjWuwQv5WpleOnW0mj/Ro4+PweSC6CZgcx2ghEBQnVUJ3OYKWUMcbiLPYiyVB
 BAf9Ss5mv5JzKnGSP9oYedkbQwNR3vKdEup9foDXC5MrzFi+LJGrXNFUirVKaOQrBLrSQMU8=
X-Google-Smtp-Source: AGHT+IHVSxQZ5y0gb4g2u7MRwgZGEBGctSR71Gja1kKIxdng7NIKML3muyVD9RGE359hrhcMUJoK9A==
X-Received: by 2002:a05:6a20:3d82:b0:243:6f4e:fba0 with SMTP id
 adf61e73a8af0-243d6ddbde4mr366695637.4.1756506845549; 
 Fri, 29 Aug 2025 15:34:05 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:34:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 87/91] linux-user: Remove MAP_DENYWRITE from elfload.c
Date: Sat, 30 Aug 2025 08:24:23 +1000
Message-ID: <20250829222427.289668-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

The last use of this fallback was removed in bf858897b769.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c0326928d4..8b92fba0f0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -105,11 +105,6 @@ int info_is_fdpic(struct image_info *info)
     return info->personality == PER_LINUX_FDPIC;
 }
 
-/* this flag is uneffective under linux too, should be deleted */
-#ifndef MAP_DENYWRITE
-#define MAP_DENYWRITE 0
-#endif
-
 #if TARGET_BIG_ENDIAN
 #define ELF_DATA        ELFDATA2MSB
 #else
-- 
2.43.0


