Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51A5D3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 11:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSZ1H-0005MF-5l; Mon, 08 Dec 2025 06:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1vSZ0T-0005J6-90
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 06:02:18 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1vSZ0R-0005C8-0I
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 06:02:17 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D73D13F16D
 for <qemu-devel@nongnu.org>; Mon,  8 Dec 2025 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765191731;
 bh=6nj3p6U0XgKhDCwvbyDyhEyVj/FaNw1yK9wIgLeKEtk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kPH0g6Of/tmFM9VrVsUPNIJ94zFHbUgk+YUGPquZz6Vb5rdR4Jws63ZwOrY/y1SYV
 +w0vKbr+wgsF88yui/b321zo5haUXV6Tmakt/jYVMHSEyBo5MbVBQ79hAFUdEAFPHL
 0iSBO3v+6k8TjVuD+cindDm6yhim3NRFZYjwagWnSW62RitP72W/U1kMJnxBP8tgUv
 ltCcn9g5LIafoYds2yXM6udVM1oueFLmE7/sOxEJw3RmjckwIzaVPH3BKShmTYEr9E
 Pp93i/WqYxBiKzbIiWfT4IF62sRFk/2ffapTkfRUYGtQbB7GL2nuypC1fJjfLHpoC+
 nwTGnpZhJUxmkqLedASSurIs2qJPISdPXbEa8H3vnojakCLnNL0Ryvp0xFcYp6PHBV
 //iYbmB3u2dTPkhRXb8ppq46IQwDd/opz5kDLkUn5rq/bHjlrdaaE5SfJAj6w0Nufx
 0ljFyJCwtaTkX2J2iszlx7B+JF2R+FhGsX4E0AUN8ubnrIhITYB+tmC8IgptQsseMH
 32uNeTDAd35MRpVVeCmS7+6cETwYz42W+SPm9aBT4TUHv+q87DEomgmqCWsXOXoY+I
 v4pVi4qAPtQy5TUT50sHxvreRrJ5yCzDTEx0tanWWfbeYHZ9+GmpuPJx1jYLgP/Fbr
 gf7BeV2UcFTCKdSO0cIs91+k=
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b7a29e6f9a0so159143966b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 03:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765191731; x=1765796531;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6nj3p6U0XgKhDCwvbyDyhEyVj/FaNw1yK9wIgLeKEtk=;
 b=RHxAU+N2WqaarfesTVR8yxmw9KRRENq6Y9lrdatxDGhU49V7RVZedwnlsxruT0PSX5
 UUUWZHaAhO/Pzf+MB1fwbUnnWPqMe2KfbpIk7tgP8sXhYmHUA0vCBqfdpFn9KV+SOhIl
 90fgEWxJ5YdZBrgpQ+ypP0Pgg/tI55SGFr8SDak+fB7Ke4WU2EiG8k/XiWnpmP2S1FlO
 MTTchOq8gY3p2I5q1Va8Jgcl6KNbDx/74XZ9145O7kV4rmxyOtNbIvrm+zDD0eqONA2e
 nsgEDlMqSoOp0o5DTucP+5lRrMN4R0Kb/DCxUWXnwZyRIC0bStMoql6V9BCge8xLx0za
 XRtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4+tDQH1IkmmRol2EnLPR4mvaK/VJEoyh67lVc+BAEZyoSz5bJKi00+EUbM0+cUy0pkiWSXVXOAc2M@nongnu.org
X-Gm-Message-State: AOJu0YwSufQWwuyyMBgVj+9zJAA44V6wPUHgJkPYue1I0JTN3N5qe9Bt
 cNmzeSrqlSec6bMuiux81dMovZ2sjTTqPbjjAoQt0WYMpvJo+//cTFTj+CpdcqARrz3X0VgRqb5
 bUCE5YhAAK1vEg5tQPv4ACuplseDyyQ2i4AoHkceq8iD7P9bjwYfIyjaVY7pb5tit5d1/78b3
X-Gm-Gg: ASbGncuJcDVlRUq/B7EkxtzwIHamWPuljY7BD9TQAO+T9OzKIOhXhpnqwEKColGsNcC
 tKeBHiAkvUewNPGWSibyCHge+T/W2dpcmcH8b6hp6OjCUUb1km74J5MUwxs1xqagxpR0RAF6R9Y
 RLyfP97aAWby+Q6vw6G5rN6bGC5F+49WSTrQr6bteo4/tKo94zu6XkqOmHrTGIKTYLBquPc/9I8
 rzH9lOVWMevd/N2ig8bsAZ6dgdJFGIROxTxkSLUVGrb7TZFLax2yMaHC0rdNoQnQl5Yt2ybX3cZ
 DaCdtxh7/HFHwHxfR/zUZ+UmtdyBvK3sZT1iU4ZqxZj6hDfyny/xDuDw1DZmuqUiqVvFUQKn+sT
 hLmBuOXDUsJKeCO87ZEIZjk405dJB7iESHMMbddbh9CGwM69yO6eqYlSG04NomvY58ROKpJ58LO
 w6/fthJlY=
X-Received: by 2002:a17:906:478d:b0:b79:c1d7:6f40 with SMTP id
 a640c23a62f3a-b7a242bfe0amr745981366b.14.1765191731393; 
 Mon, 08 Dec 2025 03:02:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdWgzkBu7qevDeb4zbhR71dcQUCpVSs2u6aZ25PhC2ixVAC7RhYRq91GnZYJBtk/p8WrMkQA==
X-Received: by 2002:a17:906:478d:b0:b79:c1d7:6f40 with SMTP id
 a640c23a62f3a-b7a242bfe0amr745977966b.14.1765191730879; 
 Mon, 08 Dec 2025 03:02:10 -0800 (PST)
Received: from [192.168.103.125]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f445936dsm1086465766b.9.2025.12.08.03.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 03:02:10 -0800 (PST)
Message-ID: <4b87cc8f-c3b3-4115-9fa6-a07a0d92710e@canonical.com>
Date: Mon, 8 Dec 2025 12:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] linux-user/riscv: add vector state to signal
 context
To: Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?5p2O5Lyf5pm6KOS8n+aZuik=?= <weizhi.li@spacemit.com>
References: <20250903081417.338515-1-npiggin@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250903081417.338515-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 9/3/25 10:14, Nicholas Piggin wrote:
> Changes in v2:
> - Fix 32-bit compile
> - Moved sizeof_rt_sigframe change to its correct patch (patch 2 is the
>    one that extends the size of rt_sigframe, patch 3 is adding new
>    extended state to the frame which is added dynamically).
> 
> This series adds vector state to the linux-user signal handler,
> and adds a basic signal handling test case. As a sanity check, I
> also verified the signal handling test works in the same way when
> run under a real Linux kernel.
> 
> The signal handler test has some gross header hacks in it to make
> it work for me (debian arm64->riscv64 cross compile environment),
> I would not be surprised if it breaks in other environments, any
> ideas or breakages let me know. May just have to define the types
> by hand for now if it becomes intractable.
> 
> I couldn't find much in the way of previous discussion or work on
> this, forgive me if I've missed it.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    tests/tcg/riscv64: Add a user signal handling test
>    linux-user/riscv: Add extended state to sigcontext
>    linux-user/riscv: Add vector state to signal context
>    tests/tcg/riscv64: Add vector state to signal test
> 
>   linux-user/riscv/signal.c                | 197 ++++++++-
>   linux-user/riscv/vdso-asmoffset.h        |   4 +-
>   tests/tcg/riscv64/Makefile.target        |   5 +
>   tests/tcg/riscv64/test-signal-handling.c | 507 +++++++++++++++++++++++
>   4 files changed, 700 insertions(+), 13 deletions(-)
>   create mode 100644 tests/tcg/riscv64/test-signal-handling.c
> 

This patch series resolves the issue reported in

https://gitlab.com/qemu-project/qemu/-/issues/3224
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2133188

Programs in foreign architecture RISC-V containers using RVA23 crash due 
to not restoring the vector state after handling signals.

It would be great if this series could be reviewed soon.

Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

