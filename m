Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED22D63930
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 11:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDjDV-0000kU-Hr; Wed, 20 Nov 2024 06:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDjDS-0000kD-93
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 06:49:50 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDjDQ-0000cF-OA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 06:49:50 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3824a8a5c56so1858814f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 03:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732103387; x=1732708187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=72IV67nIElwJocj8hgHcGmaLQKH/wnHy5iI6DeP/Lhw=;
 b=QU3c8qhiArW6D3Iu8gAGfoIhjMmaHLwHQRz3LC2Ka8D1EBSgCiy1jE8mAcXWF0Rgrn
 cukHTmkM6c6n3oIPfFoml+dFW71cco2//sIqDnOZQntnvQVSYDRLf19Z8cYJziXMyc0g
 sVNahlz+YOhrm4E33gmigliEnqbSzVn6ezPoZWR9k0plogFSSvza4/T1MgFQcvu7YmRP
 0yfTtJ2pWKqavOhKi40W998woCXyN0YXDzhTUfpWl5KzFbhYdODbeyNuGFHugnujgFO/
 iO8HkXp1EN4kZEqdBI1vUGTZ78ubANn3VHBw851sWLucgqcoJ/mVlFgIvYUaYoUoNIul
 dDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732103387; x=1732708187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=72IV67nIElwJocj8hgHcGmaLQKH/wnHy5iI6DeP/Lhw=;
 b=Tfi8yPfRAoiYW7U7D1qeOB8Fo2d+1/xXEPvOlBMk2NsdBaZ02WHSzelEMCpe4Syz3J
 8/LUlbAQ4twJYDHcBvN/vHpYQujvcmedfDmlTjrpscoShKwrzpgAN/tOvbBx+HapFlXh
 mrKoQKWQxeAtcPV2mULsdbRIvlPkGxF+ThkZoPjojAY3F4czHxoYkzdkrGd06e5xGVRE
 4B85f27cISmUo9b0rDb/7HxPgGwY6/gyEgxVpv1b03e2Dyv5B6SSpo2xFFA/MRKPj49p
 UakFDQAPZjCdh3Fqm9cD9qFe/6/rdmCGvGofjEquOvsM0+SKec3Tej2IfAMRLlc84ei8
 bt4Q==
X-Gm-Message-State: AOJu0Yy8tKDUZAARBD9fipA2Y1nziJp8P+ENbI029UapqtUVvcFFMXfk
 WT5fAnjp0nj7qQW1ciYCMwbUADBmmHIHMvTKQVxBcjSO6HldGXjwVl/KeXILmqxjexycqoFuOt3
 N
X-Google-Smtp-Source: AGHT+IHyyz31yvfG+iwNfPO9F4Pbe+6ZzJFQJvjArltHPBOX7GkjTBPBId2OSgmmiduaEMJKnC3PBQ==
X-Received: by 2002:a05:6000:4012:b0:382:46ea:1125 with SMTP id
 ffacd0b85a97d-38254b041bcmr1658570f8f.33.1732103386667; 
 Wed, 20 Nov 2024 03:49:46 -0800 (PST)
Received: from localhost.localdomain ([176.187.208.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4617563sm16448415e9.25.2024.11.20.03.49.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Nov 2024 03:49:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] meson: Add missing SDL dependency to system/main.c
Date: Wed, 20 Nov 2024 12:49:43 +0100
Message-ID: <20241120114943.85080-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

  ../system/main.c:30:10: fatal error: 'SDL.h' file not found
     30 | #include <SDL.h>
        |          ^~~~~~~
  1 error generated.

Fix by adding the SDL dependency to main.c it's CFLAGS contains
the SDL include directory.

Fixes: 64ed6f92ff ("meson: link emulators without Makefile.target")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Looking at commit 88c39c8693 ("Simplify softmmu/main.c") I wonder
if this header is still required.
---
 meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index e0b880e4e1..846ffa3834 100644
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


