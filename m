Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2F9C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkixt-0004fa-Hj; Fri, 17 Jul 2026 09:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkix9-0004Q0-66
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:50:15 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkix4-0001bd-CI
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:50:07 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-81ef11a0972so7375427b3.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296204; cv=none;
 d=google.com; s=arc-20260327;
 b=PL7IArOXJsP0guHW3hntwjGImwuYTDLpwzBKgLETZZfdE52gatCS14klbdt1FuJ1I2
 uW2r1iNvy/aLpAk0c2knf1jv6rpJbVygsQPhQUMni0xfMZwng9+1BHT6JhaRysqZKtwo
 sbLQohhJBkok3WimJGKQheOkZCEiAwwPxFcsGWDdIlxFj24vQVB6DUR166AyE3LHICz2
 pNL9GusfylAuGgROB3QBa3VvRKSDEh82O4/9iBPzdwAHjbn7IZsusVA355G0qLij/AqO
 qYR3J9df4IaXDhF7rBNL65BFoQkwA59A3TllXL4LHIciLzMCXkeseIh4KQvlww9ecMFM
 kJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fbnd4avmCZuarZm8evJ8GJbSYptpIMj9ydyywnXY8to=;
 fh=P385SY7ZQgiYT4UoVrmLvbOK18O8gTSYWdpx2fq+5qM=;
 b=tCNzpDGNpoPv3Aw/tD4I4S76ZlzXtbz9fvoTXxKs/IlaUFjbKGBSSQ9bFD1HKN518S
 KTNk7n8Wlm/51VhtM1uuhgGkoHyfDoIwRhvgRLwfpxcAlIRWELg3ddi6ATh89Bof46Rq
 zyGs5a8Vxo6Rdynpo32EtYP5gf4peK30nvCdRUMvqGIfiVVnWZs821x9qgVkK2e2NJzs
 ycS1pUmm5bFJ7BQAd5HShfsc42Y76rxWJVUegScaEoxWmMTyj2akrhjHIz4/AOabzVfH
 fS6NX84m2+n1byMyXWleeqxGvqqaDpA1g8891u4xh3/2U6TIqY/kRJ1UxoRkZUTzQ8o2
 ulMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784296204; x=1784901004; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fbnd4avmCZuarZm8evJ8GJbSYptpIMj9ydyywnXY8to=;
 b=s1jdsyWFuW8ihwPa7jkEZ7t7kcjiGEE/4L33LrfFA4y7pGPRVIj1Ee/bwqD9w0gYes
 4C7+crLt1l9GuRfl2yIOVTEWJOY2V9vlgDXGcU0pD3r5pAY+3nmThhwgWW0MmR1PPe91
 4/mQAQv1b/0+7vHiUVCM146lxsRJK8gZ9plBe4ial4/+cI6/8ewpvPfR7KBZcDmlZt0x
 2Mfu4YhVwtAARlM8biZOBU5qnqDdfGSIoaAg/5v2vdF1PtnA5ScpDJQKcE5NuBdg94VQ
 Z5kluJp5K4d1UY8Yqjgxk8vpUc6e+o0WV84jRkZXT3y4bdOXu6QSRR6iVjROOfhbmXUo
 YCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296204; x=1784901004;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fbnd4avmCZuarZm8evJ8GJbSYptpIMj9ydyywnXY8to=;
 b=BEQ5sZKAmGoVOxGgj5maedR3+NFUgJhM39H/zGFgSqMG0fNQcppoXmnnXJJH+jNOwx
 Z+01VUhlkEzacSLSpQ80PQVjETCrrwVo/FGLkTA4W6A+vqA0qWLFxHTpSyiuzLnp1jh1
 ql2z4/PbH1FNquqHnxMIMJYWBKk/7MLCw2gNFAlsQEWACo/vXOfpupKRtfxm06qO6WRl
 kAJWHjfeFtwOVW0Q3C6UXPDzk7SDT2ED3/0mKr3lRik27qBrWn89qzVFwcPKmJ0DCraA
 Nt+jesdX7SOd1bPuF83wYZaAg88W5uXF3ECwAcvLnKEIYZlLtTC9x/0IIWhAF6anYoBq
 8MFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUaBfXNenUvcfKR3X3xH+tJuPKoDyeOR0o37Pz1+HD41GqEZNNsbp8NeBYd663dRRmsdH9PdJhko6J@nongnu.org
X-Gm-Message-State: AOJu0YxfhWaSXDFGCNiMrM3bBuLlFqkvUwuGe9erSNuPaUOwitBSrTuG
 Mgdeori0yuj2+T2fdzKa+bNVCT4NXvlRDTiySZhn1M9ULdM5HqpSxXuVnOpbNjghTMN0byaF0Aw
 tzhnA+3r8kwXpjrY3Be6lsfp2WQOt9l0C0mreiJ6yMg==
X-Gm-Gg: AfdE7cm9btDlHZCYXj9++H//2TWuO9ffhjEiIh6Yfc/duqKU0HPrjQtm46rgoOI0IqI
 ENgFHiIoBe+7AkZuBlLnFxfS3+QegdDrEE2PNZ/fp6DQvKF4YUXf5Qm4+8CjPWju61kk7VgMFE+
 5wWJeZb8mYnl5hJRm2co8CCj/t6ASyxzi7kuv/bZ3ZIf6SxlS2SjjVqv6RBFFO0xogkEo3kPb05
 Zkj+VaHJ39g8oXhZPaszHysXNfwkkd9GZzfko6p6Xd89dmY6kXwuVAigKFqieRrQIhTeLK6WBqK
 rLues+fPJCyW2AGNGfXILRL8yU3e2wJ+Qsu9z/lwh7QcWw==
X-Received: by 2002:a05:690c:4801:b0:80c:85c6:897f with SMTP id
 00721157ae682-81ef263285dmr8165487b3.62.1784296204492; Fri, 17 Jul 2026
 06:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260625070551-mutt-send-email-mst@kernel.org>
 <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
 <20260625091334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
 <20260625101817-mutt-send-email-mst@kernel.org>
 <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
 <20260625123119-mutt-send-email-mst@kernel.org>
 <CAFEAcA8UjtXgmPC27fOKMwbaWs2piwGYudtwCNWQHuu3E_7A-A@mail.gmail.com>
 <5faf04b9-d596-4a1d-9fe3-5e9ad5f0a99a@redhat.com>
 <73f79841-8cc7-4ca6-8f6b-fb97b53a6fe8@redhat.com>
 <20260717091756-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260717091756-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 14:49:53 +0100
X-Gm-Features: AUfX_mzSQyLYQofBBh-fPCiowP3Wl9A04pifrBGZdwvQ1aWJUo0gu2VipGSTwAQ
Message-ID: <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, alex@shazbot.org, richard.henderson@linaro.org, 
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com, 
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, 
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 17 Jul 2026 at 14:24, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 09, 2026 at 07:52:12PM +1000, Gavin Shan wrote:
> > Hi Michael and Peter,

> >
> > Could you help to confirm if the conclusion is to have unified qemu_ram_{copy, move}()
> > for all architectures? In qemu_ram_{copy, move}(), the fixed sized accesses like
> > 1/2/4/8 bytes are handled by __builtin_{memcpy, memmove}() and fall back to
> > memcpy/memmove() for other sized accesses. It's basically what was proposed by
> > Michael :-)
>
> No. __builtin_ and  memcpy/memmove are same on modern linuxes.
>
> I'd say as a 1st step, on x86 hosts we can do a fixed size
> memmove for 1/2/4/8, on other hosts
> *aligned* 1/2/4/8 bytes can do
>  __atomic_store ... __ATOMIC_RELAXED
> and the rest can hobble along on memmove
> and hope for the best.

I don't think we should be doing something that's x86-host specific,
as I've mentioned previously.

-- PMM

