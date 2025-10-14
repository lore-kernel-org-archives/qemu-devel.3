Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A69CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cxY-00080b-Pr; Tue, 14 Oct 2025 07:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxQ-0007vE-MM
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:45 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxO-000823-80
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:44 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b50206773adso1120536666b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440359; x=1761045159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bg8rMtlhXnkF/w+mBJd2TOmEOHNkxcbPVb42bgZPfso=;
 b=zsJ453v88Bg4jgk6+95QOAdXd9l90D8GD5qBULAY6fNSL2t8isnMZ7h82XSIpk6yy9
 CRn3+VyiS/WHP3hmRTDv9snLcnqKU9qPGA9cG7ZptH8ulf4OPuSjWbAM0bVAveBE2hM0
 d94FHQL6Oh0JDHxS5uEc7x0CW9/wBeX6ZlnISHeFL9IYcOzUZUXF5MYLCiI5+qz9hFjt
 yt3ETuV5fgkiGFW31waboLj8Xg6mNnyOlu5wTuI4qBmOah806rJikWmjfNziChb/pKE4
 uU9mpivL/aqUfT78+IINKntdDlD1vaqCoCMXuo/MIEwE7Eg8l87ZE+2bm6sVrH2KmRJL
 Epdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440359; x=1761045159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bg8rMtlhXnkF/w+mBJd2TOmEOHNkxcbPVb42bgZPfso=;
 b=DSdgNKUT0y/txYUiwSu1mK46mgQlDfzf5hYmQ1yNo4GKuEoEpdIXz+3Zra0fFqrSqA
 d/9a5Z/i4HxtSG1UY2/sIsM9KIK73dncVsmZ36ui18JS9Ve4gSvYBm7oXfuHhsYyu5/e
 BTd1kFoQxIDgIItprVlOxspyh5nT6lHgf/iZIuMbMAB2TTqYx4svA5xzz37v/MfoHZH9
 7F4l6cY2Oplm7ER5md6JwCsBPgMGH9zb4mTTdVhniuxPGeK4pNf/tKknHalkvpmYm0rC
 lBp29n/6Q5bppOXenRQNI+WLWeTWi8xitwxUJEkL/p6SaOgQ9Prtcwva1SVZnmVRP28l
 J/6A==
X-Gm-Message-State: AOJu0YwOAXecbrJCJ2ysFTSlKiHV40o+qvdwVS7dOYaY72zPEYcoj9rX
 tPza7l0B3zdUYrXBwlFYSh039OYyImLxzN8F34jjUPMfdXB93+iAh9tmaSnd3WKNGhM=
X-Gm-Gg: ASbGncv87uwl2cQn4d4DSsjygjqXUWsSxEs0IOIPlArXmxkIiVI2r9eLOmLqvOfcUqS
 F7Uv+Vn2G6AqL8U6zztPbmLJvXVcWJf6tAvUDF9In3Cu5oy0Ee4ywbZn0MtER0i0S+FSrC6gN44
 wdjWYGkhJ+q3B7UYUnjcRPZ09H55VOthoELbi0eR0P7GFFVYFQYylI16YaE0WC2jV6BoYgstPHH
 hgKn9zZ/VwGwm2chRQJh4sDYDeZ43YmO1P1JQy6cbsQh1E7jVe69DJ+WJlHfDBxlOI7F+PEcE7x
 KNDm9ux9iqWgkgK1Wr/tGzVlruO+/aqCJtPqLeFJwk5lbeEAL5SG9xgdNA4JUdd34dIv3ueJtDY
 /rtnZUWGd74vwb2rytnF1sA8/cPuvO72V84exAXJhzz9Sn0ySBwX1MhR1FGubVw/IYCg=
X-Google-Smtp-Source: AGHT+IFfA4YwSeSl9iZVBc6k9MB9nfb3h9qQQwAJjvgfVfWJCggQ+Mf9MFEijfyE+xhebnDfR5bPSA==
X-Received: by 2002:a17:907:18c6:b0:b54:2c82:40f1 with SMTP id
 a640c23a62f3a-b542c8241bbmr2520263066b.11.1760440359504; 
 Tue, 14 Oct 2025 04:12:39 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d9525541sm1127441266b.80.2025.10.14.04.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:12:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5510B5F83C;
 Tue, 14 Oct 2025 12:12:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-stable@nongnu.org
Subject: [PATCH 3/8] ui/gtk-gl-area: Remove extra draw call in refresh
Date: Tue, 14 Oct 2025 12:12:29 +0100
Message-ID: <20251014111234.3190346-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014111234.3190346-1-alex.bennee@linaro.org>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
Message-ID: <20250603110204.838117-12-alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 ui/gtk-gl-area.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 05fc38096ec..9a11c9b4d18 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -165,7 +165,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.guest_fb.dmabuf &&
         qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_gl_area_draw(vc);
         return;
     }
 
-- 
2.47.3


