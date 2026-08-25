Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607D2C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzD6-0003fz-R1; Tue, 25 Aug 2026 18:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCk-00035p-3d
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:14 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCi-0001DA-CK
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:13 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so320533a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695271; x=1788300071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uun+UuCnOruy+78T99P3n2q7fn+cAO6lGcRn4VnJwcI=;
 b=xVKOi2ycy+TlvFWrqKotSiGNIfrV921hLUnbhs6bJaOoliLbyj/jmV+lvR/eRvWSwz
 qwX28FiXRa/imT2YQoT5qJh3fAD1eYEbcDm1bVIr16ARnPonAuoCuAPetYcHY0omNmZB
 ICTlysmPYsLza8TfMwKMARuC+5TJugdKmgs4dmthnDmrRgI3k81ExfBtfzzP4baAN7rb
 P8zJhDgj6yJoOBq+HGHSBpdK1EweOnamHZBoKYDy9QvNv9nrRa+0k/0vHx/pTPVCEu55
 sql+QWAx8sqoTDXhd2KnJwVYYJUL23yBlb/bx/U0fE47CRVMb1fshOj1mEvjNc58+ZXX
 cApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695271; x=1788300071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uun+UuCnOruy+78T99P3n2q7fn+cAO6lGcRn4VnJwcI=;
 b=eCiB+Fzl63s6hZJ2BAKsRmNQy9vQembs9t9WIMwDZo99rAWqu3Ucd3L1WUrhjUeGRm
 cF+rPGM8UijpM8fS3IRPd4ptaIDX/9ljprDitQ2EDphPvK1HJjxZyz0WUSE/YtvS2GDz
 FA8tVQ+HcoPHe0xrU8jUQd76FCzpz3l1uC2u/kJSY10TqUzZBtx4sX+HR3F9c44mKR/0
 UkbbCuYYtbJLa6T8gPV67UZTDaUR1lEufH6YmaKkkqLp1g+3QcjrxHPfC+Cyj+eLcuOs
 rOAWheYB4dhzGMPFtroxSInxYfPgqqFocQCMr404dRdOsMlxpooE5jjpNvf4cgnCBdwv
 UG/g==
X-Gm-Message-State: AFuF++mSym/odpQ7SX/xHqVMPCX/Bhq9mb9k6OgcR8sVxJ9y8QXA9bsq
 XStUlWw/OBM3EA0kiQCGl9s82TThg6N809o83UlRGhgK6GUVeG5D2rieyoimOJq8EWM=
X-Gm-Gg: AR+sD11T9Q7t3TBLG5UzMo+SCOWObGfArrqur9ueLmARl/GNfniGqVAGV2Xk0919PMd
 1o56y3R4X5WEY4pGTYWicd4nrgAtBszVvOw7fcK4Qbr5/LrqH2alQKxtXGFzEK8KsTfv0ypZZ7f
 BrVGf56OYSmrBsmmh44Y76327BzWBORAsyujJs8zhKnyCaXu4pdCI4svakTMXs+SNy/dlDxVp4j
 FDJqRJeRaRU5SLln5K+lSA0VldbEmirfzSnG6lgKQDZuxoi6vw8sjDjxGMZ7xK2ZglZlI4f909/
 lThNHx1a0Ih+s5ZjP4veOkLFBVqW4cmQnnzZmVZyTNHm3RIi7WSjGBaLvGgyITRHpKoPm2A3v62
 sGacRrSjd/TEETlVvPxba9xP6MkymCSNrmcYVS7VsOyW61WOuqIKAr5/Uq8I3NmsTzpqnl3kPU0
 B8DQTr9kZlFi7LkYl69UNoAt51JmRnpK7XJq7vw74HI7XfhWsz4pR0c69YbCiU1RghBWDEkccAs
 KHCyNQqJmHjsHn8
X-Received: by 2002:a17:90b:380b:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-3966d13a242mr4229936a91.1.1787695270354; 
 Tue, 25 Aug 2026 15:01:10 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:09 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 03/24] target/arm: Add confidential guest support
Date: Tue, 25 Aug 2026 16:00:40 -0600
Message-ID: <20260825220101.3443954-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
support the Arm Realm Management Extension (RME). It is instantiated by
passing on the command-line:

  -M virt,confidential-guest-support=<id>
  -object rme-guest,id=<id>

This is only the skeleton. Support will be added in following patches.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/system/confidential-guest-support.rst |  1 +
 qapi/qom.json                              | 13 +++++++
 target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
 target/arm/meson.build                     |  5 ++-
 4 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/kvm-rme.c

diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 562a7c3c2852..abb56923ad13 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
 * AWS Nitro Enclaves (see :doc:`nitro`)
+* Arm Realm Management Extension (RME)
 
 Other mechanisms may be supported in future.
diff --git a/qapi/qom.json b/qapi/qom.json
index 037c07879986..edc902c88c36 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1216,6 +1216,17 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
+##
+# @RmeGuestProperties:
+#
+# Properties for rme-guest objects.
+#
+# Since: 11.0
+##
+{ 'struct': 'RmeGuestProperties',
+  'base': 'ConfidentialGuestSupportProperties',
+  'data': {} }
+
 ##
 # @ObjectType:
 #
@@ -1272,6 +1283,7 @@
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
     'qtest',
+    'rme-guest',
     'rng-builtin',
     'rng-egd',
     { 'name': 'rng-random',
@@ -1351,6 +1363,7 @@
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
+      'rme-guest':                  'RmeGuestProperties',
       'rng-builtin':                'RngProperties',
       'rng-egd':                    'RngEgdProperties',
       'rng-random':                 { 'type': 'RngRandomProperties',
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
new file mode 100644
index 000000000000..42e1d1e7b859
--- /dev/null
+++ b/target/arm/kvm-rme.c
@@ -0,0 +1,42 @@
+/*
+ * QEMU Arm RME support
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright Linaro 2026
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/core/boards.h"
+#include "hw/core/cpu.h"
+#include "kvm_arm.h"
+#include "migration/blocker.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "system/confidential-guest-support.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
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
+static void rme_guest_class_init(ObjectClass *oc, const void *data)
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
index 4723f9f170ad..544df5c84d79 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -20,7 +20,10 @@ arm_common_ss.add(files(
 arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
+  'hyp_gdbstub.c',
+  'kvm.c',
+  'kvm-rme.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
-- 
2.43.0


