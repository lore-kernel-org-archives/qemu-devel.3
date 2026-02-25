Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD3CF5545F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7XM-0003la-6U; Wed, 25 Feb 2026 00:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7XK-0003lK-N5
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:34:14 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7XJ-0006lg-1F
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:34:14 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso8573415e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771997651; x=1772602451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iBo1lTvpEzWtV/3g95qoBlTwp9cVcmS6JAj5uUNf/qo=;
 b=FtVkVw8bW26f//XaH5NAXpVFcVTmRMEZaIsGxmPfJ4Z9N3jh9ulyyolZ0oxy+ywCaP
 nyxJcCqmIB+IrwWEnzeHwE4tlEsDbIXQYjxcyiXItwP9faEN6IMBQ9vqzzqua+gFtgsR
 0sJ5f67GHfgGS8UkoBWfRzGafk66q09DvpcJF8pzN4TjXyatxaXYUtj4Qwm/xHZYoyEN
 Vss93nMB35zR63ClnzX0QxKBEBNEp96yls+5yJN4w2S/HPuUWUE+uHZMXFwxemoIq/kK
 CUj/u1b0+acqeFWcl0g8DPDPCGP5oH/r8OTV4BPWS2cZj9LCZV4BSAizx1SxR0FOouNJ
 wWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771997651; x=1772602451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBo1lTvpEzWtV/3g95qoBlTwp9cVcmS6JAj5uUNf/qo=;
 b=RHTgPPLtg+aHbE6/lXq5RY1+USBlSvq2IKMSWisOdaUOLDP6btb+sYcIh9UQLgArLE
 whCKoPXUW6l5h1t0JlJNpKGekqUH4ouYCTSy5caKnKw2Mrl91fL0oS6enOfOONnCwAz2
 TyeFJac/JqOzomrHQRKwxqss5TKWvX7nSL+/Pe9kNx9uPI7k7W0uEmEr9sLfEA23JmEG
 qC4WVGu5muYkFZyK4K2oit9ymmDApVAPQekdSrzMl2FeDiy48ulT+GQ7C6N2LOdTSDxO
 0TGLWRQJobVl+XCPtYSYXzsPa0pqQdv1fXtgwywjo+XN7OXL6cSJkNLzdfhaakgMrjRj
 2vkw==
X-Gm-Message-State: AOJu0YwiMpZbh+Wo8ClrBQy+aYISvEywMWrrdi2CRfi/z6SkejJWrDNG
 qO+l8cavfU+1NO3j88qaA22gkbX5Ii7L9aSzS1W7+dLYTwmDOQCf/gD6J1rsrv847Qp+YUY5pWU
 RsGkUOJ0=
X-Gm-Gg: ATEYQzwL9oNHqTOEtZkqJ1VLczWfhfx6OKiAGn4LpZHTHMbTwArddbjSzanhL/Das7D
 VZZ8UpTUmyafWmDeVDknL7PkVBijE3bK+7cvdlgxT8koDMSzz+67uuSNnWXkpyDrLMnhX031ZeJ
 GPT+Roo21lIFsLDoAgoHS1RxwjnnJj1kGJ7LFJBhNRKX4ySB0IS2oLRJkFJj3mMcdXvpTVh9lWR
 pn8xP6doKQXrU+wfy7Yjr4CFs24SJF9OcjvuZ2st7ROgE3ewc83t67romAQ2bDW37aMfGKjmkKm
 yp+ib/Bc5ZkN3wl7NQMUAIEO+yH3FxavQHG8hrIQR23dZRmo3pRLycVJspag5xzUDbM04mFH0Sm
 7lMucVwZLH9JVaH3SRnj6LxQEdVPHXR5YLiw5omoZBIwe8p/ScPEMz9BSGoxCjcxIuFW+xd5J8L
 Qy2Jiex7kRtP4QZb80HdZ+cRXZoUCf2XaSsMnnp2hplO/Pv9Y78tN92wUQZEI2aEzLiW6j5k3z
X-Received: by 2002:a05:600c:8506:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-483bef62a9cmr16282105e9.32.1771997650872; 
 Tue, 24 Feb 2026 21:34:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d54760sm31296177f8f.35.2026.02.24.21.34.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 21:34:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] accel/qtest: Build once as common object
Date: Wed, 25 Feb 2026 06:34:07 +0100
Message-ID: <20260225053408.18426-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

No code within qtest.c uses target-specific knowledge:
build it once as target-agnostic common unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build             | 3 ---
 accel/qtest/meson.build | 5 ++++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 5fecd6103a6..033d8cc1a0a 100644
--- a/meson.build
+++ b/meson.build
@@ -3867,9 +3867,6 @@ subdir('linux-user')
 subdir('tests/qtest/libqos')
 subdir('tests/qtest/fuzz')
 
-# accel modules
-target_modules += { 'accel' : { 'qtest': qtest_module_ss }}
-
 ##############################################
 # Internal static_libraries and dependencies #
 ##############################################
diff --git a/accel/qtest/meson.build b/accel/qtest/meson.build
index 2018de8a05d..e1b089e02c7 100644
--- a/accel/qtest/meson.build
+++ b/accel/qtest/meson.build
@@ -1 +1,4 @@
-qtest_module_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: files('qtest.c'))
+qtest_module_ss = ss.source_set()
+qtest_module_ss.add(files('qtest.c'))
+
+modules += {'accel': {'qtest': qtest_module_ss}}
-- 
2.52.0


