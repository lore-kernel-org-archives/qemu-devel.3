Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361F5E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMpDX-0004tx-MX; Sun, 15 Dec 2024 09:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpDW-0004rp-B7
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:03:30 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpDU-0002rx-Un
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:03:30 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eba583fbe8so781358b6e.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734271407; x=1734876207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=29Mhp+icYaG0e7y6GyARpsfnSrKdv5R0GREVEBYPpbI=;
 b=zljW7Rqshk8FbaGgs9uShwluluihZFjXcnypx/Q5SNwRddABsHAqgS+RUCanbRPB3d
 qLG3KreIx1St/97Cwrr4CcP0FGed2Nj1K70lBX4kU9gwTSi+uXdeolbFStPX/yLFvp35
 6/SIOQSGvr/gHC/07ih5EJwRx++vz2XZSbTeYGy6UKgim57rvEONH6uAFRMcE+LXOlln
 l9OnocLQeVm4l62svZX66ppdZdAKLV7EoO6DtLPSfbwG6bK+nCbAqq1Yd5EwUpKEjHxs
 DDdtMxf1SoT/bAjhpUrAshxsg0ZRh2FbZSfw0MnI/OOIbYSiQ/5SKfd10TQiROLRmjpt
 IsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734271407; x=1734876207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=29Mhp+icYaG0e7y6GyARpsfnSrKdv5R0GREVEBYPpbI=;
 b=kUn2MdYjWa1trLCDFejHdcgUQkhAQztkw1beoa61u+BIxf7NnDF8RH4Z85hfRgwg3Y
 n3KA6+48CU57zHdSu6lv53PDoqSPfmpZBFI8ONa5qx/FyMU/xXVvoJu7/W7ZXffTfMuo
 ST+e4d76kJiC30Y8CG+GdhApHxKOr/V+BiotS7ta1oeQi/goLkPwW3CyY0nJOajaQWXR
 5UiZoWt1rSqGtemZxY+2oCQfhJpzDiRJtk7KHF1JiFikkWlGZxVLdhrOL8bO+E3GCR1p
 a5FwZaiom7UDuOCXNd3cx+LPUXe0b+tSVJIeiwZDhhB0UJ0y6Sexyr9JAbZComZOLeRV
 Q6jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI8eoIEmF+VlDCABtaTux9SqOdyi5mnrNsHObtU50GdfSWeSJEJMwHGGz9u5AD2377WqSRE8GDdjBI@nongnu.org
X-Gm-Message-State: AOJu0YxfgsU2ATbF2Dq0isn8dPC00KaDiY1FRkAEEhmsZvfI/etFD3YM
 qe6myDACdEF9SeMXnzD3tVfJ8hD6IAMVpNbWNhclSwAc3U6Pffne2dxWD005Hno=
X-Gm-Gg: ASbGncs5rLomHi1tiNkXkSe621woRErTRE7OpGf2hthVV+TOc6VmzRTLTBLmaeOMZ1y
 lsqmb2pR8srDtGapOxokDvIXT2dt/eUzgctaZxbwPGJVImJVYtuALk3zcxjvfe+30GkWxOsXf+k
 hPMPy16S5h3VdNDmcsbReMlE769PVsSfs3dwfhDBhw5JniI0Va7nxfjuSZzmTsenkq9jaeuj/eD
 r3/bYevvc/oKvlx4ct8YerSHYdBBHoTiUJbvhDdKF5kJ3ihfHcAkkroVDiupr586wpKjotm0w0c
 9eSlgHPYR0JPnbaRxUy/xUQ2LjWYYlY2Fbg=
X-Google-Smtp-Source: AGHT+IFy7Z3pF6c1Eupom9IL5NniqMpjxPCdX3R8CIAEGx07Yq0SzUDLVH7x9FtEPQNlC7wJKmazLQ==
X-Received: by 2002:a05:6830:6a13:b0:71e:1fbe:db2a with SMTP id
 46e09a7af769-71e3b8683dcmr5507021a34.12.1734271407616; 
 Sun, 15 Dec 2024 06:03:27 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e483773bdsm840257a34.39.2024.12.15.06.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:03:26 -0800 (PST)
Message-ID: <c7f6ce85-3c67-45a7-bc1d-ab5d8af687e7@linaro.org>
Date: Sun, 15 Dec 2024 08:03:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] target/i386: remove trailing 1 from
 gen_{j,cmov,set}cc1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 12/15/24 03:06, Paolo Bonzini wrote:
> This is not needed anymore now that gen_jcc has been eliminated
> (merged into the similarly-named gen_Jcc, where the uppercase letter
> gives away that it is an emission function).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 14 +++++++-------
>   target/i386/tcg/emit.c.inc  | 10 +++++-----
>   2 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

