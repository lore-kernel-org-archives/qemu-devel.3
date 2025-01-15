Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27881C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXveW-0007vR-DG; Wed, 15 Jan 2025 00:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXveS-0007v2-M7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:09:14 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXveR-0005cb-5H
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:09:12 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166022c5caso98384905ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736917749; x=1737522549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j81ajV+WsLkHQ3+QO0P0QCAhW4tueuuVcsUpbYB/3iU=;
 b=Cg1QnAD1INb/eHAdkGiD+LN+ByIJOVDMDDGKjTWBqpO/tA0KgkdxFFMCwka8r2L6mW
 rlZJyUd93u8yjFlv9hAgto9zPcfW54Wa8cOadkSioInL8XaBhi62MIZgaROllEwglyIm
 na7yQD2i6fvEeE7qYbz8zIfGZJH5NZGsU0eQIHgfUClTUGfo+/2U3W3Iw8qoY5SYp26x
 ZkMyKFMLwAS2XdTG0oTPBp7bX2wO9yXKhFbqO6rPait/BesHmhSnrCUoSc5d/fcqQuee
 zUXgSDDU+3aO8lO7OXG23bElwJFA1SeD5WQGjxTNTg6ZfPb9BAbyc8/aNX1PmhBba/qG
 sVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736917749; x=1737522549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j81ajV+WsLkHQ3+QO0P0QCAhW4tueuuVcsUpbYB/3iU=;
 b=soag6gmxefPVWY5bw+n1RjeGBTIwIt0yH+q4QRUTbuf7BlaxWPACs1AJbhZ7thkGEV
 7x6xAANfNF9FELebuyC/J0E8GN6BGrxdJusFGTAV2KvVGdt5C4j3MnrF2GJk7poJ5V7w
 mFEGw3ynXYFVBSS2GvS9m182LWbTnlLOeZYA2B5mDx1fgE7YyWi8n3HPC6xCYQbg4p0I
 LXTbGNsyBs3ya8gw6gSu/Rj3jQYDXqO4qJZbz5Z/xvL4rr4/DgVoGGHw/GXbDd4TpTFs
 JL3jkyYaILSW9IVVl5zE/zpgvhsfLJe9KJP1D5Rt0xdIn9EPQfdih+NBoFsdwJkbs2Kq
 HzLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM3JnQLSO2dv2nlOIOFZ0l2Vr6a/2sLtGXiH6jfXDKLBH8bQdl8zxfSp0aydbThgmvpx2Tgc9D8ysB@nongnu.org
X-Gm-Message-State: AOJu0YzA8eQLLE0rLNKv+FbMJOE+HYFG6mv/Dt5MI5qhzgqbBuMKARDF
 oLhbEwycfgXrNdr2TOnwLH51JRrej9Oyo591UNPQFK6w9MHK0LB/gaBeoQre6Vk=
X-Gm-Gg: ASbGnctTdfjh6ELdnpC59Vz9HNMEwjCse4rFpb5druECSsMXQK+qm+P4mH3Fkc7Yg2F
 epzOTWHwMC5l6/GEriFSngo4s2AT+XzmqqbNPRg+u0RCzvddR5z22xz/aFEHYXpv1J41OCfc4ve
 PV6FE/BDZooDnEO/v93iq1AhvIEfGfNijvux55KHThHwXcwaCcBm+b0tXMIr+SC/IL4ik34HPHb
 HxLlMfEQfJSFmMNQVQolxojdMKl4Dw4Ke+xe0tUshFzoC9UGbJdApldvQrgLVr0mFwF3vqaUjYK
 Qa3TdJgRlOpSXyfSamIepco=
X-Google-Smtp-Source: AGHT+IH5xmPj4YURh0vZR9Uktx/KTZJmFe29PSlW2Knu4KTCclIIpCzdyiQeRb/so5xY1/WOSJO/Ag==
X-Received: by 2002:a17:902:e5c2:b0:215:b33b:e26d with SMTP id
 d9443c01a7336-21a83f55103mr459731155ad.21.1736917749325; 
 Tue, 14 Jan 2025 21:09:09 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10df7asm74631835ad.47.2025.01.14.21.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:09:08 -0800 (PST)
Message-ID: <47ea0ea1-a9f1-447e-affb-73f92b310787@linaro.org>
Date: Tue, 14 Jan 2025 21:09:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] hw/mips/loongson3_virt: Have fw_conf_init() access
 local loaderparams
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> 'loaderparams' is declared statically. Let fw_conf_init()
> access its 'cpu_freq' and 'ram_size' fields.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_virt.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

