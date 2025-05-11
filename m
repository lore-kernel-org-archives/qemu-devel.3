Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C03DC3ABCC
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDOs-0002RU-HG; Sun, 11 May 2025 16:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOq-0002Oz-KF
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:52 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOp-0006Jw-1n
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22e16234307so39328515ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995749; x=1747600549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xv6bQ+ZJWmSMXwr8xK5cNNZTpCyKVZTObTM1JOhX7j4=;
 b=O57CDsJcndSw9VxBjiH7hFFzMUqRPPOCY+l7DlmzXRqbILe/iUaAKlqACM+xAxClrf
 dj7NSukXjuVs3/2lxzvxOUHPX54dqdFFLnk6NHeVeUp3HQsdAncwjdTNNtuTKvnKJwn1
 PML2iCs2Dwv1/J4sBkw6zsgfubJJhOvciqvIWztp0e3CEHAOobYL2ED6jKSi7VTBdZpv
 LJsQHLUUZ+696jNIZ8IaZbQYklFE5byJdIALNbATLicmDO1pHm7cerqW5a1SUthtcsw5
 WZLnN0RmZxCK6aQjxYexFcFEQpZwV9YoFT1yqLihxH8wdB89KZGvjGczdWOtO99wKg4A
 h/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995749; x=1747600549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xv6bQ+ZJWmSMXwr8xK5cNNZTpCyKVZTObTM1JOhX7j4=;
 b=n/idPVPjaR+p6YEVekzMeQrJmenVbwovvLHzxOh2fyycfwbuQftbk7amWd+urfardu
 4XrwPwfXL0GPuryWUT4tgbTkH+zSU8Rq43sDcdP/nqcvPw6tsOMVBq4gdiw5yJFSI3z8
 cQ66fsZr0e3s7AAS5GcQCW7Y4Hx2Yw1VuGIaI9MhR/0mNhCYEJR8z6xOhTnjZXKcZ2r0
 6NCSZ8CHQIHcHWuM5iscvMDUoDCoXGgXpY3ZB+b1WseK679emZp+w3e6C/8E92ikBoxw
 Im4dAKPuDKI2uyi4Yja/nTIUzT8tNHfP6oR+ntKqbz6Qol6o9X9JOSFZBvp8rjCXHPkL
 gUWw==
X-Gm-Message-State: AOJu0YzamIwjh80rtolk2Km5QpUbifZjKvOol6rJl0kKUTuWIopSz2Mj
 eQNnngx9lv25134fOzcr3AAREIJuOMUkgeh467EDw0YcmrB9z12lmvB7F5mq2Z9h/qkbaNcUyYR
 H
X-Gm-Gg: ASbGncsVkxMW3651/gQnikU/Ydwf9Lyy1nQo2/t7hjY6yX8SOuTNvQXLIZv3k5Bebap
 ak3HgQqgmBvCJCLU8mmlfsiSvo0LVMtQ60p0+PRj+EvIynjp3ab23gWU0h518jkEfkC/na8aqXy
 ap0Huiv2ZJx4pQ2v4nUlJynDPvh8YWiUzOIV4ulq7HKwPLoh0Moy898JNPnNwkW9SDhQ+tIQ+iG
 b8zxPhcOT0ehjjFuH6U8cJCu/WXmLBrfiGiOsrXLhyhLCmusDbELPMe8p1l4ZZ5d7J2mV9a2+OZ
 7inA+cGW2BvBAQ6I04Oy6amW9oirf8OajOdoi/4K89Vk/cZLBDjvqrE2EYjs7Kv3ll4Rzyv0WJY
 dG3dNA5hyMg==
X-Google-Smtp-Source: AGHT+IFeq9MZax2o+yISxXod/DrpxNvVOx9LmOSHI8g08/wClCFJdIcRbAMEqzicDxoGGfaW0NUvlQ==
X-Received: by 2002:a17:902:c946:b0:21f:2e:4e4e with SMTP id
 d9443c01a7336-22fc92f41d6mr168944275ad.5.1746995749388; 
 Sun, 11 May 2025 13:35:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 02/24] target/m68k: Restore fp rounding mode on vm load
Date: Sun, 11 May 2025 13:35:24 -0700
Message-ID: <20250511203546.139788-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Call cpu_m68k_set_fpcr to make sure softfloat internals
are up-to-date with the restored FPCR.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index c5196a612e..724138b302 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -480,6 +480,7 @@ static int fpu_post_load(void *opaque, int version)
 {
     M68kCPU *s = opaque;
 
+    cpu_m68k_set_fpcr(&s->env, s->env.fpcr);
     cpu_m68k_set_fpsr(&s->env, s->env.fpsr);
     return 0;
 }
-- 
2.43.0


