Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0804CEBF9C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 12:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su9vr-00058u-2V; Fri, 27 Sep 2024 08:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1su9vn-00057E-HH
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:18:43 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1su9va-0002DD-CL
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:18:43 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c87ab540b3so2593665a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727439508; x=1728044308; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qdWRG4GaPdJjcB8GvK3caSKLz2XLy6IwWrOQgLRSVhU=;
 b=tEPy7ka8+qyrU10z522gTIXjvtZtjC/n/R2KvRklwonW3GCdRuvFQCH7enDska2cUj
 X3UtB3a+GYJdB/V41Mpf5fwT3fUslBi3AGthP3KI7pMnfcmjk6PcpJDfQFhGP95ag/1I
 v/0XG+GFnrN2mFW9RlMRY2Fz4a6Ql5MVfX0Jkv2mKzz4dMJ88Eafq89/dQWvgJktOsVE
 6M0oL3uVKFQVgWcHpJDSBTsd3Ns8uMFR5Q+AG5HgKGWpzafssKlhvLHVlAB+/jbCnAO5
 1HzJrRnoOULNC998zRVouJ6LUkfhqyRgdLIDtqcn7scPyYYU8hVax4/H4zVivYYutxYI
 MAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727439508; x=1728044308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qdWRG4GaPdJjcB8GvK3caSKLz2XLy6IwWrOQgLRSVhU=;
 b=noxBJwulpdZ9xJbIygJG/H01lFzXMbTJFVzjU2U3PKPbhaOqN3mdVHXGdAK8s2fqAQ
 +RmBCt37CUWJq5V/OGK2EfQHRi714XAmCRkG/LHSGoFK+q1JzbmMVrjr672kdwwNqBXs
 RuSg23VcMDBiUzt5Oq6c7HuQkW26+p8/pDdWNFh763pY7kBHWDDZ9l0jGpQJL6mquEeE
 yZhHHG5+kVKSfOVFTnOqDtxhk+PxoKVqmEPljM+BvTuTqrqDAQOctKur8+BpTw+FP3Gp
 nNxpB6Htj1Kbw2CF1PYn/DiOZLYvs2GFmjN4GpTvJAZaLIU3nKKI7xiigGtUfZpBmZbt
 dw4Q==
X-Gm-Message-State: AOJu0YxZDYrDziKcOtoUCT5M3d7wwQYULnC84jEji66SyJQ1QKzmG5ko
 oA392Dod60NLGp84CdRCV3cLdMrUTw190mZjDGHL4J5oFghkdAqatcrNVMmw5wR0fuPny+lBf3A
 SMjhf5MDA2R7/Wye37iMIbh9nAXbEbIs9QMBQFA==
X-Google-Smtp-Source: AGHT+IHauj8a5MMHAu/3l26AcOGVcGbslBa0e2VTG+9NAqB5hIjrhBw47iCgLMkgugiOLjK64MS9pfXPcC0FK+YoN2Q=
X-Received: by 2002:a05:6402:2481:b0:5c4:aea:5833 with SMTP id
 4fb4d7f45d1cf-5c882484124mr3464084a12.18.1727439508214; Fri, 27 Sep 2024
 05:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727425255.git.chao.liu@yeah.net>
In-Reply-To: <cover.1727425255.git.chao.liu@yeah.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2024 13:18:15 +0100
Message-ID: <CAFEAcA8Kb-ym=Zd1TzcWuqRVbaKAG4TDF3VmZ8EfnBWW-B_Cyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Drop ignore_memory_transaction_failures for
 xilink_zynq
To: Chao Liu <chao.liu@yeah.net>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 27 Sept 2024 at 09:52, Chao Liu <chao.liu@yeah.net> wrote:
>
> Hi, thank you for your prompt reply, it's a great encouragement to me!
>
> Based on your review suggestions, I have improved the v1 patch.
>
> By using create_unimplemented_device() during the initialization phase,
> I added a "znyq.umip" device early on, which covers the 32-bit address space
> of GPA. This can better serve as a replacement for the effect of the
> ignore_memory_transaction_failures flag.
>
> Since create_unimplemented_device() sets the priority of the
> memory region (mr) to -100, normally created devices will override the address
> segments corresponding to the unimplemented devices.
>
> Even if our test set is not sufficiently comprehensive, we can create an
> unimp_device for the maximum address space allowed by the board. This prevents
> the guest system from triggering unexpected exceptions when accessing
> unimplemented devices or regions.

What would be the benefit of doing that? If we're going to
say "we'll make accesses to regions without devices not
generate faults", the simplest way to do that is to
leave the ignore_memory_transaction_failures flag set
the way it is.

thanks
-- PMM

