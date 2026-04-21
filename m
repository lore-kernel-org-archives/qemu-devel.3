Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD66F94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJUb-00049l-Iu; Tue, 21 Apr 2026 18:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJUa-000498-0h
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:22:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJUY-0007Y5-5M
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:22:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so35249215e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776810168; x=1777414968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BAq2gyUqg3Ed/iVfZisi5D1so/0DHxlWPok1Kar9AII=;
 b=xVBU3rf3skbJSwU7ZsYJjhKvi4rUwOLIzYGmO8XFbQTBje7TnKkCrpMAZZyg1kKOMh
 xtg7PNvb2HZFU6548O1CyM7R8CbfDbsNYP1SOQn5s3dteTIDo7lNXY+OLTw/mIoBljhq
 APy+kSCPDYO+sXmJz1nJwOTBWo4J8n4duQcvalfl9x3O1MSIsMziVZ77MwPYUsUYL2fH
 ztU7uO09/MNDW60u1xM9l0Mze7Qo/KtXUWaxwuYZGM7a0ktJih94zgJOc/R6vqAvMk3N
 sc31wea3xIlTVLqv/nNCDR1dLHO1xfdQoCkr0ggFKI2GaM1V0DFuFJX+3AQ5ccUOHswd
 npDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776810168; x=1777414968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BAq2gyUqg3Ed/iVfZisi5D1so/0DHxlWPok1Kar9AII=;
 b=I+cd/K17XeaWIqskgaIeoptaxlp0WsLKGZjK7lLrXlTDu9EPQcDkXx0ANKaCxfzDL/
 bWJrt/BIlo0kwRenhu31SQ61jR6k3CNyjyxOXCQHbPowu0cAIFFClsDVPKSnak/JjX0E
 BPdT+9+c7K/Ma1rPTjn9j0GJpxyee6Qp22t6x+DdiWLgxCVsxdcANyVK8jvGx7DChzw5
 joSr7iZNT/lD/EyG3GWU9vrFUdidB+WoId+QSDBZ/pNqRiezeoRSlGu353PZOsqFlA6O
 AjU0Ar9st6M2pGw8EpfvgRbCxDf1tPty9RDWUoIUrIGyc8/hO/7tuAHFqcum1AFpCkrt
 RoLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZUJ4Kk2R03nrY6fn+NoFl1+EUr+PuOK43qC9KDNieq4LlmlM773hpd37kYHtaymGFqiQk+63j7z50@nongnu.org
X-Gm-Message-State: AOJu0YxpMgzCiqTyoI5fxuEm9tNYm7F+iglLnq0+N7muLjae2wmUnKRJ
 7nN2hqXKrCoseEyrBlq7Yts/4pbFMg6B1g9Ev6im5ESEnfbN0V+bIJr140b588OXOl4=
X-Gm-Gg: AeBDietmDPzb7gNBm04J2tSLT+gLg4yMZ3VTef3QfvGbiBa5lohNIzxanj2PwmpKqCz
 Iduc1Dw5tO+MNEq+R4YeM6kohmXRAxihvkBaENp51lFTQbTY+szxGjWjvJuu27Nj2L9iCZtSpAZ
 Kd0Fw+vKA+wQS/0A7M6earyZJcoUJdaWnkLPYD8xu/G2vMMhjgG/pHlKwcuta5Ht8Yq8M3lDsBG
 8phMsCwoJN63ZqR9FiZHh3uhsC7bk256uvfyb4jXwmpvaxODaGsXcxFaITtLE7N11a5iS6ehas7
 dMvurlq9PwSUBZ5yjE9kSPuWGN25vpEx2XW8KpTfQJMb3Ywtr+pPY7oGxJBYbsYvNyJqq4HuX0y
 +Ylc/cJCCQmAqoey6m3U2YG5Cd1xRHhktqufVpMd4IBI4nK0zDTqAg2Ahww/pwn0PDiJ5L01nSR
 IH/LqIUOL3MwCu5Bxe2fciWu4LsbeBVRi5AfBnN15dhkJo05NQuLMLIQ7vAs7ekNNFT/DBfwGLN
 Z6h
X-Received: by 2002:a05:600c:154e:b0:488:9ed3:1492 with SMTP id
 5b1f17b1804b1-488fb74fc02mr280369975e9.10.1776810168158; 
 Tue, 21 Apr 2026 15:22:48 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a525a0b1asm64647405e9.2.2026.04.21.15.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:22:47 -0700 (PDT)
Message-ID: <005262c8-7ac4-4bbe-9b69-39ebd8fca2f5@linaro.org>
Date: Wed, 22 Apr 2026 00:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Defer the IOMMU translation and support access_type
Content-Language: en-US
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 Mark Burton <mburton@qti.qualcomm.com>
References: <20260421162912.3295598-1-jim.shu@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421162912.3295598-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Cc'ing Pierrick & Mark

On 21/4/26 18:29, Jim Shu wrote:
> Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRegion"
> 
> Incoming security protection devices feature more complex IOMMUMemoryRegion
> implementation in the CPU path than ARM MPC device. For example,
> RISC-V wgChecker [1] may permit the access with only RO/WO permissions.
> Consequently, the IOMMUMemoryRegion could return different sections for
> read & write access.
> 
> To support such IOMMUMemoryRegion behavior in the CPU path, the design
> of IOMMU translation must be updated:
> 
> 1. address_space_translate*() must now pass the access_type to
>     IOMMUMemoryRegion.
> 2. Since IOMMU translation results are too complex to be fully stored
>     in the CPU TLB. we will defer the translation until the actual access
>     occurs. Also, TLB is allowed to store the untranslated IOMMU region.
> 
> To implement deferred IOMMU translation, this patchset introduces the
> following changes:
> 
> 1. tlb_set_page_full() no longer translates the IOMMU region
>     immediately. Instead, it stores the untranslated region directly in
>     the TLB. A new slow-path flag, TLB_IOMMU, is introduced to force
>     access into the slow path when a region has not yet been translated
>     in the TLB entry.
> 
> 2. When the CPU utilizes a TLB entry in the slow path, it should perform
>     the lazy IOMMU translation of the access_type first. The resulting
>     translated region and access type are stored in CPUTLBEntryFull.
>     Since the slow path always performs lazy translation first, we can
>     switch the CPUTLBEntryFull content to the correct access type before
>     use.
> 
> 3. To accelerate memory access in the fast path, lazy translation can
>     update the addend of the CPUTLBEntry when translating the region to a
>     host memory region. We restrict the IOMMU region to have a single
>     non-zero 'addend' across all permissions. If a second 'addend' is
>     present for a CPUTLBEntry, QEMU will trigger an assertion. This
>     limitation is sufficient for security devices, as their "secondary"
>     region is typically an IO region used to emulate device error
>     handling when access is rejected.
> 
> 4. To support non-slow TLB flags, lazy translation can update the TLB
>     flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation only
>     updates the flags for the permissions specified in @prot. This
>     ensures that each access_type of a translated region to maintains
>     independent TLB flags. For example, TLB_DIRTY of memory region will
>     not be "polluted" from other permission that translated to different
>     region.
> 
> Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
> feature.
> 
> [1] RISC-V WG:
> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> [2] RISC-V IOPMP:
> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/
> 
> Changed since v1:
> - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
>    translation until actual access in the CPU path. Provide a IOMMU
>    lazy translation function with the special handling of 'addend'
>    and 'addr_idx' fields of CPUTLBEntry.
> - Fix the checkpatch warning.
> 
> 
> Jim Shu (5):
>    accel/tcg: Pass access_type as an argument of tlb_set_page*()
>    accel/tcg: address_space_translate*() will pass the correct
>      iommu_flags
>    accel/tcg: Provide early AS translate function
>    accel/tcg: Add IOMMU lazy translation function
>    accel/tcg: Support IOMMU lazy translation in CPU TLB


