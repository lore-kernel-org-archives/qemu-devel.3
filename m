Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A891049516
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0G7i-0001yz-JK; Wed, 11 Mar 2026 05:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1w0G7g-0001xl-2u
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:45:00 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1w0G7d-00056Z-2d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:44:58 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 807853F7DD
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1773222293;
 bh=XGPHKnLAO2hDcslSBTaYCljDNJnfQ9V/FHYuMS8Kyc4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PyMw4perKx/5cUZXlUWrqdl1nGOI87HG8UT61/kioM49dZ/bl+wXf56/enS+OCkxm
 2FGSq2zBC5ZIT+y1M+XflP4DFzY4pmsO0KzApV9+A+MnBOHR+cmOL4Yjvj/h1fFeYl
 mECeUNYtvN7/9Pm96+Uzxydnt5zL6UHzBE5mwCXO6/KzcHgFnQ4Mrr8MfRXso8kybY
 pxK6spgsr7QmAOY8bZFmHLB4aBTvaUPJ9AQCsrgFBO7SUS3hca+MJCBrX4X/YD+z3p
 8428Y4Pg0oa/trVh+SzrtkVFmGeOG9NYF0k4lxcYIBdUWnbERcepFlKjxHjH2mHK6g
 l3E9+RSoLD+aEestyd0j+5i6TyJS79MriqzMcsXv0dGQudgGZ1j99mRuGTvxuBX12r
 oJp/MjbqdL0ERVoHAts5211MfiWNhfY3/+vWLhB1Exlux2IcRLjFtePKwZ40f3yy0k
 jw1wicnE3+lle5+kX/gnwzGn3bZuG6MbXUHzp612oUfi6I1u+r5VBrQbxXjfrOPaPi
 px71/5usZ/uyrziYXLydHa64k8ry2Rh94UW9TzKFzBSlLgz80YUMw6/i7G9MA/mfK1
 KHeYHhi4QQi+DAOlckoUXB5j7Ui/Xv/2PvCOwWJbmq/bSPZ6jqNKXLXrmDO89HAF+3
 co7AZvQ6fc/AnpcSRlZoSdg0=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439fbfd93e8so32377f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 02:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773222293; x=1773827093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XGPHKnLAO2hDcslSBTaYCljDNJnfQ9V/FHYuMS8Kyc4=;
 b=CE3j2y74ghN1apQcqV5zLWnARAPd5iKp2y57k8eRezL0Ydcm3+McLMWDC8cgyhATiL
 i3bfgQXfVSYcZ2FNtYySfhLe3MHIcWbvwwfHKEPl541RZmzh1Zy6swNU+gx5ANt1Aago
 L5tq9UTH/6aMB8o10zDn7V4IQy7fyb/2cfQJS6ka3W5wNBAbirO3uWXbN/FgXS+9K3gv
 ddaj9MkfnQFyUt4rf7IFsqvO0gdm8HTTn++rovQLrbgJ/cFjF19/Y+wJJFaULNWlCn5M
 bsDpZ756Pt8K/KnbB7mHGjRJDJuqZ4Zzegk9yj369n8g0hVs5xwFIZPJypXpc6QXOQUE
 4kSQ==
X-Gm-Message-State: AOJu0Yx/0dEZwTbwPQZgQFO2jqmJjxVZ+rspeP/eyMF86rvpVp6En5xn
 +JqQBspfPejHSEX9TieqDEQdj4t33ayVn1Uq4Bv2rYbPY4B3TP3MnpzZ0c7x19hbQRrkTC438Yw
 QZlXGLhoONJ/SH2ON5ozNmr09uHVLlWsTeXbK7pw3MzMCZcphlSH3WPFuCHZfn12aCOKUnXTP
X-Gm-Gg: ATEYQzwdFwL//2vP9XKK+m1F6Mmebk/Zwx8Y8Foruh/AbGA7vFuowBTBvTsKrB+9pXM
 76+/gvXSp6w+qZyXXdD1seZnB1qe5zMilNQ75YdWLnxljmjiYt9HRhsxztPDXYoyhr9duNVAU++
 nQ4xsop+VcoTaFEaZ2gum8OdUxig72wr2d+R2tpNGIdJvj8EhT9/JKtdDOUMLamoLo7qHHOnkPl
 zP4apLb1obpUOp8BGp5+7FgRQXMwH7KkHAzGLb8PgxUOrVJ7HqmoJ+LyoLbhSKOnYVjSBLSiv2k
 R/UlnoBPYKg3TWdgPci67F4l048ejASBUyPnC5GWmV2JmbWxgJ9RDL5EpoZdw3aLe1gER2c7gb5
 95Do/21nsawQY6hrf2bj7u5SCv/lSS1lkw4M7N4htvsQ5B5bUBrKHlcOKIu1NKO4nplxqGu26F8
 xIKpAMzBdFU/5MOFUa+NAlJNTwZoN77Yn7sa2YdtTSqZ+a4Ip/n94=
X-Received: by 2002:a05:6000:4202:b0:439:bc31:a05a with SMTP id
 ffacd0b85a97d-439f8222ee3mr3508468f8f.43.1773222292977; 
 Wed, 11 Mar 2026 02:44:52 -0700 (PDT)
X-Received: by 2002:a05:6000:4202:b0:439:bc31:a05a with SMTP id
 ffacd0b85a97d-439f8222ee3mr3508432f8f.43.1773222292568; 
 Wed, 11 Mar 2026 02:44:52 -0700 (PDT)
Received: from [192.168.103.129]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81f143asm5765840f8f.23.2026.03.11.02.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 02:44:52 -0700 (PDT)
Message-ID: <866317ff-70c1-47a7-8347-e84e519c2716@canonical.com>
Date: Wed, 11 Mar 2026 10:44:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] linux-user/riscv: add vector state to signal
 context
To: Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-riscv@nongnu.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>
References: <20250903081417.338515-1-npiggin@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250903081417.338515-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

This patch series
https://lore.kernel.org/qemu-riscv/20250903081417.338515-1-npiggin@gmail.com/
relates to
https://gitlab.com/qemu-project/qemu/-/work_items/3224 .

In January it was no applying cleanly but it does apply as of today 
(ae56950eac7b61b1abf42003329ee0f3ce111711).

Could one of the maintainers, please, have a look at it.

Best regards

Heinrich

