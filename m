Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D39FCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeqx-00008Q-65; Tue, 28 Oct 2025 04:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDequ-00007i-GA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:14:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDeqq-00024n-Id
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:14:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-475dab5a5acso19156045e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761639280; x=1762244080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lKvuGIPao4f9b5Yh5dVFJwIsUfYoVzIrWUWcl5K/AmM=;
 b=cKqd1X8JxQ7IQTCLHM7UffwEMEe7xrZq42ezEsBjK8wYH9zmICVyEEUi1o2PGpW4GJ
 PhnOovncoIbMd2l/h7EpFWtEkSkJ2R2FY5XmgN6V/nrq6O72Dad8T+X6NtaPYPlyDyPM
 Rn2v+kcZ9yDhnUSCyEWrdMvRqglQyLutL6Z4G8zyOP12oRVvJw8uKVCnDIaa1VB++4Oq
 VW0eIcQC5sTAXnk/dWqAWqmRzXN9Mo1U1Av3ae190bRASUMzezVMX9C/PLs2yDOpiQYi
 yUaKTBjh1ptNYczY3FdmuxWHiLNR/Sk9JhKGcc6fLFFG9G7RQln4IleOnLN6RnatPBLI
 /IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761639280; x=1762244080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lKvuGIPao4f9b5Yh5dVFJwIsUfYoVzIrWUWcl5K/AmM=;
 b=c4I0lo1iwX9fr+Gf3rkOTl5Fka5CrQgkVQfpshRekiQh+cJC0njdzsbeOyd1ahLIun
 nDK5D+SV2DOzMylpN3umzi8ydoj3UhsYCVobK7j22d8HqttuLF005xsCgy5fZe8tVASN
 mBhdZQpCbdvUrTjS1cfHTZzVVtqpTQFrKljXdV9liDYb7QrOgQlFtJeZdOVetzi/XeST
 YjQJDlh3yAlGBKxlD3bsLacgDiStrTLrALbh685C83r0tSadrgwRBcdG4T/HaJL+ZoYe
 vqrCxKr7OOoRwW7jiwByAW+25RBVmhmgLF448ty5DwiGoQA5X+ePyhfgDUSO7jPGVGEg
 M2ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbZtMYqMCACeDkVDMFgdHatu8UniQhqEOGw8H6TYqMNfW5bGLoojtt2k3Jj6StQtA8ymSo1B3cgpRB@nongnu.org
X-Gm-Message-State: AOJu0YwC7J4HVDWEwcEOxENnQ1Gh+roYRQn0y6PDsyYXYva8hTB6Noic
 mm15u41bPFPqAua3KGM3mrmgGxbeOBfX7pEoIDGFhpnUcyRtcZAjJFN2clUHEj7A2Rc=
X-Gm-Gg: ASbGncvwKPDN1xlyEA6fn1Ut/Zc+FIuDw6WdPIwH/blYrhxY6TwqA59Xcjoec7ABOpO
 dN7uEoHlmbQxBs6wSXqLx2BrWvJyw7SzmZgmLUk2Hml8UoLWwwK1aalBorkYBgB/0xXdVcHtQLF
 FG4+6AxzgwrVVF7x9VoDs/Bez8azwsxEgaCJ2TzcaRGzlMqNgkl9saO4KxGem5YwkYZ2W66ssAa
 t8FFj+rtfdfs7ElHI3V5xXdShn+OZSlNJ6rUyHc0vV2CkdSr9BLSCZXKRjt6LfyREffM8uPihgK
 7IO1Va1uAS3S/LbcsZ9uiBCpAzPsfOJK8rOUQZ2z5LeUsPJq+L7d/T1zhZj9AlZbPVBvy0ZJ1yh
 mVivcsyGVBk1yLNlfrOHBE/fgKrNKVMD/sEVmcEdPqbGSbHpG1kGvvPFj0RrUcLCxY7fnZ/Jh9h
 YfCa+2CP8a8rPnZl0kedYvR+7v45KFrJnhg0N2YsAcDK72UDoT03RSMu4Qq45srUAr2Q==
X-Google-Smtp-Source: AGHT+IF8YR3P4AFJuBH8rZAKfxMdRYj90i1kX74WA/6ZN85rDPHprtgaN/2P3TwCSbMoiiucyyF+3Q==
X-Received: by 2002:a05:600c:5295:b0:477:1622:7f78 with SMTP id
 5b1f17b1804b1-47717e67bfamr19382905e9.40.1761639280533; 
 Tue, 28 Oct 2025 01:14:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718fc0335sm13694415e9.2.2025.10.28.01.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:14:40 -0700 (PDT)
Message-ID: <004ef76d-1f3d-4800-b89c-3cf0ccad9d01@linaro.org>
Date: Tue, 28 Oct 2025 09:14:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/33] target/riscv: Combine mhpmevent and mhpmeventh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-6-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251027181831.27016-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x330.google.com
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

On 2025-10-27 19:18, Anton Johansson wrote:
> According to version 20250508 of the privileged specification,
> mhpmeventn is 64 bits in size and mhpmeventnh is only ever used
> when XLEN == 32 and accesses the top 32 bits of the 64-bit
> mhpmeventn registers. Combine the two arrays of target_ulong
> mhpmeventh[] and mhpmevent[] to a single array of uint64_t.
> 
> This also allows for some minor code simplification where branches
> handling either mhpmeventh[] or mhpmevent[] could be combined.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h     | 10 +++----
>   target/riscv/csr.c     | 67 +++++++++++++++---------------------------
>   target/riscv/machine.c |  3 +-
>   target/riscv/pmu.c     | 53 ++++++++-------------------------
>   4 files changed, 42 insertions(+), 91 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


