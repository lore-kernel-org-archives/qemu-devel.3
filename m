Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EE9C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9WN-0008Cj-3b; Wed, 15 Jan 2025 14:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9WM-0008CH-5k
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:57:46 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9WK-0004Me-DG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:57:45 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so158706f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 11:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971062; x=1737575862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+lwDNfaw1hUUL4y5FqmyOvCm5+9BT713Hl+8038WI3M=;
 b=aPDtBPMJfKoykHq8gUCjiC1P6RApauK/KaCmBhUXCKQZljAVNomi4ZmSlRwANQ1KQu
 +2J7f2zsstHUY2SeUEgEXhjoOZVnuEC0ap3UKsblhVFpp17lJPIB4NA+vCdNSlSnLLec
 tUGf2S+WWSWh1RYwmN9UWoBMIVslYAqrsLkXzzEFfkuMYUNfWzpb/Gsq52ogWz9nB3DI
 7Zi2w65LL01fnv37BJcL5J+sHzlAGpTGTyIB9QANT/zguQg1tZVVUajue7+6/S30CEEe
 epMr1O4tAbFyLz8QWxrnnQBH23fa682f/XB8vXh/qZqGGsFRgmJdcj8AfuUVtvCJ7F86
 hlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971062; x=1737575862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+lwDNfaw1hUUL4y5FqmyOvCm5+9BT713Hl+8038WI3M=;
 b=mCEUE4AoXLtRxgFeHkLKYEFoXPWs7wa0H/USfmC4z41KDRL6MmZOYcOCfI2vuWyswy
 8bZ+X/t1F+iMWSo8jQBmEHWtya2XtnHdCcHiXZUshjhqUj0smEU3NIDJ/qUti5jpZNqA
 XPvSY5kE1fvL6AWT7ayOEJaA7ZKEDRAoYYcxNMPeFjYPhOgJOfx/0emMHvtDHtB9VAOf
 8xNm5BL8QcBmhQLyBmEwzig91ASb+zFn5SyJQRKjrrUuXb2b0+ozNPtVFvoKXbXJRoE2
 itVIBOp8mf5HVoJnt8RIMQwVm5s/fDsir+hMldMmf/nz+TlE929IYabEPa5x6qr05VKt
 c5yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9StAlMhdlXL4jYqjKMiIAlcD0KhdhGM7hzDxnK2e5ugPFHh0trAF3DMpmxifF2WqOUrYLVrOh8VUi@nongnu.org
X-Gm-Message-State: AOJu0Yxku30jHVSbP9oRxX/BENkLLNVnNoh560sjvSehCYOcVGcNs1uC
 dvVJIH61ml85dDvMzj1upFn5CKQeW1BJ5W0w4wfqsM9/5khB6/848PslEdE5aQ9efPIxi9GbeZ/
 /JEE=
X-Gm-Gg: ASbGncv3aAg+acKLaB+4l5nlqibsn6dNfo+UfBlbRaoHK4b858uYRY52TiNZfxfzNM6
 2Iigq1VdmQRQHwF6C1+XANDwt3eN0K7cl1Azlp+6VCncQ5xcxWt3Efw0THiGrcU6DLx6aoTKUNY
 tABiQf6OkVZKPWJDl5IK4v3/JQcp3c2rrFReOP2KbjP8T8cUwaN5SeXl5vbnSS+UUY/DOByqO6e
 SeT7YWOj/rb38305D6722q288796ExSj2ZfDTrIGct2ETc35sUSa+9n0mGKYrw6027oe+/zqrPx
 nYHL2oam+oyAUxqbSyjKMvIh
X-Google-Smtp-Source: AGHT+IHgmIUJ9YDUzXItrR0qG7l6FY0CywtweeA/IOiNsmZ9nYS+r5N7MNXTbBmJqcWDlwzROFDGUQ==
X-Received: by 2002:a5d:5f8f:0:b0:38a:2b39:679d with SMTP id
 ffacd0b85a97d-38a87313e2cmr25612019f8f.32.1736971062075; 
 Wed, 15 Jan 2025 11:57:42 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7527fd1sm34201505e9.31.2025.01.15.11.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 11:57:40 -0800 (PST)
Message-ID: <bdba5477-ebcc-4081-a8c9-63be7227932f@linaro.org>
Date: Wed, 15 Jan 2025 20:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/81] tcg: Remove TCG_TARGET_NEED_LDST_LABELS and
 TCG_TARGET_NEED_POOL_LABELS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Make these features unconditional, as they're used by most
> tcg backends anyway.  Merge tcg-ldst.c.inc and tcg-pool.c.inc
> into tcg.c and mark some of the functions unused, so that
> when the features are not used we won't get Werrors.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h                |   4 -
>   tcg/aarch64/tcg-target.h         |   2 -
>   tcg/arm/tcg-target.h             |   2 -
>   tcg/i386/tcg-target.h            |   2 -
>   tcg/loongarch64/tcg-target.h     |   2 -
>   tcg/mips/tcg-target.h            |   2 -
>   tcg/ppc/tcg-target.h             |   2 -
>   tcg/riscv/tcg-target.h           |   3 -
>   tcg/s390x/tcg-target.h           |   2 -
>   tcg/sparc64/tcg-target.h         |   2 -
>   tcg/tcg.c                        | 211 +++++++++++++++++++++++++++++--
>   tcg/aarch64/tcg-target.c.inc     |   2 -
>   tcg/arm/tcg-target.c.inc         |   2 -
>   tcg/i386/tcg-target.c.inc        |   3 -
>   tcg/loongarch64/tcg-target.c.inc |   9 +-
>   tcg/mips/tcg-target.c.inc        |   3 -
>   tcg/ppc/tcg-target.c.inc         |   2 -
>   tcg/riscv/tcg-target.c.inc       |   3 -
>   tcg/s390x/tcg-target.c.inc       |   2 -
>   tcg/sparc64/tcg-target.c.inc     |   3 -
>   tcg/tcg-ldst.c.inc               |  65 ----------
>   tcg/tcg-pool.c.inc               | 162 ------------------------
>   tcg/tci/tcg-target.c.inc         |  12 +-
>   23 files changed, 216 insertions(+), 286 deletions(-)
>   delete mode 100644 tcg/tcg-ldst.c.inc
>   delete mode 100644 tcg/tcg-pool.c.inc

Simpler to review using --color-moved=dimmed-zebra.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


