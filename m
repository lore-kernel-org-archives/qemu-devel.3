Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E59FD5329
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 09:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvucf-0007DZ-Rc; Fri, 27 Feb 2026 04:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vvucY-0007Ch-R6
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:58:54 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vvucW-0002FL-NJ
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:58:54 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6798f3b7163so1443268eaf.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 01:58:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772186330; cv=none;
 d=google.com; s=arc-20240605;
 b=J8NF9iq4WEQZIgmJF9r+44Fnhdldwri4HC6RGbMUGBJ8iPDxRjvsrcsuM11GC28akZ
 JLXgO8kc9jPiXd+STsEhfPu/40WemKTH4Jj7TaDY7kVlNr4kSQ1oNkXPFxL+KqqC5k/3
 773NzgY0kqmFoMe73hjJjhGBd66s7E6ux5cGuGsFpTtjyESgmUl41ZgaV4YJg3RcSlF6
 W6XoFmPypH7Sxf8g50soayavxOrYHIDw5hSL8qKGFIkmd6m6MMxq2Ol99kp9uCxpeZJM
 rgRfZ/dw96hoNn8lG9crlXrf6bg4o5/3Xf3PMX8WOWQ0rZXKl8nd9X+gp/oUcmyg0z0X
 wT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bsg29y6BvFvVYrFenV+jYj44VkC5kfFzLxWH4Uh8UbU=;
 fh=x4QmGFGz69hDEH+9gHWmaAPjhP49zbnMbzJjnLmNgSg=;
 b=by32Nmm4EB2Otn4Im6PubWMneW0NExTToe/WtPqYjlg3Il2XqLcfAPVQKkyVLFOPXq
 qlD97wxUGl1/CbFayt3KkYnFHRXl+TWPd2yyoQjUznuHCmr5g8gv/Qo+eYBVTXjQKoH5
 GAXm7rqJgkDcUNuFtdfWQWdTYqDMKhOdg3HbRFbt9yWbqzIegUtV9mfLjlya47nGuDEx
 IIHMkr95f3w6z39f87jPtYZ7sC1LmBzZjO7odaOEv9tqlW+WdJX0/QxhvaalZBEKygFN
 fiuggf7x0CkWEdmlGExbipo8jkAM5/yYMQfJI6NaKs06TBfdDjVw4ftcHGfi138OmiT9
 Ir5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772186330; x=1772791130; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bsg29y6BvFvVYrFenV+jYj44VkC5kfFzLxWH4Uh8UbU=;
 b=bTGLvmc7au/SL3lzL9fyEYOBRr7n4izRo18yUP2Pemk7v6aHscvKlVL1yTJZzBNGgO
 hniai6hxvdL/rx7ePZfXhwIDs8tdZzmW8sadHb6z4zZPx0DKMNsgz4QSq/44lD3dBosH
 2b5J3mRJou+YH98YX2lHepr2ES0vFa3JusgNia92alWurKGvq/KPvP17FcWE+1RUfN6S
 NH3h+gzx9bij84qTdiTdzk685eJfGArMxW/v9BnWZ2biyCWn1wNBBWgkTyNLz1Oxtk/P
 gfr6Ck4n3miYXDsFiZYRx/dmCfLYyRdFZq10ScG52fsOHc2HsUxe0l7LUd8OvBDjiaSQ
 1zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772186330; x=1772791130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bsg29y6BvFvVYrFenV+jYj44VkC5kfFzLxWH4Uh8UbU=;
 b=NSag9i2cWuSSEsufAvgRzxm58d5U6WgAWlYxYWcIYKugcHQSmPYTIpWEavzpxWLOFN
 WJkdQLaRIg665ezXIdh9zEAShAmSjSuRTtYkMrIZLgL2i3o68us7Sj+kg1LOSV3gJDkk
 ilPW9L2BscKvvyLpq6i3YUW36QCQFxSNl0BVE9Pb+/squh8G2o3cHZzq6e5dG4GsYkG0
 d3UITTnLO+P730ii//EkVnWQsZbz1gnUjK/N74eBEMzU5lk1AIGVpeBwZNnD69X3v5FU
 T/JrZ/nPW1gObSe5IaxOLezjYpPuOC9dZ8/8gs3+1JqXLIlncG7Vn5smwsbug7oSXuX9
 1V6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWhsyIu4TBeG/RbxBb3YHNZzmSwDqdBkH1jHQVUK/6iJ/MBpaZ7DOahPPoCGuDXOv3efH/KjlBaZlS@nongnu.org
X-Gm-Message-State: AOJu0YzuVEGdzmDIxJHWSHi6lxHmPPhmVNV925YMDogUzA9yenk/AJGC
 2zYWe7s+PqYma+Qu1a5sMypjFGyEho2o4rxMS2M0JhSeZ3LLYCvfn8wsy27jCLfjr+iz0MSLht/
 PbPPc+VZekI/HoXQjhP+aeyEhIhTdz4AXda8mCYjafQ==
X-Gm-Gg: ATEYQzy1P8pFKmAMaACvDsomdVMaIJ8+ciQmZRv0ff9EXeHr6OrKK96bX07rzqJg4gS
 VwFrWsIaBko22QrMlwpSXhvQtmMWx/hXTUfr2iqZVG/nAqR5Q8yG+AP9rGdqdLUXjtdtUyYvLFA
 qlajt8RFFwUp/e+e2umQhr5Ld3liLkLYrdKWrMzGWhIlN/gNsBAVPyQyz+1jnrLUQWsHkutcYpw
 YN6h46CqTIO2KVDg5tC1zTF6M9QokDS5SwnwcbFdRGPZxe8M01UjFf2/7lPZBuqG+rEswstMOQU
 UUGbDOo=
X-Received: by 2002:a05:6820:826:b0:679:dd38:994b with SMTP id
 006d021491bc7-679faf4e90cmr1406952eaf.57.1772186329731; Fri, 27 Feb 2026
 01:58:49 -0800 (PST)
MIME-Version: 1.0
References: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
In-Reply-To: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Fri, 27 Feb 2026 10:58:38 +0100
X-Gm-Features: AaiRm53D-l4t0O2lESkYlq4OPISG-Zt0YrP3MNN9oE80g-_8HKOmlfzIWUo0_OI
Message-ID: <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
Subject: Re: ppc-linux-user GDB stub broken
To: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-oo1-xc2b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Florian,

On Fri, 27 Feb 2026 at 09:28, Florian Hofhammer
<florian.hofhammer@fhofhammer.de> wrote:
>
> Hello,
>
> on current master (d8a9d97317d03190b34498741f98f22e2a9afe3e), the basic
> gdb stub test fails for ppc-linux-user when running "make check-tcg".

Sorry for that :/

> The error message is as follows:
>       TEST    basic gdbstub support on ppc
>     Python Exception <class 'gdb.error'>: Could not fetch register "fpscr"; remote failure reply '14'
>     Error occurred in Python: Could not fetch register "fpscr"; remote failure reply '14'
>     qemu-ppc: QEMU: Terminated via GDBstub
> I've tested from a clean checkout with the following commands:
>     ./configure --target-list=ppc-linux-user
>     make -j$(nproc) all
>     make check-tcg

It's odd this config isn't caught by our CI.

> According to git bisect, the test started failing with commit
> 1ec0fbe2ddadf17f7e0644b441833f0cd20dc137, which reduced
> cc->gdb_num_core_regs from 71 to 70 (link to the patch on the mailing
> list: https://lists.nongnu.org/archive/html/qemu-ppc/2026-02/msg00265.html).
> Commit 7ddd3aca5f2efcf6aae10f836011e445ee77a6e1 (mailing list link:
> https://lists.nongnu.org/archive/html/qemu-ppc/2026-02/msg00267.html)
> got rid of the hardcoded value for cc->gdb_num_core_regs, but the test
> still fails (people involved in the original patches in CC).
>
> I've debugged around a bit but I don't know my way around the gdbstub
> internals enough to propose a patch right away, so I'll just summarize
> what I figured out so far.
> 1. Due to cc->gdb_num_core_regs not being set explicitly anymore, it is
>    set to 0 at the end of gdbstub/gdbstub.c:gdb_init_cpu(). In the same
>    function, cpu->gdb_num_regs gets set to 70.
> 2. When the test tries to read a register in gdbstub/gdbstub.c:gdb_read_register(),
>    the first condition of "reg < cc->gdb_num_core_regs" is always false.
>    Also, the register number for fpscr passed to the function is is 103,
>    and cpu->gdb_num_regs is also 103. If the register number is supposed
>    to be an index (as I understand it), this would indicate an
>    off-by-one error somewhere.
>
> If you have some pointers on where to look / what to check out for
> fixing this, I'll happily try to work on a patch. But I suppose that
> somebody more experienced with this could probably fix this much faster
> than I can.

I'll have a look.

Regards,

Phil.

>
> Best regards,
> Florian

