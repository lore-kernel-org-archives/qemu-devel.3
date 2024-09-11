Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2967DEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKh-0007Ol-De; Wed, 11 Sep 2024 08:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKe-0007FA-Ry
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKd-0007xt-28
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso80581155e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057221; x=1726662021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5FvC+/VM5CrNgO4HyY/9BZiUoLX3NqqSLut7K2D/c8=;
 b=O+I5HPTc+ntUDEuSpBIomojFZHMhpYL2u6JkHMfVTpT4pmgEzWCPJMzZdbpp7gZuy/
 NBksv4OVyRrkbQsVd7fNkwp28AHEewObf2wuAPFnXQwlGju+OJHZZ52gdO1CnFj9h+5g
 UlxkkHO1rFTo9X7YNu056fCx9unPQZAGEP0SA8uV/LaIwEdQqmVELaFqXKRjEyvUPMZW
 28V5zOwJHaD5DlkUvm9FJeq4G46cAuU1LpbyhbG0xq24qJoHZ8aNCm2gUTQhHldT9Rj6
 rQBMthL7dDeSG1UZK1uou2BF4QW0eyRlUKV9jWaHxVvLOvirLMEZ2nZtCl4OnIgnRDDP
 SbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057221; x=1726662021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5FvC+/VM5CrNgO4HyY/9BZiUoLX3NqqSLut7K2D/c8=;
 b=KmQ0rWyMVlgWqfNzOshAK5++0kcC+0nLpoBAYQFRHlHWRF3awR46+KmEEfN+W9b/ry
 HcAMhlRKQIjTj2QXUjA0RlflNtt++4bMItSnkslGqXBdL/SRkcM43ZL+xbYRximx3JBx
 WZoB81Ia+pBJTwTmvCIURPBMISuwPFfYkkrDEgQkAXCYnK5VC6qY7bglfeDhi5zPrI3o
 oBp+aQqHSOC0JNGbx+bWpHenLja6UnCvbdAyoEVmwVqs9M2W7EC5+clDEm/f5S3GKAMx
 iESOsAjxecmNRnN4xnB2ZKlrPwBaVFAdgrlsV9c/zJdFzMyQPVAHafisOsPmQLIzpzkF
 TlEw==
X-Gm-Message-State: AOJu0Yw4eA7cwqCMVsN4+TZs0sKP1IQRRJFNyaHzdVsQWUPfX/fIgLv5
 97UPANP/MLDMoUDar0xFLihMQIqiw8rG9HTQ4TL/s2j/PLCLuReB8e1pDPlNqeeRAMOyNUa3zP6
 J
X-Google-Smtp-Source: AGHT+IHlcvyHE6JB6o5XnpqSauKM+GAt+zKnm7kwmNZPGoAzVDjf0AZZJxo7eJBmkPgETPE7JD094A==
X-Received: by 2002:a05:600c:524c:b0:42c:b555:43dd with SMTP id
 5b1f17b1804b1-42cb55545fdmr110635715e9.3.1726057221052; 
 Wed, 11 Sep 2024 05:20:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3941sm11477256f8f.84.2024.09.11.05.20.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:20:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 53/56] ui/sdl2: release all modifiers
Date: Wed, 11 Sep 2024 14:14:18 +0200
Message-ID: <20240911121422.52585-54-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
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

From: Volker Rümelin <vr_qemu@t-online.de>

Each virtual console in the SDL2 frontend has a key state map.
When switching windows with GUI keys we have to release all
pressed modifier keys in the currently active window, because
after the switch the now inactive window no longer receives the
key release events.

To reproduce the issue open a text editor in the SDL UI and then
press Ctrl-Alt-2 to open a Compat Monitor Console. Close the
console with the mouse. Try to enter text in the text editor and
notice that the modifier keys Ctrl and Alt are stuck and need to
be pressed once to be released.

Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20240909061552.6122-2-vr_qemu@t-online.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/ui/sdl2.h | 1 +
 ui/sdl2-input.c   | 5 +++++
 ui/sdl2.c         | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index e3acc7c82a..6907115809 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -60,6 +60,7 @@ void sdl2_poll_events(struct sdl2_console *scon);
 
 void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev);
+void sdl2_release_modifiers(struct sdl2_console *scon);
 
 void sdl2_2d_update(DisplayChangeListener *dcl,
                     int x, int y, int w, int h);
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index b02a89ee7c..2286df4223 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -58,3 +58,8 @@ void sdl2_process_key(struct sdl2_console *scon,
         }
     }
 }
+
+void sdl2_release_modifiers(struct sdl2_console *scon)
+{
+    qkbd_state_lift_all_keys(scon->kbd);
+}
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 98ed974371..bf6868f204 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -418,6 +418,7 @@ static void handle_keydown(SDL_Event *ev)
                         SDL_ShowWindow(sdl2_console[win].real_window);
                     }
                 }
+                sdl2_release_modifiers(scon);
                 gui_keysym = 1;
             }
             break;
-- 
2.45.2


