Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CA9CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnS-00078T-Iu; Tue, 02 Sep 2025 03:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnK-00076M-Bx
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:12 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnF-0001vT-FK
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:10 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7722bcb989aso2689364b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799464; x=1757404264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRefeMWyZSYaeV5SOh3x+t98m3lhnIbtiTK21kQRzUM=;
 b=nrLxsOL7q7LwoquFu9ql+E4plwOTRmpjo2c/Ar8XrHSkq1OTAKa2zyygO9p16ZzKOc
 2Q+LNlZBc+MUo3zkS6Chzq4cOMarcHkJJu8m2WvyD+E7E7Fgfrjz5kFjZVP3mWt6Aqpb
 VgD/A9E+1WPjiCJCSvxwZULeE920aGH2G8xNHX+tfFhDjmmDvoug1wRIYHucvw/OMsui
 fNE9jkXJA5hH0bDn4lBSgtU/iFECp5XAzfmEwVPAwf34LyDHJXnI7LLHgrIDJo+5U10V
 zWJYSO5N9TNhhjadMo9kZVijCVzDSAM6gTLcrUnUyxAJL5PfO4HUmYe+VgT7brqbWGqA
 48ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799464; x=1757404264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LRefeMWyZSYaeV5SOh3x+t98m3lhnIbtiTK21kQRzUM=;
 b=hCDuxCu09pGHc1OAjg85edXm01KF5YjpaZVPE3SY9N72uG4YnPShsJ3q9xqgz86Uz+
 oUlAtuEsQPwuGwlyzhPTKlyu0qagCorL/+XO958eQOObYIxPlaQpGc7gATiNgkxlgh7O
 YroKCKz3+g7d8kyQP4v64Fenkex/kDCqq+hUIPNutwwLp9nC3WTTm0uUBw6JrbP87Iws
 2q4BbDidZudFMP4N477P77UHs/44LuauMymUTBBnAViOGFcXavBDsSoqA0ZiuF6KXl0b
 cCoMHvmlrc57FD853ZFBOqBcQ2vApaYeQiWx+Hwjz/Rvgvq7u2yY5PrbyY+LuF/Z9TXI
 Z65g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyKvYq3X1oA/SMRltyo4/+qk2r28XTSEdwPWMg5rAJwu/kkL3jUfYpxLmtDfrfAxlUHP6RCpDWP891@nongnu.org
X-Gm-Message-State: AOJu0YynfOxEnSMevfQYDWGpbFRtLs1Hjy+kYszXhMLpHPqyyI1+74b5
 5sicKc2NcPzLc8wGgQxyV3N39wub2SzYTPThKp9sZ0UKFV7OVeuAABwIoZWPqeh50xg=
X-Gm-Gg: ASbGnct7rH6g1OGtc+jkQaBCHrpHImZtqMbUK/CrYGle69B5XleVUuX5MfyxXzI8VqQ
 z8FgOYZqMtyYXdGiaYaHDkM0ZmJtUtrPVBxLBZRwvIAc+usIeJ9412F21W8mHFHfhqWg6e3obWp
 NGAl3LKVkCsGj2WbKFo3WCGCq4LY5ZKhfuQLTZP+W7efmlJ1PNtoUweYvsFKEF50iJVFMyEKhUQ
 4aurss1Syld1wE6k/1hZdxRC6IU9BSFIfdLj361Xqd5vDGJtKTVoG7vmU1EClOlJU0XLFo5bdOu
 pkpz2BVCVJHCFGiy6yRmnJyBpsT5KSqAj13jiuoF2w5WEv+NOsbz7Uai2bSTMi4VuyZnnQGuB1Q
 yHFSAfTVZO2schdO8nSkQBjsZP3ORa/xbnt40o2mQ0Xw=
X-Google-Smtp-Source: AGHT+IExxrXndfd/JyQJFZnzp3ZN0WaxLY4BSggEb9KpmfCvlMW6vbZLhcgzC36eW4IHebD6U2FcTA==
X-Received: by 2002:a05:6a00:4b03:b0:748:e5a0:aa77 with SMTP id
 d2e1a72fcca58-7723e276b6dmr11388698b3a.13.1756799463623; 
 Tue, 02 Sep 2025 00:51:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:51:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 8/9] contrib/plugins/uftrace_symbols.py
Date: Tue,  2 Sep 2025 00:50:41 -0700
Message-ID: <20250902075042.223990-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


