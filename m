Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186ADC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 04:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue52s-0005nu-94; Tue, 22 Jul 2025 00:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue52b-0005df-UH
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:55:55 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue52U-0004H8-FB
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:55:46 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b31e076f714so4280971a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753160141; x=1753764941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LQZIHbBuXid8iCd4uQRcE8cD4Q27Dve1/07zd+zCHI=;
 b=oM1DzS0m5WQNiwpd9HfmGnqJ2ZDUuue86MfRRKro4Zi8BygBuYRLBiLigIwcnwJqG3
 iY10Jykg9MSX4w/MLXysx7etSM/2+xJpT6Z8W2Dcex6lFdaSJO806mCBvrPL2qrvtfVU
 rz2VvPyzBXXANoHmyXnigEZZXu53MGXNZ3YOb/4UehU+udWOvFWaYyHpGrsXziQ1gxmu
 0MfDoqEL6QozjzZ/C8d1hdDC5fwMSE95tUzXMydoH8DcrTDLODah1MDLHDtReFbEhIpf
 8gMj/RZ9TfguLPuXNdyhq2WoHGt50xxLBjOF8oUhKossuOJWKrG6gZJMFo5msyBUg1m+
 UQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753160141; x=1753764941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LQZIHbBuXid8iCd4uQRcE8cD4Q27Dve1/07zd+zCHI=;
 b=v9qdqZn3uX+fuQzR70WPDzK0wNiH5qFMce1ETsx9VOsjkp7JD36MmEWsd39E2ZErkI
 VNu+U7YmHkNuiFVi1nH1f6AgQWo/Nc4NoIq5jt0VQRurGxiIiJywjlkvZJ1AbkS2prM5
 Ql0DQ01g8YHpjKQOlGLwKQvG2AkMiroCqfP522SAywHAOqYwRSv1ppWcEUdoLRRsWueH
 7tA43FiW7ykNfrDknHms86lP4iHpZDH/t//g0NYqdqrecDmzZSNngc14rX1ecInJ+kRv
 847y8+gRYbeID7Tamvo4ZMgG4gn+RUpyCH8NKfV4EWThDhvHOfMAxqOiUIR407WJdmWb
 OlaA==
X-Gm-Message-State: AOJu0YxU5GUum45u3jAhO0J+wgGiqPGFGzuIGd2naN3CGlqxKFW6HGvA
 kvzxRd23dKI9VUGTzKEPQhNzbq7vIiK3iY6ZShy+qm91q5uBtQTo6u9qC15lEokVl2WYIvAiG1V
 2/PDC
X-Gm-Gg: ASbGncvpD6ybpGECP0WrtukRb9CdqPrelH2q+k+kGlGZBilWb5DeobyfXu/t9iEZ5jJ
 P3Pq6ajIcTRT/G8U6tmw2Dey0nvoBjpbYOT1h6ZYan/7vvIZkR1cKRxhQIZ0/Oq5TFLrZtGxioe
 GS5mqI5o/i7EnQkng3fO6VP3KlLCKrQyytDuoiPYMSv4wdeqxEwf8XZqDqMQlE5meU7xSV993Av
 VOVVSTd71lBDS4fN0BMyGfmDTaTwmess/Ui4z3hbFoDZvnQg7zq5i7K5+MdEQEhixMb5z3a4A6g
 wDXvjgcN6Ypm+1X7GORfACjhGZXAPFKMya9fPBCUwkWqTO293dMO6NiKeS3JVzhqjeFr9DBpJQN
 SQL+k4sR6k/HUMcd1Q6n+Bg==
X-Google-Smtp-Source: AGHT+IEDCuBSbX9XZo4DiCbxY3XxmlhDLekqSzM/TK6YiYZV6Et4cux2UWWGmnX0l+YhE5oG5n9vng==
X-Received: by 2002:a17:90b:3910:b0:311:83d3:fd9c with SMTP id
 98e67ed59e1d1-31e3dfcfbb0mr3110650a91.0.1753160140513; 
 Mon, 21 Jul 2025 21:55:40 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31cc3e5b038sm7065311a91.10.2025.07.21.21.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 21:55:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/6] contrib/plugins/uftrace_symbols.py
Date: Mon, 21 Jul 2025 21:55:26 -0700
Message-ID: <20250722045527.1164751-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722045527.1164751-1-pierrick.bouvier@linaro.org>
References: <20250722045527.1164751-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

usage:  contrib/plugins/uftrace_symbols.py \
        --prefix-symbols \
        arm-trusted-firmware/build/qemu/debug/bl1/bl1.elf \
        arm-trusted-firmware/build/qemu/debug/bl2/bl2.elf \
        arm-trusted-firmware/build/qemu/debug/bl31/bl31.elf \
        u-boot/u-boot:0x60000000 \
        u-boot/u-boot.relocated:0x000000023f6b6000 \
        linux/vmlinux

Will generate symbols and memory mapping files for uftrace, allowing to
have an enhanced trace, instead of raw addresses.

It takes a collection of elf files, and automatically find all their
symbols, and generate an ordered memory map based on that.

This script uses the python (native) pyelftools module.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace_symbols.py | 152 +++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100755 contrib/plugins/uftrace_symbols.py

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
new file mode 100755
index 00000000000..b49e03203c8
--- /dev/null
+++ b/contrib/plugins/uftrace_symbols.py
@@ -0,0 +1,152 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+#
+# Create symbols and mapping files for uftrace.
+#
+# Copyright 2025 Linaro Ltd
+# Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+import elftools # pip install pyelftools
+import os
+
+from elftools.elf.elffile import ELFFile
+from elftools.elf.sections import SymbolTableSection
+
+def elf_func_symbols(elf):
+    symbol_tables = [(idx, s) for idx, s in enumerate(elf.iter_sections())
+                  if isinstance(s, SymbolTableSection)]
+    symbols = []
+    for _, section in symbol_tables:
+        for _, symbol in enumerate(section.iter_symbols()):
+            if symbol_size(symbol) == 0:
+                continue
+            type = symbol['st_info']['type']
+            if type == 'STT_FUNC' or type == 'STT_NOTYPE':
+                symbols.append(symbol)
+    symbols.sort(key = lambda x: symbol_addr(x))
+    return symbols
+
+def symbol_size(symbol):
+    return symbol['st_size']
+
+def symbol_addr(symbol):
+    addr = symbol['st_value']
+    # clamp addr to 48 bits, like uftrace entries
+    return addr & 0xffffffffffff
+
+def symbol_name(symbol):
+    return symbol.name
+
+class BinaryFile:
+    def __init__(self, path, map_offset):
+        self.fullpath = os.path.realpath(path)
+        self.map_offset = map_offset
+        with open(path, 'rb') as f:
+            self.elf = ELFFile(f)
+            self.symbols = elf_func_symbols(self.elf)
+
+    def path(self):
+        return self.fullpath
+
+    def addr_start(self):
+        return self.map_offset
+
+    def addr_end(self):
+        last_sym = self.symbols[-1]
+        return symbol_addr(last_sym) + symbol_size(last_sym) + self.map_offset
+
+    def generate_symbol_file(self, prefix_symbols):
+        binary_name = os.path.basename(self.fullpath)
+        sym_file_path = f'./uftrace.data/{binary_name}.sym'
+        print(f'{sym_file_path} ({len(self.symbols)} symbols)')
+        with open(sym_file_path, 'w') as sym_file:
+            # print hexadecimal addresses on 48 bits
+            addrx = "0>12x"
+            for s in self.symbols:
+                addr = symbol_addr(s)
+                addr = f'{addr:{addrx}}'
+                size = f'{symbol_size(s):{addrx}}'
+                name = symbol_name(s)
+                if prefix_symbols:
+                    name = f'{binary_name}:{name}'
+                print(addr, size, 'T', name, file=sym_file)
+
+def parse_parameter(p):
+    s = p.split(":")
+    path = s[0]
+    if len(s) == 1:
+        return path, 0
+    if len(s) > 2:
+        raise ValueError('only one offset can be set')
+    offset = s[1]
+    if not offset.startswith('0x'):
+        err = f'offset "{offset}" is not an hexadecimal constant. '
+        err += 'It should starts with "0x".'
+        raise ValueError(err)
+    offset = int(offset, 16)
+    return path, offset
+
+def is_from_user_mode(map_file_path):
+    if os.path.exists(map_file_path):
+        with open(map_file_path, 'r') as map_file:
+            if not map_file.readline().startswith('# map stack on'):
+                return True
+    return False
+
+def generate_map(binaries):
+    map_file_path = './uftrace.data/sid-0.map'
+
+    if is_from_user_mode(map_file_path):
+        print(f'do not overwrite {map_file_path} generated from qemu-user')
+        return
+
+    mappings = []
+
+    # print hexadecimal addresses on 48 bits
+    addrx = "0>12x"
+
+    mappings += ['# map stack on highest address possible, to prevent uftrace']
+    mappings += ['# from considering any kernel address']
+    mappings += ['ffffffffffff-ffffffffffff rw-p 00000000 00:00 0 [stack]']
+
+    for b in binaries:
+        m = f'{b.addr_start():{addrx}}-{b.addr_end():{addrx}}'
+        m += f' r--p 00000000 00:00 0 {b.path()}'
+        mappings.append(m)
+
+    with open(map_file_path, 'w') as map_file:
+        print('\n'.join(mappings), file=map_file)
+    print(f'{map_file_path}')
+    print('\n'.join(mappings))
+
+def main():
+    parser = argparse.ArgumentParser(description=
+                                     'generate symbol files for uftrace')
+    parser.add_argument('elf_file', nargs='+',
+                        help='path to an ELF file. '
+                        'Use /path/to/file:0xdeadbeef to add a mapping offset.')
+    parser.add_argument('--prefix-symbols',
+                        help='prepend binary name to symbols',
+                        action=argparse.BooleanOptionalAction)
+    args = parser.parse_args()
+
+    if not os.path.exists('./uftrace.data'):
+        os.mkdir('./uftrace.data')
+
+    binaries = []
+    for file in args.elf_file:
+        path, offset = parse_parameter(file)
+        b = BinaryFile(path, offset)
+        binaries.append(b)
+    binaries.sort(key = lambda b: b.addr_end());
+
+    for b in binaries:
+        b.generate_symbol_file(args.prefix_symbols)
+
+    generate_map(binaries)
+
+if __name__ == '__main__':
+    main()
-- 
2.47.2


