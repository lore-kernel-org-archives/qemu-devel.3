Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9817C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr6I-00008Z-43; Fri, 17 Jan 2025 13:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5r-0006ZJ-C0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:19 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5m-0000KX-23
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:19 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so4276945a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138553; x=1737743353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4dO1DHs3aMhbQoy6IdswUOKg4TsdDQ15BdXLkM5uuA=;
 b=uL9oIiV/RU2rTkv10nlRcbYZ5PnNpEnq6InXWdyd97UpZXFk1AdFhIywQlwcpVT3kT
 jTfXVNCSgsUT5UBzDWbCf1YdF2WtMpdUIqhXxpofEovPB0R4AowDg/hShACXqGV0hRIJ
 oPTkT6ViMeJVn1UNia+RWphXZhjW096NNVriGaCCIygC7N7VAstjR4lSpBDaoj4d9vtj
 CmgNM5kN4ZO5wOqYZhlcHZUmfpBRYN9P82vtm+RM3YhGgvdBTx22swdZht5SG3xsUr6C
 tCUmlkByF8Rogg6CZy/RpRQ9vHfsDdh+Hhm4qCGxwQNbek7Gl9MoPDzdPAbHfVbApBbF
 TSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138553; x=1737743353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4dO1DHs3aMhbQoy6IdswUOKg4TsdDQ15BdXLkM5uuA=;
 b=wqdn7kxSxskiafFBDrs32rdlpvCtMyqMrhWWPnLCliv5COcmji+vINQtaGA9CVoEDF
 BlVtEGRbKvBTJY5I8TTeFDXwIETtIT2mVcNnICQ1gAOZXsf5GPb/WsRWDvHMwnfFZo9S
 A877VEJOJjCtzfUXBDGWg0rtfpeC5AFkvVq7WGZA5aNNpC57UwtFxfpYIQPnXCiqrIXu
 +82iH5lm017VzsTkP1EC2B0wH+gfkBLbXwjYSW/ZUc+3nSm1N6or+UMFMEhyQ4qAk3Ga
 7xMHRjFtfIPUXMkBYGlZ4scsrjRvW1fOrcZMP9VjFEvBf02IvdGNBC1eYt/atSkKZ3sg
 NImg==
X-Gm-Message-State: AOJu0Yy8Qc+JgEz4Lf5y1hPqUh/ZsVmgVkQC/pJxroIeysV8vaWsYODk
 9OwCD3defuv6kit1xvapkzO/CbyjKy3dwnocznHoA5XA/lQA/A2FFe51KuKAk2e6xgbZlHN55kO
 L
X-Gm-Gg: ASbGncs8GoJop4/8AnEwTouYmFEFynRddfsjgcs49gfOdo4fRROZEE7Z4VUeE89ZRaF
 P2GhxnRteglsqBtKhVVIpYZ7AnRUbXdkFTpemcxKkAw5hkwhcHgTwL4dD+3a4hUt6NxL0brC+0t
 AS3KTewtgrKgYoI6NLZ+r7Cdb+nim/yYTfeMySfzIEaepP3LnrRwnTiAZfXvfHtqjzVcQe+JZu2
 Bn73+f21GACgEZGHrW6Xp4BNX8R2di16MPhVYjeMXM0FmFTfwrGYYEta+XdlckgD+sNEI7CpECg
 tw55e+iQEEsUUf8=
X-Google-Smtp-Source: AGHT+IHZDkDB8rAIgYz5bbbyzON1Zq9oGHf86/U3PtrSedduL/0IjtwbsUH4in7ArPJ2TiByrbmb1A==
X-Received: by 2002:a17:90a:d003:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2f782d7dbe5mr5046329a91.29.1737138552696; 
 Fri, 17 Jan 2025 10:29:12 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@kernel.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 65/68] linux-user: Add missing /proc/cpuinfo fields for sparc
Date: Fri, 17 Jan 2025 10:24:53 -0800
Message-ID: <20250117182456.2077110-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@kernel.org>

Add some missing fields which may be parsed by userspace applications.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <Z39B1wzNNpndmOxZ@p100>
---
 linux-user/sparc/target_proc.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/linux-user/sparc/target_proc.h b/linux-user/sparc/target_proc.h
index 3bb3134a47..744fa10730 100644
--- a/linux-user/sparc/target_proc.h
+++ b/linux-user/sparc/target_proc.h
@@ -8,7 +8,25 @@
 
 static int open_cpuinfo(CPUArchState *cpu_env, int fd)
 {
-    dprintf(fd, "type\t\t: sun4u\n");
+    int i, num_cpus;
+    const char *cpu_type;
+
+    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+    if (cpu_env->def.features & CPU_FEATURE_HYPV) {
+        cpu_type = "sun4v";
+    } else {
+        cpu_type = "sun4u";
+    }
+
+    dprintf(fd, "cpu\t\t: %s (QEMU)\n", cpu_env->def.name);
+    dprintf(fd, "type\t\t: %s\n", cpu_type);
+    dprintf(fd, "ncpus probed\t: %d\n", num_cpus);
+    dprintf(fd, "ncpus active\t: %d\n", num_cpus);
+    dprintf(fd, "State:\n");
+    for (i = 0; i < num_cpus; i++) {
+        dprintf(fd, "CPU%d:\t\t: online\n", i);
+    }
+
     return 0;
 }
 #define HAVE_ARCH_PROC_CPUINFO
-- 
2.43.0


