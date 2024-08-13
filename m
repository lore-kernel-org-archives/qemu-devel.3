Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E0DC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdulc-000541-Vy; Tue, 13 Aug 2024 12:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdula-0004uy-PF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:02 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulW-0001CC-Tx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:02 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so3242118f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567977; x=1724172777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zj3+M66bxOFhlrx+GWHtYLelzpxVSar2LL0gkYxOSew=;
 b=dWI4n96YJ6dB+ucPhVsv5sY1MlRLtlawskS9pRu0i/BAlYj1biBCVX8RhpmyriBkaX
 UT4bQWerk5qype9IDFjMe14/+cQOT39UC8biMedlQ4z312hcpmrqZMVcP0x0Irb/UufE
 zb/U9QW97a74tbRNaDkD0za9amTNa6ht5NmW8E+Rhba0jYCWmshYd28mi85BmmCSawdI
 dmo8tGxRZlwyLoHQnpNGu0/jfNMU6DUL/LaMCmKkZpP8Uky6HDy1KvUzpLSijIw7LDqj
 lUvBqEaAHVpCfOtr9t4OEEDx2ZppSe+U116SfMqZTTIGUkhhNrH/5DC+I2I/KkqcGmIX
 RlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567977; x=1724172777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zj3+M66bxOFhlrx+GWHtYLelzpxVSar2LL0gkYxOSew=;
 b=Bby5A4FklwvfVWXSsB69QX5WJkwR0zADdw/2txl0AQPhyszxr3jKD6gpuXlr7lOkmB
 dOih6b5vQuc9ovb0t4gSGRcWVJx3V0runqCVHQniiT1njoSF4La8++vjbGrr+KZtG/8i
 tQ6xpX106JJYWHo2qU/lNP/6jOKuOus+LMnwcWOuDAa+FHKGwh1i9dLvPWzO/zlGk2SN
 /SsJcbiHIpZ5DJ3GNo2nvZI1A8WlaqoszgkXcEjsMyGyeHvCLzDQRbKmFqmkAyJnzwIu
 NiyK6oapOnrz8I1NuItMrkqmLQU4QrvF1tkb+WR+gkWfkUniOg5JGlBX7HK8YgRt186+
 aIGg==
X-Gm-Message-State: AOJu0YyV6TAY0FNDf4QqPAqJHAfkPPgSxk2ddlPykbYkiYWLikXCeo04
 8Vd8OGtkc02cASTFB5EE96T+ME1HixO63dj7H53Yyk5YbTBvSRFSjv0l5aauRjZGoyVsEoTv/bA
 T
X-Google-Smtp-Source: AGHT+IERsvcfsRFgSKjJCUcyhZzyup5Bqq0jyXWuxR8GEUWHRe3Bl1w7DmQpuEJlbRds0qQeCuaWsw==
X-Received: by 2002:a05:6000:2a1:b0:368:37d5:3f2e with SMTP id
 ffacd0b85a97d-371777adb2bmr171586f8f.32.1723567977273; 
 Tue, 13 Aug 2024 09:52:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 07/10] hw: Define new device_class_set_legacy_reset()
Date: Tue, 13 Aug 2024 17:52:47 +0100
Message-Id: <20240813165250.2717650-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Define a device_class_set_legacy_reset() function which
sets the DeviceClass::reset field. This serves two purposes:
 * it makes it clearer to the person writing code that
   DeviceClass::reset is now legacy and they should look for
   the new alternative (which is Resettable)
 * it makes it easier to rename the reset field (which in turn
   makes it easier to find places that call it)

The Coccinelle script can be used to automatically convert code that
was doing an open-coded assignment to DeviceClass::reset to call
device_class_set_legacy_reset() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/coccinelle/device-reset.cocci | 30 +++++++++++++++++++++++++++
 include/hw/qdev-core.h                | 13 ++++++++++++
 hw/core/qdev.c                        |  5 +++++
 3 files changed, 48 insertions(+)
 create mode 100644 scripts/coccinelle/device-reset.cocci

diff --git a/scripts/coccinelle/device-reset.cocci b/scripts/coccinelle/device-reset.cocci
new file mode 100644
index 00000000000..510042afcca
--- /dev/null
+++ b/scripts/coccinelle/device-reset.cocci
@@ -0,0 +1,30 @@
+// Convert opencoded DeviceClass::reset assignments to calls to
+// device_class_set_legacy_reset()
+//
+// Copyright Linaro Ltd 2024
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch --macro-file scripts/cocci-macro-file.h \
+//        --sp-file scripts/coccinelle/device-reset.cocci \
+//        --keep-comments --smpl-spacing --in-place --include-headers --dir hw
+//
+// For simplicity we assume some things about the code we're modifying
+// that happen to be true for all our targets:
+//  * all cpu_class_set_parent_reset() callsites have a 'DeviceClass *dc' local
+//  * the parent reset field in the target CPU class is 'parent_reset'
+//  * no reset function already has a 'dev' local
+
+@@
+identifier dc, resetfn;
+@@
+  DeviceClass *dc;
+  ...
+- dc->reset = resetfn;
++ device_class_set_legacy_reset(dc, resetfn);
+@@
+identifier dc, resetfn;
+@@
+  DeviceClass *dc;
+  ...
+- dc->reset = &resetfn;
++ device_class_set_legacy_reset(dc, resetfn);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 18c7845ce9b..ade85c31e05 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -953,6 +953,19 @@ void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
                                      DeviceRealize *parent_realize);
 
+/**
+ * device_class_set_legacy_reset(): set the DeviceClass::reset method
+ * @dc: The device class
+ * @dev_reset: the reset function
+ *
+ * This function sets the DeviceClass::reset method. This is widely
+ * used in existing code, but new code should prefer to use the
+ * Resettable API as documented in docs/devel/reset.rst.
+ * In addition, devices which need to chain to their parent class's
+ * reset methods or which need to be subclassed must use Resettable.
+ */
+void device_class_set_legacy_reset(DeviceClass *dc,
+                                   DeviceReset dev_reset);
 
 /**
  * device_class_set_parent_unrealize() - set up for chaining unrealize fns
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cf811580621..51827858ce7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -844,6 +844,11 @@ static void device_class_init(ObjectClass *class, void *data)
                                    offsetof(DeviceState, parent_bus), NULL, 0);
 }
 
+void device_class_set_legacy_reset(DeviceClass *dc, DeviceReset dev_reset)
+{
+    dc->reset = dev_reset;
+}
+
 void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
                                      DeviceRealize *parent_realize)
-- 
2.34.1


