Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A61AC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhScx-0007Zw-86; Tue, 05 Mar 2024 06:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhScv-0007Zk-60
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:29 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhScr-0002kH-3b
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:28 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5645960cd56so638356a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636783; x=1710241583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sv16H9PKGwJGLVBAig4t3MlBJQ0Q5jant0j1NpS60/0=;
 b=K/PSD++dLYSuEFr/KzAucWEs1sSh8Uci0nBn4lnZwUc8Cj5pCbjoTc5XPZYOeXlW83
 PbKalhDt1ySaZvj11BDpeE5eHM5VT3blv57SwJCknNXimRJJH7UXJfbk6NGMAqcbWaox
 XwFRo7hXQ7gGheEF17gWr8VVQCjSPUnEGC+jlRcv7EUN9D22g10Sn+s8DGqRSc/osnLc
 jEO3D2QwsZj/1wDyGLcSf09BpuONL+yegUbZjtFXVvPrktqYA2g4SqKi96e9c/Rjr1ZJ
 Sdv/fGRPbB/4hmZ2mC/YQi5zDKqMxTOMCZinRb2+pwBvHf8Dvz1xJqywmN4ehtr8KQxh
 gDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636783; x=1710241583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sv16H9PKGwJGLVBAig4t3MlBJQ0Q5jant0j1NpS60/0=;
 b=Qzw40Y8qyE4JtEm0veozT83WIwYSqPL8TlNPP5HArI1IPEnopDUZQl7sbi+Nse7zdV
 v9E6F/lc9SOG0GHi5nOAAq+yq04g6DGuJhMTIKzieJcReqm0J7S1MKLNFfF4j+TeqEfZ
 YyMYwq+Jh/n76KLOZicFJYLKLn72QC0seODzLmy1+QVzzznb51vusXA4vFZxNmifLMpN
 e89kAzkvdMqJVsB0WOxG/2T9IVN/AywuymiXHlIjmVxh3392d5nXnqUjckA45NyivXmK
 gI/Ner/YDRCSZCmjzJeQ8ZYp3EWWc3R1qoY1PKZOTVbFtsqnDx+CpBw8WdGLHjnz3WvJ
 o70w==
X-Gm-Message-State: AOJu0YzgSNFF2MzpIuYcwvM10J0KT7wmqByvh1lKuG/YNaukp9XQZyTS
 fcWgaVIn0zN4yeP51ov71SqvhFwGOjLKR/wL91LQJOKRdnb91iLE5DerTdH0YtOzPzqz94nbtID
 o
X-Google-Smtp-Source: AGHT+IE9LGdH6CFIT2ge6C6I9PQrMU2SmVhsoYaJsKoYPDePv6hFGpUQ3Q/okyIIeoiUYXF5OZ8jHg==
X-Received: by 2002:a05:6402:7d7:b0:567:4900:3103 with SMTP id
 u23-20020a05640207d700b0056749003103mr3218708edy.41.1709636782932; 
 Tue, 05 Mar 2024 03:06:22 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 v29-20020a50a45d000000b005649f17558bsm5956254edb.42.2024.03.05.03.06.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:06:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Parsons <dave@daveparsons.net>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 02/12] ui/cocoa: Fix window clipping on macOS 14
Date: Tue,  5 Mar 2024 12:05:57 +0100
Message-ID: <20240305110608.21618-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
References: <20240305110608.21618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Parsons <dave@daveparsons.net>

macOS Sonoma changes the NSView.clipsToBounds to false by default
where it was true in earlier version of macOS. This causes the window
contents to be occluded by the frame at the top of the window. This
fixes the issue by conditionally compiling the clipping on Sonoma to
true. NSView only exposes the clipToBounds in macOS 14 and so has
to be fixed via conditional compilation.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
Signed-off-by: David Parsons <dave@daveparsons.net>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240224140620.39200-1-dave@daveparsons.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index b7ca0ed94b..5618d294c4 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -54,6 +54,10 @@
 #define MAC_OS_X_VERSION_10_13 101300
 #endif
 
+#ifndef MAC_OS_VERSION_14_0
+#define MAC_OS_VERSION_14_0 140000
+#endif
+
 /* 10.14 deprecates NSOnState and NSOffState in favor of
  * NSControlStateValueOn/Off, which were introduced in 10.13.
  * Define for older versions
@@ -366,6 +370,9 @@ - (id)initWithFrame:(NSRect)frameRect
         screen.width = frameRect.size.width;
         screen.height = frameRect.size.height;
         kbd = qkbd_state_init(dcl.con);
+#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
+        [self setClipsToBounds:YES];
+#endif
 
     }
     return self;
-- 
2.41.0


