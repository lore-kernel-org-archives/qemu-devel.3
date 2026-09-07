Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77B6C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wd0-0004LJ-KH; Mon, 07 Sep 2026 06:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wcj-0004FB-9I
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wcg-0003TX-Or
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788777046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDgNGwW+ikB04+uFpE5aVrV44YCxj/0gXscGjqip9fI=;
 b=C088BQ3zO65P3eVurp91LgwznuWCL6nSyq8e1WG3r93vpVPtlmYJrrep4U5W+P5YmWRl73
 SLesdi+f7I4SvwtUPn/vOnfSFXRIUI2cB3es/rC8A6un/cE4CDCn+wVHNhDBsUUfPUTbRt
 hewJ0genQ7Z0SsFkI4fwx+CJIdFWOzQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-gDErs7mpM-uCs8tshjl-xw-1; Mon,
 07 Sep 2026 06:30:40 -0400
X-MC-Unique: gDErs7mpM-uCs8tshjl-xw-1
X-Mimecast-MFC-AGG-ID: gDErs7mpM-uCs8tshjl-xw_1788777038
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA005182F558; Mon,  7 Sep 2026 10:30:38 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5E16427; Mon,  7 Sep 2026 10:30:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:30:20 +0400
Subject: [PATCH v2 02/10] tests/functional: add skipUnlessConfig() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v2-2-6d952d972c21@redhat.com>
References: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
In-Reply-To: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ygc3sa0XyimlEPA9EvJG3rAzBiuUKaymrtR3GvddhO4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpJCx76BhkkEtw5IfXC8ETpcUnBBZEzAY2u1R
 uUttmuFuXuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6SQgAKCRDa6OEJdZac
 5YAeD/40wvCHvIBNT29clCHMZfGU4ZaUGX0sqfFZoygMX0bs2K2cPegEnuhdPRcThVsGICSZ6nZ
 pMR7T4Dfl3Y51J8G3WxRwMnPftdnVzU828qGvEmPp6+I3dsPNY3xLbxDY4fo/XuGjlmLMlgnMg7
 YpWixwekpy3TYIDiCoASR66ok7k4lp55vGV+bJVDSd3xTAOP3BpXBNvN4b3N1m5xf+8d2UiIRUL
 YI1QtIRxm4FwD1TGQ+doWY/L/D/EaQk2gKouDT7oLKMj4P2qk6oyEq+SlVyYEMgYmTMf9Jx0hcW
 riEsLNFbMjiUyNXtucQCqEVsvtlc7G+2M/7yR+mcvi8WCF0zI+MmNdc1mrlVAd8UiHFzYuzJbvt
 FcN/JTO9kcf11jrANBbRX277pqFIH5ss15miBYD/r9efDEkPddUqVhbDVTN5nPosk4yXHZxw/CT
 2FpL7iopuMLXuiYgYO777M09rcn8Lrb7oVG41rB06cCzDxWHXALGBPGOAYB1B0mVX+djhV1LTzo
 inGbZHRhrNjyAlyL4ABhXDKfAR8i6SGQYp/Zx+k8RZ1DNCvksXCs4xZ0rf77aoDGR5ajci4zA+N
 Eojbc2GsVXfaIcqTnl+KdhMrVHm8BIYzzJJKa0yeXz/mqg2Pz8PX1tF/PuCzezRX2ELmChEvzx0
 7gnWc8V+nXi6igw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Read config-host.h and skip tests that rely on some CONFIG_*
values.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/qemu_test/__init__.py   |  2 +-
 tests/functional/qemu_test/decorators.py | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 03e5c73d39dc..e21fa8279281 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -16,7 +16,7 @@
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
     skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
     skipIfMissingImports, skipIfOperatingSystem, skipUnlessOperatingSystem, \
-    skipLockedMemoryTest, skipIfMissingEnv
+    skipLockedMemoryTest, skipIfMissingEnv, skipUnlessConfig
 from .archive import archive_extract
 from .uncompress import uncompress
 from .gdb import GDB
diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index aa135acc7857..7a7d30503440 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -10,6 +10,7 @@
 from unittest import skipIf, skipUnless
 
 from .cmd import which
+from .config import BUILD_DIR
 
 
 def skipIfMissingEnv(*vars_):
@@ -162,6 +163,30 @@ def skipIfMissingImports(*args):
     return skipUnless(has_imports, 'required import(s) "%s" not installed' %
                                    ", ".join(args))
 
+def _read_config_host():
+    config = set()
+    with open(BUILD_DIR / "config-host.h", "r") as f:
+        for line in f:
+            if line.startswith("#define CONFIG_"):
+                name = line.split()[1].removeprefix("CONFIG_")
+                config.add(name)
+    return config
+
+_CONFIG_HOST = _read_config_host()
+
+def skipUnlessConfig(*args):
+    '''
+    Decorator to skip execution of a test if the QEMU build
+    does not have the required CONFIG_* options enabled.
+    Example:
+
+      @skipUnlessConfig("PIXMAN")
+    '''
+    missing = [a for a in args if a not in _CONFIG_HOST]
+    return skipUnless(len(missing) == 0,
+                      'missing build config(s): %s' %
+                      ', '.join('CONFIG_' + m for m in missing))
+
 def skipLockedMemoryTest(locked_memory):
     '''
     Decorator to skip execution of a test if the system's

-- 
2.55.0.543.g5ebe2ebe4ea8


