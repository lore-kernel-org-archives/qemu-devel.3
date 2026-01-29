Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54929D358D6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV5F-000169-1d; Thu, 29 Jan 2026 11:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV5B-0000yG-Oh
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV59-0005GY-AT
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:25 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48069a48629so12476435e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704881; x=1770309681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31vcExfhyxITyDpAatH4IsbdJjBgBKYHjZYCzAjc2Rk=;
 b=D7F1/3UTHtGBHvFphEKySINqBVR+MCDy71a9/iuIV4YkioUmpGeAqixFsxhIi9H1YK
 F5OmQOulwSzx+h8n7mxfqbt0DubzEGjl+IZD8NbFyivYj1my5u/9RbdMLWr28lpJVe63
 CNw5Pt5zw8xd5TQNP/LkeoTnGnqcRjMqBC3lDxFFV/RaYSO8P+R+LRvKuc+6HT7dSlCx
 w8mGHJTG2iaJs0C7rQh1kYhtEBe1MoHOdpR2GKHqy9TBUjWJFQlGgcDzDUBqNCstY3sG
 52m+R4DUPXJBzyl5JDCUTroTzn1DxapgvZOL2KD0jNh3E/5BacCIF+eawHb0tcigJOD0
 HQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704881; x=1770309681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=31vcExfhyxITyDpAatH4IsbdJjBgBKYHjZYCzAjc2Rk=;
 b=ui5xkZkhcr/F12fiQA2pT6+Xsgt5pI+FtJiReaOr2yATLBTuXZ+IXpW8TX3koKytgs
 7ly/K4Juz+r+SVql/uyrPRDgz06FKii7E/OrgAmJWWv73HsQkP1AAVtQiHkey7Kmptd9
 1lMr5x/94+FGWHj65T5bZixJKHbQwU1JLDP2KucGyr2FaLzB4qHKB45MZfTsLJzjzuzX
 fYwV3P9RsWb/Z6oC/jhneGbBQ27axt/TSwhEIj0xS9A5f3JjPFEHoVnmztutJccO2AxU
 6SNCQLPTdhYBufzttVcWf8+Srq9Bpv4dp0HfqZCKbyNC2GAS49jGe/MunmRC/GsjzW8P
 Pw7w==
X-Gm-Message-State: AOJu0Yyw+snZfc6bfqV+WOjwCGR0zgT6WdEA0fSPdvCyQDl2wuJnS0Ob
 H0iahIOoGgeG8+KhAjx8k+Del8X+cNqXB8zI+q4JXE8nugiS7nhFeNlhxBoQIfS/1068im3jp6b
 K+kPc5fE=
X-Gm-Gg: AZuq6aJiQsZ7K3JzwSj9qfLPPV9W8QlNYMXo2Z5XyD00jhceRcj1b24hN/LRN9wWPAw
 yP+TUwZIQD8PA+6uYZ8qXIPWdGppPTGpVRmKLjCtW1hR8dPXV3CnS3IkqoaC2/kqibtdx1ch4JJ
 9GZKlRf0fTHmAMQGjjzB7Vnbm+Y7OATEFeQTkgBW6evqzvbjdMHz+UlaTCnl/6qv5H+wFn9JDGY
 HKPUZcsz/f0T8y5J8aIFFAEnG9KSIWSkiydMZOVcc/yVDv5RGn8q8+6TH4D2k5RL95ITeAWkGkD
 YAG7smLJnUQRfwf8mZ4emKphhALpvaTmKvs8jeWAkh9w2J2NbXGZqUI7ndVKnTtAhNONYVsAwHh
 rZ8jfFQYVsi34YbDCKBINEKwGOOkQDgpjM68ix5Aq8mXEQYUrxa/BC2/14ryne2HB+4BQhUI/Ai
 Hj/KBrk57yaqG4LctEKUagqU0GRQRSaXozQpOt+dFDM9FVtcdZhiMaaZqV+TvJ
X-Received: by 2002:a05:600c:8211:b0:480:4c45:aff5 with SMTP id
 5b1f17b1804b1-48069c755e6mr104928215e9.34.1769704881533; 
 Thu, 29 Jan 2026 08:41:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066aaf235sm197783265e9.0.2026.01.29.08.41.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 08:41:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH v5 6/9] monitor: Have *get_monitor_def() fill an unsigned value
Date: Thu, 29 Jan 2026 17:40:35 +0100
Message-ID: <20260129164039.58472-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129164039.58472-1-philmd@linaro.org>
References: <20260129164039.58472-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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


