Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84983C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 10:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woIwX-0000i1-Vc; Mon, 27 Jul 2026 06:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woIwJ-0000dG-Db
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:52:10 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woIwA-0003Ct-PF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:52:00 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66807ba2f0fso3171446d50.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 03:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785149517; cv=none;
 d=google.com; s=arc-20260327;
 b=FhTSQ+O4Et+QyriuuV1Q60kQ4h3TerSoMwh4v+ziLVztiM7yON2LOOuailLsylK2LX
 ywvKTBlsG/NvF++v/JIi9FXWaK5r42flrRPR3PvBGgOT2mNhmGKsYSwyri7DeE7XdqX8
 OhGdLLcTchRdomAur/Y05glfr2C24CKWJAPnCI+60T86Bo3sTkrpzF5e7COybJER8uZP
 yTEdFBq9AB9BtQ7XaOp06AtcABlAl440Uzgy5bRhSK6/UtOPPTlarYGaQ5O2X7+40Cl3
 2vSwKu2QFNs4k0TUW7lth2YAy1hLekV+sEpIL2NBCF3/9eMcFt6vBBTUMxmFQzz1XA4f
 zbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ff/BxMSzKTlyWyEKFqqDKCnrdAATxliJpkC0anLLGh4=;
 fh=9Fns8Nnf372gP5UinSU2iutduXM+JyIua1QkDWjdyUg=;
 b=iBeSdGqnq3cXGlJrE9ZLUjrvrZh8OY5ssbCHHe0IF5muJYdpHmKbcdyRgfrqNpg/TG
 2Lzsner9u3DTpq2fAe0vfBLREUhhDDugLczO8J4fNZaU6liVM7pvIo6i5EO77iMk6gzr
 sKSsgjG1Xf0nuPV3Vs93a/H9j6v9jdMlx5wg6aRim1b+aXz3l+sABfK5ak/qY5VKP89N
 V2UzQ2TG4R/rUOheii0a7ZUWIEusCuujKkwqhqaFU3GTtm/RYol1L8wsb0wzO+fb7+q0
 fgMJEnd522sFFoNBdymAYCES2xAE5cJ5sxFeSGo1HUxN60puKDZ3qLuy4CTp+Qv6idLi
 LKjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785149517; x=1785754317; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ff/BxMSzKTlyWyEKFqqDKCnrdAATxliJpkC0anLLGh4=;
 b=tcj2cohCjS464Dhmsl8DMqih12l2qs/lfQvnnGRv52MTgBPabO93jhuGpZlWQxZ/bH
 x8Xmpw++YI9TDTN82Pf5MS1n9hDQlwIwrEdoJfq845iKErUJOR/Ri8r6FNGab9k41+D4
 /Pv7+hQ5lV35jRmOmYvG+Bn5H2SaN2lJMXpW51plPW2N6W2+yaNJkxz4R/rxQqRrFi8T
 U6ojag5h5uufjnEZCCAqP6u3xxNKsaQ22LgHLwi+nziT12ALjT2WtrM1UQvnfCirFg4P
 bFL633bSgD7rXpreldPygvBuewxa7z5WWycev9AtB99pWeBoRtLTaYqOhwjqnbcnwqet
 +7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785149517; x=1785754317;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ff/BxMSzKTlyWyEKFqqDKCnrdAATxliJpkC0anLLGh4=;
 b=CMSzCVj3e7ESZIIj7ysaXUsgbyqBLWf68dpImbMHBqstjaEHDZxErq3L8P3C4STTjU
 OfSrk7btwByqyZzBL7x3PQ/k+ou5x//cfBuXW17RWdVcGmBbxfOxbUGZ5xkDHXPmPwAb
 w2zFwu6d4Te8MmOBoQUetW1oCNkfRvmmUjKHOIuGI0g/lnghd1IW8r03o6+Y7uDC9Ren
 LK8Ybe8azSK/ZIcymUq9kl6vi9ct0rFgmanbwJie69IakdhsQLkM+GXiCinuutnDA6+F
 G5SLpHD64WE5UZKO365SoIG5asWSELnTmcmaE3RIsZYcFQKYDiGUMGQc8cHQHrvFZj7s
 Kbjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrchGDCCJtj4HYP3tzrR7BK7hX3D6eY8TxTH19wHAvy7jnvVhKDoAKL9bIjPZtay/et1tMBbBvMSEA9@nongnu.org
X-Gm-Message-State: AOJu0Yw9nd5IxbNUY/lmo6EzjvHbOxvw0up960Dh+cZWGXJNBCOSNc9+
 BWUju7/mTr6OpGS45aFzkQ0YuUAYhycMigBVt00OUTjc5orx90l/ixnKu+mHPv2+r7sLGKeCRma
 eKF4V11Pk/5l2nJBratBoF5VswXnvoAB7u/i95ZcmoQ==
X-Gm-Gg: AR+sD12sAnhV61RtPepSFWktmP7EDmYeZlb1GFWGa+29G6L3X9WhC21H+baWZ+rs6X+
 rqpPij0rnm168m0+PrQ4VbRjmCzLh1YXbhq6UHlt7N+QDYyS0IzOCEvRQEKFllBGRw2Zi+mhV9m
 1RGj3KUGv2bxPGVH8KMK9O8Ot2ZXQAANQyVWJG3QyU6dn74ucNHWigWHtGQT93df2zzpJErB1Bc
 jYATGmsUb/zSC1KBnbLcmFSCvHxItiEfiIliqfQf8V0NC8ZuaO6iqERSiKBHiUWeDHVb8CfKEPU
 pftwtLs3g2N9bgUgyFUtIqJvo5oXJv7tqOfdhOdoNy9gk1S5ozraknkN
X-Received: by 2002:a05:690e:4854:10b0:664:e8ac:21ce with SMTP id
 956f58d0204a3-668c79e8708mr1676378d50.24.1785149517320; Mon, 27 Jul 2026
 03:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-2-gshan@redhat.com>
In-Reply-To: <20260727032649.145381-2-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 11:51:45 +0100
X-Gm-Features: AUfX_mzZhc8aDsTK8wb7UVIuJjvXh_LXSXdQuI6Q99SCQrwpScDncfpuT3-PJd4
Message-ID: <CAFEAcA9cmvjq9AJYrn9N6ZmPYDynd=eFfWtkar5wQpdS5KqgZw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] system/memory: Use memmove() for directly
 accessible regions
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com, 
 mst@redhat.com, philmd@oss.qualcomm.com, richard.henderson@linaro.org, 
 alex@shazbot.org, berrange@redhat.com, philmd@mailo.com, david@kernel.org, 
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com, 
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 27 Jul 2026 at 04:27, Gavin Shan <gshan@redhat.com> wrote:
>
> Similar to what's done in commit 4a73aee88140 ("softmmu: Use memmove in
> flatview_write_continue"), there are more sites where the overlapping
> source and destination buffer are allowed for the directly accessible
> regions. Use memmove() in those sites, listed as below.
>
>   hw/remote/vfio-user-obj.c::vfu_object_mr_rw
>   include/system/memory.h::address_space_read
>   system/physmem.c::flatview_read_continue_step
>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Even if the overlap isn't possible, it's definitely better
to use memmove() than to have to think hard about whether
there's some situation where it might happen :-)

thanks
-- PMM

