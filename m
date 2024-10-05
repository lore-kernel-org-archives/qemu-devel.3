Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B945CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkY-0005dz-LN; Sat, 05 Oct 2024 15:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkK-0005Pt-5W; Sat, 05 Oct 2024 15:47:20 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkH-0007ht-D5; Sat, 05 Oct 2024 15:47:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso27841045e9.2; 
 Sat, 05 Oct 2024 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157635; x=1728762435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlo3i+gTLj++N5p9flHBUDt4I/6LJsfJbAWD74BnZ64=;
 b=dTAncQbpZVJkxcqAWnq7QiWjyT2sCc1akVlGL7sLycn1Tfm06I4Ess2IpSelom9CIg
 Ae7o11RuizftlteC26DIHZg2LuoCQJuOYlpTPh2TlP9sVZ31xI/B3Tabg9WQpdbA+J80
 xWktwF3/eg8V4GRLd7BjRZ/IKccc/fTF9B7wFRmD3ZLvZ0oYhJQdPkk12tqFhfFksMqM
 SLzHDV2qOVwPmtBHLXvehnGyipB1v2+nQygQSTS1qzh5ipdtd3+63b7NKMH01Fz+2iQq
 Hxkk0pHC7nzeqdntSM1sTqdtIR7N6XdXWHMz0wWRRg/hqsIZA3MIA8FD7BP1Z9AKE3KV
 k7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157635; x=1728762435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlo3i+gTLj++N5p9flHBUDt4I/6LJsfJbAWD74BnZ64=;
 b=HWrzyUaZUVZObdcIgoRAfnZIzQl1xuYmO6RYjej/rLcHscuboEi1DegFpY6BDHrwo0
 kU6PkMAHJQYr7YzONOIwVW2OxZ7ErIto67vGvFXhVEfyLU/Sh4prKOHIzbQdWllocuvI
 Gqlx10gFY1nhWxIAes2rzNAOZ7DWrNc2MHk9hST4xqRUnVECRDaCcMjgoWKw9jBs7JY9
 oouGzM6zEM1W28jnwpxlQMQaZbnbBeGKU16XpKMgTloYi4AFv72Q/oPB2qvW3lbiuFWw
 jmXPQj1wQ58DzKo211+i0Ac1fpVI+425yEcY8smnaPaxDpC9rFWFsk/fku1fkrNIxfZ/
 h60Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzzNmsW33LhK8jN4ds9nqaMj6T1tt2gu0Z5lirzYlCyFCizfxf05BE4qtvlyFkMNY3OrjR3Dd7HWsT@nongnu.org,
 AJvYcCXISR7g75PZCmnkp7v3eyo7742lTRKEeXV/laI84T8Xl6+SXgCh+Rwv0kov+rsKeRqualu/Bo5sgg4=@nongnu.org
X-Gm-Message-State: AOJu0YwU7A/cKNwgVQEk/CKq65izPCEu8IH4E7lfAJXdzi+6Yva9mcqw
 1VFq+9le3EVRU9kS2JXqdh1zxvdn9tV1JEsHpNY6oszeCUFX81EjOCf44g==
X-Google-Smtp-Source: AGHT+IHI83yUKp89dT6LP0Dpvj6BdGTmrYklOh6AFId/2wx3C2RRwGEyaz7y93Su55OMCZa8oq198Q==
X-Received: by 2002:a05:600c:19c6:b0:42f:8515:e47d with SMTP id
 5b1f17b1804b1-42f85ab68femr52037945e9.11.1728157634972; 
 Sat, 05 Oct 2024 12:47:14 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:13 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 15/23] hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:45:55 +0200
Message-ID: <20241005194603.23139-16-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
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
2.46.2


