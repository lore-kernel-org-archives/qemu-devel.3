Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658C7CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PX3-0002ID-Hy; Thu, 16 Oct 2025 11:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWm-0002GC-U4
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWa-0001BP-8i
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so4509235e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627049; x=1761231849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zp4dBelYcrDdnG9qeH0z5QyNjh/aPBWG7icXFCLgLbY=;
 b=gePZE7XPKS3/DSd+oDMA8BCt1PL7RW8nFi2gA7YDD4hL1V6C8NOYHXHmSvONcHKwVG
 7Bn14h5eWjC0RTYevjKbw6kG1K/EybwZgfidASpmAlI2exjUwGU0gHMCDM9PveVQ+Zny
 HNRiP8BrDVuBpcgl8tfnERc0FwvsUULU4mvdmvh6oDKZaJ7DsSIjn3Fw8fD6/PEcFTln
 6orUvUUTWr+bLDABmp194On74Gw51ltiwfJUoS/taePd/inuWUNDc8ZcMjCk7jcUWQty
 2ZopeXv9Rx51S0LLVofpHmXUSTEXsQF1GnrDMqKvI4bQJ7tKhbHARs2YIrVOTWjNTnfB
 pCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627049; x=1761231849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zp4dBelYcrDdnG9qeH0z5QyNjh/aPBWG7icXFCLgLbY=;
 b=ljwVXJRi/SjoeGb8/bKsPCNA9UiKXm9w4dEiksPzqOL7Q7q050QkZU0Jsgxyep3C/E
 79CemUiOr8Bi817f93Z3+6V5+L2jqmC19CA5FR7KRKT9meSRku89+wKSdlc+V8pgdX+L
 Kq3LMotge44K13GtF2EFdv/v8oVxiMoh8gFR7KhE2IYwxnv1CM5zPVMOCpz7cmghB7As
 5/bnhhLa1GzEzWObbVH7OXA9JhQ/hjJIEweOxfgpbk8DP2mJCt57DecZHO+kUgds9TRb
 +WcL6rm2zIuIWvwWWlEt54442E6BoukQsvSRVcMHhvzXkljEnvRydGil1nBearfZ0m7c
 Ofcw==
X-Gm-Message-State: AOJu0YzYYqfgbN37nPwYuVUTVQWn8siAMagm5B0Q2Bk2G2hBdAyRtxCr
 tI5dbj5v34ynXSzAGfU9Shqm53GNYk6wDyCG+3K8BV3xX7vBmfKzOx4VXdcvlN2WytM=
X-Gm-Gg: ASbGncvU8hVVaF2csIAmCIAIQ+bhjMWTxUeYGAh0cA6b1qMUF2EAZRfqGGjSeZSThRF
 X+Da7xoqjjqrlSfAnDFMzcGo6aGbr19Ii6AX0jIemluw/U9BbsfikHHt5HIP95Vi2wdFEC9+fE8
 0G4iU7ly1y49k7QWelYcfM9JJKMLJPruZIRYVnxINBDhGyVAgcy1K3BZC0JulhdkzmzIOhgapGu
 gMP8VPPrLmgV7mSYcyf6LFjUNEtriNmFnGm2PFo83mCeB0FNDanp0Vz5F7q7JlW7paoWoAuJZQQ
 XGMsMWw3LFhEnA3AMCJjH8XihVOPqTppdpfIk5B7d8d2provIWkMlCDmAQdd1yJkV3oFXQJ85sA
 iOUakckaM76jY1xb/ES9+cgjeqVrGNfsbOmSLxFD/uf+H1yy0nBe5bzN8jhoivjij5tMr1sxitS
 isAB6SOrarHENefViL8FWF8ixzVg==
X-Google-Smtp-Source: AGHT+IFQprA22hyfbXF9KVjjlncotxu4f6SHQ8l012K8WptALDqjp16O5AHXuFVKfEaeFiSU/dPhZQ==
X-Received: by 2002:a05:600c:a013:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-47117919b6cmr2509825e9.31.1760627048967; 
 Thu, 16 Oct 2025 08:04:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cd11sm35592379f8f.5.2025.10.16.08.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:04:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27FF15FAD2;
 Thu, 16 Oct 2025 16:03:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 07/11] contrib/plugins/uftrace_symbols.py: generate debug
 files to map symbols to source
Date: Thu, 16 Oct 2025 16:03:52 +0100
Message-ID: <20251016150357.876415-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Enhance uftrace_symbols.py to generate .dbg files, containing
source location for every symbol present in .sym file.
It allows to use `uftrace {replay,dump} --srcline` and show origin of
functions, connecting trace to original source code.

It was first implemented with pyelftools DWARF parser, which was way
too slow (~minutes) to get locations for every symbol in the linux
kernel. Thus, we use `addr2line` instead, which runs in seconds.

As well, there were some bugs with latest pyelftools release,
requiring to run master version, which is not installable with pip.
Thus, since we now require binutils (addr2line), we can ditch pyelftools
based implementation and simply rely on `nm` to get symbols information,
which is faster and better.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/uftrace_symbols.py | 120 +++++++++++++++++++----------
 1 file changed, 78 insertions(+), 42 deletions(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index b49e03203c8..45fb79c7a58 100755
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
-
-from elftools.elf.elffile import ELFFile
-from elftools.elf.sections import SymbolTableSection
-
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
+import subprocess
+
+class Symbol:
+    def __init__(self, name, addr, size):
+        self.name = name
+        # clamp addr to 48 bits, like uftrace entries
+        self.addr = addr & 0xffffffffffff
+        self.full_addr = addr
+        self.size = size
+
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
@@ -56,24 +83,31 @@ def addr_start(self):
 
     def addr_end(self):
         last_sym = self.symbols[-1]
-        return symbol_addr(last_sym) + symbol_size(last_sym) + self.map_offset
+        return last_sym.addr + last_sym.size + self.map_offset
 
     def generate_symbol_file(self, prefix_symbols):
         binary_name = os.path.basename(self.fullpath)
-        sym_file_path = f'./uftrace.data/{binary_name}.sym'
+        sym_file_path = os.path.join('uftrace.data', f'{binary_name}.sym')
         print(f'{sym_file_path} ({len(self.symbols)} symbols)')
         with open(sym_file_path, 'w') as sym_file:
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
+        dbg_file_path = os.path.join('uftrace.data', f'{binary_name}.dbg')
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
@@ -97,7 +131,7 @@ def is_from_user_mode(map_file_path):
     return False
 
 def generate_map(binaries):
-    map_file_path = './uftrace.data/sid-0.map'
+    map_file_path = os.path.join('uftrace.data', 'sid-0.map')
 
     if is_from_user_mode(map_file_path):
         print(f'do not overwrite {map_file_path} generated from qemu-user')
@@ -124,7 +158,8 @@ def generate_map(binaries):
 
 def main():
     parser = argparse.ArgumentParser(description=
-                                     'generate symbol files for uftrace')
+                                     'generate symbol files for uftrace. '
+                                     'Require binutils (nm and addr2line).')
     parser.add_argument('elf_file', nargs='+',
                         help='path to an ELF file. '
                         'Use /path/to/file:0xdeadbeef to add a mapping offset.')
@@ -133,8 +168,8 @@ def main():
                         action=argparse.BooleanOptionalAction)
     args = parser.parse_args()
 
-    if not os.path.exists('./uftrace.data'):
-        os.mkdir('./uftrace.data')
+    if not os.path.exists('uftrace.data'):
+        os.mkdir('uftrace.data')
 
     binaries = []
     for file in args.elf_file:
@@ -145,6 +180,7 @@ def main():
 
     for b in binaries:
         b.generate_symbol_file(args.prefix_symbols)
+        b.generate_debug_file()
 
     generate_map(binaries)
 
-- 
2.47.3


