Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716CBD3E77C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SNk-0002Mq-TZ; Tue, 05 Nov 2024 17:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SN6-0001Dt-Tu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:50:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SN3-0004UV-9m
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:59 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so1591125e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846996; x=1731451796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKLOS9+H9ykYcRJyY9KVpn0N4yWwkY5/7pJAXitW7dc=;
 b=OM9B2B42KjSIOcDD9vfZbZqwIu5p61jYNg1iGfq3M3wbTmHFVPmXYHjEbtthil8d+u
 C1Q+G+b+w5LOUdKamxu88bKrr60qKa7SXP50rdZQguw8UZShKgI3mXPVqsZ14K+os7SY
 WyG2ikJqrJ/2Op9AuFA7aMwnNHuSEUqYEbsJYWo9ePJrQTjDTvMfpzd5Vv7EWXHaBklf
 H3gZwW/O+DsQIYbMtW9rRP2N/0IalUSaim+ZvTxNFtj8FArGeL7L6D4MyJuSjLQ+pH0l
 AZ++xr6mvRm6QsawzWC9LEYFsB9sTTU/sb9uRQbK7tOdCYjg0sE3VlIx81rtVX416RyX
 0plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846996; x=1731451796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKLOS9+H9ykYcRJyY9KVpn0N4yWwkY5/7pJAXitW7dc=;
 b=rF/IetIrbPgslp56Aiv6x9stk6crKMEfye8x9QxFu3kVKC7MA7Dk81sHoJ7pR/qMBd
 PUTK3wn/JxQ22iAYsPcV3j+fNDZq1TNrXahGCVtWfaN+/9JxVWXOKo51jZlnkbni3M8t
 iQemn8oTpiFe0j0iOq7rXZehOL8m52ZbrRtj8CP5oxkIiUrWxAjtZ7VbAqSfzjroC89A
 fdTo4W95TsupJcUqgSaKSvo4m32jAD9YVSGpxmcmlOXAKe7WPxU4HzdWKnS4Ou3n7ZSc
 40bdwv6puFJpPtVHvxn95ON6X4/TriIS7onq/2JvleCaljuZ5IMbTaiUt6pEiNGJvpon
 ijWw==
X-Gm-Message-State: AOJu0Yy3MXEd0NERlTu9cAlcP9ikWbPtTM8GsIpxgCvLu0bK/F69qsXB
 NzmCOIbZCqkKd/DHrcYMBHVKOmWphua46nJzZyJi7TfX/Xrh4NbV9wLmGl1He2dc6pBR+31BFO6
 yCcWnDw==
X-Google-Smtp-Source: AGHT+IEQPjs9PVv4KjDFMbEMe9shMLh/l924DzY7BOZMdINZJO5sNzGzsshK/ayF9C8+Z5NO/+z+/A==
X-Received: by 2002:a05:600c:511a:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-432a9a8c882mr3056455e9.4.1730846995652; 
 Tue, 05 Nov 2024 14:49:55 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6bee9asm1097045e9.19.2024.11.05.14.49.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/29] hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:25 +0000
Message-ID: <20241105224727.53059-28-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-24-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/rtc/ds1338.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index a5fe2214184..13472c56703 100644
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
+static const TypeInfo ds1338_types[] = {
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
+DEFINE_TYPES(ds1338_types)
-- 
2.45.2


