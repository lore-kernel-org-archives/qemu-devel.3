Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B6F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHwK-0001J2-C8; Fri, 10 Apr 2026 15:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwB-00016Z-V7
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwA-0001aZ-80
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d23305225so1667229f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850878; x=1776455678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ5l/yASQ24ZYUVrEW0W1fOfIxn1pYjbKa7VNjc5dpE=;
 b=TxmTe6/UYCq9VPOZRRjhbAtXi5iamWZtPB5x07RlqrB9UFtuAXwCupkL/MtmofcLSj
 L6Sct+Vi+1kYmkAaXX9CvvUalEGf0Z5wivBKl8IdWdDFT/sLIKNpvaSqOyOgOUqVuyP9
 CLHUgQL7lh03SEPqghcaqOuvzAnOoXq1lB4va9l1lgZZdm9/GYbQX6zDsBad1nwuGKi1
 c41GKBKCEQqvx0IQYb3uiA6bxw7/RQ2RNyASFtqOIaf+R7xyDnaV1MWGIWQJWeN0m574
 bo19GhCFkPLMOHUta+eIg+BkaOSybnhFfRvJwsqt30Y6L5yLfNdXByr12JWgBl8sNBp+
 /TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850878; x=1776455678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NZ5l/yASQ24ZYUVrEW0W1fOfIxn1pYjbKa7VNjc5dpE=;
 b=EtC51/AolYsdCyX5aDBMVdMn36YkoCPCDAhMjyHgNiU3MNRJi3rTbTMElCIITy1u1Q
 g/fIBhTazEBoVYzwTRYNxpkKQ0s9L9EHCb3B6/vtm75wGArX5vRFsc7J4l4fMafmtYiM
 oJ7hOg7N3zb5SvjziY2MPL8vYcr9cU06GuGN8qFZNaEYZqRGIZy7GXI4mr2BZkv7LX2Z
 dDhbSBy7ZVf2YypACgWqNbC9ZWJ2BBQVpScmR8hvhbxQ29AxrRTYmImV77BKgELh8e24
 Wbfvv/5lQyzR9RGsrUyPgGpKBUnBRgflpeYc2OvkBdcGGjxuy5+Dio4EyIPDEchhoy4x
 MWSw==
X-Gm-Message-State: AOJu0YxvwXMwih3wB2NOMTZ5RjgrProEshx1Od1EP52BdVRbKiMGjsAV
 rn1wPxxPv7s1s0X34tWRjrNUxprs5iFBl2msFMpGsaGgZ3pMPM+2laIsyrLg8NvlT2/JJjJd98O
 JwFZxEMA=
X-Gm-Gg: AeBDieuZ1edtGySxIp1HIb4E1FS5rtoX2dUA3t8/pPk/pBo81TwMoI+p1eQQrmD3Ol5
 jOVEfjFxvDEjLtETjsQVHcTuRRrz9G4FfnvEqhLFURxFO+z4tyaznc0Z7HqgQGEDnsU3cCAZjrT
 RvXvn3BBy5BUyP7VKWmrjZZk1G5KuySGcU/75OPHM2Em6x2RJ+97rvrUKeG+m2KLxwIAWgXCdi4
 mYLiwY1mQ7R5K8Kv1H6tMdKG4w+aUAwZnl5kWpS35xcyaj0o6Cr4WRdmF3/9uSvXI4pKhA9eRfk
 lm2xHx5z7AdBWadXoENHenydnBtga7dhZ9xhUMutyVH+LX/LeRaK2NU3Qmd0ZT4xZoT+2LWFmG0
 8ktGW6FyDQBe2c6qJP/zxgspmLyjw5AQAvRRJBU8kINWSUVXAdICq/IBFtrlkv3Z/uTnJA255Dx
 VA+O4OZ9wroUFFrEVf2sQ1iCQVGqHKrMIZoaBHIojdlN2pLYrc5Uf1yqer3sucyE2zcEl9BBLM
X-Received: by 2002:a5d:64c7:0:b0:43d:500a:1e5b with SMTP id
 ffacd0b85a97d-43d642da9e2mr7199206f8f.27.1775850878373; 
 Fri, 10 Apr 2026 12:54:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2a48sm10271471f8f.7.2026.04.10.12.54.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:54:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/27] monitor: Remove target_monitor_defs()
Date: Fri, 10 Apr 2026 21:53:04 +0200
Message-ID: <20260410195323.17937-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 include/monitor/hmp.h       | 1 -
 monitor/hmp.c               | 2 +-
 stubs/target-monitor-defs.c | 7 -------
 stubs/meson.build           | 1 -
 4 files changed, 1 insertion(+), 10 deletions(-)
 delete mode 100644 stubs/target-monitor-defs.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 516089eb5c6..cabb2c55f8e 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -23,7 +23,6 @@ struct MonitorDef {
     int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
 };
 
-const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
 
 CPUArchState *mon_get_cpu_env(Monitor *mon);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 6cf2f3e65ff..3d812ea3068 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1613,7 +1613,7 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
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
index 7189ff63ed5..10eb68ab55e 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -75,7 +75,6 @@ if have_system
   endif
   stub_ss.add(files('kvm.c'))
   stub_ss.add(files('target-get-monitor-def.c'))
-  stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('monitor-arm-gic.c'))
-- 
2.53.0


