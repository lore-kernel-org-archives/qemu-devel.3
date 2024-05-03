Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461C9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s8n-0007bw-0W; Fri, 03 May 2024 08:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s8E-0007Fp-Bf
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s8A-00030F-AA
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41bca450fa3so48323325e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739712; x=1715344512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tc6dayl5tulhCDU0tgAOjnRfAOhbRHX4YnefxEFrhW4=;
 b=MsI97ceGgamI3T8MQhU3M/m5VRsbHKtX2ONfnoWq8ADdjTGD+CaMGFCaVZGPyh+HPS
 USkTm8jJH7QIwGqIxAvTN+ZsaUFB9/txnD6LR4LdhgOUjouR4TPvfgb61ES7JYNTEJZ8
 V0XWWRiT9DF4FKiy1zeXBYJ7Pw/tba56VlhQs4iPrF0d7Rph8VQWFdDSB6TBG8BT0Yv7
 gAHGjZSfbtOGVyxJwBTWANeXqwMQcu2syVmbBbbxb4UtXHFO2gU0rv50+FY8POmeCbcu
 YgFAhhWCWBYgK1F5t1tB89qWBRMG64CKX/22bJvXwOoxH+juiIrwVyomfd86mRrpiRsK
 1fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739712; x=1715344512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tc6dayl5tulhCDU0tgAOjnRfAOhbRHX4YnefxEFrhW4=;
 b=H9BFaHHlqrY5JK0/9V3IPeZZ0BBkEl9mWSwdgsTHrA6AvaC5EsQF2ewZlU3IDx76W7
 HjamoK1o/nqhowvy/iPIxpHvjsdyfcBjwRYqFh7p12o72fDa4MUf5iRxkr0TUkMJpXXl
 8P+7WJ+qcBoqOsNoxO6I6kiOrvgcjluRCZr+pfVpVJX488MWLhXhI5b8y05m0UOrW1So
 Bxy4G3Hst74ooEgrIKmeRQahNYI55Nj6wt0M8HbLLdLJHsUuzDcltLNbJmvUNfvdTuZA
 a/upHAqKQAq4XHCBXwrnfmJjcLJszN4NyJwGrd7h79zcK5tIct7hz3kw5AGdftG67MIl
 MvhA==
X-Gm-Message-State: AOJu0YzklUFOPyjiYp1ngbt0yIobOWDnEetJ4QAAW5HNhspNfxru4N3v
 L/4oN2cLwYmKzJmpa4g34CL/MvcGDq1r6KDF34siY42w3v78Q0HbrfHw40JVayR7lT2OBplnGBF
 D
X-Google-Smtp-Source: AGHT+IFL8w7N4nqikQUgNMKqvrgUvrAY7TD0j5uoOjkVIPyD8zvDmejuYwYfnn6tvqBxEMK6rr2tJA==
X-Received: by 2002:a05:600c:46cb:b0:41b:d08d:dce4 with SMTP id
 q11-20020a05600c46cb00b0041bd08ddce4mr1919892wmo.5.1714739712282; 
 Fri, 03 May 2024 05:35:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a05600c4e9400b0041b5500e438sm5504276wmq.23.2024.05.03.05.35.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:35:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/5] accel/tcg: Move system emulation files under sysemu/
 subdirectory
Date: Fri,  3 May 2024 14:34:53 +0200
Message-ID: <20240503123456.28866-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503123456.28866-1-philmd@linaro.org>
References: <20240503123456.28866-1-philmd@linaro.org>
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

Some files are specific to system emulation. Move them under
their own sysemu/ directory. This might help to notice what
is affected (user, system or both) when doing global refactors.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.h        |  0
 accel/tcg/{ => sysemu}/icount-common.c        |  0
 accel/tcg/{ => sysemu}/monitor.c              |  4 ++--
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.c        |  0
 accel/tcg/meson.build                         | 12 ------------
 accel/tcg/sysemu/meson.build                  | 11 +++++++++++
 12 files changed, 13 insertions(+), 14 deletions(-)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.h (100%)
 rename accel/tcg/{ => sysemu}/icount-common.c (100%)
 rename accel/tcg/{ => sysemu}/monitor.c (99%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.c (100%)
 create mode 100644 accel/tcg/sysemu/meson.build

diff --git a/accel/tcg/tcg-accel-ops-icount.h b/accel/tcg/sysemu/tcg-accel-ops-icount.h
similarity index 100%
rename from accel/tcg/tcg-accel-ops-icount.h
rename to accel/tcg/sysemu/tcg-accel-ops-icount.h
diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/sysemu/tcg-accel-ops-mttcg.h
similarity index 100%
rename from accel/tcg/tcg-accel-ops-mttcg.h
rename to accel/tcg/sysemu/tcg-accel-ops-mttcg.h
diff --git a/accel/tcg/tcg-accel-ops-rr.h b/accel/tcg/sysemu/tcg-accel-ops-rr.h
similarity index 100%
rename from accel/tcg/tcg-accel-ops-rr.h
rename to accel/tcg/sysemu/tcg-accel-ops-rr.h
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/sysemu/tcg-accel-ops.h
similarity index 100%
rename from accel/tcg/tcg-accel-ops.h
rename to accel/tcg/sysemu/tcg-accel-ops.h
diff --git a/accel/tcg/icount-common.c b/accel/tcg/sysemu/icount-common.c
similarity index 100%
rename from accel/tcg/icount-common.c
rename to accel/tcg/sysemu/icount-common.c
diff --git a/accel/tcg/monitor.c b/accel/tcg/sysemu/monitor.c
similarity index 99%
rename from accel/tcg/monitor.c
rename to accel/tcg/sysemu/monitor.c
index 093efe9714..620c18d267 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/sysemu/monitor.c
@@ -17,8 +17,8 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
-#include "internal-common.h"
-#include "tb-context.h"
+#include "../internal-common.h"
+#include "../tb-context.h"
 
 
 static void dump_drift_info(GString *buf)
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/sysemu/tcg-accel-ops-icount.c
similarity index 100%
rename from accel/tcg/tcg-accel-ops-icount.c
rename to accel/tcg/sysemu/tcg-accel-ops-icount.c
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/sysemu/tcg-accel-ops-mttcg.c
similarity index 100%
rename from accel/tcg/tcg-accel-ops-mttcg.c
rename to accel/tcg/sysemu/tcg-accel-ops-mttcg.c
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/sysemu/tcg-accel-ops-rr.c
similarity index 100%
rename from accel/tcg/tcg-accel-ops-rr.c
rename to accel/tcg/sysemu/tcg-accel-ops-rr.c
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/sysemu/tcg-accel-ops.c
similarity index 100%
rename from accel/tcg/tcg-accel-ops.c
rename to accel/tcg/sysemu/tcg-accel-ops.c
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 84826f043a..3539b0b799 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -24,16 +24,4 @@ softmmu_specific_ss.add(files(
 ))
 tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: softmmu_specific_ss)
 
-system_ss.add(when: ['CONFIG_TCG'], if_true: files(
-  'icount-common.c',
-  'monitor.c',
-))
-
-tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
-  'tcg-accel-ops.c',
-  'tcg-accel-ops-mttcg.c',
-  'tcg-accel-ops-icount.c',
-  'tcg-accel-ops-rr.c',
-))
-
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
diff --git a/accel/tcg/sysemu/meson.build b/accel/tcg/sysemu/meson.build
new file mode 100644
index 0000000000..5a97cabe7b
--- /dev/null
+++ b/accel/tcg/sysemu/meson.build
@@ -0,0 +1,11 @@
+system_ss.add(when: ['CONFIG_TCG'], if_true: files(
+  'icount-common.c',
+  'monitor.c',
+))
+
+tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
+  'tcg-accel-ops.c',
+  'tcg-accel-ops-mttcg.c',
+  'tcg-accel-ops-icount.c',
+  'tcg-accel-ops-rr.c',
+))
-- 
2.41.0


