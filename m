Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0DFCCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98nE-0002QK-4u; Wed, 15 Oct 2025 17:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v98nC-0002Pn-0U
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:12:18 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v98n6-0000IG-9Q
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:12:16 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-78af743c232so74774b3a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760562730; x=1761167530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sNJm6o6FFSvcQSLG6tZabe9mGGA/gzmKg/2gVRQWFng=;
 b=Z0k7ITn3SFoxnQp9qI2Lnhw5+4R9ltKvNQoM1Uz+LL8Uj64tVEB9puLj5Vdx1bbKx8
 erOiTOFzoS7ZWf2cqmoQCyZ/coQ7Bl1P8Sg2nOxYKLvBFsIVtdNazGXrcbU5RvLqYIR4
 7bLnZ9IHegW7PV56+DgREnK9ynHIMohY7uxulrRlUPVZjizT5sr82PwHsKpNn1hvDM3v
 qSA/QOmAZsRCxcy+0ncKH4N7/tDWM/vHJKXqiSVlXm4JIBqB4z1ieOGFTMdvFl8XVp1I
 cR7UbZaRiuyYJijv/DuCgma8Kq5yjSeO0TuUAY13NPMmlVbY9wvWASyNSJtyHeHVLom1
 gv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760562730; x=1761167530;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sNJm6o6FFSvcQSLG6tZabe9mGGA/gzmKg/2gVRQWFng=;
 b=HaPRAD6gOqUHNkBkNd2R2Q7+3Y+YM2+oQfnO+XNjQhpg6kQHm6fiLAMdmIDojztkTV
 jxCa5cs4qggb6Q0nGiMA2O9Kjh6IlwY7HvU02z7wOlPwHS7bFGCvq16DM4jlUqB+Dv/T
 u+vcYb34us7fpyja38cGgDfCescKPZKbmrtZ9ToK1aI8SG4Vw6MsPswLHky+CI/UoW5w
 tU6x/sS+MM589l686dNkB1epj5mQ1F9RZx2SBOSR50LEf1ppIcrrdYUh2OTESvE1VpnD
 ujlLH2BQKr3XASpQ5JJuMRp37UTqHIuW3WSSsVtu7UDeCGCOYQIRnK2zTUaSj1vt+b78
 45Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3vcaGDObWp+XciE/ojhzG78cjlGNVXDJRlfNH9d4GVzGII/OR4KN7g5NlPnYAJdMH5OqhNAqBq9M8@nongnu.org
X-Gm-Message-State: AOJu0YyEJzXHaN8r/aoHLt62ERcZ2WIoO3X7pIr6OCsGInaNFSi01eHg
 ZWvbYGXJ1UZMaaIUJHHDFPbHMS56NPkx+NnrVEvgDFcn5NdR3i5nA5ac8Q/gOzzKls8=
X-Gm-Gg: ASbGnctAqbV/J7eAYhnvpNX1i+R72mCL0gSdr9x2HUwgOI3vnXZRliq5F3foBTFf1h7
 PDicfTNBXoLAWJ2Rtlyzeg0ty253PGJHMtYX0mK6DH6ol3hGnd4HBq0cfaTofCKqJToYgAT1x/b
 oa36QpsjPdl4MhnXlPSIEjOx3EaCG0Uxyi29yyLOkmsARtx36uDA0f34Vm3KbGyl6CLnLP/9j1f
 Q1sviBCIhp5XiVcslW0VkVcBzhKsCOOkvHcyT7xpIRgZ65xjXEXo28QlbJzlpItm3lUO85i56Ja
 Elqre0jQT2stLsvdPQEEkApYoKMJx5Cbo2/PvCiEaJ2jtByU1V7FMuN2XquXRiMmTFKQ8TvdQTq
 PB99iHCtub/9tTL20wEiPMrGeLNixQwtO+DQROZHX+N/olKBkRci7ep7GtA==
X-Google-Smtp-Source: AGHT+IGN35HnVBpdWRau46JtcXF3QN2swfHW2i7780oUnQu7vVJgjse1ZfIFWjhYUejPUVIckXmgmw==
X-Received: by 2002:a05:6a21:328c:b0:334:9c41:bdd3 with SMTP id
 adf61e73a8af0-3349c41bfd5mr439465637.2.1760562730135; 
 Wed, 15 Oct 2025 14:12:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d0e2d51sm19723658b3a.65.2025.10.15.14.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 14:12:09 -0700 (PDT)
Message-ID: <a9c491b9-e1f4-4ed5-8355-75db54239130@linaro.org>
Date: Wed, 15 Oct 2025 14:12:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: generate debug files
 to map symbols to source
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20251013213912.413386-1-pierrick.bouvier@linaro.org>
 <b7256e10-d5b1-4978-90e1-99d9e76318df@linaro.org>
 <b4a0756b-3781-433a-aa4c-338d9348da5d@linaro.org>
In-Reply-To: <b4a0756b-3781-433a-aa4c-338d9348da5d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 10/15/25 2:02 PM, Pierrick Bouvier wrote:
> On 10/15/25 1:40 PM, Philippe Mathieu-Daudé wrote:
>> On 13/10/25 23:39, Pierrick Bouvier wrote:
>>> Enhance uftrace_symbols.py to generate .dbg files, containing
>>> source location for every symbol present in .sym file.
>>> It allows to use uftrace {replay,dump} --srcline and show origin of
>>
>> `uftrace {replay,dump} --srcline`
>>
>>> functions, connecting trace to original source code.
>>>
>>> It was first implemented with pyelftools DWARF parser, which was way
>>> to slow (~minutes) to get locations for every symbol in the linux
>>
>> s/to/too/
>>
>>> kernel. Thus, we use addr2line instead, which runs in seconds.
>>>
>>> As well, there were some bugs with latest pyelftools release,
>>> requiring to run master version, which is not installable with pip.
>>> Thus, since we now require binutils (addr2line), we can ditch pyelftools
>>> based implementation and simply rely on nm to get symbols information,
>>
>> `nm`
>>
>>> which is faster and better.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>     contrib/plugins/uftrace_symbols.py | 108 +++++++++++++++++++----------
>>>     1 file changed, 72 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
>>> index b49e03203c8..728bf04ce54 100755
>>> --- a/contrib/plugins/uftrace_symbols.py
>>> +++ b/contrib/plugins/uftrace_symbols.py
>>> @@ -1,7 +1,7 @@
>>>     #!/usr/bin/env python3
>>>     # -*- coding: utf-8 -*-
>>>     #
>>> -# Create symbols and mapping files for uftrace.
>>> +# Create symbols, debug and mapping files for uftrace.
>>>     #
>>>     # Copyright 2025 Linaro Ltd
>>>     # Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> @@ -9,44 +9,71 @@
>>>     # SPDX-License-Identifier: GPL-2.0-or-later
>>>     
>>>     import argparse
>>> -import elftools # pip install pyelftools
>>>     import os
>>> +import subprocess
>>>     
>>> -from elftools.elf.elffile import ELFFile
>>> -from elftools.elf.sections import SymbolTableSection
>>> +class Symbol:
>>> +    def __init__(self, name, addr, size):
>>> +        self.name = name
>>> +        # clamp addr to 48 bits, like uftrace entries
>>> +        self.addr = addr & 0xffffffffffff
>>> +        self.full_addr = addr
>>> +        self.size = size
>>>     
>>> -def elf_func_symbols(elf):
>>> -    symbol_tables = [(idx, s) for idx, s in enumerate(elf.iter_sections())
>>> -                  if isinstance(s, SymbolTableSection)]
>>> -    symbols = []
>>> -    for _, section in symbol_tables:
>>> -        for _, symbol in enumerate(section.iter_symbols()):
>>> -            if symbol_size(symbol) == 0:
>>> -                continue
>>> -            type = symbol['st_info']['type']
>>> -            if type == 'STT_FUNC' or type == 'STT_NOTYPE':
>>> -                symbols.append(symbol)
>>> -    symbols.sort(key = lambda x: symbol_addr(x))
>>> +    def set_loc(self, file, line):
>>> +        self.file = file
>>> +        self.line = line
>>> +
>>> +def get_symbols(elf_file):
>>> +    symbols=[]
>>> +    try:
>>> +        out = subprocess.check_output(['nm', '--print-size', elf_file],
>>> +                                      stderr=subprocess.STDOUT,
>>> +                                      text=True)
>>
>> Nitpicking, we might be using cross-compiled `nm`, so maybe not hardcode
>> the binary name.
>>
>>> +    except subprocess.CalledProcessError as e:
>>> +        print(e.output)
>>> +        raise
>>> +    out = out.strip().split('\n')
>>> +    for line in out:
>>> +        info = line.split(' ')
>>> +        if len(info) == 3:
>>> +            # missing size information
>>> +            continue
>>> +        addr, size, type, name = info
>>> +        # add only symbols from .text section
>>> +        if type.lower() != 't':
>>> +            continue
>>> +        addr = int(addr, 16)
>>> +        size = int(size, 16)
>>> +        symbols.append(Symbol(name, addr, size))
>>> +    symbols.sort(key = lambda x: x.addr)
>>>         return symbols
>>>     
>>> -def symbol_size(symbol):
>>> -    return symbol['st_size']
>>> -
>>> -def symbol_addr(symbol):
>>> -    addr = symbol['st_value']
>>> -    # clamp addr to 48 bits, like uftrace entries
>>> -    return addr & 0xffffffffffff
>>> -
>>> -def symbol_name(symbol):
>>> -    return symbol.name
>>> +def find_symbols_locations(elf_file, symbols):
>>> +    addresses = '\n'.join([hex(x.full_addr) for x in symbols])
>>> +    try:
>>> +        out = subprocess.check_output(['addr2line', '--exe', elf_file],
>>
>> Ditto (cross compiled)?
>>
>>> +                                      stderr=subprocess.STDOUT,
>>> +                                      input=addresses, text=True)
>>> +    except subprocess.CalledProcessError as e:
>>> +        print(e.output)
>>> +        raise
>>> +    out = out.strip().split('\n')
>>> +    assert len(out) == len(symbols)
>>> +    for i in range(len(symbols)):
>>> +        s = symbols[i]
>>> +        file, line = out[i].split(':')
>>> +        # addr2line may return 'line (discriminator [0-9]+)' sometimes,
>>> +        # remove this to keep only line number.
>>> +        line = line.split(' ')[0]
>>> +        s.set_loc(file, line)
>>>     
>>>     class BinaryFile:
>>>         def __init__(self, path, map_offset):
>>>             self.fullpath = os.path.realpath(path)
>>>             self.map_offset = map_offset
>>> -        with open(path, 'rb') as f:
>>> -            self.elf = ELFFile(f)
>>> -            self.symbols = elf_func_symbols(self.elf)
>>> +        self.symbols = get_symbols(self.fullpath)
>>> +        find_symbols_locations(self.fullpath, self.symbols)
>>>     
>>>         def path(self):
>>>             return self.fullpath
>>> @@ -56,7 +83,7 @@ def addr_start(self):
>>>     
>>>         def addr_end(self):
>>>             last_sym = self.symbols[-1]
>>> -        return symbol_addr(last_sym) + symbol_size(last_sym) + self.map_offset
>>> +        return last_sym.addr + last_sym.size + self.map_offset
>>>     
>>>         def generate_symbol_file(self, prefix_symbols):
>>>             binary_name = os.path.basename(self.fullpath)
>>> @@ -66,14 +93,21 @@ def generate_symbol_file(self, prefix_symbols):
>>>                 # print hexadecimal addresses on 48 bits
>>>                 addrx = "0>12x"
>>>                 for s in self.symbols:
>>> -                addr = symbol_addr(s)
>>> +                addr = s.addr
>>>                     addr = f'{addr:{addrx}}'
>>> -                size = f'{symbol_size(s):{addrx}}'
>>> -                name = symbol_name(s)
>>> +                size = f'{s.size:{addrx}}'
>>>                     if prefix_symbols:
>>> -                    name = f'{binary_name}:{name}'
>>> +                    name = f'{binary_name}:{s.name}'
>>>                     print(addr, size, 'T', name, file=sym_file)
>>>     
>>> +    def generate_debug_file(self):
>>> +        binary_name = os.path.basename(self.fullpath)
>>> +        dbg_file_path = f'./uftrace.data/{binary_name}.dbg'
>>
>> Prefer os.path.join().
>>
>>> +        with open(dbg_file_path, 'w') as dbg_file:
>>> +            for s in self.symbols:
>>> +                print(f'F: {hex(s.addr)} {s.name}', file=dbg_file)
>>> +                print(f'L: {s.line} {s.file}', file=dbg_file)
>>> +
>>>     def parse_parameter(p):
>>>         s = p.split(":")
>>>         path = s[0]
>>> @@ -84,7 +118,7 @@ def parse_parameter(p):
>>>         offset = s[1]
>>>         if not offset.startswith('0x'):
>>>             err = f'offset "{offset}" is not an hexadecimal constant. '
>>> -        err += 'It should starts with "0x".'
>>> +        err += 'It should start with "0x".'
>>>             raise ValueError(err)
>>>         offset = int(offset, 16)
>>>         return path, offset
>>> @@ -124,7 +158,8 @@ def generate_map(binaries):
>>>     
>>>     def main():
>>>         parser = argparse.ArgumentParser(description=
>>> -                                     'generate symbol files for uftrace')
>>> +                                     'generate symbol files for uftrace. '
>>> +                                     'Require binutils (nm and addr2line).')
>>>         parser.add_argument('elf_file', nargs='+',
>>>                             help='path to an ELF file. '
>>>                             'Use /path/to/file:0xdeadbeef to add a mapping offset.')
>>> @@ -145,6 +180,7 @@ def main():
>>>     
>>>         for b in binaries:
>>>             b.generate_symbol_file(args.prefix_symbols)
>>> +        b.generate_debug_file()
>>>     
>>>         generate_map(binaries)
>>>     
>> No blocking comments:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 
> Thanks Philippe.
> 
> For the cross compiled tools, I'm not really sure it's worth making this
> more complex. Having tooling for a cross architecture is an advanced
> setup, and I think it's fair to expect someone to have binutils
> installed if they have any cross compiler and cross binutils.
> Plus, they can always create a symlink if needed.
>

As well, nm and addr2line are architecture agnostic, as they just access 
ELF symtab and DWARF information, so you don't need an aarch64-*-{nm, 
addr2line} to extract information from an aarch64 binary.

> Alex, can you eventually integrate the (other) cosmetic changes?
> If not, I can send a new patch if you prefer.
> 
> Thanks,
> Pierrick


