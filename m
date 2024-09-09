Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33464ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snf9v-0001Kf-Ck; Mon, 09 Sep 2024 10:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snf9t-0001Jj-Tu
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:14:25 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snf9s-0002mV-6h
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:14:25 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53654e2ed93so4678717e87.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725891262; x=1726496062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r2sJ9jRhNu0rugsGntgPlhTeeSdWfgO5fbAz/wbO+Ik=;
 b=LmLgW+VqBCr36ufORoNrmle5dreWpZCRnjP2HVTxTyj68fsZ+SLgWJxKBbiXWbndom
 UrbjnpY4CiFhNGZXqunXm1xmmHfmkseeqEoOoc9bivmLAI1n0CHUGZI2454DswcE9t1G
 DIWOHPdmXxAxPgtTQA3gAEZ1/w4Zsk+xCtQ5DD/mGLrH30nyFQDaNxUrEaFlWs9TGktb
 VUUA98unFKVeQ3Ssm6mZqE8SVVFcgppjhIVPncRHWBNxS7CTzLzM503WmFTLLucwyK7Q
 L2ok6IxBRYLw+Ls+GexDeHAtuJjy2J0S/fW12HO60dL8gzyylSfgqfd05VGhvu+ZFlFv
 r5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891262; x=1726496062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r2sJ9jRhNu0rugsGntgPlhTeeSdWfgO5fbAz/wbO+Ik=;
 b=sITqTlWkZwTDg945tmTc0bfxpb7ODQlWUPfwwY0jLkpW369Oh/Q2RUgnia4GNRd8H8
 LcYJ+PBuJW7PkmTAqT7W5UOWxlOawA/40ZuEMzjFEaK9RlZBCo3HDp3dbKDj0/ubl8HN
 NeBD6d0UPF6JUN+VdJNsfNr744EH/SU9enNgcW+pgKA6dQdxpOQXsbTEOZOS+hgCOuEQ
 8IhCQ74fRodyb+P274rJRksFEoArkyyJ6gFrL7Z6TegEXOrmjoG1WBJGPLIQS9TcYSty
 7dX9C/ZbtmBrRwnPbmJcywbSugZupmawmGqPvfUpIQ6DsoDiY4fjoW/SAhGoroLNlTU0
 eWnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5CBEwgkVSFnXpzAc9WXW5IZKsiuOYJn9u9TirUqWxG9wj187JMepoK5sLQIHvJ9f4Fn9+d00TBMSl@nongnu.org
X-Gm-Message-State: AOJu0Yy8a6igDPaELQaaH+y9IIAJ5YnAED+gNIn+q9JbHQzeQZObWwJq
 a/LMPBZvMVN/BdCs9eEPQwpdfsDlzefHfc6mIY1URW+7ozDx3C1aUa8hQZYmv4A=
X-Google-Smtp-Source: AGHT+IFuWqKa/JCutU2WDU4fm8W9F5BcPcDeD6Jon2YypZuGENzNscC0TBJipDJwEIbpGrnpwGs+Fg==
X-Received: by 2002:a05:6512:3a91:b0:52c:d76f:7f61 with SMTP id
 2adb3069b0e04-5365881634dmr5094940e87.56.1725891261624; 
 Mon, 09 Sep 2024 07:14:21 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c61185sm347092666b.100.2024.09.09.07.14.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 07:14:20 -0700 (PDT)
Message-ID: <bb489c8a-c680-4e5a-b56f-6b7aa7d6531b@linaro.org>
Date: Mon, 9 Sep 2024 16:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] target/cris: Remove the deprecated CRIS target
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
References: <20240904143603.52934-1-philmd@linaro.org>
 <c2bfdb7f-52ff-4650-a171-663925194682@linaro.org>
 <CAJy5ezo3VH2u-W9iFQNGZ2A8M8CoVtHPq-V_=ShrJa6HGB0ceA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJy5ezo3VH2u-W9iFQNGZ2A8M8CoVtHPq-V_=ShrJa6HGB0ceA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 9/9/24 15:59, Edgar E. Iglesias wrote:
> On Mon, Sep 9, 2024 at 7:25 AM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     Hi Edgar,
> 
>     On 4/9/24 16:35, Philippe Mathieu-Daudé wrote:
>      > Since v1:
>      > - Split in smaller patches (pm215)
>      >
>      > The CRIS target is deprecated since v9.0 (commit
>      > c7bbef40234 "docs: mark CRIS support as deprecated").
>      >
>      > Remove:
>      > - Buildsys / CI infra
>      > - User emulation
>      > - System emulation (axis-dev88 machine and ETRAX devices)
>      > - Tests
> 
>     You acked the deprecation commit (c7bbef4023).
>     No objection for the removal? I'd rather have your
>     explicit Acked-by before merging this.
> 
> 
> Hi Phil,
> 
> Yes, sorry, I haven't had time to review each patch but:
> Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com 
> <mailto:edgar.iglesias@amd.com>>

Thank you!

> 
> Cheers,
> Edgar
> 
> 
>     Thanks,
> 
>     Phil.
> 
>      > Philippe Mathieu-Daudé (15):
>      >    tests/tcg: Remove CRIS libc test files
>      >    tests/tcg: Remove CRIS bare test files
>      >    buildsys: Remove CRIS cross container
>      >    linux-user: Remove support for CRIS target
>      >    hw/cris: Remove the axis-dev88 machine
>      >    hw/cris: Remove image loader helper
>      >    hw/intc: Remove TYPE_ETRAX_FS_PIC device
>      >    hw/char: Remove TYPE_ETRAX_FS_SERIAL device
>      >    hw/net: Remove TYPE_ETRAX_FS_ETH device
>      >    hw/dma: Remove ETRAX_FS DMA device
>      >    hw/timer: Remove TYPE_ETRAX_FS_TIMER device
>      >    system: Remove support for CRIS target
>      >    target/cris: Remove the deprecated CRIS target

Series queued except patch 14:

>      >    disas: Remove CRIS disassembler
>      >    seccomp: Remove check for CRIS host
> 


