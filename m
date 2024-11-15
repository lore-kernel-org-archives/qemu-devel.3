Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC5CD68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzX1-0007wE-J0; Fri, 15 Nov 2024 11:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBzWy-0007vE-UU
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:50:48 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBzWx-0003ar-3f
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:50:48 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539f76a6f0dso960430e87.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731689445; x=1732294245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGdMDfkgBn2W0Y27sTh83LY39xw1q9oPSugpDU4vMas=;
 b=cIGSaNnA4Huh60ctPtljhxPSGqS06KOwkijwEJea1Ez435RYEMrnuQ10NNc7eEHgI0
 JDQniir8MtVhV/cm821vEG1784eAB6IjsgfjAviy6OGfU5/M7EYK+YbtlzaV/YDA/IWe
 4ll6cJgKGLKk3K8R9NqgKdvyV5Npe7BoJC1ttr+9OjrsKcSmvUYnOYTlGeMqPnuqnKFD
 HBuyNW3T0Cim+sJbfIEQ7aAiakHqCdTP6OwrIcMMEb+Z2dJ0qGKx4X9wVCbPabSM2lW5
 nTARnVqKRquIirYDo+JVHFTR+lazCihG+5L1V522h7MEt5rZTUzjBcAqikBB8yjb3EGN
 f5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689445; x=1732294245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGdMDfkgBn2W0Y27sTh83LY39xw1q9oPSugpDU4vMas=;
 b=Gv/uxaJQFfm1eHJ6K/+90YqBPmGVpfJDjEQzaiflGAH8AFqUbeZrHPI3R7cypL5Tex
 Mh7K/z3EecUNdh0GwpUuNU8mp6dIxl05hzzd5FCKlHXODC0TxCYFVlENyPSwT9L4XyDG
 7VQ5L29h4E781SRp0RUL+xb5osucCCVxRp83pv7VX55wbtBDSprbUJzqXxAVzZelCw8A
 LjVewJkPkAnENAHWzQzPatcjFaDEsaIOpxs3MUZVJL/3KH6NawXk+L04SNocxDVpzEyc
 D6NJizYTCpwkN3uKxpIBNY5ZtKGgkpmPH9YT8qIFFmKGujJ9234IAIy/9lUSXU6MiPmC
 GhDQ==
X-Gm-Message-State: AOJu0Yz/mER4hIOJ5+XXUWTj69Nwe3siGBAZ09XYVxs3MgJyxJQ8qRBQ
 j4yxKTqm097Rrpj72etEE3ZoeekVz+91HnnfKZ2P2TSAWBbUG1jAw9z75wnPLn8rXbTmMjm3/mI
 2
X-Google-Smtp-Source: AGHT+IE5ME5xQRxlsulJq1uJy3/7WMYG7vxzmcEfHxDuQbHr78euWlsste4OI4UhVVhGLQvQuk/HYA==
X-Received: by 2002:a2e:a586:0:b0:2fb:593c:2bf2 with SMTP id
 38308e7fff4ca-2ff6064e0d9mr19254301fa.3.1731689445369; 
 Fri, 15 Nov 2024 08:50:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0aef0sm60386405e9.28.2024.11.15.08.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:50:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roque Arcudia Hernandez <roqueh@google.com>
Subject: [PATCH 3/3] tests/qtest: Use qtest_system_reset_nowait() where
 appropriate
Date: Fri, 15 Nov 2024 16:50:41 +0000
Message-Id: <20241115165041.1148095-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115165041.1148095-1-peter.maydell@linaro.org>
References: <20241115165041.1148095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

In the device and drive plug/unplug tests we want to trigger
a system reset and then see if we get the appropriate
DEVICE_DELETED event. Use qtest_system_reset_nowait() here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/device-plug-test.c | 11 +----------
 tests/qtest/drive_del-test.c   |  7 +------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index c6f33153eb4..127a7f9efea 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -15,15 +15,6 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 
-static void system_reset(QTestState *qtest)
-{
-    QDict *resp;
-
-    resp = qtest_qmp(qtest, "{'execute': 'system_reset'}");
-    g_assert(qdict_haskey(resp, "return"));
-    qobject_unref(resp);
-}
-
 static void wait_device_deleted_event(QTestState *qtest, const char *id)
 {
     QDict *resp, *data;
@@ -58,7 +49,7 @@ static void process_device_remove(QTestState *qtest, const char *id)
      * handled, removing the device.
      */
     qtest_qmp_device_del_send(qtest, id);
-    system_reset(qtest);
+    qtest_system_reset_nowait(qtest);
     wait_device_deleted_event(qtest, id);
 }
 
diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 7b67a4bbee4..99f6fc2de1b 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -154,15 +154,10 @@ static void device_add(QTestState *qts)
 
 static void device_del(QTestState *qts, bool and_reset)
 {
-    QDict *response;
-
     qtest_qmp_device_del_send(qts, "dev0");
 
     if (and_reset) {
-        response = qtest_qmp(qts, "{'execute': 'system_reset' }");
-        g_assert(response);
-        g_assert(qdict_haskey(response, "return"));
-        qobject_unref(response);
+        qtest_system_reset_nowait(qts);
     }
 
     qtest_qmp_eventwait(qts, "DEVICE_DELETED");
-- 
2.34.1


