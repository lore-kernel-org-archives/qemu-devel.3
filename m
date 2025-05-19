Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEF5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3J-0000b6-Ob; Mon, 19 May 2025 00:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmr-0004l5-RO
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:40 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmp-00048s-E1
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:36 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b061a06f127so2580937a12.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627654; x=1748232454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcTSIVF8fD22KtdcMyyIobQ8uv5lgIlmowtqHalYg9s=;
 b=C+eD6nqhwZFLgk8ZjMaDMkSehvmImT+/S4XZzyWrXP44u9CJoAbRSA7CaHJqS8zRD0
 quO2FFpv1Ikn7ci7n2Q27bi1ELnm+b93dBW/sCbNuTvTYIY3PJvM6keXHK4xie9KoLZK
 +1/+f6FH4IQpczk0n39svRS13P61foKayWQSgouo0/ErjVjNkl7owmKSrjS48OCOW16T
 Ojt3hWhd5niw00HzdxmQVW1q5VBV0vYHjJ4BZYL891TwOjC0FwlsoJMkXGeHYAPcTo+H
 RrvBR8hgqc0Cm7A7iwn21abupYuJ8fZidSiWqj5Soy7KzDs6rjrjEQPEQ4wTQPdt7pKo
 Ltkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627654; x=1748232454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcTSIVF8fD22KtdcMyyIobQ8uv5lgIlmowtqHalYg9s=;
 b=ISU7pUYP7c1+iip1YNx/iduUHrb+gtsEe7/nE08dpFUGsWr2NVlpicNzb3xB8WYKSe
 tn3InLmrYZ6TDrxZU/rW/7GvIX8iZYhi6Ci6o0N2dy93CfwUleXvJJveKC9rp1RKLBpK
 9SMbrEoR7/KvQJALoHO190Thvn9o8TEg5UB4MZ48OXSKA3vbM1OhuAfM6iehODOLHFD5
 Qeyx6B8iK+Rad95Z5fiSySP+hCulgMsTxpcxWbE3s2e7fThUsv3JmMfRrinHaVcArAaJ
 poU4UkQcrN3GuXrWjDrGhN9R4nUNSnJooG/QuMnqgvwllESsfGBqdgYKI1a8HRp+Zva7
 EhFA==
X-Gm-Message-State: AOJu0YzuLW3zEnv+WL2JtvmVhaPXzM/sNwx6Pa1p81V8RWHiCRxqMLKz
 xrFdvK5BgcQnVWIOb1gThQXhsKXVf6sM/dfvdQ49gITMKutplNxcCRA1Cx3lzg==
X-Gm-Gg: ASbGncsXRMSnZb/OTg4w9z+Q6liKHEmI3OWfnuKL4ip9Nkf5/YzlyOw3jWQ8xaY8miz
 sJ7OsKUrbj8tch8tSKiZ3qfGQ4UevvyhXx+f2e15W2Oq5zGJao/831Xt6bWCx2C0UylrtWRMb0E
 AjgxFt3UAnuAoi8UBpP7eqBIVX9oJyAZQoP/IHEAHYmztyiMsSrFHk8DFzJ4WacgzBThafMwQeN
 0xWB3LiSeNzhybF0V4FVtxmA3lavSiqU8o/od5808AS/JV5n04c4CpLYdbbujzLKaELBhq4tik7
 cMt+ZWGEgmGW0BotBXnvErDTzDyupHhe7ddsdBqWBM2B7zRx1oyT8m9zWnOGTC/czRVVDRTavUu
 vUiHesOGHsTh1z18SwT8tdXkH//wMUp+Axg4pGJpdivwE1JTz72YJwpW3
X-Google-Smtp-Source: AGHT+IHH3JArvwsDD+ieQaiWntf1kCuSLrGexKAK94DWbXN7N6KJXRgcVqUhjA0/xnvXaH6Ve39R+Q==
X-Received: by 2002:a17:903:17cc:b0:22e:5389:67fb with SMTP id
 d9443c01a7336-231d43d9bedmr151572665ad.7.1747627653788; 
 Sun, 18 May 2025 21:07:33 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/56] hw/misc: Add MPFS system reset support
Date: Mon, 19 May 2025 14:05:06 +1000
Message-ID: <20250519040555.3797167-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250319061342.26435-2-sebastian.huber@embedded-brains.de>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/misc/mchp_pfsoc_sysreg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index bfa78d3d2f..f47c835f80 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -27,7 +27,9 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
+#include "system/runstate.h"
 
+#define MSS_RESET_CR    0x18
 #define ENVM_CR         0xb8
 #define MESSAGE_INT     0x118c
 
@@ -56,6 +58,11 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwaddr offset,
 {
     MchpPfSoCSysregState *s = opaque;
     switch (offset) {
+    case MSS_RESET_CR:
+        if (value == 0xdead) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
     case MESSAGE_INT:
         qemu_irq_lower(s->irq);
         break;
-- 
2.49.0


