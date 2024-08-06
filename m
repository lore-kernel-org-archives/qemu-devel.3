Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C5DC49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJiM-0002rV-Tc; Tue, 06 Aug 2024 08:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhu-0001Be-8P
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:31 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhs-0000OS-EL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:29 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a9a7af0d0so56649466b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948866; x=1723553666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTDAhFeBz9GijM5OI6/yGi13UeAA7K13kn7Zuxhnv+U=;
 b=NPNVgoVsqnWR2wGTYEo/+XHOwqUPR3N8M418/RJfFh5xb6Oa+gJa5OQol9pg3IfO+t
 2DSpRtTdGFKTdEJW8lxAb9D74M9RzcSRllFM0SE+Pre68K3nUNhi23N+WQ+CkF/tjIMv
 tUtpkgySAQNa07F8ha9/4bTLSW/vnYPQUvUQZnUIuW1XSfjWyvBdb+Gk8VL0WnUVzcsP
 XbERr7kiJdmQIySGXINcFhFMCv3mI5yfrVkpuUjeytx8IjC9IxbkZvPEUCCIdjl+qAHZ
 Ck7zlrnF/tb5Lv9oR0sQVZZ8vQfH7w31iD1eF8Uy9+BxVMOO7zJ1QG5B8y+qrn14iSp/
 upFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948866; x=1723553666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTDAhFeBz9GijM5OI6/yGi13UeAA7K13kn7Zuxhnv+U=;
 b=Tm5bjljQq/O+hDD0zvyXKBf9Ygr6u8/j23INt+3pCDVCfB25Ft+PcOvjTl6X1xWaur
 RwOOBwuIXw0auVglmo7/nUZ9LNKw7uedXfOv0UxY9cFrBLXVp+SZvPAbjZdKDiGDquAp
 4MuGoQs6jhubYslLoaGAs0/chfrSOy8Fg/y0bSfFjrz1Km5alfsPwRHiZDEOShu0YPyD
 Gamj//18+x5RkEKMpBgS+uZFHuQ4hKcHbPrmPjYvt+peYTs/RYCTOE+78bydAicCdczR
 M4S/VxbPOfXDhCSgKR2KOyVGRCkbz55h8Bp9UgKfN+mQN7haKU+3R8orpcCQWdGYFNo8
 NpZg==
X-Gm-Message-State: AOJu0Yw5u6D7fsnpbFIeo/HMASJNJH1bQjGwTpqFfJOE55Yh8MmnT21d
 Vdeo03krPuRpIcDxbJUqJmGvWZyPR7Stb3tHebmJmMPtYHKEpi3U3hey+QG6Kz+5iMTA6v+Fh7L
 M
X-Google-Smtp-Source: AGHT+IGomE15Wo24DJ7lRF9r2AdwMtkLdlxkaxrrJGCGSbJvrkwY5lYMVoVzNmiweJgvYZedJRXyAg==
X-Received: by 2002:a17:907:7ea4:b0:a7a:a06b:eebf with SMTP id
 a640c23a62f3a-a7dc4e86892mr989659866b.22.1722948866623; 
 Tue, 06 Aug 2024 05:54:26 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7de2d923ccsm423738866b.79.2024.08.06.05.54.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:54:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 24/28] ui/console: Note in '-display help' that some backends
 support suboptions
Date: Tue,  6 Aug 2024 14:51:52 +0200
Message-ID: <20240806125157.91185-25-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently '-display help' only prints the available backends. Some
of those backends support suboptions (e.g. '-display gtk,gl=on').
Mention that in the help output, and point the user to where they
might be able to find more information about the suboptions.
The new output looks like this:

  $ qemu-system-aarch64 -display help
  Available display backend types:
  none
  gtk
  sdl
  egl-headless
  curses
  spice-app
  dbus

  Some display backends support suboptions, which can be set with
     -display backend,option=value,option=value...
  For a short list of the suboptions for each display, see the top-level -help output; more detail is in the documentation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240731154136.3494621-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/console.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index e8f0083af7..105a0e2c70 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1632,4 +1632,9 @@ void qemu_display_help(void)
             printf("%s\n",  DisplayType_str(dpys[idx]->type));
         }
     }
+    printf("\n"
+           "Some display backends support suboptions, which can be set with\n"
+           "   -display backend,option=value,option=value...\n"
+           "For a short list of the suboptions for each display, see the "
+           "top-level -help output; more detail is in the documentation.\n");
 }
-- 
2.45.2


