Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE143FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH3g-0001Q3-H9; Mon, 27 Apr 2026 04:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3d-00011g-Rw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:11:10 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3b-0002qd-Hn
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:11:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so5444920f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277466; x=1777882266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5jsZtofjbXJHOZasZf01XJnCpN2qoJicQAKP7JiukTk=;
 b=ysV6eUVLlBSRJ7N3sg1r3YEsa49oaJCQqymSJHs6DwYLc0V54qPfiNBiDMvXlsSkz5
 CVziqpOtGQU3p7XMG9nyymv6sUu1ZfQSEoAwctE/RdtXXPYiyCSScQDsgFRdYcMkdNzs
 OI0MQSW1UrGEY0DwyBEVIwkAONdFl55nSSj/Uyipeou12MPbkdyb8eKjT2e1TSZjhmKy
 wy1DfWFGKKojqBvcoz8TXOB4OQXuqb6h9uWdiJ9MGcb0ls2Cm8+MI/FnyJy7G/ZEUcLu
 He4EupYNKeAEtxCwAXgzaVb7h9CCTqsER4AfmrIlZ7Hc0zVZRgg+8yCVJC9/CUAJBUCx
 nZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277466; x=1777882266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5jsZtofjbXJHOZasZf01XJnCpN2qoJicQAKP7JiukTk=;
 b=bCOqZ2iwLp3cTYcUMZNHWTYCGKkNO1mAaUWijZzhaZScgRNM9JjPyaxrmvzomipRDE
 4/U00Qyx6Xj4cdiblz9EFZ1uY5F43CJJlUyPcky1Ulrw6atw+z4PI+BxFCB4XBZy+TVf
 Ms5OQM6YY4c46i5HFu7679BlExBrTHNMp8j873UGlI2FrB1hOh1CXNMOyZIqyP5FJisT
 EFzBvJyPFWxRyWrANaZJC+Ud1TVIJalb9nI2LWaw/flgIjWS56y07L6bhw1X4ZIcQeNm
 5wAEFlzeNU0Ao/uNPqJMaYDHO4ieSR2TErNqadZfOrv8KVcPFnhevJqMiwskoz+erM9f
 To1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YF8iH0mZabf4fAZrnOUa476Pt5XgTYAALilnI31VTnfxGX/9mF+U8If3Vu1IPi/si/V2q29UdLUGo@nongnu.org
X-Gm-Message-State: AOJu0YzTYp6QEuokwqhckK/j2majDFo5ZFvDER4T82e76TS8YEmu7YIj
 zGj3YbVNrzVrqqnfxMzpEfnSb4RVxkdFlIt8Hy/9SUFPnhRpi2wDfWBFuuF9gjh1tnn6ZQq2UZg
 7M4OQiLA=
X-Gm-Gg: AeBDieu/Nxv96KEhSiuR30AMRNEPTy9qvFUhQGgRurguJzd4vh2NM4Bq/+OJknIGvo8
 FDNaazu1kmsKvl878c+4WfRCACxO4CQvptEIDBMw+1ysa99KOmud+PbA91GmoT4d5IU7g4mWi2O
 BZtxYQgcyuN9wTvsDv0tKpbGZ4VZ8VcKTNt+TJ476uTgoLZyZgcuCuTmI0nOS+JsO5vwIX9uh5N
 YjtCHXx5jDK9x2O17qQWr9CP1GrxZ/HGjbIsOEPIQjxmaQy94pAa5mHsNB2O/BvyrgJv4w7cG3+
 PN+26y3Bk1C+nTN8/CHe8hTyXGoblHfmYGhDOJleFpyQNniSlONd4rGPLaAfgOAOlm8XPVq5mWc
 EWVJ7Cr48cMtem33zCGYB/eIsOLqIF94cUz6IOEj96J4uQq1aqz9/IHwZcKLr3TYb76YjkPphjm
 yIMVi1cnqVhwg+ourdX9K/GckCJdo2ZQlC4HtDPgmRtPECQInuJWioK1jxS8KWrg5oDJleSTdbA
 u0o+/s4NnNsWbadLZJKlQ==
X-Received: by 2002:a5d:64e4:0:b0:43e:a69b:d810 with SMTP id
 ffacd0b85a97d-43fe3e0fe56mr64744060f8f.38.1777277465488; 
 Mon, 27 Apr 2026 01:11:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm38922744f8f.15.2026.04.27.01.11.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:11:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 30/32] monitor: Remove target_monitor_defs()
Date: Mon, 27 Apr 2026 10:07:36 +0200
Message-ID: <20260427080738.77138-31-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

target_monitor_defs() is now only a dead stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/monitor/hmp.h       | 2 --
 monitor/hmp.c               | 2 +-
 stubs/target-monitor-defs.c | 7 -------
 stubs/meson.build           | 1 -
 4 files changed, 1 insertion(+), 11 deletions(-)
 delete mode 100644 stubs/target-monitor-defs.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 22784bd4c79..c8ce8579424 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -30,8 +30,6 @@ struct MonitorDef {
     int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
 };
 
-const MonitorDef *target_monitor_defs(void);
-
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 70e5e5c2367..6d0f5b251b9 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1615,7 +1615,7 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     if (cs == NULL) {
         return -1;
     }
-    md = cs->cc->sysemu_ops->monitor_defs ?: target_monitor_defs();
+    md = cs->cc->sysemu_ops->monitor_defs;
     if (md == NULL) {
         return -1;
     }
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
deleted file mode 100644
index 0dd4cdb34f6..00000000000
--- a/stubs/target-monitor-defs.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include "qemu/osdep.h"
-#include "monitor/hmp.h"
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return NULL;
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index 3489b1f20dd..3b2f2680b19 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -75,7 +75,6 @@ if have_system
     stub_ss.add(files('igvm.c'))
   endif
   stub_ss.add(files('kvm.c'))
-  stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('qmp-arm-gic.c'))
-- 
2.53.0


