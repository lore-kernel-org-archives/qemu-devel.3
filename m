Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C00EEA3C59
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAp19-0006WV-Fa; Thu, 09 Apr 2026 09:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.roberts@linaro.org>)
 id 1wAnAN-0001uC-WE
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:03:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.roberts@linaro.org>)
 id 1wAnAM-0002XG-E3
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:03:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso8493955e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775732596; x=1776337396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l1xmRNO4MPFO4sE6cHQgCqUs4K6g7ptewn3o/ZQpDqU=;
 b=jO69rCjZprtAjlj9SU0WF7pn4nt06G0RsuG3gya0QluwXaVAR6Cp3/AIDr4olbMduQ
 dREPse32+7CdFz8bDMfa/6CuDVcJVXzlAi6QqNRD8AYtfAK3kC7AmeMRn2ku7ZlP1UoU
 eOpu/KUP8XqCEz3ILGTAgIaXenqESgj7+h6E4qHBWEThSDHa4m46ULy5ThifZvcclp7d
 pCe/e0ph5r8nt9q5BY4MdpRcBM36C3wJpDecxCl+AVVHTjEMkDl+qiEi7u08RWg4WKHJ
 U1cMjtXgoR2bMo/SlbX4laDR5EXbwNsTiy/HTn6yet/PyCDTEdjgJwEc1avbS1qoEmDn
 HEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775732596; x=1776337396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1xmRNO4MPFO4sE6cHQgCqUs4K6g7ptewn3o/ZQpDqU=;
 b=O9fVYmjvkLAUPelcWReu/Q82O3ncYHvk2N+NhY0CmSpcI3UrLzWVqB/eTpdWPLL4UX
 oTLdewTDE8FHbQBL8e8mC89PvwB4MN0Kmdrw4tjNY+xnx1EB/CODVBXWJewg1kWqzeT7
 Ew6gMYE7xtdea7wpvdbJo++G5P4f0IzMmIVdd34swnMRBu2NCqZot7bWCvpdECuy2nh6
 0BlYWDd8QvFSIZ7Huu8ufvxzyy6MkuhpgI3pkrh02x3ILILaY/0dk9U0dTLaOpgND8Ze
 Zp1/bGNe2WpnPhpQjqGerATvRZOc4hzHjI/X5TwrFfDLmY1pSko7UKKZDq19uG3gDolI
 TBhQ==
X-Gm-Message-State: AOJu0YyT5HBZL2yzaEHdU06hzPnIyIXOds91ECntUZuukaMHanIb1IA5
 dhN5EAaDO9SCyfRNFdxCuWzhhLBanoa1nXM1BnexlsM3OhhhzmBUpnTOp+Z4hqAju9Gpdqn3Tes
 XYthnwF4=
X-Gm-Gg: AeBDiev5Qn3RfBWbmbi9dBgulr/G+S8USqd0BIvlcaUOks+uGkbb/ytHtXTlL5l8j2l
 Mj+WmD2AquaKLrNjqdhbXE/7szW3jamW01suGuiD6/aSV8NEgtyOwGByNHMZVnWppIDMKhefFME
 mzT4Go+NWc++2jgFJ9Ez1Eo3Sg7sNsBmGcRVDHrj8yginZRIEdGi8a8oMOiENX1roZ/5RiKIGeS
 IcH96pV18+USddGg62qVFLEmGGpKzQ0rQp4awSMPFoc0FstLK/Fo1+bshwEJ0uZ5s18aInDRrdB
 QW4tOfvKx6Whv/t9L4d6r5ElRnOfcp/Fd4By/SrgjGAO8VovViZfA8qQy/s75KXEddwz72Fj1ex
 hGb0m1RsF/2pXANO+ZMIWYcWl1EHqeg4fgyPr4EZp2rHhRrFtBgh256gXrYoxUrgtYLN1gp5RWr
 mU7lcLP8rENsdTf0hR0wc4txELVNjzwv6rWwkPxg==
X-Received: by 2002:a05:600c:444c:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-488a9770d4amr247443975e9.16.1775732595537; 
 Thu, 09 Apr 2026 04:03:15 -0700 (PDT)
Received: from ANTHONY-T14S ([2a02:6da0:45:960:f48b:8163:76f0:5ff6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd1879b2sm33446475e9.8.2026.04.09.04.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 04:03:14 -0700 (PDT)
From: Anthony Roberts <anthony.roberts@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Anthony Roberts <anthony.roberts@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/sdl2: Fix assumption of EGL presence at runtime
Date: Thu,  9 Apr 2026 12:02:55 +0100
Message-ID: <20260409110256.684-1-anthony.roberts@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=anthony.roberts@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 09:01:31 -0400
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

The original commit had a section of code which worked on the assumption
that if OpenGL was enabled at build, it was present on the end user machine,
and calls could be made to it. This is not always the case (such as Windows
on Arm devices).

This line should have also included a runtime check.

This commit moves the relevant line to inside a runtime check for OpenGL.

Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3347
Signed-off-by: Anthony Roberts <anthony.roberts@linaro.org>
---
 ui/sdl2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index aaaede56e0..987ad334bb 100644
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
2.53.0


