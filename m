Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9602CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x24-00025B-Nr; Sun, 28 Sep 2025 15:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2x22-00022Q-2A
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:26:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2x1v-0003dG-KT
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:26:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-27c369f8986so38193795ad.3
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759087546; x=1759692346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wfc5ngXBTiwh73m/5BvCkFXJWtRE2nKm36+gsfgqflU=;
 b=fP81/VQMd5GHQVVsVVba+dQNJi7SDzyuYVZEoxy14g/UtGJpuW6YsBvDRZsa1+BjkF
 Rte3PO9Aq2idNvFie3jW5EZbJ5tyu/u9uQb2gBxis2P+Coj7BaPs/huhFPETeK5Nr/vE
 Qu459KWXicJf6NEXy38qtqiZhXiXiwKlzGQnBj8feXVG5W4IK8VoAfOJkdHCwifdnK72
 nND6+lASMI2tqbxYzth8zuIpztZP5x5Ab9rivEibvBaLY22M30lihYm97vXlYzL5qFS5
 4PKVVUR4A+IRxATmBsNUStMjIdH99aXU2HjGeb1taD3g2qUQAG7Fc6+DMzLAVXBX5eGW
 YVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759087546; x=1759692346;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wfc5ngXBTiwh73m/5BvCkFXJWtRE2nKm36+gsfgqflU=;
 b=NaH0IpCPFS+QaI6FcP8r+pya1KALr7hP5d0wy5YPTVxv/SHgmhLikxWLUxpE8E2Pkt
 hmmpPyqePn2QGrl0oVAHRLLlQ5Pw2iYfr16kHOlPcpSvKxgb64j1849WCVRjalIizr7s
 QPIHNMOE4mEKFSaOS5xo6+/zDeouA9hd5J8xp0jVL65rLZCHpCC6UMkCQJ7uzQ09Zv/D
 aC1sTC7q803EEJDiPdHtDDlzXp/a7zNSrvNGRA6FQqEPEO05n3mbtjJt8AtfaYh8wna9
 CjfthbIk6xc15ZSxSRythrvrgvDYdIDeiz3l5wPjbFTG61/gvJ/hzUIPQDo52K2SBjLK
 3OMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuNyNzpmKCwL/UELLm8GiV/zIMMPKHEtDPA/O4QRhyW/zzeq8Tr5dR3nc0oDARqWwuThNvao7Igw5D@nongnu.org
X-Gm-Message-State: AOJu0YyspfSQJV5epdb1wx/NBE26zt+ZkUadu+i4G6JU+8xuyQA/q9/k
 THzpVIMu4+zZnCvOFCE9+I9yWGk1v93x8ViUvt6f+smra18o83y/WCRx4fKoEooDI63v0Xc/Gt0
 1MdIr6nw=
X-Gm-Gg: ASbGncvMlbcmpztD/WHnl1gVaQJ/c2LCjNNN7MQdvb7+l/3tfYvmhLehKXz1I+83swU
 CZ+UDSRJaD6JWUwYRc2UFePM/QbtfxtFfE8Zq3uUpDNKoVL+m7kWA/x/KlCs6MmcIeceIPBVnaJ
 oPe8U9FIInjTd3fksTTe6lueoHWX2DNXs1bbH492LM9oIe2AyWInbjXmij8CZ+eOwhLd2YjFn4i
 x2vR/2RVs1j35mBB03FT4j/ZuZwVnsx/7tI0Z7KpJiF3pohYMG5gInvieIl50fH6nWY1iujA+p4
 vC5x5CQXFOMPpqo2VYBmEgsJ+8+27poCebEsAx8IvVTSNuy2aAfeDXs8Nvsgnfbafd+0dT4FGkr
 gDV+sxMQjLs8FNltvar/JZsuaQigzfpcYzdBM86MwAibN83k=
X-Google-Smtp-Source: AGHT+IHxpIgo1WoCfJLN/RkcOIC79rI4cRquS7EkG4r3jYKCxbbKsLeO3KxUjAXydBENMWO/IDFuyw==
X-Received: by 2002:a17:903:2407:b0:24c:ca55:6d90 with SMTP id
 d9443c01a7336-27ed4a7448emr163336285ad.61.1759087545635; 
 Sun, 28 Sep 2025 12:25:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ae693fsm107278565ad.152.2025.09.28.12.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Sep 2025 12:25:45 -0700 (PDT)
Message-ID: <eacd65dc-cb7d-4871-a69a-6d95252923fa@linaro.org>
Date: Sun, 28 Sep 2025 12:25:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] loongarch queue
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20250928084728.1972177-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250928084728.1972177-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/28/25 01:47, Bibo Mao wrote:
> The following changes since commit d6dfd8d40cebebc3378d379cd28879e0345fbf91:
> 
>    Merge tag 'pull-target-arm-20250926' of https://gitlab.com/pm215/qemu into staging (2025-09-26 13:27:01 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20250928
> 
> for you to fetch changes up to 8d26856fabf8faac60de03a2e0fc35e5338e248e:
> 
>    target/loongarch: Only flush one TLB entry in helper_invtlb_page_asid() (2025-09-28 16:10:34 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20250928 queue
> 
> ----------------------------------------------------------------
> Bibo Mao (13):
>        target/loongarch: Use mmu idx bitmap method when flush TLB
>        target/loongarch: Add parameter tlb pointer with fill_tlb_entry
>        target/loongarch: Reduce TLB flush with helper_tlbwr
>        target/loongarch: Update TLB index selection method
>        target/loongarch: Fix page size set issue with CSR_STLBPS
>        target/loongarch: Add tlb search callback in loongarch_tlb_search()
>        target/loongarch: Add common API loongarch_tlb_search_cb()
>        target/loongarch: Change return value type with loongarch_tlb_search_cb()
>        target/loongarch: Use loongarch_tlb_search_cb in helper_invtlb_page_asid_or_g
>        target/loongarch: Use loongarch_tlb_search_cb in helper_invtlb_page_asid
>        target/loongarch: Invalid tlb entry in invalidate_tlb()
>        target/loongarch: Only flush one TLB entry in helper_invtlb_page_asid_or_g()
>        target/loongarch: Only flush one TLB entry in helper_invtlb_page_asid()
> 
>   target/loongarch/cpu-csr.h        |   1 +
>   target/loongarch/tcg/csr_helper.c |   5 +-
>   target/loongarch/tcg/tlb_helper.c | 205 +++++++++++++++++++++++---------------
>   3 files changed, 131 insertions(+), 80 deletions(-)
> 
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

