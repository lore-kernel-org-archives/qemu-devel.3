Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA544C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeUh-0002zb-Hr; Fri, 03 Jul 2026 10:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfeUg-0002zE-5L
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:03:50 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfeUe-0000Sd-CI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 10:03:49 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-37fc01a7835so495138a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 07:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783087427; cv=none;
 d=google.com; s=arc-20260327;
 b=fwdQrMKNclODfo5ztuyyY2foqcf21DGE9RVI8I4PaI06ws0C6YPGkzUKxTQitUFYLA
 ZlfZVrOyNsASjWjKThTjrFbtJ+rydHLy6NHPLT6vBkEuGrj/oDhMaZXLXS+N+nmt9OHc
 RVweg1N389Fa5VsQehnKouev6/TJDF2NtVVRuKG5BC/j16Eeu6q5BxBRz8hhsDq4GqCA
 AvaIYV9NXcbb0+XRbIPehx5Vo64hG2Uxz8rPpv83QFXaEBc1RzIsDe+sTE1PycnIDgNM
 154eeiL5a8O1Cpx0hZ0PPXbWtjnAchvOHiGhoZE4y7nsUv2W78ipGJwh6XYS9lSB4MmY
 VoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HCfeo1erMVY2ghZo8oTLmgsr2P2JvPmWIeclpvCNHCs=;
 fh=uuNB3HJ5lfFP196KPCH4BVFxtnvmD/oMG5FHYJFUI8s=;
 b=FdNCtsAVyNyuU6H0+Z7mOahAkewQMDaSMyBRQK36Slic+xkt+Hh4pQN1tD+Rp4FIoj
 OzipU6CEkPJ7QFVaBGLN8DMDPL4LsfvfLZAj8ao+80prhtW0wagn5ZRzEYhfHd0vjlEV
 ipnc815cxlZGBIRpMlAHpQPJ8vUG46BGWPSLmAA0aqqRJX5DQXJhDVmbEJgLrZp4sqT4
 csIUUETAogrRMQeuTyF4HTredWHUNlb+R17fQtQMMYIQFJB0e2CJMtS4ykalHQS52JCs
 SK5JRQzYbj7Qopx8r7+gUk0/0cKG6lJFZJpTm3+FdwEJj2B55ZGc58iBWVahJrpiaMh3
 CS0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783087427; x=1783692227; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HCfeo1erMVY2ghZo8oTLmgsr2P2JvPmWIeclpvCNHCs=;
 b=m7zxtjzIuHvjXM3RETeVcoNDqNig/zyoC5fkf663yh0xXAHH5jLjQqDzoI9ZJQfkQq
 B2viJBh7SOt6U+pDIxLslaRTCXdb0C7cUR6nfhfKYf8mkNDMB/wrTNjmqesgYrROFxOm
 oFREW/qXw5/8YeDzOyieEhhDOcP8ZOz3WaGMSh9UXiHL4wGj4D1FcKg1pVLTWnrMuuzm
 RCE03D9an191Z24thb4fIOHNGG1ED5PIBA3p8D9Ku2/f08xPxTFOKxsVb2oYWsOhyPTs
 JRZtdlZXjpixbWpqB/gTIerYEyO73ka/1h3fHvZgYhEFrAUuCh3MdA0wyw94kHib8JQc
 EH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783087427; x=1783692227;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HCfeo1erMVY2ghZo8oTLmgsr2P2JvPmWIeclpvCNHCs=;
 b=h1MhwB4OIL+vPucAcr5GRQowuMuBH2KQeFYopf99eLYpJNvZCnj5m+scZ51Z3tl0sM
 s1QKw4aHKQn6VqfOwu1FsYqi69i+NkpRAbCglwTQHczKOKfrdQGTe/0ebzgd3jtn/2FN
 eALeMt0JNI/VGMzWMDYVrz0rZdIzCzUtcwETR5Sk3/zeAUKYwpckaMs4c3uUpFI1YyY2
 OSg1MiuARyTRLu/4m0/p2EJW5OwjeMWtrPXME+DNcmIU4Ptvt/g2/gCqy6C+jAyHaSv5
 r3krvePaGWUS7hH7NiTU2KlfpEE0f7mc/sCmhR9GdR/Jiy5Jwi5hRxWGu+7/LRiSalaX
 CHiQ==
X-Gm-Message-State: AOJu0YzVzQ0o5qnqO8DvuSHGexEO7JjtgHgEVF0jCND/G2oD/U/xsu3L
 oQ6C6CYk/hClell4Yobeh/TgUtzA0zh+7rMbTz9mt3hDKzI2mbmNF55PqpaGMGwgUfdRYlDaQUc
 YYDmpfLiyRORvb0ANQSazAcZmp/UlHQkvmE0BmVVfgySkaYNMvPPx
X-Gm-Gg: AfdE7cmI28P3AfgNxNucjBZzPot3Vp8PwyUzMvQ9FoWLWWTJ37prtDFiaPYZ0neW5Tz
 NVe9RaCgVvcYD8521rRFczZJG6mUI70YRzAoapHoEeRQFTCfUFnnFmmvUeLvnZgHjV1NayZlb0V
 oUFHgrvJCnc3xB+8u5t3y5OsYJIC09Uoryy3Yusc8KaSWx+COwZ8+RTlKVRrV7I0wyO7pHX4ZEg
 cgJ/Emzc8AhuuPkQ5j63jDfbYyBUXDIm6TB/s96B0d2TbJxrLf99NjmD530ugW9rgmBKHMeeMKg
 5ZMCrdK5cVQqkoRoYmrfLk0O0npy3K1bmhA7mqOp1Jvht3wo6MARva9q
X-Received: by 2002:a17:90b:5547:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-380ba8d00eamr9928528a91.12.1783087426562; Fri, 03 Jul 2026
 07:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260703132528.4035684-1-peter.maydell@linaro.org>
 <a5b9ebe1-dbf6-4581-9394-d879adcec419@tls.msk.ru>
In-Reply-To: <a5b9ebe1-dbf6-4581-9394-d879adcec419@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 15:03:34 +0100
X-Gm-Features: AVVi8Ce_EHn78I6L6l-MQS8n1prRqVH0TbIBblbhS0wkHQUa_ACMxoGfLIUHAgI
Message-ID: <CAFEAcA_XEKeR+hHOcmjBRsxrGL0vBh9xTs9guni+VuPwBcg2Xg@mail.gmail.com>
Subject: Re: [PATCH] hw/9pfs: Check for error return from local_fid_fd()
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=peter.maydell@linaro.org; helo=mail-pj1-x102a.google.com
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

On Fri, 3 Jul 2026 at 14:53, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 03.07.2026 16:25, Peter Maydell wrote:
> > The local_fid_fd() function can fail (returning -1 if dirfd() fails);
> > check for this explicitly rather than relying on something later on
> > failing because it was passed a -1 file descriptor.
> >
> > This was flagged up by Coverity: CID 1660923, 1660924, 1660925
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/9pfs/9p-local.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index ee592b62f8..8f27c562b5 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -788,6 +788,9 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
> >   {
> >       int err, fd = local_fid_fd(fid_type, fs);
> >
> > +    if (fd < 0) {
> > +        return fd;
> > +    }
> >       err = fstat(fd, stbuf);
>
> I think this is a wrong approach - if we're going to report error due to
> a failed (local_)fstat call, we'll use errno which is not set in this
> codepath.
>
> Instead we should check fd earlier.

There is no earlier point. local_fid_fd() calls dirfd().
dirfd() can fail, returning -1, so local_fid_fd() can
fail, returning -1, so we should check it.

> In this particular context, we don't check possible error return from
> dirfd() - which should not return error in our case, as we know we have
> valid opendir() handle (unless we really messed up our memory layout,
> but in this case we've much bigger problem).
>
> Mayve
>
>   assert(dirft() >= 0)
>
> in local_fid_fd() will be better.

I'm not generally a fan of "assert that this system or library
call can't fail": it's making a claim about code we don't control
and that doesn't document itself as providing that guarantee.

> In general, seeing code like the suggested in this patch, prompts me
> thinking that fd can normally be negative in this context, - and handle
> this situation in other cases too.  But it really can't, and if it is,
> it's an abnormal situation.

This is just local_fid_fd() having the usual Unix style
"returns an fd or -1 on error" semantics, same as open(2) does.

thanks
-- PMM

