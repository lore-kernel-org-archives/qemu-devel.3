Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C87CFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 08:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNSFz-00020C-Gv; Mon, 24 Nov 2025 03:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNSFp-0001yY-9e
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 03:49:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNSFn-00053h-Rc
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 03:49:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso31301445e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763974138; x=1764578938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=REAyeuIOej9oylUCUsREGxvZ6tIVyzRPM0vzc+fC4nM=;
 b=qk2aJMDxVNaFNWvvS1yAqxLWZE4xnvnCFh0FZRItBVbiocX/GIFABDAneu8p0tVOlh
 CZAwG9a6gPWmV8b4JOVT5H9jiADX4SxUGzXTeIvaBK62GUfFAZ9wXbSe5iIx2EZG5ggE
 k3qLn+iwge0tdExHB/sKYslt3KjQeaoTHp7O5a3S8t6hXb1kG6Bettj58ZOw4HDlnwtp
 XIvOb2Esrvw9W+D9+0sC0QiFMKzAsDN1qUCDGWrlsG6/0NvPsURSbMItPMLPbGrAB1JQ
 t1elh0Mf/SSZTZxYZ5uuatNgkYz0/+typs/37ocGy5zTekqa8+xZLEZg0WhQNOmvfeeb
 KNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763974138; x=1764578938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=REAyeuIOej9oylUCUsREGxvZ6tIVyzRPM0vzc+fC4nM=;
 b=urENF2CAm3BVP2i8qPR36uPIYg6kThsVTBjkcTxK7dkTbbq075V0OXYkMc6bZGEVSP
 BiHdzk96r+9ylUEoRpOu2psiUSs1Hf/hc026f/s6aKTbUgKBAJvCXS3veC6oK5kISAeI
 YUUwZllRbMCNWpWQbNsF++wm9Yq7sfzUbgyTagKssgwSXsXXIeH7ymqetJJxkkQQgBFv
 2kM6tDU5sfruHFNj9U67lLdM6V+1Lbgt+pPtvkRFqI96Vfcr0PaGGvR+Un0xkpgIypf9
 LycQuLpQzh2riOnSEImBfZ0Vo9O9fbo/vvsar+CqLTNJLBxY+PoolFEDBzvrVA2Y7Njb
 sq5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6qAPS5qrJvXepk1OWEBZu/MFO8uf5rh6SKiWD7TOpip2ijCs/BK+nFoEApLsFxiPXUxce6pU6oz+i@nongnu.org
X-Gm-Message-State: AOJu0Yy33uuHby9AN2fmnvOfNvZMrr8bc2OBGnF3qtJtt0btuAGpIRFS
 4yDr8uDFc4IN/uLeS2BlCC2KCUo7/H5m9Y1Mr8Sc5CJ5n1uaSbm2xVRnhNrX1QVO3Hk=
X-Gm-Gg: ASbGncuKTYJV9IJIE3iUI0ovf/Zw9i4XUgN9NCq58EYAsrB8x2ht+ajLR15x3tMY9N7
 4fSr+aZLrQoJkv/VTd6h2zEvSaA0as4ySED9zT6mkLcTN2xqCJ3wqLtGV1bzPESsjksxIBztPL0
 zfUABo+jvrCbnpO6z4Mr6xQwSiL73tYMULlm58j7yV72Fz0VlOyBec+VqQo9y4fyzpDpyznsO64
 +OPG6uDmfNu8btV1u8y3vpDc2xOqXA09/9gQ4ANPIx0Trpqt+tn7SHzhzg5ZFgZEotjeSzPJErH
 I+Y8L+sEBv4gSOVZ6ex1sydlShtsmdUhCprbZWpb5uDPYhQw3xNgv1wKRnkj8b/swyz7NWHSdEK
 8p2A5L89h7Bre0uG37cqkgFcrE5tPwjCX3b0k6jddFzxNYF8pN7sZoLLO5id7d2lcd1nTJAu/0R
 wm/yaMlKmfdFmTk8YRXXkVQ0LNJM8SFVMLxTGiM0gl3RfhU6g05pPkTqmnqOG6j8+y
X-Google-Smtp-Source: AGHT+IHsEOznXAUy49fhVYlZq2Lhi2GTZmBEsY+WLEPDs2jIKnFWmMD2Vp4Hu+/sDSso+QQ6V4sYew==
X-Received: by 2002:a05:600c:4f45:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-477c04db9a0mr116274985e9.8.1763974138163; 
 Mon, 24 Nov 2025 00:48:58 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3b4c13sm182560995e9.13.2025.11.24.00.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 00:48:57 -0800 (PST)
Message-ID: <ea61d8b0-8307-4796-85af-04113c13deeb@linaro.org>
Date: Mon, 24 Nov 2025 09:48:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 64mb limitation of qemu-system-sh4 board
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, linux-sh@vger.kernel.org
References: <aKi6IWVX2uIlGKnw@seger.debian.org>
 <Pine.BSM.4.64L.2508230023030.21591@herc.mirbsd.org>
 <6abe2750-5e2c-43a1-be57-1dc2ccabdd91@tls.msk.ru>
 <119d5858-52f4-ce1b-9ee7-9615ce2054b9@debian.org>
 <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
 <b42433a7-e102-43f7-a7fa-1c9417a21146@linaro.org>
 <91b74af52f69c360a27269ab3145eeb377ef816a.camel@physik.fu-berlin.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <91b74af52f69c360a27269ab3145eeb377ef816a.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 24/11/25 08:33, John Paul Adrian Glaubitz wrote:
> Hi Philippe,
> 
> On Mon, 2025-11-24 at 08:31 +0100, Philippe Mathieu-Daudé wrote:
>> On 24/8/25 20:07, Rob Landley wrote:
>>> On 8/23/25 09:19, Thorsten Glaser wrote:
>>>>> There are no alternatives - qemu is unique in this regard.  And
>>>>> it has never been designed for this usage.  What we had for 15+
>>>>> years, unnoticed, is like `chmod u+s /bin/sh`, which is never
>>>>> supposed to be used like this.
>>>>
>>>> Perhaps, but there’s shades in between.
>>>
>>> I find qemu system emulation a LOT less problematic.
>>>
>>> For sh4 I boot qemu-system-sh4 and then use a network block device to
>>> provide swap (so the 64mb limitation of the board isn't a limiting
>>> factor).
>>
>> The R2D+ board uses a SH7751 SoC, which memory controller can access
>> 7 external banks. This board has its boot flash on CS#0, a FPGA on CS#1,
>> 64MB of SDRAM on CS#3, a SM501 display on CS#4 and some ISA bus on CS#5;
>> leaving CS#2, and CS#6 available. CS#2 can have SDRAM, while CS#6 only
>> SRAM (not really a difference in emulation).
>>
>>   From QEMU side, we could fill these empty slots with 2*64MB of RAM, so
>> the machine could use up to 192MB. But then it is up to the guest to
>> use it.
>>
>> Looking at Linux i.e. it seems to hardcode the RAM base/size in
>> arch/sh/include/asm/page.h, so we'd need changes there to use more
>> memory, which seems unlikely to get for a such old board...
> 
> I'm the upstream kernel maintainer for arch/sh and I would be happy to make
> the necessary changes to get the Linux kernel support more than 64 MB in
> QEMU.

Great :) I should post something shortly so you can play with.

Regards,

Phil.

