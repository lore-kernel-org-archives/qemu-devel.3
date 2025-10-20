Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B524ACCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnKz-0007Yc-NY; Mon, 20 Oct 2025 06:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKx-0007XP-Pw
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:59 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKv-0000ga-QW
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:59 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63994113841so7182928a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956916; x=1761561716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvYlwMHdVV/m4b7uoLnXwowMJKhEagoEJQgkNT3N2pE=;
 b=FYPu1VTtWqrODrIZXJGku0xB2gX/stEqhboAQQ4KnyfEDUjRyl9vWtclR/X4rrvr7I
 /EIR6PhIMMNOYtXdbsruUy9Py3e11IFQf5b4gBcOaQfOXhi8CNy3++nJ+eoshUdYPDF1
 aC008TJNqckTM/aW/aUzXaCzbdPdMasKFrA+4HB9R0x9uWRaPqi4Dz5Lq7fZ/g/dkfHr
 I4ZesKLHHrkaum2XD4L9/fIxHBupdYte1FZhlyMfsK8Htk9q9qUGVO32kwrFrS98eVvS
 Q5mSahnjxzuk4Urll9aJlAT+lUG+tHi4hku5+3O09D28D+DVQFq7v2ArtdM0gkZ517zC
 c33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956916; x=1761561716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvYlwMHdVV/m4b7uoLnXwowMJKhEagoEJQgkNT3N2pE=;
 b=bush82fjPDGA35TOb8k5CG+CBw2NfgZBEf/9QQ0H1Qz1y8Ij8olORC8JrCHdLt/Efq
 OWkEx1XWYOIoYG5q5ZPD9UoadzL429b+yGWlTk8C6jwtJxS0kNeSPDj+DdIxobiCosmH
 VbrChieNkQWOntpNkjrgztSQO6/t7swhg3EG6th80XgthTn6OpNdUQv4vBpgWzg2TT9U
 MCTChL3b9tLRdaFgXl9mw3qwbXw3c92pv/XNiGlDGb9j4l7P2JHPHIlKcu53nQ6ZpDp1
 atcAlMyBSGuwqRZwu+Ydui/CGgjpdKWJQ8664jD0WAXYahxDn5ic7zm5JuEpppZC7Ozp
 aR8w==
X-Gm-Message-State: AOJu0YxKxnFEqXpvNvItLKxTFrxwz29ROUkuPlrLpWDYooQ7QvOVAH+a
 0Wsh+vd6onuKBuxpnSdIPblhLIXrYD3ZEg3RXuoYbumpTu5+7OIngTr8rujejfEDuPSR5xLnTM8
 QdlU+UFU=
X-Gm-Gg: ASbGnctdDJuY4i96lWBWaeg5dlgldD0sxtKFgZXyfgIgSrtqTu+J91hN+T6S9q04yyz
 zMrYVlshERsz9PcffrOAbWC5Fjq9MXdIrtOsbR5SgYSpOzplwp3fRaGaXO98nbFUHXDhYKM+/Cw
 aU8yYNcO3+0reE1nlDr4tJovP179g1rCTLaJBmUrKTb3gVXCaMBbBlfMuuL9B8yUZDy8OxT973Y
 sZdUon/sc3XDXgtFr+mva+1n+JBN6PZj/m8ucD69FYr4hdrZpO4ozTjYvd3jVYSe6yl62aO6bqM
 7GD9gprhzCZ9SJrLIT5qgdB1AKIkZpHqLs1xsUFXvGTsgDAkk7Dq4ZjejBsenV+dIS9CTXTH6J5
 3y5ptG6pmt2W/JshRqljB8ajSn4lE9HeXB/u9Mq0fyfPaDSRSD/lrk1pJ2tkQ6uX0kyNo+IEW5r
 a6Ios3gFJ7fGs=
X-Google-Smtp-Source: AGHT+IELUTlT9FnWeQZCFgdMQU9vS1O8jSEMu1Umvh6dXpBuNnEJMdTbxb80C9ft9wLS9uVk4LpRqg==
X-Received: by 2002:a05:6402:2353:b0:63c:32a6:ea0f with SMTP id
 4fb4d7f45d1cf-63c32a6ef2bmr10499261a12.14.1760956915990; 
 Mon, 20 Oct 2025 03:41:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4942f629sm6506973a12.25.2025.10.20.03.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 106DA5FA5C;
 Mon, 20 Oct 2025 11:41:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-stable@nongnu.org
Subject: [PULL 05/11] ui/gtk-gl-area: Remove extra draw call in refresh
Date: Mon, 20 Oct 2025 11:41:43 +0100
Message-ID: <20251020104149.4034124-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

From: Dongwon Kim <dongwon.kim@intel.com>

This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
which causes some guest display corruption when gtk-gl-area
is used for GTK rendering (e.g. Wayland Compositor) possibly due to
simulataneous accesses on the guest frame buffer by host compositor
and the guest.

Fixes: 77bf310084 ("ui/gtk: Draw guest frame at refresh cycle")
Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-Id: <20250214170813.2234754-1-dongwon.kim@intel.com>
Message-ID: <20250603110204.838117-12-alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Message-ID: <20251016150357.876415-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 05fc38096ec..cd86022d264 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -165,7 +165,22 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.guest_fb.dmabuf &&
         qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_gl_area_draw(vc);
+        /*
+         * gd_egl_refresh() calls gd_egl_draw() if a DMA-BUF draw has already
+         * been submitted, but this function does not call gd_gl_area_draw() in
+         * such a case due to display corruption.
+         *
+         * Calling gd_gl_area_draw() is necessary to prevent a situation where
+         * there is a scheduled draw event but it won't happen bacause the window
+         * is currently in inactive state (minimized or tabified). If draw is not
+         * done for a long time, gl_block timeout and/or fence timeout (on the
+         * guest) will happen eventually.
+         *
+         * However, it is found that calling gd_gl_area_draw() here causes guest
+         * display corruption on a Wayland Compositor. The display corruption is
+         * more serious than the possible fence timeout so gd_gl_area_draw() is
+         * omitted for now.
+         */
         return;
     }
 
-- 
2.47.3


