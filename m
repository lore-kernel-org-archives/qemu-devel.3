Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C017CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPq-0003Rz-Os; Mon, 23 Sep 2024 05:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPn-0003Eo-Da; Mon, 23 Sep 2024 05:31:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPl-000710-RF; Mon, 23 Sep 2024 05:31:31 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so554382366b.2; 
 Mon, 23 Sep 2024 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083887; x=1727688687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTAYFcyEYOewFDEdRGbYScC4E5SZ9wSdgr4ijamJJiA=;
 b=PLQ00/hKHClPGaUAWOkwfju8iYzqyLRmN2deK3KaScJfD/l+yO51C8RnO6AFBWnonk
 Aw9E7/otsr1AgKPToUjDY3dExtPGM9FQ5NuplW2GUUo5pJdmTLcfymvp+E5eitWJ/J3x
 F0G6hktYBQ9aVighKq/bay172H/rsDLxyfeXr+kvC1GBYXmaEGyca87oUBPs+ciQPoD/
 /8OBLdE24xGqeZthdp9dC720VaxiLGiThuB78VDsQnhGyPHsFlcM+nhfHRLYhntLJO3x
 t/oW3mCl2+lza+dVE95SVyi404sihN5PE4n4jWQmVCYBFnv0d2R7dDYjyFaU3BZQmIRn
 QP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083887; x=1727688687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTAYFcyEYOewFDEdRGbYScC4E5SZ9wSdgr4ijamJJiA=;
 b=CB97WnazrMfu5BK/6J3z440QJwhdLioeJJ8Xmjtre78/efdEiPyWpDDbFQYMHDRt+A
 2d2fIyTRPV6/nxNppf+SzzE2dwASzX369N1RtANtxSyPgiWc7FDqhbCrY6To+KVHnRkK
 fRLErew2R1PknEOEWRytEyhfw2yIJ+oHsDGZvL6RbEU4JaoNb8sTyB3O5FN/Mw8kMtCg
 eP8CpjG/E9ExWxT44PuYuxMmu4oDjZYnqW+XK3uljXRcVUqH3hrOxXgRjwDy/0mQEY47
 nSict8mKaL+nOlnk5A4fFkrNV7+fADTKXlHMUq8vfp8sjFC5q9e79X/mzrBR0qRnLZ50
 5yfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWb8OlSvFhKIG9Q3hw9BLoOzsuprEEyerbSJJm4UIaQFfD9rO6kaylAoEjL4IS4n961utuimR405ed@nongnu.org,
 AJvYcCXjE0lvwM1ZU6OIecR96YVb+PJDzTHtmwVvsrgpssGU1ZNU09CiaGN1zM/YJsGV0znXRqeBPiGBXpk=@nongnu.org
X-Gm-Message-State: AOJu0YwxT22xCV1arOWqIT1BpMHfg6yeN7Ktw6z/gEN7yv1otjwdoqBH
 LHwMmGiiC2hJ5LSGV71gVnqQoZWTFmK4Swd/a58HdnSt32KdlZooqLqSfg==
X-Google-Smtp-Source: AGHT+IH7kOrGrs11twdPlGMngsYp2+d8ZkGLvegXkfNGuiCd4ENUXx5IN9HSNg7mJ0Qd0ZRKninr8g==
X-Received: by 2002:a17:906:d25b:b0:a86:f960:411d with SMTP id
 a640c23a62f3a-a90d4fdf842mr1140067166b.2.1727083887158; 
 Mon, 23 Sep 2024 02:31:27 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:26 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 16/23] hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:09 +0200
Message-ID: <20240923093016.66437-17-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/fsl_etsec/etsec.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 3fdd16ef2e..9bd886b996 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -36,7 +36,6 @@
 #include "registers.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 
 /* #define HEX_DUMP */
 /* #define DEBUG_REGISTER */
@@ -431,17 +430,14 @@ static void etsec_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = true;
 }
 
-static const TypeInfo etsec_info = {
-    .name                  = TYPE_ETSEC_COMMON,
-    .parent                = TYPE_SYS_BUS_DEVICE,
-    .instance_size         = sizeof(eTSEC),
-    .class_init            = etsec_class_init,
-    .instance_init         = etsec_instance_init,
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_ETSEC_COMMON,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(eTSEC),
+        .class_init    = etsec_class_init,
+        .instance_init = etsec_instance_init,
+    },
 };
 
-static void etsec_register_types(void)
-{
-    type_register_static(&etsec_info);
-}
-
-type_init(etsec_register_types)
+DEFINE_TYPES(types)
-- 
2.46.1


