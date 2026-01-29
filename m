Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177DFD61011
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSAI-0002pi-94; Thu, 29 Jan 2026 08:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS9O-0000SD-PA
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:54 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS9K-0002eL-E6
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:33 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so10451405e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769693605; x=1770298405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31vcExfhyxITyDpAatH4IsbdJjBgBKYHjZYCzAjc2Rk=;
 b=v72rBlp9uUc6nG5ir2Dm9eztV7SDDekkLt3Pw308rcbMkspaJN2yAPWpTg2ad+cxRs
 of+MWjCWmmKKN36kYzH6v+kT9Oc4BrvcO8vmm0iCCmf0G9WoSYniU+gVPCuQIudpPKEJ
 wX1U1z4z3hp9+qYKrzLphX/ydCEFDERiJM3HnDGrwkmzB+3rNVSyuhE3NjjAEZHY/0Lp
 OSWPqQmKbW/2T0v+IADysdR5VOZl4l7GWoDDCGaFT6rAkN7yoYCEc8HKSfdLeLvKurSL
 j9Ew+c/nmidgaLYi91+AXgbln3P8g/mLDQ/cbi5YNcNXkDM8b76lwy1wO+vYZUBB0Zdx
 yz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769693605; x=1770298405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=31vcExfhyxITyDpAatH4IsbdJjBgBKYHjZYCzAjc2Rk=;
 b=CV9eNuIFE02hT4WexB9fTONeNsi6PYKk3SjKT5/IrD4b9sn4ihCEf8F2viLCQqXT9d
 P54VA+m8v4tDla452STIxtihzk1srstVq+T3Z5T5uH13kT0230bqAtEEFnUlOanfmpBB
 MFeN9wzmlsAKBhM0Ni9p5Qhbo3dj154+EF515N0KLHRGbSsXkGu+Wcb/kyNCPQpPuQVG
 tdYSR7tgWyxliRcji0cZnl/Dv411ZD0TDmhUGa+8BPUIUznc2egNsdTkLwIUThDzuqml
 /U6+K8yE9Jecyc5R1fHkyBjCo9sVLfqoZQbb2zKDSXeGjdT6swdaq6zCRWIHN1slYShZ
 2exQ==
X-Gm-Message-State: AOJu0YzM22JpakkpNGRg/d59oCsviZ0tAxMZYMfoX1QxqbV8cc2FGkwa
 duPixM8keNgIM0s9FBfqJrykyJKqIPpgWb+2zJPm1bVyBTUO7Sb7unp1UOmUHDsXqa52nUkl849
 yWqcz/44=
X-Gm-Gg: AZuq6aJHDlPgQC3/I/PCjUQ1HVm+TAgRekICZ+YGdNpxSkZXn2QSQCWBSMSfGFGZOUH
 kLWItt6lEnU2UZi07EqFG5BSlIRDlEVwogj1vZuP8fO/0bphLGL3w0FTU1nRepmLfb6WMQM/Clu
 h4Vcn7juRG3ybXbVQASXE6VO0f7F+QRvnVbapOwrNcqSvppt58uC1NQ2z+Ddp7EhgaXlDAZHBhn
 0CD4IP4eRmEcaVBnBSejXS6MAY8xFk+DO1qe+9dq6hOsuqpGUiBX6jNO1DLCigdE3w1zFilT0ss
 7XSCvyTH+wyzLAtiCG93RO9eoVJjgIfAC2z7gyCDgkwMjw64xdEcYS7dJa8fdm/bnK+/Hs9hVgK
 UMlWjPFOjWF0/jF2JfMBvIrLMXPLKf59T0CReVT5jljms3mok4q88CPESz3XZ3wK5YV/gcIrBT3
 L8imR+B1/gNMr0CCeIsuc4T1cWf9Nip+H+xhM+wUWLnkGAUsjZMmhWKSKFSfOSR39/vttNazA=
X-Received: by 2002:a05:600c:450b:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-48069c0e151mr95318785e9.8.1769693605118; 
 Thu, 29 Jan 2026 05:33:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5cd32dasm4733865e9.0.2026.01.29.05.33.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 05:33:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v4 6/9] monitor: Have *get_monitor_def() fill an unsigned value
Date: Thu, 29 Jan 2026 14:32:38 +0100
Message-ID: <20260129133241.35990-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129133241.35990-1-philmd@linaro.org>
References: <20260129133241.35990-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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


