Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66689C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXXO-0003ss-P5; Thu, 18 Apr 2024 15:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXXM-0003rr-AE
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:35:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXXJ-0000vA-TL
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:35:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-418c0d83e61so13542695e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468906; x=1714073706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W3POXLkXOEegSIr+CiLoNV+e6nPI439irSo27x6wQYk=;
 b=GXs9f9ThV+NrUmNdSx1K8B1hoxIVf9iE20OsYGJQUhkvW8cSK9lD47oPhhIKIPu0jh
 OEXfNBKaY271IdiEaXrcGFXYnzp18T/EwiP6XRaCngdUQ6GEFmYDXtTJRyihhVcZR6iq
 iDMAYxHxVdqM0fghhZ/5jOsDk0HCexp0516BWRA+T4+IQ3+tTDPp3j39JIctbwn2Gl8m
 2UekLebE/rYEWa7d9gJAUQ8mDxG/3X6ao80o90ie/s6KhBVLP0GDpnuk4GVej0XECNSY
 nRvtESjN7pHjzYXhYt13e8jIKovPwS6W413r/9QRmy42EK0wBjsXPLi4UlLoFgyHBLjz
 4lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468906; x=1714073706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W3POXLkXOEegSIr+CiLoNV+e6nPI439irSo27x6wQYk=;
 b=KHdPMDjEWvLAsptmO9lNPPcSMIZVHR3dnH7fLX18FP94IafgOX5bD/It5njLixx0VK
 L4OTEBfFmjzfvFuncSWyB0ZAzYEnYydhjfeUsQZhftdlIP3pFZ5yIXGf7/Q80vwAHbtX
 hBTk9QsDI/ozjXtcLEKFbGxYvxyYfn7MB1Kozs246Kcz7jOM23oiy70d0dVb508MvKeP
 714fEJhZAnLGu8ME05TykRG54WUxXNO+UO7pvsKYZE4GBQMyfR2hvShnI+U5+DAPYgpy
 qS+Suh3JhfHkN/Q/5smFZ4MGBv0USD9gwRV6GneeLwqPw8CE4xmW7WV+vw9lGo5qtIvP
 76kA==
X-Gm-Message-State: AOJu0Yz6udC4hlCgnaLutqXeSJrAfKkBaDW92/SzjqB6spMMeKU4ow8z
 ttVnbPX5WY+cCsNHxjAh8CqLGTiDwl/CcOrac+XuPA5d2/tqUbvDKHmlBYvszJQh/+CJwxlOdSq
 C
X-Google-Smtp-Source: AGHT+IGMCzmEnXnVD4o31/C0VmlviDxbH19sLaVnp9L+a0G+U6wowTv37MaEj2AIuCUCXbCDxujMhg==
X-Received: by 2002:a05:600c:3511:b0:417:f527:21d0 with SMTP id
 h17-20020a05600c351100b00417f52721d0mr3869169wmq.0.1713468906643; 
 Thu, 18 Apr 2024 12:35:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05600c444b00b00418d5b16f85sm3747438wmn.21.2024.04.18.12.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 12:35:05 -0700 (PDT)
Message-ID: <a75b20b5-995c-4de6-81f8-78a6f58d12b8@linaro.org>
Date: Thu, 18 Apr 2024 21:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] include/exec: Rework (part 2)
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240418192525.97451-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 18/4/24 21:24, Philippe Mathieu-Daudé wrote:
> Reordering exec/, second round. Mostly splitting:
> - TCG LDST API (to "exec/cpu_ldst.h")
> - CPU TLB APIs (to "exec/cputlb.h")
> from "exec/cpu-all.h" and "exec/exec-all.h", and
> reducing inclusions of "hw/core/cpu.h".
> 
> Based-on: <20240417182806.69446-1-philmd@linaro.org>
> or https://gitlab.com/philmd/qemu/-/commits/exec-next

And this series is available as
https://gitlab.com/philmd/qemu/-/commits/exec-rework-part2/

> Philippe Mathieu-Daudé (24):
>    exec: Declare MMUAccessType type in 'mmu-access-type.h' header
>    exec: Declare CPUBreakpoint/CPUWatchpoint type in 'breakpoint.h'
>      header
>    hw/core: Avoid including the full 'hw/core/cpu.h' in 'tcg-cpu-ops.h'
>    exec: Restrict TCG specific declarations of 'cputlb.h'
>    exec: Restrict 'cpu_ldst.h' to TCG accelerator
>    exec: Have guest_addr_valid() methods take abi_ptr/size_t arguments
>    exec: Un-inline tlb_vaddr_to_host() and declare it in 'exec/cputlb.h'
>    physmem: Move TCG CPU IOTLB methods around
>    physmem: Restrict TCG CPU IOTLB code to TCG accel
>    exec: Reduce tlb_set_dirty() declaration scope
>    exec: Move tlb_reset_dirty*() declarations to 'exec/cputlb.h'
>    exec: Move CPUTLBEntry helpers to cputlb.c
>    target/sparc: Replace abi_ulong by uint32_t for TARGET_ABI32
>    exec: Rename 'exec/user/guest-base.h' as 'user/guest-base.h'
>    exec: Restrict inclusion of 'user/guest-base.h'
>    exec: Move GUEST_ADDR_MAX definition to 'cpu_ldst.h'
>    exec: Include missing 'qemu/log-for-trace.h' header in 'exec/log.h'
>    plugins: Include missing 'qemu/bitmap.h' header
>    gdbstub: Avoid including 'cpu.h' in 'gdbstub/helpers.h'
>    hw/xtensa: Include missing 'exec/cpu-common.h' in 'bootparam.h'
>    plugins: Un-inline qemu_plugin_disable_mem_helpers()
>    exec: Remove 'exec/tswap.h' from 'exec/cpu-all.h'
>    exec: Remove 'disas/disas.h' from 'exec/log.h'
>    exec: Remove unnecessary inclusions of 'hw/core/cpu.h'


