Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1243CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdWd-0001np-Ig; Thu, 28 May 2026 12:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSdWZ-0001nd-Ut
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:24:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSdWY-0005Yd-Bf
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:23:59 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36baec934b6so160303a91.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779985436; x=1780590236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1CmlDw32A5+2Pto4vqUfWR06vY0nitO5ujz+6xcc8/0=;
 b=R5si87jn7Kx/d7ft6/E/IrNzct74LtFQjjobJQa6Iz2GPHxyrnQQCiFr5QzXXlrofI
 w/QB713e9gLNzLfRwrLAP4NBMyEwFFG78g+ZkUilTfFMWCQaHznkfEcnnuCAYgpv0JVk
 luD0NYk3NdrwJthdIQi3nptzPZV+/i1nGO2vvphYhumQbxK7BbkcEqiUhnnQUtWV7dEA
 URFsowv+sEYFI2ljeS5I0EFCvUG0guiDfQ5M3HiDehyWzMP1mowcIrksKl/jmwt4NyIl
 9Lir0eUaCTNoQFjlSub15PbVsTgLIHOkFERpr5EOEQeS+8zTc+T5avXT/XpsD56q3f7h
 eQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779985436; x=1780590236;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1CmlDw32A5+2Pto4vqUfWR06vY0nitO5ujz+6xcc8/0=;
 b=ZRudhyvsbZm2KF7xeziet6keBZaz/AIUhTKnNMKVAM/D7LSR9qPHeDztZNeVGGX/7B
 HhFoZhtPMEsFCgLD7Xy2geZC0LpHcxVPu1jBTcsWeSyD6DzQP+OKwY4qg+uLK87PjtBd
 2JmeunAwPeFQiZ5U0oleYlLUYd0OXgyE7FrUB1f0QsCsHgV7GaPE1uBQJnufgDj9YsVH
 84jT24Ccg5ZqYBpkwrv+Xu8ztlu2uYt3P7AaTKiK3Vvt53kJTCvC+Jo35QHecHib1oKN
 0N08RTSSjqoSoN3UylqSJYzrVlCo5qcxu+witZZFTbPGFylF0+qfLyBzoHFFY0aTheBj
 PK2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iLXobbrkrp/GW707GG6K/ivQmnLlrZ+3MNAnI4glaG9ivLEcf0cZTZti2BFEKOCRefDDsNj/7DgZw@nongnu.org
X-Gm-Message-State: AOJu0YyIrLg/vn3nTZPhgZxqLbMpnVp8xzRObGxEDsYsJYL2J32Aw8UO
 wjq5t4D1rYYkNSGLesUmXo714Mg1H9cFJwATLPANYWH9cgJRK3jXpTUgxBnBjgIIDEM=
X-Gm-Gg: Acq92OHH/VLDc7WBxqHFnL2f5yAEuG8UOuvnJqnN9Xhz5DpwrWegMtGamzn5AfbyBT0
 LaFOS800kJgYBN/x8eCHKH7vORLCrhQX1dGypPAVIqUXI14o1JeIO2mFoAkzrgxkxk5blYaO7Gf
 2fBqNswy7GsT0U74EyOW+UUlK/SYpgPBMd/CMa9t+gx62BH0BnKdCnH5Hh4IJAnWqd5CrcHanSc
 B6WowAj3N8MtPOP9XcHlZLWcKYP13wUCjwDPXj5l8W74rhVyL8aTqPZDjcHMBMpf+oH/L3c7ta5
 NH/ngQ0TRaGiR7dcu7FF3uQfK6h5ae3xhlQlIwHF3GXNi98/9+iEwuPd4i4oupyIn8gI0UcdZ2/
 yqCHS1jv37b3tNmJzCfOA6jOU/GdppJlaqHT8sjju7MjUz6e93cUmhiwXozmOJGTVLLYYGGMSZg
 61CdqGfqqvTJs0CuZT1OyW98f0mcR7ref4gelyjQ5craf3Gbs=
X-Received: by 2002:a17:90a:f945:b0:369:9469:aeba with SMTP id
 98e67ed59e1d1-36b9c6dcb75mr1635663a91.1.1779985436226; 
 Thu, 28 May 2026 09:23:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b90be1699sm2444666a91.12.2026.05.28.09.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 09:23:55 -0700 (PDT)
Message-ID: <376b8bc3-d377-4363-8a83-866a0c05c708@linaro.org>
Date: Thu, 28 May 2026 09:23:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2] arm: add wfx test case
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <andrew.jones@linux.dev>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, "open list:ARM"
 <kvmarm@lists.linux.dev>,
 "open list:Default mailing list" <kvm@vger.kernel.org>
References: <20260527111822.1563679-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260527111822.1563679-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 5/27/26 04:18, Alex Bennée wrote:
> This is based on a similar test case I wrote for QEMU's tcg tests although
> obviously able to take advantage of kvm-unit-tests additional plumbing for
> dealing with the GIC and IRQs.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - drop TIMEOUT in favour of computed 10ms timeout
>    - add comments for each test
>    - use sevl for local clearing
>    - set gic irc depending on CurrentEL
>    - EOI the GIC
>    - display elapsed ns (no float to do ms ;-)
>    - fix some style issues
>    - make test TCG only
> ---
>   arm/Makefile.arm64        |   1 +
>   lib/arm64/asm/processor.h |   7 ++
>   lib/arm64/asm/sysreg.h    |   3 +
>   arm/wfx.c                 | 187 ++++++++++++++++++++++++++++++++++++++
>   arm/unittests.cfg         |   7 ++
>   5 files changed, 205 insertions(+)
>   create mode 100644 arm/wfx.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

