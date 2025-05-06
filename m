Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4DBC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrt-000491-Fa; Tue, 06 May 2025 08:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrW-0003Vl-Ow
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:31 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrR-0003sL-Rc
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:30 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ace333d5f7bso1060087266b.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536244; x=1747141044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQgFawT5s/msfN0Ty0yYdLDwFLO4xopk0Jf5DyIhBiU=;
 b=gTsdj5Ji21JeIrkpz3igLeZPhMUSE/GoGKz5jMo7uPGIGr0N+efOTzf1akyihKG8X6
 2RV++LnRpSsZB5jgNFUOTSR4LWqN/kZemzUHnLlIpO+YgRBJshoRUoNaomnFDEf+Kd66
 z+w9s1kAIgDZJuZh7wr03/Aq+EfRtAH6j5IuV+YVAxutcoJyuVv4lze1Pz+byOUQntf+
 ANROAQMy8KZBhgSeH9BYQOe0DHH9tqPHvCqqTl2h1CqcvFg2IOhdyYK/6WBpDXV3U1RP
 cEXDPjxtzau07KJCjJXMlwR5Bu/XGTgcUMeZKCdRE7NlQ92KpJ1QXTStp4/Nmuxm//aw
 NiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536244; x=1747141044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQgFawT5s/msfN0Ty0yYdLDwFLO4xopk0Jf5DyIhBiU=;
 b=cRM43wVJTHJICXsDwioTlv893GknWU15jESrJePLSLcMUx2OI0sWD7qnTh8JN5Rdjo
 T2CwlqZY2VoButqrOTfyWlKp9ZAfZ2HJqQmVnYLFAWEp5pRxwhmiO2bX7wlyA+6I7Xas
 slLeJiiEK5mtf1YWGZEsAfFIIZEk9r1gizU8qMhV+6GSAOuqtiO4UpuWzDQp6xfw67vr
 vqs8CO8wLmu8UFfVNBCTUZmqefRNaKfGoUnt8YSFIMvRBV9F5i9OVDWFhgW4pVMNFuvX
 Q4CuOrJ6RqAGFAkch2gNmwdHYUqhrHNf/SfgE8F9iA/+IOCIdlXjz1FhQNj+FMY9lxIZ
 136Q==
X-Gm-Message-State: AOJu0YxScQtBV8Jo2hhfOJED9YXnSkMoMGpOYGA5rtsdskBxQpQtpvdR
 ziBAqyBgOYB7s7LE2Tvehr+KnG0Z41uaduye/dez1sZpC7hbMSKLv8IR+f36nZU=
X-Gm-Gg: ASbGnctie7a5ayyHoDFoMkzGt+oFY0+vDr66Vvzbv9JLlMB+DDm7/dahwvd82geyoAS
 ZfAGtubgkldPgwKcOKDhikhOge3fg5mGoITP3zNCScA3EPDD95m4YTnEspGkROjLdFopK8Ec8A5
 adlM4zv7scui7oBxkUqenjQIueT8XTT9efV1DtWJZW+lKP9VKxmOBSTgRBqFXes9LFb9CyoPgyM
 oL3XXbZQQmI9zCWbCs8/gAFfm8GzuxeQ3MEyWFEoqKSoRLIZ4TRCHdtGweCGH5cXVjEhpI8jPnb
 +cAf6rG1EPqHYqbsEzRAfO1V+WxCF8LhqCEz/MszyLc=
X-Google-Smtp-Source: AGHT+IHEo2O/aq15muGdCzVXp/XBND2b1bQbIF7wWBWQoVWpQpzvWA+5HQ4Ek2eqbEIm/0sm07mQqg==
X-Received: by 2002:a17:907:2d25:b0:ac7:391b:e688 with SMTP id
 a640c23a62f3a-ad1a4b7c2e9mr1079826866b.58.1746536244060; 
 Tue, 06 May 2025 05:57:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18950b5c3sm696344566b.159.2025.05.06.05.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F95E5FADB;
 Tue,  6 May 2025 13:57:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH v2 12/14] ui/gtk-gl-area: Remove extra draw call in refresh
Date: Tue,  6 May 2025 13:57:13 +0100
Message-Id: <20250506125715.232872-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 ui/gtk-gl-area.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 2c9a0db425..9f7dc697f2 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -129,7 +129,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.guest_fb.dmabuf &&
         qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_gl_area_draw(vc);
         return;
     }
 
-- 
2.39.5


