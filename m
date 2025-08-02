Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7E9C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 22:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiKMU-0003wF-EU; Sat, 02 Aug 2025 18:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiKME-0003oP-An
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 18:05:40 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiKMC-0001VC-OM
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 18:05:38 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40a4de175a3so1970480b6e.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754172335; x=1754777135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k9uKq6xA14v+AN58VKziWQoyESt4P2RK+Q1pFNRX0qc=;
 b=LvN8kDE/6TT8e76e2Ubg2Bs/82kE/hRqIUE6dEDBGRzz5tZGuCSLJAaCv41VaJiztC
 0k3XmuTHGtyfWmsTrLzaOa+zBVVbPNK4KxuHWwB184UFBumL/GjuCbslJj/sWWwr7YTg
 KWJmfN9eGvobGs0jSAWch6yw4oAgJF6sfKSO8y8ISOSWYs6zV1SUbp8NMyknTL2QoHxI
 fes26bt/ZWhXC4AP7Zk585iD7AO06+6G17QZdSuw7DUYhSFQ4emg51y/yE0bpczSznNU
 +m9N5GzWCBEdeGuKeqAdsLFvFOxME7AaY9dL4hpP29EUzYYgqnipqxy7f2uK6XnIrwsA
 ufaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754172335; x=1754777135;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k9uKq6xA14v+AN58VKziWQoyESt4P2RK+Q1pFNRX0qc=;
 b=Rbg3hO1cVLe0vfCowQ4RQ82VT2TyweNDWVmZRWICDh9VA1xUAA2HU5sxTJtsluVOwZ
 BcKdmzSR7mFFGpGRRcG1p3N9iQUWx/4iVqCZvpFwxXsKCRRB0OFCXBo1HOe8sKRTG0xV
 K0u4LyZ5oc9jClKCl8apowPUDu5UE37+z+y6P7qzcSg6d3/E6G3DnsAXe0H1rHTIS3qF
 wOHrDmFxvcG8iZlwog13svWgGQE96RZgKRKfPFsz/556iTsQatdpZj1JOuMSEVZFLCqa
 bokUvQCzio6SV+yjZz05urSSxl52v/yARa+aEEGG7tCOOuiZaBMCwUe+pZJQd3z8b/HQ
 FUIQ==
X-Gm-Message-State: AOJu0Yxj5rs2ckMmRnKw8jDf1Mv/piDeTPd69804YWmz9LRWPdvglXa4
 vIBB5L0e1aKXD5CV+IagejjxKzE3Z1jO1nSOm6f/4halaTT6kMYgsfb9ePdDrqPMK7C54P6mos3
 9DubT/FY=
X-Gm-Gg: ASbGncvTfEViSsp3GijNwBjVHIBKumkq4uQoN7BeBZRB2kVdXK2BBBc415kgAb4C5jI
 RMlKe9nfv7HMFm2p3MidUnBZHBWzoCOIw9WYlsQknn9a/4FUEXxlV6AJZWaQMMFILowFfbiMyXD
 rPNOpHkcdj1SN7nFCA71zzbRKjimbby2s9GAhJHkNbmUJBYiiBsL+nugyu64OAMezZ7mKJhAiji
 izz5DQbAeUILiLbqciN2pJzLGYAOP85hlpwlv4YlViM1rOVZImvR57K0SKToB0/T9lcuk3imh3D
 MMYTezLsyWQUbOoZnY+xy2mIW/jNZngMzmco3kb0BEBlcfhLHGEAeCk5hIsldgzGRN9uzh3MYCj
 vZI0scMmMR0QJbi/lcVKePhiSS+bdeVf2HJOYvd3W87rO2FtrVmf7J9aiomeK0w45
X-Google-Smtp-Source: AGHT+IG7a2gl1CIWPWS1geA4sVpk0w6hjhSg960YJiCNddrLsZ8OyE70/5WYwC+n/YGfQgbAVyTH2Q==
X-Received: by 2002:a05:6808:318c:b0:434:231:3e2c with SMTP id
 5614622812f47-434023142ebmr270379b6e.0.1754172335161; 
 Sat, 02 Aug 2025 15:05:35 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43358892a94sm1430007b6e.17.2025.08.02.15.05.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 15:05:34 -0700 (PDT)
Message-ID: <fb436336-49d5-4378-8cb7-39c61f5dfaaf@linaro.org>
Date: Sun, 3 Aug 2025 08:05:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 65/89] linux-user: Move elf parameters to
 sparc/target_elf.h
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-66-richard.henderson@linaro.org>
 <CAFEAcA9QQn6X83HVWh-8NZOisgqDZgQQ866X3m6OhrCE-BVzog@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9QQn6X83HVWh-8NZOisgqDZgQQ866X3m6OhrCE-BVzog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 8/3/25 06:28, Peter Maydell wrote:
> Why does sparc share 64 and 32 bit in one header file with an ifdef
> when the other archs like mips and arm have separate headers,
> by the way ?

Hysterical raisins?  PPC and RISC-V also share a header for 32+64 bit.


r~

