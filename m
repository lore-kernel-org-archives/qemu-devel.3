Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720F1C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbfvQ-0003Ei-Be; Wed, 07 Aug 2024 08:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfvM-0003E8-PK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:37:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfvL-0004io-5H
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:37:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42812945633so12825895e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034269; x=1723639069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnPHm5qmilosKgT5p/Ig2S4/TLxu+gWuPX7v2WagT94=;
 b=DU5H6yUbh64Q27BuJS467eFTyzdveZYHJxdTsuFs3Sw2h7BHaqU/I2F1f+zO38T9q6
 mmrmytwVXklWhJnrOQCV12vOUaiWzpdC1Yr7WhON1PXMA0TAHjtcJFGRSzyVr26FVeUo
 xVgo0HXvAzNLc1r9IFQJ0W0UaSSzFRgQeaGNEaNGS7LD7WHWkzUckK/4i+4wk7YrBaVh
 rK4as6h+aF2NawaoQUQhmmuP3BUnGclqR+7brVM1sgDcySJhn9bAZGob17MYzw40xG2T
 bxXT6Q+J5eqaA52xnGG5HebHmsOuLTqWOA0kN4cTl0m+ypMPU6H8KyeiAXONYVUgc3ji
 g2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034269; x=1723639069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnPHm5qmilosKgT5p/Ig2S4/TLxu+gWuPX7v2WagT94=;
 b=kQryK3uSMGs07rfpYc+5jcTZnqZTP5bTDOljFuzgjo9G56LQUYJoHVDAkosQiCnbzb
 gm39R1i/uAPVzHkl4Za1Uoeyci0fO/3wV4HP9zESzREx80ygAQwSft5YyIt612z/ltgp
 de8hTLqMlSFn/SQZ8sMFfA+3ZQtulQYsSxgyhS2QBuPYKtt4Qg1DXSR+sqzXuqsl74IK
 vYyO4+pwIULrV84kJumMbiWxl4IQPo0CwnNf8fKUoYpkRCVxGoltOUZXlG2N/HBYrr3P
 KRe3sgCqI0RpsQlKyx+B74jezUnlfaTb9/bx7HRwOGrRazFZeGHW8M9N2Sr0l8k6jIAK
 ljfg==
X-Gm-Message-State: AOJu0YxhJSS0zS2Yk8+h1jQp420XjQWTQnAI8NhxpVf6G3ay+AYESBTn
 AnfVHyhVGYiZWp6I4rKtJGAou6qKcWBtCI7dVTEi7QjoglvYfXlqJ4i3AIsI5gtKJQfwFyqZVFs
 j
X-Google-Smtp-Source: AGHT+IGPL0xrhYbmEkA7VxG6RR4T9wovYudrUBlEKXROkuTIaODRl3twy95iA1OVxshAEidO2Js0VA==
X-Received: by 2002:a05:6000:1fa2:b0:368:7ee2:b7c8 with SMTP id
 ffacd0b85a97d-36bbc0e6721mr14969362f8f.1.1723034269357; 
 Wed, 07 Aug 2024 05:37:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c314sm15660585f8f.12.2024.08.07.05.37.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:37:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] linux-user: Factor print_buf_len() out
Date: Wed,  7 Aug 2024 14:37:32 +0200
Message-ID: <20240807123734.52501-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807123734.52501-1-philmd@linaro.org>
References: <20240807123734.52501-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
---
 linux-user/strace.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 80f64ff40c..210ff86afc 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1655,6 +1655,13 @@ print_buf(abi_long addr, abi_long len, int last)
     }
 }
 
+static void
+print_buf_len(abi_long addr, abi_long len, int last)
+{
+    print_buf(addr, len, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, len, last);
+}
+
 /*
  * Prints out raw parameter using given format.  Caller needs
  * to do byte swapping if needed.
@@ -2742,8 +2749,7 @@ static void do_print_sendrecv(const char *name, abi_long arg1)
 
     qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
-    print_buf(msg, len, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, len, 0);
+    print_buf_len(msg, len, 0);
     print_flags(msg_flags, flags, 1);
     qemu_log(")");
 }
@@ -2761,8 +2767,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
 
     qemu_log("%s(", name);
     print_sockfd(sockfd, 0);
-    print_buf(msg, len, 0);
-    print_raw_param(TARGET_ABI_FMT_ld, len, 0);
+    print_buf_len(msg, len, 0);
     print_flags(msg_flags, flags, 0);
     print_sockaddr(addr, addrlen, 0);
     qemu_log(")");
-- 
2.45.2


