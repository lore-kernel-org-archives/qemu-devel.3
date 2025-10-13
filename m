Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1B4CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 21:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8QGb-0005uM-8u; Mon, 13 Oct 2025 17:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v8QGZ-0005u6-DL
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 17:39:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v8QGT-0001Yo-OB
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 17:39:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-27ee41e0798so75062275ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760391571; x=1760996371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LmwKSrFlZ7WCHwQQLdG8dqWWJAdIzVLNDU53jl3kQbU=;
 b=pPeGBC+2Hkq34IGFl12wdMzpA6JNKnDqAt5fjwH3SmEdiGKNQWFdoCminmfJIm1Il8
 Tl0Gs2eatr1WuGKxpnBrv8XCfHPrnalPUAyQbq2kdrI0KMqmcCKeNE7nO1sCA5vskKaU
 7uCyv9POu3Ymu1J1qnz0t5uHqKYN1IKqZoknjEdX0VgRa/HAJHB7yOc2dl2/nEQ9wnlr
 v+uJOP/M9ZyBl5gvfUOPYbyXJjvOzvx+M0esyV86HzhBD7SCHqmLVSaGqE38cwXfzOns
 Oblcb+uFWSNJl42wOJdPXTaEiNnwq7x0zStqEp8dsk9k26PrbzxvTqjGI0LnsoCzU6tu
 Ejqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760391571; x=1760996371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LmwKSrFlZ7WCHwQQLdG8dqWWJAdIzVLNDU53jl3kQbU=;
 b=FiX4QxIG1z5s5dKzTNTEDUONCDJvI5abBMniTMJS3WZ1ccwT8+TQHlugEqfNjxkwxb
 WiTdiyytW1jJXVbipQs70NgFe7sgqquAyAsFNbl8oem548cxtaWnNfqOSAiIquzlVDHK
 S56ERV8fdj46zq7xXUvr8CqD9aaDVVpS8LeRcBFaIB9NhuZ6V7EOIeeV2tynpSrdzoEs
 ePT7zJy3R+mka1AKbc/ogPBUrsn8CwmxiLpCUcDV3WViKcNEhhvc9cZ4Dxle8ttZZQjr
 IoLq/vlhcQyowg2essllLz02+pPvqqYBFPNPMAl4ErnPp6aRgTwe2ovXcu5WPtdwnO/j
 3yxw==
X-Gm-Message-State: AOJu0YyCUkFZFWEdILB9PIq3GLr2DeMcofq96LBhwfo5Rr+MlZlgf0c/
 NAi2WLfCHSpKnCbTRMyWUyw0aiOAOevldwAlF2hwCseuAsPKWLXTy4OxOm0UmWp1dT89+mwMVWr
 CO3uu
X-Gm-Gg: ASbGncspfSZBFx8jzM2n6tLrC9ATa3gNJx3FXKVhSvRoZE9ZGNeFammyBeaE1tvy3+8
 IUaOQJfaLXTWpBDti/0ikxw6Gctm1KRCU1bNVw1JXJpMDoZc/xS9ScXBDGHTBtn/ctENslGp3nP
 yyTTbk6sEDDMsMDQXLA1lS42WDZJSvprBHZQtaSEk8AQ3T7stqoS0PfEs9H2zlaCKdl3HaZOQ3K
 JN0coXZbY4HXXtqzOw+t0hBjsJlVqAOcZVBz8bJ8N2e4DL2w9RDFvNrMXuF6IoeGtRUNnY5Xa0I
 awqHW/lm9cBFX/fMipSrRWAWIY9sfA2JOVMAa8YzgA1fiY7uQeCTECo4+5lxyxG3SGxHUYdOm49
 tlBFvd90HFYXvDCryIDgz3MzAJ3Hba+cQlr+M5zUL5ueityJrLD1K/BY96l3azBs7PS6UBTnth8
 Ct
X-Google-Smtp-Source: AGHT+IE5DfsZx9LpVBYPMjjnfAbYewX4QtMnKpjHjLDDeV6HDcnfr+ZDZgeuaqQ9G5fChEdimPpbhQ==
X-Received: by 2002:a17:903:2a8d:b0:24e:e5c9:ecfd with SMTP id
 d9443c01a7336-290273ffc74mr273514955ad.42.1760391571392; 
 Mon, 13 Oct 2025 14:39:31 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f08998sm141404045ad.80.2025.10.13.14.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 14:39:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] contrib/plugins/uftrace_symbols.py: generate debug files to
 map symbols to source
Date: Mon, 13 Oct 2025 14:39:12 -0700
Message-ID: <20251013213912.413386-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Enhance uftrace_symbols.py to generate .dbg files, containing
source location for every symbol present in .sym file.
It allows to use uftrace {replay,dump} --srcline and show origin of
functions, connecting trace to original source code.

It was first implemented with pyelftools DWARF parser, which was way
to slow (~minutes) to get locations for every symbol in the linux
kernel. Thus, we use addr2line instead, which runs in seconds.

As well, there were some bugs with latest pyelftools release,
requiring to run master version, which is not installable with pip.
Thus, since we now require binutils (addr2line), we can ditch pyelftools
based implementation and simply rely on nm to get symbols information,
which is faster and better.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace_symbols.py | 108 +++++++++++++++++++----------
 1 file changed, 72 insertions(+), 36 deletions(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index b49e03203c8..728bf04ce54 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 # -*- coding: utf-8 -*-
 #
-# Create symbols and mapping files for uftrace.
+# Create symbols, debug and mapping files for uftrace.
 #
 # Copyright 2025 Linaro Ltd
 # Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
@@ -9,44 +9,71 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import argparse
-import elftools # pip install pyelftools
 import os
+import subprocess
 
-from elftools.elf.elffile import ELFFile
-from elftools.elf.sections import SymbolTableSection
+class Symbol:
+    def __init__(self, name, addr, size):
+        self.name = name
+        # clamp addr to 48 bits, like uftrace entries
+        self.addr = addr & 0xffffffffffff
+        self.full_addr = addr
+        self.size = size
 
-def elf_func_symbols(elf):
-    symbol_tables = [(idx, s) for idx, s in enumerate(elf.iter_sections())
-                  if isinstance(s, SymbolTableSection)]
-    symbols = []
-    for _, section in symbol_tables:
-        for _, symbol in enumerate(section.iter_symbols()):
-            if symbol_size(symbol) == 0:
-                continue
-            type = symbol['st_info']['type']
-            if type == 'STT_FUNC' or type == 'STT_NOTYPE':
-                symbols.append(symbol)
-    symbols.sort(key = lambda x: symbol_addr(x))
+    def set_loc(self, file, line):
+        self.file = file
+        self.line = line
+
+def get_symbols(elf_file):
+    symbols=[]
+    try:
+        out = subprocess.check_output(['nm', '--print-size', elf_file],
+                                      stderr=subprocess.STDOUT,
+                                      text=True)
+    except subprocess.CalledProcessError as e:
+        print(e.output)
+        raise
+    out = out.strip().split('\n')
+    for line in out:
+        info = line.split(' ')
+        if len(info) == 3:
+            # missing size information
+            continue
+        addr, size, type, name = info
+        # add only symbols from .text section
+        if type.lower() != 't':
+            continue
+        addr = int(addr, 16)
+        size = int(size, 16)
+        symbols.append(Symbol(name, addr, size))
+    symbols.sort(key = lambda x: x.addr)
     return symbols
 
-def symbol_size(symbol):
-    return symbol['st_size']
-
-def symbol_addr(symbol):
-    addr = symbol['st_value']
-    # clamp addr to 48 bits, like uftrace entries
-    return addr & 0xffffffffffff
-
-def symbol_name(symbol):
-    return symbol.name
+def find_symbols_locations(elf_file, symbols):
+    addresses = '\n'.join([hex(x.full_addr) for x in symbols])
+    try:
+        out = subprocess.check_output(['addr2line', '--exe', elf_file],
+                                      stderr=subprocess.STDOUT,
+                                      input=addresses, text=True)
+    except subprocess.CalledProcessError as e:
+        print(e.output)
+        raise
+    out = out.strip().split('\n')
+    assert len(out) == len(symbols)
+    for i in range(len(symbols)):
+        s = symbols[i]
+        file, line = out[i].split(':')
+        # addr2line may return 'line (discriminator [0-9]+)' sometimes,
+        # remove this to keep only line number.
+        line = line.split(' ')[0]
+        s.set_loc(file, line)
 
 class BinaryFile:
     def __init__(self, path, map_offset):
         self.fullpath = os.path.realpath(path)
         self.map_offset = map_offset
-        with open(path, 'rb') as f:
-            self.elf = ELFFile(f)
-            self.symbols = elf_func_symbols(self.elf)
+        self.symbols = get_symbols(self.fullpath)
+        find_symbols_locations(self.fullpath, self.symbols)
 
     def path(self):
         return self.fullpath
@@ -56,7 +83,7 @@ def addr_start(self):
 
     def addr_end(self):
         last_sym = self.symbols[-1]
-        return symbol_addr(last_sym) + symbol_size(last_sym) + self.map_offset
+        return last_sym.addr + last_sym.size + self.map_offset
 
     def generate_symbol_file(self, prefix_symbols):
         binary_name = os.path.basename(self.fullpath)
@@ -66,14 +93,21 @@ def generate_symbol_file(self, prefix_symbols):
             # print hexadecimal addresses on 48 bits
             addrx = "0>12x"
             for s in self.symbols:
-                addr = symbol_addr(s)
+                addr = s.addr
                 addr = f'{addr:{addrx}}'
-                size = f'{symbol_size(s):{addrx}}'
-                name = symbol_name(s)
+                size = f'{s.size:{addrx}}'
                 if prefix_symbols:
-                    name = f'{binary_name}:{name}'
+                    name = f'{binary_name}:{s.name}'
                 print(addr, size, 'T', name, file=sym_file)
 
+    def generate_debug_file(self):
+        binary_name = os.path.basename(self.fullpath)
+        dbg_file_path = f'./uftrace.data/{binary_name}.dbg'
+        with open(dbg_file_path, 'w') as dbg_file:
+            for s in self.symbols:
+                print(f'F: {hex(s.addr)} {s.name}', file=dbg_file)
+                print(f'L: {s.line} {s.file}', file=dbg_file)
+
 def parse_parameter(p):
     s = p.split(":")
     path = s[0]
@@ -84,7 +118,7 @@ def parse_parameter(p):
     offset = s[1]
     if not offset.startswith('0x'):
         err = f'offset "{offset}" is not an hexadecimal constant. '
-        err += 'It should starts with "0x".'
+        err += 'It should start with "0x".'
         raise ValueError(err)
     offset = int(offset, 16)
     return path, offset
@@ -124,7 +158,8 @@ def generate_map(binaries):
 
 def main():
     parser = argparse.ArgumentParser(description=
-                                     'generate symbol files for uftrace')
+                                     'generate symbol files for uftrace. '
+                                     'Require binutils (nm and addr2line).')
     parser.add_argument('elf_file', nargs='+',
                         help='path to an ELF file. '
                         'Use /path/to/file:0xdeadbeef to add a mapping offset.')
@@ -145,6 +180,7 @@ def main():
 
     for b in binaries:
         b.generate_symbol_file(args.prefix_symbols)
+        b.generate_debug_file()
 
     generate_map(binaries)
 
-- 
2.47.3


