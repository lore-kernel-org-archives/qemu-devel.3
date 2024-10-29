Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD26ED2AB30
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3n-0004f6-9Y; Tue, 29 Oct 2024 08:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3Y-0004aJ-6M
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3W-0007Sr-HM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so51562255e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203837; x=1730808637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcXCjHXJMHI5YxkHU4VEpqalzCQd34FPSXySjBFHomU=;
 b=OsRZdESB1ZV8N7vlZGYCtqrNL0japx/T/JeCoviMDoF7UeHiEJWSo18qrvaeTJ4TW5
 8hyW2gdJ6Ih0d2VnarTAFeRlvZSkcY7cekpceYMOexH1KmLOi/4TjKGVyGA8IF/RElPj
 ykqADmTtSRCoBhXfF0FB6LAJ5OffJAh1KdNT4oEBuWypVUvShXbxpmt7oNkLRb1DRox7
 imu0MY2uJbmlZCZbndRjlIiqu+CsnBg+0WrBqFkibm7UytsXtNwIn7yo+q8Poyx1vwXy
 JpT0mejofDF1+0DW5GV01fN5qCfefUXXZAMuF46AjiHoCVI0VG/1BsLNQMQhaYECHDu1
 jFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203837; x=1730808637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcXCjHXJMHI5YxkHU4VEpqalzCQd34FPSXySjBFHomU=;
 b=Z/tQ28cMz352bE0PGCUsPoy+H/aqoZWwtzye6Ak/17YBxlMqNIaJTvBw2ynblnPKgu
 tqbB/sXuh18JjSl2v834Ue1QXiTv6cu9pEilwqApcsEIjhM1pGklbL8OU6V84wXZbkxg
 1Oi0I5QyfkuKMctOuQKf5LckSb39JiaRBUUA0VXZBvqrMda+K+DzX+g42He/W61vZLzo
 IuGDjpYu8tOwq/O5HUQb/oLLpBqd7/7trptA5V7czU/A1Vd6uI8oIdGvgC0DN8S1qAYC
 b06RTzB9AQs30fN6DFccwWCloZJUxclDRm6zQpLDRtTHLh76r1IWOyMKO1U6/mJJyxDG
 Bzsw==
X-Gm-Message-State: AOJu0Yw5bze9gYEerG+hUlRleROju49tK9JhVDUNK8iZl/pQtGEzV313
 2dR5ONSB1HJsPQmOZNQ4bmdFj9GLsefw3bOEQ5rdZc0qX+fTguD+FyWAIpyc7Gw=
X-Google-Smtp-Source: AGHT+IHb8QTLbZByAnyQ79rJl3T62PWXkkFQRtveQ79c2ROrSYdOyvEIKl6W+bB6EfLf9EKHV4p01w==
X-Received: by 2002:a05:600c:3512:b0:431:588a:4498 with SMTP id
 5b1f17b1804b1-4319ac9ad1bmr114123305e9.14.1730203836823; 
 Tue, 29 Oct 2024 05:10:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b567fe8sm171774435e9.28.2024.10.29.05.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B3245FABF;
 Tue, 29 Oct 2024 12:10:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/13] virtio-gpu: Use pkgconfig version to decide which virgl
 features are available
Date: Tue, 29 Oct 2024 12:10:23 +0000
Message-Id: <20241029121030.4007014-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

New virglrerenderer features were stabilized with release of v1.0.0.
Presence of symbols in virglrenderer.h doesn't guarantee ABI compatibility
with pre-release development versions of libvirglerender. Use virglrenderer
version to decide reliably which virgl features are available.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-7-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/meson.build b/meson.build
index 85594fd3f1..8dc53c12fb 100644
--- a/meson.build
+++ b/meson.build
@@ -2437,10 +2437,7 @@ config_host_data.set('CONFIG_VNC', vnc.found())
 config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 if virgl.found()
-  config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT',
-                       cc.has_member('struct virgl_renderer_resource_info_ext', 'd3d_tex2d',
-                                     prefix: '#include <virglrenderer.h>',
-                                     dependencies: virgl))
+  config_host_data.set('VIRGL_VERSION_MAJOR', virgl.version().split('.')[0])
 endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index a63d1f540f..ca6f4d6cbb 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -171,7 +171,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
         struct virgl_renderer_resource_info info;
         void *d3d_tex2d = NULL;
 
-#ifdef HAVE_VIRGL_D3D_INFO_EXT
+#if VIRGL_VERSION_MAJOR >= 1
         struct virgl_renderer_resource_info_ext ext;
         memset(&ext, 0, sizeof(ext));
         ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
-- 
2.39.5


