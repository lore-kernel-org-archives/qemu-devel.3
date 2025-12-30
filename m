Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E061FEE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzt-0005ii-52; Tue, 30 Dec 2025 16:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzr-0005Vn-7o
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:15 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzp-0002rN-FQ
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:11:14 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d3ffa5f33so19824435e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129072; x=1767733872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zu2BaYB0moTFOIMF7F4LVDdXIbTCjZNqLUd4CaPJB3A=;
 b=kky9DiBiGSuDezXkofVnWWHtCCcyQm5jyybiPUTRPUHbJ1LcfhVxuyDsaw3iP/ytWW
 8Y7322IyCYb8r3lW4AT9P32zZym16CckLPxWVVGxYSy9gNiYUQtWmS+h0g0f+wczMLY/
 HyRh7VZuuH+jMiVQWwXTxT2/r19J90AA7GNP9OOMrIsvHW9dnQJvvLxGH8BUBnBzmm7F
 0gLAweaJBsh8ZJXh8JLaibTpATgUs1xi+BOfBnElklnwvhinUfuV4+f81Vl+WJLK++Yn
 xnfJEX3BadlkC3qamMwm2dBz4cxJ7eVdCoFclC4vgpoMSmaFJlmedDvkJEDGkrtsDMW2
 Umgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129072; x=1767733872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zu2BaYB0moTFOIMF7F4LVDdXIbTCjZNqLUd4CaPJB3A=;
 b=Si1Jfd8g8qPqrd84M05XukIO5R0qLTnXL+UpRDCw7VtznqwfQoifx0zsWxGbS1QexH
 67JUikQHpOm3Z6AmWdf5Zu/038A6p9qEJ9Gi6ndGEJWTxAIMgk6iA2TUV+KSkXxRSG8W
 Z58J5+vTI+X8W1V64dWtZwspo9qqQWi5oMjL5euISP5McPW6gVJGfTVE/YYEvla3xlpV
 b2gjIum6JjMN5ILJ469QjeyMgMpEo+phriRWYrSFwTkEYq/XIEbOQpyGUvr9LcNu8DB7
 xND3/QuV4LKOY+FNeuIIKVGefoEo8Er+ejjrhKIVduHxUU58ZJlnNSJ4YJ7ZIZyGqOlG
 P7xg==
X-Gm-Message-State: AOJu0YzT9jULj24dlPmCJ5zv7hVyC1muBLJxRYhd+TIAqK9Gy7pGYKTZ
 5WVYNw/otV+9bg6s20VjVorzFZ2eMeZhddY8Ka0ns9yyxRJBHou45gJIOR9hP3A5anNUsJIrR+7
 XZDSbBGI=
X-Gm-Gg: AY/fxX56UH8sOYDBKOZ4kGNc5QJpzE3wYXvvPa1TltXJ1447SNFfEq6rYbDqogRk+b8
 KH6xg7cxgcMy1AXJHsffoASRAxx4r9tPqTSXvBbZ+Rfz/kOz7QzmLstib0U/u0i6crqosQfs1/s
 YyuE5GdmlhBIqqrdPz7nSJ5sVJxwZj60hrBYbNMqWu/Jax1g6sSrst1tK9zQ1IhrkA94Dr+Pofl
 QyFA83o/4U8brMh52RXmEJ0eyf8jrSK+tyotd3LjcEkgQUacZ+MNoCONZRfK1x6udjkDqsZG2D7
 niFTVlRgJ/M3JAKCjnyHwdHoH3pz3ghouFGlq7P/D2wvlx+GHjCj2Qh591u8Axm1Pw3cP4cQr8f
 1F496Og8e/FgI9Pala109TaZxqCo/LYHZzZALjn1ZN+xAE9IRcUcNh4egd2D2PJRNZuOrM60KUg
 oB7ixz6vnWh//U8pLxUIBmakbd4A/Xv9Xjp5iz1RShpgewKjVdeUFo+RlEz7RF
X-Google-Smtp-Source: AGHT+IFnLUTeFZ+YjLjJp4l9qNWPh4YMJPcKcVKQF4mU5kqNsWVJkZq0R+IcntLNquLlShqXT9i8tw==
X-Received: by 2002:a05:600c:3508:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-47d19590bbemr412516955e9.30.1767129071619; 
 Tue, 30 Dec 2025 13:11:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346dfcsm739823945e9.1.2025.12.30.13.11.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:11:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/34] qga/vss-win32: Fix ConvertStringToBSTR redefinition with
 newer MinGW
Date: Tue, 30 Dec 2025 22:07:51 +0100
Message-ID: <20251230210757.13803-30-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Newer versions of MinGW-w64 provide ConvertStringToBSTR() in the
_com_util namespace via <comutil.h>. This causes a redefinition
error when building qemu-ga on Windows with these toolchains.

Add a meson check to detect whether ConvertStringToBSTR is already
available, and conditionally compile our fallback implementation
only when the system does not provide one.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Message-ID: <20251218085446.462827-2-phind.uet@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build               | 12 ++++++++++++
 qga/vss-win32/install.cpp |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/meson.build b/meson.build
index 14b1160c15d..8111e62bf12 100644
--- a/meson.build
+++ b/meson.build
@@ -3241,6 +3241,18 @@ endif
 # Detect host pointer size for the target configuration loop.
 host_long_bits = cc.sizeof('void *') * 8
 
+# Detect if ConvertStringToBSTR has been defined in _com_util namespace
+if host_os == 'windows'
+  has_convert_string_to_bstr = cxx.links('''
+    #include <comutil.h>
+    int main() {
+        BSTR b = _com_util::ConvertStringToBSTR("test");
+        return b ? 0 : 1;
+    }
+  ''')
+  config_host_data.set('CONFIG_CONVERT_STRING_TO_BSTR', has_convert_string_to_bstr)
+endif
+
 ########################
 # Target configuration #
 ########################
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 7b25d9098ba..5b7a8e9bc52 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -549,6 +549,7 @@ STDAPI DllUnregisterServer(void)
 
 
 /* Support function to convert ASCII string into BSTR (used in _bstr_t) */
+#ifndef CONFIG_CONVERT_STRING_TO_BSTR
 namespace _com_util
 {
     BSTR WINAPI ConvertStringToBSTR(const char *ascii) {
@@ -566,6 +567,7 @@ namespace _com_util
         return bstr;
     }
 }
+#endif
 
 /* Stop QGA VSS provider service using Winsvc API  */
 STDAPI StopService(void)
-- 
2.52.0


