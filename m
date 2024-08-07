Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4B1C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbg0j-00083w-5R; Wed, 07 Aug 2024 08:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0e-0007zI-B3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:20 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0c-0005OY-7L
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:20 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ef2cce8be8so18578631fa.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034596; x=1723639396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaQO+2U4Q3+FxA+WUglfjEa6HzrZrjuAodkM2Cay3Ww=;
 b=rnHRcneI9cIq9DV4cXcj6D46/dv4vxGRgeaYkWxDCA5khUqiNe50AQsqm+ovR2ZgbR
 IJQxh4W+AVjD233XFWb//LiTFVcaXt6pH3d7Ch4gkkIgOhIOSWfa/O2c/x/NIGEbePMt
 OATdXN5ncWmzjZ3M4zcRAN2QScQyAqtNaZWNW3GgxCnzI948aLz4fsFLFCwj88XHK2Xc
 lkKw9EnGN2q56XktAitJIhFFYCzOXm8IR0SojGb+a3FLnQ4HHexG3csHbxwiQfpDGOvn
 2jsoJR1NJNowYZIUFGk0RDdJ6anBQ4uswa6YW4zvBzSLyHkUPtvwNjpnM5ZPL0du6z4J
 LeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034596; x=1723639396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaQO+2U4Q3+FxA+WUglfjEa6HzrZrjuAodkM2Cay3Ww=;
 b=Txm6Woab/LqFPr6AMO0r4Hb9ws2OEN8IzqsDXMNhJBdq1xwoORkxwrh+iljn1RDnl1
 8vt/xVgcXtZELmR8hPx2CrHJ2AMhZF3X99X7TNyO3RkkvypixVt/l7VU7xHFJ4ZPa3+J
 aIjEBRlyX8+d23VUAqtaK8CRIbHZGJ20uhs2zJpBIAOqLUM7Eejgq6FbUlax6XOmag9h
 fNlSLqJBMbnMZM3Q+08OA+QcBftdOEIh/OlP1Jvjk1+rU5OxEAJV8p2dWMyfFSsWFBII
 pDZpY5UmvWof7rgFnZYvAylHJRA9DFv+lnLHtTbJlfoAHorU9tXLlGFqvifMyF45Cl5n
 HMQg==
X-Gm-Message-State: AOJu0YxmDH2TenTN1dNoX2yg4iT2KyaCNS5ItCHmDomWTkOLojRwEKYx
 d7fzl3fvz+xg0fiZOhu1x/RUSBsHVI10OfI+ccdD5gNGLW3yzwoBeH8GBao0h+PrJlvJ0c4Vf3g
 x
X-Google-Smtp-Source: AGHT+IFdgiA6JncU5pMswQQfZgXEob1ST9AC/LJ6nEukGJ4a18PDqkyaE7z2anTl9YAnMWgYma/6pw==
X-Received: by 2002:a2e:8789:0:b0:2ef:2247:9881 with SMTP id
 38308e7fff4ca-2f15ab0416cmr136361881fa.31.1723034595466; 
 Wed, 07 Aug 2024 05:43:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm15922573f8f.2.2024.08.07.05.43.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:43:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/5] linux-user: Correct print_sockaddr() format
Date: Wed,  7 Aug 2024 14:43:02 +0200
Message-ID: <20240807124306.52903-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807124306.52903-1-philmd@linaro.org>
References: <20240807124306.52903-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

When the %addr argument can not be accessed, a double comma
is logged (the final qemu_log call prepend a comma). Call
print_raw_param with last=1 to avoid the extra comma.
Remove spurious space.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/strace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b4d1098170..73f81e66fc 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -434,9 +434,9 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
         }
         unlock_user(sa, addr, 0);
     } else {
-        print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
+        print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 1);
     }
-    qemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
+    qemu_log(","TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
 
 static void
-- 
2.45.2


