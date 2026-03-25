Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1E51093168
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5VeQ-0006Sz-VZ; Wed, 25 Mar 2026 17:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VeP-0006QD-H6
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:20:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5VeM-0002Mm-D0
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:20:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso3025145e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774473618; x=1775078418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=plox9j/iUU8EZyl6U0OyV9sIvlUApm1bvH/zFY5odng=;
 b=Jz34jRG5zS5oWFZ0kj6JbYpL7szl6MtfEXE3l5msz/ntH76zRC0kQbz2CjfpupJfsY
 MZIYrDm9Iw7i3MuqRAIM7XHWRjA+asiYnE8rBcy9me9HNcr7i+oAb6nSaiSfiILMZB5A
 Q7jb4GUU2Vl3zRU9KKWu9nYEJEi1ZxaydHuNeQ1/8NdBi/1LkLJtV2eY4U/UmFvnM2ob
 oQ3x4lz4sUxeN0EwZDT1npEgJIzraijGpudR3AhIoSTmZZ9peWRSRTmkC9d46k81Bt1r
 AF3jFFDL0G6x48GL0LC0aPxab56QCPoxDaziHICidWglB+hXfjfjLgzjwInoTsfhgzk4
 Lxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774473618; x=1775078418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=plox9j/iUU8EZyl6U0OyV9sIvlUApm1bvH/zFY5odng=;
 b=Vafo0ZjfTIo5/QOq8dAeorkb8q4rd8/HESOqfBuZaQEsnsxQk2FmxhNwyYRrJ2cJfs
 imMEcWjLTAwMaVhzvIA7YMwcSgK/6jam3s9bbzQxK5TIpW9dTCwSiGu8Z3jFT/Jw/ei+
 ZppXc8sAMM1Sn3ASZAtVrYgFyXJYnnaRN9fAjK3Sp+FPoVbwRb38mfZP8t7Ou4VwlIyv
 lJv0mNIeiArKYoNapv09nIwX8hM/p5qDvbfCdbQFMK2tlmvzssdOvr5PPAhgPxEDUYId
 eJIM73FEUEwouYGE4ZvF1Ga5qCPv9YZCwIqiXoM4unF3ozz24I/4aYhvyjM7TmidqIHP
 vCvQ==
X-Gm-Message-State: AOJu0Yx/eIh2sUA21MRBkrlQLkf42/255+0E/5QuXlRoRZH7LoXj3xMM
 NvS87ydasT6N6FKD30L3NuWMTpM9HFbImAovKyE9zDa7LkIcBXxeTeqc+DD+MlxZJQBMqHui5oo
 iGMLRqp4=
X-Gm-Gg: ATEYQzzQpwmd+E56m3WJiUea+nBuSeNj4yFnmMN7SGMdgEu6z4onEKVTEAGAWK5Los3
 EnZFmUXJ2DdcgByZN021CYw+EzedxvRMkSFiQgn5TkNVYAeSBCjZS75YoEwNbNKLTuH7r5ZG1dx
 AvS3e2rTnGYQ/r/yuqqXe/VqF3RKvVhzjC+MEUAYvOR56ZGEAYJhCaWrbeEp1dZYSNvYQoZYI4e
 2cyMKrBmNME12gyL4DlDScBe4AOreWHqAehyaTPxuWFOODvU1zuqQtXxZGvarQ1zEXBK1wV7fiv
 Nlm3AKrL49TxjGuK1SR7+PHgbmc+lJiVRUD4agpTokRGyqE86sPFJUprTg85rny3EUBk/4QE532
 ISIQ4+Pv09kedouLQFuEvFOs9j8s1hfj7xKppYp6U0RoQ/b+r9BlfnEYsQ4hmqALBzpaHJVgcGu
 jkVeyTVztxlQK6iUk8nFeaoQPD/ifhFsQUoyqc8/cVsbIue9oer5qhpuT/BI0KozbGvcUR7mf+B
 gmV
X-Received: by 2002:a05:600c:3490:b0:486:f8e9:add5 with SMTP id
 5b1f17b1804b1-48716042c08mr76276895e9.19.1774473617920; 
 Wed, 25 Mar 2026 14:20:17 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4872090368dsm340605e9.5.2026.03.25.14.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:20:17 -0700 (PDT)
Message-ID: <54ddb814-5ab4-4883-b855-29a356bd8fc8@linaro.org>
Date: Wed, 25 Mar 2026 22:20:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 10/10] migration: Restrict legacy
 VMSTATE_UINTTL() macros to few targets
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-11-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260325211728.89204-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 25/3/26 22:17, Philippe Mathieu-Daudé wrote:
> Only 5 base targets use VMSTATE_UINTTL (MIPS, PPC, X86, SPARC and
> RISCV). In order to build a single binary (preliminary step toward
> heterogeneous emulation) we need to remove it, but it will take some
> time. Add a temporary TARGET_USING_LEGACY_MIGRATION_VMSTATE_UINTTL_API
> definition to keep targets not using these macros clean while we keep
> cleaning the last few targets one by one, preventing legacy uses to
> creep back in.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/migration/cpu.h              | 24 +++++++++++-------------
>   target/ppc/machine.c                 |  1 +


> diff --git a/include/migration/cpu.h b/include/migration/cpu.h
> index 05a1ddde343..4c8c9c34cc8 100644
> --- a/include/migration/cpu.h
> +++ b/include/migration/cpu.h
> @@ -3,25 +3,23 @@
>   #ifndef MIGRATION_CPU_H
>   #define MIGRATION_CPU_H
>   
>   #include "exec/cpu-defs.h"
> -#include "migration/qemu-file-types.h"
>   #include "migration/vmstate.h"


> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 49cfdc6d674..f6169a128dc 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -5,6 +5,7 @@
>   #include "helper_regs.h"
>   #include "mmu-hash64.h"
>   #include "migration/cpu.h"
> +#include "migration/qemu-file-types.h"
>   #include "qapi/error.h"
>   #include "kvm_ppc.h"
>   #include "power8-pmu.h"

Oops, this change is part of patch #6 "Inline qemu_get/put_betls()".

