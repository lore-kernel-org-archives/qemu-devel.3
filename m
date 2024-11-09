Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB84D5E364
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 10:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9iU1-0003cx-W6; Sat, 09 Nov 2024 05:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t9iU0-0003cn-A9
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 05:14:20 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t9iTy-0007Up-Eh
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 05:14:20 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so2631624b3a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 02:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731147257; x=1731752057;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1TaikMtotvXpNsA8CnfB8Qm/Dttpc9MPhPa7eP32lvw=;
 b=aiSFFPMydKa7QrmZGLLYePQ+q/uHCDn6Y5b2ayCI3DtucS+c3dCTyd207a/DpAeYZX
 j6P3yA6MHcafMfOFMLIYBE67+lJNIEylljdD/RLXA9QxNLWsI09ZaiQpWvAjNRCzHlWi
 0amdesdo2WVqAJLtPSifMxNiDpbHYbzf24t0hf10uvmfSwHRRhjRav/UQpPntTUiLH+T
 N3sBalqm9TTM2jpTS5Un/msJ4w2FgyQfvpG4zQGE6S23kpdNRRYUj4N4TurQz0E7QKt9
 TwZiWYlklGGH88+8wglg4pk73BVPkUu5inUnF1sgmfu5C+bdcBEU3l/sM25OoN5UM94m
 Rc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731147257; x=1731752057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1TaikMtotvXpNsA8CnfB8Qm/Dttpc9MPhPa7eP32lvw=;
 b=HPPest79rbOICaC4yzns+I/EWcLI56ANbFjeJ6h6boHGCAHrsGQJuP4P1JOmd8AxvL
 hDEoA2HSYSHti4GAZsPZEOC7+8q+SdX0RkZ2aB7iPFu2qxnQk0PVHWzI33Wb4xLGDnvd
 Vioii9MTz4l89j8eT9HCi6uZHRbkLfQW4Hl0ucG7t31HgutKVg99xrxDPIKc7XrenNUZ
 mL784eB7xNxgga/CjL6v6lJ8aKoWedFh7yHWq+zLulGF0F3LUNvcYIoXyoeFGCK6fQD7
 eTIwc0n7rwCVRb/Tah6zoo1GXQJGPUI/u9WVMCkC5YuQuUCVnfEBHxrhFo8SzzgSjZhs
 BlKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/FSDPT7l2vchZfBmMarfv1xsLGYm1O0h1wMjFgOulnamm+Pqs8Blypo66NcUUnNYyMJOsQMCMcfqT@nongnu.org
X-Gm-Message-State: AOJu0Yzpa8oYlFPDS3GVqBrW3bC6S+lujGHWZo53FDQvKKak1DQ88k52
 CdivoAm9L6IaE0zGU7CP1nHVIEIqaxJOcuYbk5gUnh1sJTkJ7LiXfzyhjw5tMV0=
X-Google-Smtp-Source: AGHT+IF54p8Bbp3oCEAC5leRijz+h4krDCGInuYi8jSBTIRcuFa67AqRlbNeNLSTcQHoYCM87Qhlkw==
X-Received: by 2002:a05:6a21:9101:b0:1db:e3c7:9974 with SMTP id
 adf61e73a8af0-1dc228ef1damr8242592637.12.1731147256906; 
 Sat, 09 Nov 2024 02:14:16 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240799bb25sm5424973b3a.109.2024.11.09.02.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 02:14:16 -0800 (PST)
Message-ID: <25ed843e-b250-4613-9819-72ed4e381d33@daynix.com>
Date: Sat, 9 Nov 2024 19:14:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/8] memory: prevent dma-reentracy issues
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daud?? <philmd@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, David Hildenbrand <david@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bandan Das <bsd@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>, Bin Meng <bin.meng@windriver.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P . Berrang??" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jon Maloy <jmaloy@redhat.com>,
 Siqi Chen <coc.cyqh@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20230427211013.2994127-1-alxndr@bu.edu>
 <jsmj5q7adyvvkuvspny4xxvfczdsrxfbjqt4irattz3gfrrhfh@bmpvza45wkze>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <jsmj5q7adyvvkuvspny4xxvfczdsrxfbjqt4irattz3gfrrhfh@bmpvza45wkze>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/11/09 4:56, Alexander Bulekov wrote:
> On 230427 1710, Alexander Bulekov wrote:
> 
> <snip>
>> These patches aim to solve two types of DMA-reentrancy issues:
>>
>> 1.) mmio -> dma -> mmio case
>> To solve this, we track whether the device is engaged in io by
>> checking/setting a reentrancy-guard within APIs used for MMIO access.
>>
>> 2.) bh -> dma write -> mmio case
>> This case is trickier, since we dont have a generic way to associate a
>> bh with the underlying Device/DeviceState. Thus, this version allows a
>> device to associate a reentrancy-guard with a bh, when creating it.
>> (Instead of calling qemu_bh_new, you call qemu_bh_new_guarded)
> <snip>
> 
> Later on there was also a guard added by Akihiko Odaki for
> network-backends.
> 7d0fefdf81f: net: Provide MemReentrancyGuard * to qemu_new_nic()
> 
> Recently a talk came out about re-entrancy bugs in qemu
> (unfortuantely I could not find a non-video version of the slides):
> https://www.youtube.com/watch?v=wL3LK9Dp4os
> 
> The talk gives an overview of these bugs and also demonstrates how they
> can be used for VM escapes. It lists the following vectors:
>   1. MMIO
>   2. Bottom-Halves
>   3. Netqueues
>   4. IOEventfd
>   5. Timers
> 
> The first three should be covered by the current defenses. However,
> afaik IOEventfds and Timers are still unprotected. The talk demonstates
> an attack via IOEventFd, but not one with timers. In any case, it might
> make sense to revist the guard to ensure that we are covering all types
> of code that perform DMA.

Hi,

Thank you for reporting this.

Was this problem reported at qemu-security or is the presentation the first?

