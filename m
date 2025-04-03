Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD51C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UKf-0001u5-Uj; Thu, 03 Apr 2025 19:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKH-0001YE-8p
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKE-0000i6-U4
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1631661f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724221; x=1744329021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rr+hpT8SboGgKuB5nhv/jFygpXGU6aBbobklx4SUFWw=;
 b=GBPdCz47tSqLLzNhPA0YlAfuFnNWVbFkN+3EOBoorb+aONSB9Y+JazDovtxqjdxO98
 hFYe8LDtTLe+6xuI9bebcVFxzOlxro3+CWyRgR5yCFEyN2f5uG/yDizyMT0KtWC3b0Ak
 ORba1vVjXPq8Kl6gJYrwf7f5bia/uEYBY9Ba/Tuu35QcXFOjVu9IRMcJbM7y0OVdVtbr
 bEB8fg/B+CYZs0uN+k2euY6TPhTz3gUnPz4//OmNvIu5bggrc9M22gw0j3016wjzRR45
 z799nvZLlJ+/5rFXcrl7y9/F4Oo4NYyfLHS5ZdezgH7nAf4ffTe7T5u+Neq2wj+qaE03
 oI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724221; x=1744329021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rr+hpT8SboGgKuB5nhv/jFygpXGU6aBbobklx4SUFWw=;
 b=K+12i8DP9ozjKaXWccuou5mb6LVeCUhuYJURriGgCXowSkdpx/1iCe0eVdGnYVxc60
 xv9f5pq2dmF2IkQ5boFEZozBj0Qv7V7u5FG32ABo6K5yUOdBj0GDFqso8BdpTG5VL6kf
 I0OWQNLeTicwMX49XyNKQTGeLubFKHoT63qlVV0MssmqFAD8p2lp4jm/rKbs5zFUrY8X
 gMOIaJkR0Ee0y/vg7MCuBHiLTDQDISMXAUlhz1BdU+XPfnH3xMnVrO53P+an+R99/O5G
 vm9ML74rdsMCRyvglu5h2pm4S0AnehR1i4nSOg+O32SjL9bC+oRb1v24pp7ComAC6+0k
 Pqvg==
X-Gm-Message-State: AOJu0Yz0hMUq4kuP+G9C7OMzF7SAM/KESg4I/H4nYfOUyLjzVkn/P5dE
 OOTmHKmPSn5QKuzR2LEy3nQpcEImbH+BozgBUnOHx6R1+Ku17drlVaQB9OzBijGAag4a66yMXUz
 v
X-Gm-Gg: ASbGncvdekWfGgshq8mDsbZpfQVtHHLkGhtx3VBrZWHXlnm9TM/Y9ek7HEHwZNoApbw
 HbU8XuBhfdrI2p9UhXOGrzH23tWHrJPyyWWtiwwxMLynL0bxnYrxbG1FdKJOMpbgUwkkoDnO1KJ
 mV/icX2JfVr9qlAsgF002SMD9rw96zll2dPwpFPlzPSn8yCnjS21hIDGWS2mC7UJ1WMu4ypDL+9
 lf7fdtzXrgBPoAkdzrcYPJuyDhlF6EK78uL1nVHnkEhPitfQoOsyOreBKkXB+JYm85RYMOC+mA1
 KTGvFmTgZfRGszomjrrqg4YQ70zAFW796ugr1hTsWGB65S3cQzkn8gxJL8ARFRt5dF5Q/UsA4d2
 PHCapUERYrV+pFEPHUxg=
X-Google-Smtp-Source: AGHT+IErolKrSX6KteIIjPQvPP6tDPcjVLPEAsDHZBYwF/hwTghiPYF+NzqLQDpdEuJXmfO2p9EPGQ==
X-Received: by 2002:a05:6000:2509:b0:39c:12ce:1112 with SMTP id
 ffacd0b85a97d-39c2e651984mr5182101f8f.21.1743724220803; 
 Thu, 03 Apr 2025 16:50:20 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b6778sm2882577f8f.46.2025.04.03.16.50.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 10/19] cpus: Replace CPU_RESOLVING_TYPE ->
 target_cpu_type()
Date: Fri,  4 Apr 2025 01:49:05 +0200
Message-ID: <20250403234914.9154-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 761c2d28645..01b0064b91f 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
+#include "qemu/target_info.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
@@ -37,7 +38,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
 char *cpu_model_from_type(const char *typename)
 {
-    const char *suffix = "-" CPU_RESOLVING_TYPE;
+    g_autofree char *suffix = g_strdup_printf("-%s", target_cpu_type());
 
     if (!object_class_by_name(typename)) {
         return NULL;
@@ -63,7 +64,7 @@ const char *parse_cpu_option(const char *cpu_option)
         exit(1);
     }
 
-    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
+    oc = cpu_class_by_name(target_cpu_type(), model_pieces[0]);
     if (oc == NULL) {
         error_report("unable to find CPU model '%s'", model_pieces[0]);
         g_strfreev(model_pieces);
@@ -92,7 +93,7 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
 
 void list_cpus(void)
 {
-    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
 
     if (cc->list_cpus) {
         cc->list_cpus();
-- 
2.47.1


