Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03651C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdkj-0000eA-PD; Fri, 03 Jul 2026 09:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfdkF-0000dm-KN
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:15:53 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfdkD-0006ok-Ub
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:15:51 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664dd23829eso509082d50.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 06:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783084548; cv=none;
 d=google.com; s=arc-20260327;
 b=jfh00DSHaweYYyVBTw0PmLhXECMpVk4XRCW5l5FVViJpz4iwOmpGJr5BZ/Bgz6Eb6n
 UpEFp8lk2Tisoslod7/lWoRpZ0+AZtNmXQOqKAZGZqbRujD9IyM+GX5x1QK9Tn9JYB7A
 oqjPNMckX6C6CuECBCToH1h4IqBEuyT1ACT/9u32W//hupr9tyPnUxxCGI7c+xqjSwjl
 ugRR5yJxLxwSGKHt8JUIbrhDycl8YVcccRZvN21gHuO1NAKhg2nbrtyMoGhOtwoh57KU
 lG1T2EdtP9A+irDFjpWJM7JK/3ZanP9IvLQ9IF03lHG0sPbOHYcB9+JXifxLu8gW1fsA
 UmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ypX6y0SMNrtooa+4hHzPDKSXJdJ7uXsc9yFpBhQKCLg=;
 fh=7R/RZGD+m7OAV6ynsYAfWZ1IG1hYR0cKwZ0GYuuX0rE=;
 b=babJUcG6zzk12X33o/c+qfvqlF3sTiazLcYd9GkVs+Qdtbt+Rd2jUBolYvnG9AIIQy
 qiwrXkDYI+OaL+IUvK+m0AvKQJh7dW+Fj9euJPqg+TitOHRmwsp7ypMazVy6V7slrAf+
 HKMBhkLofNPHJTdsVtj3CB/OzKYL6PM8e9UUj5RR9BBIHaNX+NMbH5WkE/Fj+gTyUruC
 i9HQon2bSEhouz/JAZGo1c0nL/19fs0hMrQllmQW/0ynyrntykSdwGGYjv9r7b2n1Bej
 f9Q3Bwo7KbJ0N6fL1+HquCDw6DxzVRSNxOZLyejbZpmwX6wir123LCZ4zo3Ou6nFOseb
 jtbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783084548; x=1783689348; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ypX6y0SMNrtooa+4hHzPDKSXJdJ7uXsc9yFpBhQKCLg=;
 b=In+mA7SdevgdmqVPVHVJVVZq3zHG1EbflIYiVbcrPOD7dJrAMjhJGzaZBRJZ4EzP/j
 7FSWTamj5Nlk6+7N8S1MYzkf0NiIA0I2lUecZl9YFiUrkpEqqtIscNs9AmnW0ymdMPTl
 FAmaegndAWSEAzhi5TlYJrble+q4mjEp5kOEIqI8GDkF+qRGiiQRafeuxog/uyfL+r7C
 I5+yhp2kZpBUxjYM/iWpZZL2JzmpIRiK4bGwwNoD+qlvx/ZZAmh6jP45pDnWC71H/X9B
 zoXWfdRlNNQJdquKwNarmGQzx9sqbk81cXU2JEnFS9vbxwPsVy8wlH8uajMhPIr8NqK1
 VGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084548; x=1783689348;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ypX6y0SMNrtooa+4hHzPDKSXJdJ7uXsc9yFpBhQKCLg=;
 b=cdtTDgn1PH35hSUm40gCwlFB8YFfdE6GWlK/8JZJYX/gCwgBM57VusGeGuxGJEfLkV
 KPd7R8w/PTBwKZERd/pMi69MMf3tYdaRef+dTMrZLuasU97io+mg/j7iZYs45gXcFnV8
 J17Ll/sZRvBtC1s9Bpc2fAaoOi/SExtAQqDi3/T/IKmCO/3rb+uJDJfrnMOkwz50nGk2
 ZhQ9Xu2IMWNYay+wTUMVH9YhC7RpCDUKsMeiLv/RSBBeuTDlWiSduD4cEFaIRGmCcUYT
 +m3Ky3aFaOEXvfYIQw66BILBBdTN2uBbUiBJxgSnvrbjXq14uomEnUA4VevSxxc2pO4S
 y3ew==
X-Gm-Message-State: AOJu0Yxa8JdYyGqzJrJ71xIiJJilt4/N9ZmKerfpRP0s6qgZDMBlu7P2
 tbDIhKkdPK+uZH6rRNytoqV3mIhEcDFZUi50Jaq1USjkQz++wDDLGBZtQn1lcwUA2ODTLUZ3Gbs
 hFrQ4Boelx4svWu6lJkubnPuVD7DBwAl/8hgwvBnJyg==
X-Gm-Gg: AfdE7ckrLdxMZG3t02AquILsMejQwemRSgaUWFaz1f84K+f+/LZQ4FBfGXhffGcLsWG
 nYcxuIffXIR7Q2QQs34uPGdZ2UDOMORhZ35pB0VuBvS/e0mRwFFPL+Xw52U08/IvI5cwSVgghDg
 youDrGO4xBMMyMOVjEsUv71scIX6/0NicnwhiVSGjRd1g/dk/8t0LU0uhkJzThFc6HXnBCpt0GE
 QOz/G62mjqGuey1K/pL/LHUc2fOzTt5Kfhw0OkFv8d9Dq/jcJvXAqA2z6FGTGj3ii0nSoZ+gKwA
 CBsm7PkWTIqpTdSmeQW4854KWfn/OOp7OQjQdwlnsLjMT+mYpStbllTu
X-Received: by 2002:a05:690e:1512:b0:664:dbfc:e468 with SMTP id
 956f58d0204a3-665916765femr8379947d50.9.1783084547003; Fri, 03 Jul 2026
 06:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
 <23160010.EfDdHjke4D@weasel>
 <CAFEAcA-qtuM51VCzAr+VgsTVkEg1+CsgUNQofVZ0B_zzfodsxA@mail.gmail.com>
 <1964729.CQOukoFCf9@weasel>
In-Reply-To: <1964729.CQOukoFCf9@weasel>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 14:15:35 +0100
X-Gm-Features: AVVi8CcQXLbd_0Z0-fLJE6KmroFUm1D9gjtE7IXG0XPOk3uib4FVvwSzAi8u-Rs
Message-ID: <CAFEAcA_c9fgub436R+7u-Chmon3a=cfuLhzywi77XpLSRXPPPw@mail.gmail.com>
Subject: Re: [PULL 3/9] 9pfs: local : Introduce local_fid_fd() helper
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 3 Jul 2026 at 13:49, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Friday, 3 July 2026 14:21:29 CEST Peter Maydell wrote:
> > On Fri, 3 Jul 2026 at 12:41, Christian Schoenebeck
> >
> > <qemu_oss@crudebyte.com> wrote:
> > > So this new EBADF / -1 path in local_fid_fd() is just to avoid undefined
> > > behaviour as a last resort measure, in case a guard was forgotten in
> > > future
> > > changes.
> >
> > That part is fine. What Coverity is warning about is the callsites:
>
> I know, this is just the change that triggered Coverity's warning, because it
> made Coverity think that this function might return -1, even though this
> branch is actually *never* executed.
>
> > > > > +
> > > > >
> > > > >  static int local_fstat(FsContext *fs_ctx, int fid_type,
> > > > >
> > > > >                         V9fsFidOpenState *fs, struct stat *stbuf)
> > > > >
> > > > >  {
> > > > >
> > > > > -    int err, fd;
> > > > > -
> > > > > -    if (fid_type == P9_FID_DIR) {
> > > > > -        fd = dirfd(fs->dir.stream);
> > > > > -    } else {
> > > > > -        fd = fs->fd;
> > > > > -    }
> > > > > +    int err, fd = local_fid_fd(fid_type, fs);
> > > > >
> > > > >      err = fstat(fd, stbuf);
> > > >
> > > > ...but the callsites don't check for error, and instead can
> > > > feed -1 into fstat() or other functions, which isn't a valid
> > > > filedescriptor.
> > >
> > > But even then, a syscall receiving -1 for a FD argument would handle this
> > > gracefully by returning -1 and errno EBADF.
> >
> > In practice, yes, but it's not a valid file descriptor. Coverity
> > warns about it because it tends to mean "missing error handling",
> > as here.
>
> Yes, -1 is defined by POSIX as "invalid file descriptor". And that's the point
> why the helper function would return it as last-resort result, because -1 is
> well defined by POSIX to not be interchanged with a real file descriptor.
>
> To make this clear: before this change, this helper could potentially return
> garbage.
>
> And yes, you can check for every -1 file descriptor just before passing it to
> a syscall

We don't need to check before every syscall. We just need to
check the error return from functions that can fail after we
call them. This function can fail (because dirfd() can fail), so
we should explicitly check that.

>, even though I already explained that a) you never ever get there
> because this check is already made at the higher level call stack

If fid_type cannot possibly be anything other than one of the
two valid values (i.e. anything else would be a bug elsewhere in
QEMU), then maybe we should have

   switch (fid_type) {
       case P9_FID_DIR:
           return dirfd(fs->dir.stream);
       case P9_FID_FILE:
           return fs->fd;
       default:
           g_assert_not_reached();
   }

? That's the standard way we write "this isn't possible" and
avoid it turning into doing weird stuff if it ever does happen.

> , and b) that
> every syscall handles -1 as file descriptor gracefully.

> If you still think this was not a false positive, you are welcome to send a
> patch.

I'll do that.

thanks
-- PMM

