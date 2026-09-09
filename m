Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44910C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Bjh-0000n5-5Y; Wed, 09 Sep 2026 02:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4Bjf-0000mV-KB
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 02:24:43 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4Bje-0004RB-0r
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 02:24:43 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c28eef361f0so502306866b.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 23:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788935080; cv=none;
 d=google.com; s=arc-20260327;
 b=BrWDAW/vNFkvRcQARmU7ZrPm9hxYi3R2S9xAJg/6WEkx4KD5FGyPdJ+GeMHpkatXyu
 Ss/Vw/Ec1i17m9Sde+6ByBq6QE0Fy3VyZ9c8JnreDJnxtJPV/HyVCzI2aR4Y3q0C1aQp
 hbiNYK3szG2diJiTmibBfkBppluqYEEiJoyv+AxZEbNA+lNDKMPtYRHocoq70n4AI3ji
 BywFtRoJGUU9I4khu/mqwUBV7qoMjqCnG2EnE3VTW4LMJ0RaaL30FHz0LiUgAjV+NUWM
 PVYYE6XoCJFyp3ZKkimmBM5GWomidZjRqrhryjUr8EUN8zWZBdQZVJIyZZnDeS5VE0o9
 VGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jp2JOmSdU/n48YRUr+LMqcwd+AV8sXHBTVZRe6AJ21U=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=KVUXo6yGSsxPQlk6o0/fz04R0R5mX/rhzIBqK3Y9WYf8ksFUvon5BuCfa7mIx/TmPI
 xciBr6FGkGr6vBrUuN27pSbnJQaTnIkU8vXM2lrEshP7KjTC7AkKgXZkfQ++ZDmX9QUL
 XVC1YqA9bIwREFTVWpzRVuC5ivEb2+NE8s44vNk508Z1FY1V8eUrPdrFOqZmdYsOmY6X
 NtukQ7DTOK0zhK7t8Nw+ooSZVUT+8Rm6xe0Ec6KqKhREIa18F8ibCz8usC9Qg1rMC11q
 gR7x2OqBDfBymBfahEIHi7/b9yMiAqZ+B8CI5W7/Tfz/tFY0vk8E7tNzn+YfUv1kIL9v
 OEig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788935080; x=1789539880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jp2JOmSdU/n48YRUr+LMqcwd+AV8sXHBTVZRe6AJ21U=;
 b=HZL6dhNq5f3+dcwBJbII4bhpxa6JtLldlPCND2blkHyP/EaMNEu6b4ddoK6e8R3w6w
 F7L8ysv/4DmFvSkNxxQ1f/2UP72bBtGaPb0ijW1fVSskDFFPL+MfYRHtmT1hfqY3nWTX
 3xm5Kid9hp8/yOw0VBlXlwDEcVZ0MlbcTWD7v1A300A9ElcqynpE0O+hH7ttfhd/JKo0
 +PmLH9PRR2dQYcfyRZqUC6enrlg2Ms2kUirZW2sMamDkhwp2mRgsmNXUunP3nKV8vTjd
 XbEinO/81moL7sJpR58o+ggRj728iSLGf0BntFpW0NtKYzPrR7O6iPZQFZ5mS/B6tzmw
 Z06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788935080; x=1789539880;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jp2JOmSdU/n48YRUr+LMqcwd+AV8sXHBTVZRe6AJ21U=;
 b=jDAzBnQRonBAxY3URPDYWyvsQgySb25b78K0X539lOeQw3NGNv3flKQj70vrAmN8y2
 jp/dcIxLvuspivin6umPiD6FJ6MVGbede5At7XFmhmOMfVDiYCIvPZbf672yFCbFumIx
 1DMuPMQuOd6kc/PRrxunaio/mI6P0pgVOvZmnR76qiV0I66gXiZ5XfdxoeC5kpUklgqI
 G0AH5tVFAKoPDjDuFd4tz9BDxWtAue2htnnyZ9I/PYt1pnmjcWZPgtnEoXDmzyoids5V
 zvIfvt+R98fZW3QsOZcmrf4+HdhTVsKB+WihkpfO4LW2BngKea9bVYg6SmC0q7ykhq8m
 DfLQ==
X-Gm-Message-State: AFuF++n+i02C88LhKTsO62x763fKgIoegjwzBNeT1sv8LNH6WceG5EXc
 eTkKcNDgjCVxspEs9S9cIY5r4sfGIw6ACn2ixpTZ3sNLgIJABErAYZ1RpE25LajncQtiU5zIaGm
 G8KpJxR51OQJdPUxb9COugQa/LA5RSDA=
X-Gm-Gg: AYBFou3ONtcced0dwFn5yVXBlr6vuvNEC3mEmS7OyV1Vd1tmH6cZn59tVDqkjOy2jGG
 fcBZlbf2ENT4NpWJ9Gi/l6HconxUCRgkPkCN42jcwaL0mMBB/193oNYTKc4lA2FP1xhHTGsMN+N
 2h7zf3wnpDIYv8hlZbx6ijvfLvaH3fnwlWJHbamnKhpwSmmFmLhmYYhHdlNpYNDW5Fi6o32KCfU
 FwFrJTD7MWSLo1alNrD9bjUUK1QTAJLP0ZKG+v7ZZEnVP4HOOiljU8K+plgi5CCkL7uY9MPL/kO
 0XmQ3zcF3n7GbZMyd/wD4EZhundHnB93bq/sNOGTaXEkY7N8EjywUeh2/cMz+4OF
X-Received: by 2002:a17:907:3f8b:b0:c28:e01d:1d10 with SMTP id
 a640c23a62f3a-c28e01d2ae8mr862971966b.49.1788935079768; Tue, 08 Sep 2026
 23:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-14-zhangckid@gmail.com>
 <87zextw78o.fsf@pond.sub.org>
In-Reply-To: <87zextw78o.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 9 Sep 2026 14:24:03 +0800
X-Gm-Features: AcwNN1VD0LpDc5XKO426fzqaKH3RRTrcvxKy7RZKALleoMTYGwFYPaLTrKKqDho
Message-ID: <CAK3tnvJALU_i6OzrCb-t20un=AALTySuRamkmyqrbS8Zumk2Tg@mail.gmail.com>
Subject: Re: [PATCH V15 13/14] iothread: make legacy AioContext getter
 explicitly unsafe
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62e.google.com
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

On Mon, Sep 7, 2026 at 8:55=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Now that holder-aware callers have been converted, rename
> > iothread_get_aio_context() to iothread_unsafe_get_aio_context() and
> > update qmp_x_blockdev_set_iothread(). This avoids adding a duplicate
> > accessor only to remove the old one later.
>
> The last sentence appears to justify the change since v14.  If that's
> the intent, drop it, please.  If not, what is the intent?

Thanks. Yes, that sentence was about the changes since v14; I'll
drop it from the commit message.

>
> > The block graph retains only the AioContext, while detachment happens
> > outside qmp_x_blockdev_set_iothread(), so this call site cannot provide
> > a matching holder lifecycle. The new name makes its existing lifetime
> > assumption explicit.
>
> Suggest to start like "The only remaining user is
> qmp_x_blockdev_set_iothread()" and then explain why this caller cannot
> use iothread_ref_and_get_aio_context().
>
> > New code should use iothread_ref_and_get_aio_context().
> >
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  blockdev.c                |  7 ++++++-
> >  include/system/iothread.h | 11 ++++++++++-
> >  iothread.c                |  2 +-
> >  3 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/blockdev.c b/blockdev.c
> > index 6e86c6262f..97d161079a 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -3683,7 +3683,12 @@ void qmp_x_blockdev_set_iothread(const char *nod=
e_name, StrOrNull *iothread,
> >              goto out;
> >          }
> >
> > -        new_context =3D iothread_get_aio_context(obj);
> > +        /*
> > +         * The block graph retains only the AioContext, not the IOThre=
ad.
> > +         * Context detachment happens outside this command, so there i=
s no
> > +         * point here where a matching IOThread holder can be released=
.
> > +         */
>
> This is fine for readers who already know what this is about: why we
> can't use iothread_ref_and_get_aio_context() /
> iothread_unsafe_get_aio_context() here.  Others will lack context.
>
> Suggest to start like
>
>            /*
>             * We cannot use iothread_ref_and_get_aio_context() /
>             * iothread_unref_and_put_aio_context() here.
>
> then explain why.

OK, will change it  to:
/*
 * We cannot use iothread_ref_and_get_aio_context() /
 * iothread_unref_and_put_aio_context() here. The block graph stores
 * the AioContext but not the IOThread, and continues using the
 * context after this command returns. A matching put would need
 * to be tied to the block graph's context lifecycle.
 */

Thanks
Chen

>
> > +        new_context =3D iothread_unsafe_get_aio_context(obj);
> >      } else {
> >          new_context =3D qemu_get_aio_context();
> >      }
>
> [...]
>

