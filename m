Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C47E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E1A-0003Yr-Nq; Sat, 02 Nov 2024 09:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0y-0003DL-A9; Sat, 02 Nov 2024 09:18:04 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0w-00022r-QI; Sat, 02 Nov 2024 09:18:04 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so437994366b.1; 
 Sat, 02 Nov 2024 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553480; x=1731158280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZZ+5ovmnVpC5NTiYuiewUtYnzTYhlFm/LIFM9Feu0w=;
 b=mJxTvW21uoBNQo37IZMR/3KURVEf6SGa9wbVUZDbWZTmZg2iVNmVkEzT18N5H1eqC+
 CkAtl0RrdqPKl35HSiJulJf+rtR2KUx8JYA6DZ3hdCNSO+kUOxjm5pTk3V6yYzNOYzs1
 rUCrtXt03n/0XxnqDIXGA+0HUiSPYYAoscqeNDaHJdQ+tRlXZ4cY0bAFn7vCQNYOXmFc
 ECbi4ioZ4iD0gNZbf9k6GAEDVtg1+0tRUN+kiBjwoiWVxWkaLy6ENRBtL0RfM6QSIRli
 hkRYqFDKRKCl7Q2wZXS0rguUIj8o2rGUogBOVG0x3K8uB8JRCfn3JtLBcyv9KIYOi1Yf
 Vhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553480; x=1731158280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZZ+5ovmnVpC5NTiYuiewUtYnzTYhlFm/LIFM9Feu0w=;
 b=vFfXlHYUdZUkMQowvnGS7RJ9+3QfybefNOTMO42YFIWpmNthjnsQtzSaCwksVy4Iyu
 c4eqHlPIAJdWbOPKwHn3ZHeMtBETcUrC3sH3DaN3sQy83NV99ikA5q6p4YpRfRj/IPK7
 HmgCXjaNP1LBg12XAJlGxwn5/TMUSLz15WaDAeZXhB8Mgi6NVT/Ng6WYr/r6ZJzIcfXd
 tS+BfQSMWtdQ1khE5s1nhMg1CNTWAKLHFCkB/YiYJBn4FPMT1r1DG80iBvNfTjHxjVlS
 WeNcJWkl4Ohh6JaZdMTy08IadABPk73fHjoQXRn4FGfiQfaaQUtyMT0ZXpUc/kqsk6Dh
 zZdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAsc287hOEzdkb1in/S0/tYup4qWBa8pVRp9D9PQJ5qrdzVFaqLCtRAf918cdDEDkxBeivHOJ2FkwT@nongnu.org,
 AJvYcCUysmX1iLp7BD+xmT+UExTt+b9//g7v8wLLtgUw1LhCKYgQ81t7twZVuDqCHlWflrTTg/Xq9IgpILU=@nongnu.org
X-Gm-Message-State: AOJu0YxmJf8oBZskOc4ukzu7NU0NnFRPN0pcXXbcpKm09xSHsC0c+YS2
 TZlcRMyytClXOLL6rK5anmIBOX0RGrsbNO8KBTMfJymxA3gjXPV5zfw4cA==
X-Google-Smtp-Source: AGHT+IEbTuNte3+yzDCLPvNybPA71+5Bp9DMg0Md9ijXvAmgES/u4yIHdInF4foVrMZOkAqom7LZQQ==
X-Received: by 2002:a17:906:f596:b0:a99:5773:3612 with SMTP id
 a640c23a62f3a-a9e65507131mr558075366b.36.1730553480366; 
 Sat, 02 Nov 2024 06:18:00 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:59 -0700 (PDT)
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
Subject: [PATCH v3 23/26] hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:12 +0100
Message-ID: <20241102131715.548849-24-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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
 hw/rtc/ds1338.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index a5fe221418..6de13caf99 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -14,7 +14,6 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
-#include "qemu/module.h"
 #include "qom/object.h"
 #include "sysemu/rtc.h"
 
@@ -227,16 +226,13 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_ds1338;
 }
 
-static const TypeInfo ds1338_info = {
-    .name          = TYPE_DS1338,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(DS1338State),
-    .class_init    = ds1338_class_init,
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_DS1338,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(DS1338State),
+        .class_init    = ds1338_class_init,
+    },
 };
 
-static void ds1338_register_types(void)
-{
-    type_register_static(&ds1338_info);
-}
-
-type_init(ds1338_register_types)
+DEFINE_TYPES(types)
-- 
2.47.0


