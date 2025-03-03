Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B748C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9zv-0004KF-9u; Mon, 03 Mar 2025 12:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9zq-00045W-Jq
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:54:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9zl-0000Rz-G2
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:54:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4399ee18a57so30013755e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741024461; x=1741629261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ig1O+P684D2zxZDZEH1iwaJLNZ3uO/yV94Srxs0Fy5c=;
 b=IaxQHXRLlfDIvx0bDIEifkyqqokGVEXrGmFgw2Htth4qDgPtLNCuoogqwafRwwCeXk
 pqLErCjtQENLTbkD9jj+zYKLO4OIbxPFsOuRrVPfiiqH2GmDg3H0t34PiXOIU5uQzT9V
 mYrO4uDmtHFqPEaH+tjbbd6oS7l6/JX2mcQCzeeO5wtt+G93CyL0mOV400g7E1LaSOBE
 9wgy5oCe0NYXTkMfzHYVZIeR6353LODMF1H74UP/U+F3D/5/64W0X5cMbHix5XyYbJGf
 YSlNkFeHsasX67O9gVEI6UmRTWsqMaifVer2sJQ7HJls+OB7GDiGBshgd41WRHBq/Qwi
 qkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024461; x=1741629261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ig1O+P684D2zxZDZEH1iwaJLNZ3uO/yV94Srxs0Fy5c=;
 b=Pi5DpIV2z0R4rLBtTjDBtzZEgoOiIlx6p9KdwkgqugvYQxnatvroUAAMFC6G5616h/
 s/p2z6RiOM2nHMNShcs/Dh8/KOxHpi30mhQB5f+X9iaNc5W1G+4vRpwLI/LhbOjgKZcO
 5AvglFL40WT04M4SkGFkuJrMON8YMi5azhd0bKH0ZBbfs9Xj9myrcKvg8eE3s2EWashY
 wjqmV9zvI7p5Dr69mE4w1Uxaf+AoezRNxqlTjdz4uMwJv3bVzsaxZJOz3bxROabx0F3i
 ZtebLNhw/om+Y9XS8w+jDEwjABvpHtlgw/rDJ4M6Wb5UETCsufY7YCcPMASBLTTc7MTm
 i0gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl67mx/iDNTnga612BLVs+oYQxngsvgCjMtCbKGq739XBTnw0RyKDNeJhQNVrIbNm6OQAzlKJ+pfy5@nongnu.org
X-Gm-Message-State: AOJu0YzNnG3KY8dQ0QxLOdNZ1hkK7qsZuCEA+991QOfXvbr3aUxHP4yi
 +L0oypZyTb3PqXm+jrxbl7YG91hO3Fngx0r0wb3YhFyeZ87TP3ZQ6h9b2RCSsUA=
X-Gm-Gg: ASbGncuA1MU5jQ0dmegnZdDdORcGXS8BoIq1trAav7aqEQriXK9JuFTqowBqRYvgjDx
 wQsEomSw7UIwLstG80bSEcok61yhwzyU/+IH2egXb7GKwKZM0PMLE3m7MeTbVtAdrX1zHZ3o3VD
 QfqZOYrgndw+hOtcG0FH37CX1JFFVCLG8J9J7CmZza+NRY4UbsnGpnSm4AKv6+Qs+sMOdkKIbB2
 xTeAlwIXyw6qCtlGyzZzOAlncl9gd0NaUeavf7v6kheuC8I+zZyouJFtvQUz7YPgm1qwl17xlLo
 5x9bMT3YSl7vVJiATTprg12BKwC5SYEADL7cQtfTtweRqOkglB3QJuJ999R4t+A0+SZJ50+5VRA
 T35oeI034OuU2
X-Google-Smtp-Source: AGHT+IEVstF0P4bQY4ARwaYs70KvMfUdl2n5C4C0g3Wfep2QqgvzIqJFj/x+vUGRRtuSsT/w3yNXEQ==
X-Received: by 2002:a05:600c:a403:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-43bcae04e3cmr1971915e9.2.1741024461181; 
 Mon, 03 Mar 2025 09:54:21 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc2d76c9esm39334795e9.26.2025.03.03.09.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 09:54:20 -0800 (PST)
Message-ID: <54399bc5-2dc8-4494-a501-ddfbabf4699b@linaro.org>
Date: Mon, 3 Mar 2025 18:54:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 04/11] hw/misc/pvpanic: Add MMIO interface
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 marcandre.lureau@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Alexander Graf
 <graf@amazon.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20250112210056.16658-1-phil@philjordan.eu>
 <20250112210056.16658-5-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250112210056.16658-5-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 12/1/25 22:00, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> In addition to the ISA and PCI variants of pvpanic, let's add an MMIO
> platform device that we can use in embedded arm environments.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> 
> v3:
>   * Rebased on upstream, updated a header path
> 
> v15:
>   * Constified the property table.
> 
> v16:
>   * Removed the DEFINE_PROP_END_OF_LIST marker to match recent upstream
>     changes.
> 
>   hw/misc/Kconfig           |  4 +++
>   hw/misc/meson.build       |  1 +
>   hw/misc/pvpanic-mmio.c    | 60 +++++++++++++++++++++++++++++++++++++++

Missing MAINTAINERS update, who is going to maintain this file?

I could add it within the vmapple section in the next patch, but I'd
rather pvpanic have its own entry covering all variants.

>   include/hw/misc/pvpanic.h |  1 +
>   4 files changed, 66 insertions(+)
>   create mode 100644 hw/misc/pvpanic-mmio.c


