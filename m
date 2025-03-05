Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDBBC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd1R-00035V-2l; Tue, 04 Mar 2025 19:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0u-0002UD-5x
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:36 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0q-0007YW-Kw
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so3682142f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741136007; x=1741740807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzOKHZRFCe8gSsyMmCbgGLcMBcX5RnVMQQNugexIWns=;
 b=ZV+JpKfZ0Jw5FRV4T4jbnSvF6MZMn7S97k3SUVkqmCzEE8LA2gbyVAlM1xWbSYr1Oh
 5hufbHB6NI/1jlAIU2NLc+t/EkFadGMmPNzuZdrDWlRNu2Om7AHbRIORFEKo7awPd/1k
 YiN4cZvriWcNSUAH6Ez3F6gD03UIwR7HAxaFPW/Hs3lu0h/vZVMdrnCgzHvY3xlVtUNV
 JKwEpqvXgCKD2deolia1v7MUUFJkupdmTfWt+XF7WWwnN0aNE9OLOZsRcu4/XGDJy1az
 wqIC0581qPdwpo+MSyiVhcICayzvPqbm8FrO/5xsIzNxrs8Mu7MnEjfjHIYXl4lzGae0
 0jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741136007; x=1741740807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzOKHZRFCe8gSsyMmCbgGLcMBcX5RnVMQQNugexIWns=;
 b=kGBJHJOfKpX5LoBXh8Z4uUay36pWw68jsx++mBvRdBcfRq93cEuNo8XFF58UJawBp/
 667bo7y9fVQuHmWXIXiRcvpsEVSRip8EkPMqCarQS0k0MiMkGD1DWR6OcSIDE73JFFRT
 X8uvYZdu/CNU/wDo/RSGlGjM3gB8dbJsWkIMpsdE060LC0rjKNNU/jSi5JAH/iu+NfQ3
 PrM+zlvEbU9HZTGcsR2E8EHdtRqyZLQQpd6/xHBV5+3L78F1CLa0JubckoZJLdp99NCy
 3HuVHEEAmy0g0zsZZpc23aKwCHDsiaAYrUjxcKO5ghy85c658/sWRGUbt4CWUxdcG7Uz
 4CIA==
X-Gm-Message-State: AOJu0Ywqn7rDfFEkA6+CxHOnpatGHW8Sv49sHGg8iApEIq6AqI+7VrI4
 3fRG0cXQwss9p5COhcGUkIRpA8TcJl8aZT3/LFYbKHMl2IpBuMus7kqH5d84/Rw5VAjR+X2n0BW
 l5d4=
X-Gm-Gg: ASbGncsHtA837A5/vD//IPpSsBs2wO2lCyGoEWy51cgzXa6iWjJeSq1Q8tVp11oBR8W
 gIvwOA+ixs6FaWWm3IjrdeaG4TbMswEPalfXYvVtTW+1nNtXZQNBr9lxf2SyaevJXPbVfR1Rs8v
 nGqj3wfT1r8sywf/n4l5wkzB8QZd2mA1jxKGZTX2eapt8c3Xo/zaBfyy2r2IZMuVOoY9F2bZtJK
 RSDEIiAjkcE6PBlJV4DVWpOfKAcEz6OkMu6z3lJfekf+qfy54GyUdFO1Aa1JX521xvKlUnIo5Mc
 FXS1SPvwp/y9qk4uLFLSPJ05UVGOBuP/hLwrK3mtLnQAuZkw7o9BlBeySv/egOQblKgSITcuGPB
 D30OUreaxQnGlUJTLgQo=
X-Google-Smtp-Source: AGHT+IFmY0fHZO/RV2a0dc7rdZ6O+Ah3IMc1LZF0TdVbrJ7q+7Gb/Wpr2Xtlx31Ye/jq2gX+ESQr5Q==
X-Received: by 2002:a05:6000:184c:b0:391:2163:dd67 with SMTP id
 ffacd0b85a97d-3912163dfe0mr147689f8f.6.1741136006937; 
 Tue, 04 Mar 2025 16:53:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4847fe5sm19327264f8f.73.2025.03.04.16.53.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:53:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 11/11] qemu: Remove C definitions of TARGET_NAME
Date: Wed,  5 Mar 2025 01:52:25 +0100
Message-ID: <20250305005225.95051-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

We don't use TARGET_NAME anymore, remove and poison it globally.

The symbol is still defined in Makefiles by the configure script
(it is required by tests/tcg/).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build           | 4 +++-
 include/exec/poison.h | 1 -
 include/qemu/osdep.h  | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 04d8c477644..eaae1da2e92 100644
--- a/meson.build
+++ b/meson.build
@@ -3347,7 +3347,9 @@ foreach target : target_dirs
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
       # not used to select files from sourcesets.
       config_target_data.set('TARGET_' + v.to_upper(), 1)
-    elif k == 'TARGET_NAME' or k == 'CONFIG_QEMU_INTERP_PREFIX'
+    elif k == 'TARGET_NAME'
+      # do nothing
+    elif k == 'CONFIG_QEMU_INTERP_PREFIX'
       config_target_data.set_quoted(k, v)
     elif v == 'y'
       config_target_data.set(k, 1)
diff --git a/include/exec/poison.h b/include/exec/poison.h
index f4283f693af..0c4ad04eb97 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -34,7 +34,6 @@
 #pragma GCC poison TARGET_XTENSA
 
 #pragma GCC poison TARGET_HAS_BFLT
-#pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison BSWAP_NEEDED
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4397a906807..3167fda68e4 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -50,6 +50,8 @@
  */
 #pragma GCC poison TARGET_WORDS_BIGENDIAN
 
+#pragma GCC poison TARGET_NAME
+
 #include "qemu/compiler.h"
 
 /* Older versions of C++ don't get definitions of various macros from
-- 
2.47.1


