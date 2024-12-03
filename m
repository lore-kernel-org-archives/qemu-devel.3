Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDEFE64A82
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8e-0000QR-FP; Tue, 03 Dec 2024 06:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8W-0000FU-2O
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8U-0000aC-HD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:11 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a9f2da82so47142295e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225529; x=1733830329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3la+FnavYG5s8brFqSIjvleKq1jzXECMBlEIPY8W0E=;
 b=t3bRfOr9xAEeaBVUNd3THVoVh1bQqEvg05GjKls4FgfbuBiUtqLiaRmYydx10XPGQS
 LcIxC34SMdFiWzJWuPPd4hgM7/ja9LUhHFZL86C9gXgEn0M313HasccGmyjyOBbpLTah
 41UO+VwkAnfy3Phughl6KMDgX1frSCHYh/4vIvgKeSHTwjnxo2I93TRBK7puAWeypgZk
 /Icmm8mZzIfGcaIEXChDR87gQkWZGDW10aqbE7N+Ku9GJswLiGC5gqRrECn3qXlJM2GK
 4cYLOFMNba2Xp2qnd9f8SEV0mQJONhkrAH3kNT9HrVggKmga2iRAUY//CapyG8Y0gsHH
 3r9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225529; x=1733830329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3la+FnavYG5s8brFqSIjvleKq1jzXECMBlEIPY8W0E=;
 b=CrEo/PRVgM+U0hcjvMcgqgv5yZTqTgEzdX8G0vToJBDqtQKnvNgcs3Db4Zsj54UU8k
 ZbqHA/6Y3dUh6IA0rtj5L1neVem4HLzmb1SaxQeYWvG9pYAmj7Yhb5JBt0R/cDdgrjBE
 M0TRkRLy8fjK1YeGZK8w2Gm4jDZ5JcJ08DXDGRPEgJEAB3Lo2LCOXP34/3ntoq6NWjbh
 /J4oQr3y8c4brdJIFgANFdklfgmY0+0OQhtQPR5+r/OKz/thXwGOwDOABYOitkgCU1kA
 TtyZ7YHSprxXu3RkEdr1+q57VAICg+3zgHHkoOsV88Km1ctbasMOgGZG1VBIA8d6srIp
 wzCg==
X-Gm-Message-State: AOJu0YyvJndIP40NBvC30SofDPMKB4QYKUvgpwNOCYBEXC8ur/dd5MDW
 byNvZtufaeW4JBOEqeXY0OluPLcIFGppFytCWo8POPuYoR/1nKNQD4BHF4qz0ycms5W/vEi+YKT
 +H4o=
X-Gm-Gg: ASbGnctcZb3x7WBEEj9m8R3eMQvY56P3+QO1rrzp3n/guM0MbymqKFjzSLrARVOoN0U
 4j5HTk8ETbYA53D9bDfaZHzAPoU1ORzzqUv5C/Ae1ZZc6LU0NUMORrAXYjf5FT0NbW+cQ76j5YX
 VWcbOn/Lk1qnl265TRWNGeE3P+QYFuukx/kigE/MxxcHA0QgLtbcRViSBwz0QOHkXuaD8EQnzRd
 b07kfnwYr7gvOAq5To9kXJfmf4dm1mfftIzIWz+e+cOGsHvhx+0L+yE2+I6z/AVxTdZr58B
X-Google-Smtp-Source: AGHT+IG8vWKi/4CYhj9VZQ3l30Y0f9EYuW1U+uHKVCkubwmg2bqB/KwUQlPWxlHttMhCbdoqvHXjRQ==
X-Received: by 2002:a05:600c:3ba5:b0:431:4f29:9542 with SMTP id
 5b1f17b1804b1-434d09b1441mr17712145e9.6.1733225528764; 
 Tue, 03 Dec 2024 03:32:08 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0f32793sm189031305e9.31.2024.12.03.03.32.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 05/13] meson: Add missing SDL dependency to system/main.c
Date: Tue,  3 Dec 2024 12:31:32 +0100
Message-ID: <20241203113140.63513-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

When building QEMU configure with --disable-gtk --disable-cocoa
on macOS we get:

  User interface
    Cocoa support                   : NO
    SDL support                     : YES 2.30.5
    SDL image support               : NO
    GTK support                     : NO
    pixman                          : YES 0.42.2
    VTE support                     : NO
    PNG support                     : YES 1.6.43
    VNC support                     : YES
    VNC SASL support                : YES
    VNC JPEG support                : YES 3.0.3
    spice protocol support          : YES 0.14.4
      spice server support          : NO
    curses support                  : YES
    brlapi support                  : NO

  User defined options
    cocoa                           : disabled
    docs                            : disabled
    gtk                             : disabled

  ../system/main.c:30:10: fatal error: 'SDL.h' file not found
     30 | #include <SDL.h>
        |          ^~~~~~~
  1 error generated.

Fix by adding the SDL dependency to main.c it's CFLAGS contains
the SDL include directory.

Fixes: 64ed6f92ff ("meson: link emulators without Makefile.target")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20241120114943.85080-1-philmd@linaro.org>
---
 meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index a290dbfa331..147097c652e 100644
--- a/meson.build
+++ b/meson.build
@@ -4235,14 +4235,14 @@ foreach target : target_dirs
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
       'sources': files('system/main.c'),
-      'dependencies': []
+      'dependencies': [sdl]
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
         'sources': files('system/main.c'),
-        'dependencies': []
+        'dependencies': [sdl]
       }]
     endif
     if get_option('fuzzing')
-- 
2.45.2


