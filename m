Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C109CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 22:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcWOh-0001Jr-5P; Wed, 24 Jun 2026 18:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcWOf-0001JS-Jh
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 18:48:41 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcWOd-0006yp-AV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 18:48:41 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bec3ffb95dbso253111766b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 15:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782341318; cv=none;
 d=google.com; s=arc-20240605;
 b=FflDqywv/TIzOy71hZVFVOYbChd5xOCTNCqJTkECyQ834CQaeaXlfhcExV67rXY/jn
 5hSgsmF/V6CYw0e2aG3xw18cCiIlUOWprjh3efo5jgy4jDseHB3Y09zoxZ+k3KGIvz0Z
 NRDffPQXsrjDAmAbVT17tHaKXBa2bJmH0FoqMIQX5lyzqdnTZLXWc5bnU6AcW5Znpsps
 mcMMrWwSUmMvj8QUYNZHssaZXe+LZM+Mz6BZPLyaNv0ICa831bPc0FLbnrk4n5FZ2HkI
 yBQisrIavZ3xk0HEbd7La/XwvJ9wKHqzz8g/0nkJdlyRtUTixSJKrqMd/7waGtnDunnj
 VL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6krzKx3HwtJ+MNvkW0uVVfBtwDpKFmXsm+IEYGdbGcA=;
 fh=dEcCJoizW0PIXIsgsrNAtfPedPj0hmKZvH/dXrAI1HE=;
 b=axqyquNMjkqtz3svOOABJv+VRVUay/eOtyGsmHk3Fu7yQXLtZtZbIuIY8UFFKcTm31
 VlSkjxNgdiU4TN+PQqgGjHVGJbZS4VFJhDfB6PkS5JXEF4/zWm15SvcD3wxB7psQ/tmd
 gHri/l4lbTh8w9RMp8D6LXfUjeQGiysFtdLo70JaBc1aQx7ZDpc8oRxiIL7Ia1gqKJLG
 GKsPiZibovqw40F48LxwuaoGR8zifRZirIt7llGMBJJTBW08wDIi9u3L2hBnU1sbdjem
 FHoQ6drEMhPNJP4G4EE8DhG6B4hZt2A3eyC2roJgKmQtGHLqbUMBkvCShfdSHKiSJO+k
 lKwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782341318; x=1782946118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6krzKx3HwtJ+MNvkW0uVVfBtwDpKFmXsm+IEYGdbGcA=;
 b=pExjyTXLqS387jJ2mxaNx1cWmuPGAQm1ZqwI8NE8mpz8jnuE3Xa3Q8RF6lBO1XDsh3
 8sqP4a5eHPo1C5DTDaguVFxK1spV2cF5ngEDyb/Eflpa8A/aavpJJQlnQCzcj584k9YD
 TEIYKmvD1cnBFClTy4tq9BxDZIf9pmhXCAh7jEmqoE4VJFFFeaJlGwIpheLnNvcVn8FH
 KCT91YKueVQ/efwpM2Ba3tVh69pGBKJuADWHicDg/PI55tNRmojfalq9bDaJuUx3ttZg
 HCsQkx4ttg1YTkaJdR4nMVB89kY55nw73e6DvsNQDGAQSrSkrT9bGAVu9xN1EuMcMB+6
 3Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782341318; x=1782946118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6krzKx3HwtJ+MNvkW0uVVfBtwDpKFmXsm+IEYGdbGcA=;
 b=nCCCkHtMi5a/EJQ8WTUIKQoXbOvbPqipAYDS65RSLOe3ebmGt+W2V4EQuO1B+Z/tyM
 OLC0UEKxwelGds+o4DKfeJueg4w8cqlhG2YtIQmckuS+gu9bzsb/IKjHbmMl6imq1XBC
 5K+nyFLuvokO5XL1wRpiZwx+QIdequiIAnqcrvbx5hwgVNh7X1JwlAkbZQRkkwAhxxVm
 EmncqqBzEmskO+Z1OB1e3/0wB/K09IKpB8dgLv3slslxEJ5fLKVzNNG2qCblwQ7faeHM
 1CXeLb9CXhy+njJ6dEgbWr0vf/bp8o6z6DmJ5tHiqjPoj1ZuAgVo7GYMEDmWrgIUC/yP
 3WIA==
X-Gm-Message-State: AOJu0YzG+EEInTl2dUTNB15xfFd8EXsLQ8FJ4sGVNUYn5u/Dcp3rXoRw
 tMES7FbX/RZmSlUHffQsEnK8PGOfgshEhek6Dz9Q5D5DW4mG2jzLi/JZKmwUuypkLkUQfwP+dh+
 Jl9fqyPilNAoqKoqaRoRHuRuRDsI9ugc=
X-Gm-Gg: AfdE7cm9BIo6R4QXBU1pVeJm1H5mErd3CRKfiigMUWPy5COiALs0KUF0m5pUfT8WHla
 d0hBkXSmfQN7iJ38cneBrCzUwzU1V6DKidlERCjhKXJgEpIVZWL+LAKvxXE8KUVap71INKHXsG9
 GnkIcyyxMLchWXS6J0T/8f39dR4gcF5KN7xBTe50ulZq6PqLCpDtRqL8mSO0LhlkfoqI5VAK6Qn
 8snXMRKdHThA0SYppikUwQHE2GpB700X9Zqo3460mtGXnhlnDp/RwuY28sMEJ896x+OT0b8
X-Received: by 2002:a17:907:e112:b0:c11:f52a:4e70 with SMTP id
 a640c23a62f3a-c11f52a5d58mr185945166b.44.1782341317676; Wed, 24 Jun 2026
 15:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-5-zhangckid@gmail.com>
 <20260624171941.GC109308@fedora>
In-Reply-To: <20260624171941.GC109308@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 25 Jun 2026 06:47:59 +0800
X-Gm-Features: AVVi8CfUqloslzMp8ELjFcfiJNcUKuWgKUTIItUqAOXaG_Vgn4Tn5NJdf2oggZo
Message-ID: <CAK3tnvK+vOFoGXtFUyuRXD_xZH7ob2VmUhJbBE=zY1Em=XTH7Q@mail.gmail.com>
Subject: Re: [PATCH V9 04/17] iothread: introduce
 iothread_unsafe_get_aio_context()
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x633.google.com
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

On Thu, Jun 25, 2026 at 2:33=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Jun 24, 2026 at 03:08:38PM +0800, Zhang Chen wrote:
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index b483bbfab3..064c05e78d 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -71,6 +71,12 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> >  char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> >  AioContext *iothread_get_aio_context(IOThread *iothread);
> > +/*
> > + * The iothread_unsafe_get_aio_context() is a low-level unsafe way of =
getting
> > + * the AioContext, recommend migrating to the new API with IOThreadHol=
der
> > + * as much as possible.
>
> This should describe the safety concerns and when it is okay to use this
> API. Something like:
>
>   Normally the IOThread's AioContext is fetched using
>   iothread_ref_and_get_aio_context(), but there are legacy callers
>   without a clear ref/unref lifecycle. They cannot unref (e.g. because
>   they do not have an IOThread pointer), so provide an unsafe way to
>   fetch the AioContext without holding a reference count. This unsafe
>   API serves legacy callers - do not use it in new code.

Looks better~ will change it in next version.

Thanks

Chen

>
> > + */
> > +AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
> >  AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> >                                               const IOThreadHolder *hol=
der);
> >  void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder=
 *holder);

