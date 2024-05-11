Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827ABC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIo-0000HS-Ep; Sat, 11 May 2024 07:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIm-0000Gi-Tp
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIl-0006wu-5q
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34e0d8b737eso2208501f8f.1
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428445; x=1716033245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+j17CWT0LGOl4p0U3kdloXB6QscEHqrtuA6J/qKLXl4=;
 b=vVHqsLXPNxYuVbhbWU93fxnm7NecPSh0RNaNNte4T8kNlCJHXKG59PoQbnhmRqqMri
 PaiNzIh9lqRgv+PNRyvPDywV0Z4OqN+A/YwiQ9/0KaBsoy3ZZt2eFSdSdoukkXDBfsPq
 4pNjPN5G8vz599rNJq7A0ZQiyl1+34c9Tcz/yz7INdcNKO+LhrF6d99YbfPs2UoWZA4y
 Y2vaD4tHv4qNfnLUEBbGwlTs6TncbNGr3T3e0zS/4AOCio5D6slPKzxCoMCAN603308g
 AaRj8yG2NRJjQHgbPYl0OI4fANENHRYyLaDNmsWpObax8NxQ5oiPC7+mW3iggjqrD6pm
 3UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428445; x=1716033245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+j17CWT0LGOl4p0U3kdloXB6QscEHqrtuA6J/qKLXl4=;
 b=bjzbs4OzJR6qa2SQ7ntPqEoAOTQjiK0Us5U24EbvEdP8otANSYakcckyKn9PtXgluv
 o33rmDB3PJjdxVD7kwV2ZQp6flbEixNpBisvuWInEA7Qgv+7VFrKgyAhMaL1620B/gW6
 uVZHoc5sQeitvZTP8ECJ9hd4F8LvfkGBdS/ligj1kIkrJu9RSuNUuObZc80vZ0xvfo5y
 cvCSmwKntQAisnbG4gocqFGxVix/XgxEdCwY3+ti2KKc4kCNPwpW09UEIHJTrQBVBfIT
 GnqAr0Ir+F3gystUIrK9kzHLbMoMYZ3FbBmKCP4i4ydEc47OGU5+oDoqgTxqdzMwGVwE
 06Vg==
X-Gm-Message-State: AOJu0YylhVBomnuiFoIe0jtcdsRPhYRWjBdZ5XU7dR5YUfxpEC88PrD/
 9kTFE44plJOgj4ZrVnivXe2hZCfAEsjKOEHngbxNOCEUu17zoUjcZQxq8Bx6M+NrFP14ipZ1LVc
 J/7E=
X-Google-Smtp-Source: AGHT+IFr4C3gvHo1cHIEG6/1tTC1W/BSVKtAdIY4/Hmw6XA228rk17CpXjeWPfMIEF39Sh9q59eFLg==
X-Received: by 2002:a5d:6952:0:b0:34d:8d11:f8c0 with SMTP id
 ffacd0b85a97d-350498a4abfmr4192581f8f.18.1715428444827; 
 Sat, 11 May 2024 04:54:04 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 02/17] Fix load_image error check for mmap
Date: Sat, 11 May 2024 13:53:45 +0200
Message-Id: <20240511115400.7587-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

mmap does not return null on failure, but MAP_FAILED.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/risu.c b/risu.c
index 36fc82a..6b6295c 100644
--- a/risu.c
+++ b/risu.c
@@ -362,10 +362,9 @@ static void load_image(const char *imgfile)
     /* Map writable because we include the memory area for store
      * testing in the image.
      */
-    addr =
-        mmap(0, len, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, fd,
-             0);
-    if (!addr) {
+    addr = mmap(0, len, PROT_READ | PROT_WRITE | PROT_EXEC,
+                MAP_PRIVATE, fd, 0);
+    if (addr == MAP_FAILED) {
         perror("mmap");
         exit(EXIT_FAILURE);
     }
-- 
2.34.1


