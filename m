Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC2DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1Cn-0003qQ-O1; Sun, 11 May 2025 03:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1Cj-0003q9-AJ
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:34 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uE1Ch-0003cy-08
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:34:32 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7410c18bb00so3662734b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746948868; x=1747553668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bqAFcM0mocguuOJJgtADKFvDV5IEcmLyJztG0xkJMwo=;
 b=BWagDD6QYLBOzNxchVs+jCztlGb08gxe2HC/zdHB/Kc8asp7cSqUFqFQed0xA7qtJU
 p8bIro2/eH7bd4qyywzAuq408Fe2xQU7laf+ajsw+hVJYFylJTiH4ZI/YQ3o6yWjsv0p
 Y2qMl1b1mFk54b/PB0jQZm0v68eDBpjCKqDr8bf87ajO+W0TQJevoO0a5XL7kwfRWKUH
 +WwWGZXj23YhVSG6tfL1AVZC4jYiGBm0Hh3/+3GbmOeP8Nma/txqPXQt0fyS0vS18Kfs
 DvB4TVQ7hjEw8+ACTcU59AThnG3A2TKsyHUgaTKAudMkRNx2AiZe31ljQVrrkzQUIbsn
 OYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948868; x=1747553668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bqAFcM0mocguuOJJgtADKFvDV5IEcmLyJztG0xkJMwo=;
 b=UtjGy5cwz7u4+oALkEh9ZpdjpVG89aenRcXH4h0T43v9qIUUE4saqyxJfk+tu0oV0Z
 MdoJ0OJcA+OSTnsirgNbinW4kaE3Z0sdDaIGySrdYawZhiMd1oFSwSo6oNlWsiIC3zIz
 aHlCjAWAOKtXWZrobcE3x52XvnjYUWdMUXrUCeDT9stzg2xgrqILADZCBMVBd8ws8DqB
 hQ4K9615I+aUeg4Vny37wqiELMpucSnol2J0AVX0yTjd7yWTmdnIm29k0gT43VAOGJXJ
 zk7Pb8sfeDerL9lyMnaHJkjt8J0vcXmmLj06Px2UC8BllhjXmQxdwzxeVtwGEXDlSApe
 3uVA==
X-Gm-Message-State: AOJu0Ywb52ZnZtpKIq0UY82HLTw0IYq2gQNu9vaU/xGyMHNokrsn7L97
 YARkBBq9KzHurTwRp10FoFj1h0/9h4wGx+HyBKkksUqSwkD7slhL2lZtKbNo
X-Gm-Gg: ASbGncvAxQDzPXVk3IC64QwuPlrQLahD8oG3jYPbli/3TRkn7hVIQ90TBkLDWl0jaX/
 7FY5uaAHB938J5EPvTAzu1yhcMgmpfz46gXnMd+tyX7oDMC+6BjMfUkV9wFZHygkF4JFfCDREC2
 eOHcfyKXzV4GGyj68Y/IF6yUYO+0WSuZuO4OzjOgkQtvSdBQGEsCV9mQ3M2j0sHY+krHlPYZB+f
 9MKQD68ydEUU1c0M5Hj8lqWfpupx0TioZVoLk5FwYZFVAwTHVWlBKpfLg8XIWcOUPNsE894ki4P
 o0nRsefwx9hP25RGPVY8sEVWYV7lLgPfRvyzQnT7JJrMyDrlwYAIhSE=
X-Google-Smtp-Source: AGHT+IGyHJlTpGv/wvRkU6Fpv+Pao6vQORr6CD1jqLBYPb2+q/lglgFykagzzQDoxhV0whk73+NRFQ==
X-Received: by 2002:a05:6a00:1254:b0:736:34a2:8a18 with SMTP id
 d2e1a72fcca58-7423c030959mr14987126b3a.24.1746948868516; 
 Sun, 11 May 2025 00:34:28 -0700 (PDT)
Received: from localhost ([103.192.227.12]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a0ce8asm4101759b3a.88.2025.05.11.00.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 00:34:27 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH 0/9] ui: Improve scale handling
Date: Sun, 11 May 2025 15:33:10 +0800
Message-ID: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi all,

Now we have quite a lot of display backends for different use cases.
Even in the context of gtk, we have various implementations (e.g., gl=on
vs gl=off, X11 vs Wayland). However, behaviors to users are not aligned
across the backends, especially in the part of scale handling. This
patch set attempts to improve scale handling.

We have to deal with various coordinates due to the existence of scaling
in different level. Firstly, in desktop level, we could have a global
window scale factor. Secondly, users might set a zooming factor to
adjust the size of guest content in scan-out level. Consequently, 1) the
buffer from guest, 2) the host window and 3) OpenGl drawing area inside
the host window are in distinct coordinates. It's important to define
these coordinates and scales unambiguously and use a consistent naming
convention for variables representing different concepts. The first
patch in this set tries to achieve this goal by adding a document in
gtk.c, and the next patch (PATCH 2) attempts to align the code with the
document.

PATCH 3 - 5 fix bugs in mouse position calculation due to not handling
scale properly, for both gtk and sdl.

PATCH 6 align scale update logic in gtk-egl with other implementations.

PATCH 7 fix an issue that gtk window might keep enlarging/shrinking because 
ui info propagating to guest not considering scale.

PATCH 8 and 9 align fixed-scale mode behavior in gtk-gl-area and gtk-egl with
other implementations by adding appropriate padding to the window to preserve
the scale.

Tested cases:

- qemu-kvm -display gtk,gl=on (free scale mode, fixed scale mode, full
  screen mode)
- qemu-kvm -display gtk,gl=off (free scale mode, fixed scale mode, full
  screen mode)
- GDK_BACKEND=x11 qemu-kvm -display gtk,gl=off (free scale mode, fixed
  scale mode, full screen mode)
- qemu-kvm -display sdl,gl=off
- qemu-kvm -display sdl,gl=on

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>

Best regards,
Weifeng

Weifeng Liu (9):
  ui/gtk: Document scale and coordinate handling
  ui/gtk: Use consistent naming for variables in different coordinates
  gtk/ui: Introduce helper gd_update_scale
  ui/gtk: Update scales in fixed-scale mode when rendering GL area
  ui/sdl: Consider scaling in mouse event handling
  ui/gtk: Don't update scale in fixed scale mode in gtk-egl.c
  ui/gtk: Consider scaling when propagating ui info
  ui/gtk-gl-area: Render guest content with padding in fixed-scale mode
  ui/gtk-egl: Render guest content with padding in fixed-scale mode

 include/ui/egl-helpers.h |   4 +-
 include/ui/gtk.h         |   2 +
 ui/egl-helpers.c         |  10 +-
 ui/gtk-egl.c             |  58 ++++++---
 ui/gtk-gl-area.c         |  53 +++++++--
 ui/gtk.c                 | 245 +++++++++++++++++++++++++++------------
 ui/sdl2-gl.c             |   2 +-
 ui/sdl2.c                |  20 +++-
 8 files changed, 290 insertions(+), 104 deletions(-)

-- 
2.49.0


