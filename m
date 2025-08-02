Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B42C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLTV-0004uC-NG; Sat, 02 Aug 2025 19:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSv-0003lb-1t
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:37 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSt-0002du-1g
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:36 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-741b1fe0d4fso49725a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176594; x=1754781394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIYNBYdbbedxMEELb3vRrPziRZG0SvFOYG6yaXQaCQ8=;
 b=bd9FNbDjPEPwkPpKMs0ioxAw4hLkGoAzWgNx02JLFQ3c2OGqh8WEf3IRO1jEyv0Eo5
 Njo7/Pz7EVzpHUv07t50GNP0p5gE5F8zk3kmtUqWyvqFa06NwlStETzryT7xc44t0hv8
 kx4xGZjk/AGBlFNBhH9brVSWSRzwvUCY0YIlGxSYZc72PC03zBWvVd1wSsxWYWlLgt2E
 2/yqnyQcYQlarhSl9lNO/sIzWiMvIw0bxqugG9WiNtr2d+wVl6qZHCA+5T+XN7O4sVqL
 JWZHMDJNUYEIDxp9nE1BhJn6o7a2QZHPdM/YZN47HB1millJSPRbYnYOT830VSFacF+h
 gl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176594; x=1754781394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIYNBYdbbedxMEELb3vRrPziRZG0SvFOYG6yaXQaCQ8=;
 b=c6z10pVGaZc6ckjVN5vZFLKuNa8u1QOzJBpVudkBld5HaDmQzfrSjz4aqzFIWKHT+D
 OHxiadEhUECcSINbKD1xvj+ihKLFUKrV2y3xbokTLjXodvWmLKiCnWtEZrGMyh10wn9S
 fQOXU82S5ndnpEWgt7CALuiVScsctZY+BcMBtwvzBWgsufcvQErXEEx6JiA7nuC6C9SL
 O/6Gg5Q7dRFvIprBzT8GSvatmBr2igPJzbc5MqsDpSadxITE2k5lcvkVHRp/ycvtA7r0
 +g7MBPjJ31sx+Hs3ggz8aJqA1OCvlktjbCORsoJtkSrgrFZeCskCHlX4/c3Hwzzedtp9
 SPgg==
X-Gm-Message-State: AOJu0YzBJWj1U40nxEfJWmDIaM2DTGPt+zXa9sjgogE9m1Fscs3vWO/O
 A/kU3sPphbMBN8fw/IC2CPnKXbIk/dNZ1t4n5QOpKxk5HBtqySvrPydNnhj2guR1LWTwZlzN9J5
 doh4kuPM=
X-Gm-Gg: ASbGncuOJvAEgBhFXZROorG/8DQ4zrKJau7AKLm/6L0YtRKZcJ4gduBbI9SgYt/I0MB
 VNYp1MxU2IwMS8W6Z75BjxKlthPiHTgUm7pGtNCFCDO+P91YezF1Tlfu50Q1KH6nRzpIVki+Vh5
 cQbYcUQCwVWNXb4zDJ9ZDGONYhZWPlheuRuSwgLHtOuMYcVBxXZcY9YxlQdsrmju6NdTj9YTCcQ
 hi43KyGzlVa0wLM/2lDQs0qKouehiox1+X8e+2JNfibntqkIg9oVNK9CPNY+ljJ4z10U1ou8w4o
 Ljtv+PuKmF6OtA5ohUajsnpZIEwclwg3y3shFUTmBONHoF1+0RmEZGAQPjmkntRqlrzNnJqr3rA
 SzCIjl5xiusa7xdHybpTFbncNAaQHRUcqtYvzoRgStIq+jEzQHs+a
X-Google-Smtp-Source: AGHT+IG43/ubnsljGqTdlGNkpg7QQ7bWJJlgWneJXeeE6rBQ1ylauSB/XBZ4yfrUk9bPSSEkhacjpA==
X-Received: by 2002:a05:6830:dc4:b0:741:a36f:7a2f with SMTP id
 46e09a7af769-741a36f7bf4mr1943014a34.5.1754176593915; 
 Sat, 02 Aug 2025 16:16:33 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 88/95] linux-user: Remove MAP_DENYWRITE from elfload.c
Date: Sun,  3 Aug 2025 09:04:52 +1000
Message-ID: <20250802230459.412251-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
index c45724b33e..ade72c7624 100644
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


