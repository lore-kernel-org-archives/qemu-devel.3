Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F502CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98J1-00017f-10; Wed, 15 Oct 2025 16:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98Ix-00017R-TT
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:41:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98In-0004zK-53
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:41:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so24242f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760560848; x=1761165648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T0b/1wGVGVJtHzFTMl85FN7SfQ+UM6msS30Eib6gmpw=;
 b=QgRKo0pRe8rnkv2cze8LtFV2F6kg9ib1Lz2CymK7P1pPy2++mHmIyPW9odId/j8Cf+
 kHS2xCKtOjWwkxhdTPcOEr6TcLwq0ZDmfeWEzKBCzgsV+pbY23nIHL8eCYdP30N5nLBu
 3en1oLnT1pPMLNYPmLdFrphjxgmpoToXmhu6d4LMT2eXr0xxPKlVL12IUtgsQs4+GIuL
 mxPvfl/I+un3V7NbcmhNTYECOVPc1E/PjbDcql/QFhGKtE40G8DPPs2BWVmzZ87idofG
 D5y1GOlQkQr5evXA4QdyUiLQ1peBAvaIsdSnRVmXWZMoFlBpFHVA0PVDHRS6BsklPhz6
 dFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760560848; x=1761165648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0b/1wGVGVJtHzFTMl85FN7SfQ+UM6msS30Eib6gmpw=;
 b=B7G7tfzvYwrnpS6dEywYiHSQFHc0nJbnMRJkDpSMkIKih2K3e9L/A+CjRjWTZwz1Lp
 84DEtu7WBLW89PHt2xeCnXQgYHvUuOBTH7BYSPzsZ15RmHALtMee5t7LrClFyrIkWfkJ
 MuWt/fWnEB6oebJcon1KEAYUZ5vb0mntCCAn5ADSKCHbD4OjUR3UgqEglAVxdHRCM3Wk
 u32lccxFtBho2EVPoKGbpTqRM2YNilULLS50DYkv8yMjI/wctcT6595Aq1GQs+lqBLac
 BrWWLt4Hf+6pYoBLWY0O4Iy4chuGt2VySK6zzFmP1tZjkUp79OwfNbd9ULlbJHFnAlaB
 iuvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpXvJwzZH77MScGv7UDoHl3rEPk0wXZLG/URPacrgXaVJGRzMQSAwwKy2Q5QsZKKyG6nYWVvQ79MGn@nongnu.org
X-Gm-Message-State: AOJu0YzuhfoBTEUsnYjW5EYA2SuOZzTT+Ad+XwfQ/AvlE3zCErGfN6Aw
 +hYQQZ7CU+zkZGh7tG0eD0AZQ7ZgqwLK5B7HDbxpZn6r1qwZVHWAn5zjzznBOfxFe0I=
X-Gm-Gg: ASbGncv8vCXnGHZaQSFzOpbRzPxOG9NIII2UhgnTyjSZV0R0SfmrQUy0nxrkZYbuM9G
 Wgm44QZLMifNdNj8qSaYZJTi9kGfv7fhd70RQoSGFWqD609gvR96+IHSdD+hPBUjGkuhBbt1lQS
 r81GJ4woUIkEpC5cQmbTdyxZ1rdHzc+SUEz/zC4tm+aU4B+kBFrDAzq5+oYxqzqW2ch028EG2Hi
 Ia2+vpBu42N9YhvwZ7zBXHIKlmDMd5W9CR/Icd74TIE10tPPrpXpDiVFDtDdH0cwNGneSjBhjg0
 CQ/8S1mVoUA8CGNCAMG9WIUYvZoU7CupxZ8jtoElfuxiFxGBsDnBRrv2aYuDprSTX5jJvDoWNwa
 dyPAQNf7exlZhJEHg6h181kM+wVSypkuFyNBjvC5oyWl2X+6b2PWHqbAsgcEfnHLnvkpvbEo47q
 Bdc3VByoZJWz1d
X-Google-Smtp-Source: AGHT+IFS06udDAsYIpwdtbZvMvwOc1TpdcokVus47oAl6Ms6b3enAp8wFAwr5piwrqFlNn705pPScA==
X-Received: by 2002:a05:6000:248a:b0:3f2:dc6e:6a89 with SMTP id
 ffacd0b85a97d-4266e8e4c29mr19355520f8f.57.1760560847702; 
 Wed, 15 Oct 2025 13:40:47 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582b44sm30956408f8f.16.2025.10.15.13.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 13:40:47 -0700 (PDT)
Message-ID: <b7256e10-d5b1-4978-90e1-99d9e76318df@linaro.org>
Date: Wed, 15 Oct 2025 22:40:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: generate debug files
 to map symbols to source
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20251013213912.413386-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251013213912.413386-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 13/10/25 23:39, Pierrick Bouvier wrote:
> Enhance uftrace_symbols.py to generate .dbg files, containing
> source location for every symbol present in .sym file.
> It allows to use uftrace {replay,dump} --srcline and show origin of

`uftrace {replay,dump} --srcline`

> functions, connecting trace to original source code.
> 
> It was first implemented with pyelftools DWARF parser, which was way
> to slow (~minutes) to get locations for every symbol in the linux

s/to/too/

> kernel. Thus, we use addr2line instead, which runs in seconds.
> 
> As well, there were some bugs with latest pyelftools release,
> requiring to run master version, which is not installable with pip.
> Thus, since we now require binutils (addr2line), we can ditch pyelftools
> based implementation and simply rely on nm to get symbols information,

`nm`

> which is faster and better.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace_symbols.py | 108 +++++++++++++++++++----------
>   1 file changed, 72 insertions(+), 36 deletions(-)
> 
> diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
> index b49e03203c8..728bf04ce54 100755
> --- a/contrib/plugins/uftrace_symbols.py
> +++ b/contrib/plugins/uftrace_symbols.py
> @@ -1,7 +1,7 @@
>   #!/usr/bin/env python3
>   # -*- coding: utf-8 -*-
>   #
> -# Create symbols and mapping files for uftrace.
> +# Create symbols, debug and mapping files for uftrace.
>   #
>   # Copyright 2025 Linaro Ltd
>   # Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> @@ -9,44 +9,71 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   import argparse
> -import elftools # pip install pyelftools
>   import os
> +import subprocess
>   
> -from elftools.elf.elffile import ELFFile
> -from elftools.elf.sections import SymbolTableSection
> +class Symbol:
> +    def __init__(self, name, addr, size):
> +        self.name = name
> +        # clamp addr to 48 bits, like uftrace entries
> +        self.addr = addr & 0xffffffffffff
> +        self.full_addr = addr
> +        self.size = size
>   
> -def elf_func_symbols(elf):
> -    symbol_tables = [(idx, s) for idx, s in enumerate(elf.iter_sections())
> -                  if isinstance(s, SymbolTableSection)]
> -    symbols = []
> -    for _, section in symbol_tables:
> -        for _, symbol in enumerate(section.iter_symbols()):
> -            if symbol_size(symbol) == 0:
> -                continue
> -            type = symbol['st_info']['type']
> -            if type == 'STT_FUNC' or type == 'STT_NOTYPE':
> -                symbols.append(symbol)
> -    symbols.sort(key = lambda x: symbol_addr(x))
> +    def set_loc(self, file, line):
> +        self.file = file
> +        self.line = line
> +
> +def get_symbols(elf_file):
> +    symbols=[]
> +    try:
> +        out = subprocess.check_output(['nm', '--print-size', elf_file],
> +                                      stderr=subprocess.STDOUT,
> +                                      text=True)

Nitpicking, we might be using cross-compiled `nm`, so maybe not hardcode
the binary name.

> +    except subprocess.CalledProcessError as e:
> +        print(e.output)
> +        raise
> +    out = out.strip().split('\n')
> +    for line in out:
> +        info = line.split(' ')
> +        if len(info) == 3:
> +            # missing size information
> +            continue
> +        addr, size, type, name = info
> +        # add only symbols from .text section
> +        if type.lower() != 't':
> +            continue
> +        addr = int(addr, 16)
> +        size = int(size, 16)
> +        symbols.append(Symbol(name, addr, size))
> +    symbols.sort(key = lambda x: x.addr)
>       return symbols
>   
> -def symbol_size(symbol):
> -    return symbol['st_size']
> -
> -def symbol_addr(symbol):
> -    addr = symbol['st_value']
> -    # clamp addr to 48 bits, like uftrace entries
> -    return addr & 0xffffffffffff
> -
> -def symbol_name(symbol):
> -    return symbol.name
> +def find_symbols_locations(elf_file, symbols):
> +    addresses = '\n'.join([hex(x.full_addr) for x in symbols])
> +    try:
> +        out = subprocess.check_output(['addr2line', '--exe', elf_file],

Ditto (cross compiled)?

> +                                      stderr=subprocess.STDOUT,
> +                                      input=addresses, text=True)
> +    except subprocess.CalledProcessError as e:
> +        print(e.output)
> +        raise
> +    out = out.strip().split('\n')
> +    assert len(out) == len(symbols)
> +    for i in range(len(symbols)):
> +        s = symbols[i]
> +        file, line = out[i].split(':')
> +        # addr2line may return 'line (discriminator [0-9]+)' sometimes,
> +        # remove this to keep only line number.
> +        line = line.split(' ')[0]
> +        s.set_loc(file, line)
>   
>   class BinaryFile:
>       def __init__(self, path, map_offset):
>           self.fullpath = os.path.realpath(path)
>           self.map_offset = map_offset
> -        with open(path, 'rb') as f:
> -            self.elf = ELFFile(f)
> -            self.symbols = elf_func_symbols(self.elf)
> +        self.symbols = get_symbols(self.fullpath)
> +        find_symbols_locations(self.fullpath, self.symbols)
>   
>       def path(self):
>           return self.fullpath
> @@ -56,7 +83,7 @@ def addr_start(self):
>   
>       def addr_end(self):
>           last_sym = self.symbols[-1]
> -        return symbol_addr(last_sym) + symbol_size(last_sym) + self.map_offset
> +        return last_sym.addr + last_sym.size + self.map_offset
>   
>       def generate_symbol_file(self, prefix_symbols):
>           binary_name = os.path.basename(self.fullpath)
> @@ -66,14 +93,21 @@ def generate_symbol_file(self, prefix_symbols):
>               # print hexadecimal addresses on 48 bits
>               addrx = "0>12x"
>               for s in self.symbols:
> -                addr = symbol_addr(s)
> +                addr = s.addr
>                   addr = f'{addr:{addrx}}'
> -                size = f'{symbol_size(s):{addrx}}'
> -                name = symbol_name(s)
> +                size = f'{s.size:{addrx}}'
>                   if prefix_symbols:
> -                    name = f'{binary_name}:{name}'
> +                    name = f'{binary_name}:{s.name}'
>                   print(addr, size, 'T', name, file=sym_file)
>   
> +    def generate_debug_file(self):
> +        binary_name = os.path.basename(self.fullpath)
> +        dbg_file_path = f'./uftrace.data/{binary_name}.dbg'

Prefer os.path.join().

> +        with open(dbg_file_path, 'w') as dbg_file:
> +            for s in self.symbols:
> +                print(f'F: {hex(s.addr)} {s.name}', file=dbg_file)
> +                print(f'L: {s.line} {s.file}', file=dbg_file)
> +
>   def parse_parameter(p):
>       s = p.split(":")
>       path = s[0]
> @@ -84,7 +118,7 @@ def parse_parameter(p):
>       offset = s[1]
>       if not offset.startswith('0x'):
>           err = f'offset "{offset}" is not an hexadecimal constant. '
> -        err += 'It should starts with "0x".'
> +        err += 'It should start with "0x".'
>           raise ValueError(err)
>       offset = int(offset, 16)
>       return path, offset
> @@ -124,7 +158,8 @@ def generate_map(binaries):
>   
>   def main():
>       parser = argparse.ArgumentParser(description=
> -                                     'generate symbol files for uftrace')
> +                                     'generate symbol files for uftrace. '
> +                                     'Require binutils (nm and addr2line).')
>       parser.add_argument('elf_file', nargs='+',
>                           help='path to an ELF file. '
>                           'Use /path/to/file:0xdeadbeef to add a mapping offset.')
> @@ -145,6 +180,7 @@ def main():
>   
>       for b in binaries:
>           b.generate_symbol_file(args.prefix_symbols)
> +        b.generate_debug_file()
>   
>       generate_map(binaries)
>   
No blocking comments:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


