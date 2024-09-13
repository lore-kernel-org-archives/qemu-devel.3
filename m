Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DED4FA375C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80B-0002Be-E1; Fri, 13 Sep 2024 11:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp804-0001gx-6N
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp801-0007lZ-MC
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso18601355e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240456; x=1726845256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4imojfIsJ60JAMsYjzxe7fUUa1MPhY4EYRSKYHUjSoQ=;
 b=CGXt5n6XUxQa7AGXusN8fiyhY2VY0ma3HMKe8PJDvgrIV0htmyjd86F3PEKgtEpPYg
 tgeCMIacCDpWDTL4acPZjgEN8M578kQMK3liLYyK6McASYNPdq3RyhINOlJbW0jPsCd/
 HV7VZcPGWLb7joSgmuJq7eXYea/2er8tKDLRWb/rJ+ED3XHdZs4t+5UwQQW7dIneISjK
 Um0Sy5RhogLrdQ0xcOsSvpNyjPZY26cMJRLaigyVmtSmDiQDf5kaAfy1Iu02GVB3MCa8
 jW6S3awyqwORaaR2aE/pypRedlgC5ttv7mqbhZcPPWhSVn7Sc+6o4YzY7v+x+JWwjWtH
 PStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240456; x=1726845256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4imojfIsJ60JAMsYjzxe7fUUa1MPhY4EYRSKYHUjSoQ=;
 b=tCiMO7QQFTc+PyNTKLzGIO418MH3qTNHNEiMbGt1hTAR1678/Vk5QRBUJdhEclykOk
 AXqukmGEaDmevEXyr4lt1QxnEKB3pT3l/dn2RBFiYJ4zql+AIJyVQuvLHBWhsPdl8JOv
 Sh78FcT9imQyikxca7MGR7Ua27Ascp+bSUUORzxi4umgk9dKWmFRzi8pEB+DhkkelKjy
 WianlMuLkGjCcVnu4uQD34t7MquXMqPQMiEicPLx3A7r7INc4nrO73No1tRnZOnR9vG4
 t5a/0FSpjd47D0/Nb7lsUTimOtIaPeLF88qIMEbNlSZKB+Y+zEjQWCPZHuHC1BAl7/6Q
 Uq1Q==
X-Gm-Message-State: AOJu0YyHi+zGh4teOsMR2KGoGvsS0Z8ntBaktLBnIvR7lbjjTzWV7XUa
 hc8vBiT27+nYexCI7oAzvpR+IuEE+Sl3attCpTJ4Bp6+mqWIfdG27/Hx0p2tymnatJX+vudC+tG
 o
X-Google-Smtp-Source: AGHT+IGOI4LNzrulSA+u/5UmOus/Px7Og6GOHll1hGy1pxaNZAGdBlDkWz1jkNfZTO62sd3CFErv7A==
X-Received: by 2002:a05:600c:1e1a:b0:426:5fbe:bf75 with SMTP id
 5b1f17b1804b1-42cdb567190mr51997755e9.23.1726240455887; 
 Fri, 13 Sep 2024 08:14:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/27] hw: Define new device_class_set_legacy_reset()
Date: Fri, 13 Sep 2024 16:13:50 +0100
Message-Id: <20240913151411.2167922-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240830145812.1967042-7-peter.maydell@linaro.org
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


