Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1558AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmXO-0000fK-V3; Wed, 21 May 2025 12:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmXM-0000dx-1S
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:24 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX7-0006DL-Dk
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:23 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-601d10de7e1so6025075a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845786; x=1748450586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQgFawT5s/msfN0Ty0yYdLDwFLO4xopk0Jf5DyIhBiU=;
 b=n2t4qLno/iiN6p9mhzlmQmrUPn7H1XBvcMzdgxH1sSyzqZAKjTV4f28Ze2ozfr3gsp
 52fDvUY7NoI7yQqWbXmE/aiwfhvilCGT00BNok6kp4kLGc5KyXGV+lgV8mCJOR8A8OQF
 rJ0BaBgzWYxOfsrbmA4l/5wU5M97+nNIANax7EVUGmWCvtK3B9M250ucz4s2+P2jvjnY
 KOHw7Y+Ej3kUC+F7CgWBuKXwETtGg8DZJr3pH7mifH0rsS/AyvVVTxeZrgFpYdnZcM0b
 S5Mx0xlqE/gASNaWUWAXllE2EIoLafJxGejr3IG8dKnxb1t9D8MZvdF9xDAkdrScZbuO
 u42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845786; x=1748450586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQgFawT5s/msfN0Ty0yYdLDwFLO4xopk0Jf5DyIhBiU=;
 b=FykHdUZ9KJnNbVim5h/lcQYGYuX3imCr+sXH5LDnmD+9iW8UTHY+Jpytr4QU/lNkaL
 15DnIszByRALgh2SoM9qU6LnJVnF9K+9fArc13ZWFnGxvwXJtVfeWjuTScBIGQfheCpI
 X7H1lMuBs3Ca09rpSAMgCCNkOXP94yg9uQ8mhb1oJBAumoxiH+/RBMTYFe14Iwb9YMPQ
 RChXZ36fIe7t62DE0ZTFFHvk9kDcqCFzPhhQPJd3TObao8ruNgJaL7VJFOEMplFjdp7G
 kpFLE8ePgQOg3m+43DTbFEKJcg2ACRWwvtX35QV14QY5YWlqgSQPKXdGT1cU6k6svytQ
 kT7A==
X-Gm-Message-State: AOJu0YwHDDI7lgVsMZ1YlgsL/bzpTN64OvqktQ8BrtYX2XPXtaprq0Fj
 bSeIC4m2oOY10xPSL/DOwmnsiBkVnRP0NcKXB2rAefYnEkEuKxyD7xV9fVBb0yvlhxM=
X-Gm-Gg: ASbGncswQKt1UTpTHiczW08yPV1bUBEH8N/Av9U3T8dzEgiNRiLatCPXjsFze+BdycI
 6Ojjqj2Us2t4pJVIZOzfVMSySN/y7+WWrNPrPBzVlaasUUwP9OnjfhDP0ZaSb6cudNu/bwNaiF/
 Hv83ERfZ4F5N9kVTTFgoo6QWeMpfmvhvMWqDLNNCZJmA8cQs7VoS/OITVHKE7inyiBMguxf1Qkk
 a1h+elOXvBTlb0nsR0Mid7PJP/OSRIaPnPPO0XR8jkginveZvSiMngkPUyBDjwqnsHQAd2R373B
 loy/t7A4Zr24HHIj4f6TnkIu6qJHjSuGQGeBd1C/6WGU0hrXWEEu
X-Google-Smtp-Source: AGHT+IEp0yNBM+ELuOMhX0wKqofoVpQjl88b5WASP9z2iURC/oMWspJ6GAnpOGGWiHlLBLWpoHGvdA==
X-Received: by 2002:a17:907:7da2:b0:ad2:39a9:f1b2 with SMTP id
 a640c23a62f3a-ad536fa5966mr1921937666b.59.1747845785703; 
 Wed, 21 May 2025 09:43:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d497214sm929070366b.146.2025.05.21.09.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:43:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4AD235FA53;
 Wed, 21 May 2025 17:42:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH v3 14/20] ui/gtk-gl-area: Remove extra draw call in refresh
Date: Wed, 21 May 2025 17:42:44 +0100
Message-Id: <20250521164250.135776-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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


