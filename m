Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14F0CD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsxd-0007fy-9A; Mon, 18 May 2026 04:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOsxD-0007dU-WC
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:04:03 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOsxA-0004cz-HM
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:03:58 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-65c396d3b36so2122476d50.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 01:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779091433; cv=none;
 d=google.com; s=arc-20240605;
 b=k40iSvUArWlgRbmF0P/2YX4Q9VaRX6oHl6ReJPlTi+ELswa549IcoQh2M1lYkup9cY
 mQw2xtdyhYZhajAgVU9BzbVP8ETCq8eRTfsqv2XskIDRZR+V4ZL3w+fkw3hkL6zFTwXo
 lswa93c0vyy9OPKS8YJQL8KPKmNOeuxGN6OUIAzWM6RgdA9iRe7YXV2Mf+bvM9nWU7y9
 HaMxtMSqBkPV2SIZjqMca80C01iItaAFhVdvMGMxnhJq70aPc/4AOZ0kIgsypNQvNiLw
 EUULH+v9YsZ3OOxzrxI7GgT66L6ICF9ZXI2faH+u7WwB5DdUiVBMTGxfEoE9tQoZ00IC
 Akkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yMCUJDnYDGUg0guhsopcnxd7sSRP7hh66/XkRJ+k6q4=;
 fh=onkeOOUSDTYT0BEv/ruHE4jO4nK+Gtx6UrLHZ2tBy6I=;
 b=DTVNfgWsV+CXTaFnDfUcnVAWgMPaB+o+VKi/3OH70g3xqwvtzrp3v61Mr3Hg4aMQRh
 UCNNYt+EJjhOY+kjOFKT0olWosbFrCYgv2nizFVGi/+7BAxHuFlnpMrIx6NtXXmEwSLW
 2Ef81CzcdwWLcWD9nuSGYF8QdrLxY+x72KLaD6UFmp8hvG/Sf2ANPw+d/Q/X1FV0Xtpc
 P4bNIbKvGjBDTj28MnzYN6zU0luq9erZ6TTAezATD8dCWv6bXaHDKeTjEQ5PEa67Sv7o
 6MpyQaqoKZjo7re4KQhdqDzKVx6r8E7wnxtV6P/qLV8KbT2czgNX/8ZmjvNA0ijuN475
 ER+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091433; x=1779696233; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yMCUJDnYDGUg0guhsopcnxd7sSRP7hh66/XkRJ+k6q4=;
 b=y+9AeHQonnG8UWZ54Z1+rxZwASXqHtZCMz0rBHT0ai/EkyhF7AHdF6qvZivhPFDGcC
 5y9VVt4gh7zlmBuijW+C020/iNrWjlhsKsAR0ZHDV2IOhba7cxnw6sSlhSyMqonS6EeR
 O6NvXh5EiuU1oRuBBBd/WbtsS2bovvgayT/7Q8nqMu/0x94cpjpvCw4uO8Twab6BcnqO
 tHc/ZCu5p6a+IZvtYqs3Y0b6vBXMHo6MFCvJPByVD2UjrxTgamfKFRklYGz3zzbPYHwV
 ia2yPbwkMMWq5yJ3yQUvm+MlbeKT9k7neILHfVdBOuPcYq7x81+VQbVkvVPt2Lmnd2BU
 oN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091433; x=1779696233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMCUJDnYDGUg0guhsopcnxd7sSRP7hh66/XkRJ+k6q4=;
 b=gCk5bCbI/Gf5bNnba8FGdhvGARdXMhwQCUjnMrwjDuFI9SmC6VJjCUhF2N6Zzo4eTa
 yNLkwDYLnZ+TjjJyYi7rjeBM35Vagmw+oLlFrMz6DIjBHhFSpHRmPltTCO4hZ0HyCL/D
 vdjvkCMjQG4qMU0zQU/Sy6pLV/qcfOqFJ0xIjjBwxUw43H7upDLVrkxTbRDdaP3Pg7rX
 e+mkoK7BoBgtHDTEmvIiQ0WeijQUji5vdAi9VLFXUpU9CowipCU3ZaIAvJFgltQwJLZb
 nAIM9IjLV1JJqFVqhIyOxsanbZ256aFL0nOOjEIvU0RSzkmNj7s5Ftz4mmVyW8tK1LpT
 cRgA==
X-Gm-Message-State: AOJu0YxymRUMY/eM0C+vYOZHJPWUmuQ3I1w30YDcI7vBK9sxNfq2S6Sx
 Utomr0Q8k4jDh+fUewX4ZoTOwtx4uoHXnES87IV2FinDFSiu2t0Y67MGqP7EzqW9NegmAfM9wMm
 ZitoLQB7p8ne6sOC7ZBGkCImDCj+lMulFVB64nNMn9w==
X-Gm-Gg: Acq92OENanMWa5yohRErVObDnU9jqi57ye640DCpC7VxHFC1Zu9GiaJrAKKABIPc4Rx
 sXPluktFVwa/CV1MHgbKZHtTGolX5AI5HmYEQjdy4ujdPtHEaEUSQOXd6rLCXfCCc1N5jGcyzLo
 N8Ci8LyuVNwevlP2s5+Q1oh6qACKfhdqdAanLrdc8Y3tJKGe/S3WLy8CJzUbjKhmI+OXJwvzzEO
 xx8/JwyD9iTZWwTZAi0i7SSmgtoT2VksvHq6fTBTXJeEGAMxnVZwXCWY4Hm7vjYORzW2YhcZDUS
 7JE9BPROruuZmGMFmlLDl5+M7XDMyoQJGlS2CpZPIWURR2AvTjA5R1qGrZzBVd4784DTnndCMos
 WsA==
X-Received: by 2002:a05:690e:168c:b0:65e:44a3:ac3 with SMTP id
 956f58d0204a3-65e44a31552mr6388917d50.50.1779091432598; Mon, 18 May 2026
 01:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260515125727.349675-1-peter.maydell@linaro.org>
 <20260515125727.349675-2-peter.maydell@linaro.org>
 <52828194-de59-4d7f-8047-c3ae53276c51@linaro.org>
In-Reply-To: <52828194-de59-4d7f-8047-c3ae53276c51@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2026 09:03:38 +0100
X-Gm-Features: AVHnY4L8Koataf3RyuscGcY1qQYYezSqp20_3lRgmqJhLtWHZrnOkcOn8lcl4A0
Message-ID: <CAFEAcA80ju7mtHGwW=C9_LZB-ddGmR1PtZEdG6iYjKem0rkaYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/microblaze: Convert to translate_for_debug
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Sat, 16 May 2026 at 19:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/15/26 05:57, Peter Maydell wrote:
> > -hwaddr mb_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
> > -                                        MemTxAttrs *attrs)
> > +bool mb_cpu_translate_for_debug(CPUState *cs, vaddr addr,
> > +                                TranslateForDebugResult *result)
> >   {
> >       MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> > -    hwaddr paddr = 0;
> >       MicroBlazeMMULookup lu;
> >       int mmu_idx = cpu_mmu_index(cs, false);
> >       unsigned int hit;
> >
> > -    /* Caller doesn't initialize */
> > -    *attrs = (MemTxAttrs) {};
> > -    attrs->secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD);
> > +    result->attrs = (MemTxAttrs) {
> > +        .secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD),
> > +        .debug = 1,
> > +    };
> > +
> > +    result->lg_page_size = TARGET_PAGE_SIZE;
>
> TARGET_PAGE_BITS.

How many times am I going to make this mistake? I think
it must be the _size suffix on lg_page_size that makes
me think I want the _SIZE constant, not the _BITS one.

> >
> >       if (mmu_idx != MMU_NOMMU_IDX) {
> >           hit = mmu_translate(cpu, &lu, addr, 0, 0);
> >           if (hit) {
> > -            paddr = lu.paddr + addr - lu.vaddr;
> > -        } else
> > -            paddr = 0; /* ???.  */
> > +            result->physaddr = lu.paddr + addr - lu.vaddr;
> > +        } else {
> > +            result->physaddr = 0; /* ???.  */
> > +        }
>
> Surely this is the "return false" case.
> Fixing an existing bug, obviously.

Yes, it looks like that ought to be "translate failure",
but I just wanted to retain the existing behaviour here.
Possibly somebody had a reason for it given they flagged
it ??? rather than using "return -1" failure option.

> >       } else {
> > -        paddr = addr;
> > +        result->physaddr = addr;
> >       }
> >
> > -    return paddr;
> > +    return true;
>
> Perhaps cleaner to finish with
>
>      *result = (TranslateForDebugResult){
>          .physaddr = paddr,
>          .lg_page_size = TARGET_PAGE_SIZE,
>          .attrs.secure = mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD),
>          .attrs.debug = true,

I didn't know you could partially initialize substructs like that.

>      };
>      return true;
>
> ?

thanks
-- PMM

