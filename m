Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E97CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIqN-0003zZ-VA; Thu, 18 Jun 2026 15:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq5-0003tZ-Lc
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:50 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIq1-0007wY-1w
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:55:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c6bdb8a8bdso8665815ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812542; x=1782417342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXnvKcZP9AChKOwVNmnhtyA36iu2kjvikfZ1oQO3isc=;
 b=gSvlO/Dyvge2Z0ZLfd8rIiOFSKl6UD1VZUW9kMWBOMchnleRsMiqWRmnivPU1PIYkS
 bWhppxnj+HIDutu3yjxSDpEEjCSMCb7uctK4Gs0h3DRK/ufZepAuRUDCuBHsRwuQEZtm
 QMpmONyMotdpbmFA5yjAn8aoZYekhyQ7XUY2QnHVcaYAU013Zze6Gd/DUty127e9E8DY
 5LJdnVRAHmMh2aiZXyUat7YqjDQ8FswfC0xPRYXgdhRoIfnWVR5nuFFSDjLLb9ddVvYF
 Ck3a69Vlvifwr8anLEeqmHiJJ4KidVXz1wKYBPQsmbSG+TEWCPR87ohHGKzZrTzZnZUd
 VTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812542; x=1782417342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mXnvKcZP9AChKOwVNmnhtyA36iu2kjvikfZ1oQO3isc=;
 b=aEocUaNUsnCbKtTRDvZGqGUhH9Pc6O3MQFRtugknCn3e+Vq7CR1jFklh2uSmxjzbvQ
 V8WVS1kJYbAo+9iuL+rTBAkyxrQMbzL7eRm2QEdF8U4PiszSi5srY/RzmqDAMaPkQuJ2
 rup0apXgd2YTl0vJO8tVn6RaHbXNKLMHWj3LTI33oJIPHkZ3e71UTI4baQttGEehR5wD
 FQepI6G4FmGZl1GVbsiRP4op+F8S4OKfMfNObsUrFXorpxfuEwRojeZzhSwQlzBib9K7
 /kp1UWFRcNp2dNUccD5IQLryrVJrRXRpUpSI/WH1jt6Ls/cGW+4oxnki7hPpXIokOkT3
 lTDA==
X-Gm-Message-State: AOJu0YwI6hr7sExwuNQZEccFz5o7MgPBlHIVOV96EDKWUbPyvnFzvpxg
 6PZ7NFFKyZiJX2GwVg9Pbh3iiuX7RTwNu9SMDaUWuFnyVRK77kN1bXV3obrix7xu5v+xjlZ6S6n
 TzPrw
X-Gm-Gg: AfdE7ckfEK+WMPaFcR4o+TtE7EO1O8GMpieW3mWnP95Q6SPFEVr3ddn5ytgkhB0WGGh
 GXoH/kinFumzJppe/Ue8BDC3WRi2Z3TZS76O3lwX3jt1iMk76pgTSIsMyvi64qBtuj+3WtO1si5
 SdeDOukuiIaSuLG182Jfuy8+2YCRjB+u9K3y9JMaD6NyEgEHwuyM5/OL7KA9JIN4cGY8aTzwPk1
 qk5F/kM5xCAF56BxF1SK2dVTwNRthTxIWZanVfioRwhd8vqo9pZaM8xdcGojX5wqL+8ALHtTjrb
 NVxWIizMr7eNt8OHEVsPEG1q7GkM0Ne15KDELsQCifcRU/LCUVOdxEt7liOErkp43LErIDq6C0w
 tirLr8rGkuKmkLoIxutsVy+8FJeM6cF93KwW7VFipa9AxYp42rcsguSYkckALh3vjAl+Fzc/xoJ
 vgpEOSo1s21F3YZkGbPmbfRjRnh4nPdm4X+A33A7VXc270tnx90Q==
X-Received: by 2002:a17:902:f552:b0:2c1:69cb:4423 with SMTP id
 d9443c01a7336-2c718f61657mr7121835ad.14.1781812542162; 
 Thu, 18 Jun 2026 12:55:42 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205732965ad.55.2026.06.18.12.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:55:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 07/13] common-user: Initialize mmap_min_addr for FreeBSD
Date: Thu, 18 Jun 2026 12:55:13 -0700
Message-ID: <20260618195520.589907-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618195520.589907-1-richard.henderson@linaro.org>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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


