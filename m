Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3300BCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjkW-0007MT-V9; Fri, 02 Oct 2026 16:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkC-000795-Mw
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjk9-0005ju-Q3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso11933375ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972432; x=1791577232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bm2R9pn3B+qOLBch30fsk6rbf6WKwHzxx8w/KoQ0W+A=;
 b=wARbj3NHigENwBWzMrS4G6dZ+oZNQFRzjjG4vSZ6ZkKh3cTnDfyCXixjC+5am5HE1T
 Gs6Rv1aoSn4Rn5a7MmVl0HM+v+55xWWU8/a3gL0+u/sQgxtV9BB2MMqSPJnMerZUqET1
 ScLWhr88Y4qjyxRSveJfvdGpGi4fEawsczY9A9rzvR/CMCKnFoXFekhx9iNk0sl9Dgl0
 uXFA9D7g3Ui7CFb6hbrmVXvjalJlYgOTxhxN2Dbo0R4ksW3eZ0Rnk4InF6+stPc0DhPF
 3Vd2K0MI/DodjJGPTq7k0cIMAaymDG1v0tiR1claexmzgnNZBJSgvZ2NNDO5XA7it21W
 iYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972432; x=1791577232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bm2R9pn3B+qOLBch30fsk6rbf6WKwHzxx8w/KoQ0W+A=;
 b=qQFOcAC+KcxjMS2XFNfJGMbaBGOctAPIzlXwsF30osGRQcDzO/Tk7/RMskNOhjukGF
 +92FEkz+p4f9ag3M/IGVxRMCqGS2WgpYRGjMdrVNrOM9VeRXlr7Tbj+3pH2SGlP63mVo
 LQEb1UU7BTe52+a6B5BU8os2VnMm7T+icvCfk90Lfo3tVzc/9kcSx0SqdFxYV5YIy+/O
 Bv4BiUwDiqMPKQlf8KpDTVC8wJWfDcg++kA6DrzpTzgkcduXexyCPBQZNriSuFLR0d0q
 o03bdXRTHwP0nrwBam31I8VrUneBP2TnOMLb6MkONeehdCIL+N/SCC/A+B09jpLjH7Tf
 leZA==
X-Gm-Message-State: AFq9FYJg7y9SnOUioeeyG7xchf+P0oV7Wt0ePspAmOFiovxloFhAuXW0
 9hsdqUgRY8EWo8MrhE87dOVosFnwn+hTttJSH0t3CEbD0AyMyvmbUS48nonibj2dQgE=
X-Gm-Gg: AYBFou1k6SBC2BH4r/mw+FzQLgJSK8MKo1rA8RDmOtwgPJpSXdIPr+o2p1br+CptCsr
 GhLqvOD7k0ajcV5S9gFsWMRxTMSHhgucNrH41LFPLkDQmjCFYpGd+g7kUQnQwRvtFRGLyAePFVS
 sip/eVwNUvkPgLwJlKoCNDgoE1dPgnuSiErPP5VFbUcCkXYOTonKJc+jm259G/OTiZwyMSasP4n
 utiXLRmaN8IDCfhZXjxuIUrT8/cGkEiWfAhOyfRK7ybLUcnPDyROA/fTof+KhyqMcK45pg7fgkH
 nlRJ+wbuimAtXkHG69qGdoRKQBtPWFsbBaqfAlXle+rB3LTVnI7RdMhZuQPQMVBrEyx+mni6h3A
 A0xhlMI6WHCuy8j+uU0oUb5pIj7tBpciKSR+amjwYg59W/AWNBQWhVWB1V3p4qM8J9uU+i2zwR4
 fvWE7leRYiFayeobNczXC0PaUSicXcK69I5E4fjqyKwi/0nRuCMCbIdbQRj8VNPrWN6yCyGXr30
 V5ilKYFRbuDYt+h5ASbW4YV
X-Received: by 2002:a17:902:f541:b0:2df:89d3:1b6c with SMTP id
 d9443c01a7336-2e4e9c28c59mr5729955ad.5.1790972432088; 
 Fri, 02 Oct 2026 13:20:32 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:31 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 02/22] target/arm: Add confidential guest support
Date: Fri,  2 Oct 2026 14:20:06 -0600
Message-ID: <20261002202026.1204110-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62d.google.com
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
Acked-by: Markus Armbruster <armbru@redhat.com>
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
index 54495d4fb6f1..5f04264d02fc 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1289,6 +1289,17 @@
   'data': { '*pretty': 'bool',
             '*close-action': 'MonitorQMPCloseAction' } }
 
+##
+# @RmeGuestProperties:
+#
+# Properties for rme-guest objects.
+#
+# Since: 11.2
+##
+{ 'struct': 'RmeGuestProperties',
+  'base': 'ConfidentialGuestSupportProperties',
+  'data': {} }
+
 ##
 # @ObjectType:
 #
@@ -1345,6 +1356,7 @@
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
     'qtest',
+    'rme-guest',
     'rng-builtin',
     'rng-egd',
     { 'name': 'rng-random',
@@ -1424,6 +1436,7 @@
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
index 0369f96b4cc6..9d322a7aad28 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
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


