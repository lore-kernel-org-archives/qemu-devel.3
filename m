Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BF5C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmXBU-0006yT-BN; Wed, 22 Jul 2026 09:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wmXBS-0006x5-4k
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:40:26 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wmXBQ-0003eT-I7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:40:25 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-39c8dbf4ef0so113376311fa.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 06:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784727621; cv=none;
 d=google.com; s=arc-20260327;
 b=DMChYIB10GpzqHdMcxns1EokoKId65RgSnovtdhgIv0d65kK6mHFhUgq87YAs9K3CY
 hRsNXXb568XrM42M0qEJLpcGuh8oUYX4DD5ku5mvrWdoOtKR5X4hM2nzBNRWu1e/hM7k
 zERQMSK05GjDcZ6qpiGvy3TG+d7K/kZT7gphUWXZMRhb+TYkApkFalls6eLFuXypoBMf
 gtUFpOmRwrqpYgMDjoF/BZXvf46ye6+3cfzwnO3qcTsQjDV5vqfrKVpv7UoRthwuTD21
 uwSFEJbhImvDvlHWMDTbRBfBDTHzB/uF8gVMblbdlLxZS/dKBMvnk44ByftPisQ8hpr+
 DJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BwClKtYU9l5zRTfDEWhXM+pZrglWGqf6ussmPagP47E=;
 fh=YYFlP8b5nG0xp43ekYQGYSQr9uembBeNxJ16OtaRW/0=;
 b=d1WWn282ITonzurJuhNuYB4wtzjFt+wxEjp2xnxSyq4fZDUJYzOrO9yuWbpzJioTMn
 7Xdrylw7DaA6IVj5NDO7CduljMCwKl9eo6ZlfHnZzZW0mr/pfHZKDrxzseVbbe5aVhQE
 c6KX6aK5Rm9c9vc3yuFi+TsOyfhqxkouPFJKfWnDLeJP1DPHXwYjL6Kl5d4Xt1ZKuouj
 U3IO2UvTtQ/SImFE79fSVcRNMXZjO4YFCMGGdcO/tQ1/VEZ8IlHSmG9dfgadsNldesoG
 IkUtq55J+DJWOJ2xE0s86YgX2UWhqMiSuquPBBeAhwZpp3f4wKKz7HIa9HN62tj/q1Ys
 3FHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784727621; x=1785332421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BwClKtYU9l5zRTfDEWhXM+pZrglWGqf6ussmPagP47E=;
 b=aIWuIjUH7SM9FUctJtymb9ANc++vVHYmAd/awaicbUyKOU8YxCS2NwiDrc4wja96AS
 oEl27IZDF/PCu06wJ52uJcFsVv9qx/UgKe/SBGojKam9yMErYLPOuUTPDCg2EzmUN/Xl
 DSod8SsqzZe4E2xBtd6J89gtAp15TauCH9hBMhK9+9ceDPMQved4mj3GQzG1MyqLedAN
 fmaa+qmc2Vah3UDfuBsZaR6OKqRTnAvpZrimXY3ErFv13PZ0EJF3mSG9bm2zTx4j2I3F
 oYZrJgq8qZwmX2xfNiK/Pseu2e9EYgunetVG+Mb+UEDX0q1Uf5q1mWLM3ugka7kyNcCN
 a/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784727621; x=1785332421;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BwClKtYU9l5zRTfDEWhXM+pZrglWGqf6ussmPagP47E=;
 b=a6BsQA9pyLSSwqs+K5LE7YiAX2+s9ZQvinUT60AEmqomycbNel48HbmpXdIhZNGn10
 A8cSKvBO7kR/mObmiD+kQKxQiENoWAmowsLMoLEa7IxcohaP9FPMFh/GjJfqF0sJ4qDA
 YX3eeK7Z3FdkgRg7Yh7a/D+Iglfl9akD79bgzO5DF246MeUW4zyVHanNVJqYW85VIwQp
 74bNkFfkPhk9nozLP1QqK0NWy4CJx0Ho0PFgdy/X+ylJLBCktiKLfmykclBe6wdHntsm
 5jKJ5Qn1FTniMBfcKrT3TPbrMV+I8Uo5y1MYP+tUYhewQXLgp47fttYnh4GAMXlG047X
 fNeg==
X-Gm-Message-State: AOJu0YxNFoeK1MlB6W9mI8thzwSKAC1aGlg4rZgzpRfjOoa+w47Sp6Pu
 tmKkh7oLeOH8rFxv3vzJFWltTJFkyLs/TqyQwEPCCA0HQ6oPc6e2LPs2CjTZdPMZynpFUyW343w
 qePs81+j93aiQVi6cDE3lyv04XznFqxk=
X-Gm-Gg: AR+sD12DbZOucJNpW3aRSfUvW3wF/QRY8eA4QvkPWnMXnsUHLlTuPKucNqrNZHAFRb/
 VeMXZEz9EOWDBktwYQrM+A3Nw3Sedal+Ll/Q97/jSHrMJO8N0gUjOb+rpGjx+gV46nJnmmqVEMG
 NBtdfBjhx20vvii+46F1Ri7jDR+olLQV/TJmDoQG1juLZj/ckaFrhKVCvcQSfxCjKX2fuOP7vUN
 jT1qPgAaHDOe2LupRnk47agr1FmrVoayB+ck84Mweop9wGM9ls39bloNkxCIUmqLlvZDZ102W9g
 HEo22GNkDpRFL1Ztng==
X-Received: by 2002:a05:651c:4388:20b0:39a:e29b:7915 with SMTP id
 38308e7fff4ca-39eb287812emr39065151fa.34.1784727621099; Wed, 22 Jul 2026
 06:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-7-aadeshveer07@gmail.com> <al5rTdgBKxKOMCEt@x1.local>
In-Reply-To: <al5rTdgBKxKOMCEt@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 22 Jul 2026 19:10:09 +0530
X-Gm-Features: AUfX_myzkVeD30qXcOlkvd2djAi8dvGGEcfCxKtgjIR4Ofz3CCPQyxDgAssktEM
Message-ID: <CA++cPvKFkx45t2f-zz8pA1zM=4PTLjEszHDtsUXFp3yspKVvzw@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] migration: add RAMBlock field and helper for
 fast snapshot load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jul 21, 2026 at 12:09=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Tue, Jul 14, 2026 at 07:45:42PM +0530, Aadeshveer Singh wrote:
> > +static void ramblock_pending_bmap_init(void)
> > +{
> > +    RAMBlock *rb;
> > +
> > +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> > +        assert(!rb->pending_bmap);
> > +        size_t size =3D rb->max_length >> qemu_target_page_bits();
>
> I forgot one thing here: I think it should use qemu_ram_pagesize(), for
> huge pages when the fault thread or eager load thread want to figure how
> who to do the work, it should always be in host psize, not guest-psize,
> because that's the granule userfaultfd's UFFDIO_COPY/ZEROPAGE uses.
>

Hi Peter,

Thanks for pointing this out; I think I noted that but missed changing it.
I will address this in the next version.

> > +        rb->pending_bmap =3D bitmap_new(size);
> > +        bitmap_set(rb->pending_bmap, 0, size);
> > +    }
> > +}
>
> --
> Peter Xu
>

