Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7FAFC0342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvqS-0005VN-TV; Thu, 23 Apr 2026 11:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFvqO-0005UE-1y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:19:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFvqJ-0002DV-Mv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:19:54 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so48811685e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776957589; x=1777562389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlHoHlAON3iyzZqhc0+HDkMSFrxwv7bLaIY/p6YZfQc=;
 b=FivhKUr+ER8qrzK6h1+RYfSCdcKNOAmUwoXkx793KI7fKAA+i/KdwKV67jplbAxs7K
 V2sEWdO482eYLRct9V3Azd3WqfvSxmv69BhlwROFVsMsHPthz3t2sbZfPJ/3F91ge4v4
 zW8C+z/lctqfMABufJ+4SO5ShhpNd0GY8gMVB+sGUHGHmvjTwc+JC370SZc8ce60IYr9
 zGq0upA5FgofmPlHMNmUymxkDZhSnQY2CFgVE3gK+yyap2QXeQqzFRgD6HUEpArT0BYj
 oCWjgKlo83bqjM7BXge5bbytGtQahWt7siR2sIoem7c3AtXDyeJuztG6K9OmdJ/LYQGK
 w/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776957589; x=1777562389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MlHoHlAON3iyzZqhc0+HDkMSFrxwv7bLaIY/p6YZfQc=;
 b=ZFUhTD9dVNNm/GUjq2ElNz38qT677bFicKqovl30CeFerRhNdJSDglr8ObH7pImi4b
 CUpvATsXiSC+krzS71LVnn0m4/1Ea7e8NSV/LmY8FyW3+Opwffu5qNlgJhTH7Lzjl2fq
 S+lpuM2OIBvl2hSAJzH3pxwDRVNsxIrlkVPrAXFehBnDKZFSJiOmNssw8IuvHiV5sdhI
 NCt+02axgTwQZ3Ap3buzUvjTZcbZf50K+l1RQK7bpcYaKXqDy8t409SLPLuH1i+EcbsW
 dsMWBizZubVBseg2W+6DJYIJPOyclqfAJHwgGnE8W/mFQ2IEgOqmSSNIJYOltQgHh937
 oUUQ==
X-Gm-Message-State: AOJu0YywcKSuW2V+jTFNWdb0lbqfATzb89WJe3A86EreiujOXPO5cD8X
 e75gHniktwDDwWMiHBcyTqzBi1VusCM6Y1D0nomV6yyaufcoFHeXLHgZAgULyda3PgU=
X-Gm-Gg: AeBDiesfDgWLGySjne82EsZCBBrhq6Fjp/V9rv6aDd/F8sj3eShH6E5glTyfdP235fC
 oUKhtH7VWQo+jX3am+5nmZP3fnQN39zc9LkhO4I5gU8OJli74SfYQXdgSkU5/iqEyUo9PQmY7OK
 yO8ElDfgBvLqXZOwvmgQ51N/IEpFzbo67Ej06+S205KcYgHnBUA3gR4cbtF79cAfvKyOchlLwf4
 Ab1Xd3juVBYZujsX8n7HO4/B38ubto12ed0aN1F3EtCzE6jwYXkuLtZrD7PhTFPec7kh1Dg/ShR
 H/AShYYNyZAcnd7WoxsXQhOeRMiK5f9TI0RDElxhc5tOzMOHeHQL9wrHAxhpRagdkU3/7/FRlH2
 kFO4CYcMe5MnuZD8dusYkwbn5fTwgnmpPGuXgUv4Cy2aNKDKSBRwCkqWN1xWZSYUIW7yr1vxkW6
 MWOrQTMLe/vePhMoLjuIoblOa0nRDz/jedHQ==
X-Received: by 2002:a05:600c:6206:b0:48a:599a:3716 with SMTP id
 5b1f17b1804b1-48a599a3bfamr117429685e9.23.1776957589237; 
 Thu, 23 Apr 2026 08:19:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a55dc9f58sm458714615e9.6.2026.04.23.08.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:19:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B47615F941;
 Thu, 23 Apr 2026 16:19:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Roberts <anthony.roberts@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 1/2] ui/sdl2: Fix assumption of EGL presence at runtime
Date: Thu, 23 Apr 2026 16:19:45 +0100
Message-ID: <20260423151946.1853943-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423151946.1853943-1-alex.bennee@linaro.org>
References: <20260423151946.1853943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Anthony Roberts <anthony.roberts@linaro.org>

The original commit had a section of code which worked on the assumption
that if OpenGL was enabled at build, it was present on the end user machine,
and calls could be made to it. This is not always the case (such as Windows
on Arm devices).

This line should have also included a runtime check.

This commit moves the relevant line to inside a runtime check for OpenGL.

Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3347
Cc: qemu-stable@nongnu.org
Signed-off-by: Anthony Roberts <anthony.roberts@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260409110256.684-1-anthony.roberts@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/ui/sdl2.c b/ui/sdl2.c
index aaaede56e0e..987ad334bbe 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -120,15 +120,15 @@ void sdl2_window_create(struct sdl2_console *scon)
 
         scon->winctx = SDL_GL_CreateContext(scon->real_window);
         SDL_GL_SetSwapInterval(0);
+
+#ifdef CONFIG_OPENGL
+        qemu_egl_display = eglGetCurrentDisplay();
+#endif
     } else {
         /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
         scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
     }
 
-#ifdef CONFIG_OPENGL
-    qemu_egl_display = eglGetCurrentDisplay();
-#endif
-
     sdl_update_caption(scon);
 }
 
-- 
2.47.3


