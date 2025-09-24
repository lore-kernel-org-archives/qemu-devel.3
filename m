Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9277CCAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UmJ-00076S-OL; Wed, 24 Sep 2025 15:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkM-0006It-Sc
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:01:51 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uk8-0007uh-9u
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:01:40 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-32b8919e7c7so217183a91.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740486; x=1759345286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpRgmvlnblTavvJMOahhBlpUf6JZRFziBBrDwUTk1LI=;
 b=gAqw6SAh7BX8nwj7RN23804TGUy819W5Nkke2lyFDMezHhRmD58cv7YH9WVPPuMrZY
 yq7jv2Mk/IP8inShJuKDR2fbdeqCVwaGheZeJ9/7Um2GSxzwuUR9IKO59MonSFqLIr8l
 C82BS8tvBe0J7cgKm1NT1MZpkTy9R/T29cO4XttsEPIxlStg6o7HXVo/D1NGHPhSEbEH
 OSE8YZi6tojGZuvB4XUQkySLU9exQlFCoGKx0xMfSBsPNL3ZoodsOzG57i+Ykjnq8roV
 TQlFRUGoC/LQwHEGkFSGUbgW3ynQBa7wwPb5soH1Nlxs/XLjfk9d0j2YwLxIXQ4kdP8y
 OY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740486; x=1759345286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpRgmvlnblTavvJMOahhBlpUf6JZRFziBBrDwUTk1LI=;
 b=stDCm8NXSLjnUiElumkcawagK82BkK1TRNrhM2A7URRvNjTVpgAR1Bfzu58hRA1eu1
 QpKf9R0dY4cIRNmyIR/Wd/iEwHPiAhzJP40ggOLakm7K9m2bdOdLzGK5sO8VRD64xDlK
 iwxbY7ryqj2N7CAuX079Hw37DdJ8ayMvSf32GZCakZKFzyowRwlLns2DbpzctxHvFzN5
 EcD5qT+E3lKoUAMlzyAqzXFO338qSmi+M1tNloovvfYk9VLwRMAobyGxCvLFUEmsq/Cd
 XAhnh4EWswZ7b9aU95ia3W7T6sy9MvsOhifHF2GTAEpQ4Oslw5we6anEIxNsjtfozzq8
 IY3Q==
X-Gm-Message-State: AOJu0YxKPlK+vVYqU/U4lOcdXezX7q9SXT+UNkPvglYNGGID7Uc6pDLV
 SPR4uBa3fC3oiAc1zlVU2sWv4g6ieIHVaHbaanlVYakGLQct9eJ+1Ea9ZlHNDqmVyfcHnKkbLzl
 pk3XU
X-Gm-Gg: ASbGncsKxq92hUbw1JwZyi0EJlCls3WZvrRQs7zuVOYhq+Ybq1PCLmXbnANaFgV4uJl
 Wkf6/BNGZIT7M2zBrRKeoT8N1Y7pHuu613vYg3uDSUAjya500nPfhG6Rct8H+n2xco48Y/WgTNx
 XSIEMOloQUuswpbyYMv0C9S8XEGUfv9hs3UxE3yKa+TfO48GIoEOZS38r2mmFNrjFUHsV7Izgcd
 M3fYB2K/YBJf+QUuE+CrI+9I0DBhW/faD2V5268ZkY59Mrq62KxZv88UkWX8TJka5yZu7SFnMeS
 lZmFeG7g4pr4OILLNhiqTdGodo1SKJZJKANs5f+nZTRzV5JWO+CblQiHh/2xYq4DyVvI3ty+2Te
 yPhuWPpqCVp+Zju6k9vqjWdFp0kCb
X-Google-Smtp-Source: AGHT+IH8sxUckrrfyl9T1HrjKLvPasB2M/1HRh3b5ADeOx5OJzP5yMHyDkYjhjy4151sjdIubwwtdw==
X-Received: by 2002:a17:90b:384d:b0:32e:64ca:e84a with SMTP id
 98e67ed59e1d1-3342a2436b8mr987319a91.12.1758740485494; 
 Wed, 24 Sep 2025 12:01:25 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 24/32] hw/ppc/spapr: Use tb_invalidate_phys_range in h_page_init
Date: Wed, 24 Sep 2025 12:00:57 -0700
Message-ID: <20250924190106.7089-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

We only need invalidate tbs from a single page, not flush
all translations.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ppc/spapr_hcall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c594d4b916..8c1e0a4817 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -8,7 +8,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
-#include "exec/tb-flush.h"
+#include "exec/translation-block.h"
 #include "exec/target_page.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
@@ -301,7 +301,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
         if (kvm_enabled()) {
             kvmppc_icbi_range(cpu, pdst, len);
         } else if (tcg_enabled()) {
-            tb_flush(CPU(cpu));
+            tb_invalidate_phys_range(CPU(cpu), dst, dst + len - 1);
         } else {
             g_assert_not_reached();
         }
-- 
2.43.0


