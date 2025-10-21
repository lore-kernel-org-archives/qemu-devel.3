Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A79CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJ1-0003IR-3E; Tue, 21 Oct 2025 16:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIn-0002np-HD
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIi-0001HO-Rx
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso51285695e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079786; x=1761684586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SGb2WMzFlaoi+Qsg+v6ETrYRqrYtH+YhqLXII+0hvwc=;
 b=ZdSE45V1V9TXKHh2s9L4+QKbZDHv60KyNhDS3o/S+LO9NAN8DcbqvswsXyDxLN2q+v
 ZYJDDRhI7cPeVZMGQi5427dg9KDgtp5ja0OKD0rFXsdRhRlzS/tHNiVGCgwdunye86is
 XyJAiFnJKVoEhIQW95VQ8L6jyj6kAL+2dr/avgbWIh3Nq+M9IC/BO1YlHtaezjgFBr2X
 UaSzm8nAQARJdi3+jjmJXsTxXuxQk/wgl9Og409zlommt2Ps/B0B00Y94D9njvygwS6r
 AYJMZMKPOm6ACMXA7Qe/JvPLiJujsJk12SD2T02PyGE6gYAJT/RiWJ3uVB02AsTC4Vyz
 h6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079786; x=1761684586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGb2WMzFlaoi+Qsg+v6ETrYRqrYtH+YhqLXII+0hvwc=;
 b=KO8uiKt+qFk5YNhlHd2+V7tIVPbA445vEggMNqjTdrnYZPYrsBFObrImG3+kDCfvha
 t57shHrSa1fa8WTSazTbuMAIYDTAb85+9lJlJbf6QQ/lGTWVpfW5k4HWxwqcOpxDMAtI
 Y5TwvSaH2z9ymENnCFCO3L59UjC1jg7esVmuXRcP9TPJfIZihC5WTwzpGe42zSm8s8hA
 QoQ+a02rfBWORBGMln94dH0IPzQ03n7ysAqleDGPi+XsvUg03X5vkmHuchupWnslruSN
 3AhtTW0qY2tmHSR8Pc8XZfTL7C72AMuOsZdolJWBknXeWk1rO+4A3RR79mCysENfQ8UI
 GEOg==
X-Gm-Message-State: AOJu0YyUSdR7KLw1vz19K+hSLJyIKfPZwF64/ogpEp75ajxYDNuh0QfI
 KaaEhtTIK6ilbah8zJDP8fB39SeoR9BPvYvDuiWW1SjyNMH4PI2PJ3r+JkjZQ/xehPN3khWH9LJ
 F61neX+0=
X-Gm-Gg: ASbGncsYZko5HbXwMjgilihzTFgG6FPeyUKMNyI1tRJxT0Puiu7KmMcL/CSum0RSLl3
 lT0TsADe0zfLilSjg5ZiNS6hM5gqB4+bnwIiyzoV5vJyQsyhb/YyM0jP7OObGcTC5bPxduOB2np
 iXXKo33uNomZfwFDdY4pxf56DkpMCZ2h0GyVr54iLw0ZBkCNR/ywSquqOcUHmbn4J922KBWgKP4
 1S66gtdMwGmzZWg1OGjBz7wRmUBWbupqnt5Rqo9K9hOYZEybMDsntuBM5i4uOSyJD1UlNDz0dcT
 PeVKyH5s1K2yXdQpF8cUROt90rEhHTLSF4pUNWlgreBVtEmjZ9XhNgdVjTAHNvIXFm9nGPo3XoF
 3C6L0J9emOYt7xwS5YITFLwczq931a1LZSTxNPGjVYF9kvkIji/MG4k25jWxwOmY0kt9L5Oz6gu
 +zSpkqwvLxdpZgnHV62Yguaaww4DcUGweBKaVNVwu2a3hk1skjPQ==
X-Google-Smtp-Source: AGHT+IHsISY9p51tLZ+PTeuI5niayxGN8SqmaE7zu1nSveKa5TWQakyv+jCstTY6RvQ258oGBntRWQ==
X-Received: by 2002:a05:600c:548d:b0:45f:27fb:8016 with SMTP id
 5b1f17b1804b1-471178726a9mr118864715e9.1.1761079786265; 
 Tue, 21 Oct 2025 13:49:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a7dasm24086374f8f.25.2025.10.21.13.49.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/45] hw/audio: rename model list function
Date: Tue, 21 Oct 2025 22:46:49 +0200
Message-ID: <20251021204700.56072-36-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251021090317.425409-3-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/soundhw.h | 2 +-
 hw/audio/soundhw.c         | 4 ++--
 system/vl.c                | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/audio/soundhw.h b/include/hw/audio/soundhw.h
index 474c5ff94e5..83b30110834 100644
--- a/include/hw/audio/soundhw.h
+++ b/include/hw/audio/soundhw.h
@@ -7,7 +7,7 @@ void deprecated_register_soundhw(const char *name, const char *descr,
                                  int isa, const char *typename);
 
 void soundhw_init(void);
-void show_valid_soundhw(void);
+void audio_print_available_models(void);
 void select_soundhw(const char *name, const char *audiodev);
 
 #endif
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index 2a41e108c02..63a68556352 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -65,7 +65,7 @@ void deprecated_register_soundhw(const char *name, const char *descr,
     soundhw_count++;
 }
 
-void show_valid_soundhw(void)
+void audio_print_available_models(void)
 {
     struct soundhw *c;
 
@@ -102,7 +102,7 @@ void select_soundhw(const char *name, const char *audiodev)
 
     if (!c->name) {
         error_report("Unknown audio device model `%s'", name);
-        show_valid_soundhw();
+        audio_print_available_models();
         exit(1);
     }
 }
diff --git a/system/vl.c b/system/vl.c
index fd98ea52d9c..17bbc092c87 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3078,7 +3078,7 @@ void qemu_init(int argc, char **argv)
                     model = g_strdup(qdict_get_str(dict, "model"));
                     qdict_del(dict, "model");
                     if (is_help_option(model)) {
-                        show_valid_soundhw();
+                        audio_print_available_models();
                         exit(0);
                     }
                 }
-- 
2.51.0


