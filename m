Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B973BCDDE70
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Zme-0001wr-8q; Wed, 23 Oct 2024 07:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zmb-0001vZ-Ry
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:44:09 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3ZmY-0004Ye-PC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:44:09 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso7634143e87.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683845; x=1730288645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goM9TWkvUJk023ZZ8+wq0WOvMkki4+LOppFI2tLZ0P4=;
 b=fxCSCLeJTdxr+MilDGuNdey1g8TG2L1+fIRl/YZ5uB5yISFNrwSsl0kKGfyB/lDh3S
 yFPvWbUIYEfZyT80XXsxitFSUvyHp7DIb2GzbBzIxp/HH+A+ScDAnztlj4MR7363SoQz
 Hs14NpKA5LdQIDudNRZzJ8j7sZmSB6sUSdGR8y1wmZB+tB+YD8gKkISSg/Osl9kqQyuU
 BgIJ8kKVP414i59rkmewJvfhvERdZovzn1aYYKaxJojpUmGkPy6dUF0WKjLh+uMz3VV2
 kuk5X6ZSeXbR4FPYlJg00mkxlb9SOpWzMxKw2JCkw4EPLc387cFmKGa8ekRR2aGW4Lht
 15JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683845; x=1730288645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goM9TWkvUJk023ZZ8+wq0WOvMkki4+LOppFI2tLZ0P4=;
 b=BxTZBzBe1ehO+uUnhoG3lggKwnW6V3pc/EG7lD/c8TqcLF8ul3fqAz4NvfowmCWxzD
 xBKXABewG8RZ7DLUD1PXu3+AkHDK20TfGGZNAYLZngFGhz/Ub1RTJyqh+Snt6KdcTJKZ
 A+zJkiGkz+mXMbLEWAnChDmM0Em85po6ym0Fwsi8N2FPBtAo1LmDARxg1LPP37hP7kgH
 QVE7eBVqXN4GCbIFDUSZbD/cHjJHIhGcSwvWA+1teLEsuUQnqmU0hyBecHwx1zUmsgel
 e9lXlu+KGjg1PIzfuzff9hHBBggEL02IsYn0we7wSJYvk4xw6CzMLjKqP7pQlfKcOGd6
 d2fA==
X-Gm-Message-State: AOJu0YxsO0ZRYXeo9ESeZlCrRxzXAN5Q5iJtnL1u14jR9ALX04oo41R3
 I6N4fZv7RwyCMERUAOENfqeoIZs1WS7BE/inoD50RUeXYC5xLMHJcNa1oMlTKBo=
X-Google-Smtp-Source: AGHT+IHDtHU0ccJr5rc5xz8My9arnYk+SlnudjoCir3kQRdzjKiDoRSU1ko8s5OGs4YQqLHIEVXPxQ==
X-Received: by 2002:a05:6512:398a:b0:539:f2f6:c70f with SMTP id
 2adb3069b0e04-53b1a2fed80mr1092099e87.8.1729683844676; 
 Wed, 23 Oct 2024 04:44:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91370e54sm462834566b.102.2024.10.23.04.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:44:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6AE8B5FC0F;
 Wed, 23 Oct 2024 12:34:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v3 15/18] testing: Enhance gdb probe script
Date: Wed, 23 Oct 2024 12:34:03 +0100
Message-Id: <20241023113406.1284676-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023113406.1284676-1-alex.bennee@linaro.org>
References: <20241023113406.1284676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Use list and set comprehension to simplify code. Also, gently handle
invalid gdb filenames.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241022105614.839199-16-alex.bennee@linaro.org>
Message-Id: <20241015145848.387281-1-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.39.5


