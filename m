Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A71CC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdEX-0005Ja-NH; Mon, 10 Mar 2025 09:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdEN-0005HW-4U
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:31:44 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdEK-0007Nv-LR
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:31:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso9812325e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741613498; x=1742218298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gwWwhAuWqbYhYJM2CzOTGOLTxTRCMppZ1Oq+j9Tbsc=;
 b=z77ob94UxIasnrg1B6VWFwIvcBhYlGqpU9vSZaAyXg1MYnMMMu4dZrg9nFCgS+BPj0
 ow3Iuof29yyoVAC3hmpTuNFrR5RiYZjf5GC7Q94Cg8dXVoAxflhx4KRXrqqt1TXgPyQB
 bwqlbNhr2IcJfz4UXP4zHL1UlXueN6xCm++VRTbpaPzjEarRRlSWEubEN5SBQUb9R531
 u5sbBztprlaOeI2VFilz46XgYYzZbeLYUs8j05AmdNY3S2lqlP8XZtjLVeEdp+SXY0D4
 BDd9N7RWqrlNsoRbMF+BwbX8t3nNv9XZiP1CwVXCMS4XiRvIOsWpHVTfDPRqf+7cEt1E
 NESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741613498; x=1742218298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gwWwhAuWqbYhYJM2CzOTGOLTxTRCMppZ1Oq+j9Tbsc=;
 b=kC+bMYk1eu0t4HIMwHPdTVyhur1HD2y8RDLsyV3LS2lpRqwmXuRjNpFsiUFcP0rcxL
 xcHiIYevrWmzOKAQWQIuj1IG2GiQf/kKfGGJNrWlEcz9T847PO45SuQ8Zn7gJptbmgcH
 NeHAi+fSabQkLj/66Z1lt0aLcu9z0mgffBjS9/0WuB0plIJfpi8RQGiWgdMCjeGhw8d/
 ooJ1/DVhukfkn3f3moh+fVWSqWZ3gD4CLr7TiECLhlfi1QIa+hwb9+VQUVxpXli6CLlC
 QEK40g1umy1Tj99CWXH4EOvwAhMSjY14NZ3iLaVDdF4Inr9nXcWwjvOB+gwJE87eSpXg
 NPMQ==
X-Gm-Message-State: AOJu0YywbdKD2mpKCcdawaMwD2PKki2t0l4vfN/qttyaTRXc8DytscYn
 D5yLxkIn29YXQZVJLJlS0P6v/YU149GdU61DDdOpH4JdVmUArRNSp9tX8fOcwiNAJXetokI6V2H
 diPA=
X-Gm-Gg: ASbGncsehSj0tDCe0nvkaMjrCVa9E4/Xj9hRfMCCTdfFKF55Ki+S0jbgtUWoDwTo/MT
 ngxWKntrkCEqu4zSQULr3OccBaE1+us6thwgkzmXR5TbGBJlplEcbHGzIQaNusF5qaX2fCaRGbi
 IQnuO+mriH1QHNLxPXV9pUPXcpAK/yO1tLvXD95Y+26NSRznfOb/MzJV+B7zmbSCZjus/c+WFwO
 e4pBwx9vqi/U/KBNQvSiMJTAY3L1J7p/CIHUSY7chTrh9rqVJY3WuQKgLTlul7/KGsH+h8+Ehem
 ZM776S7s3I5uPMJJJWDnajZgKqBfZBVL9Lsrc1bX5GEOzKU2wE5jUR64Uz6Gs5uQ1b9+yjAGrmh
 cTx6n9WDRN1UmskMxAns=
X-Google-Smtp-Source: AGHT+IG+1qThTujopH3oS5hjb/iXtkKLkXTJkbpsk2OIfey5iVDRiHVoOptoHe/uqxJRTWnw9tTX3g==
X-Received: by 2002:a05:600c:4fc1:b0:43b:cd0d:9466 with SMTP id
 5b1f17b1804b1-43c601d9251mr72915935e9.9.1741613496945; 
 Mon, 10 Mar 2025 06:31:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e1476sm14922878f8f.70.2025.03.10.06.31.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Mar 2025 06:31:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] qapi/machine: Make @dump-skeys command generic
Date: Mon, 10 Mar 2025 14:31:18 +0100
Message-ID: <20250310133118.3881-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310133118.3881-1-philmd@linaro.org>
References: <20250310133118.3881-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Reduce misc-target.json by one target specific command.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json          | 18 ++++++++++++++++++
 qapi/misc-target.json      | 19 -------------------
 hw/core/machine-qmp-cmds.c | 13 +++++++++++++
 hw/s390x/s390-skeys.c      |  6 +-----
 4 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09e..53680bf0998 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1898,3 +1898,21 @@
 { 'command': 'x-query-interrupt-controllers',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
+
+##
+# @dump-skeys:
+#
+# Dump guest's storage keys
+#
+# @filename: the path to the file to dump to
+#
+# Since: 2.5
+#
+# .. qmp-example::
+#
+#     -> { "execute": "dump-skeys",
+#          "arguments": { "filename": "/tmp/skeys" } }
+#     <- { "return": {} }
+##
+{ 'command': 'dump-skeys',
+  'data': { 'filename': 'str' } }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 8d70bd24d8c..42e4a7417dc 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -274,25 +274,6 @@
   'returns': 'SevAttestationReport',
   'if': 'TARGET_I386' }
 
-##
-# @dump-skeys:
-#
-# Dump guest's storage keys
-#
-# @filename: the path to the file to dump to
-#
-# Since: 2.5
-#
-# .. qmp-example::
-#
-#     -> { "execute": "dump-skeys",
-#          "arguments": { "filename": "/tmp/skeys" } }
-#     <- { "return": {} }
-##
-{ 'command': 'dump-skeys',
-  'data': { 'filename': 'str' },
-  'if': 'TARGET_S390X' }
-
 ##
 # @GICCapability:
 #
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3130c5cd456..b9ed0963bb4 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/vmgenid.h"
 #include "hw/boards.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #include "hw/intc/intc.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
@@ -406,3 +407,15 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
     info->guid = qemu_uuid_unparse_strdup(&vms->guid);
     return info;
 }
+
+void qmp_dump_skeys(const char *filename, Error **errp)
+{
+    CPUState *cpu = first_cpu; /* FIXME */
+
+    if (!cpu->cc->sysemu_ops->qmp_dump_skeys) {
+        error_setg(errp, "Storage keys information not available"
+                         " for this architecture");
+        return;
+    }
+    cpu->cc->sysemu_ops->qmp_dump_skeys(filename, errp);
+}
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 686c118ebcd..6bd608b5aa3 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -15,6 +15,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
@@ -219,11 +220,6 @@ out:
     fclose(f);
 }
 
-void qmp_dump_skeys(const char *filename, Error **errp)
-{
-    s390_qmp_dump_skeys(filename, errp);
-}
-
 static bool qemu_s390_skeys_are_enabled(S390SKeysState *ss)
 {
     QEMUS390SKeysState *skeys = QEMU_S390_SKEYS(ss);
-- 
2.47.1


