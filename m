Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA629F3C27D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztlM-0002J5-Ji; Tue, 10 Mar 2026 05:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztl7-0002F0-Vw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:52:14 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztl4-0002NI-Ty
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 05:52:13 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-662ac74fd85so1753997a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 02:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773136329; cv=none;
 d=google.com; s=arc-20240605;
 b=a5mfJGsVYcI9JR1pNhKm1ajoEKnaZX5qDx++s20bMYubHdTWCocHBRjJJk/YUB49o0
 NZdFYj1kEC8HcIhoRS8KR9wraU5ZQgUc0LVIGg6xKekZqkhEzRmuprYk2QmCG9+lo1uN
 Gm6Sb5gCILIFmXI1v+Zk0NnEHe/ymC6BtaSVtezxNfhToarT9eSvmf2XnX0JzkCCcYBb
 hWj6kdX0z1dGiMLThKKojWlIuUL6GG5mQkiosFXK7UzeZZqZi5AXrVlQTtnzwGlr9Z0z
 k/hQF8OZIVUYGzOifQn7+mQDrR4gl3Mipv9+Zf260NaDm588axhpaj6S7ZB5nNmzRmKY
 cx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=be+qqeuv3XlqTHhJTpk+hmkkzRVAtgjNi2FZuRSrqF8=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=Da6p1GHWDRg9lH/J2KzVRXc+MWtdFGMgokWK3BhAKfTpLZ1Mt9Vv/J03B5G8/bV09L
 NFmcfGScFkvKfHhJ0d/oHqGT+hiwb6ETeEfHl8Pe0C4l9inDsUPgL78wgiH8lJl9BM4+
 oXJRzvusA0Bh3KkNHT6BleEltM9tXk4IkUV50Ade7aUe+ckwHECL/16LwMlOf+6ktOjD
 SGp/c49+8+AJ5OHs+TUpSr6WGy+2vmQNilSEla9G2mbRWiBV64IjWknAwOvK8bkolLAR
 Bsbjo6XGAX4fYNAxKMhV104MnLC3Nny7anRVvV+37OmbuDeqFoiHej4PQC2Dp9cmBb4H
 kfCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773136329; x=1773741129; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=be+qqeuv3XlqTHhJTpk+hmkkzRVAtgjNi2FZuRSrqF8=;
 b=lbuPNFmFNHeI4wMhdhbXNA6uXLXv5uCdCfNv2BdYboCv73oBshl8/UpMKpAzDDmdsk
 RGc6UiinmcLH+tGmluMT09julx6yEHJmYrGhxo043aHHIJTmVuiH+Ds6EsNoiBIQfG3D
 DnbNRqYdTXdk1W5pA0IFRzylQZX+MrasD7mMRYoV/4hw/XoPSoWvcqjsRJwq58k2Rflk
 0hZgEor/c6XD+D4F2KbDX/nKQrAC2s6IIM32/Tm2tfpAuKCprfPsxhO8z50c5gW5ITOe
 6HlUpYivPkpbQ2Bjk517IutigkedZGFDe/kpng4tv4b/MrN0YMWCgT9bGSmC6+qVzLMu
 8lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773136329; x=1773741129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=be+qqeuv3XlqTHhJTpk+hmkkzRVAtgjNi2FZuRSrqF8=;
 b=cuFyrnx7oerAz1wPh21UVbZOCMTBdtvy+etutB92RpnOWHSqcWnJAsj3spYXQOH5Dx
 3Istqom4MK1HUAdDGm3/CMpe9jS1b2OTn4lgEADCtK1iwtlwe5wJmXchClnnEu/Y6Uth
 uiOf8ymk0H2UubaRXCEuAqchx8aHX8c6z8OWp6vUn+CoS2yX89ILcvfYJkXRH8w3j9uI
 9zSU5otbcWcAZil9fNB2i9R/TRdFuyDCIZCAkzEw4/4gYsKRNwL7HtdaSgJ59959x9D8
 x6ESLFWcVFhXdN2T+5U5/PcPwbokxX2wMSt52YUe2SbLPeesIPHf82Q1VvxRdbEatzlb
 ltLQ==
X-Gm-Message-State: AOJu0YxdiPJ8lUWAhAPnoZIjzCFguILYQl2VV46wT2RkszOtrMQNi3NU
 P1m3Okx5g4jAZupPq//JYqLM+IqMfe3KVt+96FR0DP4zdQZKF68agw3jNTA7x8Cmh+Cf7Njpfml
 H3Y6diqqsxrZcfC076NVbzVQSmzFnegM=
X-Gm-Gg: ATEYQzzQez3nHbYNHZVy2mCPpmRBA3oeXI/LjkHI7gvytPmD0ArnSytMyivfBygBEht
 Xp97RaCeTQsKUk1OYahjE6fG2YtSG+Ri9ERTJMwBrzZtGack4rSe2WTwHbpYOumDZVgkRrVm6um
 6qvUmZsShaVlWggAhD93XM8M98zP+pC8Jy/KmkOUH/b1wqaPMrGGFz4o6b2nis66jPM0fEdkKdN
 spqtiVx7Q1ZgDKOYFw7x8spn7UejbHbI8+w10z5v7TV4ITP1TQgJ7ARteY3k6g7bHWfFtcrk5fh
 Sbb1DW4=
X-Received: by 2002:a05:6402:399b:b0:662:d11e:e680 with SMTP id
 4fb4d7f45d1cf-662d11ee964mr678680a12.32.1773136329003; Tue, 10 Mar 2026
 02:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-4-zhangckid@gmail.com>
 <20260309083346.GF39949@fedora>
In-Reply-To: <20260309083346.GF39949@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 10 Mar 2026 17:51:32 +0800
X-Gm-Features: AaiRm53tIVblWlB_ZtFj6gjAUf-ShAxXwxqHIDxBzxK6bQRk-C7yzeRAX16e-M0
Message-ID: <CAK3tnvLn2-r35s_NxZWu9W4T67OB75A4y9toQ+f_hZu-3MwS2w@mail.gmail.com>
Subject: Re: [PATCH V5 03/13] iothread: tracking iothread users with holder
 name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Mar 9, 2026 at 4:33=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Mar 05, 2026 at 10:24:49PM +0800, Zhang Chen wrote:
> > Introduce iothread_get_aio_context() with a 'holder' argument and its
> > counterpart iothread_put_aio_context().
> >
> > Previously, users of an IOThread's AioContext did not explicitly
> > record their identity, making it difficult to debug which devices or
> > subsystems were pinning an IOThread.
> >
> > This patch enhances the reference counting mechanism by:
> > 1. Automatically incrementing the object reference count when a context
> >    is retrieved.
> > 2. Tracking holders by name using iothread_ref() and iothread_unref().
> >
> > In iothread_instance_finalize(), we now retrieve the source name from
> > the GMainContext to correctly unref the initial internal holder.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h |  3 ++-
> >  iothread.c                | 28 ++++++++++++++++++++++++++--
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index 21a76bd70d..595abeefbe 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -47,7 +47,8 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> >
> >  char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> > -AioContext *iothread_get_aio_context(IOThread *iothread);
> > +AioContext *iothread_get_aio_context(IOThread *iothread, const char *h=
older);
>
> This commit breaks all iothread_get_aio_context() callers because they
> are not yet converted. The build will fail here.
>
> Every commit must build and pass the tests. This is necessary so that
> git-bisect(1) works and it also makes backporting patches much easier
> when there are no implicit dependencies between commits.
>
> Please structure this patch series in a way that keeps the build and
> tests passing. One way to do this is to give the new API a different
> name like:
>
>   AioContext *iothread_get_aio_context(IOThread *iothread);
> + AioContext *iothread_ref_and_get_aio_context(IOThread *iothread, const =
char *holder);
>
> That name also makes clear that a reference will be taken on the
> IOThread. You could then require callers to call iothread_unref()
> directly instead of iothread_put_aio_context().
>
> One of the last commits in the patch series could remove the old
> iothread_get_aio_context() after everything has been converted.

Make sense, thanks for detailed instructions. I even considered combining
the later parts into a single patch to solve this problem, but that would b=
e
too difficult for the individual modules to review.

Thanks

Chen

