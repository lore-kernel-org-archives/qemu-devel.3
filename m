Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E0FC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 11:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4fKw-0004Nj-4o; Wed, 08 May 2024 07:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s4fKt-0004NL-J9
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:19:47 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s4fKr-0003Jy-7v
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:19:47 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f44dd41a5cso4020646b3a.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 04:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715167183; x=1715771983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gCLkNHnQR5gaqfpPrdts8sooQemk6IkawiF4M/4uCFc=;
 b=GKNUpAvD1D8NY8MCXXIWEzOU4U/jm55v4wr8wxIdLWZAOFv8VOGsGGsJN0Y0KsvAhe
 gCOs0alRcBBxpIa+3YoGDUuwLCXE49IyAVAk1biKjrojxWqxqyZp7B9NB+4MsdqVt8J/
 m7gyLlwnB+FyfQaMBCGJKAjOh0sDfz5X6S90CrxnEJw/QNcnvQfogWJrlhDqo4jR08rV
 cqG1eHu3x+EZ8RcZc5vkrR8QPDZK35oxUDblsW9XeijCQZTGiOrKM8SG+x/8xX8b96O6
 xe0ezHHPRLxV0qp8a+DYyEkekLBkG0PsuKI63OqP33f3v202ZjDX0tORWKqwWZ2b1Zc3
 oNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715167183; x=1715771983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gCLkNHnQR5gaqfpPrdts8sooQemk6IkawiF4M/4uCFc=;
 b=DayTdbXOTwuEEnzdqAS36mDXvB7b0xAT1S3HQt38w5zOEDX1AGeUmBDQPVEXqzkPsu
 TClLLiqKbB17wuMGeVdFyfUavy8TthTVv3SYLI41EVIE3IyyoXTKpfwfew3WlbNa9bow
 aNehbH/AsNVkNLhkRZOg0DMdNJSMk7m2iTd2tgIc0bmvz9Wickat9AMsBAajsuRGtAXl
 y6/oVDfrD2Nmu0CjJnebSEMjRIjcLkgsKR0Mv8qH+yXkEquFyckGvtzSt17znZe9srg6
 Xn/HBilOIKoVM0GOqBprDwUy2m0w6YeESuD3uMJQpm4rAvAsDRBCZNYPHcJTNAKpmfVk
 oWZw==
X-Gm-Message-State: AOJu0YwDPIB4e7u9J9KT+Ck925GRivj1sOSsBB8a7ivGTzhrELzrbtsH
 16bjKe8v/6NWbNNBfNw4emu4YyBqGowBKXJmIqfDynxJAnq0+tZiMkEAHZp5hQY=
X-Google-Smtp-Source: AGHT+IHrBTlgsBxVr5J9cdEs06TmYmbw67vpZO+PrQlTzZdlxaFrSLLS9Z2LJQCoEcCGgA+HU8zlxA==
X-Received: by 2002:aa7:8641:0:b0:6e7:4abe:85a0 with SMTP id
 d2e1a72fcca58-6f49c2223afmr2515015b3a.14.1715167182738; 
 Wed, 08 May 2024 04:19:42 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 fh37-20020a056a00392500b006eac2a25631sm10890764pfb.129.2024.05.08.04.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 04:19:42 -0700 (PDT)
Message-ID: <2819c24b-c3ae-41ad-af8a-f06cceca3a1c@ventanamicro.com>
Date: Wed, 8 May 2024 08:19:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] pci: allocate a PCI ID for RISC-V IOMMU
To: Gerd Hoffmann <kraxel@redhat.com>, Frank Chang <frank.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com
References: <20240503124244.8804-1-dbarboza@ventanamicro.com>
 <CANzO1D0g=AoPkyFS_5d5mJwmwDX8hpaj0fjeFy9xt4xi70fh1A@mail.gmail.com>
 <d4wsa62chc4dgxeakmsimk6tsvxhflgbofgbugpfjyyo5xx2oh@urgime5r4wqs>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <d4wsa62chc4dgxeakmsimk6tsvxhflgbofgbugpfjyyo5xx2oh@urgime5r4wqs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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



On 5/7/24 12:53, Gerd Hoffmann wrote:
> On Tue, May 07, 2024 at 11:37:05PM GMT, Frank Chang wrote:
>> Hi Daniel,
>>
>> Daniel Henrique Barboza <dbarboza@ventanamicro.com> 於 2024年5月3日 週五 下午8:43寫道：
>>>
>>> Hi,
>>>
>>> In this RFC I want to check with Gerd and others if it's ok to add a PCI
>>> id for the RISC-V IOMMU device. It's currently under review in [1]. The
>>
>> Is the link [1] missing?
> 
> Yes ;)
> 
> Also:  A bit more background on the iommu would be great, for example a
> pointer to the specification.

Fair enough. I'll add a pointer to the latest version of the spec:


https://github.com/riscv-non-isa/riscv-iommu/releases/tag/v1.0.0



Thanks,

Daniel

> 
> take care,
>    Gerd
> 

