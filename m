Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC7EC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX4m-0001nG-G0; Wed, 22 Jan 2025 04:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4j-0001i3-Ss
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:31:05 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4i-0003In-Ex
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:31:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so65656175e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538263; x=1738143063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6euSBLv31aJZp9lvcImTSgTbDVlnwvaPYw0ieO+1v6o=;
 b=hWSPv+d2k8JBdaQDMD92SKchTB/Zl+COaNKqvQH8EjdOTFL4ZG3ynU1CB93uf4z0Di
 yN+ajwby+91/ByvxiMjcUtJaP1z9fFtW4IxblQORd1HE0Qr2y9BfAgvPowfbUtJ6qdWK
 C/InLmQ7Nj5ALx75pWKueZnF2MhWbaHuYXkj5s7I92XwgyK3kaUsklQ/1rfMHhJJuMpu
 iOQ/ozsx6cucF+TDxYom93c2qf8IxoYdMnWjPF6CceDmpn85lRWYmBek580pYvIPA2tV
 JKO+I1onBLdG7lmYqla55CyeVOFHWDzRovO4l9pfN0T3zp601DkdWxwifaOpNZMjn2Q6
 8o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538263; x=1738143063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6euSBLv31aJZp9lvcImTSgTbDVlnwvaPYw0ieO+1v6o=;
 b=KQacXUbLk9k914IH04sX3nCX4Qb9yq+I1wVON1RbdPBgEId2RegxmsYQOIxQeG7P4A
 cElASIu68v+DNdi/EiZcMDdpnBHOF0aQRCGB5cdH+AE+/lueoNc87aZKW8BiuzmXAEsD
 GGXoKCQq4OFKfmuYN+9jS6jDqfGZwWMRgxfUfIDM7mLDki1wSxmPahSPfZFUKjE9JcDH
 KL2i+NxBC/MrVkOqDkGa8YbZsDhWglPC1rU0WJv3V3HZXNsXTPU/AYEOEtVnbwGOQMn9
 ov8IQK6IeMi7JFr28kaHVRWDSV+Avfaz3kEZlDGyQUYSU52WB3xaNEgyEmkQn5gz1nsC
 h4Dg==
X-Gm-Message-State: AOJu0Yxx88+0Hc0mSZe7E1iGLYcsmoqnIVl501YUWCgKfa9VLdUUMeq/
 FLOJ37/QpWofVtqBcOt3X3916nxVedj+S6kAZCiIV+TNE0uNmqYSWlyHav93FRfN8HJjW00VAld
 N94U=
X-Gm-Gg: ASbGncujOqa7VR0ZUI/1lPpgJv2nDwRsPooLILiwkwELGqJyKHCE7fWnDwwZ67/3wIm
 g+a31aFtsYiVJBjJ5rLd9UXIcySOu67J2Yik3wAC3sl8Zudeatz2QnSJBpGyUnHE4x6uUeU3KAi
 0VS9uiCYi0km8HkJU6bf7HBMIDQTFHUD1DagKsf9CWpPK5xH4kGt/bp+KNmwcGMIm1NkrBfKCe2
 DUiYxtuf2tOt5ykalFeBLIfu7PXUae/fgjTilmeDJduyK4jMMHxUQUh6sQGgzUk67n/oCBn5Znf
 sb/rZ3IafoFduQjfV6zhzL/4Jyeoyjr8s55HuTgC58DW
X-Google-Smtp-Source: AGHT+IF2JvGRnHc2kBttL0oH/jSFC9d4hSmVy0jmUw3+QS0SDdp5u+fq9MN06CLSXLDViVVLuT7YAw==
X-Received: by 2002:a05:600c:3593:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-4389144eed4mr166904965e9.25.1737538262741; 
 Wed, 22 Jan 2025 01:31:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31adbccsm17547875e9.19.2025.01.22.01.31.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:31:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/10] disas: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Wed, 22 Jan 2025 10:30:25 +0100
Message-ID: <20250122093028.52416-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/disas-common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/disas/disas-common.c b/disas/disas-common.c
index de61f6d8a12..57505823cb7 100644
--- a/disas/disas-common.c
+++ b/disas/disas-common.c
@@ -67,9 +67,8 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
         s->info.endian =  BFD_ENDIAN_LITTLE;
     }
 
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-    if (cc->disas_set_info) {
-        cc->disas_set_info(cpu, &s->info);
+    if (cpu->cc->disas_set_info) {
+        cpu->cc->disas_set_info(cpu, &s->info);
     }
 }
 
-- 
2.47.1


