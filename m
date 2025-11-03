Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23ECCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsAK-0001cN-UM; Mon, 03 Nov 2025 05:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFsAJ-0001c9-Uk
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:51:59 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFsAG-0002UT-Om
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:51:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so22530765e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762167112; x=1762771912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=II2haOYg1atOCLfo3fYt3IWP+vgoUxdFIw5I6NiNmXw=;
 b=YUUgGmrK44d1F3rs7yPOKF1pX9C8CtjktpWtrrRoyoKc4GB7USqmkTuWm6S9LlIftU
 vv1W6+5itnZlqgyyAVEittUqs65inpLYATdbA7qah+0Ryx7yVRCoNUOdSArpUIe2FN8R
 T55/sgn3NryOIXT5WBqeBQ9S95IJ7bImYy4dSzghYrPmGHLMxsAA+/AVPprF4hUoJX5v
 0QpGaIjt6Nr6Mu9rtMMcU3iEF8hezoXa5dUT4+2xt+bXKff6FP8hpQXaWa5ZklENP4Ae
 pIyyLoXaJTLuspcHNSc4KyeYQERwTvej9JISQBc/x4n3ZDmk1d5sE9gq4J76uK7MqZJn
 XuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762167112; x=1762771912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=II2haOYg1atOCLfo3fYt3IWP+vgoUxdFIw5I6NiNmXw=;
 b=LhsgU1YhTahHKwHggPdTwxr1ivsyiJRBDN5INxoWsXd9sTmqbG+FEmQ9b7dWrfkPh+
 ProfN+WNhmwYfShLZSkszl6zUIw5kgblk6mlGbGQW6zJzhsoL4+JYCmEoTxhEUUV7TGK
 FgBD0jY6J39ollUpLdxQXIXmByxfOvjbrRB++vJ/xoKMbW5YLWAi6SD/HGz/1t3XmhEK
 ouk37/PI5jebNfbLas/4yT+GkS8b6e0waFLWBM+VrraaKpGpXK52t3lgtf1G0qTgIHio
 pd7FzwUF74CYMPS4HfrGWP/+aY2lVAfHjq1TPpWhvlOOmoWHv2u4n8yKSmTA8YSOXHkM
 yqkA==
X-Gm-Message-State: AOJu0YxDS6EBjON03GxF7IzeqxZEstIm/+fwNUUS4byFKRua8rHtfh2w
 EFk2NreMNN5lhPyvIUSprb8bw8hrOIPfSFrdBEt2QPw9OUqNRoBp0yC079qGribi2uolm7xdsXr
 lA7SgpuoyTsau
X-Gm-Gg: ASbGnctisV4V/sDyOd1IBj2kOOQ3AKPNJLP3TgglKBdPoG0i2a50IbFlnqxgvDPmT4c
 UxwKzHnrnK9Q4cLCWJ1zt0gp9l6Obi++R7tfB6yBis7xvkgkB4GagwcdeiI/4hztuf67P7M5/2L
 +sBuZoM4yDVjvwg4tRWePWj88/RvO9RReRDPu8mmRXQZGQ7qZUd0pDN2WHzB6UYFJBjl48sm7w2
 0nEjVnDSLXnOOm096ssrvqmVcxhetr9UewqYrk/ZhiaAa4aavoKunvefe+a5CbOEWgzLYnuB1Mc
 ArmoqmaM+oFnXlr/+WbLJLDExUNejhCgLwr7GEjXf1rxPmCK2ANSl+iHGX+k89W6n9Ww33YjK9k
 2duM08tRtSbPkL7bfT/tfQujAmiihT0jjSaP+FepYwXGmGxs0+jEqMtceMv0grfNi4jP9O6YnMU
 pegSwq6teETgoL4wBEPsOENtZ2Fgjw/2cvbg5MMpMW1GfxnteLvCjC/Eb+0pmjwVKMcBe2tyGTc
 dKRnX/O
X-Google-Smtp-Source: AGHT+IFO11XDnDGiVahrZPjABxj7we8zniVtcN4NnGdcOduRBS6504of7cmolWzjU3SFzczJX4DVMQ==
X-Received: by 2002:a05:600c:4710:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-477308a8972mr102489565e9.40.1762167112113; 
 Mon, 03 Nov 2025 02:51:52 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c10ff20esm19707019f8f.1.2025.11.03.02.51.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:51:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] osdep: Un-inline qemu_real_host_page_size()
Date: Mon,  3 Nov 2025 11:51:09 +0100
Message-ID: <20251103105111.68294-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103105111.68294-1-philmd@linaro.org>
References: <20251103105111.68294-1-philmd@linaro.org>
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
 include/qemu/osdep.h | 6 +-----
 util/osdep.c         | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cf8d7cf7e61..fd714014eaf 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -763,14 +763,10 @@ bool qemu_finish_async_prealloc_mem(Error **errp);
  */
 char *qemu_get_pid_name(pid_t pid);
 
+uintptr_t qemu_real_host_page_size(void);
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
  * when intptr_t is 32-bit and we are aligning a long long.
  */
-static inline uintptr_t qemu_real_host_page_size(void)
-{
-    return getpagesize();
-}
-
 static inline intptr_t qemu_real_host_page_mask(void)
 {
     return -(intptr_t)qemu_real_host_page_size();
diff --git a/util/osdep.c b/util/osdep.c
index 770369831bc..44fad13dcc7 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -613,3 +613,8 @@ int qemu_fdatasync(int fd)
     return fsync(fd);
 #endif
 }
+
+uintptr_t qemu_real_host_page_size(void)
+{
+    return getpagesize();
+}
-- 
2.51.0


