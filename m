Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F25FAD3E7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjZa-0007pi-Rp; Wed, 22 Apr 2026 22:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjZG-0007o2-LQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:13:33 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjZD-0005XY-MP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:13:25 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-50fae4d1f85so43486551cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776910402; x=1777515202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TVOMlgTKwLmNpS1Od8/7xYLdhQ4uz2+MNbY8Tp1Oaj8=;
 b=SzdepP6vAzNLSLmi4/+8ajgs3cqdJTl2cE0dsF5QmJDqfnE4v6A3MiIU9fIM7gSMld
 9HpWdLyEsGlAZo8KVKe0kFIxcv7Vun83Z+iwbBrYQ+IZ7zFah2p1GuwTFB7tkbdHzeIG
 bo2amO/6Z0Oyj6neKErVLGFy72RAjMEBnnet+c+gQQOiVStARhaGopn7+PS0mAelRuQW
 +/USDzdTGJ8MXJdnKtIEUOO+kaXIPzduCOg1mzYOSKzcMzyoXzoxICr1A3jnj5pXiqh1
 u5O14XnfGOlznEX12oTBsTWqgu9n43N1TlW3L6YORw1a7Y/mm2CiOEr05o2E3T0b60Y6
 JW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776910402; x=1777515202;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TVOMlgTKwLmNpS1Od8/7xYLdhQ4uz2+MNbY8Tp1Oaj8=;
 b=pahuW5IAK2eYQfP14GNs+SMqcyZ5EBll3Qrrj2aFQmMs8jfsqOtl0ru0JDizaPHhYq
 dX+J3IYwt5fxJaernYcAA4svdj2IGPBjL9fZ99a3EFPjn+0qNm+0UXtGx4OFNxaZqVOy
 m49GLzzcIdNY63+LEm/OgWgswhAWZHFkhy2HUNkftUATXO0TKsceAs612GWZgz3bUBvo
 gbP8CflutRVahvZrXUwzs0GSYT6niTHVjRlnv6iidcsSotDR7+A9CYf6hh3eSZxKhSDD
 LUHu5OZHF1JNxyKOdj4Twc+WPME0wfw5opm1dkynYe1wH4Ofl/99y3eqsXvFdSJxYPgo
 Cb7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cOEGqCwRNOEghRcfQNgSnOUf4O5oRHi4lmDW2P2f0UCIa/lXfS9z+pd15sHIjx64Vk4kz8YfihIE8@nongnu.org
X-Gm-Message-State: AOJu0Yyf6/ckmgJj5tZhInZzuQIE3yGnVBNp4qDwacYiSJoTJ75kKYLW
 4+qq8v1K/mbamr/CeOvmLFSp2o0EGfY8Vz2mFauGstlvnMLW8nR4K1fex3s9+UpezOg=
X-Gm-Gg: AeBDiev39Gf1KNiX8kvrjZ9VCTcymzRkXmFkGvXhEkxOg7YkFeI/pLWeDMq1w2SgGXA
 Ijxp2JCqKGV54vd4rUpXTnYYiTH0/FSlHFDm2LyALObcIvsFhampKy9mcqbm9hEizhIsciN0S+Y
 /5DT+sfCstlAiyW7yRpBkilpqqgLDdkVOgQmfnkL2R4ug+bRWu9e+Z7jg/LUdJXAghEvvLJmGDY
 5/YjzupiOfPXdln9dN1X5tiCNKQ0pNNyLVLPss4+t/1OgWgWjlxjeyPPvehasMJ6DR8veuhGzG9
 Q+lgC5M0wVALlGWy8PKWMRULwOfFhhg1QRNqHrSNPFdblZ1iXIkL9+DDDSbOekbj76nBtTXlB6R
 GaZM443BYPGkYVoS7OEKikM2MFppLH7ULMTbnVCRfFdPTi188csHTl8/5sOsVTgsrN34T62B+lF
 88l08sZXsRnlp9MhD5u03TOaOAiw0sW77dzi2jvlsaa+9khfo9AW/bsn39e6LH4bx7UDn3a5XTv
 JETwwL+PMiKiBnjgc61lsI4FQX7
X-Received: by 2002:a05:622a:1812:b0:50f:bc35:ac0 with SMTP id
 d75a77b69052e-50fbc350e4amr118429931cf.30.1776910402087; 
 Wed, 22 Apr 2026 19:13:22 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e39487921sm145477261cf.24.2026.04.22.19.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 19:13:21 -0700 (PDT)
Message-ID: <5e7013b4-8879-4db9-bbc1-71922371276c@linaro.org>
Date: Thu, 23 Apr 2026 12:13:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] target/riscv: Make get_phys_page_debug handle
 non-page-aligned addrs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417173105.1648172-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/18/26 03:30, Peter Maydell wrote:
> Currently our implementations ofSysemuCPUOps::get_phys_page_debug
> andSysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
> 
> The only thing in the riscv implementation that we need to fix
> is the place where we explicitly round the return value down to
> a page boundary before returning it. Drop that.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/riscv/cpu_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

