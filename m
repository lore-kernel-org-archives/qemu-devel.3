Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AA2ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCPP-0003w6-AI; Thu, 05 Feb 2026 22:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1voCPK-0003kf-4S
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:21:22 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1voCPI-00018X-GB
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:21:21 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8710c9cddbso23908766b.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770348078; cv=none;
 d=google.com; s=arc-20240605;
 b=BjuLyCnCZyJn+Yj41RYMCk7+O7m/7vCpI36JRKJn7iZ0nSgftQ9Va5jojbROAueebv
 Hj14+q3sdbklWIzO/Tisdywtbsei9eEZh3+1jMx9/yqMyj6cGF5HO2ZYQP3MCrjYkOUI
 JYABzHLRNCvCvDQJYDHvT5+LSI3PVCrj7GQ1Qp92+dwszorRJ/U/hdIF1xO7rvMSLQEv
 SByeyuY2T6pR1vFeedX3S3H4l+PYvnEj7ZjYFWjyM/hOkeeHg8I+ksQ9YG1J5tSoi5+u
 Eb/GZOT/hoP74IVo1DjLr0FNYGQDsQa2mizvvX4XFrEd3zP6C8FACU4BzhA9lHUvZ9hB
 DpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S33TLpNqLnl5D2qFo56B6Tx7NxkhoocI3dPUgigCI18=;
 fh=cQ7hnC6fLJLg4X0VdG++3DarxbRbY0MROLW3rb9G9r4=;
 b=cVGIodYIVVzCvyuT8BB4uTYeun1lgQnBLT6NvcbdLiSmwkzkm8eQ9/kIYI2vGn6RW4
 7/72qb71ggRuwKd4zXVDacvEeyhQVPnCDv7DuZexoVRuxho6E3UO8qPjrNRgS74Ax9fd
 l9sa03v9DNyZ4aR6kZiCr8uiWTWIf4xrL51a/CyMCnvu7ehJ6z1gBJ7PJVvxQZdSp+lc
 m3fLY2D4FQ99qva7RPo6p+97aqoaySSAMWXvRV7PEl7n/C2zH/6yOmdtLyMx9PWUlyY5
 h2GNlIyrpK5kabfBkW4/2E8qrQjTKDQS1XRhmyhf0/Esl7mYWRS+Zyt/d3ArZHjURV6e
 i1cQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770348078; x=1770952878; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S33TLpNqLnl5D2qFo56B6Tx7NxkhoocI3dPUgigCI18=;
 b=Zx4Rr/4CSQQmbMld7yOJWUkSJQyt1gtHsgsepXacdwvZnvXGN1VkeMGqK/zoPLKJf7
 6SaBPxzTsk3h6KAk3sSOnh+3kDIbNLrnMRH1zS0JIuekw9ltKaQ0rveDYl33mNiEZIpf
 wO3jwmAcD3OCXcXmxMy3RNxnQa2h6sB4tT/oPBAaalWKFNWEa6Em9CfSuNwNphXE2Xal
 6Y3MBk4hPt9L2om2MagqC0TGxbDwKqbbYd6SpPVB1iqVY1v3ebc43K02XKT2MJmKbb+Q
 IFRYcPRib/TQNqoHXDrqdjiZZ2yD2shHeNlrIYL4BIYLpFWhtGg7idC1bjVRxzcRc4zQ
 bfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770348078; x=1770952878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S33TLpNqLnl5D2qFo56B6Tx7NxkhoocI3dPUgigCI18=;
 b=U0YUwl4oE0lOMkXpFeey01z95nVB4oWmgPIBEzqD95b2D8s14yy3C1roJRlJlYxLVM
 y8dzEb+1lm0zLQe8SM7khlk9W7M+elXuWAOPkqENwvwhM0kYtrsrDIiiBqzh/n4qi7L4
 +e0n+hGOQcPSLx50k1Jd6hWOj8hSFBspPOp0Fg18WsfjFn10lHmkCt25vg6K8H+laS2N
 Cm5VVYJn6G/ALt9TrPZB2nSGM0kW1gZYbVeudIqES4h5YKh1kTvENiUW6vTsRllMg/o3
 XmPwwzwf2h6YS63GeQ26gQs8UH5w+Ne9wkq9VrYmFp2eSkVwrka+QWNdew/4xg793Nn1
 q8LA==
X-Gm-Message-State: AOJu0YxNeG9JOkLIwIJlaMW8f0wpUTJsfSoobghfPx6njO1EWUgm+4WJ
 DcVQH4pQF6XT1W9//mzYSFeqNys3n4/ys18zrlCjcPLbCond59a/2+ZSMR6U2ULpO5wet4hhk2G
 dwBvUoBObJS4ZL3oI47zOqTqO6kvCrb0=
X-Gm-Gg: AZuq6aJrkbf7tnmnnt24l4aNmOAVfMMdxys2BhneCd+Lo1tB1F9DNo8a0fnxrenR9bB
 VsjprrNvypMrH+LXZqd5sFz0upRx7sG0CY7dtYsTUdPKdI6hn3xYy+mXvXpMnJfJGhzsDOX6hOe
 lOXJ+NX8U0/yXWU4bNWwPGpxDY3lVJUEnyALe9PyccRHTlPnIFY59i7jr+UiCoIXJ98K2SiPDRS
 8ROTRibRvm65DHMfKWq/+chE09tBhg/9S//x766rMTQ3uTu3zGRsL8E0HWYF7MLGg5WQC7/
X-Received: by 2002:a17:907:7242:b0:b8d:c595:815 with SMTP id
 a640c23a62f3a-b8edf375f4dmr60988666b.58.1770348077865; Thu, 05 Feb 2026
 19:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20260126094422.23116-1-zhangckid@gmail.com>
 <20260126094422.23116-2-zhangckid@gmail.com>
 <CAJSP0QVNJW==wVom++7WERQUXViJOsfzuraveXBxfnQ1LVzXpQ@mail.gmail.com>
In-Reply-To: <CAJSP0QVNJW==wVom++7WERQUXViJOsfzuraveXBxfnQ1LVzXpQ@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 6 Feb 2026 11:20:41 +0800
X-Gm-Features: AZwV_QgDDoosWwzcfrAiIqzV0DCOd-3BlpPW-TTK230r8QgmTOkVWD_pSFHCgIY
Message-ID: <CAK3tnvKfcbYJD7hhTghmOFRn8vzR6S0o2CZhPHwQtcseR75BpQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 2/3] iothread: Introduce a new flag to show
 iothreads attached status
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62f.google.com
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

On Fri, Feb 6, 2026 at 12:11=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Mon, Jan 26, 2026 at 4:52=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> =
wrote:
> >
> > QEMU Need a flag to show current iothread attached status
> > when hotplug multi iothreads. For example virtio-blk.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h | 1 +
> >  iothread.c                | 5 +++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index e26d13c6c7..3d00474523 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -32,6 +32,7 @@ struct IOThread {
> >      QemuSemaphore init_done_sem; /* is thread init done? */
> >      bool stopping;              /* has iothread_stop() been called? */
> >      bool running;               /* should iothread_run() continue? */
> > +    bool attached;              /* Whether or not attached to device *=
/
> >      int thread_id;
> >
> >      /* AioContext poll parameters */
> > diff --git a/iothread.c b/iothread.c
> > index caf68e0764..38e38fb44d 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -94,6 +94,7 @@ void iothread_stop(IOThread *iothread)
> >          return;
> >      }
> >      iothread->stopping =3D true;
> > +    iothread->attached =3D false;
> >      aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread)=
;
> >      qemu_thread_join(&iothread->thread);
> >  }
> > @@ -199,6 +200,9 @@ static void iothread_init(EventLoopBase *base, Erro=
r **errp)
> >       */
> >      iothread_init_gcontext(iothread, thread_name);
> >
> > +    /* Clear iothread attached flag for init gcontext */
> > +    iothread->attached =3D false;
> > +
> >      iothread_set_aio_context_params(base, &local_error);
> >      if (local_error) {
> >          error_propagate(errp, local_error);
> > @@ -336,6 +340,7 @@ char *iothread_get_id(IOThread *iothread)
> >
> >  AioContext *iothread_get_aio_context(IOThread *iothread)
> >  {
> > +    iothread->attached =3D true;
> >      return iothread->ctx;
> >  }
>
> This patch will still report attached =3D true after all users have gone
> away. A reference counting API is needed because IOThread users can
> come and go (e.g. device hot unplug or block exports being removed).
>

Make sense. I will add another "int attached_count" in the struct
IOThread next version.

Thanks
Chen

> Stefan

