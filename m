Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5BACCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Gna-0004tV-Vx; Thu, 16 Oct 2025 01:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9GnZ-0004rf-Dq
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:45:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9GnW-0005Zz-Fm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:45:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47112a73785so1327415e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 22:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760593507; x=1761198307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gd39qrnQsFo2io69p+XdH5zgFz32wsRxv5AsNsRxJJw=;
 b=rr23wFv6MV7Cw0MiiZC8s1IzrRNt+VBR1giv4aG8GxrqrRFqZQhJvHGhGaabNzQBcy
 1vrzyCQZEL265Ub/trTiKy+5lJPNIB0PBDY5RMy+y+OIOIiiNriV1hQPva9t7m2Voqbv
 oZPZpoA6KOx7YzNcqs9UZ+rPaEYckz4o1Ma4cW/0Bsl4KmzwWTheUZsFbDOfPsILezma
 9fPm9bwdL2UxJuctOKeavNFs2EhYfQwreEvDSCO3lQ3zSq1VuA2hyPHTZuj2WXZQ8a3y
 530Rh0prpH7/ZxKWT8isSD332qHVtVmALYJoKeVJ03mkbmz/sgqCs9I2UTtBpnVMeAI+
 0pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760593507; x=1761198307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gd39qrnQsFo2io69p+XdH5zgFz32wsRxv5AsNsRxJJw=;
 b=xRC4lFJZeBsKElenrojcpC3gqA1VDo4FZHfr6mYW54fCh1t3W+xll96ev9jWJoIriV
 JkXC+vb4eXRmcM2yoFumcj3LCXMHsdij6OX4bpAm8brNYgn4SgpSo6ylvDawQKgDLNuV
 Xd0oz/5yFMp6iJauGuv9F8Mwa6JlULc2grm/YKky3YdIkA+UH/JZYurjXA9gXkqjLjlk
 WSgS251t9cm5ra3YP2mugNiWJKV9EW/7BmDrGcw/LNUco0B2BrSLt3meyXtka9xVwSCr
 yTBccJTE6eOASxC0TJ9yGXAn6zgImFsoLWeasmyWakDngcaF7ZJIiIocw3RseRRd1Lkl
 wUXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8RzXRzxsbbdsMsfHsITtbytqxN69JPsTAsOh5AAIizWkE6YGH/wtXKGujBNBz8hS7vh6fy5Xc9WdY@nongnu.org
X-Gm-Message-State: AOJu0YzXdX3idz9Cx6YDUjGfqsumZO/D2X0knAvHo2YiTLrQwMYBgxYB
 gjTBnEKhLkEwn0uPl5mTvn4wAyGLqSWQ0MzqoTcp8ez2GbPXs3YsFN61f9oXa6JqWxY=
X-Gm-Gg: ASbGncsoIBG90QPeIuuLeMAbiP1sZzI19BY62EAwOWpf0sxdSdeprAIt1IRCkgQWDTS
 Fi93VXkqCGcnDspXUgbirlwE3Te9O8Rx5tjGketnbYlLzABTb1JoP3HcJT9hyDIhpxYpBh+MCOz
 ECfKGlbigFzYL8TyL6hMk0FB7U7ocKi6Cvs5Xo4wAROIROtf6heJbSr+oEVWEWpcf376XNKQ5o1
 cr/gL/j3/z4yQqpurv2+Msxd+BMOmjYQCXmSYts9MERSiLAseniKakgPGBaLnWuV73XYJumjirb
 TcyOsGb7IwDRNmBAmgVkb82zJk/GMU7A4OBA6ALS88WeBXLv06eehZGcP04bDyjSXD84dOpGzqH
 Dn0tQ5hgdp/0GTWC9TCsPDTfIzStXF8xWJWcZmEFib18LMW2dzC/0Wo7OgcngpvjcRCEsZNJ+Fy
 ECFN3FvuQcbxdaqWU1dCQ4zEkS4HnX+cO2g6ZeUbSaUPAMZJWAytDjqBJUjA==
X-Google-Smtp-Source: AGHT+IGTXm37iIudSEAYIWSk4YnU2gPFQbIhWOjNp0FlHWJOrWUbl96bT4FHi+6N4x+CqOKVL6nJwQ==
X-Received: by 2002:a05:600c:6383:b0:45d:d353:a491 with SMTP id
 5b1f17b1804b1-46fa9a8c425mr207118075e9.1.1760593506803; 
 Wed, 15 Oct 2025 22:45:06 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442932esm4927985e9.6.2025.10.15.22.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 22:45:06 -0700 (PDT)
Message-ID: <850f9b0b-7487-42e6-a9e4-eeb45af7b9d7@linaro.org>
Date: Thu, 16 Oct 2025 07:45:05 +0200
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
 <b7256e10-d5b1-4978-90e1-99d9e76318df@linaro.org>
 <b4a0756b-3781-433a-aa4c-338d9348da5d@linaro.org>
 <a9c491b9-e1f4-4ed5-8355-75db54239130@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a9c491b9-e1f4-4ed5-8355-75db54239130@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 15/10/25 23:12, Pierrick Bouvier wrote:
> On 10/15/25 2:02 PM, Pierrick Bouvier wrote:
>> On 10/15/25 1:40 PM, Philippe Mathieu-Daudé wrote:
>>> On 13/10/25 23:39, Pierrick Bouvier wrote:
>>>> Enhance uftrace_symbols.py to generate .dbg files, containing
>>>> source location for every symbol present in .sym file.
>>>> It allows to use uftrace {replay,dump} --srcline and show origin of
>>>
>>> `uftrace {replay,dump} --srcline`
>>>
>>>> functions, connecting trace to original source code.
>>>>
>>>> It was first implemented with pyelftools DWARF parser, which was way
>>>> to slow (~minutes) to get locations for every symbol in the linux
>>>
>>> s/to/too/
>>>
>>>> kernel. Thus, we use addr2line instead, which runs in seconds.
>>>>
>>>> As well, there were some bugs with latest pyelftools release,
>>>> requiring to run master version, which is not installable with pip.
>>>> Thus, since we now require binutils (addr2line), we can ditch 
>>>> pyelftools
>>>> based implementation and simply rely on nm to get symbols information,
>>>
>>> `nm`
>>>
>>>> which is faster and better.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>     contrib/plugins/uftrace_symbols.py | 108 ++++++++++++++++++ 
>>>> +----------
>>>>     1 file changed, 72 insertions(+), 36 deletions(-)


>>>> +def get_symbols(elf_file):
>>>> +    symbols=[]
>>>> +    try:
>>>> +        out = subprocess.check_output(['nm', '--print-size', 
>>>> elf_file],
>>>> +                                      stderr=subprocess.STDOUT,
>>>> +                                      text=True)
>>>
>>> Nitpicking, we might be using cross-compiled `nm`, so maybe not hardcode
>>> the binary name.


>>> No blocking comments:
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>
>> Thanks Philippe.
>>
>> For the cross compiled tools, I'm not really sure it's worth making this
>> more complex. Having tooling for a cross architecture is an advanced
>> setup, and I think it's fair to expect someone to have binutils
>> installed if they have any cross compiler and cross binutils.
>> Plus, they can always create a symlink if needed.
>>
> 
> As well, nm and addr2line are architecture agnostic, as they just access 
> ELF symtab and DWARF information, so you don't need an aarch64-*-{nm, 
> addr2line} to extract information from an aarch64 binary.

Right, good point.


