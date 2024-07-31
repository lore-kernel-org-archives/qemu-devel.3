Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5E1C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBSS-0001vJ-6g; Wed, 31 Jul 2024 11:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBSQ-0001qY-VP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:41:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBSO-000574-6k
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:41:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4281f00e70cso26739415e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722440499; x=1723045299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgQ8hDnd//FyBdrootoUTzW/R8QU7nkSIuMQVQDrypA=;
 b=AVvwR50+/kmhwbEeqMpaKH2pd+PSPF5z/VT9OntQt8GrfH5w5AIaFz125RQJQBpkcQ
 yCaxdwRSvB/UyA81bBElg0vB6UZwIuMVlqoAAWwvjj4UG3TQHfL3J2+u4fUd3WnuEEgT
 LEM9b3dVGG4fJNGOCHmUFGOLl9oN/LXCwIvfcS2rJ8Eys8TT7qQZIcuTy2XyPQBzXJew
 APUu3ur8daXrdfUhF7if55iu7AJNJrouMKecGzYaYaNfwj+/olXpDeTvPO1EYIyyA1q7
 fzRxKmU4UBLlvqNZknFDxasm7J3m5bHe+Z6amgUQjv5XcNArsxfS/Rgf6+m2BOqqw4tl
 gWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722440499; x=1723045299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgQ8hDnd//FyBdrootoUTzW/R8QU7nkSIuMQVQDrypA=;
 b=m8r5/6lXYDEd7Ini8TqKkl0HYfZgB+GmWT0QFt0CE6locclc2NNZEJHavODWXCi+G5
 Vx9RtDqhtwWJHJdIPniBSfxYTgZoW8XitdC6ipRvvepJ5Vqg0zjXxf9JeHDtKYsoM0Sa
 czexkjmvXLJos+y/XdivIihLt2mWvb5uK5sNoWubY91W0kTFGSRdlB3he3QKbg2lYU0i
 D1FlcwexYXr6Vwm+X+y7er92Xl1kcr76BBUTpq0mvX/zHKIIuAe8mzt34nx3IwI8XlkL
 6S4mIl0f8PNKMLcKHiMFtMGbcF5117cwZPOz9fdpwp48xVdElMtZe8zssUPuaJ/iNQZy
 UNJQ==
X-Gm-Message-State: AOJu0YxzO+o5T7sKCdJ3KJ35YSA4Ufrp2bRWFTMnXSGBX/w+P5V084LF
 JOjs2voFxUaUn3iY4knnB4JuM/5gOD+yociTiVtLl7bP4mkdy+xrGIjMMZzvRNdaBEjhQ6jrlO2
 L
X-Google-Smtp-Source: AGHT+IH7dQ9OafYUo2O2yvrE3VcGFSQQ6UhmemrZomlAEWufVXG19XuyPke7fFwSRbc2ZABlWPxGJA==
X-Received: by 2002:a05:600c:1d03:b0:426:5cdf:2674 with SMTP id
 5b1f17b1804b1-42811d735c9mr94933405e9.4.1722440498715; 
 Wed, 31 Jul 2024 08:41:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bba283fsm25201295e9.46.2024.07.31.08.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 08:41:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/3] system/vl.c: Expand OpenGL related errors
Date: Wed, 31 Jul 2024 16:41:35 +0100
Message-Id: <20240731154136.3494621-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731154136.3494621-1-peter.maydell@linaro.org>
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Expand the OpenGL related error messages we produce for various
"OpenGL not present/not supported" cases, to hopefully guide the
user towards how to fix things.

Now if the user tries to enable GL on a backend that doesn't
support it the error message is a bit more precise:

$ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=on
qemu-system-aarch64: OpenGL is not supported by display backend 'curses'

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 9e8f16f1551..213ee6a6a92 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1973,9 +1973,10 @@ static void qemu_create_early_backends(void)
 
     if (dpy.has_gl && dpy.gl != DISPLAYGL_MODE_OFF && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
-        error_report("OpenGL is not supported by the display");
+        error_report("OpenGL is not supported by display backend '%s'",
+                     DisplayType_str(dpy.type));
 #else
-        error_report("OpenGL support is disabled");
+        error_report("OpenGL support was disabled when QEMU was compiled");
 #endif
         exit(1);
     }
-- 
2.34.1


