Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAB3D216BF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0j0o-0001NF-1l; Tue, 15 Oct 2024 10:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0j0m-0001Md-SS
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:59:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t0j0l-00008r-7q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:59:00 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20cb89a4e4cso24265975ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729004337; x=1729609137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xr9VcP67btkW9fdHquP6IjRtytSNpngBeXikWdUm1Z4=;
 b=q00wRtYuDHqZ0lluR0hZuFI/3LHXSmz8vASJdxwfym0s08MkLJLGACOLe6Mr83BMz8
 S3y353GiWJywbUkCV0p/fBWp0wmpdGAC9zv+eb62ZvKuIvMWWugPCC17joPgyisGHajR
 qvwIvaHV4TuyVOtYg2a6JyEqyx/MBHyO3T5nAAwf3/0qxnUEUHYsxPr2173bI3ATSgsX
 QCGEOC45zwOE9pJq9KKwlBX9vGmQYKcKhPvFCeB72IifSlnTGmMfUeCzd3oWZ4R7zK5M
 AKaBTs3z3ejohY/AgiVKzi5eu8KJ9quhe+8Up3hOiucTcFP7nZ1N6MzJdKpQCcRH/78B
 E2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729004337; x=1729609137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xr9VcP67btkW9fdHquP6IjRtytSNpngBeXikWdUm1Z4=;
 b=khU3NHdUGxbsQBCwQZpi9WU3vc1MsBo6LylYHoan7ZXThPl090eXmayFtMPaVs94GI
 jNJmy7hutOjauhjGvXxc8P6T7yPJCtK9FFjUBCbZ7zwR2B/tfv12AFfl1TSVxnu+dLJe
 q4uwNyUShvi/nap3tBfKkwi5HBf+iiIu0t80qJ3sce3MybNgHoqDE6pO1H9eBVNc8JJp
 15NTciqyfnwaqme+kC/4Zz1FHQH5/kB5X8wovPhpfP57jz6GY4ac5zEs8f+JGGW/SEpF
 BdPTXknai+Ti5n+TDNHMOue1gsyDHl8b08NGJvMBnKQwsfR8L43JWCXGePQVrwZvAtSd
 g23Q==
X-Gm-Message-State: AOJu0Yzrw8z/M1/Cwv013fuwhS4Zf3TwI3CeikNcCnJ+HefUYd6eautD
 x3zUE0Yd162WETGde9n/yXXgVPSntCY6j5R3idxVtR83KaKb3OzwkeaZG22TbiknJUc337oWAs5
 ic78=
X-Google-Smtp-Source: AGHT+IH8+DQNhmp2bul/TYQwPvUocMWXOBjyORwLlD5IFCY7gMSV2OBZDTmujeTJnPBvY8Y3c6YXPw==
X-Received: by 2002:a17:902:d2cc:b0:20c:dbff:b9d8 with SMTP id
 d9443c01a7336-20d27f0db37mr5201085ad.37.1729004337358; 
 Tue, 15 Oct 2024 07:58:57 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:3301:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84dbdsm13021505ad.55.2024.10.15.07.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:58:57 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH] testing: Enhance gdb probe script
Date: Tue, 15 Oct 2024 14:58:48 +0000
Message-Id: <20241015145848.387281-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
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

Use list and set comprehension to simplify code. Also, gently handle
invalid gdb filenames.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 scripts/probe-gdb-support.py | 75 +++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 6dc58d06c7..6bcadce150 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -19,58 +19,61 @@
 
 import argparse
 import re
-from subprocess import check_output, STDOUT
+from subprocess import check_output, STDOUT, CalledProcessError
+import sys
 
-# mappings from gdb arch to QEMU target
-mappings = {
-    "alpha" : "alpha",
+# Mappings from gdb arch to QEMU target
+MAP = {
+    "alpha" : ["alpha"],
     "aarch64" : ["aarch64", "aarch64_be"],
-    "armv7": "arm",
+    "armv7": ["arm"],
     "armv8-a" : ["aarch64", "aarch64_be"],
-    "avr" : "avr",
+    "avr" : ["avr"],
     # no hexagon in upstream gdb
-    "hppa1.0" : "hppa",
-    "i386" : "i386",
-    "i386:x86-64" : "x86_64",
-    "Loongarch64" : "loongarch64",
-    "m68k" : "m68k",
-    "MicroBlaze" : "microblaze",
+    "hppa1.0" : ["hppa"],
+    "i386" : ["i386"],
+    "i386:x86-64" : ["x86_64"],
+    "Loongarch64" : ["loongarch64"],
+    "m68k" : ["m68k"],
+    "MicroBlaze" : ["microblaze"],
     "mips:isa64" : ["mips64", "mips64el"],
-    "or1k" : "or1k",
-    "powerpc:common" : "ppc",
+    "or1k" : ["or1k"],
+    "powerpc:common" : ["ppc"],
     "powerpc:common64" : ["ppc64", "ppc64le"],
-    "riscv:rv32" : "riscv32",
-    "riscv:rv64" : "riscv64",
-    "s390:64-bit" : "s390x",
+    "riscv:rv32" : ["riscv32"],
+    "riscv:rv64" : ["riscv64"],
+    "s390:64-bit" : ["s390x"],
     "sh4" : ["sh4", "sh4eb"],
-    "sparc": "sparc",
-    "sparc:v8plus": "sparc32plus",
-    "sparc:v9a" : "sparc64",
+    "sparc": ["sparc"],
+    "sparc:v8plus": ["sparc32plus"],
+    "sparc:v9a" : ["sparc64"],
     # no tricore in upstream gdb
     "xtensa" : ["xtensa", "xtensaeb"]
 }
 
+
 def do_probe(gdb):
-    gdb_out = check_output([gdb,
-                            "-ex", "set architecture",
-                            "-ex", "quit"], stderr=STDOUT)
+    try:
+        gdb_out = check_output([gdb,
+                               "-ex", "set architecture",
+                               "-ex", "quit"], stderr=STDOUT, encoding="utf-8")
+    except (OSError) as e:
+        sys.exit(e)
+    except CalledProcessError as e:
+        sys.exit(f'{e}. Output:\n\n{e.output}')
+
+    found_gdb_archs = re.search(r'Valid arguments are (.*)', gdb_out)
 
-    m = re.search(r"Valid arguments are (.*)",
-                  gdb_out.decode("utf-8"))
+    targets = set()
+    if found_gdb_archs:
+        gdb_archs = found_gdb_archs.group(1).split(", ")
+        mapped_gdb_archs = [arch for arch in gdb_archs if arch in MAP]
 
-    valid_arches = set()
+        targets = {target for arch in mapped_gdb_archs for target in MAP[arch]}
 
-    if m.group(1):
-        for arch in m.group(1).split(", "):
-            if arch in mappings:
-                mapping = mappings[arch]
-                if isinstance(mapping, str):
-                    valid_arches.add(mapping)
-                else:
-                    for entry in mapping:
-                        valid_arches.add(entry)
+    # QEMU targets
+    return targets
 
-    return valid_arches
 
 def main() -> None:
     parser = argparse.ArgumentParser(description='Probe GDB Architectures')
-- 
2.34.1


