Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4245FEE49A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKt-00089Q-Eh; Wed, 11 Sep 2024 08:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKq-0007xV-EH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKo-0007ya-Lu
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso1259085e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057233; x=1726662033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+JN/C2X36G3NaCEpwwdK6lpAZCWVIpHedYNQuIYeRc=;
 b=vH01775qbAoJQyzrg+fm5w0Xq19piPY8XC0DLg/8iav/ewhjs8ypjmQGQSEJTq+Eq8
 /wFr/qp9mkoGz9q+JJ4CUnBBvk+MYecIK7qyqJ9318j2uNPT8zydbr3LTkT3h/ivXT/Z
 Vi15fb6sXyNh7M62M2Yt9d5ElIJCbwi+qhLU2wL0ZYpCFZCg5xe6wLICiAt7T9Vfb2z9
 IKUmK0EzL8Dz8CFbYacK7ntuQbakQDRWRzHz3fRovxWVCQZL1MqrrksiyduEHvU3E/J3
 +dqRmlYB7FLqg1xOZa1i+UT/mMh8so8t4cXmmPhLYxsod3iQRrSlfT5ZTi30FxJe0VDQ
 bVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057233; x=1726662033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+JN/C2X36G3NaCEpwwdK6lpAZCWVIpHedYNQuIYeRc=;
 b=rhBf9Kw7gHi89Wz0UKWEgwanxZ7YSlGmA27RI0Ic9fwlha74xp+0bT+Z3XthfCtn5r
 RpuvMLf2jcib0imRei4BzWJoHxv1mqr287Dn0RIyq2k9vWRAUzkFW6o5N8eL7r6uHNkh
 rB18P8wMS3lyQAHXr3FTmeCqOQRpon3UdJF8WtPJS2kDGsvdArwZZQQPZNQEHmhWSoLU
 yHEogF06YBSeU34LbH/QuO/F+nEj5Z9uiPIVbR/ZFLCa2NAAE+Fsb7hCC198VN71VGoW
 eprTlhLnuwe+Se2JOtyGVGOHbYzPA2/DgF1IFej+eZcg0Hzhd9AhYjQC+eQYxPRPBbtg
 +0Bg==
X-Gm-Message-State: AOJu0Ywt48d8PgO8H+0AzotIlp3hmsOBAEuQoXGWVa60mg3g6ZcIiDGP
 6ku6IrpPjPGMsHf0KSIBBGEin8qboKoVr2LEPfzLkauX5wS2dioy59m3a5BCRWBdnhTDYrXbtQp
 v
X-Google-Smtp-Source: AGHT+IEsHm6k0wHQzFIjrIhS7ROfNn4bzBH2DHWc7ffWYTzroXlzFEoug0UgZvcgC0Cmaaideqo1wA==
X-Received: by 2002:adf:fcca:0:b0:374:c90e:990c with SMTP id
 ffacd0b85a97d-378922b7aefmr11604959f8f.33.1726057232798; 
 Wed, 11 Sep 2024 05:20:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675cb5sm11487134f8f.53.2024.09.11.05.20.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:20:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 55/56] ui/sdl2: set swap interval explicitly when OpenGL is
 enabled
Date: Wed, 11 Sep 2024 14:14:20 +0200
Message-ID: <20240911121422.52585-56-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
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

From: Gert Wollny <gert.wollny@collabora.com>

Before 176e3783f2ab (ui/sdl2: OpenGL window context)
SDL_CreateRenderer was called unconditionally setting
the swap interval to 0. Since SDL_CreateRenderer is now no
longer called when OpenGL is enabled, the swap interval is
no longer set explicitly and vsync handling depends on
the environment settings which may lead to a performance
regression with virgl as reported in
   https://gitlab.com/qemu-project/qemu/-/issues/2565

Restore the old vsync handling by explicitly calling
SDL_GL_SetSwapInterval if OpenGL is enabled.

Fixes: 176e3783f2ab (ui/sdl2: OpenGL window context)
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2565

Signed-off-by: Gert Wollny <gert.wollny@collabora.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <01020191e05ce6df-84da6386-62c2-4ce8-840e-ad216ac253dd-000000@eu-west-1.amazonses.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/sdl2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 574a22306d..51b7aa82ea 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -115,6 +115,7 @@ void sdl2_window_create(struct sdl2_console *scon)
         SDL_SetHint(SDL_HINT_RENDER_BATCHING, "1");
 
         scon->winctx = SDL_GL_CreateContext(scon->real_window);
+        SDL_GL_SetSwapInterval(0);
     } else {
         /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
         scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
-- 
2.45.2


