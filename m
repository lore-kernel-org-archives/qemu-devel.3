Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A44C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguoa-0002Zc-JO; Tue, 29 Jul 2025 20:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMW-0006o6-Mj
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:04 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMU-00057k-Os
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:04 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so4497614a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753834081; x=1754438881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9DoPP6e2vc+dYpUccWoXLOyyZ909534j7zoyV1tXOsc=;
 b=rW2izyJeHv2NVsTN1MmI2YE2DYytOL20NZvwcW53SBOdb2Xuna4c6iSRgSf7bgXh2x
 u40eDgzNsJmN1fg4r5MlT9C+TSnutyUQsWuIxO9Q+yF8iAB9GxZgZe7aM4SnPI3pPZEm
 u8tly3ZK76vDJMYsfhEIjzsAhDcjFz8gNjU/397FOqFPvYXS6a7HQxXDvFNoN/yoIgve
 6ZVe5cpVQtuTK7JkQbDR+0MskN0KXPaixG1tR3Vsj3hgbJhimnKepM1aO/gG0AM2h5v6
 HRG5bxP2bvaaqGEKbSjht/IGB7ZgNgms267Y9IxQyLx5Lgl4xJEVS0Avv7DwKUranE8c
 9Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753834081; x=1754438881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9DoPP6e2vc+dYpUccWoXLOyyZ909534j7zoyV1tXOsc=;
 b=sfAcuE3fsY3VHa+xyzgCdfPWoXiiABES4r/W0q0I5UCTazT7HbKd2VfB/tmYfb+MX5
 nLqoc3g73BIiMF9gMevgJynFAF8X6404MT9Z/GhNlQWTSm59AiTWYRT2t7RoDu+dwePV
 N/kbAONFVs0WrP8LQhclAvfuxaTvLB4edMPHhO5mHXI3C7p9ICP2HlkxVB5WlppRz0xL
 iD/oWTpk0LLtjE5A5OwXcFuYnriTQKhBE8tWEmLyqR8co52ZbMaYpZI+IyDnFQP6T/05
 vp0Mve8aeSag1gkyJ1TMxBNHkBYncrKVx7nNqvjsyj3e85Vk1CfYe9tdIHvj5hSGNFDd
 Xpvw==
X-Gm-Message-State: AOJu0YxY3BXKNxe0w4wyLDhmElUp3fuYznH7sTkfMSdi1L5HfNtexHnf
 wv4DkwU0MABHWCSz2mTZ4afBKCEGG9v1YxOaN//J45A7K+u0XL6UWVb/duNSZxp0pLCMymDtl0d
 teIDY
X-Gm-Gg: ASbGnct7fpcD5HP0ZOWm+kRq2WMIdmySe4NCK+U/LJcA7/0W7V1fG4pQHzzerj40/xx
 kDucSYbpHPOGgIsQBu3ucsexQVwVzZoTQ4F8HOjWxwzSJZgCo3jFlLp3cnL4DwzoA84tsJifzCM
 0xMW4lVyaM/gc35tP+h0Ag44TzjCVM6GTZoD6pF8t8DXNLWYlDWj/q4aLj9KHqBp5a7p5FpG++x
 fXtjH1kJkIDrOhFSbygQWwzVRgThTouVcXTzIRIawiy9JVSofm/Z4KAAQem2A3V03ml/X0w/sL/
 yqlucNWMC5F/stqM2umuJAo/HvRYPZc4RYKKm/AvCbtcLl/6k2O0Qu6pzIL6xG5WxHeLvVET57A
 yfn+zzdz5D+HSeKEWznlyO322/zzuupIxkOJZCm81n4/T9H/PMvVYCdu1tR0Pf4km16jZXJLdQo
 VD3NUOqL5ESg==
X-Google-Smtp-Source: AGHT+IFopPYYUMXWSK7uvtj8ns87b6zbkamHYFMQc/7tNw+EYsBXQMeNOyLLjJyTEt2eWEAP1mGucg==
X-Received: by 2002:a17:90b:3d4d:b0:31f:2558:46cb with SMTP id
 98e67ed59e1d1-31f5de32904mr1820314a91.16.1753834080548; 
 Tue, 29 Jul 2025 17:08:00 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ddfb2asm281868a91.22.2025.07.29.17.07.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:08:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 81/89] linux-user: Remove ELIBBAD from elfload.c
Date: Tue, 29 Jul 2025 13:59:54 -1000
Message-ID: <20250730000003.599084-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

The last use of this fallback was removed in 8e62a71738bc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5185c84e58..6eb4e31bdb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -110,11 +110,6 @@ int info_is_fdpic(struct image_info *info)
 #define MAP_DENYWRITE 0
 #endif
 
-/* should probably go in elf.h */
-#ifndef ELIBBAD
-#define ELIBBAD 80
-#endif
-
 #if TARGET_BIG_ENDIAN
 #define ELF_DATA        ELFDATA2MSB
 #else
-- 
2.43.0


