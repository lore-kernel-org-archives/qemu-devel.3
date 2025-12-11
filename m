Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449A6D41C01
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 08:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbjE-0008Q7-QB; Thu, 11 Dec 2025 03:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTbjA-0008NF-A0
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:08:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTbj6-0008PR-Ov
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765440519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vodviATWQnP/8u6k6xKhTTKhDnWNFGWcgWh4eEZC9Sk=;
 b=RN6eWELiG+IVbF3xJY15L/c4PL8ErMmuMSqtENOL4noj8ZTkhpeq4mKxxNapSYYbsUvCit
 zD3ohz8RzjgZQowo6euXsTrTBBn+a/Sqs8GcWp2FHt2atE4ZgJkxEd8oz2xqbCs6mWs5Pe
 1CYvpMF44/VfpvRnjQ3U3SvQiq0NKJ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-GfNeVpojN_K-9ULp_5Eteg-1; Thu, 11 Dec 2025 03:08:37 -0500
X-MC-Unique: GfNeVpojN_K-9ULp_5Eteg-1
X-Mimecast-MFC-AGG-ID: GfNeVpojN_K-9ULp_5Eteg_1765440517
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so3741725e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 00:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765440516; x=1766045316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vodviATWQnP/8u6k6xKhTTKhDnWNFGWcgWh4eEZC9Sk=;
 b=ln9/bCBe4K0PRIP+SFLbVSqOwHCXJi+Ox4kzbU1AhcFTCYgaegOhGyp3bpQRm+9jf4
 6Cj6dxoa5+31t2ULp6Q+bpeFFXLGIfiIU5uDw98A7pRH6VR2NaFd41A6AUCC+jxmRuj/
 bbTXNN3tCCMgy7m9q+aBYtP2uqPGxnBM/FsukbBT92zfhIa/ICaEwlYQUFBX/4nQlWV1
 nB3XtAniaATsARxj02tDXe/zHB40oFHirK5jvvtyRnOQPi2U5Ank9PDvXxsSBLCDmVOJ
 ketyirZjbt70BPSMaK9NZahHvU+SlpAc0nb7cikBO6CIT22eBnaGBrf97KfhxnwxSyi2
 JZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440516; x=1766045316;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vodviATWQnP/8u6k6xKhTTKhDnWNFGWcgWh4eEZC9Sk=;
 b=KyXC8JiViQOwry/LESl6gNkrbr/fJz4C15iNAOATiEfqC8ojiVmUVL0AD33VVi37Wd
 Oug75BcWw5zmFU755voIj4pVCpWRkya60up06Y2Wl8Dc/EyD/m2Qrn6FyRNJVKeqZ/uB
 CX4EVRezEMW6lf80SKuKkuopCvbLC/7Vspj/xGLuF/2QEpWVS7ruOqoH3yQyzj0I+fKf
 ao5Pw6sYMRrKJKQJMBwU/7JRYmO7+mmBWjIqQ0eDQMb2+bf5P+5KmbMN8N8LKcHYlo16
 UA0wwgfF+l7Gkvv1GCKq/S/9OF8MNDWERy9O3FqS379/M3E5AR8cu6efE1AGBDnyEhat
 ss3w==
X-Gm-Message-State: AOJu0YyTCpx9a8M2KWYK4UhJTU9UnyDj19ddTVazmWAAaBsKy7udkvcr
 Hpe4Vg620+P1BCaYbyClzFFnA17qavoSK74v9zhj9vTCUsxUOb7VRhLjSyXn8GF30gObC0jnV5k
 BizfpoMd2/c32xl5qNn35X/xTGxZaZLszg4J8hl55tufy33Ncm2s+wHN7
X-Gm-Gg: AY/fxX6q5PMJAK0FqVUw4R9nEIX9XVXv7uZolwfvE1ze3Am/CU/cNfrLrivfo8L7CDB
 hhkABeRuClV//WzwEv8xXZxJJQOBHnndSk84IW4p1GkbNriXPrcHoHr9w8uTrnjOoeALe5QLphL
 Cqo0m07sXqcrsaF/I7B7U57YvSqibrtIcGzJuzaI+OZpZCqdNrzZ8445u3LIQXmO4JYsGMh8jW7
 VFUModuce3l3SEskxG/V9rhray7+5eXjPyp2v11rOr3JeuEBWhF3QdT1WbTaA+3ceF83riRUj8F
 RId3/8wusS1aEAABeAae4ohLVlSjrEDBDRTl48uy0SQHcUgyJWmA40qkozMPlQbFSPyQOwvN2sj
 YUgmzHhxBjXglBvFw1gBBrIg70ahqQTUvWyzT1Ht5AnzFxELR8sTC4BJgzZo9ArcQ9AQ5hZrspb
 0axcdjlPnnB74d+D8=
X-Received: by 2002:a05:600c:3485:b0:479:2a78:4a2e with SMTP id
 5b1f17b1804b1-47a89f9219cmr10460705e9.7.1765440516596; 
 Thu, 11 Dec 2025 00:08:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbnk7m2JNosjwWzc2hpxUHgrfTYSAWgWtGevR9iAHiqGMK15baZuJoytxxvBxNexxhZf/vYw==
X-Received: by 2002:a05:600c:3485:b0:479:2a78:4a2e with SMTP id
 5b1f17b1804b1-47a89f9219cmr10460335e9.7.1765440516185; 
 Thu, 11 Dec 2025 00:08:36 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47a89ef95e1sm20296665e9.9.2025.12.11.00.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 00:08:35 -0800 (PST)
Message-ID: <16e0fc49-0cdf-4e54-b692-5f58e18c747b@redhat.com>
Date: Thu, 11 Dec 2025 09:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] i386/cpu: Support APX for KVM
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20251211070942.3612547-1-zhao1.liu@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251211070942.3612547-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/11/25 08:09, Zhao Liu wrote:
> Hi,
> 
> This series adds APX (Advanced Performance Extensions) support in QEMU
> to enable APX in Guest based on KVM (RFC v1 [1]).
> 
> This series is based on CET v5:
> 
> https://lore.kernel.org/qemu-devel/20251211060801.3600039-1-zhao1.liu@intel.com/
> 
> And you can also find the code here:
> 
> https://gitlab.com/zhao.liu/qemu/-/commits/i386-all-for-dmr-v2.1-12-10-2025
> 
> Compared with v1 [2], v2 adds:
>   * HMP support ("print" & "info registers").
>   * gdbstub support.
> 
> Thanks for your review!

Great, thanks!  Just one question, should the CPUID feature be "apx" or 
"apxf" (and therefore CPUID_7_1_EDX_APXF)?  I can fix that myself of course.

Thanks,

Paolo

> 
> Overview
> ========
> 
> Intel Advanced Performance Extensions (Intel APX) expands the Intel 64
> instruction set architecture with access to more registers (16
> additional general-purpose registers (GPRs) R16–R31) and adds various
> new features that improve general-purpose performance. The extensions
> are designed to provide efficient performance gains across a variety of
> workloads without significantly increasing silicon area or power
> consumption of the core.
> 
> APX spec link (rev.07) is:
> https://cdrdv2.intel.com/v1/dl/getContent/861610
> 
> At QEMU side, the enabling work mainly includes three parts:
> 
> 1. save/restore/migrate the xstate of APX.
>     * APX xstate is a user xstate, but it reuses MPX xstate area in
>       un-compacted XSAVE buffer.
>     * To address this, QEMU will reject both APX and MPX if their CPUID
>       feature bits are set at the same (in Patch 1).
> 
> 2. add related CPUIDs support in feature words.
> 
> 3. debug support, including HMP & gdbstub.
> 
> 
> Change Log
> ==========
> 
> Changes sicne v1:
>   * Expend current GPR array (CPUX86State.regs) to 32 elements instead of
>     a new array.
>   * HMP support ("print" & "info registers").
>   * gdbstub support.
> 
> [1]: KVM RFC: https://lore.kernel.org/kvm/20251110180131.28264-1-chang.seok.bae@intel.com/
> [2]: QEMU APX v1: https://lore.kernel.org/qemu-devel/20251118065817.835017-1-zhao1.liu@intel.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (6):
>    i386/machine: Use VMSTATE_UINTTL_SUB_ARRAY for vmstate of
>      CPUX86State.regs
>    i386/gdbstub: Add APX support for gdbstub
>    i386/cpu-dump: Dump entended GPRs for APX supported guest
>    i386/monitor: Support EGPRs in hmp_print
>    i386/cpu: Support APX CPUIDs
>    i386/cpu: Mark APX xstate as migratable
> 
> Zide Chen (3):
>    i386/cpu: Add APX EGPRs into xsave area
>    i386/cpu: Cache EGPRs in CPUX86State
>    i386/cpu: Add APX migration support
> 
>   configs/targets/x86_64-softmmu.mak |  2 +-
>   gdb-xml/i386-64bit-apx.xml         | 26 +++++++++++
>   include/migration/cpu.h            |  4 ++
>   target/i386/cpu-dump.c             | 30 +++++++++++--
>   target/i386/cpu.c                  | 68 ++++++++++++++++++++++++++++-
>   target/i386/cpu.h                  | 48 +++++++++++++++++++--
>   target/i386/gdbstub.c              | 69 +++++++++++++++++++++++++++++-
>   target/i386/machine.c              | 27 +++++++++++-
>   target/i386/monitor.c              | 16 +++++++
>   target/i386/xsave_helper.c         | 16 +++++++
>   10 files changed, 293 insertions(+), 13 deletions(-)
>   create mode 100644 gdb-xml/i386-64bit-apx.xml
> 


