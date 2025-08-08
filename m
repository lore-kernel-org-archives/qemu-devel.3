Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CD6C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 02:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCW3-0008R6-E5; Thu, 07 Aug 2025 22:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVw-0008Ap-0Q
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVq-0003V5-Vm
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bd050184bso2318546b3a.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754618837; x=1755223637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LQZIHbBuXid8iCd4uQRcE8cD4Q27Dve1/07zd+zCHI=;
 b=Mv01FUgQ8IYifXnLJ+dl5fnuMnKQ6s1xrJz89jBVamUZ1C/Ci6lgBbwYFQrFpllHD3
 F6NZL1WoorRPtUwTru+7aaaRm4oW6a/o5rCCd+4niLP2X43mR23jI+a8FjL9nEuYt6WC
 oUHJ/wkw4umv9XNjqXIBjaGFb67/NCgHdEct0uMldP9tio4IIi381H/lN/qdLitKNzhs
 1vqQMpmDRv507pA85r6sJEkTDZ1jH1Yg13MtxTakpCRhG6kPMHcz3VpxlpPW9QYOI0a1
 UeJOCfPH6awGS+UWxgCfOf1rawxFuwKix5n4C5S3xU0YRg/I49pRhKNlbLOHHQzIUUsv
 0I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754618837; x=1755223637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LQZIHbBuXid8iCd4uQRcE8cD4Q27Dve1/07zd+zCHI=;
 b=P1UqV/sFO9Dq9yxRd01OIblyUCGVatZEBkvhocVy3oRGEL+vWqB9w5DHCtOMvfI3hL
 UnNtX+W3JzCaSSJmBWdCBmHWln+Q8KpadKKtTShIYAL7DPSnura/BjvPfNZYxdL3SxBx
 PpRgykiVovzSW/xDRqykU1eGoQtr7R1fVfplBB5dy2QtBXnGjCK9LN7RdlkZZMT1rCr8
 z/BxHbAlphbLKAJr/y8lgIqXOFsOZ07icFdueg93kxX+zTFgQXB+6z4LeLQbhVYPdbxl
 K98M7XA0BTkJ3U6Sg9zcScVf5WvuC0hmJbhZDpoEPDgecfn3gAd3ed6+RNIZkYIgIm7q
 o+vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0YC5wbJ9eLRox+3bX4O8NeCdsl/hmJyW4dupmKk5957UlUqQhyNkfwbrD3MlSHsjwRW63Asw4RgUU@nongnu.org
X-Gm-Message-State: AOJu0Yy1bAcDev34xPaW8QTMhpFTiczzLTEz62iClAVp53Qani6v3+nS
 vK/pPEtBwSW5YuJ0Hcf3IAylkKfydpC8qm8EAvMirFPlSm31BLDTf0pGA7ScsTPhVcQ=
X-Gm-Gg: ASbGncsZKfOYDFS7xtzV3VYiI/1+9EEdWiBWH3DeO5hyMSDCD4l8Y/+nQpyJFj34q5I
 yGQVD+zgMaE2dP+aftBpa5KiC63tLzbJ64gy0Tk3/jBvTH8pnwIgHwh9t7ZNMogHuMeq7AtWjpJ
 tl1sAQWzLOqubVUHDfAnxJzL5nL3u3OhzkRmVVHcKT+N6uDivflODy2xfgNvSEtn5aB54YJJ034
 wp4iQPmxlF66fhd8kO0rBoiSW1IDniet0VclxwqEgV3PLZiJ9I1PllIHBEA81AA/fOR97aqMQVY
 MteIoSnRieJNg2ps3DjDI6yVeU0RQLF2UkCo/xoO42pGTcyeQkrpcQ2ulJnc8Ij/O2Z3/GvWhkP
 DPiYIGPR8IMpgG6mdKfgOnQ==
X-Google-Smtp-Source: AGHT+IFOUEdu9PZYbRGs3tt6e+xSTPwYWTlZoRejyJo6Urx05EmonMbZCpV2bOHWEGp5uzOhnMuCLg==
X-Received: by 2002:a05:6a20:5493:b0:231:a5f3:4d0c with SMTP id
 adf61e73a8af0-240551321eemr1815974637.26.1754618837001; 
 Thu, 07 Aug 2025 19:07:17 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b428ba4cf35sm3705433a12.14.2025.08.07.19.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 19:07:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 8/9] contrib/plugins/uftrace_symbols.py
Date: Thu,  7 Aug 2025 19:07:01 -0700
Message-ID: <20250808020702.410109-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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


