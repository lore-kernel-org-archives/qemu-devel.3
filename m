Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9750CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqxW-0002nD-NE; Tue, 26 May 2026 08:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqxV-0002mi-C7
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:32:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqxS-0007W8-Fu
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:32:33 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so77380665e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779798742; x=1780403542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ssgQG3fy9ijB9USyv7gfkCiMt1v5cI4feeBTpZdmhEo=;
 b=Q5tYmwDt2Td+CdDVtmY8VPgm0JguRpvNXkSf5lYEUsgmJKJKVCwvqgkGw+n22aBzRS
 nI4EndjRNUh/OvxqPqkAldYKSM5GOPztl2/0OTBHYS/wpUFewKLa5WP83ssJ9PYQ5RU1
 HqPWW4QkbrSas44nGYAI6ib07jQjeNrOSjnZwEZDM9E6a54V+RIAXq7QIVXxoDmArVEF
 +bykft49gDtILZzK7amcTN0wYg9fJH4DtL36x0fx3wGbqFqLQqRWeBu1/SpST/M1r/kJ
 2214Qym+YgpehVCjbuJo8XbvfIJJO1aCET9uOJ8dYZJh/gJulB6gy5SAiTmBP202s71t
 LwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779798742; x=1780403542;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ssgQG3fy9ijB9USyv7gfkCiMt1v5cI4feeBTpZdmhEo=;
 b=cosovx61OPLEJ00ZcdeGbxo7cUtgN9vfTLnK7mcXZREjkOPLq+LHbMfVd+q3j71HUK
 K2CmsgE+CPN0eALHI0xL+xvC7ILIU5jQ7KgSh8pFllkMBsq23zh0bgnECz/KsW4wy5+j
 iyGxQ0ORWhwPofF2dkH7iNt2mwTrc+l/P5VRUpcRUCrALwS0ieKrG+uuX5ORmw+hkZsE
 G9Zm4U4Zzn2aqowNFBGegsmieVmhduu4PR/ODr7XfhS4HZE+4Ae1FYleO6eQLIOws8UZ
 RCqBwp8FKUBt5tayw6Ur+5qymwKzgwWphlsu3zRH3p81Or97kUqrdH3vgcJMzJ3ez/wu
 /jYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OqP3ld0wNccSJEttX8c8dHqKLZOrJ9Sc1vIqcQu0/u/GkvDsDBwNE6QxTI/f0I/vW4RYjuVrFyeJq@nongnu.org
X-Gm-Message-State: AOJu0YyRq/fQ8SmB828U1Q29G8S0mnLk6suyU01gqbpWUcxuhRm4Zwif
 9igISkRzEOaT8cB9YBClULAyBxWPtXwrxaJHnQZOebEyWHK9uYoVHs39PVIQoDrJhPk=
X-Gm-Gg: Acq92OFIUlKzrMyMowuFEjaeCC/2x2eW1I0I3ka073xM2ANmUeTSinEgqIh2edNB7gW
 S6cSlzB2BTXTTzDtCWVftieukyCVDk8s//c+pDNHLRfa2nxUheW6bl9jS5aB+zL+1eMsM+Hzwh4
 Ed+TnVLlUapMfZUYi7Rp5uAXLkOB3SC8QYUV6gYu1QCmTtMCkbxXN8lhDyjucGBqBHctxsdwSN3
 wZoXyZOn9X6SUUjOlBgpRiuW/F507pMwTTalCSnf4/blf3NzIWL0iixxGGQXb3p2Q1e5YEI/C0F
 8bzduJ30DWm8ZAfjBp3M6hGMnRSBR39Lsia88ePuDEc4ud6peS7ZVyZwY/UQkUcT8ua5CmVPje4
 U+SY1nDv6ila09snk9rnY9IkT/waHWieczi66NdeqqWjh7V8etf1d954hWxzlVmK59XFIfOAtOg
 Kh+XT4dVfdHpwQrVSZYxKhh8HNoyDSD95U/+eMVIXsJU6VWRxZHimVLH8v/6XjAzGhDQ==
X-Received: by 2002:a05:600c:6217:b0:490:44d0:11b6 with SMTP id
 5b1f17b1804b1-49044d01257mr305544565e9.12.1779798742444; 
 Tue, 26 May 2026 05:32:22 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490424b5b80sm154315225e9.6.2026.05.26.05.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 05:32:21 -0700 (PDT)
Message-ID: <8aea0965-300b-4393-bb4b-cd8239aee597@linaro.org>
Date: Tue, 26 May 2026 14:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] target/riscv: Fix no-TCG build
Content-Language: en-US
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
References: <20260526024454.2013810-1-fritchleybohrer@gmail.com>
 <cover.1779792111.git.fritchleybohrer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1779792111.git.fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 26/5/26 13:04, Zephyr Li wrote:
> This series fixes the riscv64-softmmu --disable-tcg build by keeping
> TCG-only files and code out of no-TCG builds, while keeping common
> helpers available for non-TCG configurations.
> 
> The first patches move common helpers out of TCG-only helper files. The
> later patches reject x-misa-w when TCG is unavailable, provide a no-TCG
> stub for riscv_cpu_validate_set_extensions(), and build RISC-V TCG-only
> sources only when TCG is enabled.
> 
> Changes in v2:
> - Split the original patch into smaller logical patches.
> - Drop the unused tcg/tcg.h include.
> - Add a no-TCG stub for riscv_cpu_validate_set_extensions().
> - Keep x-misa-w rejected during CPU realize when TCG is unavailable.
> 
> Testing:
> - riscv64-softmmu --enable-kvm --disable-tcg --enable-debug builds
>    successfully.

To complete this effort we need to add coverage. See the last patch
of this series (which was unfortunately not merged back then):
https://lore.kernel.org/qemu-devel/20230711121453.59138-17-philmd@linaro.org/

> - riscv64-softmmu --enable-debug builds successfully.
> - qemu-system-riscv64 -M virt,accel=qtest -cpu rv64,x-misa-w=true \
>    -S -nographic reports "x-misa-w requires TCG".
> 
> Zephyr Li (5):
>    target/riscv: Remove unused tcg/tcg.h include
>    target/riscv: Move fflags helpers to common code
>    target/riscv: Move riscv_raise_exception() to common code
>    target/riscv: Reject x-misa-w without TCG
>    target/riscv: Build TCG-only code only with TCG
> 
>   target/riscv/cpu.c         |  8 +++++-
>   target/riscv/cpu_helper.c  | 53 ++++++++++++++++++++++++++++++++++++++
>   target/riscv/csr.c         | 11 ++++++--
>   target/riscv/fpu_helper.c  | 27 -------------------
>   target/riscv/meson.build   |  9 ++++---
>   target/riscv/op_helper.c   | 15 -----------
>   target/riscv/tcg/tcg-cpu.h | 10 +++++++
>   7 files changed, 85 insertions(+), 48 deletions(-)
> 


