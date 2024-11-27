Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2E0D6ACC4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGzD-0004f5-HN; Wed, 27 Nov 2024 07:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGyw-0004d1-3n
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:30 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGyo-0008Jy-3j
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38246333e12so6578841f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732709831; x=1733314631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NuUE7wlyBlmQOjXJ6jWzyk7rKqGNsAm23QWx4Jiwm0=;
 b=gkdULsffrvEKw/H+wSH6jJR8fno7YggfAmhU7/uVnYK5ZARcDPH3Uyw+c1xK/74P8B
 jFcae1uCIy86IgQKLiWdyy5Xj44Lkt26wNC8FphixJxniI6sve0MD+p04VOjgNkXBJoD
 osf5iYdZORNwRd12JlqsLGzCJlJZpmgcUyjPZPXpDrrOtV5bq+BRpxxd37gokNp2eYCq
 a0NVVTlu1GMBKYQVnROFn6un7/FpZaxhq6giQCMWPjj2IX14n2UiTkP4LE53/cecZvtL
 5xXtd9o9poGxRipr8mef5SfDO3cyRqCkGkKV/Iorxqspz0s/LT/TrgdUISTHC7rNgl54
 t7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732709831; x=1733314631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NuUE7wlyBlmQOjXJ6jWzyk7rKqGNsAm23QWx4Jiwm0=;
 b=a4JlCfkJAMNrOZXPg6giinAkP9aVjW5pWVpN8uN7lngto7+jTN9DIT6PgEF+PHZz2n
 P+E2CgUl38/KuI5dsMP2Uub17xKCf78pf6plQxum+RcNSvxyWIH/EdTp260RIu/+3Gzn
 SJM/SA4+8L/tMOtTIStVNyYfP4tf2hJNw3cIZ8oOf2vcitdK/ZUj54rdBWUBL0hYYBj8
 lKvgF+HiN4EPoNbJxUwnPDnh/G2w1fm9g5QVkACojG+Ub+X9ZI2hZTvfuE0sa192S7yb
 0rUUp33x4SSCEQ3gixNfggukS7a9dytYPffgjue/HWyL0V+pft2OxmK88azusgtTyWid
 TKyw==
X-Gm-Message-State: AOJu0Yw9MkQwfy4LPXfJyYMpdoWr1mmxyUGIQaScPfg3XCBHpljY9TcC
 +K7QydRBl+vGbDuJ2P8xD/OZSDiCnUZtk7UrHMI0LEWoc3i2D+EvPfu96C6qOQtqo2Y1iFRCvzC
 7
X-Gm-Gg: ASbGnctoP4DpIq/ImlCaF0HVN+BzDWArWJWhzqeGIlOcZUVw7YHutnGm5ltDocXKO4E
 jIQGOJ3NW6l/qGDanFkJ/rssYRntkKyh7e3Wpuv/LlDB35AV0TtzTJ4/EkfJGcJ4ExmIqicvK1a
 dizx9SErWh5sLoDln3lFNk1MqWy31jDYMVtMcmKloxnoKIsXUmZgR332OfNwv7BL1OlEl7DP6PW
 MMmjeTZbLVeQxq+F+6PcrTTc3qVxia6dQh+Waavr5pBrgkH5Z43Ayh9J6IauQNe5HhNQxYXfMA6
 kqxdhpOoLCrOw/KJJ+MXTVX6uug4U/NBZTGv1C1DILE=
X-Google-Smtp-Source: AGHT+IFzg2jg5qjcVKwHC8kuHABz4KLEBTYAJUeryJwEkNY+/fhy6yg6IEl6vBlhiT5aQIT+xTHYMg==
X-Received: by 2002:a05:6000:21c2:b0:384:3731:d721 with SMTP id
 ffacd0b85a97d-385c6eb7c74mr1798190f8f.19.1732709831595; 
 Wed, 27 Nov 2024 04:17:11 -0800 (PST)
Received: from localhost.localdomain
 (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr. [176.184.14.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad60f0sm16157301f8f.22.2024.11.27.04.17.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 04:17:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 2/6] accel/tcg: Declare local tcg_ops variable in
 tcg_exec_realizefn()
Date: Wed, 27 Nov 2024 13:16:54 +0100
Message-ID: <20241127121658.88966-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127121658.88966-1-philmd@linaro.org>
References: <20241127121658.88966-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Ease reading code by declaring a local 'tcg_ops' variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8163295f34b..18d9cf0ea58 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1070,15 +1070,15 @@ int cpu_exec(CPUState *cpu)
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
-    static bool tcg_target_initialized;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
     if (!tcg_target_initialized) {
         /* Check mandatory TCGCPUOps handlers */
 #ifndef CONFIG_USER_ONLY
-        assert(cpu->cc->tcg_ops->cpu_exec_halt);
-        assert(cpu->cc->tcg_ops->cpu_exec_interrupt);
+        assert(tcg_ops->cpu_exec_halt);
+        assert(tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
-        cpu->cc->tcg_ops->initialize();
+        tcg_ops->initialize();
         tcg_target_initialized = true;
     }
 
-- 
2.45.2


