Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E9AC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 08:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9gh4-0006Bt-As; Tue, 29 Apr 2025 04:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9gh2-0006Bh-UN
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:51:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9gh0-0000Yw-Ae
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:51:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so53512885e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745916711; x=1746521511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yKCscmoOEco5+B+YXBR9ZwtoiYDokiLDPDs4PkzViVE=;
 b=nux5nikdgwLaT9x6qOUlk4idL3FryjaFQNsGoksX+J5LLqxc0V7Ay5vxbc/WsXFg2M
 cv7oKHDXNRumyAC0QQBe0M2KcXR+f/y2pAoG1qIpbu9vXAWz/mMLW6ChM06QkfPHW21y
 p+BLNciBhTYcE7m0rf9nevvl/MmEL/nQtBLmpR5cdQK0bjeA1xfvfzfYOw6Rpqd0BN8B
 9u3jyFzNh7x9aeK85ti4G5hDDlD7mm0hrqSNqCgWOOn1g06sqMaMhCMhTYeyCaNi3VWU
 k5eC3v59OgYMh0ws1qWNLzbFs43zyglvjtb5X/O9YMrKTa5eAlukB4jlQCY8UEeIsZN+
 d58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745916711; x=1746521511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yKCscmoOEco5+B+YXBR9ZwtoiYDokiLDPDs4PkzViVE=;
 b=OluGNwkL/OjShlL5/LSQ3pjbs6Sj+9R94IsbwsRzFTMprVGySnmwyfn7A9HKJ7jRol
 JzRzzP3dx60j7OcDXC8HfJfAjcWn5rqUedJqecFM6hiwl10Bbi0ZM7FS2ccwRQs8LMp5
 HgZ6TW46mrU4s8XHON73snvTjWuPwrgDhiJxB5iny+mDKoDrBAN7KxEEbe1xnXourwTd
 hqI8GVb4ck2MfG62YIA7dO0Z/9Q53tcG3nSGoJs49JUE0gl5/3t0DIWbruZz+xuA8omk
 F45Wfsjv20KXrAqek6D9miZiSk/qpiurKC/fuwRz7UP4CsGybP81Nv44Lf3gpy0BbcNB
 k7uA==
X-Gm-Message-State: AOJu0YzNwJgV326hknBFgaqR1MB2LBTitUlERWd0mwK6ZYBKZ/LekTfG
 8cpovtRnEvbdR29bYdAYXfsHs2xbFR3DbumH35LG9wySCnyCcSJUC1NHigXCIflEnSQ30T3rbT7
 P
X-Gm-Gg: ASbGnctwWSI6y2bLAxOgVU+K5xHhbNzBcMmJba682kMftwVb/r91UW1cmXWYi8oy0Fp
 CTPf5BQCG2tIKbKqb0ojA464iGIsn7tqsr+poTZqEzgKxAhPECUcLjmXKRcoDRe70fr5wEHHeCF
 FOx4CL09RUqmb8jO+LzIXWwRLnlB+PDWu2KlkE6X5rxphCGl1+Iy8WDmLevis3OYrVwzbfSP+p0
 7ksDoXE5hdSDa3NslKB3Onan0TuIFFHtAD9jz7J3p7TFZONwuf+WorNQW/REqJy0fckWKR1I+EN
 07bfOIAcbuEQrKV8A27ldMc8w+jtRgRSub0o80cGrIjeiD4RO8RiNL8rIS7Y21NU7ceXSeADvts
 5b2lWWoeffR/gJoJ92sMjo1XnO+QaLdU=
X-Google-Smtp-Source: AGHT+IFggvULqN+lahlaZ/DmY0pT74tNpxRTe86zlJSTbBcPgx5UuQp5VQw7RAk62eScTdwMQj3ffA==
X-Received: by 2002:a05:600c:1d9b:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-441ac85cf5bmr28893445e9.15.1745916710833; 
 Tue, 29 Apr 2025 01:51:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2d8154sm180253175e9.30.2025.04.29.01.51.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 01:51:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/migration: Inline VMSTATE_CPU()
Date: Tue, 29 Apr 2025 10:51:48 +0200
Message-ID: <20250429085148.11876-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

VMSTATE_CPU() is only used in 4 places and doesn't provide
much, directly inline it using VMSTATE_STRUCT().

This removes the last COMPILING_PER_TARGET in "hw/core/cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h       | 12 ------------
 target/alpha/machine.c      |  2 +-
 target/hppa/machine.c       |  2 +-
 target/microblaze/machine.c |  2 +-
 target/openrisc/machine.c   |  2 +-
 5 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 12b2ff1f7d2..1e87f7d393e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1121,20 +1121,8 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
-#ifdef COMPILING_PER_TARGET
-
 extern const VMStateDescription vmstate_cpu_common;
 
-#define VMSTATE_CPU() {                                                     \
-    .name = "parent_obj",                                                   \
-    .size = sizeof(CPUState),                                               \
-    .vmsd = &vmstate_cpu_common,                                            \
-    .flags = VMS_STRUCT,                                                    \
-    .offset = 0,                                                            \
-}
-
-#endif /* COMPILING_PER_TARGET */
-
 #define UNASSIGNED_CPU_INDEX -1
 #define UNASSIGNED_CLUSTER_INDEX -1
 
diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index f09834f635d..5f302b166da 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -74,7 +74,7 @@ static const VMStateDescription vmstate_env = {
 };
 
 static const VMStateField vmstate_cpu_fields[] = {
-    VMSTATE_CPU(),
+    VMSTATE_STRUCT(parent_obj, AlphaCPU, 0, vmstate_cpu_common, CPUState),
     VMSTATE_STRUCT(env, AlphaCPU, 1, vmstate_env, CPUAlphaState),
     VMSTATE_END_OF_LIST()
 };
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index bb47a2e689f..13e555151a6 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -216,7 +216,7 @@ static const VMStateDescription vmstate_env = {
 };
 
 static const VMStateField vmstate_cpu_fields[] = {
-    VMSTATE_CPU(),
+    VMSTATE_STRUCT(parent_obj, HPPACPU, 0, vmstate_cpu_common, CPUState),
     VMSTATE_STRUCT(env, HPPACPU, 1, vmstate_env, CPUHPPAState),
     VMSTATE_END_OF_LIST()
 };
diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index 51705e4f5c9..a4cf38dc891 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -93,7 +93,7 @@ static const VMStateDescription vmstate_env = {
 };
 
 static const VMStateField vmstate_cpu_fields[] = {
-    VMSTATE_CPU(),
+    VMSTATE_STRUCT(parent_obj, MicroBlazeCPU, 0, vmstate_cpu_common, CPUState),
     VMSTATE_STRUCT(env, MicroBlazeCPU, 1, vmstate_env, CPUMBState),
     VMSTATE_END_OF_LIST()
 };
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 3574e571cb2..081c706d02c 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -136,7 +136,7 @@ const VMStateDescription vmstate_openrisc_cpu = {
     .minimum_version_id = 1,
     .post_load = cpu_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_CPU(),
+        VMSTATE_STRUCT(parent_obj, OpenRISCCPU, 0, vmstate_cpu_common, CPUState),
         VMSTATE_STRUCT(env, OpenRISCCPU, 1, vmstate_env, CPUOpenRISCState),
         VMSTATE_END_OF_LIST()
     }
-- 
2.47.1


