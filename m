Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3F4ECD993
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo384-0004Q8-P8; Thu, 05 Feb 2026 12:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37v-0004NV-96
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:47 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37r-0001NY-0w
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:45 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-409470ad5bbso567092fac.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312401; x=1770917201;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cUUECjbrAz0euz9yRx0bWvXG9kVcrE4vBJkqjCGo36k=;
 b=fuDNmS9ybqJ0B65E7NuQEVFMbk6ajbAW9OlenprHRpDW3tPMHV1cKBG+s6iTThI5W3
 6IhfLXf35KV8dL5w5sxs8WW4b7g7D4akUQo1Jf45Oi6Utdr44RPbDaMo24BlsgbR+5px
 RfqHZ5Y5Mhrru4NEct7L+vlJIzrDZh6bo1sq8+Vh+BF3MZYcY6rSiaBERr9xtgJ2ddKJ
 +AcJ3FHnsnZeDXEAMsqIXrqQluXgFge948WdlOk//VKbBS/PBU4wGkp0/GqnPUymHaUi
 QV9r+V+PReAVSCLfRHMtg9/gljORVWsUFqJj4xixhtiu2uBf/40OM+fjWv/hiU8MJoi7
 3IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312401; x=1770917201;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cUUECjbrAz0euz9yRx0bWvXG9kVcrE4vBJkqjCGo36k=;
 b=LIcvl+rXdTGfjokwc1M0IQ9yebeLaTZ3nrIXzQQhfrcg4MSVOG1sOUYxsZOO24Nz/O
 XTHP4bsySBeeQWVm11XIOhEW8cKWNauehCWwzkQBEBeJrZEhLFAbkDXXVoiY8fvsRxjr
 QfSQzZ3dTYBzi4WKcB2iPaSYG0recz40lnAIGVBkvZiiGTq95I5Jda+CgUiJAM9RQ7MN
 qPaN9ymT7zrbo2f5ZxAsalR4ybrt5U7AZg02cZnvtoYJG9BoHd6oBgl3sF43x0YP0aIH
 wpZOO9N/KjfpdjUbPY+EGyJXNVwa7euWglotr4Zti0i8Cki2cMRLygBCo3kOZ6OJShhM
 xcEg==
X-Gm-Message-State: AOJu0YymfddpaP+xZXuUlZ/j7O4msOyFAstYtK2JYYle7Qyn1rWHtmou
 fiG9MFo6ksmlFqnzHJWAkP56iOCrpkpfZvauGReKjb6kL6r6PfM/HT/mt+ZVupHdnso=
X-Gm-Gg: AZuq6aKYwxRJbBkNZ4yiHHFUtwBJAGvwysiBvnE63nAM656rf5itDN5IfmAXTgQ/w/I
 j1ynJPdCfrKJHfJg8D+FAEB+W9Co7RJTh4UZrgrgK5UFrIHc1FFUVfHs6YTScfbYMLHbA0KphR5
 O5s6dmEGLY+G0+ykR40DXZR1+JkxYkvT4JjS/IQIZ98w31m34BL6qtI06koya/tTTkQno7FEBYQ
 DSsO0YYaaFkExONNw9kE2idKooJtM32GU9bS5sRScKcczPZP9YI1YP2mskgkcDGY107gzJrYw93
 C8O1fToRMgjdz5zdPmYov1RRxjGQflPSl7YLVYqEDKngDsiMKS7wbWXpsCh+wC/kbBPJGwl388A
 u/mFqI0C1bXlv9QuW2OD4mE9jT10UBt4Z+mFEfiRBBJKWvte9vd53082u4BWf9TQSUaiP55otVg
 ==
X-Received: by 2002:a05:6871:7a12:b0:36d:287c:694f with SMTP id
 586e51a60fabf-40a96e86872mr10756fac.30.1770312401052; 
 Thu, 05 Feb 2026 09:26:41 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:40 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:34 -0700
Subject: [PATCH 01/24] bsd-user: super-ugly hack : current doesn't have inotify
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-1-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=JCsyaCvnic8vUQg6OJLOCWEPFQTOztpdyXCd8V4Ires=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLZeVxvv37zhh8C0VgdQQD5sOm1PZGoYKzp2
 bs7Gyaun/OJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2QAKCRBsHNEofbAR
 AEL9D/0ZQ4m16+xIaModR2nJ+O/zv1j2/NzOs0wNQhdvkbSJ4JBFVHzv63V/pHCwnCORsKlH5AJ
 jWc7EE4uzKgvIkmVqS7oN8K2Iry+5tCW8wzev/ppb0/jufyXa+AFn6A6FfJEhUwX7KoM49tAuj/
 N1aCAGp3ChrMqn0WzX+WnHp19uQBoNy2b1hax2chSGYvgqPQ41PpRTtZFufyuTH3/VHOjgulmlb
 W/eab0aOE0H7glIoUoRP2tej4tGVjt0zpP4Fo1VGmqqaZY0VthuFmRGMxtLrs6RIcwXjVRf4Aov
 Q+BUj2smCxN3oYFVd5I2ZQHbyb+nPXxohS/XTxuW0xcFfGDCkYFTSSrM87ybZQ3BFNMonZCR4Hf
 S+hHjXQ1Z1uswXIS+TerFe5EAlExEErRLN8+QvM9qPj6Q0NLd+6+BxBmqEh0yoWdWQCJq5hY871
 gjBqqwP0n8S25yp6ShsyaNLnzGSoFN42Y48kyQsF91NCitjYneHQeEhLlYxGRhaoSuIYicvsK6F
 1onX5105zINtO7n/zPtAzEAnA/rKbdZAAse2yPV0HAnJLPbhILBNo8KzH7fJQQiVipYc13jegnE
 fryTGvfun3G/mPOM+pjue3w1uRHc+Zky06nisj9T2cv2LQcJzS/7wd/nBvljq8fzDIlo6iE2FIu
 fluaxsydNy/xumg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ugly because we need the code I commented out in 14 and maybe 15. Don't
let me upstream this...

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 meson.build | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index cc0dfed066..1e305d22ba 100644
--- a/meson.build
+++ b/meson.build
@@ -2659,16 +2659,16 @@ config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
 have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
 have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
 inotify = not_found
-if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
-  # libinotify-kqueue
-  inotify = cc.find_library('inotify')
-  if have_inotify_init
-    have_inotify_init = inotify.found()
-  endif
-  if have_inotify_init1
-    have_inotify_init1 = inotify.found()
-  endif
-endif
+#if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
+#  # libinotify-kqueue
+#  inotify = cc.find_library('inotify')
+#  if have_inotify_init
+#    have_inotify_init = inotify.found()
+#  endif
+#  if have_inotify_init1
+#    have_inotify_init1 = inotify.found()
+#  endif
+#endif
 config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
 config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
 

-- 
2.52.0


