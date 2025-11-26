Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4438D10F5A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 14:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOGP8-0004J5-2j; Wed, 26 Nov 2025 09:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOGOf-0004AL-3v
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:21:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOGOd-0005G6-1N
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764166885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zo/Bq9TUjLyhpqSX/zXVyODLtm8ZhsvlCvCSPbQI48=;
 b=Zo20abIGYam6/86YevUAdMbAf9fjtQEaoEqQxLfQZRDhAhyEwt6tXuas58ZLWQRxejnFUP
 GJmTb6tEZRwjUAeslufIqMnBm1OSAJIOd6VmGKlkJNRnTzZyEsx3wY+nSModD4W2L8CD8N
 tbjT1X1VJxXINl7fWHavACV4BvoX7Og=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-FO-sqF-RP5uMXOrrhvrSmA-1; Wed,
 26 Nov 2025 09:21:23 -0500
X-MC-Unique: FO-sqF-RP5uMXOrrhvrSmA-1
X-Mimecast-MFC-AGG-ID: FO-sqF-RP5uMXOrrhvrSmA_1764166882
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05C0819560B1; Wed, 26 Nov 2025 14:21:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.126])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C41730044E9; Wed, 26 Nov 2025 14:21:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8EB231800397; Wed, 26 Nov 2025 15:21:16 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] edk2: update build script
Date: Wed, 26 Nov 2025 15:21:03 +0100
Message-ID: <20251126142116.4077056-3-kraxel@redhat.com>
In-Reply-To: <20251126142116.4077056-1-kraxel@redhat.com>
References: <20251126142116.4077056-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

sync with https://gitlab.com/kraxel/edk2-build-config/

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/edk2-build.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/roms/edk2-build.py b/roms/edk2-build.py
index e564765aaa71..c4bfbae4cffb 100755
--- a/roms/edk2-build.py
+++ b/roms/edk2-build.py
@@ -51,7 +51,17 @@ def get_toolchain(cfg, build):
         return cfg[build]['tool']
     if cfg.has_option('global', 'tool'):
         return cfg['global']['tool']
-    return 'GCC5'
+    return 'GCC'
+
+def get_hostarch():
+    mach = os.uname().machine
+    if mach == 'x86_64':
+        return 'X64'
+    if mach == 'aarch64':
+        return 'AARCH64'
+    if mach == 'riscv64':
+        return 'RISCV64'
+    return 'UNKNOWN'
 
 def get_version(cfg, silent = False):
     coredir = get_coredir(cfg)
@@ -137,7 +147,7 @@ def build_run(cmdline, name, section, silent = False, nologs = False):
             print(f'### exit code: {result.returncode}')
         else:
             secs = int(time.time() - start)
-            print(f'### OK ({int(secs/60)}:{secs%60:02d})')
+            print(f'### OK ({int(secs)}sec)')
     else:
         print(cmdline, flush = True)
         result = subprocess.run(cmdline, check = False)
@@ -191,7 +201,10 @@ def build_one(cfg, build, jobs = None, silent = False, nologs = False):
     if jobs:
         cmdline += [ '-n', jobs ]
     for arch in b['arch'].split():
-        cmdline += [ '-a', arch ]
+        if arch == 'HOST':
+            cmdline += [ '-a', get_hostarch() ]
+        else:
+            cmdline += [ '-a', arch ]
     if 'opts' in b:
         for name in b['opts'].split():
             section = 'opts.' + name
@@ -235,7 +248,7 @@ def build_one(cfg, build, jobs = None, silent = False, nologs = False):
 
 def build_basetools(silent = False, nologs = False):
     build_message('building: BaseTools', silent = silent)
-    basedir = os.environ['EDK_TOOLS_PATH']
+    basedir = os.environ['EDK_TOOLS_PATH'] + '/Source/C'
     cmdline = [ 'make', '-C', basedir ]
     build_run(cmdline, 'BaseTools', 'build.basetools', silent, nologs)
 
-- 
2.52.0


