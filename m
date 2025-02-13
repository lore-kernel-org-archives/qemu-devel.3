Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C18C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 17:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticfb-0004yn-TG; Thu, 13 Feb 2025 12:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticfY-0004y0-Uc
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:06:32 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticfW-0007cy-UX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:06:32 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-219f8263ae0so19010495ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739466389; x=1740071189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uGqyG1qJ2lyTou0eJu8FMJBxJTuo8R5Iavag9CSV4HA=;
 b=T0bUzPOgvgj4JXGCPtZeC9T/jwvtvVBFoiToaJnJAQ/xO9nPbHVtNVLdkQVTgSdWvU
 vTrQJzMwU31IMoovTuesxv9JUq4EASe1inqrO+B35tjv5LVXz2VwHUF2jFVMtFpRvia5
 idt5kmwri9eq4ylO7UYMvxDiyJ6Vt5CnO0xHqzx8Rs978n81LZ8NUVjktl4RxZGHYguy
 vjX5KqRYBTeEt2DBdBFgyRVpP4e8pPr6I3AskRQQNn1oi8Zxj/Up9KLfT/Aznp5mkpbW
 bdBvfEzwzfaBy3ZT8fD72Z8EyDpBLpvT0Zr2FVxDOY91b846wG9CgnXZwznOTEKRWzsN
 uWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739466389; x=1740071189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uGqyG1qJ2lyTou0eJu8FMJBxJTuo8R5Iavag9CSV4HA=;
 b=KLAPcrcj4n4nVxd0nb3K2UQsjsXS3ZD+mJ1+WaQy7JSkwKY3kDTcU3d0Qbs6d/o//I
 4G0+JMpkGNZk0zvzdnXKJ+4N1tQJvgSoAbGrpsTe1fW6TdltXWtX2kArEbTerPtl2nU+
 pCDDZbAcgWNdJ2RREfd37fR6Zjp0A61+H/dZSExt80V10CmOxWZmHoQFY1axBVDFZN14
 sUehewftCAwaPhrUj0W7B2bixH7TIjXCOVZBjtKU3Rc9XM+Q7yM/u/rG8vn70NwWW2rJ
 Bcd2u+9PR7RN1nwVeCu5XthaXYiHQVaX7mJfEfKRiXV0sRjACJYJtT7SA93/Fhk9tn5q
 0uJQ==
X-Gm-Message-State: AOJu0Yy6Rx49eA8opAHvZTtZTsVEWr2MBTRzxOld3ig+CjI93oPR5ceB
 1dQwXieqq3ERtNIS8JAfwYfRhkZ9paSncF700x+UAj9SutTxi3w2q7KtEidRA0kw71KPJfrV6eX
 V
X-Gm-Gg: ASbGncsZnfMWbnGGGGZaGZx7yhoMIXRxITlH4SHfPldPHxjn3OUmgwwCPZv2WDOv/H0
 ALla3ogiNkKlu+1tEiLwYl/Zcu7ZXZ7g9noHqAm4qTZXky3V2XQCk8C2uzTG61hk37afmTfHYDC
 1cw7+lFQEv4bzVu5aXN4CkabNlsABkdWV47eDRgcV/npX3uWLDECRZATdA6D/ncNNm7IChCO+iW
 fsgNRW3Kcr4S18FCVDQUYTSTzEdWCwQ1KKF8LTbCrAkHaxQzBkHtlbi09TMyrEzUF+WwEOhGix9
 ePTtWgbxw+6+/Hfs1s+ILyHe9L+wZXzXAS1Iv4aPkRqvOVNCddQbBG0=
X-Google-Smtp-Source: AGHT+IF/NEgA8BQ7+SFJwvMVajg5TuiQFFg82F2P6FCG440yw9+EJb/5BFL7XqnDBhR089yzQq46Zw==
X-Received: by 2002:a05:6300:614a:b0:1ee:6659:29f6 with SMTP id
 adf61e73a8af0-1ee66592ad0mr10046971637.42.1739466388677; 
 Thu, 13 Feb 2025 09:06:28 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242546835sm1511608b3a.35.2025.02.13.09.06.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 09:06:28 -0800 (PST)
Message-ID: <eb211153-6dbd-4113-859a-9fe6cb87e7b8@linaro.org>
Date: Thu, 13 Feb 2025 09:06:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] hw/char/xilinx_uartlite: Make device endianness
 configurable
To: qemu-devel@nongnu.org
References: <20250213122217.62654-1-philmd@linaro.org>
 <20250213122217.62654-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250213122217.62654-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 2/13/25 04:22, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
> DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> 
> Add the "endianness" property to select the device endianness.
> This property is unspecified by default, and machines need to
> make it explicit.
> 
> Set the proper endianness for each machine using the device.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> ---
>   hw/char/xilinx_uartlite.c                | 34 ++++++++++++++++--------
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   hw/riscv/microblaze-v-generic.c          |  1 +
>   3 files changed, 25 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

