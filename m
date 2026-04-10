Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8427F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHwM-0001XH-CW; Fri, 10 Apr 2026 15:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwI-0001BW-2X
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwF-0001dL-Kx
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso28951115e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850886; x=1776455686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5TS34D7gzjspZxEtF9wQrQfCaZf1oD4hCg5mbcwpKM=;
 b=D4cVZwWg5G6vikaYtnqJ0velvbp665UIoB5AuV8a+MVz2g7VFRsf1hUgVkbc94Mcl2
 1wpevKHk9VpZ/FJrZV8HPskaNRk1ZEuR/MP5NTtAxaAkM0ey74oCyJorQ97pjlyXNLwJ
 f7xOKnMuBn/mdLg53gO2ipdu309UupGlO9cYGs3Deck6Hx99JcIOuuBkkBRziqP1Bhnb
 04jSYZYAVRm/oKsR6iO0QYf0I+Zmp08gf0YflPNKC9Mk1PSebWBJvsXBN0Iuf5vPv1+G
 HPdExj5nuhG7x3adFADM/OYvPG7edQi3KJsEtH+1wk65qqs1XOkqOsD5a/LA/pV8xsSj
 8wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850886; x=1776455686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m5TS34D7gzjspZxEtF9wQrQfCaZf1oD4hCg5mbcwpKM=;
 b=QPxPzIs+srql0aLSRh7ukE8lOwAtm7eWozdV8q5c1cB0pr5aCfreGiqtTxIPCAEPlJ
 KbjqG97WhO+Fu/G4e/mTeBvr58d1/g9uUqSMrzgTQEA0r8S9z8ucP7qZ6gFmwLEVyVuU
 e+kgxjgUl2P6GNDFkfs174iselaevxKuEQyOLDPNsYs8ODWM7T8Wq2GKfGkPdI6J5s+T
 l6NGBxZD0NtTtIge0lgQgdxP1oDmSVljr4H6cbJDrxS/GdbFQbqxwGUNQpocQ8uweyaX
 uk9YJ4kMqazm1GBRSBONELbVEttCGk4fkScdTkRnNFDnXE70y0hiXP2UviEca/9LeUUQ
 oy4A==
X-Gm-Message-State: AOJu0YxdQCjatj1A20qMnQsIIi89mHVpbwPTGbp+ore4lbNcjK8KzIo2
 EPfwsWZhWIHtTafKVWL/RpRKNGfYO2Z/2S+mNC7+Tnjca2PhAo3SFYpePl9IQDd31MeHSzGhcGY
 sj6wOSgw=
X-Gm-Gg: AeBDies8T1phBUAZJpAB6D9YixU9WlS1uKQ4yPnBApQHGOKldu5M0AVDm4lKUQqb4Kk
 eRrmftfKNRBMg4Dc9YWMGJDdM063+41wX9217wDzB0jwmzVRx9DIZ/wJsoWdmOEZ53dIiSy7pqD
 MuZ8R7QAXG9BohwcFwXkGC3SL5V5ZIn/3Iz35o0GJYUorBoriCB3TyC+0t/t+fhRdBknxb04Bbe
 +JFoSFWfia8ZvbUMblEhQAcBmZR82G8WIXN5sVNGcvL01hxbOa3lPSfUPyxyiKPfJjADvYCqnpm
 /ZNmB4ZFYlfRquUGmvUabr2t2zxvkaXi+lOYM0uxyunH72CQQM1OOoucDAvdVB4ky+eKdYqHgWj
 CeBE5fx0bhNrBQ002ugMvmvUkDtV5ifjhXPJPtynfvvJuAxftaV43T5lrD+Qgis5O3MeNsFN+53
 28rplaScmBH2c9QREr0DV4H+Pw0Bj+i3GRNAJnEFcmO+f8yNqiFe8SPH1Nd23+j9mW5y1KIGxu
X-Received: by 2002:a05:600c:3ba4:b0:488:c6e9:1e0c with SMTP id
 5b1f17b1804b1-488d6847de9mr53887245e9.5.1775850885735; 
 Fri, 10 Apr 2026 12:54:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d533e596sm100071985e9.6.2026.04.10.12.54.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:54:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/27] cpus: Introduce SysemuCPUOps::monitor_get_register()
 hook
Date: Fri, 10 Apr 2026 21:53:05 +0200
Message-ID: <20260410195323.17937-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
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

Allow targets to register their legacy target_get_monitor_def()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 8 ++++++++
 monitor/hmp.c                    | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index a96f4907d05..a9200ec5737 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -85,11 +85,19 @@ typedef struct SysemuCPUOps {
      */
     bool (*internal_is_big_endian)(CPUState *cpu);
 
+    /**
+     * @monitor_get_register: Callback to fill @pval with register @name.
+     *                        This field is legacy, use @gdb_core_xml_file
+     *                        to dump registers instead.
+     */
+    int (*monitor_get_register)(CPUState *cs, const char *name, uint64_t *pval);
+
     /**
      * @monitor_defs: Array of MonitorDef entries. This field is legacy,
      *                use @gdb_core_xml_file to dump registers instead.
      */
     const MonitorDef *monitor_defs;
+
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 3d812ea3068..799855f3f68 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1632,7 +1632,11 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    ret = target_get_monitor_def(cs, name, &tmp);
+    if (cs->cc->sysemu_ops->monitor_get_register) {
+        ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, &tmp);
+    } else {
+        ret = target_get_monitor_def(cs, name, &tmp);
+    }
     if (!ret) {
         *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
     }
-- 
2.53.0


