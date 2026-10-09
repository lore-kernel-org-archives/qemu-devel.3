Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2CCCA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF5k4-0007hf-34; Fri, 09 Oct 2026 04:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xF5jg-0007gT-IK
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 04:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xF5jf-00047b-0H
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 04:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791533626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=41gQb0etbYvNz0VPnWEcsAX1WcPaermMt2xzNHfKl4A=;
 b=HaS0frP2Av8WppwdR2bD6Krg1q8W5Fmvc6GWGh6yfDGv3vAdj3DvobXbKY1zTBy3I4tPUe
 Emiy7Bf81n/+sX+8SgCfwEXChoUgxoNL0ZE6ozThT5jxGJGoLU+DFmpC2XPHDk77//6zpb
 W/JtXwWCK+ntOXweqVAQMljhwZsgPQA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Y6MgBM4vPaOGJ0SmmtmyvQ-1; Fri, 09 Oct 2026 04:13:44 -0400
X-MC-Unique: Y6MgBM4vPaOGJ0SmmtmyvQ-1
X-Mimecast-MFC-AGG-ID: Y6MgBM4vPaOGJ0SmmtmyvQ_1791533623
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a021b1b561so47070945e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791533623; x=1792138423; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=41gQb0etbYvNz0VPnWEcsAX1WcPaermMt2xzNHfKl4A=;
 b=kstYGRrcRnD1DRPRfhT99L/dUC5KSSumo1JR/654cK30TqtwO9p9fhEAZOQda1vIAm
 GOHc2tRV8sBgIXBZRpT4zQGakkGbENnhfr4X5TQrRlxSwA37GhdV6RgsFI2at/culcbq
 obDAGifEbVNJSZrboes14ysuGp04GMj0WiKJYNiZrsv4gSmGuwMgGCORD2CIEmMCApUE
 y7xRk2Fa6LFd5gsJ2bRQptoRUrbI1Mu7a24+5TboLAqi2hhpjXH0p7lXX9h/xNEajhN5
 LBwdy8PFs4NTfLH+laDt/6UlTQVmUilMTlVPZfav8rGZxdKzU2cxOhKrOjD+Lhxm77iJ
 KHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791533623; x=1792138423;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=41gQb0etbYvNz0VPnWEcsAX1WcPaermMt2xzNHfKl4A=;
 b=pCdS2TqB5wwG0HQI7CQciHzQ58iioOYU4sZaBvvuXd3wirwtjNwVCu6lbxCGHRVCDu
 u0Pu7G9ykFLNKc9T/mUR4YPC7u2fAXO+DH5SICV53XzgWTi/X9FyHbbvptm/PRjSFlG+
 Bcw/lknl8o/eM6JaZb92OL05QPl9NDlhnkWrV8y2GHRwS/AtdPfBaVl+P/rcwaiwv0og
 l2BtG8ZSN4noxb60U60/dAFvJcNqnmmJ3tcq6LaIBi36JxrZKBXdosjuqiGxfm2hHTDY
 /Uml29j2Tv2b3irJBJcdwndNjxMnuIdAhBIXm5IUgWidPjdT+k14zgrSKPThnBYEqx8O
 Q+nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTZ5KrFf1UKQ7X0yLkEG/rgKaADqdeio0tUvU9I9OaKtz/5PuJaA9r+Upi7DwsfkozpjoYg4E2zSKU@nongnu.org
X-Gm-Message-State: AFuF++mFlxrmylk8nd8ej1igjawuYUcfspnT1kRdOmdsN8IYX4z3ToLX
 I2doYOYEBlgSxDQyogGqEES7bSnhtOerwMgtfHOMg5OErpYBZXhdTHIQUrxoUdSaBvLl6FOYhEo
 8PtM9KHD3isfvHVjWMwwfz4lyV7uDxNVKf9QsNNiujdkLYUGkMD8nqUDwzlwAaJNV
X-Gm-Gg: AYBFou2raMbhrzAUc1QlH23Em51MKB20ngg/feGQqv0snfi7G5bfag2WtsMkQOS3ukG
 vA/J+j7HM98EdM+fcxvdC8sMQUSPkOJ8HBtjBI7ZKc58sRii7zV9U2+RHVxjLeyRawgPXJ5h8Hs
 Ogh3UxfHawycwgYWw8aYgvchwNVnxhGoJlVYGBdpZubJlcMCYAqF1s/cRSYE99ENYtpdLY6Vg/P
 KzdJKeFqP+WcjrD/64h4V7t1bcSGB1yHTZyRYYSNSTT4d19mC3tm9u53SJah0y/elD2lG1pNf8b
 6LIU8Xks+GKFmbCF3lbGACvR7wDWzAgPcFrxvNEPL5iYliw/rw0SiuNk2g==
X-Received: by 2002:a05:600c:810a:b0:4a0:2391:6533 with SMTP id
 5b1f17b1804b1-4a18e4a954bmr15620535e9.21.1791533623316; 
 Fri, 09 Oct 2026 01:13:43 -0700 (PDT)
X-Received: by 2002:a05:600c:810a:b0:4a0:2391:6533 with SMTP id
 5b1f17b1804b1-4a18e4a954bmr15619905e9.21.1791533622596; 
 Fri, 09 Oct 2026 01:13:42 -0700 (PDT)
Received: from x1 ([151.67.89.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18dd7a3e2sm35001475e9.0.2026.10.09.01.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:13:42 -0700 (PDT)
Date: Fri, 9 Oct 2026 10:13:39 +0200
From: Gustavo Romero <gromero@redhat.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Will Deacon <will@kernel.org>, Itaru Kitayama <itaru.kitayama@linux.dev>
Subject: Re: [PATCH v2 3/3] tests/tcg/aarch64: Add a test for the 52-bit TTBR
 base address layout
Message-ID: <v3hmpi7kjifsrwxbznkqy2zrbi2i2hizrnia4bozu26f5my2xd@it654s63rz2t>
References: <20261007080019.350315-1-fuad.tabba@linux.dev>
 <20261007080019.350315-4-fuad.tabba@linux.dev>
 <4ajscli4c4ef7agtizxzdiopjseck5qwa6s4n4mmwwjdrqlnby@xit5l76dxm2w>
 <CA+EHjTxsC8K1Bw6fAMs6APaqVDpup8192dCeJs+vfeh2fN+6Aw@mail.gmail.com>
 <3dqmrslvb3zrr3ndzmcmy2tv5vqovntordzdjqkp2vn2deklua@qkcedhe4owgv>
 <CA+EHjTwnpaFRFEzT8N34=t6JzKn+x=a6GUqa1U6vH2e+vW6C8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTwnpaFRFEzT8N34=t6JzKn+x=a6GUqa1U6vH2e+vW6C8g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi Faud,

On Thu, Oct 08, 2026 at 07:01:41PM +0100, Fuad Tabba wrote:
> Hi Gustavo,
> 
> On Thu, 08 Oct 2026 17:40:27 +0100, Gustavo Romero <gromero@redhat.com> wrote:
> [...]
> > RAM_BASE is precisely defined as 1 << 30 because the way we link the tests based
> > on the memory layout defined in tests/tcg/aarch64/system/kernel.ld, right?
> 
> Yes. The tables are static, so they're linked a few MB above RAM_BASE,
> inside the blocks both stages map at RAM_BASE (and stage 2 again at
> HIGH_IPA | RAM_BASE).
> 
> > That's the bit that also confused me, like, how Stage 2 entries:
> >
> > s2_l2[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
> > s2_l2_high[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK
> >
> > are taking us back to s1_l0. How s1_l0 ends up related to RAM_BASE :)
> >
> > Hence, I think it's worth mentioning that relationship also in this text. How
> > about something like:
> >
> > "RAM_BASE is chosen to match the memory layout defined in kernel.ld. As a
> > result, s1_l0 resides at an offset from RAM_BASE after linking."
> >
> > Wdyt?
> 
> Agree. The stage 1 and VTCR.DS stage 2 mappings depend on it too, so
> I've put it on the RAM_BASE define for v3 rather than in that comment:
> 
>         /*
>          * kernel.ld links the test at 1GB, so the tables below lie within the
>          * blocks mapped at RAM_BASE.
>          */
>         #define RAM_BASE    0x40000000UL

Excellent. Thank you.


Cheers,
Gustavo


