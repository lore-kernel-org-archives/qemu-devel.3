Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBA1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKE5-0004NI-DS; Fri, 10 Jul 2026 19:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDn-0004HN-JF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:29 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDl-00031y-GD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:26 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-381891a9525so1792919a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724483; x=1784329283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mXnvKcZP9AChKOwVNmnhtyA36iu2kjvikfZ1oQO3isc=;
 b=kvB4FTkPb85etVRABGcWso2krC/PUFQ1vPut0zZcVS8OkCDrN7aj12VgayM4Mgqjf4
 4Bu8iCRY7w4UBuIV4TNj4EouXXlxWfC+2ADln6uPd/uTbHlFK8+UanrGLeLIJ0sTOuJf
 7f8nj6EA7j1UqxenkZigbBmp3Z3k18TlFH7ftiz+Fthh97s6BBXIvcCBVwC1fJugXOGq
 7fl0UICNAq+JlabNKFANjoSBrTt732hRwHeJ71MXbeP63Es6If/idOxbm3gmoD70XAKh
 c4aNEUViambo/W/TLO0tbz8Ea2H3CJhd2zLDYynWsCr+eHEeXTYOM5X8F9tjkiRkIR1A
 09jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724483; x=1784329283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mXnvKcZP9AChKOwVNmnhtyA36iu2kjvikfZ1oQO3isc=;
 b=sLcSK+UoP+swcK+viBIR/2/LYBBRmVbItgwl81qfut4TRRngJRC9WGB2OwcNde+XMz
 indNamPEDvZOuUmR9etYlWdus3Jw01mKpnxBWkSsMw0yv9KCxuU1JiLZPPylVzDd4Vo2
 cIe9evvFifPNd1jjP4pPmwAD9CyVE3uA/DsD1+WlL2JRfphMc0oRzRpKPJwq+QaF0Bl5
 rYXSQkHOpnQ+NnjjaZDZzhC4Dc1/RXINeeJpIVNCqY8cZH3/HBWGI6/1SuPHGCWH9woh
 KiP8ygfj0hJRDxLA9CG1BOSLS4ggHsPP7Cb0hc2xIMmwf5DEpxCkSAM4d+ksebddMI9W
 5TeA==
X-Gm-Message-State: AOJu0YxP7abcqPGHzxbmXO90jz911Q0qMq/vLik5EoEe8JPb9DrDewEv
 gMjjx41q5uCt1pngZuDuJE26y3K0+PKjnvAmeZa4JDwPuJDw5Gon1o+UELRQAMJ96Xirlptn8bc
 gvXaB
X-Gm-Gg: AfdE7cmvlzerwwiRw4Bt2Pd7EpzFBlSSmLP0G2MbCTOObT07G9h4uXeZayBWakkQrSk
 GJ2/8OslQtCG1aBJJESYDXORa1n872ieM420AD3texSSU5UvrHjpNKwEsul3QVYVQKYqIFnHDE7
 M7ZLaChuT58uNrkOuwVnwzpV4X8nnfWgwzpwzcZbG08Wv197Kbc/mP2fpaZMI1nNpXBFvM9MIdL
 ve9gfaL2hJGgE0ntLIBxIM5MSpt40CO76ezIKeAru5nUCA3BncW6es3QH4La+nI0jhaf0ab+ymW
 7W1PJrJPWyEpC6MGyp5Nvd65oNCQsi1SG5nRWWzFD6v8rLWpd9wHSAMMl5PN9KvdqRznkhru1/+
 k5TWqHwI8TEuEH46cdWqM7yaORGBlfd7uM8XhrdPpid5oszgme6V64xMF+SVd2HNW/xACMbJc2f
 9x9DgxyfVBwCHJ1gvq+g==
X-Received: by 2002:a17:90b:4c49:b0:381:270c:4dd1 with SMTP id
 98e67ed59e1d1-38dc774d270mr753533a91.20.1783724482976; 
 Fri, 10 Jul 2026 16:01:22 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Warner Losh <imp@bsdimp.com>
Subject: [PULL 07/13] common-user: Initialize mmap_min_addr for FreeBSD
Date: Fri, 10 Jul 2026 16:01:10 -0700
Message-ID: <20260710230116.900171-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Use sysctl to fetch the vm layout of the current process.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 common-user/mmap-min-addr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common-user/mmap-min-addr.c b/common-user/mmap-min-addr.c
index b2b3762386..830c6f66a0 100644
--- a/common-user/mmap-min-addr.c
+++ b/common-user/mmap-min-addr.c
@@ -5,6 +5,10 @@
 
 #include "qemu/osdep.h"
 #include "user/mmap-min-addr.h"
+#ifdef __FreeBSD__
+#include <sys/sysctl.h>
+#include <sys/user.h>
+#endif
 
 uintptr_t mmap_min_addr;
 
@@ -31,6 +35,15 @@ static void __attribute__((constructor)) init(void)
         fclose(fp);
     }
     mmap_min_addr = min_addr;
+#elif defined(__FreeBSD__)
+    int mib[] = { CTL_KERN, KERN_PROC, KERN_PROC_VM_LAYOUT, getpid() };
+    struct kinfo_vm_layout info;
+    size_t info_len = sizeof(info);
+
+    mmap_min_addr =
+        (sysctl(mib, ARRAY_SIZE(mib), &info, &info_len, NULL, 0) < 0
+         ? qemu_real_host_page_size()
+         : info.kvm_min_user_addr);
 #else
 # error
 #endif
-- 
2.43.0


