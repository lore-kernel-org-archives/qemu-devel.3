Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775CEC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpek0-0006zP-WE; Tue, 04 Mar 2025 21:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpejw-0006t2-IK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:44:10 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpejt-0005Sr-77
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:44:07 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2feaca4e99cso9306544a91.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 18:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741142643; x=1741747443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o2Ug3tUV9IwrQJl5zjSG50mMrTM6oxZUpEBTlcmtjE4=;
 b=iaRAvU24e5KMjUhk0O19pKZNWWGUnepH95edYzmOSJRroQNavKNoyMoaps1O8ymqhS
 cZ/YRpk2QDgaYZ8wAEr6ZfsTLYYK3Z/D8ErDPG42PMnTdGOGG+g8d4ziyv6oCBhYlnbz
 uyBVYduqXnbSc42+s6pWIK+08CjtOQLjt73CvDv9bYmBKKia4h10pXehFKcKN5kYFiYQ
 uIP3w0jVfJiNu/AZ8b3DyFyIUPMxeXggT7JKwpXQtI6ofSJAXaRF2l5r14ALmePjyYO6
 l3ChNj0oR5x1GluToSRqzswom0VGTkkMWJ+lPwt3k784IfW39CLDuQViP7zSMJU1mfiW
 SRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741142643; x=1741747443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o2Ug3tUV9IwrQJl5zjSG50mMrTM6oxZUpEBTlcmtjE4=;
 b=ckZ+zHKXdk4ZtRWf5hbCrR27t0A621sFkN+t2x9qWRbFvk5B69C1J8jHZb24rOypR4
 XTFBpjVqLyZm6U/3JU82Qqlfb5Iijf3qo9kXry5i+1e5FADUkqZJZHxhm3UyoPy7gcQ9
 5Hkx+DCWhVdnkRXG51SKnutNSpl1EVcsp3hng23hA8TimY1WvGigQ6fq5m+YHeALIVCj
 ZqhYs+/RKKFvrwGIqbYSn3ILrMUk00Ic+Aa1PabuAkquWv4qfotCzl8nJzZrAL1i8kJI
 SNTNhjogzcyl799xKH9XqnBDqv7n3KoTRANFqWq1Zk75B3Tfi1Lp8JSZoGFx3gyEOcGB
 7xWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUxrFx7PKcsp6Htn69PfxaNeNn/IyCWTBwbTotnhaqvGsG4ENoA+ZHbVZjxVYS/BZtttZFIC+a+zry@nongnu.org
X-Gm-Message-State: AOJu0YyYLPj1znGZNSAUW2dvl0zl9ZRO1CuoJtPcLHWUjcKzvTqoQi8Y
 B9d+nPOXzXE9qwIAfjjkSt+htdmvbdEhlAlNCuLDbAEv1K+Yd94FJy4mIHCSCjo=
X-Gm-Gg: ASbGncu+ckO/jYI0IuuH/f0cf313qNjkdHE3Sge4KKYZaNT7fmJlfh6B1qw6HK+2B04
 Wkd7PhaUQKnpH2Ni4nzV6TkdJhEO7f6QWcddDBrsx4LFRJeoNjejbe+4nbEcv3eapT/TgyFyZSW
 hNvNrDBYb1a7xK1Ce/bALSuzGtz0G4o04pK68fpvf5wX68LIwoV8ddFrqjow03v7fY7O3eBetPW
 GwBP3VeqnrZ6Os94Buf5QIdjOKmb6XSAsKiHiJeMFy7dPa4AvGHnFff+9J1bIM6ImoKMPlmoml/
 xlhbw7kHtxSY6M/ZPFhd8WGvHFFjPKzBwPFf+G9THCk1hPef2WP+DzdH8KfD8B50Xidbsw1t5bD
 5jRMhpBam
X-Google-Smtp-Source: AGHT+IH3niQR5zhnBqFOI5bAzBUpvRDTk6GG3Ytk7gndj/F5+2LsagwV1b+Dq28TJsukkBHWWnqz8g==
X-Received: by 2002:a17:90b:2703:b0:2fa:f8d:65de with SMTP id
 98e67ed59e1d1-2ff497a0022mr2296092a91.22.1741142643583; 
 Tue, 04 Mar 2025 18:44:03 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e78a9b6sm179084a91.21.2025.03.04.18.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 18:44:03 -0800 (PST)
Message-ID: <32bb3c05-b7c5-4ab1-bcf9-8a7b9e35fd8b@linaro.org>
Date: Tue, 4 Mar 2025 18:44:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/11] include: Declare target_name() in common
 "qemu/arch_info.h"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305005225.95051-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
> No need to include the huge "hw/core/cpu.h" header to
> get a simple prototype declaration such target_name().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h      | 2 --
>   include/qemu/arch_info.h   | 2 ++
>   arch_info-target.c         | 5 +++++
>   cpu-target.c               | 5 -----
>   hw/core/machine-qmp-cmds.c | 1 +
>   system/vl.c                | 1 -
>   6 files changed, 8 insertions(+), 8 deletions(-)

You should mention moving the function as well.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

