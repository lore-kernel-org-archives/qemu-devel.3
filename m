Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEA7C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7R-00036l-Il; Thu, 15 Feb 2024 01:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7P-0002w9-2a
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:11 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7L-0005b6-Pu
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:10 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d91397bd22so3785925ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978066; x=1708582866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM2DWBTbIODm0qN2yhX9D3hAXXDtYwow0kqtsMcFoQE=;
 b=v4wd6VKy5O2IRTProYWFR0Vcv+WPssRe5SK74jjAA2yPm6ASPm6m6kzj4ZE8ogpUFi
 fsSXfdqzQt9xgKcnUGQPgUEaRKvoJu/B0VIN7/GYhI86gbWiVauGD1o4c396AvTVV2BG
 sW58FAOp1qqxbIrgFHPusCAu7FF7Z1McXjiQL/KtNQ6cKKsD2pHTYd3RuvUQb7UKXr6/
 IHVM0KCMLeBYIv0xMzMuUgxQC4bUjJJpezU0uZCvkg6+ikuEZbUhE0g0sQJUgdNernYK
 3cDJv8eIa7qdzMDA8PufduinmecsefyLeCT272b2DmEy6FlgYTmKziUIDm51bsx9lShQ
 Qhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978066; x=1708582866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iM2DWBTbIODm0qN2yhX9D3hAXXDtYwow0kqtsMcFoQE=;
 b=cZC1e7gq9OMOAa4Veq62nzlN0UkcZK/TyE9Q6tTJMdLhrmFHryFcop23iKb7qNfH3n
 Yw5GG6rHwQeW4FBQuNXbqyV042eblhsch4y+O5peWQFsmf5K8ahi0G8GzW+l7p5KPRHm
 I2NNG3cUBhq2nEXoTUeFJKa6+PIIrX5c83wZa5u+FIQ5aQ4q0Yjsy6vAjOyKWQ7kC/Dy
 GLv+AHABepgkCcp6i/CTLnWiexdo6XhnfLWJonngsK7nhUGfbGqycvUvB6DGJEc5WM2E
 scnzSBw4l+jJX6JooCcQ7/zjfVr68MI/z8GspALI98qeaKPunUF85sJ580MkI1rzdDfv
 XM2A==
X-Gm-Message-State: AOJu0YyyoNitrWmZtdfIgCvWrSvZU543IOPDQ6fkQ6fZiKUBXyWYSkRJ
 Oekeu/CHRBS+tDagK6sWvdV7Ji0kYBfktnEbBIcIYz5K+d8hqikXFjia+0LJp33n4W6kTVJNOgo
 v
X-Google-Smtp-Source: AGHT+IEevPRBMgGW9AzdwAOYT1e4rQc8RU+6HkCg9vJCaNaj6kI1S/o6llW4TwiqCKixriLxZYgSJQ==
X-Received: by 2002:a17:902:f7c3:b0:1db:75aa:7f6a with SMTP id
 h3-20020a170902f7c300b001db75aa7f6amr751041plw.20.1707978066567; 
 Wed, 14 Feb 2024 22:21:06 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:21:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 31/36] linux-user: Allow TARGET_PAGE_BITS_VARY
Date: Wed, 14 Feb 2024 20:20:13 -1000
Message-Id: <20240215062018.795056-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

If set, match the host and guest page sizes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-30-richard.henderson@linaro.org>
---
 linux-user/main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index bad03f06d3..12bb839982 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -55,6 +55,7 @@
 #include "loader.h"
 #include "user-mmap.h"
 #include "tcg/perf.h"
+#include "exec/page-vary.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
@@ -680,6 +681,7 @@ int main(int argc, char **argv, char **envp)
     int i;
     int ret;
     int execfd;
+    int host_page_size;
     unsigned long max_reserved_va;
     bool preserve_argv0;
 
@@ -791,6 +793,16 @@ int main(int argc, char **argv, char **envp)
                                  opt_one_insn_per_tb, &error_abort);
         ac->init_machine(NULL);
     }
+
+    /*
+     * Finalize page size before creating CPUs.
+     * This will do nothing if !TARGET_PAGE_BITS_VARY.
+     * The most efficient setting is to match the host.
+     */
+    host_page_size = qemu_real_host_page_size();
+    set_preferred_target_page_bits(ctz32(host_page_size));
+    finalize_target_page_bits();
+
     cpu = cpu_create(cpu_type);
     env = cpu_env(cpu);
     cpu_reset(cpu);
@@ -804,8 +816,6 @@ int main(int argc, char **argv, char **envp)
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-        int host_page_size = qemu_real_host_page_size();
-
         if ((reserved_va + 1) % host_page_size) {
             char *s = size_to_str(host_page_size);
             fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
@@ -904,7 +914,7 @@ int main(int argc, char **argv, char **envp)
      * If we're in a chroot with no /proc, fall back to 1 page.
      */
     if (mmap_min_addr == 0) {
-        mmap_min_addr = qemu_real_host_page_size();
+        mmap_min_addr = host_page_size;
         qemu_log_mask(CPU_LOG_PAGE,
                       "host mmap_min_addr=0x%lx (fallback)\n",
                       mmap_min_addr);
-- 
2.34.1


