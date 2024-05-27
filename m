Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7613BC25B7E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBc5s-0001vi-Ry; Mon, 27 May 2024 11:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sBc5r-0001uf-Ct
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:16:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sBc5a-0008TZ-Us
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:16:59 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f8e98784b3so2478891b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716823001; x=1717427801; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YNZCKIEg/wB7FBJ60uujpf+diVNX2hoPtBar8fDBLso=;
 b=Ou3An3L9pqcy9wt2QNnRtpKQ1QROQ/xyy6Fi1DEh544yoaPPiPw7FAiKIMjsJ6FENg
 9AfyM5C/qfHaXRlqkinUnoa6jVm6KCF/dIFIkSsGZcg2b794YT45zpv2tl3yxVlg8HNs
 EDZyGH29y8D1f/o9sMnyTWgQDDB6hCRFHT59s1JVX9zuIEIFlLLCVTFw8rF0u4NxKhg/
 w6BJpgZVA9eu1Y2cQtaS28M4UkpAMeO7MQ9sdkKs8ufTtdR/0CEmKffTYnKiLXvfiYRW
 3WbferVNt3aRuXWwv8RUlXeCzJYFwqEmQ5aWB4vzhLilxFQyLKGDWIZIzp/6nV93QYtR
 fBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716823001; x=1717427801;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YNZCKIEg/wB7FBJ60uujpf+diVNX2hoPtBar8fDBLso=;
 b=FTOusuNX+4pdE8+OMX0fwEmuEb12Bikn5wov83ZEkQWBMfS7UzTwi5TtpfwSFuGwam
 waoYvELZsZxr593iLLH35/IECdXa3QazLSkJMuvae7/2QJfDBSMdvvaFdGJ3mMOggkbh
 zZNIXpjUiVdzG2A93sfK17iVFHmbiyb/FJqE0YN6DcnnG87VWUT+ccpyuUvyZx0MEjT8
 c+oqNBDlfmNmTbBfRCe/LgV7rPGMsFYnWsC1R7o9BIYtHurALasM71HNk+qwrmlFvLRp
 bJLddZ/irFJN2Vk7kCNB4oOE562pKl9aVAMobrLT/HlJAFXovG4puwprS/GBgpzrpLXr
 9xag==
X-Gm-Message-State: AOJu0YxMjDwZqqy+ntHrE8SWkbjlfcWF7SGDa+/xjIdXx39b00hstTy7
 FysZGtsSIp4GCdexVLIbHFjJH5glFf3e18mfm1KuX6Tt6DqwfLBqeO4yqiCtcmU=
X-Google-Smtp-Source: AGHT+IFiHIgKd/rnJEicqxIOXfdw3SGT+klsDYlCicD7ji3mZ5xjHknFLrAdPZ51WWQdybvlOg4hVw==
X-Received: by 2002:aa7:9a85:0:b0:6eb:6:6b72 with SMTP id
 d2e1a72fcca58-6f8f3b454a7mr7501875b3a.25.1716823000697; 
 Mon, 27 May 2024 08:16:40 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2e3d5sm4986549b3a.9.2024.05.27.08.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 08:16:40 -0700 (PDT)
Date: Mon, 27 May 2024 20:46:29 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Haibo1 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 06/12] tests/data/acpi/virt: Move ACPI tables under
 aarch64
Message-ID: <ZlSjzfSj8MwDcJk6@sunil-laptop>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-7-sunilvl@ventanamicro.com>
 <27cef750-262a-402a-97fe-c4a55700a376@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27cef750-262a-402a-97fe-c4a55700a376@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, May 27, 2024 at 12:12:10PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Sunil,
> 
> On 24/5/24 08:14, Sunil V L wrote:
> > Since virt is a common machine name across architectures like ARM64 and
> > RISC-V, move existing ARM64 ACPI tables under aarch64 folder so that
> > RISC-V tables can be added under riscv64 folder in future.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   tests/data/acpi/virt/{ => aarch64}/APIC             | Bin
> 
> The usual pattern is {target}/{machine}, so instead of:
> 
>   microvm/
>   pc/
>   q35/
>   virt/aarch64/
>   virt/riscv64/
> 
> (which is odd because q35 is the x86 'virt'), I'd rather see:
> 
>   x86/microvm/
>   x86/pc/
>   x86/q35/
>   aarch64/virt/
>   riscv64/virt/
> 
> Anyhow just my 2 cents, up to the ACPI maintainers :)
> 
Hi Phil,

Your suggestion does make sense to me. Let me wait for feedback from
ARM/ACPI maintainers.

Thanks,
Sunil

