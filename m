Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99900CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 11:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3v4n-000417-N2; Wed, 01 Oct 2025 07:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v3v4l-00040N-7o
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:32:51 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v3v4g-000252-23
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:32:50 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-74435335177so17045737b3.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759318358; x=1759923158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dN7uGPOq0+IjqEkygipqr1ptvic5doB1cNsl9H3Jees=;
 b=FWzuO9kMirMFo7kgCGjZSWQcBHRif4+lHuoGNBSgQJDqzM1Qkcge+IGYjkGA/0uv+p
 xq61Y0OPX1fzC0D5yKJRZpxoV3oBGJooAoNUqqHpm0h6iF+sPWXGbfPzJUaFBzDp1Cb8
 jpzF1M72twjIhLCZAkSpOWXvrHgUCDbmVywo0AMswlD+poTQ/7Mj7oXRTU50CJAem0uw
 w+xONqMgE/v4a61HjqjRaP5rdtg0wWiWGjORU9HEf2hbzGFitgQe2LJmvQYgoDu/sPBU
 jfhixoPjaZZ76/peXUIg5P7yjn9NweWyJJ5m8lUa2ygXHoqK7BFDShdpDA/DAzfjEYpw
 /tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759318358; x=1759923158;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dN7uGPOq0+IjqEkygipqr1ptvic5doB1cNsl9H3Jees=;
 b=kUP808KWgQfUyUg+LlwKaFBaRY5kPn+cuRi4QTi8pDBmjkGk1YOvJqKfkzDr46Z0mH
 HBVYGuhySZ/vXjRNlU1LzNRadpAYh6a2+wnOb0Wuf57BfwSI5iRFA/brmvxLvYOudXi4
 0T9MZaAFS7CM/wcM0agigvDAsyjcyugaACpgQ9QNKuUwGULDLkzR9eCnG6qhO7CB8uJx
 OeP9kUg8Y46fQpP7UDMR1GdFCVe7QFhnXCnTIpYZ9+FgltbfsdmTVgrgwI2cIrJ0ebS9
 60hglgbscXD138+QFUQNwpB/PatksbfkInCSRXqlPxJ68UNzoXEkt7zMkoH9DCWCThfX
 asVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW63vL5JrHCFlvzIEQqoRW1YIeGjPvNUWWwW8N6ruD2mtrSujxzFuyRjY4+c0dpGHhuxc6G/TaCxwum@nongnu.org
X-Gm-Message-State: AOJu0Ywt1wKtuHTEFBxPVhuzOimR3HR/UokH5IE/SUn0sgAiZv3Z5A/t
 jcyxpw2RTiK72SJVxlXa1WoaCxqxGyp2hayPOMXvRIr8+M5e0qifN0G04mjXguDe+wU=
X-Gm-Gg: ASbGncuiIEz72Bf+uEMlyBjK7t+f38BGvpHhkTJCOIOWfr+RTMHBMNr5+Oxh0rKmf58
 M5Szc8gqIVdToDh/ET8peKXBAP0Si8C7wRJMCBPUNyMpZnwM5hy+5m2W3shvZfUJC0m0XLUdn9D
 MKpPJVVgAACUjd+Ug/liT1Xz2Uva2TZiHVoE0/okbiNZi76yVFX07YOpilwxFMrmQCANWj/JoLt
 dr4xyq4A6BvPXydh/wfa84xuCDkgeacG50yNJ1Ugm158nm0pNPj7NHRJV9NYZgYhKpo+DWjINYK
 JEjcMQYff1qehSkcZkcX1kqkYDzZGXX5JMkfLQ+PUtfkSEWTzXIZuzf4150bWuDAgu1A4e6OEXW
 4aZo0kXbp3jmjOHeip4cJOryKZ9Sn83cpVPLrJq4OEQSPWMg918+Cq7yLkZNHFMmm6nz1Ttns+A
 YuAe1NUA3vbbdL3nEwZ5ZcEpogk+x4pu1w8jc=
X-Google-Smtp-Source: AGHT+IGbFo3FnsFnTyuPSIdXDv5flYWlhMwUx7rXJtsuSIXqWTbrOOn0nzcwetcRgQt9FJwjPtlfXw==
X-Received: by 2002:a05:690e:1582:20b0:636:d4de:a73d with SMTP id
 956f58d0204a3-63b700bb5f2mr3736791d50.19.1759318357825; 
 Wed, 01 Oct 2025 04:32:37 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:6bd8:87f0:c4e8:3ccb:fa1b?
 ([2804:7f0:bcc0:6bd8:87f0:c4e8:3ccb:fa1b])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-63ad64e5d45sm2493291d50.29.2025.10.01.04.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 04:32:37 -0700 (PDT)
Message-ID: <0878ebc9-f553-46b8-b2ff-b748bd45da88@ventanamicro.com>
Date: Wed, 1 Oct 2025 08:32:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] Add RISCV big endian support
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Roan Richmond <roan.richmond@codethink.co.uk>, ben.dooks@codethink.co.uk,
 lawrence.hunter@codethink.co.uk
Cc: felix.chong@codethink.co.uk, sagark@eecs.berkeley.edu, palmer@dabbet.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, qemu-riscv@nongnu.org,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20241220154616.283933-1-roan.richmond@codethink.co.uk>
 <6ad3dee0-0fe8-4368-b43f-e7f8f30ead24@canonical.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <6ad3dee0-0fe8-4368-b43f-e7f8f30ead24@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112c.google.com
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

(ccing qemu-devel ML - please send all patches to qemu-devel too)

On 9/30/25 6:46 AM, Heinrich Schuchardt wrote:
> On 12/20/24 16:45, Roan Richmond wrote:
>> This is part of our project to investigate big endian on RISC-V.
>> The full information is documented on our gitlab[1] which includes
>> source repositories, build information and project documentation.
>>
>> We have a minimal buildroot, qemu and kernel working on QEMU.
>>
>> As this is a work in progress any review or help is appreciated.
>>
>> [1] https://gitlab.com/CodethinkLabs/riscv_bigendian
>>
>> Ben Dooks (2):
>>    target/riscv: Add big endian check for atomic ops
>>    taregt/riscv: Add big endian checks for pagetable
>>
>> Lawrence Hunter (3):
>>    target/riscv: Add SSTATUS_UBE
>>    target/riscv: Add sfence.vma for endian change
>>    target/riscv: Add big endian CPU target
> 
> The RISC-V specification explicitly allows for bi-endian cpus. Shouldn't we change the existing generic RISC-V cpus to allow starting low-endian and switching the endianness at runtime instead of adding a new CPU?


Mainline Linux stated that RISC-V BE support will be "discouraged" (feel free to read
yet another Linus rant in linux-riscv - we're having multiple Linus rants per month).
This means that this work investigation will require at very least a custom kernel that
mainline won't support, which will in turn make it harder for QEMU to properly support
it in boot tests via TuxBoot and so on.

This doesn't mean that we should reject this work, but we should keep BE exclusive logic
separated from the generic LE code at least for now. Point being: the split BE CPU
target, like this series is already doing, seems like the way to go.


Thanks,

Daniel

> 
> The switch to big-endian could occur at the entry-point of OpenSBI.
> 
> Best add a cpu parameter to define a cpu as big-endian, low-endian, or bi-endian and default to low-endian only.
> 
> Best regards
> 
> Heinrich
> 
>>
>> Roan Richmond (2):
>>    target/riscv: Add riscv MSTATUS_xBE CSR support
>>    target/riscv: Add riscv big endian data flag into DisasContext
>>
>>   target/riscv/cpu-qom.h                      |  1 +
>>   target/riscv/cpu.c                          |  8 +++++
>>   target/riscv/cpu.h                          |  2 ++
>>   target/riscv/cpu_bits.h                     |  3 ++
>>   target/riscv/cpu_helper.c                   | 34 ++++++++++++++++-----
>>   target/riscv/csr.c                          | 19 ++++++++++--
>>   target/riscv/insn_trans/trans_rva.c.inc     |  4 +++
>>   target/riscv/insn_trans/trans_rvi.c.inc     |  6 ++++
>>   target/riscv/insn_trans/trans_rvzacas.c.inc |  8 ++---
>>   target/riscv/translate.c                    |  5 +++
>>   10 files changed, 76 insertions(+), 14 deletions(-)
>>
> 
> 


