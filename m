Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D01BFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcql-0000Ht-Hq; Wed, 06 May 2026 10:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcp2-0006lt-9D
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:56 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcp0-0000qf-NQ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:56 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so4306930a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076112; x=1778680912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rVl4Ot9jNOgGYAeM+5IhhfFZHe3/ocTPrsdtHl9wG98=;
 b=Bh4Fkllzfkuy8u34kQnBYE1JvfX9As23fZVVn7uJK7pqQAtZtRgg/X1WwQS6j8h+SQ
 jjBbR2jg9ANqW3xr92YG3oxfEUf4zf40whAOE1YUNeruZGSs5pykfhKoH/YWsZ3Bt+MZ
 ir82VHepO01Qxd+prm8OL1JPcAe1r2zpUojGZfaEfZ8emqFyv4F/DDfHQzimGJfylE/O
 UB3wmQs62wAdIPn9/CtkbUXRsiZd0uCYXUA9Skrsi8S7rMIcl1a9yC2I17/TbaJqStgD
 Do/ecrKJF8qGgWwqlGHEorxw3tzSWqyb03VTn0GoIs6MtBQBgvvwMvC5sI9fOw2Ind+h
 I6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076112; x=1778680912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rVl4Ot9jNOgGYAeM+5IhhfFZHe3/ocTPrsdtHl9wG98=;
 b=p6byr5u6DMPYr6jmUwumFU9LX+px3ItLGVUcD0V4yIVnsZiqvQcO9G3IreC06ukYpA
 usJUxhCfw8xdlCSyv0EGZFHK4oQhTyqer3xg/YjwyF9uOERXHq+IXJC2RtknHynkA95E
 PDU25+f+a4+VNLwXLKBcfo1OChoZmJxpYEFlG5m/kp11waPOpJSBLAtt9eAM3sPnO2pk
 GAmysDTGkbcFfCVYJevkrDoX7115vbs+fLtaMqb8afaaEbIx+8avtmRrYQcFeh//N/YH
 DMfcdAzFjOAoakI+VkQ9D7gIK8k3ZPwxDa7MIshZGF0GhNf6METQj1DZgXF7bsvh0myS
 ngtA==
X-Gm-Message-State: AOJu0Yzv6Co+wXjb8Pf9uJWXoxQx8+r/95tT+3VGa1Fh0pkamr3sMZgy
 KF8xx/1w6mC8DXduDJZzEk9D9pb2Snn3iJ83zkGPCJYmoKsrgAm7bEoV/u2w6n+FXiwspiCC//V
 UaYw4r8U=
X-Gm-Gg: AeBDietsXp3gtRoiqz9lt67qI9YOKvBP+Eq4q9vWMXfz6zQtunvAMStPya2AI5N57Uz
 yhHzbte0A2B4JiGkFOaCHZuJbXodQWjMNXyM2LDAzzqEl+VO8ZHNzjsIAPBNwCoeg7K3xvgPgb8
 kMM5VCqx954NpF0aUL846VGOIRAolrbRHKQBon3K/OHAK8mya5HptnFtNyNc73gquBIKxyOhqAX
 SI/evwIzvA1hwn1AfIQKBcM2E4KgGK+cZsByUPNr3Xtgu60g6iYLHXxzwZqqb5vDssvdUddVitQ
 32OcZO9z2XpRRlGk5ila0QOavdove+yhfxY7i03M6zgx8Yk9NQvYOKFS7aszcZ33ppK+xWSriSK
 SKrw6BiK1QPPTQzUeHbAeDLm1Q1+1KRioOWKVmxnJGDl8DpnptOaCYR+EWE3IqJ/7fMpulTgBI9
 7KzQI1MXXiQaO5sJGlyypyeEdbrGiCh+CGcSnTju5AWoYOVn8CxlcNzdU4/aFgh08hDct6z5L2r
 Ylb/70nl+g=
X-Received: by 2002:a05:6402:3586:b0:67c:7697:1ee8 with SMTP id
 4fb4d7f45d1cf-67d63aa0577mr1670002a12.5.1778076055170; 
 Wed, 06 May 2026 07:00:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a488d8sm12594456f8f.12.2026.05.06.07.00.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:00:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 043/110] monitor: Restrict monitor_set_cpu() method scope
Date: Wed,  6 May 2026 15:54:15 +0200
Message-ID: <20260506135524.20617-44-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-8-philmd@linaro.org>
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


