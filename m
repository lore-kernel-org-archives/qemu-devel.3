Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CE2C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trb5e-00067s-0h; Mon, 10 Mar 2025 07:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trb5c-0005xx-KR
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:14:32 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trb5a-0001RI-FB
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:14:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1741605257; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XuJPpWnJJZblTMlHTx9fUYhqXw8lOGXJ+GKJIfaJOsRj2lB73rAq95j9lA+4v4EOeWPqgUoPAqd00OVZZB+dXtLIqn2J4HkrBWEKv8RB0XxdD00yTv9fOiopYLd55NXiPaQx0x6LSi6LLs+izbiMsDLI97uVWeZWR1pWlgee39g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741605257;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=09WSpJc1UTZRxFDHxkgeIPpHfI0bG12mE8DGzrr9V7U=; 
 b=FM5mXh2jFcSabdrG+eqZP9a5hdWDmOAnrivfQqQ7oJVDF3aZhYgxi76LK7s5Ekv2obYYP+mxhSjHeM0sakeHxPa2/UtHgJ2crxMhYEa+KeSeF8FJBnZjK4FGWm1SD+Ok780PwMZiyZnml3kifDF39xbKciRksZzgTAFlYqyhVxE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741605257; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=09WSpJc1UTZRxFDHxkgeIPpHfI0bG12mE8DGzrr9V7U=;
 b=S/zpsk+0rGq0lkF0iNjsj3RRZtFVs6TpAuPbDbq9meTJURj+cIguh/CbFP3a25qc
 AeYHTYS7Il7poeFD/a8sjlVz23zYlPbOECYcOBQ6XgV3n1lS3Se/VacbiJSUrO9xrpw
 pV381ppk6PMYdj4TziZsdeOU6QobzciUZnHJrpxY=
Received: by mx.zohomail.com with SMTPS id 1741605255873855.2668137917361;
 Mon, 10 Mar 2025 04:14:15 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v10 07/10] ui/gtk: Don't disable scanout when display is
 refreshed
Date: Mon, 10 Mar 2025 14:12:31 +0300
Message-ID: <20250310111234.145891-8-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111234.145891-1-dmitry.osipenko@collabora.com>
References: <20250310111234.145891-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 ui/gtk-egl.c     | 1 -
 ui/gtk-gl-area.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index f7a428c86a8d..0d1547d63ad0 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -179,7 +179,6 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.glupdates) {
         vc->gfx.glupdates = 0;
-        gtk_egl_set_scanout_mode(vc, false);
         gd_egl_draw(vc);
     }
 }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 2c9a0db42571..53d81124f211 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -148,7 +148,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.glupdates) {
         vc->gfx.glupdates = 0;
-        gtk_gl_area_set_scanout_mode(vc, false);
         gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
     }
 }
-- 
2.48.1


