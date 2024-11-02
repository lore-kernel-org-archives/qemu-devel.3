Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB35E677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E1D-0003lW-Uq; Sat, 02 Nov 2024 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0t-0003Aj-3p; Sat, 02 Nov 2024 09:17:59 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0q-00020l-6P; Sat, 02 Nov 2024 09:17:57 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so359053766b.0; 
 Sat, 02 Nov 2024 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553474; x=1731158274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLhvTnGk1a2G1u/15BCaoUHmTdjX5JW0/q8sRHtkRz0=;
 b=Dud91Jgb9zX17GtYQTgj0PxozZaT7fObBx2+zgRSFZhmbFm4DaRASPZjrIKvFnFgzb
 zxB1mHedo5B+zwMX8dtKA0PEtPvNFGgIi+hfnX88hSlKedE/wZKkFeBnPvEE+jjNZc8D
 j0gWMMkn2GC6Wb8jZqIwRRw3tPR6KApyPkaM4Ukt4gXUNobi7CiMl1h+wUF1tI9tFeTy
 Bm1UDzl8iZLsnqJkpCNKhe9BenM+geGgwrvHI1OLLElpZ72KoMLPNmjGCy9Cz6TD5ZlZ
 hWy+a3ICsAoQAoKeYLsIdE8KAF9iJVzLy3Rp32oC7WNZSOXaxVinXh2gAIMAtDNBaYyM
 esaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553474; x=1731158274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLhvTnGk1a2G1u/15BCaoUHmTdjX5JW0/q8sRHtkRz0=;
 b=pd+njKRAYyFiWlW4n1bkyN5TvSXc8hEbB++VQIawtS1Qoew0zAW8v3l/S/mCk6Y3jI
 DdD5KhQsLzEGlHAMvuuIWl0/tOTLyNtPkzdD0YptqnXl0/ze6yqhTtWPhM80aEAOadEV
 BdfXb4Ooab2ZELtb6SK411gXVvBhshjYdGBmgUadIghSPUgZ6DLWZQkHSD4UVo34NoLq
 7MaXZmIS9/npY+uQO23ygSbg7K2WD6OvEigUWfLqLZ99ZMRC6JsbYYC50I6BUlYwodNw
 tIhdYU5XqZJhcxzoiYCnR/o+TdD1GMtUZMOos04vH7pHgXGXY7HtvN4z7p7l12cqK/uh
 x3Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm58i/i08iEH/+J/TppvWdlJZDZtYFeJcH1B7nEfLutQAdZ4CXCAlTL7/FrLm+REQz50NGNrZCB1c=@nongnu.org,
 AJvYcCVkWWwvmClF+W35OozY1h1AUtf9OKVBD1kk/jputFDh0DONij7SWwPG2IUIUKNbP6JPpS5hMkUeXtv+@nongnu.org
X-Gm-Message-State: AOJu0YxalX60z7AS+efTVCxeez6hfVBS7PydTAEMaCJDHcakqRVuy8rC
 WUWvqfEKg+O9Wh7i/uGWFD1WJr6zR9HzrpvKmUw9zBaFPvjEBJLObykQsw==
X-Google-Smtp-Source: AGHT+IG4TqofOzMYlylLy2GxOiNDxCKKG+UEqxBvjxycuEV1l1cK0Pd3FKjpCN8Hz+2FMmc7qUgjow==
X-Received: by 2002:a17:907:d1a:b0:a9a:c691:dcb7 with SMTP id
 a640c23a62f3a-a9e5092d45emr808853166b.30.1730553473527; 
 Sat, 02 Nov 2024 06:17:53 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:52 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 18/26] hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:07 +0100
Message-ID: <20241102131715.548849-19-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/mpc8544_guts.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index c02b34ccde..cf2317b3ab 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/module.h"
 #include "qemu/log.h"
 #include "sysemu/runstate.h"
 #include "cpu.h"
@@ -141,16 +140,13 @@ static void mpc8544_guts_initfn(Object *obj)
     sysbus_init_mmio(d, &s->iomem);
 }
 
-static const TypeInfo mpc8544_guts_info = {
-    .name          = TYPE_MPC8544_GUTS,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(GutsState),
-    .instance_init = mpc8544_guts_initfn,
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_MPC8544_GUTS,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(GutsState),
+        .instance_init = mpc8544_guts_initfn,
+    },
 };
 
-static void mpc8544_guts_register_types(void)
-{
-    type_register_static(&mpc8544_guts_info);
-}
-
-type_init(mpc8544_guts_register_types)
+DEFINE_TYPES(types)
-- 
2.47.0


