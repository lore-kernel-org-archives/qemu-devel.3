Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66996C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaU9-0002dY-LS; Thu, 30 May 2024 03:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaU7-0002cK-En
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:46:03 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCaU5-0003MQ-Mb
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:46:03 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e95abc7259so5456221fa.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717055158; x=1717659958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HDpCi4iEWOUwI39sa+QJujajRIL5EYyVsQyGGRGUn4=;
 b=uuRG86ufMJR94gOBTyw1dKmgDiuqT0z916DVGiWt6819leq7XeYd0KSp4wNg5PWvgc
 oxzEL9CZzUmfRXB43z1Z/rHc3R0EdsK9nvsRWE8bMJtaQywMpzEebuV8PtDUnXRETQOs
 uS7zAlB2APpWAXLvhK+FlHoNDXI30WXYQQIeuP1/WN3qRjyCTzi3nShpB2VzG1mn56p7
 N5YFkmhD3DndsfzYU8gJbPP6cXqkD2kiP/+eRvOhFXOL3bVP+xR7w50GTtOoagnSC2LJ
 Hofjlx/Wh09ivFfiZybTPfJMlwTe7cV2G5Md0wKimCQ/XcwpRv135YKztjobc4jKnfiu
 mFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055158; x=1717659958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HDpCi4iEWOUwI39sa+QJujajRIL5EYyVsQyGGRGUn4=;
 b=NQF4l3r1n2/Hee/92P/7B+5f/8McO4P+1DrY3usBJhL2YEzCFAVUvGjjtWVnQQACUu
 pspb2cBbcCLnFbsfEt9rBcUrrxe3NCyGeUAc8PXKHb092iQJDZolmDBmVs5Hi/zSn7QR
 bxYEjH0digw+unG9jXErpIHr+ouMq5C2Hu9BAQ8NRcSaxhJrX5Ac5LT7UoZ1QO6azAys
 58Hg67TW5R7ngq9MtEAisIRYqv81KsLMJtchIUAeCGPJ2dgXjrw3q6eWX9O3ILv7A3sD
 EXpIgU/nBWD6W9vB+3AZzoZHj1RsPg14N785KsqNmCt1XhrEsUBwhSANWLxGWGa0wsQT
 QNoA==
X-Gm-Message-State: AOJu0YwPFp9yYNPD7/kqeI5z+ggIAUvJiJ1L/nuXSogil7RK2PFamSOY
 VwO2WPpZiP3e/4d6qnv3LrQduBYPFilVl55Dbv/go0v7q/fi/PgMZ3I5pjymFPze1tFCR00Q5A2
 a
X-Google-Smtp-Source: AGHT+IGsHz2rkPPz2V6armuS7U2pLg+nr69d4RPyUDq2oHs3Bjb9eBdsDBFcPxGBT2KFO/900W+5NQ==
X-Received: by 2002:a2e:7208:0:b0:2ea:83e6:d5e with SMTP id
 38308e7fff4ca-2ea847b3b88mr6130601fa.26.1717055158011; 
 Thu, 30 May 2024 00:45:58 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7db8csm16673189f8f.8.2024.05.30.00.45.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 00:45:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/s390x: Introduce the @dump-s390-skeys QMP command
Date: Thu, 30 May 2024 09:45:41 +0200
Message-ID: <20240530074544.25444-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530074544.25444-1-philmd@linaro.org>
References: <20240530074544.25444-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

@dump-skeys is specific to the qemu-system-s390x binary.
In order to provide it in an unified single binary, add
a equivalent new command named @dump-s390-skeys, which
works identically on s390x and reports an error on other
targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/misc.json             | 18 ++++++++++++++++++
 hw/s390x/s390-skeys-stub.c | 16 ++++++++++++++++
 hw/s390x/s390-skeys.c      |  8 +++++++-
 hw/s390x/meson.build       |  5 +++++
 4 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 hw/s390x/s390-skeys-stub.c

diff --git a/qapi/misc.json b/qapi/misc.json
index ec30e5c570..d192dd1bef 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -605,3 +605,21 @@
 { 'event': 'VFU_CLIENT_HANGUP',
   'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
             'dev-id': 'str', 'dev-qom-path': 'str' } }
+
+##
+# @dump-s390-skeys:
+#
+# Dump guest's storage keys
+#
+# @filename: the path to the file to dump to
+#
+# Since: 9.1
+#
+# Example:
+#
+#     -> { "execute": "dump-skeys",
+#          "arguments": { "filename": "/tmp/skeys" } }
+#     <- { "return": {} }
+##
+{ 'command': 'dump-s390-skeys',
+  'data': { 'filename': 'str' } }
diff --git a/hw/s390x/s390-skeys-stub.c b/hw/s390x/s390-skeys-stub.c
new file mode 100644
index 0000000000..50b5f83437
--- /dev/null
+++ b/hw/s390x/s390-skeys-stub.c
@@ -0,0 +1,16 @@
+/*
+ * s390 storage key device stubs
+ *
+ * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
+
+void qmp_dump_s390_skeys(const char *filename, Error **errp)
+{
+    error_setg(errp, "This guest is not using s390 storage keys - "
+                     "nothing to dump");
+}
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 5c535d483e..f9bb08eb92 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -15,6 +15,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
@@ -115,7 +116,7 @@ void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
     }
 }
 
-void qmp_dump_skeys(const char *filename, Error **errp)
+void qmp_dump_s390_skeys(const char *filename, Error **errp)
 {
     S390SKeysState *ss = s390_get_skeys_device();
     S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
@@ -192,6 +193,11 @@ out:
     fclose(f);
 }
 
+void qmp_dump_skeys(const char *filename, Error **errp)
+{
+    qmp_dump_s390_skeys(filename, errp);
+}
+
 static bool qemu_s390_skeys_are_enabled(S390SKeysState *ss)
 {
     QEMUS390SKeysState *skeys = QEMU_S390_SKEYS(ss);
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 482fd13420..c94b8d819d 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -50,6 +50,11 @@ virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-ccw.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-ccw.c'))
 s390x_ss.add_all(when: 'CONFIG_VIRTIO_CCW', if_true: virtio_ss)
 
+s390x_stub_ss = ss.source_set()
+s390x_stub_ss.add(when: 'TARGET_S390X', if_false: files('s390-skeys-stub.c'))
+
+specific_ss.add_all(s390x_stub_ss)
+
 hw_arch += {'s390x': s390x_ss}
 
 hw_s390x_modules = {}
-- 
2.41.0


