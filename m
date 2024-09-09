Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D1CECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sneOB-0007RR-81; Mon, 09 Sep 2024 09:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sneOA-0007PS-2S
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:25:06 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sneO8-0006AJ-8C
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:25:05 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f01b8738dso2879355e87.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725888302; x=1726493102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+L+VHehX9ZnuFGA5oNM9gVj2qG7LomNJ49FnJV9T5M=;
 b=kBdstfmGkC7IPPtV7k0W5qE8icDg3WtmRNBhRfmOYlafsYaFsvzCDbNUfWbA3Z8SRo
 E42VnEng6p8KgbgkoplBkBUu8KYtord0B9n9V5U3jKSqiXwTn9agayXVV+xR+JKllkv9
 cuirY0HU0R2+RIUZzBGHDBeUUR3JBcHV/tvWQ8BalXRmDtlBcfJtspeLHvivgrhBHwIy
 veg7wEZzN/RqAtQi5znOJxxEffjW3xSjioJmsT2mU+WmWWxMU5QmYCpzmQdexr1ZXfhl
 1oelomx1P0F3otxOvKYd2935lempSx1eXRyZeL8TpNFIELX53V76q9tzjLfCIDWuZAeT
 Yu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725888302; x=1726493102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+L+VHehX9ZnuFGA5oNM9gVj2qG7LomNJ49FnJV9T5M=;
 b=LiRpTWa11JFx6bxHY8tDeNQOMelM3wi/qlOfcklod89rzkoWhJYIf5EHdZmFKx0WCK
 Mrhg/Lt0V+//MQmcFSXxs3QYZ2504ar8oWemLv2F7/wO+WjIT1r+Ln4ZpoC0Ye5UQkVQ
 JT71Fkby3nv2m34OgLZ/yfdVQaUUmGhz/i43tpx1tAAGfIuoRxg9QXkMIir7vsRPu6pW
 jnCHDoctJUBvkXKoyobAuGHv/gff8/gKFamBCAAVD60wjGg0IrAziTv3uGuqIh3OmmQF
 FvGEH3cKl0OLooVnOZflnKzjuFJ3lsN1a0DgM5L66Z4pUV5QKMGnZbiz62Q8dXoy1PTh
 csPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4XgxyXrf6KCPpaJyD/agH3itcSsF89vXtfG0f+buGa0S6lKswdsDpFcg9qXjZ9duWw/BUsN58bGh3@nongnu.org
X-Gm-Message-State: AOJu0Yyc9tIwy4U15aX80PW8ja+BakZvTIMXdfRzr0DJUhf3wFvVpaCl
 SUGJTALV6q5v/FUnDlkpQ+kD0u+n9ARLD1y/Ak37G/KSUDS1BsgH9rr/c7qWt1I=
X-Google-Smtp-Source: AGHT+IFgC7fOd4wtnv78KdC4ofBpBRbvyNTQhTo/uii5XIWDK5Fli8cuGYp/2GZM2ZU99mcVowXbww==
X-Received: by 2002:a05:6512:39c8:b0:535:6cef:ffb8 with SMTP id
 2adb3069b0e04-5365881366emr7041621e87.54.1725888302007; 
 Mon, 09 Sep 2024 06:25:02 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d5dda8sm339771766b.211.2024.09.09.06.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 06:25:01 -0700 (PDT)
Message-ID: <c2bfdb7f-52ff-4650-a171-663925194682@linaro.org>
Date: Mon, 9 Sep 2024 15:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] target/cris: Remove the deprecated CRIS target
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
References: <20240904143603.52934-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Hi Edgar,

On 4/9/24 16:35, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Split in smaller patches (pm215)
> 
> The CRIS target is deprecated since v9.0 (commit
> c7bbef40234 "docs: mark CRIS support as deprecated").
> 
> Remove:
> - Buildsys / CI infra
> - User emulation
> - System emulation (axis-dev88 machine and ETRAX devices)
> - Tests

You acked the deprecation commit (c7bbef4023).
No objection for the removal? I'd rather have your
explicit Acked-by before merging this.

Thanks,

Phil.

> Philippe Mathieu-Daudé (15):
>    tests/tcg: Remove CRIS libc test files
>    tests/tcg: Remove CRIS bare test files
>    buildsys: Remove CRIS cross container
>    linux-user: Remove support for CRIS target
>    hw/cris: Remove the axis-dev88 machine
>    hw/cris: Remove image loader helper
>    hw/intc: Remove TYPE_ETRAX_FS_PIC device
>    hw/char: Remove TYPE_ETRAX_FS_SERIAL device
>    hw/net: Remove TYPE_ETRAX_FS_ETH device
>    hw/dma: Remove ETRAX_FS DMA device
>    hw/timer: Remove TYPE_ETRAX_FS_TIMER device
>    system: Remove support for CRIS target
>    target/cris: Remove the deprecated CRIS target
>    disas: Remove CRIS disassembler
>    seccomp: Remove check for CRIS host


