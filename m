Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B5BC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbg0t-0008U9-Fi; Wed, 07 Aug 2024 08:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0p-0008M5-AA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0n-0005PH-L2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428fb103724so4959785e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034607; x=1723639407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnPHm5qmilosKgT5p/Ig2S4/TLxu+gWuPX7v2WagT94=;
 b=rrRVLWJ08phpqd9sCmMeUxhyCA0aYwbbbUEY2PYonWDzVgyBzuO+W7ms4KyalBafts
 /FN26EjN+azqT/enTZf9itI1v105bUSaKvPWIVktRD5YP6NSFZ/jc1JerlhN3AxPhcKc
 l/Tgn9JLndr2VliTw1JDL63RFB9rDeBZqKIME1GHTLpYb93sesImLn+JGTJxI4FRmk4j
 YH/ZO+mLbM0kbf4KIkeG8B/fTWUv6Abycbivc3ZWzVnOHmbZtHnEkBrqOyxlyGgg6oVJ
 1/LsRrthAnAOGfS0xzhUPldp08v+yvDqoVUUR31BgfzE15Lu38nMMTePkXvGCZoDSk4T
 T/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034607; x=1723639407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rnPHm5qmilosKgT5p/Ig2S4/TLxu+gWuPX7v2WagT94=;
 b=Dk2+GwTb+Oa+F96k4O5h7AZszFgq+X31jzaol3Q+rm79WPte06K99aFJs8D43gYWvv
 6gWg7UMyY79iQUCcYz0ECMa5so/mE7sziYMq+FS239C2W8Z86z2jfDgb2ZW1GaW1FbBi
 KUkyMoQYh9xiAPWxdXC/mVlUf2NMFyUgyJKsDY95gKDgIKLezBmxDi23SJZUVMD5Xn6i
 3cgsGKqPqBiooCf5h/iat+G1BTEimWSDR6xsCGx6N58AXXimOLb0IzfKWyEdtCZ8TYLH
 1TArI5YrcxPw/s/1q/BKti7ebWqcw5N/jQ5zP1D+yPSos+bkqhKHh5LjZFVMfXr+irTh
 SfXQ==
X-Gm-Message-State: AOJu0Yw/7TusnTSpYGJBz8A08ett5ArO/mDxWFltQBx9G7j5Xaum1ObY
 2T12UDgz6uzqUSf49hrsF2nbu+TJ0gtEnEmEcLolZKy8nQkfM97Np9hMU2eoFE54TrA+jqO3D3b
 Y
X-Google-Smtp-Source: AGHT+IEXPuxpBtD+YwzrJfgE3tp7qPiqSCNmhmOvLrwW/Xa0K3MCDfLRc1ny4HnC1N9Xu4WBZ9VzGw==
X-Received: by 2002:a5d:54d0:0:b0:368:318a:a191 with SMTP id
 ffacd0b85a97d-36bf0dad2d0mr1439151f8f.8.1723034607304; 
 Wed, 07 Aug 2024 05:43:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290598f195sm27847505e9.28.2024.08.07.05.43.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:43:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/5] linux-user: Factor print_buf_len() out
Date: Wed,  7 Aug 2024 14:43:04 +0200
Message-ID: <20240807124306.52903-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807124306.52903-1-philmd@linaro.org>
References: <20240807124306.52903-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


