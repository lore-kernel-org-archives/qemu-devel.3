Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838F4C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSdc-00026n-IK; Tue, 20 Feb 2024 11:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdZ-00023G-Qh
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:29 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcSdX-0005Er-Q5
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:06:29 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41272d92b8dso778065e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708445186; x=1709049986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJNxNHiqA9T4HKtvdwd+S2EJnh6+yff9KeawpRzL/Bw=;
 b=oI7uj454n/km6OvPtvr90DbHlQ2SSeULVG46ZJayK4s2tAX9N1vFSF7HgFt87qId1q
 jHuGRNvIxqv5pbbUITDNm1WpmHAo3vBLSaW7hzji91bGn+JKOOJDmVd1E0eHJIAF2JTp
 Vi67ty5vvp7bFijenLF4WZ4lUuTOamx2Z5taWq12ShWtZKMoMlgkII2MD+tl0MycXL4j
 jPWyRWy8N/JbSgrQx/iUrpH1MXSkL+CCjwfggsDprVL5PknrFl8cJYIdhH5jYOSyVCeq
 TVy0vpAuyvC2xzFJK+v4uFtadT4kaPCK6WIMAT8JSDPhZ2N8nE89bNzSAHwXwLXLMtzf
 yh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708445186; x=1709049986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJNxNHiqA9T4HKtvdwd+S2EJnh6+yff9KeawpRzL/Bw=;
 b=bzeOKFgcUIY/pvizF45MeTLVzChVzsg1qoI5/mi18JLl+vd6iSO/8LmY8yX7ekYgPb
 GTVzjno2+bg6fYqGwtkietiWqK1UPuVizKpdzY7wtKgoNDqif3t6+OBMJWcYSeBQhDhH
 g24DbAyH7CmG0rAWRB7QH0Iw2iSEle878y39ZByfiu6MjHNjmfvE7crMq2Uezw92pdro
 IXqAMUZI+/TxCuA81hMackiLcrixHoqr7LWMy39zQhDAGVMzyZCzDw2i38jIwAF6ZNu+
 UATLIP2TxueExzSUsx3DM466xsJ8MN3OKckyP2UFdxoHR7VP3/i2j5UggrMzrrKDZipC
 6jmw==
X-Gm-Message-State: AOJu0YywDHyo2CHoefGPe5zgTBjHTbLJMUm09Xuot3B9NPcoZ/lz7zDB
 7WAIhcVnw+iL5/Bo0MEQwA71T0cxNoNgLipwvNAvk9WHsKMQT8m8zcL4XZaV0+itbES+9Rkn5a3
 K
X-Google-Smtp-Source: AGHT+IFeU5PZxzVPy1Gh00CPjFD54ps6gsQeXY+rE7vJtnAWAZ4tVlTT1oPapjSX9s3xitdNZ7jM3g==
X-Received: by 2002:a05:600c:3111:b0:412:71d2:9c17 with SMTP id
 g17-20020a05600c311100b0041271d29c17mr742858wmo.6.1708445186459; 
 Tue, 20 Feb 2024 08:06:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b0040f0219c371sm15299927wmq.19.2024.02.20.08.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 08:06:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PATCH 03/10] system/bootdevice: Don't unregister reset handler in
 restore_boot_order()
Date: Tue, 20 Feb 2024 16:06:15 +0000
Message-Id: <20240220160622.114437-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160622.114437-1-peter.maydell@linaro.org>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently the qemu_register_reset() API permits the reset handler functions
registered with it to remove themselves from within the callback function.
This is fine with our current implementation, but is a bit odd, because
generally reset is supposed to be idempotent, and doesn't fit well in a
three-phase-reset world where a resettable object will get multiple
callbacks as the system is reset.

We now have only one user of qemu_register_reset() which makes use of
the ability to unregister itself within the callback:
restore_boot_order().  We want to change our implementation of
qemu_register_reset() to something where it would be awkward to
maintain the "can self-unregister" feature.  Rather than making that
reimplementation complicated, change restore_boot_order() so that it
doesn't unregister itself but instead returns doing nothing for any
calls after it has done the "restore the boot order" work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
It would be nicer not to use reset at all, especially since I'm not
a fan of conflating "system is reset" with "system boots", but I
didn't have a good idea for how to do that.
---
 system/bootdevice.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/system/bootdevice.c b/system/bootdevice.c
index 2106f1026ff..2c55c9bd90c 100644
--- a/system/bootdevice.c
+++ b/system/bootdevice.c
@@ -101,20 +101,23 @@ void validate_bootdevices(const char *devices, Error **errp)
 void restore_boot_order(void *opaque)
 {
     char *normal_boot_order = opaque;
-    static int first = 1;
+    static int bootcount = 0;
 
-    /* Restore boot order and remove ourselves after the first boot */
-    if (first) {
-        first = 0;
+    switch (bootcount++) {
+    case 0:
+        /* First boot: use the one-time config */
+        return;
+    case 1:
+        /* Second boot: restore normal boot order */
+        if (boot_set_handler) {
+            qemu_boot_set(normal_boot_order, &error_abort);
+        }
+        g_free(normal_boot_order);
+        return;
+    default:
+        /* Subsequent boots: keep using normal boot order */
         return;
     }
-
-    if (boot_set_handler) {
-        qemu_boot_set(normal_boot_order, &error_abort);
-    }
-
-    qemu_unregister_reset(restore_boot_order, normal_boot_order);
-    g_free(normal_boot_order);
 }
 
 void check_boot_index(int32_t bootindex, Error **errp)
-- 
2.34.1


