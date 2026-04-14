Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA3EF531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRfh-0001Le-7E; Mon, 13 Apr 2026 20:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRff-0001LO-JO
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfe-0002ql-2J
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ad135063so47984855e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126624; x=1776731424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ais8/utTBMgt739AAzrSb5RSknUsBIEhQKlzpInZIV8=;
 b=Is1yK11DkQfpvyrMCerjGiC4j8emhrEnMLTZ/a/fP+d5oG142u74CEQxsoaHdeB1QE
 TtqEXob+gq8VfrSvw5XAB4JS4rj9UPzhRja3cUtFZxMB5yakKHY8me1Ei79n+xysTkhY
 9L/7f9UPQ9sIc94DU1YFCQMVWK+ebtk9KN0VPBZ8KGxHYBQP5+YWr81BzbwGv2n8LC/y
 gm9dSM6tYZjcyLsSv2RO35g6DyGItBx2Zjtd03uXNX08A0CMOFs39DWr/iGeidf1ztFQ
 Iox2on4hJa+tDKpbbh8NQuBFcPxfHsrnhZmM0Tm1qqJP1OYSbJ68anPemSwonwajfdB0
 BV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126624; x=1776731424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ais8/utTBMgt739AAzrSb5RSknUsBIEhQKlzpInZIV8=;
 b=opHVLeMk6yRxe+U8gxUyxVAjj/PN/kUycaSX7rZMW7gvqzS39iMJqu5ZEnr6uIl8D5
 nxpj+Mz4NAKubN93eXhKhDpXmn6wkm2H3u68+6lT8SW4G+VQnMcpDuNZdHfRSThB6N6m
 rwJZu6wG/V7LWyr3s+DqWI1Pcx83Zlhgxa+Qq6OjXSEUziPQtY6v0ev5s5Zxwye48HEH
 0HCWXAPy8D0Xj4VKlm0ZQDgr/F3eKUXMXkI3qRi9A9zFXe630WyKZbjmF7BuqVTYP74R
 gV8rB6g7+9/7vuIGw7zIzGI0ry0yrHdhoAdO5qsj1K4vMW5uX0n5QURqUBcFFddzu75L
 WzJg==
X-Gm-Message-State: AOJu0YyVeQCJ7hr5gZuin5IOs9MQZX3ElCuDz5t3q3fQ5Z0inwaX7KFJ
 +adS+TxJ8pkj7yinOT/CQl/3yvmKdyiRV2+t1Meaea4bB4Kj+zc0DD4B9LFvedPKuoPUJP63seU
 pfI7sXaE=
X-Gm-Gg: AeBDieuVO1FatBqqLO+nx/RY5vv165lVmZKPhe2GDsy18fjPaFBlo3ZlhALPji2WDEk
 t39bYTUnMJFW16LJmTgMOzFVoMSGbDGsJdx96QWyBbgQfNTym5iWnN1JxEjMPfxMCBM9hro32MR
 thD7cJcxaYcsGxafE00+K1z9r06XIfQwfZLs9mEACHKXmo+gHaW7CSjNNJnqMHhfdUwOgO0jPAQ
 hyyhC+J5RSNvQESwJqTtMC+XX27/LMsPNtl+2pBy+RjuXfyJ4l7KRFmCSgnJOGaZr9qz2VaAi66
 YXvQ9o2ghkMEoVt6WfMBDM36AxZ8zSCogv+mEEjmPrRuJmlGLbdRpHzpfRUARCxOTGlE/V/mGAm
 bUuvOtq2HDv+vsxa7wkYYGVe+4qjS7jhemRdrRfmzKRkfKEaj3TfiCAmtjDro7OkSdVyPUdsNAV
 goh8ogPGOf6iJvk8yLS7uN7rNR3vRPLICSBaYnVCl74tGL8bIqj+MLbdKeet1gPsFfEWvIg5gr
X-Received: by 2002:a05:600c:3f0a:b0:488:afb5:6a21 with SMTP id
 5b1f17b1804b1-488d68764b0mr208133185e9.15.1776126624404; 
 Mon, 13 Apr 2026 17:30:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1df12sm13946415e9.4.2026.04.13.17.30.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:30:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/27] monitor: Restrict monitor_set_cpu() method scope
Date: Tue, 14 Apr 2026 02:29:35 +0200
Message-ID: <20260414003001.97571-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
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

As mentioned in commit 755f196898e ("qapi: Convert the cpu
command") 15 years ago, the monitor_set_cpu() method is a
temporary bridge between QMP -> HMP and shouldn't be used
elsewhere. Make its scope internal to monitor/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/monitor.h  | 1 -
 monitor/monitor-internal.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 296690e1f1c..55649a86641 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -37,7 +37,6 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 int monitor_printf(Monitor *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 void monitor_printc(Monitor *mon, int ch);
 void monitor_flush(Monitor *mon);
-int monitor_set_cpu(Monitor *mon, int cpu_index);
 int monitor_get_cpu_index(Monitor *mon);
 
 int monitor_puts_locked(Monitor *mon, const char *str);
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae31..80b4a8150bf 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -175,6 +175,7 @@ void monitor_data_destroy(Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
+int monitor_set_cpu(Monitor *mon, int cpu_index);
 
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
-- 
2.53.0


