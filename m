Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA311D59D68
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFB-00054K-9o; Mon, 25 Nov 2024 14:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF9-00052p-Sb
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:35 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfF1-0004l5-9E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:35 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3823eb7ba72so3268774f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564766; x=1733169566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDanRZ41COf9qTLckEjQq0Cl2uY26nz9MVJ4DyeUoVM=;
 b=VJHX0HGJZjNb/XMsFd5ekMy9rTvVVkt916sSD+zMBip8zyplIi6chAxbbfWv6uWbS1
 0mang6Q9Yw3iBpZxiqnYjVIfl7OMZd0R+yHAbLM6TIERvaQXMfTPA2h5982rqyOxKFFf
 GY2BQwICkHiLwkMroRZtkqcdw97qLHKRaek/bkD53IT8YhT/gA04uwTWd38/VXWMVpwM
 JMV+oBx690NK32jXVZkPdSRFa5unx5pJOu6hDd2DtnVXWo0O7iit68v4fkaSA1rT1GUW
 qPNRX5+uDCfZS06F0r9NcfJbCDPbfq3srzq8fiJqMysu2EZ760voE+NMFaRUngRJWTVD
 FqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564766; x=1733169566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDanRZ41COf9qTLckEjQq0Cl2uY26nz9MVJ4DyeUoVM=;
 b=Cg5UIzeezoE6ZS43LgUW4i2z8DQq8xZYEnIviKCNSVEmMWkTkYQz0JtE5fBlxpE82B
 flIR9PuMGDl4Tjo3DJtlTDI3iVG31/zvgyHy34V8f9V6w6iZigCE77+gc3tIvruEk83Y
 Sv7QzdgLqwZ0kDGObqnIYYpgWQFiJ65qXDWGc85OoVExU0xOiBvNvWFrf0o5IVIxzBFq
 zd/+F4k6L4N/OBRewX2YMgV8AVq6qv8zn2ES63eF86UR1iH79BZt4u2PFIRYU0+/2R2p
 UZWFjr+nETrTe5+gwy7H3n0e72ILtUn+gENg2cGB5UZMx2FvHcEbpykswOwTAl57QMLK
 zeLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbZeZS3G6HDgB65j43YMfK4Q9cieLQ2w5TKi8DyTFpkifUCs+I16+G8YEa4mxMRf2MfedCPgg//6tI@nongnu.org
X-Gm-Message-State: AOJu0Yx8XYiolIjRDaQN80PEyzvynPFwpuBfBgaXvNZnAPkI5J+MFvT0
 X2UuP+5pRNLB3/IFg3Pe6GeeaMTdPRogalUJtoauhUFxuyM/onUPb8KiLqkIfBk=
X-Gm-Gg: ASbGnct7YCDEi/cfGbn2ejSCTu4B4R1CqFQjKpOFuXxDkzNhs657UkKDn9Z+15FInyd
 04wJYeQq19OSPu3VhHFargHNmKD+DnTTCW/M99C0xygYsCC36HkN6RiM1QF4XgMNBz5uN8ZsOwo
 gy0hiq6CLZ20LXXnuTE5v6R9RC+c28s9uR8TTDyg0MR/picpZKggjs3bEEsXlK2EaqIxhFm4bBV
 SmyhF9HRhLOWPB95tSzM97tdU+Si5qOEkouyYMbU7fynjJgAZbPlzR/QlX5OEYzrrOL
X-Google-Smtp-Source: AGHT+IEKWiu9Gp+Iust03Qntq+lTTn6PE7oIa8qEmxB8CKAOsTRCh9uUchQpL9TfWU7/drGclc4GbQ==
X-Received: by 2002:a05:6000:2d08:b0:382:50d9:bc7c with SMTP id
 ffacd0b85a97d-38260be6bfamr7331620f8f.58.1732564765799; 
 Mon, 25 Nov 2024 11:59:25 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:25 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 02/26] target/arm: Add confidential guest support
Date: Mon, 25 Nov 2024 19:56:01 +0000
Message-ID: <20241125195626.856992-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
support the Arm Realm Management Extension (RME). It is instantiated by
passing on the command-line:

  -M virt,confidential-guest-support=<id>
  -object rme-guest,id=<id>[,options...]

This is only the skeleton. Support will be added in following patches.

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: remove some boilerplate with OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
---
 docs/system/confidential-guest-support.rst |  1 +
 target/arm/kvm-rme.c                       | 40 ++++++++++++++++++++++
 target/arm/meson.build                     |  7 +++-
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/kvm-rme.c

diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 0c490dbda2..acf46d8856 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -40,5 +40,6 @@ Currently supported confidential guest mechanisms are:
 * AMD Secure Encrypted Virtualization (SEV) (see :doc:`i386/amd-memory-encryption`)
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
+* Arm Realm Management Extension (RME)
 
 Other mechanisms may be supported in future.
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
new file mode 100644
index 0000000000..67909349c1
--- /dev/null
+++ b/target/arm/kvm-rme.c
@@ -0,0 +1,40 @@
+/*
+ * QEMU Arm RME support
+ *
+ * Copyright Linaro 2024
+ */
+
+#include "qemu/osdep.h"
+
+#include "exec/confidential-guest-support.h"
+#include "hw/boards.h"
+#include "hw/core/cpu.h"
+#include "kvm_arm.h"
+#include "migration/blocker.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
+
+#define TYPE_RME_GUEST "rme-guest"
+OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
+
+struct RmeGuest {
+    ConfidentialGuestSupport parent_obj;
+};
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
+                                          CONFIDENTIAL_GUEST_SUPPORT,
+                                          { TYPE_USER_CREATABLE }, { })
+
+static void rme_guest_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static void rme_guest_init(Object *obj)
+{
+}
+
+static void rme_guest_finalize(Object *obj)
+{
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 2e10464dbb..c610c078f7 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -8,7 +8,12 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_ss.add(when: 'CONFIG_KVM',
+  if_true: files(
+    'hyp_gdbstub.c',
+    'kvm.c',
+    'kvm-rme.c'),
+  if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-- 
2.47.0


