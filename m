Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D758CC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJiH-0001pI-Di; Tue, 06 Aug 2024 08:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJho-0000nB-Mp
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:29 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhn-0000Nw-0p
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:24 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso68694666b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948861; x=1723553661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GHmHGgb11iYqcqPSgHHl5+4znvZdtn/oYi94we9BmQ=;
 b=F8p8PwSPMjqiDf1fjeafK20HfvSm7LyuWBdJZ8gbuaJGz+jcgfKlzRNYtpki3l8gSQ
 6Uu/jb90k/quNvwTvT6RVv1xTvbF+4tpKSLgRHW9BoZkqPLLCUtER2Vn+ECT/DNf6aq7
 BNNdcsrPBMIfNO5SlitGn6HV1C+PtHM1LqmvsZ0NEFODUfh1RsKIAx6UAu4EW/8UGDc2
 mKHN1+30IdZNRjTJGVGWSP//CJcQ3Wwwrp8PL9WU90S27Uhx9MTliMo6+RYRjhqnpXCg
 Jtk4fAcFYXrb4jcNtNQszsChBlA4nkXTYDOy72YZ9denSKz3kqFX35e+R/HAuOMgRl7N
 lVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948861; x=1723553661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GHmHGgb11iYqcqPSgHHl5+4znvZdtn/oYi94we9BmQ=;
 b=pq6ZFaKsa7r1S3rQWfCSFiPa5lynIMK1t6NRGxFD648SIxG7tX9cM4RqcZNM0fq0az
 0hk3hDb8dUn8aFSmDhRFTMzVUKlTsK1pgywqTukL3msZtO4sbd62H8HocxlGjTMP+HwG
 oFB4HwpKlyCtFLnCbVdi65XbvPEP6H7pXFq27x5/SBxQTuTdynggwuL3kOw7YwHs0IV9
 21F8XdNpgW4b6BG8Sl0FGpG8MBAHLyZdJTrACEJoocrNnwQrJHNPuNAc0wYKRMCovdQ8
 9zb0xXui9msscmWrod+as5LQP9L90oZelyqWVFV0bgH+ebMXu/N5oAuIVkAdyqsAM2ua
 nXFw==
X-Gm-Message-State: AOJu0Yyf0+dHWLfnN97NBnuBMRJTZqjeLStM3wgf+qbrl+vbbIyoIuBj
 AXyX3PG0rk0JBp4uUFFJqSEjEXVVPYQfVznP5FzmgpJooAWO5uRsSdMEZLpp7h2kO4jqL8uJzmb
 M
X-Google-Smtp-Source: AGHT+IEAf1tc9+rVm04xWKxc+tXJ/ZBu8kXaFWJuaACS5HoEF/5xW6tCR12NB/1uYawe4HF32jWj9w==
X-Received: by 2002:a17:906:7312:b0:a7d:a680:23b5 with SMTP id
 a640c23a62f3a-a7dc50007bamr1077254966b.33.1722948861023; 
 Tue, 06 Aug 2024 05:54:21 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc9d7dsm547291966b.9.2024.08.06.05.54.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:54:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 23/28] system/vl.c: Expand OpenGL related errors
Date: Tue,  6 Aug 2024 14:51:51 +0200
Message-ID: <20240806125157.91185-24-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Expand the OpenGL related error messages we produce for various
"OpenGL not present/not supported" cases, to hopefully guide the
user towards how to fix things.

Now if the user tries to enable GL on a backend that doesn't
support it the error message is a bit more precise:

$ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=on
qemu-system-aarch64: OpenGL is not supported by display backend 'curses'

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20240731154136.3494621-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 9e8f16f155..213ee6a6a9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1973,9 +1973,10 @@ static void qemu_create_early_backends(void)
 
     if (dpy.has_gl && dpy.gl != DISPLAYGL_MODE_OFF && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
-        error_report("OpenGL is not supported by the display");
+        error_report("OpenGL is not supported by display backend '%s'",
+                     DisplayType_str(dpy.type));
 #else
-        error_report("OpenGL support is disabled");
+        error_report("OpenGL support was disabled when QEMU was compiled");
 #endif
         exit(1);
     }
-- 
2.45.2


