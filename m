Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD15D6B6AD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ByI-0004hw-R3; Wed, 30 Oct 2024 12:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6ByA-0004gv-Bs
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:54:56 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6By7-0007in-7R
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:54:54 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so77407a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730307288; x=1730912088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5l1HC9wXAoGEGTsKKtyor2plsqSVFcG8AcwK6ep5Bwo=;
 b=i535LRAqSIbzodOX0x6SeKBzgqTw5OB5/V3l1vwN/om01kzNH1EZX5ujPSq5ilUYy0
 ObRN8koG1n/NQr+HTo0EcIaQwktJEjjVln90+n4VxpQn8eovATWrpCgx6BrCTX9wN43v
 Lwg7Q5+S6IiAmM+Tqvk99L/+fKPGPenOqvaB60dZjygIJ/LW+hTBa8o5mJwWJXs856NA
 3ylgmzBQN+f5s65cOOOXIul+eXLUGhhJqnuGwnZu+Ocw/N54k8+0w4IBFokvPVSKCoFS
 sE/lF8xF8eXeRENgIBxM2Vc7drhxRv/N3a3qYbhCZgLWzVOKBLKcPIJiPE+roxWUEIID
 m4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730307288; x=1730912088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5l1HC9wXAoGEGTsKKtyor2plsqSVFcG8AcwK6ep5Bwo=;
 b=eSu8vyEWv3AlQ3KOcN5Nfrjq5rMNK/Z+gLUkbaD5hTO3aAdk6EdFeDHW+qJIMjlkGJ
 KRcwTxqmUvGFGRk+g3zHjTw8Vn9gKU3fiNLHIhvmgd6xf8lDzwuvcSfEzYmbYYncTub7
 /pJi3aSLIhupQ1v9JoPKkWaUe9pw1vnySX7DRXFpsWImu2kfwlByh2ZQOa2yz4WkYwch
 KBPPd4SG+s1RVZ13st3PER12pel704N1D0kxk75cvWx7byV/6vHb/MnEi8g9WPxq8SYG
 p288FBuvhIj0bI+FeKTAkT1vPHtLNtyGxNRM0M6b59CLlQKHUkvkQYOOXd5uCWnjPZHw
 dsEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhmlsTW6JShUCjRboRHDn0PHVwyqW7zsakzRL5k/wNpm6AxAKiqwHRMgDbWbQGUzrnH96jZpDsLRnj@nongnu.org
X-Gm-Message-State: AOJu0YxcqI2C5jFuU5S1aQLL8Hp/9cufXk6aI8fsKfmwHyqZu3g94aAw
 /x2lQ64dXyb+6CHmQDQJWUfSBWb8aSxXClP+7/3nQxnSoRq56TFhuH2xSp5DIsGqG1GZsTlyd6B
 U
X-Google-Smtp-Source: AGHT+IHInl5n/zNM9gOW7Ge3NxNY67VpGckdhwDeLii3gFbB7E0J8Mh+SkAwCuEspR6fqJ21KdwNBg==
X-Received: by 2002:a05:6a21:e92:b0:1d9:1ceb:a4de with SMTP id
 adf61e73a8af0-1d9a8402f18mr20955321637.27.1730307288098; 
 Wed, 30 Oct 2024 09:54:48 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8660ddesm9294980a12.16.2024.10.30.09.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 09:54:47 -0700 (PDT)
Message-ID: <e1924094-f3b4-493e-afae-ac635a32d28e@ventanamicro.com>
Date: Wed, 30 Oct 2024 13:54:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <d4241c7b-ae97-4dc1-bc60-5f0eed58d3a5@ventanamicro.com>
 <CAFukJ-D081Jta287S5XKtEch3CyzgFxJ-SQGF-VyU4j165DdBw@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFukJ-D081Jta287S5XKtEch3CyzgFxJ-SQGF-VyU4j165DdBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/30/24 11:17 AM, Alexey Baturo wrote:
> Hi Daniel,
> 
> Let's try to push it before EOY.
> I'm planning to start working on it in the first half of November.
> Does that work for you?

Fine by me. We can add it to Alistair's tree for 10.0 to be upstreamed in January 2025.

Thanks,

Daniel

> 
> Thanks
> 
> вт, 29 окт. 2024 г. в 20:40, Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>>:
> 
>     Hi Alexey,
> 
> 
>     Do you have plans to post a new version of this series? Aside from a few comments
>     it seems like this was almost there.
> 
>     We might not be able to get it merged in time for this current release (code freeze
>     is Nov 5th) but we can get it in Alistair's tree for the next release.
> 
> 
>     Thanks,
> 
>     Daniel
> 
>     On 5/11/24 7:10 AM, Alexey Baturo wrote:
>      > From: Alexey Baturo <baturo.alexey@gmail.com <mailto:baturo.alexey@gmail.com>>
>      >
>      > Hi,
>      >
>      > It looks like Pointer Masking spec has reached v1.0 and been frozen,
>      > rebasing on riscv-to-apply.next branch and resubmitting patches.
>      >
>      > Thanks.
>      >
>      > [v8]:
>      > Rebasing patches on current qemu branch and resubmitting them.
>      >
>      >
>      > [v7]:
>      > I'm terribly sorry, but previous rebase went wrong and somehow I missed it.
>      > This time I double-checked rebased version.
>      > This patch series is properly rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next <https://github.com/alistair23/qemu/tree/riscv-to-apply.next>
>      >
>      > [v6]:
>      > This patch series is rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next <https://github.com/alistair23/qemu/tree/riscv-to-apply.next>
>      >
>      > [v5]:
>      > This patch series targets Zjpm v0.8 extension.
>      > The spec itself could be found here: https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf <https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf>
>      > This patch series is updated after the suggested comments:
>      > - add "x-" to the extension names to indicate experimental
>      >
>      > [v4]:
>      > Patch series updated after the suggested comments:
>      > - removed J-letter extension as it's unused
>      > - renamed and fixed function to detect if address should be sign-extended
>      > - zeroed unused context variables and moved computation logic to another patch
>      > - bumped pointer masking version_id and minimum_version_id by 1
>      >
>      > [v3]:
>      > There patches are updated after Richard's comments:
>      > - moved new tb flags to the end
>      > - used tcg_gen_(s)extract to get the final address
>      > - properly handle CONFIG_USER_ONLY
>      >
>      > [v2]:
>      > As per Richard's suggestion I made pmm field part of tb_flags.
>      > It allowed to get rid of global variable to store pmlen.
>      > Also it allowed to simplify all the machinery around it.
>      >
>      > [v1]:
>      > It looks like Zjpm v0.8 is almost frozen and we don't expect it change drastically anymore.
>      > Compared to the original implementation with explicit base and mask CSRs, we now only have
>      > several fixed options for number of masked bits which are set using existing CSRs.
>      > The changes have been tested with handwritten assembly tests and LLVM HWASAN
>      > test suite.
>      >
>      > Alexey Baturo (6):
>      >    target/riscv: Remove obsolete pointer masking  extension code.
>      >    target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
>      >      of Zjpm v0.8
>      >    target/riscv: Add helper functions to calculate current number of
>      >      masked bits for pointer masking
>      >    target/riscv: Add pointer masking tb flags
>      >    target/riscv: Update address modify functions to take into account
>      >      pointer masking
>      >    target/riscv: Enable updates for pointer masking variables and thus
>      >      enable pointer masking extension
>      >
>      >   target/riscv/cpu.c           |  21 +--
>      >   target/riscv/cpu.h           |  46 +++--
>      >   target/riscv/cpu_bits.h      |  90 +---------
>      >   target/riscv/cpu_cfg.h       |   3 +
>      >   target/riscv/cpu_helper.c    |  97 +++++-----
>      >   target/riscv/csr.c           | 337 ++---------------------------------
>      >   target/riscv/machine.c       |  20 +--
>      >   target/riscv/pmp.c           |  13 +-
>      >   target/riscv/pmp.h           |  11 +-
>      >   target/riscv/tcg/tcg-cpu.c   |   5 +-
>      >   target/riscv/translate.c     |  46 ++---
>      >   target/riscv/vector_helper.c |  15 +-
>      >   12 files changed, 158 insertions(+), 546 deletions(-)
>      >
> 

