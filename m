Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D988BEF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR2-0003sh-S9; Wed, 04 Mar 2026 11:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQy-0003pX-Cz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:52 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpQv-0002PQ-Pw
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:52 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-660dcafc85aso2140367a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643047; x=1773247847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5chmRJdStSTBUIyVExBHarHbJeDveLuSTCJqeJVI00=;
 b=Q2kL+I9wUYbVepJ1wqsmGXWU9/Qhgo4AGB6EZoesUn2HV0FUw9mGyifBT+zKCqkaEO
 ifkePFgcOSOvzGZZefNFoqUVL73w0qXaG6VPglxaGXBAqi19fNV27xgYYkjdu/AXDGfH
 lLhwodLh54zZj7Igz0kPXFeYDWe+DMUoeLAZ62nF4AL+FSTYWLVWoaMt1x63JlHz3wV0
 FKhLj9SBz9x0qUdiT7c3nnDUp4QbBmP8PlRPQe19a9TUffUuESgbO2lk+Pa4CptgocZx
 c9/ufjhu4bXv9dF5dUTg1RHKph2anU8fIlBUfjyAbZBjrmxnP7TMjNGAGUVp6C7aS+8o
 HrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643047; x=1773247847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e5chmRJdStSTBUIyVExBHarHbJeDveLuSTCJqeJVI00=;
 b=T+uMU9U29PqZSLKwEA1fE9guldmKHiYiiYnJjmsbr+vaPaOBMTKgmznpeu21PJTw1w
 MV0++GffPiAMyKemgda1f/F6Tm6V5zRd9s/XJnW6sTeKThwyIk8QVanjav5OYay+zxA+
 M8avxu+udqo+7kbQxnvnKaHiJUYn2dvteYkcu3hYvMgEtQhAN7A+86+EBgcGnJeoQpLD
 RCDOxT4VfAG1qF2iSQg7C4Q2KhCf5XFGzQe5YIqSIp+47pjiloq+uVEL68HCSwOsLxLp
 tdDtLY9h35HUmpxEdToFxljFMXiJzUU2YV3BzYQXt33QsgJ/q06mLSUwupTcSwrmpATu
 msIw==
X-Gm-Message-State: AOJu0YyDjJCrp8vnDVUtnQaHiw56aRm9DIwOcP/E0QGaXPv+IScoILLL
 CgR4hwQ4KzphNgBrnDTOaZfFqT/No3qcUQc+4a1YR4ml1PiF1t15FFjj+P/ZAG1Bp5U=
X-Gm-Gg: ATEYQzxllFiYqxHq3KP4/Ik+ytlfO7nE06qw362RnrYXMyVe8EBmspl/cV14MNgsco2
 CBlua0BUysVgGYgZYsT3/k1zZOBzOeRj0wTYBysBYfJFwpzD/2YNBY1pLEsPIbLiCs14Rk3N9XE
 RPWZCWkmDKvHEJgqXahzucjWUdJ81FHH2ryEDgvqOPd494SkSb5XZuGTsrZOwiQj3CAJB7jEBFp
 NoN9p+mwCV+BlGUYgoypiBzl3PVWQXKDOKL+OIcFbDkI4Xvwv2+V7zEjCcQDXETN7MmwZobDU/F
 V6EH6FCKX376Kz6MkZbHef/sEK/qSLrt1cwKbVEHledGNYHyxDzF0aEZOB3uu/u70xjBGjShKtf
 nOvy8MA2LfL17hQQ/kgkadmb2zrgLlbdx/41dDQlT//DXEgNuG9KeTjMGURoAVX4Lv+BQsjuyLl
 +3or2AnMX+QKlhifTCKwTbhCbPuMjvleaG6Q==
X-Received: by 2002:a50:85c8:0:b0:660:f98d:227e with SMTP id
 4fb4d7f45d1cf-660f98d2539mr845874a12.23.1772643047221; 
 Wed, 04 Mar 2026 08:50:47 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabd4695bsm5941312a12.12.2026.03.04.08.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 014915FD5B;
 Wed, 04 Mar 2026 16:50:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>
Subject: [PATCH 03/20] ui/gtk: Don't disable scanout when display is refreshed
Date: Wed,  4 Mar 2026 16:50:25 +0000
Message-ID: <20260304165043.1437519-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Display refreshment is invoked by a timer and it erroneously disables
the active scanout if it happens to be invoked after scanout has been
enabled. This offending scanout-disable race condition with a timer
can be easily hit when Qemu runs with a disabled vsync by using SDL or
GTK displays (with vblank_mode=0 for GTK). Refreshment of display's
content shouldn't disable the active display. Fix it by keeping the
scanout's state unchanged when display is redrawn.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-2-dmitry.osipenko@collabora.com>
---
 ui/gtk-egl.c     | 1 -
 ui/gtk-gl-area.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index ae9239999cd..0dbb429958e 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -180,7 +180,6 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.glupdates) {
         vc->gfx.glupdates = 0;
-        gtk_egl_set_scanout_mode(vc, false);
         gd_egl_draw(vc);
     }
 }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index cd86022d264..c709b2ce0f6 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -199,7 +199,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.glupdates) {
         vc->gfx.glupdates = 0;
-        gtk_gl_area_set_scanout_mode(vc, false);
         gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
     }
 }
-- 
2.47.3


