Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949ACF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHv8-0008T1-97; Fri, 10 Apr 2026 15:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHv6-0008Rt-DX
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:53:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHv4-0000Sv-Oe
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:53:36 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so1524423f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850813; x=1776455613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgSDBpX5CLw08pNI+SPMIuoznTVCeN74IG0qPtzmxwM=;
 b=UWTA0ZCwd6DkBI7Zcydv37n/mKXNdg2B1rN/GlFMe7RfqsegtD3T1BeoVP+Jp0/Btj
 oCKybYrkdpcXq/zvXJIDRMm6Ydz7zZbwHU5vz0WuPPDlFgB8fi63uRgosx1kTcFqTclO
 Lua5hoSiF9WsmN3Nr+sfm7o/TFGiTUtzE+t9r0UUhvy860OrwPfB2HfPlH7brYznlH+m
 zflt0RQ+vlm7gbb3V7jBoMtaHN/3VwVeK9kht/4y2o94HwCH7jnNUc8DD6vY6kuVai5e
 WG4Yhwdc0iTDkZW3ItMv117AA5zTF5iJje8oeyXCGshVR9KKq9HaOVb5USQOvapzifTz
 NLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850813; x=1776455613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vgSDBpX5CLw08pNI+SPMIuoznTVCeN74IG0qPtzmxwM=;
 b=BNRth/7aBprNuEY+cUSbxJMe2JpjgtdughfZaknn1/wFUD1C959uNu/muFiZnxWl1y
 G+zwgSMGVtF1HpDzX4AdVa61CV6T78s9sz+ERrbL+wna105ayduo2//wlWXxb176p5Hb
 KnjKXzg2es1EAmaOnVohWEor1EpPRnLJeZbFCTY5fc3Ti/LB8nywj8SfOgNaZE5lxjFz
 XnW4bwFpNjGDpc+PsZM5bB2LGLhXbpO8Bgw2tH035aNqCACmlqlD1klfRZ6uybDQZvkS
 alfqZZAizVyW04AwruQn1l7mlGgh1HmkmGPiQLxgz8ti3XXzro9PCW5nAOaix3n/Zp7+
 nYnQ==
X-Gm-Message-State: AOJu0Yx7PB/F5gog+1gthmXHAc2R+997fBeoz8dgWmRlPMlYjpZp0H2i
 68x5V507m3CP4MsyYR9Etb1/glKFe8vHOzxn6tjpcsgpR2PAe/FazjLgG5DeDiPJ542wDVwcHNT
 GOFGGz4E=
X-Gm-Gg: AeBDieuI49eo0CGczHh0Xe/h/pdx8PPrNwmedm4b1wR1XLFYozfL4pNJR0JQhiTWVqZ
 k+b/uzZytmsQL5sS6EUoelw1141K2wFFvXWh0oaMRwHBR/NlgZUuGJuX1DQsfmKx9yvilB/VW7t
 7xemt88nBhsAVzDnqCsKfZe8VGVG4WHhk0GjqTDpX0XoXnqFaLOzNfEiyNW8wVlphG06ugwW5o/
 hiOIyk+Lmggapk/rY5NXCRkSQqrZnQscvshb58spWePLACSfiaObC1AiGTrGTlSIZGID9qgFGiJ
 ov1MbeSbE4EKPfylE89fff1jmR2BEVyzDdzlYfdrkaL0rtEgngKeaV4evnvyvLIb/E8506TPEH5
 DCJ+2MTUSqnKcB/hqFG6TJw8Jahx6ZjTPsxV+HYSsLEYDc8BMo6R7zdaRrbm2MtdRiZJKE8ar63
 FhXQcOVXEJoqpgWwGXs2f+bvtJsu13rXCpcQ78+TcXdjPGDHldn5jvWUAXJ1p8UlvKW9mT6WxV
X-Received: by 2002:a05:6000:420b:b0:43c:fd18:a30e with SMTP id
 ffacd0b85a97d-43d642b4653mr6664483f8f.35.1775850812787; 
 Fri, 10 Apr 2026 12:53:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63deba9esm10266885f8f.10.2026.04.10.12.53.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:53:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 01/27] monitor: Have MonitorDef::get_value() always return
 int64_t type
Date: Fri, 10 Apr 2026 21:52:55 +0200
Message-ID: <20260410195323.17937-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Simplify MonitorDef::get_value() handler by having it always
return a int64_t type. Truncate to 32-bit in the single caller.

Note, this handler is only implemented once for the x86 targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h | 6 +-----
 monitor/hmp-target.c         | 4 +++-
 target/i386/monitor.c        | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index ce0bb1983cc..6364c94edf8 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -27,15 +27,11 @@
 
 typedef struct MonitorDef MonitorDef;
 
-#ifdef COMPILING_PER_TARGET
-#include "exec/target_long.h"
 struct MonitorDef {
     const char *name;
     int offset;
-    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
-                             int val);
+    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
 };
-#endif
 
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index da7dd7f31f2..812714ada01 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -79,7 +80,8 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     for(; md->name != NULL; md++) {
         if (hmp_compare_cmd(name, md->name)) {
             if (md->get_value) {
-                *pval = md->get_value(mon, md, md->offset);
+                int64_t val = md->get_value(mon, md, md->offset);
+                *pval = target_long_bits() == 32 ? (int32_t)val : val;
             } else {
                 CPUArchState *env = mon_get_cpu_env(mon);
                 ptr = (uint8_t *)env + md->offset;
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 977f65fe16c..b128334e571 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -593,8 +593,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     }
 }
 
-static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                                  int val)
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int offset)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     return env->eip + env->segs[R_CS].base;
-- 
2.53.0


