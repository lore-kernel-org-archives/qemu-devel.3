Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D029F531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRig-0001g4-Rp; Mon, 13 Apr 2026 20:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRiQ-0001LF-EH
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:33:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRiO-0003fX-9Z
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:33:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso77677175e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126794; x=1776731594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3CzJ/A2GgXwvTiMHFqbROF6u1z+P+1ZUB0NG8W5jSE=;
 b=Id3w+UM1IA3FDiT5BFRyYlhyNrnGFKZjchfQ0dLgKGlrnRRnOCN6ZhZjBeAa9BLuuW
 jROLwqyVFHgVI68sb1fnUBKsMlUgbVmSbYFqESKlnkQVoriWiBu1Wq5/3nqYG3gUjyLY
 y6bzzicDSdU+hPluflskSaz8fsLtXFXGZmy7LC1oiK7qscWaJ5wYXJXJJZoS9MdBp9eI
 kJw2KqXg/iRhYLRJfKE4yhF+PQHxLPJsql0DsuAvpsQEM/XnCnXQBrbcXChEH1CSlzju
 6HMjMTNWgoFDlJczN6IZ5DcM2isJ8wywGWEzoAkBSgjoftv5E6BOJpc6zuXjyiLSKBgx
 I4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126794; x=1776731594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u3CzJ/A2GgXwvTiMHFqbROF6u1z+P+1ZUB0NG8W5jSE=;
 b=NCC0DJL0Jyn6K8yuX7Z2jAcbevpGoJ6Xcp8mk0IFTiwAe8gS+D2rPYm01/pm/jiaQh
 dSMKOm9vRgu9GKBzt4NHuaxSagCcIG3PkvgREBM56eGKCdnB3F3jr6fmSqdcfrhXdI4D
 GGluOs3Bj8dV2Z6haw2L+iuWPzGp8kQINiUHDPIxvtKX3imLJv6Z86uQRQLbsqWSGnQm
 GjLuNCzjJqWdGLrLS0S5HlwmgAJuv2/S7bMqoMptmnCYQVKjaylEyjflD4USK8OPuU3s
 n09TLmA5PeSu5bz5El00F2MXJfpX3w9Omog7/jdiONX8StsKF8h+hxh8qnLC5JcUpSJj
 +3TQ==
X-Gm-Message-State: AOJu0YzA7VmP8Rj+Fxhr71FWCdpGv6+kELRKYreWKclRZ8UKfReq6x7T
 1zYPGRj914BFANJuaJc3mlr79GAHuatlHtl8VWsGRHb5B935NnDRJAjpnQx0/q5zcaqZHjW/Hqh
 SZO+Hbck=
X-Gm-Gg: AeBDiesu0NZkXLIOxQshOYwjR8wdSzNW1Ti+3z2eHU4FinPVvB9Gg3JHfGiphzK3Vx2
 LC5mkEQpsx34qM1tzV0olY4nZFy8e+fCqe3/C2GkpaKOt3g2vtQdEMDwsETcbLgQp60EvmTDnmU
 gyWFwECy/hNXbtWU2XbGp0yfuC6WFbw/U/4hLfLOK1sr5Zn6J3UnK6hCK8sIeJz1LsmYj5SH4rr
 e+vne7m0bac96OJd4R8nFGDyC8O7psKWa2ocLLjPhvOy/hgK2vhe+1p4iPPT6XlHMtcbZqpmVzn
 tvjIApTZLokNKYVli93MlSzAvrhulQSZcrPHhB5GTZAIme12XlhEnnEFJGBbbKjqYWRsfM7IwSv
 ZCGdBEbCCOeqGfQ4DqROjQ+dgcYfWWXIBCdXeUmM6Il3UEzBRgWEEG+BVvTviWne4EtaK0epQqX
 iLUHjzqXO64jBrpUwG7CBxISkmCig1dZzW2zvAzQ6JEnomifrbsCUh4I8AxNlDMp6TpeFZGS2Z
X-Received: by 2002:a5d:5d0b:0:b0:43d:70e5:bfa9 with SMTP id
 ffacd0b85a97d-43d70e5c016mr11703055f8f.48.1776126794571; 
 Mon, 13 Apr 2026 17:33:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50200sm37149928f8f.29.2026.04.13.17.33.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:33:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 26/27] monitor: Remove target_monitor_defs()
Date: Tue, 14 Apr 2026 02:29:58 +0200
Message-ID: <20260414003001.97571-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
index 2bf376e15e3..3c6d0032e93 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -74,7 +74,6 @@ if have_system
     stub_ss.add(files('igvm.c'))
   endif
   stub_ss.add(files('kvm.c'))
-  stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('qmp-arm-gic.c'))
-- 
2.53.0


