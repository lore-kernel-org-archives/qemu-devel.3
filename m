Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5FACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDAf-0004rp-JQ; Mon, 15 Jun 2026 15:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDAe-0004rH-8M
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDAc-00032l-5R
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781552428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83xUQYk0WNw//htfkZIQVB7lo3e4TfiGP4u3TF0wUFI=;
 b=RBBO96chIrwIQJlkrR6EOBfYrVamRbMwgUVKZago/E2W+Kfg9JgBpBtgybxm/nzhUi4Gzp
 /66Giz0kikBV0O8CiBEDFlkj7hdM5kWM+Tuq+qqhau6k+91RNP3LrdyPkOwMbsbkC960gS
 EzRFUhhI4pWfEY2rlySU/6PApxQsYzk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-kNwCpPrBPEKq-w-PTlMjmg-1; Mon, 15 Jun 2026 15:40:27 -0400
X-MC-Unique: kNwCpPrBPEKq-w-PTlMjmg-1
X-Mimecast-MFC-AGG-ID: kNwCpPrBPEKq-w-PTlMjmg_1781552426
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so37340455e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781552426; x=1782157226; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=83xUQYk0WNw//htfkZIQVB7lo3e4TfiGP4u3TF0wUFI=;
 b=iT99n4UdMXWYIxdgb+B8PsmabZ8D0v1hkBmhqbVUFY9cmc/jeF91zDXH/ihnc0R3RQ
 0/mhw3bROS+Pj6vp4zpQW9dP8+U9hiZek3AvftYi+FhZwtkkdfb8EDZkpiY0Hri7Z03g
 /I3cyfDQYgAoQtIl537fsn1FCXWt/7gaSPadh2EVn95QZj71+vwrWS7hZP7OFihgsVMo
 YRPdxam0n0IDLXf16Vsa71hAg1q5fudj+Z+EI0BKpDQ+/HwSH46/+YmVgVHToafh0tsy
 DmFrpfoctj36cqQd3vK6J0Vl+3h5T7XJZiE9XB3prTC54ZFWCBAM54dOFFlSkuS6B/oI
 oLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552426; x=1782157226;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=83xUQYk0WNw//htfkZIQVB7lo3e4TfiGP4u3TF0wUFI=;
 b=Eaxp+rSUxD0OCxbJRIBfGBeKDKsDqk4BEnsr2mzzGMl4ivH+wD/QB51em2BvnRmM22
 M1Zmjq1l9AX2QOl79QVc+RM/YqSWcoQZuZgK+IZhgDDlsY9AFcIlRfkhKMY1rXnGuB06
 X5rUjMmEGoT8mJDfuVViz2pSZWFL8hXIehNZ/vfgtgoNZ5BZivIn1W6Le6R/lGXxwuzz
 C3HF6qEjBLQFe4oKTCo53KRk86QyW4AjUvEiL3F3ZUElrM0tIDB24r/06EKyopAtfd9q
 PZ45QTneA4BQI4TuJIqPi+klTigqDHqnOdbiqDG+kk5NDQZ8cJhIAYRsh3VbyufiMgUy
 vcOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sE9iU5OqxnNfchVdy2YelvoMXqOez2HKilPQd61EXDNPVeuUrLW4ih+WfLdL7hmlylwkagLTX+euW@nongnu.org
X-Gm-Message-State: AOJu0YxRbxvJ1EDY6zZhOsT2GX38fxDGh7cP5DNO/cRVVLhS+ksiCMiF
 9+hZdB+xNfOlmXqnuErqxa1iBaRS6U5aHKxjaR3KwClTUFSyVrtoWG4Gq4JHJz9A1XLKzUWQVOf
 Q4YXaXWKXP8iKgqGvCTqAUP5gWXMioGERFt/uGPfvxvdeOU1GmvIZEcuz
X-Gm-Gg: Acq92OG0FknLbMu9u3kv5e6rcL0Na/tTKwKegdtxMpbU9jfLColxWly8y8k56t+LtQ5
 LreiF9GGbglNqa40Px9u4UeI7opDj0Oxk+Cqavcby685qd8zc5pApsafyabdbHFU+/X0kZYhhMj
 IyUPEjhpC5hhtlcH+6JsEC8meXTnO3hpqE7LTUswKOKJ3A0PD5TecmsCroGkEkBScPh6WN01T7D
 IAhgFVNaPSzzORHiI/sfPwryvQJflWJn4kpmdVkYradS+n5eOiDA4LZ5fIbT7QQ/GmjVczLPYhO
 Z/yqlPVI0TqTAOMXHK9seCD7C/a6xPonmLT+J3QT9IeNW3QywOK40IAs59/b6emiaTT23PCtiFp
 +LLeX4gonCtSZ9Le+F50A+AqDzKm92zWCmTiQly7DfGc=
X-Received: by 2002:a05:600c:348b:b0:490:e5c1:b89e with SMTP id
 5b1f17b1804b1-49220061e38mr155820825e9.10.1781552426047; 
 Mon, 15 Jun 2026 12:40:26 -0700 (PDT)
X-Received: by 2002:a05:600c:348b:b0:490:e5c1:b89e with SMTP id
 5b1f17b1804b1-49220061e38mr155820525e9.10.1781552425582; 
 Mon, 15 Jun 2026 12:40:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa5120esm16461965e9.8.2026.06.15.12.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:40:24 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:40:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260615153757-mutt-send-email-mst@kernel.org>
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
 <d0d18a5b-1178-416d-81aa-d6d5f56ae3a7@redhat.com>
 <fc1213f4-1500-4282-8c98-8ddf10d4955a@linaro.org>
 <32c4a353-1cbc-4d3e-b05c-a4324e985426@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32c4a353-1cbc-4d3e-b05c-a4324e985426@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 16, 2026 at 04:09:27AM +1000, Gavin Shan wrote:
> On 6/16/26 3:03 AM, Richard Henderson wrote:
> > On 6/15/26 09:33, Gavin Shan wrote:
> > > > Either assert n != 0 to start, or use while not do/while.
> > > > Because the body of the loop won't handle n == 0 correctly.
> > > > 
> > > 
> > > I will change this to "while (n > 0)" since we're not expecting
> > > "n < 0" either.
> > 
> > size_t is unsigned.
> > 
> 
> oh, yes.
> 
> > > Could you confirm which stores need qatomic_set()? There are two sets
> > > of stores as below. I guess you're asking have qatomic_set() for (a)?
> > > Could you explain a bit why qatomic_set() is needed?
> > > 
> > >      // (a)
> > >      *(uint64_t *)dest = *(uint64_t *)src;
> > 
> > Of course (a).
> > 
> > Using qatomic_set prevents the compiler from merging the stores, kinda like volatile.  Not especially likely with the way you've written this, but if you had exchanged the switch and loop,
> > 
> >      switch (lsb) {
> >      case 1:
> >          for (; n ; n--, dst++, src++) {
> >              *(uint8_t *)dst = *(uint8_t *)src;
> >          }
> > 
> > then the compiler is quite likely to "optimize" the loop back to memcpy.
> > 
> > It's also self-documenting what we're intending with the store.
> > 
> 
> ok, thanks for your explanation.
> 
> > I guess it's also worth asking if this copy is also used for copying *from* device memory.  The commit that added memmove (4a73aee8814) suggests that dma from the device uses these paths.  In which case you'll either want a separate function for that, or both source and destination must be aligned.
> > 
> 
> I think it's a valid case. Lets handle this by limiting the 'step' based on
> src/dest/n, something like below. atomic_read() instead of ldxxx_he_p() is
> used for loads. Please take a look if there are anything we can improve
> further.
> 
> // Not compiled and tested yet
> static void qemu_ram_copy_unaligned(void *dest, const void *src, size_t n)
> {
>     uintptr_t test, step;
> 
>     while (n != 0) {
>         test = (uintptr_t)src | n;       /* alignment enforced by source */
>         step = test & -test;
>         test = (uintptr_t)dest | n;      /* alignment enforced by destination */
>         step = MIN(step, test & -test);
> 
>         switch (step) {
>         case 1:
>             qatomic_set((uint8_t *)dest, qatomic_read((uint8_t *)src));
>             src += 1;
>             dest += 1;
>             n -= 1;
>             break;
>         case 2:
>             qatomic_set((uint16_t *)dest, qatomic_read((uint16_t *)src));
>             src += 2;
>             dest += 2;
>             n -= 2;
>             break;
>         case 4:
>             qatomic_set((uint32_t *)dest, qatomic_read((uint32_t *)src));
>             src += 4;
>             dest += 4;
>             n -= 4;
>             break;
>         default:
>             qatomic_set((uint64_t *)dest, qatomic_read((uint64_t *)src);
>             src += 8;
>             dest += 8;
>             n -= 8;
>         }


If the length is > 8, I feel it's important to just use memcpy/memmove
normally.

Because at that point it's a large data transfer not MMIO, and performance
is important.


>     }
> }
> 
> 
> > > Another unrelated question: why 'int' value is returned from ldub_p()
> > > and ld{uw, l}_he_p() in bswap.h? They would return 'uint{8, 16, 32}_t'
> > > values?
> > 
> > A bad choice 20 years ago, and the need to audit all uses in order to change it now.
> > Newer functions use uintN_t as you suggest.
> > 
> 
> Ok :-)
> 
> > r~
> > 
> 
> Thanks,
> Gavin


