Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF84C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 11:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuVFD-0006or-MH; Tue, 18 Mar 2025 07:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuVEy-0006na-Og
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:36:13 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuVEw-00070s-Uj
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:36:12 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e60aef2711fso4017309276.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742297769; x=1742902569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pwqCGFnK7/S7tx2iHXLyhZnit+YTNBb9Ye/At1RT/ks=;
 b=GbL9OS/k2vbLDiWGINLSLsHH8oKJlLaFNDoLNVOb4UHnDLATMedN+oLq2f96T75J1O
 h+DS3uV7TSin/ggtl/z2DNRwX8nsDlKDMKdoef3OqFjbtsabd9xWqDZBHjvxlpV5+AIR
 Qh/0V5asug+tg73HDixBctBlrr8IYpbj6nfygx/Xljdtw2F+XHxhsHvtThJbvLmhy9tw
 kNzGCx1KHFEs4ek2xFrb0f5QNim5L+CktQxtVeyhiweOAusz4SGWzIOBU/s2/RttSTlx
 G17HxWQEaLFL4444nLVAGfSCA2y8Q5tkcjIkQpv0JAt+vFGFN3/+wUEX2cgsRZ0PBWCp
 XPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742297769; x=1742902569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pwqCGFnK7/S7tx2iHXLyhZnit+YTNBb9Ye/At1RT/ks=;
 b=LsMhukCnXjdb/jDw36UBVV6woRbOb6Xi3yE4v5fNkxhRwt0slEyBesrsRViz8wPHLo
 xRQYUp0ROWAdS/3V/Wdvis1rMTtRDS0XS+saW394hvG4G7R/KCR63Ya5R9GJm6/yivPC
 pAiAIi/g7vck0P8uyBOGJ9BPgPRM0b3mn+3bTNpnEfnIs6g0eb/8aj6Kk4H4sSvbxCS9
 WBZ34eV7jg1zt8mbQuPEzKh66Wiri2xeaNF4o5IR22s1DM74SpXRKHiK+lLJu0DuLlYa
 JbfqH8WjxfswK2tdL0T63F2Gx2j8Ucn8ydfxe5Xja604wtf0W3dYWl+7nW4V6uXvWzub
 6U9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnbkKoirdScjR4DsX44YxQ1WrBMCc52m2Pk92mdD8EoEnwBreo6yIEXl6d6a+NMMe0lSSftXlfk9PP@nongnu.org
X-Gm-Message-State: AOJu0YyYIySpAWejVMwivNOaxvk9xLUZxIQtN+uPibrQfI9n6UFeeCmf
 iCarV/u01GjFEMCdxVqoqkcjGRxoVnKi4qGW89sx/w8GzYodGymxs/BU2ZBvMXwb2CTNlYf58p5
 /NLMszVWqIB9oIeh2YcIu//tWZKjsmt7S7ocnQA==
X-Gm-Gg: ASbGnctH85iSob1wxKaQ9a32XM+H7wtMl4kph0dCoHZPQ+9xPV9z+rGFMKJVHx2FIzw
 NFrTfo1GPpzGpkGZszhSBN9MtlWn2qwengVHxEubaEQXuieKLGNYNCEi+vVwghB7V8707qVHc09
 Ho91Ep7dp7gkD0Gm+tbLWrR+iMIpu/RFxCYPMFRw==
X-Google-Smtp-Source: AGHT+IFcZ1/Ij+TVt8JjRY29oA9MQ4CENiRmO/G720qg7wKLllzEcXbzknxRbfwbRRvNG4aCLEbLNFFb8ly3ATsudZU=
X-Received: by 2002:a05:6902:2586:b0:e64:6988:fdd2 with SMTP id
 3f1490d57ef6-e646989019cmr4818848276.23.1742297769400; Tue, 18 Mar 2025
 04:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8RjNTZsuhShFwFUHa+YP5VKBUw2RneUPwAJ9eOVAL5Vw@mail.gmail.com>
 <20250318113013.578865-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250318113013.578865-1-aleksandar.rakic@htecgroup.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 11:35:57 +0000
X-Gm-Features: AQ5f1Jo9k_D0b7UtTBIdDE1_VZ3rYLbcAzgJDatPyI6_9VqbT_enHuEg2ppNxpc
Message-ID: <CAFEAcA84kcMBKzs+5r4Th8jZ+UJf96B+QVW-J=emZw-tpSC75w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] Skip NaN mode check for soft-float
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "arikalo@gmail.com" <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>, 
 "fshahbazker@wavecomp.com" <fshahbazker@wavecomp.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Tue, 18 Mar 2025 at 11:31, Aleksandar Rakic
<aleksandar.rakic@htecgroup.com> wrote:
>
> Hi,
>
> If ieee754 equals EMULATED, then the variables mips_use_nan_2008 and
> mips_use_nan_legacy are set to true
> ( https://elixir.bootlin.com/linux/v6.13.6/source/arch/mips/kernel/fpu-probe.c#L208 )
> and any binaries are accepted regardless of whether supported by the FPU
> ( https://elixir.bootlin.com/linux/v6.13.6/source/arch/mips/kernel/elf.c#L154 )

I presume from the name of that setting that in that case a
real kernel is doing trap-and-emulate for binaries of the
wrong FPU type (which must perform appallingly badly...)  ?

Does QEMU set up the CPU for linux-user mode so that it
effectively does emulation as-if both NaN modes were supported?
I can't see that happening from a quick grep.

Also, this doesn't seem to be related to the ABI_FP_SOFT setting.

thanks
-- PMM

