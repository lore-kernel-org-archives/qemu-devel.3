Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAC2C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 21:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rajH9-0006qP-Rk; Thu, 15 Feb 2024 16:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rajH8-0006oT-6z
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 16:28:10 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rajH6-0002bJ-Hc
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 16:28:09 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d944e8f367so13151515ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 13:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708032487; x=1708637287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u7/HDZ1eKbOlVvi62l3szYM6weqK5/jj7KQZeEDO4wY=;
 b=Z8RZtunbQRSlDWP/gT5BCtgrNde5FSbs83co1OE+/8lAjDjgMoyuy7aEIrFwCABWte
 TLJ+shPWLjEa5O87NLTnrqcA/TNlDNBjpN1V815CXfDR9Xx2FQHFhj3Zyuvk1ajfzobe
 aeXJVNnc13qwxeBOB/U7QywEs5ZFC/lMtSMzxhGW3LDZ13LMIs51skFK17plhcFTTeWe
 A/6+ZI+ZYNLrQe1dyYB9JoaDGFOIisRbUYSV1ZmgMaUWCDEBzM9U7d7Jn3RDunJBqMOq
 n5H7xd8VOqu4Sq2Qy1ccuuMOqej7SrSMOs3iuuOiOnpjlcQpET90OzhIh+Y3cRX1SZbh
 sm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708032487; x=1708637287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7/HDZ1eKbOlVvi62l3szYM6weqK5/jj7KQZeEDO4wY=;
 b=i+9NUAdwNId9nxNLayf1d34+uUaLd/DdMrCKYx7LSKxLAu6j59i58kcg9OJJrXIiOQ
 DrnlMUbLsLWD/SvsQ0A7dZ1cXwOaR13+VZ0S7jHSQxpjCgScCs/gKZghhhsF8jZwbrLX
 tp0x+Aw368QemfrSJCNgnfd8nhOhA+BeB3MZ0C9AaHEhjcIyLuKJhPk6piiOoo7ffTv6
 D0z8rdMe9a97bn6CLy/kynR10J2GnCnhUUfgA78Ze9Q4HyoAqfD462ojBITGjvbJ2KLy
 zDeiFUVxDThJ7lHrzCJEiJSr8+m0XVFWS+QExNhOdGWHlyXUgu3YPZZyFDInvziLBB1m
 v4yw==
X-Gm-Message-State: AOJu0YztqD/iEykgjLm98kAwdY5mXFCWvlkUx9bZ29zKYMvBdtR3SB5T
 xuG1Cs4iZrsIr1HQ/tFsbIq76Wi71F/2J+7xXXJdvEIBv6gVX0T8DceFbdtVAdQ=
X-Google-Smtp-Source: AGHT+IFmyZs0ivzRSwZXIPUaWtokwI7xVE3KlSX4ePG5ikKmY5nNk4nNF3g1uTt18AvurUGaQf82PA==
X-Received: by 2002:a17:902:c40e:b0:1db:5b41:c5ac with SMTP id
 k14-20020a170902c40e00b001db5b41c5acmr3596598plk.68.1708032487113; 
 Thu, 15 Feb 2024 13:28:07 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 ka16-20020a170903335000b001d9ef367c85sm61122plb.104.2024.02.15.13.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 13:28:06 -0800 (PST)
Message-ID: <3713703c-7b60-42cf-92a3-198616382022@ventanamicro.com>
Date: Thu, 15 Feb 2024 18:28:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] riscv: named features riscv,isa, 'svade' rework
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <CAKmqyKN0UX_PK5Xiar-PdzJrV=S6+LaX8a3So8uahuqC04Wpvw@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKN0UX_PK5Xiar-PdzJrV=S6+LaX8a3So8uahuqC04Wpvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/15/24 06:52, Alistair Francis wrote:
> On Sat, Feb 3, 2024 at 1:23 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Hi,
>>
>> In this new version we changed patch 3 as suggested by Alistair in v1
>> [1]. Instead of creating individual always-true bool for each named
>> feature, create a bool flag will be always 'true' to be used as config
>> offset for these named extensions.
>>
>> Patches based on riscv-to-apply.next.
>>
>> Patches missing acks: patch 3.
>>
>> Changes from v2:
>> - patch 3:
>>    - 'ext_always_enabled' bool added
>>    - individual always-enabled named features bools removed
>> - v2 link: https://lore.kernel.org/qemu-riscv/20240126133101.61344-8-ajones@ventanamicro.com/
>>
>>
>> [1] https://lore.kernel.org/qemu-riscv/20240125195319.329181-1-dbarboza@ventanamicro.com/
>>
>> Andrew Jones (3):
>>    target/riscv: Reset henvcfg to zero
>>    target/riscv: Gate hardware A/D PTE bit updating
>>    target/riscv: Promote svade to a normal extension
>>
>> Daniel Henrique Barboza (3):
>>    target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
>>    target/riscv: add riscv,isa to named features
>>    target/riscv: add remaining named features
> 
> Do you mind rebasing? I feel bad always asking, but I think it's your
> patches that cause the conflicts :P

:)

I'll re-send based on current riscv-to-apply.next. Thanks,


Daniel

> 
> Alistair
> 
>>
>>   target/riscv/cpu.c         | 70 +++++++++++++++++++++++++++-----------
>>   target/riscv/cpu_cfg.h     | 12 +++++--
>>   target/riscv/cpu_helper.c  | 19 ++++++++---
>>   target/riscv/csr.c         |  2 +-
>>   target/riscv/tcg/tcg-cpu.c | 34 +++++++++---------
>>   5 files changed, 94 insertions(+), 43 deletions(-)
>>
>> --
>> 2.43.0
>>
>>

