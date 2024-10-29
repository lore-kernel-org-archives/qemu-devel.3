Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624CED3A678
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 17:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5qD9-0000RL-P0; Tue, 29 Oct 2024 13:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5qD7-0000Qa-Uq
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:40:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5qD5-0000fC-VE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:40:53 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e8235f0b6so4359871b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730223650; x=1730828450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3l/sk+sczWQ7dPR93U3sBbdgCRxQZhE4N3jHNvaS4E8=;
 b=oVO6fxNY7g+wKxB4knV8CkuB1DRuvA0VWYR8/BFwp7coAZLp/w/0LsM6Uqrtr5IUzj
 yTFBXHki0QO/LusUVmHPe9NjmpzJ42NflTdPTVvSBgBnN+BmWG1MRhvyBFYiGMstSAv1
 wEEid+LYvE3+7LnSqt5sVHkkJQ/8HR9St3LYo5QdU/afaOwHlxMEoZ949jNREAjQ1DF4
 mMZ76pVCx/C8jUnGrxzQh39S4klbMO91z3KHfVsIQSfn/zyrviLK9Oa99Hp5ovO3yyqv
 Y+Q8fmMMcoZDXBJQ5hcyLBo/FZGsPddvM7/cOCgYvTDDfUriD7CosFK0KhyTl/m+T792
 fGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730223650; x=1730828450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3l/sk+sczWQ7dPR93U3sBbdgCRxQZhE4N3jHNvaS4E8=;
 b=AqSaBznApgl0tOrxdqyqjr+xVoL52a/7JCTFiyx1e4EHycFkjgzfOPE6UvgJFyWYDX
 X8DGP86Hv8baO5WO2eTr1QiTp5lmdNp+Fz6pOS9RErQp4xRGDU6O/o7uJx1Wtm8du5fV
 QNei00En2V+O0C4qVg0Bee2OYY/oFWPBcd4/2XuKZlZxAftgl30IeH7t/u9MTQr7PA7e
 9zcNqHRGsztDfgw/+O10PYbHeJBk6h2h8NXT3YGi/E0oppM50IJA1SsE/YG885QxymbN
 PgCizb1Yr0LUj/ts/CN23pA6dpWP3blZE3ispg9zyWdPa3KqlTVOex5TfTm3qs6Qq/Ck
 LtWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXlRiotODdPuX2Gpz6A8aEuZvxYmCSkEn03BceMxoTcuk2oaMceQGeyoj/Bl9mL+RQqih8pKImocmy@nongnu.org
X-Gm-Message-State: AOJu0YyFVFRc9KqsqyiPew/G7bs+hUXTZRI79cK8iSo0P8JYxNIEWWb7
 TTLKzAqexIGbCmUGuegBZtI9fLsIiQUUJKfi/zwezp86gGF/LO/YcrDXdp+tp5w=
X-Google-Smtp-Source: AGHT+IHsTgf4p3hjomCyh1jHarXr/Ef8GNv284PUxNAFiktBJku64l+CQqEaa/xMmFGoCbWO+v6aKg==
X-Received: by 2002:a05:6a20:b40b:b0:1d9:a1c:7086 with SMTP id
 adf61e73a8af0-1d9a8516a2dmr15979106637.44.1730223650345; 
 Tue, 29 Oct 2024 10:40:50 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720579360f5sm7829340b3a.88.2024.10.29.10.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 10:40:49 -0700 (PDT)
Message-ID: <d4241c7b-ae97-4dc1-bc60-5f0eed58d3a5@ventanamicro.com>
Date: Tue, 29 Oct 2024 14:40:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/6] Pointer Masking update for Zjpm v1.0
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240511101053.1875596-1-me@deliversmonkey.space>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240511101053.1875596-1-me@deliversmonkey.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

Hi Alexey,


Do you have plans to post a new version of this series? Aside from a few comments
it seems like this was almost there.

We might not be able to get it merged in time for this current release (code freeze
is Nov 5th) but we can get it in Alistair's tree for the next release.


Thanks,

Daniel

On 5/11/24 7:10 AM, Alexey Baturo wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Hi,
> 
> It looks like Pointer Masking spec has reached v1.0 and been frozen,
> rebasing on riscv-to-apply.next branch and resubmitting patches.
> 
> Thanks.
> 
> [v8]:
> Rebasing patches on current qemu branch and resubmitting them.
> 
> 
> [v7]:
> I'm terribly sorry, but previous rebase went wrong and somehow I missed it.
> This time I double-checked rebased version.
> This patch series is properly rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> 
> [v6]:
> This patch series is rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> 
> [v5]:
> This patch series targets Zjpm v0.8 extension.
> The spec itself could be found here: https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
> This patch series is updated after the suggested comments:
> - add "x-" to the extension names to indicate experimental
> 
> [v4]:
> Patch series updated after the suggested comments:
> - removed J-letter extension as it's unused
> - renamed and fixed function to detect if address should be sign-extended
> - zeroed unused context variables and moved computation logic to another patch
> - bumped pointer masking version_id and minimum_version_id by 1
> 
> [v3]:
> There patches are updated after Richard's comments:
> - moved new tb flags to the end
> - used tcg_gen_(s)extract to get the final address
> - properly handle CONFIG_USER_ONLY
> 
> [v2]:
> As per Richard's suggestion I made pmm field part of tb_flags.
> It allowed to get rid of global variable to store pmlen.
> Also it allowed to simplify all the machinery around it.
> 
> [v1]:
> It looks like Zjpm v0.8 is almost frozen and we don't expect it change drastically anymore.
> Compared to the original implementation with explicit base and mask CSRs, we now only have
> several fixed options for number of masked bits which are set using existing CSRs.
> The changes have been tested with handwritten assembly tests and LLVM HWASAN
> test suite.
> 
> Alexey Baturo (6):
>    target/riscv: Remove obsolete pointer masking  extension code.
>    target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
>      of Zjpm v0.8
>    target/riscv: Add helper functions to calculate current number of
>      masked bits for pointer masking
>    target/riscv: Add pointer masking tb flags
>    target/riscv: Update address modify functions to take into account
>      pointer masking
>    target/riscv: Enable updates for pointer masking variables and thus
>      enable pointer masking extension
> 
>   target/riscv/cpu.c           |  21 +--
>   target/riscv/cpu.h           |  46 +++--
>   target/riscv/cpu_bits.h      |  90 +---------
>   target/riscv/cpu_cfg.h       |   3 +
>   target/riscv/cpu_helper.c    |  97 +++++-----
>   target/riscv/csr.c           | 337 ++---------------------------------
>   target/riscv/machine.c       |  20 +--
>   target/riscv/pmp.c           |  13 +-
>   target/riscv/pmp.h           |  11 +-
>   target/riscv/tcg/tcg-cpu.c   |   5 +-
>   target/riscv/translate.c     |  46 ++---
>   target/riscv/vector_helper.c |  15 +-
>   12 files changed, 158 insertions(+), 546 deletions(-)
> 

