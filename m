Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C363CA5FF6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhn3r-00080b-O2; Mon, 19 Jan 2026 06:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3q-0007v3-60
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:42 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn3o-0006ca-Dx
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:04:41 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so16752195e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768820678; x=1769425478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31vcExfhyxITyDpAatH4IsbdJjBgBKYHjZYCzAjc2Rk=;
 b=reWORSN56g0T0sRIIYYu/8tyV7tCxnz0RnTUm+2RVe4alT/fbT+dqc2AFNkydWam/G
 MOk/u1CWrwMEYOYWBBL0l0K3sWvqyRM+8m4aGZ83hD3rmtaB72RCDK1siSchpjtiDkTO
 cDarKtSzFBhllQLl+EIifeZguVu33W828ZuK3xZyWcDw8FoBAOgCMHDkrwzAvziffh3y
 Rb4T+EN1m0W0Oe9pbopGkbbekPBCO6uTc9jfP1/jpJArpMuAQ+HRnTjm3TOmoWEsnI23
 xho8CdFRUWXnWbqlGeU3E9iZP0vPVGVSt8daHfq1F6j3kV9w6Y/PddZ5AHqykRqez9HH
 nuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768820678; x=1769425478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=31vcExfhyxITyDpAatH4IsbdJjBgBKYHjZYCzAjc2Rk=;
 b=cdrMeMqHXv5Yy6iRZRiZSviHleAHySrVeigHxP2yq4IB7+FlGGS628WBisiFnvAvhp
 Rlek11IjJGuJgd7nUdbhWa8k1lJRD98mPsPdHk6Mkrq3bA6qnwnUbFIcMLFhzo70G55N
 6PY/3WRHpD+7xg+W+5aAW8z0YGiWbxosixerdMEYHf7y+BGZ1k85OZnZY3hwHStysm3A
 0WwhrcaCZwOpXZkA/O900OpUcuTvGUBVr2CHjioD/3tfwUG+eK3ATjrVOcvVwFjvaME2
 YbdLh0xe8f2YFD4MvYSjqdxloYV+nb1YOxX4qItnEUY7DhRZbYC+NW0/G0C7iVxenVI6
 p7Jg==
X-Gm-Message-State: AOJu0Yx4UNLsHuFJhLTJ9EzmhXrZ2MNvnRQnEXtxn+MYFUjGTOCkatr4
 AxxqVNClQZgV2ETsusgcPPYVFgPA15ZwORNEdpFfiy86lM86TBJndXEG+xwoaZ9vEEIfh+66dqe
 NvsW4mXM=
X-Gm-Gg: AY/fxX4vk7TYl/Cx3TgxnendZdOlw8ubS2gWhUioki6mYN6wKNWNxiR34kxPsYwZV9L
 cLO2SBE2wAqnFdXO3296nqoGQTgYdpsHZG6NP+J7jG0LfMXjkAxEFuP660RKSTjhhsLo6GAlD0N
 x0QHhjo2IrFSmzmKVpdI1c+Wq5ODn6Ii7RmQHB8jo7SignpKUrKMTtMtInr3IWILtn0VFbd57kX
 rrJGvGaVCRk98/d/m1RF9w6yaYZRjo/YFfWssGWKOdY9YD3lM2hAe1gesF13H6LDaiKHj4jfIso
 k2mvzofq38vGMugmCwfeJOiKq5gqfPhOlytduk5wz+fPPWJDcc3hfeCwPe6zk/55UgcqJIOGEF7
 hx6Oq+OfNIHd7Q4pR39oCp1k0iNakj49GrgprpucO1UuKYLk0wtdg17Cdp8KHOqxKPzBIgIEvv4
 LP+ryIQQdOzlE3abiTaYOxgnibJoVJmpwSc9UiSSjIt0cW1xxb4K6i1XhURlMg
X-Received: by 2002:a05:600c:4448:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-4801eab9db5mr122218155e9.7.1768820678212; 
 Mon, 19 Jan 2026 03:04:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe3b01csm82111835e9.5.2026.01.19.03.04.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jan 2026 03:04:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 5/8] monitor: Have *get_monitor_def() fill an unsigned value
Date: Mon, 19 Jan 2026 12:03:55 +0100
Message-ID: <20260119110358.66821-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119110358.66821-1-philmd@linaro.org>
References: <20260119110358.66821-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

target_get_monitor_def() fills an unsigned value.
Have get_monitor_def() fill an unsigned value too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 monitor/monitor-internal.h | 2 +-
 monitor/hmp-target.c       | 4 ++--
 monitor/hmp.c              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae31..8dc88963630 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -181,7 +181,7 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
+int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 1600666ee92..5738b47bb03 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -63,7 +63,7 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
  * Set @pval to the value in the register identified by @name.
  * return 0 if OK, -1 if not found
  */
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
+int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
 {
     const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
@@ -100,7 +100,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 
     ret = target_get_monitor_def(cs, name, &tmp);
     if (!ret) {
-        *pval = (target_long) tmp;
+        *pval = (target_ulong)tmp;
     }
 
     return ret;
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 0a5bbf82197..eee8b7e964e 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -376,7 +376,7 @@ static int64_t expr_unary(Monitor *mon)
     case '$':
         {
             char buf[128], *q;
-            int64_t reg = 0;
+            uint64_t reg = 0;
 
             pch++;
             q = buf;
-- 
2.52.0


