Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5B1C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjXq-0007Dn-Fz; Sat, 25 Jan 2025 12:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXR-0006Wd-8z
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:50 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXP-0000ON-1O
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:40 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso26616915e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824496; x=1738429296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnxgPJtNl18qpQlYyJcdV2Lpgdr/I3RQhGnRLNDQ94c=;
 b=kRgZgjHvtEew7p+tTewGTgswcNCdsZ7DDZ88hrqehDn5/NKf+pR4V1lrjg3F2+6L1e
 qmdlCrXAbHJOQ8QDq7aDRmJjsyH87dxYjUbsWqMaM8tMIhe0px7wLpf23lR/FiJHdaUL
 pgYlg8Uh7wXsmoYHH6P2FLN9IdTQmFH4Ej6r9ZgBWUYAMk4cNiBPsjccufRgIQuzF1JS
 RzfSGGj0ZNSf1doryLwXVMpOjcPLtSgobh3L2GSgSLBxCm1750fT/120ITKx89ATiEYj
 qOspQGwTabZfgCmEZqKc3FJOpnRyVe8tNkJnjvyDHsVZ5KFNNsGNVrxiiInkGgRhIj7n
 CyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824496; x=1738429296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnxgPJtNl18qpQlYyJcdV2Lpgdr/I3RQhGnRLNDQ94c=;
 b=h751+q63hbtt3FZzDteGBW9um6SuyZB575GeAfMss/NHEG5A2/e1XW+NN/+xbtvpYN
 d5XHO2ipCuuC5u9/Se8zGYrWwSXs4VYQvlP8ZM5MS44ZSq1qnMuM6ko2u1nlLybY6Dfg
 URCPdR0FE92ErJYCgfZB15dGh1UCU9WwTvGpoRRA9SoLc81no9X5jVwC/jG1JPYapwVC
 paqaYWBGdL0/YCBkz3moVI4vWO1oTUdEIOFBx+M4CoJxiuMWmWe+mqFhV8BUjfZhYP4E
 qsfHCkmJYGBTD1KvldunTKiSuOA9pmPbWAm8D/81aCsnuVvZHHf6bK1XAV6omYIRE53n
 fORA==
X-Gm-Message-State: AOJu0Yy0B8oAnnSLYS59mi7ahSr9/j0Nk7Erfa8m1OEZUznk5v+daTr3
 LknuUju8tZSeCzpvOfyAvsSPyOBKb/6vlLDz2gjDexTkGCDCSSUw8SEp3SnU7A97vl85QGkksDS
 d9mE=
X-Gm-Gg: ASbGncuyS3v9yyfU/N7JDsliZKpK5qbNJHVQO3s0lFA43PODMiqr1Ub0mr3wHiiCSRn
 KdpQ+fSPTBnyTrG6myKhPqo0G36eWLBdY6ucU8HssRbgbYDOVEFjWPoI2CfgoiOpI4CTHtAzAKC
 AMklwx4oGWXPSLo5vtkYqPqTHx5porkI+XrpMyaNoii+aUa33PzVze8Q2iTiYbWqH1pErniV0ZG
 sHty2C84oqGCRjau4SicB4SpgA/5FhpV1o2R5SfhPI2Z/YBrgDybeMyc1kgnmSF1lOBYNwk/xh5
 D6uJkU5bE2+RZyD1d5iemyGlnXIoMH+5iSZg6wkEmnkN8ejXeAq4uWY=
X-Google-Smtp-Source: AGHT+IHUAV52JwynhHZ5iI+rOgEvQ4xiYVjH9kn4AGAOOFjcbEPm1XRxlsPqo5KMWkWthDF2yxdypg==
X-Received: by 2002:a05:600c:1c14:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-438b8841d5amr105040825e9.1.1737824496440; 
 Sat, 25 Jan 2025 09:01:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d2c0esm66485425e9.33.2025.01.25.09.01.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:01:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/24] cpus: Un-inline cpu_has_work()
Date: Sat, 25 Jan 2025 18:01:03 +0100
Message-ID: <20250125170125.32855-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to expand cpu_has_work(), un-inline it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 6 +-----
 hw/core/cpu-system.c  | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e094d54949d..d64c823e768 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -756,11 +756,7 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
  *
  * Returns: %true if the CPU has work, %false otherwise.
  */
-static inline bool cpu_has_work(CPUState *cpu)
-{
-    g_assert(cpu->cc->has_work);
-    return cpu->cc->has_work(cpu);
-}
+bool cpu_has_work(CPUState *cpu);
 
 #endif /* CONFIG_USER_ONLY */
 
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 37d54d04bf8..16d5efee12d 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -23,6 +23,12 @@
 #include "exec/tswap.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
+bool cpu_has_work(CPUState *cpu)
+{
+    g_assert(cpu->cc->has_work);
+    return cpu->cc->has_work(cpu);
+}
+
 bool cpu_paging_enabled(const CPUState *cpu)
 {
     if (cpu->cc->sysemu_ops->get_paging_enabled) {
-- 
2.47.1


