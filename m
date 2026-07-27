Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6427AC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woOZ6-0000cq-10; Mon, 27 Jul 2026 12:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1woOYg-0000b1-FO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:52:12 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1woOYd-0005pF-2B
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 12:52:05 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso1655064b3a.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785171120; x=1785775920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KzHFq5Pzqv5CpfdfzPORsybu6IPgnVyY4OYCl7mz+U8=;
 b=ilwY/oR/906Yp3uTJ3n8E/K2bpmfvVHX4ksE4KyTc9KvPuINTKA+3imrUqnF9F6dOJ
 S5Mg7BYQeKwQyVjbbVquL4a6DV+KbihqvDMELCwaopaaCjjwXzjPrhBRsacSngrmewpK
 JLDCOccBuiDDAUuNDhSJ+HuHcjr4nahlKT5FamY2TzrBS4WPBH4ctHoN8ZRv2FBZoowd
 OskXwO2s7103vQEenFONruF7tnJ+PBfthP7+LZ9aBa+cW/vPr5b7n/NNoMl+qq9OkHyz
 IlJThU6GBeUBMCGgKOiM0KKQ3/15+ebrrJXJFA62jiG/4q3XJVkpIRgvBBV/Fs0pLABu
 2vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785171120; x=1785775920;
 h=content-transfer-encoding:content-type:in-reply-to:cc
 :content-language:from:references:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KzHFq5Pzqv5CpfdfzPORsybu6IPgnVyY4OYCl7mz+U8=;
 b=DKEuz3qXWDYXun2h/VsYF4hdGBlf4ID3uhnYmAZRLaQSfXrzUdERarxcazmj6TlICb
 L6/2nIpoWhV78njILghiY9iPoduUmNKPgHQ/AMlHkPJKN+vuteYyiaIR4IiIpN3fAKXv
 y6NJ32oNQRa/w+LQrK4CV7wqXN4ytyaFSjZZN4mUoGDmjsEXDUK+YB1fxDcEAOCngLEW
 9uviJ/MoxOB67otFA0zHxJdqq6cyGcOLR4QIyJrAQ6dXpukqG5CXvtBJmUtuUYxTDFiq
 uCUeyiyOT8EuOso1bQIoCLwKXuaLqj/iY7vsAbpgR5KJLgsJHM1bDE1LY0mcmM6f4LOP
 Syvg==
X-Gm-Message-State: AOJu0YwWoiObb44Cd9daUuXd5G0a6PlZqy9LUGm4uJm+zgyhjNIQoeFs
 zCMLSAYx6zJp3NUiM8UruIh8DERpHKGLFZkGH9mpZ2E6GzXueDS+5NJV7fQ8fhMXsCdfRQd2a2E
 uNCwr
X-Gm-Gg: AR+sD110DygfrpfXUUirQvreAhyi9wIYKvvicCftQUdzrEDD/kxSHVbaidk1vxrQexM
 qUlI+8+IU0flA4EWkjEfojJb6w78S2K6I4kuG5vi0MMa9ltHdV731surmgh4eN8yzt5MdOLCDZU
 HpzkF63Ea/1IqKZDy5Hohca9Udx8SwT26K0+GWSKkqRWU+fN5BKRVY03Ac8hbK9UKd/maqloLhF
 XLGgo4PzXblMGY/LPGoE2rqlzKC2ltAMYAcatSz3RYZdm/hIg0vi2ZMr1GAQmIfWZUU+X65bJ9j
 zSfdOa3jjKLyS59XIQu6JKKp4zqjk01CYzTDqtcumqUcjJaHsp+he4lCre3yRW1GeW0unUxCzhq
 +VXIc77b2kzfR0vq1+1KQSbFLGOzUQX5TbvMAQI7x2QsrSE+Lg14CveRY7swqyz2ob9yvQTXxO3
 8rQw8enFp9Ks/EQHwN8CGMWz/bNwjR45CSqAkpK9tvog==
X-Received: by 2002:a05:6a00:22d3:b0:848:635c:5e8f with SMTP id
 d2e1a72fcca58-84e595943abmr7756989b3a.56.1785171119427; 
 Mon, 27 Jul 2026 09:51:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5327f116sm3338733b3a.16.2026.07.27.09.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 09:51:59 -0700 (PDT)
Message-ID: <877be8fd-af97-4f68-b4a4-31201334c96c@linaro.org>
Date: Mon, 27 Jul 2026 09:51:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/sh4: allow full 32-bit address space
To: qemu-devel@nongnu.org
References: <20260727114848.1041856-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260727114848.1041856-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/27/26 04:48, Laurent Vivier wrote:
> On real SH4 hardware, the address space is split between user mode
> (U0, 0x00000000-0x7fffffff) and kernel mode (P1-P4, 0x80000000-0xffffffff),
> so TARGET_VIRT_ADDR_SPACE_BITS was set to 31 for CONFIG_USER_ONLY.
> 
> However, qemu-user does not emulate the MMU, so this limit is not needed.
> The only effect is to restrict reserved_va to 2 GB, causing OOM failures
> for memory-intensive builds (e.g. webkit2gtk on Debian sh4 buildds).
> 
> Set TARGET_VIRT_ADDR_SPACE_BITS to 32 unconditionally, like most other
> 32-bit targets. Also fix the TASK_UNMAPPED_BASE macro to use 1ull instead
> of 1u to avoid undefined behavior when shifting by 32.
> 
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/sh4/target_mman.h | 2 +-
>   target/sh4/cpu-param.h       | 6 +-----
>   2 files changed, 2 insertions(+), 6 deletions(-)

So, the goal is to run things under qemu-linux-user that can't run on hardware?

I'm not necessarily opposed, though there have been software systems that know that the 
upper bit is unused and reuse it for tagged pointers.  Emacs did so, sometime last 
century.  I'm sure there were others.  Anyway that's the reason we currently limit 
qemu-linux-user like the hardware does.

If you're going to drop that, you might do this for all targets:

mips/cpu-param.h:#  define TARGET_VIRT_ADDR_SPACE_BITS 31
sh4/cpu-param.h:# define TARGET_VIRT_ADDR_SPACE_BITS 31
xtensa/cpu-param.h:#define TARGET_VIRT_ADDR_SPACE_BITS 30



r~

