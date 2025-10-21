Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED2BCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCGF-0002HZ-F6; Tue, 21 Oct 2025 09:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBCGD-0002HK-C4
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:18:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBCGB-0002Yp-9A
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:18:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-475c1f433d8so1942155e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761052721; x=1761657521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0uUVCcSfLTNFb2IKz4tw3RJXNvASiNTQpt4aEdv6HM=;
 b=ka9dMAwO5GFwxqp8JuDlpkm/xF1E8uxdkjI7KEwQcuY7ASswrLQ0HlL/drpQWgTbht
 I26ZNti48DJR3oKOnRLtaHskbM6+mvCowXUsx6n9qdC9QrS0sIE4jochRRoqoawJAWPk
 RC05pDDBpepUolVfJe3WVPfK1W2MpN9Wpf01P3pWptksg4eA5iZtx/MVb4Sdgi6PKmm5
 Ti6ukecyMa49USR431sxa9lCHhOhI2/D55+4cZNOhslfC9fwWOYOu31IyKosULF9f2RQ
 RFmVMbuSAqNaO4RQo/MKX3fqGv+6dnPWQLYXjEJCH1cDwCzVhG3pZKRo20sdaFG9DFKC
 2j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761052721; x=1761657521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0uUVCcSfLTNFb2IKz4tw3RJXNvASiNTQpt4aEdv6HM=;
 b=SI1razr4WCSpc2wxB2RY4NsNDCUcrVOh6aBuH50kZIhfNYi85IKddvfKk4AwWW6mFt
 HzUNmIWqNwgS58iBTvvT1GllH4MeWhCjIlC8wMXJzFhegRiOmIjQr7A0tRxb8+FXphab
 Fog//q3Q26KOYtYr9Ns94LaHXcTqEKumTTHArl+N6Miq9P+LupbVsZisuYyIE+GLzWgB
 tpnkme4o5w+ECWJtcbbKJ/AkUcG6tnd023fx4KQCys1U7cejf/GEep/Ur0YLpK6k5l1p
 0ueQ1Xx1BqXwnq4eF+bHVUecUATFFgkgAUSdRPa0Kh2G1pUz1M0duNSyFG7P1+1dizeY
 LBrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmbs/4O1cy0vnuGMlxDKW3/wbbPMzUowRcNtAoSYcP6GHGpQYvpRJ5LXP3M7vudQ6RfMmx15cA/oiT@nongnu.org
X-Gm-Message-State: AOJu0YyJtgz+HCoA5/ejE7UTbNurfnTRGWmFsNifJsCZMhYBVQui80dZ
 enpbXE8ZJnO6IfoJtXwNgOkVTYMzOvjcM1RhHxcJKUluxO4osu23XrKFstTJn8a9Mwo=
X-Gm-Gg: ASbGncvKTdGSgCdFfIx+3PwEygSbilnJK/1uaG1jt46WWd0ldiPnygoZpUv+bvPdHWr
 QPUv9K9RqXeqSVPC6aBp9EpDxryq37pLfTX9T6vV73aZZnZK/DvdONoZg8WRfleA91CDEoSya2M
 g+SVodUQxHz6YYx9wO0uVeaJAtXnK7Lzgy0XwUFgoe26qut8YWWUIRlyB7LLBudObovhBOrKUcL
 eWJwP1+GZjYzwSnRfeeAyJdHmWXKzbsu9p6SoR4Hxvnu7+p0yLINOHvZsElMMhZjHfaydpdQtS7
 wHXCwSwaVNBwBVJy+ufAY0uqcIL3PryMAYx5vqwmM+M2cl/V9vCOf5qzfNNFWLUQ83JwBnJW+Yr
 7VfXHyltfLWGYI3d/HjHXmtHdOgHciZLKfIt8bXeFoC+06tz/t1joCnky02vw153bVt6gtr11Ze
 X7/qt3veM43/OwDJwMd4IC81fpvC357rvymMZShDliR1Clmsk++Q==
X-Google-Smtp-Source: AGHT+IFKy3bSBEz8fQTS59zTV+WvhpfKv8SoUOxzKPyUGE+4h7zk2iI0bC/V12ulczUPJEplRfXZzA==
X-Received: by 2002:a05:600c:34d0:b0:471:1717:409 with SMTP id
 5b1f17b1804b1-471179071b4mr109526995e9.23.1761052721093; 
 Tue, 21 Oct 2025 06:18:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5d48sm284179415e9.9.2025.10.21.06.18.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 06:18:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] hw/audio: Remove unused audio_register_model_with_cb()
Date: Tue, 21 Oct 2025 15:18:24 +0200
Message-ID: <20251021131825.99390-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021131825.99390-1-philmd@linaro.org>
References: <20251021131825.99390-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

We remove the last use of audio_register_model_with_cb(),
remove it as not needed anymore, simplifying audio_model_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/model.h |  2 --
 hw/audio/model.c         | 26 +++++++-------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/include/hw/audio/model.h b/include/hw/audio/model.h
index ebe456c22ff..b812c9211a0 100644
--- a/include/hw/audio/model.h
+++ b/include/hw/audio/model.h
@@ -1,8 +1,6 @@
 #ifndef HW_AUDIO_MODEL_H
 #define HW_AUDIO_MODEL_H
 
-void audio_register_model_with_cb(const char *name, const char *descr,
-                                  int (*init_audio_model)(const char *audiodev));
 void audio_register_model(const char *name, const char *descr,
                           const char *typename);
 
diff --git a/hw/audio/model.c b/hw/audio/model.c
index 924a41e0ac9..d1e00b4eaa4 100644
--- a/hw/audio/model.c
+++ b/hw/audio/model.c
@@ -34,22 +34,11 @@ struct audio_model {
     const char *name;
     const char *descr;
     const char *typename;
-    int (*init)(const char *audiodev);
 };
 
 static struct audio_model audio_models[9];
 static int audio_models_count;
 
-void audio_register_model_with_cb(const char *name, const char *descr,
-                                  int (*init_audio_model)(const char *audiodev))
-{
-    assert(audio_models_count < ARRAY_SIZE(audio_models) - 1);
-    audio_models[audio_models_count].name = name;
-    audio_models[audio_models_count].descr = descr;
-    audio_models[audio_models_count].init = init_audio_model;
-    audio_models_count++;
-}
-
 void audio_register_model(const char *name, const char *descr,
                           const char *typename)
 {
@@ -105,17 +94,16 @@ void audio_set_model(const char *name, const char *audiodev)
 void audio_model_init(void)
 {
     struct audio_model *c = selected;
+    DeviceState *dev;
+    BusState *bus;
 
     if (!c) {
         return;
     }
 
-    if (c->typename) {
-        DeviceState *dev = qdev_new(c->typename);
-        BusState *bus = qdev_find_default_bus(DEVICE_GET_CLASS(dev), &error_fatal);
-        qdev_prop_set_string(dev, "audiodev", audiodev_id);
-        qdev_realize_and_unref(dev, bus, &error_fatal);
-    } else {
-        c->init(audiodev_id);
-    }
+    g_assert(c->typename);
+    dev = qdev_new(c->typename);
+    bus = qdev_find_default_bus(DEVICE_GET_CLASS(dev), &error_fatal);
+    qdev_prop_set_string(dev, "audiodev", audiodev_id);
+    qdev_realize_and_unref(dev, bus, &error_fatal);
 }
-- 
2.51.0


