Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF70C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOz4-0005iX-Tt; Fri, 25 Jul 2025 16:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOu2-0007dM-Nv
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOu0-0001EI-Ac
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso3307888b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474823; x=1754079623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uein3BAt/0r6KhDw4Uu8oyUNGF88ULTG7TVz9l6UE94=;
 b=khRbfvQTWswY64Q1GqkrRXu9fc+8JS2x1nNeJUX91nJMNSljlnW0JfGDaz2xxIH9+6
 fcqILY2otHTeKffcMGvSKTKkA2+jImHhq0IpQZ+O5NaJt0/mlG+rDmQ5p1aWIMxO8oVL
 QT8WnDw+B7z9XIDJz8QyvhcfXt3pv8NtqcTGmvAA7OFGK1mK3ZSt2CT+MJnAcI8zmjwu
 OuOZDcUcgje8O0nazBg9oocSZqsO1LjWpJ68hRz+WvXK2UuuxHQ8V8JYc4JRYzfjeNRW
 UTKLUHLZFgkGIkb3ECfbY8DHWLuakXdVxvzth7qWDfQJIykwIK6+4jWAIsvQ2nSY5DRA
 Q6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474823; x=1754079623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uein3BAt/0r6KhDw4Uu8oyUNGF88ULTG7TVz9l6UE94=;
 b=cYSHglctu7+sDrbeGwgHRA9MHYW8hltzstaQhlRa8dL87dzlbUmWYH9CsV8SfPWTJY
 Edh1g6p/GrcXF6OqXeyxwujvZpMVYwCTsG3BqpPg+6jbJ3RIbctstR1/JWpq1ZX1wlsn
 pYEneq6bPN6f66T2GgVrgtiPIRbCxthTOAPZo3rYykj0oiy2gGlAbE001m+xfszRYQIL
 6UJfeOEIvrC1dECvzg9h6UGUuTnrm7qsWDnzvd3DHw6+TTD8WeL0i6QgDo/wQp1Pvued
 InMeB9WGOjMUWfqgZujBG7qai9pmx9s4pPch7c9WB3q80xo/lY9T+vjwHTI/HaabZixg
 UqhQ==
X-Gm-Message-State: AOJu0YwTW9/eEsV3oZZmmFtWETwdZ31/xlGXKPIOf5XZwxCgT8FENV9e
 RZWookMAXkWjqa784vA0EaFbpVTxIhfE5Qqo+4DHrgHl0NBvUv7oLsu4hnQpjs5DtJzPITRz3WW
 BE1bD
X-Gm-Gg: ASbGncuL+QkDavxLqbyI+6n00ns99ajnupzMZiWDmtIY+XFpXAkZLMMU7EZybjW9oFt
 4sPrm7bb0uEtJk3QQH4EWQacn7/RCkDgDhMmsMzjGyk0xFBqcdZSo4VQrfPo6Y/+T7DE3z5DcrL
 7R4t1g+FJ5Y7vCGGhHd87B3LvMwOJKtr+UXD1XE+YwtWtPha7VjRKdm3pxhTzgAgDEJZ3bKnQSj
 5lSH4f4BkyEBRZRWiXUtXwE9l6gz0KVNAja0/QTpgMwveD1mVZMz9tBlEa81WJA0heQx3D8aaPK
 3zcTpsTIBzM+G1+m30b4YP/lsoCpmswpPHOIbreEpOMhw3RewFMe3d9P8z0w0EjZMDWJ+eK1M02
 3+a77sV9rK/WjQnLRovbDareLGBuHKtuR
X-Google-Smtp-Source: AGHT+IEMwUdL5WGM92wUBgg5/ZyJAC6gSIVz7/melNzVeiF1NvCX9/RxUFQBKckzw6LRUgGuta8MOQ==
X-Received: by 2002:a05:6a00:1410:b0:748:34a4:ab13 with SMTP id
 d2e1a72fcca58-76332c46a56mr4910184b3a.6.1753474823028; 
 Fri, 25 Jul 2025 13:20:23 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640882071dsm360925b3a.16.2025.07.25.13.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:20:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/3] cpu-target: build compilation unit once for user/system
Date: Fri, 25 Jul 2025 13:20:14 -0700
Message-ID: <20250725202016.21325-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
References: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build        | 3 ++-
 cpu-target.c       | 5 -----
 target-info-stub.c | 4 ++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 6a471a27dee..d0ae602c2ee 100644
--- a/meson.build
+++ b/meson.build
@@ -3887,7 +3887,8 @@ endif
 
 common_ss.add(files('cpu-common.c'))
 common_ss.add(files('sanitizer.c'))
-specific_ss.add(files('cpu-target.c'))
+user_ss.add(files('cpu-target.c'))
+system_ss.add(files('cpu-target.c'))
 
 subdir('system')
 
diff --git a/cpu-target.c b/cpu-target.c
index 772e35495b8..f030e2c642e 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
@@ -27,10 +26,6 @@
 #include "hw/core/cpu.h"
 #include "trace/trace-root.h"
 
-/* Validate correct placement of CPUArchState. */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
-
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
    CPU loop after each instruction */
 void cpu_single_step(CPUState *cpu, int enabled)
diff --git a/target-info-stub.c b/target-info-stub.c
index ca0caa3686c..d96d8249c1d 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -12,6 +12,10 @@
 #include "hw/boards.h"
 #include "cpu.h"
 
+/* Validate correct placement of CPUArchState. */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
+
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
     .target_arch = SYS_EMU_TARGET__MAX,
-- 
2.47.2


