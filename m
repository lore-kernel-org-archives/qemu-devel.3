Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADC8C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 16:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVwqB-0003Lh-0e; Fri, 02 Feb 2024 11:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVwq9-0003LW-Fz
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:56:33 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVwq7-0004Gb-TN
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:56:33 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56010d9aab4so50987a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706892990; x=1707497790; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v/mBgZHM3ILTIRHoTb2obipzytY1xvYLZLRD4NSt/6g=;
 b=HreRvY8J8iSM9NVDFKAK/lndvC1jqPjVGFdEsz8Tn4z+zUgOoIc1IckMVY9fr9rD9N
 EX+QLy1Up0ztzMALcTecp/N2G/UNqNxzDqYbOTpIyp4VVvR0JIuXq6ciaCMt3vDYB0D3
 +iEk2J7QxZASpTjHVUV5eIqCJltBcCS5Mr2CAeq2Lw577uZ9D8TwqYI2JLbahNyn3Izp
 ZoZDb9wYt13JboR0nQykNdtcPt21AiyQRym62s7HBCUeY2i5ieQY8UiCladjrbxsHJzM
 qSpMUxvC8ceu8RtAe5vmqdjSdfeg1St+fCs609qfUg/JwUw2YDZGyWONw+R9KjTMqV8e
 yN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706892990; x=1707497790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v/mBgZHM3ILTIRHoTb2obipzytY1xvYLZLRD4NSt/6g=;
 b=jNds9iKLPU6l+hQhmJnSBfeFaHMsKCGz/w7QnfojprBOOfNnzEMhMG9kDsMWF2iWFU
 ib9fUyH5R40no8JU4brl+NsE7vuiTSg8JNky6nAR9jFg59khNj67+3SzDbF88iws/10Z
 VDU8dd48+igqoZYOd5ahPp7T+kiAck6V/FdQkQBKvlANIQY2MbPSMfqdGBFDTyrmyWbO
 EJufteijRxYfl3i+poJZ/apISAAiMfTI2j3Foty5+/HewfE9+b3thQmvGqSda3my2Nwb
 Cu4k3FItEYVFG9xSCbVsaYG8t7hyOdqNkt8v7Jr99oiSz4cPg5D8YwtoaKoi9lMkO6Sp
 TN4A==
X-Gm-Message-State: AOJu0YxLU1Om3g9TJhvtyfbqRLzSJPshm0rK6Dl+K/i3h2pt8vR42+Pn
 mJu2jVDSiS1o8BkkMolLqgdBHIOWo8Uq4JIstS7xq1wPgBHb6LjeLe/qX1e86AAn2bbizDy9pMG
 7JE6LW7+N0OUa/gBHFRpQVVOIxvTbRLHG41toFRAcTbRPT/wW
X-Google-Smtp-Source: AGHT+IEL0XWtFgZhD/Jz0arEQzzrMMUynuAuUj0I7gaTn4qJ4asToe23hFDj3SLqkcGAHaU/gKBOW0NKKieaY2JoQjI=
X-Received: by 2002:aa7:d059:0:b0:55f:f692:90d6 with SMTP id
 n25-20020aa7d059000000b0055ff69290d6mr173985edo.23.1706892989900; Fri, 02 Feb
 2024 08:56:29 -0800 (PST)
MIME-Version: 1.0
References: <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com> <87r0hwjdvl.fsf@draig.linaro.org>
 <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
 <ZbvpSaOXzZkqDd6c@memverge.com> <20240202162633.0000453c@huawei.com>
 <CAFEAcA-32--EmbzewL8WfAPanoWQ-eRpkjKuDLc5uV04wpOCpw@mail.gmail.com>
 <Zb0dXy72lyglchJa@memverge.com>
In-Reply-To: <Zb0dXy72lyglchJa@memverge.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 16:56:18 +0000
Message-ID: <CAFEAcA9KG9mF2KRS_Z2XdfD6b-aaNssZ7HCL_JKymyRkCJMq0A@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Gregory Price <gregory.price@memverge.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 2 Feb 2024 at 16:50, Gregory Price <gregory.price@memverge.com> wrote:
>
> On Fri, Feb 02, 2024 at 04:33:20PM +0000, Peter Maydell wrote:
> > Here we are trying to take an interrupt. This isn't related to the
> > other can_do_io stuff, it's happening because do_ld_mmio_beN assumes
> > it's called with the BQL not held, but in fact there are some
> > situations where we call into the memory subsystem and we do
> > already have the BQL.

> It's bugs all the way down as usual!
> https://xkcd.com/1416/
>
> I'll dig in a little next week to see if there's an easy fix. We can see
> the return address is already 0 going into mmu_translate, so it does
> look unrelated to the patch I threw out - but probably still has to do
> with things being on IO.

Yes, the low level memory accessors only need to take the BQL if the thing
being accessed is an MMIO device. Probably what is wanted is for those
functions to do "take the lock if we don't already have it", something
like hw/core/cpu-common.c:cpu_reset_interrupt() does.

-- PMM

