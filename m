Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537C7C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzP3-0006OJ-Hn; Wed, 20 Mar 2024 13:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmzP2-0006NC-Bi
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:07:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmzP0-0004dr-B6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:07:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33eee0258abso6791f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710954417; x=1711559217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MyCcrivYjVqBSr7a7MvLD5oSuAqK3i8FbSGxytWaAFg=;
 b=eZ9b7mJXOkECsPeETQkxCqDA3KvlDJfWgWPpcPqf5fTBA9W+KhoKNS/zQzJlGosC1V
 3YqEZHx1EL3GdyukYsJxoHlxMe0648/S8fK80mAjbsdXTh1zmc4juAQ4QjA9/nsflDMn
 pWE60YdNQ5FJxHw2b4v9wc7f8hLAKHCoxgMaum1xHZLfE912ED169Fzkvk5UzKQCcWeg
 XcIAAnFFhLA5Y9lY/Qzo2VrELNi95IDK07JGSsRZOQsbJ5urY7Ofy8qNTlikspTfuxL7
 EOxy8KuPpm4K2+xii7rorsvpIAyKqNf3yxzwnGt3EzpOqtUUahaOTQcgwod6tAkDyJVf
 lU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710954417; x=1711559217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MyCcrivYjVqBSr7a7MvLD5oSuAqK3i8FbSGxytWaAFg=;
 b=FGrCFIMAu4Fy3GjaCHGeAg1wWC+iWFWHCFzH7nOq/g64S3anDNH1P2nOTteXyzztdB
 47TGfgoT76OEGhrem9j1Z9AHQIw4ULFUJLXEPLmoVc39SGYTktRdhiJ2XYeinwC8Uaga
 1qOHvGnb5pZaLLBn8X0LPxn+10G9Sim734ZSC2RRJ+1kLp9958kQHWsZ5rQlvc/FqLxy
 0dKB/2cqssOcj53po+UzxL8o4RxgSso0B6y8HEJYbjUcCagogks4aETidpf2GIQo/Y+x
 B6igEIZscxRB480Hmo6kJPpr11yFEQPsvKtqNdhXZiqlZXUa4s6CHii1BXTTjXN/lbvH
 lFvg==
X-Gm-Message-State: AOJu0Yw1YeYm9XC2pcgeS4Mcr5HspH+y8a1M1Y9BQ6THhqVUBk+swWcP
 4i6YfAKuKImlURIebQodYlgodwGU+kOdyU8Xf1Q3j9ubAd6CWEmTmGENy5tMuWs=
X-Google-Smtp-Source: AGHT+IGK8mrBqyz6CHdABPYyI45oap7NpHROkaEOx2Fl4qVGEprNft6ALtvqYYveU5jZI0jyDkUBZQ==
X-Received: by 2002:a05:6000:1e8e:b0:33e:7f51:c1e2 with SMTP id
 dd14-20020a0560001e8e00b0033e7f51c1e2mr1829959wrb.45.1710954416664; 
 Wed, 20 Mar 2024 10:06:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.156.105])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a5d60cb000000b0033eca2cee1asm15176762wrt.92.2024.03.20.10.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 10:06:56 -0700 (PDT)
Message-ID: <5deec986-7a22-402d-abe1-4e40f5bb427a@linaro.org>
Date: Wed, 20 Mar 2024 18:06:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 0/2] target/monitor: Deprecate 'info tlb/mem' in
 favor of 'info mmu'
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240320164055.60319-1-philmd@linaro.org>
 <CAFEAcA81u9J9iijs-CNDbsANb6c0Cdb4qQKmBd=DiQAoFA4U=w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA81u9J9iijs-CNDbsANb6c0Cdb4qQKmBd=DiQAoFA4U=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

+Alex/Daniel

On 20/3/24 17:53, Peter Maydell wrote:
> On Wed, 20 Mar 2024 at 16:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> 'info tlb' and 'info mem' commands don't scale in heterogeneous
>> emulation. They will be reworked after the next release, hidden
>> behind the 'info mmu' command. It is not too late to deprecate
>> commands, so add the 'info mmu' command as wrapper to the other
>> ones, but already deprecate them.
>>
>> Philippe Mathieu-Daudé (2):
>>    target/monitor: Introduce 'info mmu' command
>>    target/monitor: Deprecate 'info tlb' and 'info mem' commands
> 
> This seems to replace "info tlb" and "info mem" with "info mmu -t"
> and "info mmu -m", but it doesn't really say anything about:
>   * what the difference is between these two things

I really don't know; I'm only trying to keep the monitor interface
identical.

>   * which targets implement which and why

This one is easy to answer:

#if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC) 
|| \
     defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
     {
         .name       = "tlb",

#if defined(TARGET_I386) || defined(TARGET_RISCV)
     {
         .name       = "mem",

>   * what the plan is for the future

My problem is with linking a single QEMU binary, as these two symbols
(hmp_info_mem and hmp_info_tlb) clash.

Luckily for me these are the only 2 implemented by more then one target:

$ git grep TARGET_ -- hmp-commands*
hmp-commands-info.hx:116:#if defined(TARGET_I386)
hmp-commands-info.hx:225:#if defined(TARGET_I386) || defined(TARGET_SH4) 
|| defined(TARGET_SPARC) || \
hmp-commands-info.hx:226:    defined(TARGET_PPC) || 
defined(TARGET_XTENSA) || defined(TARGET_M68K)
hmp-commands-info.hx:241:#if defined(TARGET_I386) || defined(TARGET_RISCV)
hmp-commands-info.hx:729:#if defined(TARGET_S390X)
hmp-commands-info.hx:744:#if defined(TARGET_S390X)
hmp-commands-info.hx:828:#if defined(TARGET_I386)
hmp-commands-info.hx:882:#if defined(TARGET_I386)
hmp-commands.hx:1126:#if defined(TARGET_S390X)
hmp-commands.hx:1141:#if defined(TARGET_S390X)
hmp-commands.hx:1489:#if defined(TARGET_I386)

All the other ones are only implemented by a single target, so not a
problem for now.

I'm indeed only postponing the problem, without looking at what
this code does. I did it adding hmp_info_mmu_tlb/mem hooks in
TCGCPUOps ("hw/core/tcg-cpu-ops.h"), so the command can be
dispatched per target vcpu as target-agnostic code in
monitor/hmp-cmds.c:

+#include "hw/core/tcg-cpu-ops.h"
+
+static void hmp_info_mmu_tlb(Monitor *mon, CPUState *cpu)
+{
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
+    if (tcg_ops->hmp_info_mmu_tlb) {
+        tcg_ops->hmp_info_mmu_tlb(mon, cpu_env(cpu));
+    } else {
+        monitor_puts(mon, "No per-CPU information available on this 
target\n");
+    }
+}

> I am definitely not a fan of either of these commands, because
> (as we currently implement them) they effectively require each
> target architecture to implement a second copy of the page table
> walking code. But before we can deprecate them we need to be
> pretty sure that "info mmu" is what we want to replace them with.

An alternative is to just deprecate them, without adding "info mmu" :)

It is OK to un-deprecate stuff if we realize its usefulness.

Regards,

Phil.

