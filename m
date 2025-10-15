Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CECCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98y0-0000BZ-C5; Wed, 15 Oct 2025 17:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v98xy-0000An-BV
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:23:26 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v98xt-0002PV-0U
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:23:26 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so3521166b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760563397; x=1761168197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3sODRR1YhuhTQvTLVIya69KCZ2Yp6JqnnwpOiV3vq8=;
 b=sWzYM1tQMD1gOSJTrOAwbi3Ekr7YGhJaZIzpQSpepB0vkghKgwE3cTxMcjjAPuiInc
 kaIaJqdwHf02xiJajmQ7D3pI3BzpwdPP011UHSVJjEoMHHAUG6AxM+OdbB0vpfHqbKMw
 PMuY2lqiyCiZtst+OvscNeN8/yWsWObkH6Js9rChJP53/zl2aH6jPIh0C7FhI/v2yuYc
 5A+kZGxzu1mS65/ZS7IGR4UKCwH+coMBzysczdswWBOOS57TIR0nHlFoBdmBOVYnEfdV
 pWRrCFno2s4v3kC//6bQPFvJQJBXCTTggFf9ZntVox2jTryh7oJ3XmPcX1YSLG7RbXbt
 j/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760563397; x=1761168197;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J3sODRR1YhuhTQvTLVIya69KCZ2Yp6JqnnwpOiV3vq8=;
 b=jlv8LkkIrVxNPIZfLJr3tN/HYKy4379COIEXEevZg1hoRBVObH8zBZ+p6J9pvYs0a1
 MKtRO4f3IzOK1n/03c0+9lvKHWtR+s+0PuQ3yMHlyiJN69eUUOr8PbQkru46YMUibVdS
 GseRqo9Vtm4gbg0cpHYc6HTNVjrFF6A3fvvnmMta8izpyXI+Q4rk2rFvleP1x3g4CAbD
 hedhuJcRuXsT8rQa8ETmNMikl8sqlUrqGFJcDYAxPo4jB1qvolmMD+0XYTX8XcQH6rjC
 7+yaN18C8U0xNm83u4Jv7PKkO/1Pn3DUm1NXHuW6FP0iVEGJjuLIp4rmkeu6RlYQKFjD
 yXMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCatW4xrNUyZ4dgVU7sMROBVVfG8iS7BrqH8XRngmSx52R2h06zznnG5woruRb9fwudOKU6TQvl6xz@nongnu.org
X-Gm-Message-State: AOJu0YwWXTSBCswME4fX7tOyNOZBidHkRWtdQTq1TRfF7dd6K8ZFbVwc
 gq0vPr4Lm82w4uXdOLPUM6fXsU8UvhcSiubvHchHXuVT9ISr931N9myOfXfUfR1N3QU=
X-Gm-Gg: ASbGncsVeUgVom+xwvqdYQdyFVlTpOFAonoL7UvgcHA4ohIYJyQJjekKf05kk6dhv8v
 waqDMwhbRrC2Ba41e3km2R2eXgV/13+NOHmJXOtjLbAztzH0TeldAksE/H0jSV9DC1xETTEBq6y
 1qCqEATKbNlUki6GA9KYL3/9vNdds1KJbpl/dqLmtHH7zZWs8kapTVfOg45Pg5Zi+GL1PCTOeIs
 jLFAjVOJCwDvKF/8DlwRt9ZbSqH1d0/BYaOFUbLWAEJFvIlDGtPcOl8EKYXAwUfHiOlQjPasql5
 36UnLVhVE29NUhUgNXUNTCokW2L25ZQ0nJmHKwVlU8YN431Na8+DlVHBlF+tHNGb5XjDuGd0Ujg
 cQFhRoSa+Do8Le83LRDRYDczAitDcYZPcJBknvrDujYLFa8gX+J6B9J/aFsnocM0hmSoVN0ah/X
 WG9xPB
X-Google-Smtp-Source: AGHT+IHk0DdLGaxUQWuGvFhqxAo6HVvWySzu0LBn+ue2nTTCxSz7e2dd+Trs7NzEAHv43T5wCjDrVA==
X-Received: by 2002:a17:907:3f14:b0:b41:3c27:e3ca with SMTP id
 a640c23a62f3a-b50aa4909admr3009961266b.7.1760563397254; 
 Wed, 15 Oct 2025 14:23:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5ccccb5132sm326016966b.54.2025.10.15.14.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:23:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 82F005F7C6;
 Wed, 15 Oct 2025 22:23:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: generate debug
 files to map symbols to source
In-Reply-To: <b4a0756b-3781-433a-aa4c-338d9348da5d@linaro.org> (Pierrick
 Bouvier's message of "Wed, 15 Oct 2025 14:02:53 -0700")
References: <20251013213912.413386-1-pierrick.bouvier@linaro.org>
 <b7256e10-d5b1-4978-90e1-99d9e76318df@linaro.org>
 <b4a0756b-3781-433a-aa4c-338d9348da5d@linaro.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Wed, 15 Oct 2025 22:23:15 +0100
Message-ID: <87347jkgfw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 10/15/25 1:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 13/10/25 23:39, Pierrick Bouvier wrote:
>>> Enhance uftrace_symbols.py to generate .dbg files, containing
>>> source location for every symbol present in .sym file.
>>> It allows to use uftrace {replay,dump} --srcline and show origin of
>> `uftrace {replay,dump} --srcline`
>>=20
>>> functions, connecting trace to original source code.
>>>
>>> It was first implemented with pyelftools DWARF parser, which was way
>>> to slow (~minutes) to get locations for every symbol in the linux
>> s/to/too/
>>=20
>>> kernel. Thus, we use addr2line instead, which runs in seconds.
>>>
>>> As well, there were some bugs with latest pyelftools release,
>>> requiring to run master version, which is not installable with pip.
>>> Thus, since we now require binutils (addr2line), we can ditch pyelftools
>>> based implementation and simply rely on nm to get symbols information,
>> `nm`
>>=20
>>> which is faster and better.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    contrib/plugins/uftrace_symbols.py | 108 +++++++++++++++++++--------=
--
>>>    1 file changed, 72 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftra=
ce_symbols.py
>>> index b49e03203c8..728bf04ce54 100755
>>> --- a/contrib/plugins/uftrace_symbols.py
>>> +++ b/contrib/plugins/uftrace_symbols.py
>>> @@ -1,7 +1,7 @@
>>>    #!/usr/bin/env python3
>>>    # -*- coding: utf-8 -*-
>>>    #
>>> -# Create symbols and mapping files for uftrace.
>>> +# Create symbols, debug and mapping files for uftrace.
>>>    #
>>>    # Copyright 2025 Linaro Ltd
>>>    # Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> @@ -9,44 +9,71 @@
>>>    # SPDX-License-Identifier: GPL-2.0-or-later
>>>       import argparse
>>> -import elftools # pip install pyelftools
>>>    import os
>>> +import subprocess
>>>    -from elftools.elf.elffile import ELFFile
>>> -from elftools.elf.sections import SymbolTableSection
>>> +class Symbol:
>>> +    def __init__(self, name, addr, size):
>>> +        self.name =3D name
>>> +        # clamp addr to 48 bits, like uftrace entries
>>> +        self.addr =3D addr & 0xffffffffffff
>>> +        self.full_addr =3D addr
>>> +        self.size =3D size
>>>    -def elf_func_symbols(elf):
>>> -    symbol_tables =3D [(idx, s) for idx, s in enumerate(elf.iter_secti=
ons())
>>> -                  if isinstance(s, SymbolTableSection)]
>>> -    symbols =3D []
>>> -    for _, section in symbol_tables:
>>> -        for _, symbol in enumerate(section.iter_symbols()):
>>> -            if symbol_size(symbol) =3D=3D 0:
>>> -                continue
>>> -            type =3D symbol['st_info']['type']
>>> -            if type =3D=3D 'STT_FUNC' or type =3D=3D 'STT_NOTYPE':
>>> -                symbols.append(symbol)
>>> -    symbols.sort(key =3D lambda x: symbol_addr(x))
>>> +    def set_loc(self, file, line):
>>> +        self.file =3D file
>>> +        self.line =3D line
>>> +
>>> +def get_symbols(elf_file):
>>> +    symbols=3D[]
>>> +    try:
>>> +        out =3D subprocess.check_output(['nm', '--print-size', elf_fil=
e],
>>> +                                      stderr=3Dsubprocess.STDOUT,
>>> +                                      text=3DTrue)
>> Nitpicking, we might be using cross-compiled `nm`, so maybe not
>> hardcode
>> the binary name.
>>=20
>>> +    except subprocess.CalledProcessError as e:
>>> +        print(e.output)
>>> +        raise
>>> +    out =3D out.strip().split('\n')
>>> +    for line in out:
>>> +        info =3D line.split(' ')
>>> +        if len(info) =3D=3D 3:
>>> +            # missing size information
>>> +            continue
>>> +        addr, size, type, name =3D info
>>> +        # add only symbols from .text section
>>> +        if type.lower() !=3D 't':
>>> +            continue
>>> +        addr =3D int(addr, 16)
>>> +        size =3D int(size, 16)
>>> +        symbols.append(Symbol(name, addr, size))
>>> +    symbols.sort(key =3D lambda x: x.addr)
>>>        return symbols
>>>    -def symbol_size(symbol):
>>> -    return symbol['st_size']
>>> -
>>> -def symbol_addr(symbol):
>>> -    addr =3D symbol['st_value']
>>> -    # clamp addr to 48 bits, like uftrace entries
>>> -    return addr & 0xffffffffffff
>>> -
>>> -def symbol_name(symbol):
>>> -    return symbol.name
>>> +def find_symbols_locations(elf_file, symbols):
>>> +    addresses =3D '\n'.join([hex(x.full_addr) for x in symbols])
>>> +    try:
>>> +        out =3D subprocess.check_output(['addr2line', '--exe', elf_fil=
e],
>> Ditto (cross compiled)?
>>=20
>>> +                                      stderr=3Dsubprocess.STDOUT,
>>> +                                      input=3Daddresses, text=3DTrue)
>>> +    except subprocess.CalledProcessError as e:
>>> +        print(e.output)
>>> +        raise
>>> +    out =3D out.strip().split('\n')
>>> +    assert len(out) =3D=3D len(symbols)
>>> +    for i in range(len(symbols)):
>>> +        s =3D symbols[i]
>>> +        file, line =3D out[i].split(':')
>>> +        # addr2line may return 'line (discriminator [0-9]+)' sometimes,
>>> +        # remove this to keep only line number.
>>> +        line =3D line.split(' ')[0]
>>> +        s.set_loc(file, line)
>>>       class BinaryFile:
>>>        def __init__(self, path, map_offset):
>>>            self.fullpath =3D os.path.realpath(path)
>>>            self.map_offset =3D map_offset
>>> -        with open(path, 'rb') as f:
>>> -            self.elf =3D ELFFile(f)
>>> -            self.symbols =3D elf_func_symbols(self.elf)
>>> +        self.symbols =3D get_symbols(self.fullpath)
>>> +        find_symbols_locations(self.fullpath, self.symbols)
>>>           def path(self):
>>>            return self.fullpath
>>> @@ -56,7 +83,7 @@ def addr_start(self):
>>>           def addr_end(self):
>>>            last_sym =3D self.symbols[-1]
>>> -        return symbol_addr(last_sym) + symbol_size(last_sym) + self.ma=
p_offset
>>> +        return last_sym.addr + last_sym.size + self.map_offset
>>>           def generate_symbol_file(self, prefix_symbols):
>>>            binary_name =3D os.path.basename(self.fullpath)
>>> @@ -66,14 +93,21 @@ def generate_symbol_file(self, prefix_symbols):
>>>                # print hexadecimal addresses on 48 bits
>>>                addrx =3D "0>12x"
>>>                for s in self.symbols:
>>> -                addr =3D symbol_addr(s)
>>> +                addr =3D s.addr
>>>                    addr =3D f'{addr:{addrx}}'
>>> -                size =3D f'{symbol_size(s):{addrx}}'
>>> -                name =3D symbol_name(s)
>>> +                size =3D f'{s.size:{addrx}}'
>>>                    if prefix_symbols:
>>> -                    name =3D f'{binary_name}:{name}'
>>> +                    name =3D f'{binary_name}:{s.name}'
>>>                    print(addr, size, 'T', name, file=3Dsym_file)
>>>    +    def generate_debug_file(self):
>>> +        binary_name =3D os.path.basename(self.fullpath)
>>> +        dbg_file_path =3D f'./uftrace.data/{binary_name}.dbg'
>> Prefer os.path.join().
>>=20
>>> +        with open(dbg_file_path, 'w') as dbg_file:
>>> +            for s in self.symbols:
>>> +                print(f'F: {hex(s.addr)} {s.name}', file=3Ddbg_file)
>>> +                print(f'L: {s.line} {s.file}', file=3Ddbg_file)
>>> +
>>>    def parse_parameter(p):
>>>        s =3D p.split(":")
>>>        path =3D s[0]
>>> @@ -84,7 +118,7 @@ def parse_parameter(p):
>>>        offset =3D s[1]
>>>        if not offset.startswith('0x'):
>>>            err =3D f'offset "{offset}" is not an hexadecimal constant. '
>>> -        err +=3D 'It should starts with "0x".'
>>> +        err +=3D 'It should start with "0x".'
>>>            raise ValueError(err)
>>>        offset =3D int(offset, 16)
>>>        return path, offset
>>> @@ -124,7 +158,8 @@ def generate_map(binaries):
>>>       def main():
>>>        parser =3D argparse.ArgumentParser(description=3D
>>> -                                     'generate symbol files for uftrac=
e')
>>> +                                     'generate symbol files for uftrac=
e. '
>>> +                                     'Require binutils (nm and addr2li=
ne).')
>>>        parser.add_argument('elf_file', nargs=3D'+',
>>>                            help=3D'path to an ELF file. '
>>>                            'Use /path/to/file:0xdeadbeef to add a mappi=
ng offset.')
>>> @@ -145,6 +180,7 @@ def main():
>>>           for b in binaries:
>>>            b.generate_symbol_file(args.prefix_symbols)
>>> +        b.generate_debug_file()
>>>           generate_map(binaries)
>>>=20=20=20=20
>> No blocking comments:
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>=20
>
> Thanks Philippe.
>
> For the cross compiled tools, I'm not really sure it's worth making
> this more complex. Having tooling for a cross architecture is an
> advanced setup, and I think it's fair to expect someone to have
> binutils installed if they have any cross compiler and cross binutils.
> Plus, they can always create a symlink if needed.
>
> Alex, can you eventually integrate the (other) cosmetic changes?
> If not, I can send a new patch if you prefer.

If you could send a v2 that would be great.

>
> Thanks,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

