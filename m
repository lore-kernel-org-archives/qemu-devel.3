Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B6FCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 17:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAX8s-0007ig-Pp; Sun, 19 Oct 2025 13:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAX8q-0007iR-Ct
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 13:24:25 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAX8l-0008Tl-6k
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 13:24:23 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3304dd2f119so2891845a91.2
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760894655; x=1761499455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gFy1VWbSt4GFUUXlt/CJuVwSQ+pwpzmdCqsoVbLhk28=;
 b=cZZuUxbx1C+L96YhauAkb1+f/bgUwcM9v1Ouucb1LdivxUNNRL6pXsIs91te4WijPD
 vblI5zyTautiDoa8X2oczMqMNzDIYL/BltfU3RtohTRxqClO7OYlUZM14vMHICIMkHI9
 imRJEGT7Piv11TMIdAhZc71dry1gCWq6jMPcBjhurX3qaSRkaF7YKNSh2/UrKPSK2hVQ
 JDgHlaPXyiGXF7qLdshKcoCKU++821RvFhyfEL4mJiG6HOpeerUpqlYzZTez6rOjXyxx
 ffKDjkowJycDl0lH/UPEiZ3OkiAmmuYAZcPjZmcmk2TG7Z91qdoNWpEQytQHwTtnzCsO
 IStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760894655; x=1761499455;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFy1VWbSt4GFUUXlt/CJuVwSQ+pwpzmdCqsoVbLhk28=;
 b=GYf38ZLZPHdlJ89QvimDVMvQtHIEqWEnQXcxepSoj9r2P4bXt4/Ie25rKNtXa65B7g
 DjMUqTUQUwpH/UC/7fJe+zpPrFzHGbbfxTM+a3Mp2dwkRrTbFwIP5+P0Ka+c4BiNVz4g
 1N/mJ94YI87E08JnzvA3y+J0ylCiZh727CxB0x3dVJj4T5lGgSMpyCn8WkI4HWo2+Yqi
 K2X02CO/bScHpqS4zVy/OgfFMf1LO5ALbsWLzOgzWa131S3RqEiBOj4L9Ys3s00aTjlc
 ceL287JN17OOlLbfsrKx/RShNzREsdBKKiMiH8ieFqdtYLxEXvmKb/+I3tWT05GRRDZ1
 wtFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSr+0xTZBGjmpUqPf2B6Njd2aUJa2CsY43bqyP/McUJDNdiJGG7R8mdnjLuUhi9YJdNS3v0aTjubcL@nongnu.org
X-Gm-Message-State: AOJu0Yxsy4/DQ+uHNCab2aj3DCTXHi8n8htKa45w0lqS7MlGCZLy+ntE
 eNKP8FFU5sKTsw7Dv6GKV7N81Wc0pFtwqeoBG4qQpLH72ZUuvHoOf2MyyPMp4tm8dv0=
X-Gm-Gg: ASbGncuw9XuxE0Yk0whnb46B26D+eVJJ6FWh1Q9pIpND2S0hznsxVzD1u62s4z4ylhJ
 N5tRk/2iPNjgNLQype04eXC/i9bZ21StMUNlNjI27w2vNX799WmmrcdP6AwX1MjKKBRqeIQsE7u
 fr/Fkq6WP0j0kGErG54jkqNOIS38zZ2xfE5aTFlES3ajnCEjWrxeIFnvHueaJXaE8ZTiK5rwOHy
 K1uF4ij2ZvvrHdcUBufPgtqOzHaskBAECDx8BfXn2AVphcI1t9X9evi2oQBQ6NHiFiH1VTDOdEX
 rQJiGdGEBUYkj2f5J/misJFQ71b6hGoTfejQERDRmgiPx9FaYVqL74B34wqhrEbDE1yic8iKXon
 UQOIFgsufGyDvxTGYyVqeIqbqcmMsRbvUvsR44MVjz9JvwmtFvxl1cypH/4m6reGDD/3U6wS5Lk
 uBCnM3S5CCmEOnatiPvsIYFHI=
X-Google-Smtp-Source: AGHT+IFpbTyzYTCLmdjdT9q4sU9pB4E/+erUoi5WfjeUwusiPm6yZsrOHYuCbn6li33/VPXq39R55Q==
X-Received: by 2002:a17:90b:5343:b0:32e:52aa:3973 with SMTP id
 98e67ed59e1d1-33bcf85a81emr14189620a91.8.1760894655507; 
 Sun, 19 Oct 2025 10:24:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de11392sm5841568a91.7.2025.10.19.10.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 10:24:15 -0700 (PDT)
Message-ID: <448ccc16-0781-4eec-858e-f606240a5c6f@linaro.org>
Date: Sun, 19 Oct 2025 10:24:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] contrib/plugins/uftrace_symbols.py: generate debug
 files to map symbols to source
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
 <20251016150357.876415-8-alex.bennee@linaro.org>
 <d2fbae24-18a4-4a98-aad8-f6b2c9c60c4d@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <d2fbae24-18a4-4a98-aad8-f6b2c9c60c4d@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 10/19/25 12:56 AM, Akihiko Odaki wrote:
> On 2025/10/17 0:03, Alex Bennée wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Enhance uftrace_symbols.py to generate .dbg files, containing
>> source location for every symbol present in .sym file.
>> It allows to use `uftrace {replay,dump} --srcline` and show origin of
>> functions, connecting trace to original source code.
>>
>> It was first implemented with pyelftools DWARF parser, which was way
>> too slow (~minutes) to get locations for every symbol in the linux
>> kernel. Thus, we use `addr2line` instead, which runs in seconds.
> 
> nm have option -l, which shows filenames and line numbers. With the
> option you can avoid executing addr2line and omit the associated logic.
>

I saw it. Unfortunately it's really slow (> 1 min) with big binaries. 
Try it on a linux kernel, you'll see.

>>
>> As well, there were some bugs with latest pyelftools release,
>> requiring to run master version, which is not installable with pip.
>> Thus, since we now require binutils (addr2line), we can ditch pyelftools
>> based implementation and simply rely on `nm` to get symbols information,
>> which is faster and better.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>    contrib/plugins/uftrace_symbols.py | 120 +++++++++++++++++++----------
>>    1 file changed, 78 insertions(+), 42 deletions(-)
>>
>> diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
>> index b49e03203c8..45fb79c7a58 100755
>> --- a/contrib/plugins/uftrace_symbols.py
>> +++ b/contrib/plugins/uftrace_symbols.py
>> @@ -1,7 +1,7 @@
>>    #!/usr/bin/env python3
>>    # -*- coding: utf-8 -*-
>>    #
>> -# Create symbols and mapping files for uftrace.
>> +# Create symbols, debug and mapping files for uftrace.
>>    #
>>    # Copyright 2025 Linaro Ltd
>>    # Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> @@ -9,44 +9,71 @@
>>    # SPDX-License-Identifier: GPL-2.0-or-later
>>    
>>    import argparse
>> -import elftools # pip install pyelftools
>>    import os
>> -
>> -from elftools.elf.elffile import ELFFile
>> -from elftools.elf.sections import SymbolTableSection
>> -
>> -def elf_func_symbols(elf):
>> -    symbol_tables = [(idx, s) for idx, s in enumerate(elf.iter_sections())
>> -                  if isinstance(s, SymbolTableSection)]
>> -    symbols = []
>> -    for _, section in symbol_tables:
>> -        for _, symbol in enumerate(section.iter_symbols()):
>> -            if symbol_size(symbol) == 0:
>> -                continue
>> -            type = symbol['st_info']['type']
>> -            if type == 'STT_FUNC' or type == 'STT_NOTYPE':
>> -                symbols.append(symbol)
>> -    symbols.sort(key = lambda x: symbol_addr(x))
>> +import subprocess
>> +
>> +class Symbol:
>> +    def __init__(self, name, addr, size):
>> +        self.name = name
>> +        # clamp addr to 48 bits, like uftrace entries
>> +        self.addr = addr & 0xffffffffffff
>> +        self.full_addr = addr
>> +        self.size = size
>> +
>> +    def set_loc(self, file, line):
>> +        self.file = file
>> +        self.line = line
>> +
>> +def get_symbols(elf_file):
>> +    symbols=[]
>> +    try:
>> +        out = subprocess.check_output(['nm', '--print-size', elf_file],
>> +                                      stderr=subprocess.STDOUT,
>> +                                      text=True)
>> +    except subprocess.CalledProcessError as e:
>> +        print(e.output)
>> +        raise
>> +    out = out.strip().split('\n')
>> +    for line in out:
>> +        info = line.split(' ')
>> +        if len(info) == 3:
>> +            # missing size information
>> +            continue
>> +        addr, size, type, name = info
>> +        # add only symbols from .text section
>> +        if type.lower() != 't':
>> +            continue
>> +        addr = int(addr, 16)
>> +        size = int(size, 16)
>> +        symbols.append(Symbol(name, addr, size))
>> +    symbols.sort(key = lambda x: x.addr)
>>        return symbols
>>    
>> -def symbol_size(symbol):
>> -    return symbol['st_size']
>> -
>> -def symbol_addr(symbol):
>> -    addr = symbol['st_value']
>> -    # clamp addr to 48 bits, like uftrace entries
>> -    return addr & 0xffffffffffff
>> -
>> -def symbol_name(symbol):
>> -    return symbol.name
>> +def find_symbols_locations(elf_file, symbols):
>> +    addresses = '\n'.join([hex(x.full_addr) for x in symbols])
>> +    try:
>> +        out = subprocess.check_output(['addr2line', '--exe', elf_file],
>> +                                      stderr=subprocess.STDOUT,
>> +                                      input=addresses, text=True)
>> +    except subprocess.CalledProcessError as e:
>> +        print(e.output)
>> +        raise
>> +    out = out.strip().split('\n')
>> +    assert len(out) == len(symbols)
>> +    for i in range(len(symbols)):
>> +        s = symbols[i]
>> +        file, line = out[i].split(':')
>> +        # addr2line may return 'line (discriminator [0-9]+)' sometimes,
>> +        # remove this to keep only line number.
>> +        line = line.split(' ')[0]
>> +        s.set_loc(file, line)
>>    
>>    class BinaryFile:
>>        def __init__(self, path, map_offset):
>>            self.fullpath = os.path.realpath(path)
>>            self.map_offset = map_offset
>> -        with open(path, 'rb') as f:
>> -            self.elf = ELFFile(f)
>> -            self.symbols = elf_func_symbols(self.elf)
>> +        self.symbols = get_symbols(self.fullpath)
>> +        find_symbols_locations(self.fullpath, self.symbols)
>>    
>>        def path(self):
>>            return self.fullpath
>> @@ -56,24 +83,31 @@ def addr_start(self):
>>    
>>        def addr_end(self):
>>            last_sym = self.symbols[-1]
>> -        return symbol_addr(last_sym) + symbol_size(last_sym) + self.map_offset
>> +        return last_sym.addr + last_sym.size + self.map_offset
>>    
>>        def generate_symbol_file(self, prefix_symbols):
>>            binary_name = os.path.basename(self.fullpath)
>> -        sym_file_path = f'./uftrace.data/{binary_name}.sym'
>> +        sym_file_path = os.path.join('uftrace.data', f'{binary_name}.sym')
>>            print(f'{sym_file_path} ({len(self.symbols)} symbols)')
>>            with open(sym_file_path, 'w') as sym_file:
>>                # print hexadecimal addresses on 48 bits
>>                addrx = "0>12x"
>>                for s in self.symbols:
>> -                addr = symbol_addr(s)
>> +                addr = s.addr
>>                    addr = f'{addr:{addrx}}'
>> -                size = f'{symbol_size(s):{addrx}}'
>> -                name = symbol_name(s)
>> +                size = f'{s.size:{addrx}}'
>>                    if prefix_symbols:
>> -                    name = f'{binary_name}:{name}'
>> +                    name = f'{binary_name}:{s.name}'
>>                    print(addr, size, 'T', name, file=sym_file)
>>    
>> +    def generate_debug_file(self):
>> +        binary_name = os.path.basename(self.fullpath)
>> +        dbg_file_path = os.path.join('uftrace.data', f'{binary_name}.dbg')
>> +        with open(dbg_file_path, 'w') as dbg_file:
>> +            for s in self.symbols:
>> +                print(f'F: {hex(s.addr)} {s.name}', file=dbg_file)
>> +                print(f'L: {s.line} {s.file}', file=dbg_file)
>> +
>>    def parse_parameter(p):
>>        s = p.split(":")
>>        path = s[0]
>> @@ -84,7 +118,7 @@ def parse_parameter(p):
>>        offset = s[1]
>>        if not offset.startswith('0x'):
>>            err = f'offset "{offset}" is not an hexadecimal constant. '
>> -        err += 'It should starts with "0x".'
>> +        err += 'It should start with "0x".'
>>            raise ValueError(err)
>>        offset = int(offset, 16)
>>        return path, offset
>> @@ -97,7 +131,7 @@ def is_from_user_mode(map_file_path):
>>        return False
>>    
>>    def generate_map(binaries):
>> -    map_file_path = './uftrace.data/sid-0.map'
>> +    map_file_path = os.path.join('uftrace.data', 'sid-0.map')
>>    
>>        if is_from_user_mode(map_file_path):
>>            print(f'do not overwrite {map_file_path} generated from qemu-user')
>> @@ -124,7 +158,8 @@ def generate_map(binaries):
>>    
>>    def main():
>>        parser = argparse.ArgumentParser(description=
>> -                                     'generate symbol files for uftrace')
>> +                                     'generate symbol files for uftrace. '
>> +                                     'Require binutils (nm and addr2line).')
>>        parser.add_argument('elf_file', nargs='+',
>>                            help='path to an ELF file. '
>>                            'Use /path/to/file:0xdeadbeef to add a mapping offset.')
>> @@ -133,8 +168,8 @@ def main():
>>                            action=argparse.BooleanOptionalAction)
>>        args = parser.parse_args()
>>    
>> -    if not os.path.exists('./uftrace.data'):
>> -        os.mkdir('./uftrace.data')
>> +    if not os.path.exists('uftrace.data'):
>> +        os.mkdir('uftrace.data')
>>    
>>        binaries = []
>>        for file in args.elf_file:
>> @@ -145,6 +180,7 @@ def main():
>>    
>>        for b in binaries:
>>            b.generate_symbol_file(args.prefix_symbols)
>> +        b.generate_debug_file()
>>    
>>        generate_map(binaries)
>>    
> 


