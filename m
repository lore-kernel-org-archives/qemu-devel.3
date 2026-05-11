Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C34FCD4842
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVyb-00033m-66; Mon, 11 May 2026 15:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMVyY-0002sB-D8
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:07:34 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMVyW-0008TR-KF
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:07:34 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd1caeba6beso132743566b.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778526451; cv=none;
 d=google.com; s=arc-20240605;
 b=IBoKUfqjnAaMWz/coEqGyn/Q+QvA6R2HlIHuQiaS781S6r5RfHvGo/JzW0tjrexgBH
 Lo6/6l0eojNMG+PfvPt7QIMpM2kKQ3+cf1FesN6SAWdAajS8yC4qyH6zKhox+HQ9177f
 cC7zsLcMdfUq5TR8+H9lQxol/ILSYCzfLI5Km0SCxZitxVW3I7UsBFr9E4qBPSxee5GO
 0AL6cfbjk8xzhWUdQYykRqb8imtF2wxpw7ihD9FK2aMB0ckdypgnxFfQ6XlJLMhTvUYv
 hKec+iwLxcGBVyXAQpxLrxORbgGh7hQ0O85SzkIpZsyTWvPYr2XPwUJ3v/K1XpeGHB8X
 0Q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mSEn69GTQbz9I9Zy2qz2yuNXu6m2sv+azupgqWTF7WQ=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=bP6xySn/tIgZUgtsrVQ8zKuiQs6e9bjdYwuhACC3PHZ5Jyme6qzlIdkyG1AuNjhMji
 dGivttnhd/ExOLUUVXQbC/Q8iewM2Xq408vEMTK7TZ9ugxPV9iRYiBSwwFbNxVREa5Uk
 icMq5vrh1xxo/ylb2cMi1OJZRTrr19YTFzSW56sq/vvD8BDuF50SaafbXVtdWgoNL3IR
 68U8LFy+SM8mVI2/ukgPL6l8leyI66zDgHE3/052LqXwyr9VDRy7IwkOk77hyd/WuVHx
 vpTGcOfkc/VPK7OJEgisdwJgT3i48UJGapXvl6KqXUfVyD6/Hwwof9A0Jlmir+p1i7dD
 Bmwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778526451; x=1779131251; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSEn69GTQbz9I9Zy2qz2yuNXu6m2sv+azupgqWTF7WQ=;
 b=VV0qZSm73ZDJCgXicVgoHIFT54LbiAegkF+fWIEMWQDNpS/EgX0p5FiKfuBM6llwU7
 pZCYf3By95NAE44WB83//eOuZe6ElsYn2Bp362SiptnxmXBh8eTdj/3wGqJsxY8cuui6
 hYBsSabpYUaLgAPQ83DcRFVra6Ag5psXFT9QikikeKpXkNH+hxxApG35A7J8V2GdOUSn
 aqt84xOuPPMGHz1eGBnoY6mK6R/QmAkYOS2kjwiamz5ho+yeOblqCUymWc66xpnBvL/x
 o1D5ynqPaaphbIi5SrcjoRgQSqPheUdWIpZcCL4cRwBKCqLgqgPT8eoxmNEl6wj2+oZ+
 /VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778526451; x=1779131251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSEn69GTQbz9I9Zy2qz2yuNXu6m2sv+azupgqWTF7WQ=;
 b=OVEORkNCnsFRBpv64O/1IH9OyfFU8F5RK2x+/Bo4NN3Cvz+0ZsRMe5K9UcsdvuWVdn
 PJceLO70U8cUXauBwKmUaOTalwbp1mBtGHNbCBUSsW1c5QoPGYqvv9oAIt0iy+bSrDbL
 kUwwNA4IE4dwfZHnXx4IaqXG0YwE19s8AVeyLGZNvMENGzbU8V5eKqEd+ffCzCNi0o1y
 tEkmQDApWOEEGCoa6zFC6OBs7CX88lwLExk3z0uf4xUWxxWrIyW8IUvLUHl5lyfprgCG
 UgdSmTZGVqTK4tkAsgnJJYcCSfI19+56FEFuGXOPlEOBIgAblkq1SKTJpQfgy/BsDCQt
 G2uA==
X-Gm-Message-State: AOJu0Yw3wsi2xtjQWj/Aow+FIblmaqgJHcYI9ncNCq5Vovg/mi9b8GiI
 50GJMRREO6L70EB8N8fH6v5PBSQaZ8XO94NashMYbBWNKqq+ZL5dqMWShSpU4HixeOIvf1gB4N+
 XmRf4w33wuaMikCpqhB7dSE1L3gcVD0U=
X-Gm-Gg: Acq92OHPQdHzBTXw6umRAH3vEypvYx7UqkBy9Ex+2I1v5anRGr7h7GZ1EL+z/hrw+lT
 +OOArSQb5unXe6ueUBLbOgLjBbIXXMMT+fiKbirlZNycdcgXFhiRgTUzsSs5eWyNLO8bl153K+i
 SwFOsuVgfm5RjHcz5yAe3+k5bJr8uCIhNmozv0bYkERUmLnDeb8XCQqgSOoH36x0+zYB0hC4NAE
 CYsa/sOJyAs6ZXQx52Z3ylKFXAmdGQJz6q3l09pTvge9nB3+hxuy2HV5i2CAWNOhE7F6Jh86mce
 JlmXoEWj
X-Received: by 2002:a17:907:849:b0:bab:1839:cc61 with SMTP id
 a640c23a62f3a-bcaacf2b3a8mr806153266b.40.1778526450502; Mon, 11 May 2026
 12:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-4-zhangckid@gmail.com>
 <20260511185430.GE536999@fedora>
In-Reply-To: <20260511185430.GE536999@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 12 May 2026 03:06:53 +0800
X-Gm-Features: AVHnY4J-ZI7RC9WmeBFai9QMNQyGIub7KbzVpj9Lzvu9WLPIedhxjF2W5dc7cC4
Message-ID: <CAK3tnvLcPOoTa+ToqHxHiWJ+dhModBBhhkj5SV2gR4n8Ut5okQ@mail.gmail.com>
Subject: Re: [PATCH V7 03/14] iothread: tracking iothread users with holder
 name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x636.google.com
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

On Tue, May 12, 2026 at 2:54=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, May 11, 2026 at 10:04:05PM +0800, Zhang Chen wrote:
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
> >  include/system/iothread.h |  3 +++
> >  iothread.c                | 33 +++++++++++++++++++++++++++++----
> >  2 files changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index 2871b06edc..313ef61124 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -70,6 +70,9 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> >  char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> >  AioContext *iothread_get_aio_context(IOThread *iothread);
> > +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > +                                             const char *holder);
> > +void iothread_put_aio_context(IOThread *iothread, const char *holder);
> >  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >
> >  /*
> > diff --git a/iothread.c b/iothread.c
> > index b805e4f97d..5d6f46d286 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -44,6 +44,12 @@ static void iothread_ref(IOThread *iothread, const c=
har *holder)
> >      }
> >
> >      iothread->holders =3D g_list_prepend(iothread->holders, h);
> > +
> > +    /*
> > +     * This guarantees that the IOThread and its AioContext remain ali=
ve
> > +     * as long as there is a holder.
> > +     */
> > +    object_ref(OBJECT(iothread));
> >  }
> >
> >  static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> > @@ -83,6 +89,8 @@ static void iothread_unref(IOThread *iothread, const =
char *holder)
> >      IoThreadHolder *h =3D (IoThreadHolder *)link->data;
> >      qapi_free_IoThreadHolder(h);
> >      iothread->holders =3D g_list_delete_link(iothread->holders, link);
> > +
> > +    object_unref(OBJECT(iothread));
> >  }
> >
> >  static void *iothread_run(void *opaque)
> > @@ -200,7 +208,7 @@ static void iothread_init_gcontext(IOThread *iothre=
ad, const char *thread_name)
> >      g_autofree char *name =3D g_strdup_printf("%s aio-context", thread=
_name);
> >
> >      iothread->worker_context =3D g_main_context_new();
> > -    source =3D aio_get_g_source(iothread_get_aio_context(iothread));
> > +    source =3D aio_get_g_source(iothread->ctx);
> >      g_source_set_name(source, name);
> >      g_source_attach(source, iothread->worker_context);
> >      g_source_unref(source);
> > @@ -419,13 +427,30 @@ char *iothread_get_id(IOThread *iothread)
> >
> >  AioContext *iothread_get_aio_context(IOThread *iothread)
> >  {
> > -    /* Remove in next patch for build */
> > -    iothread_ref(iothread, "tmp");
> > -    iothread_unref(iothread, "tmp");
> > +    return iothread->ctx;
> > +}
> > +
> > +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > +                                             const char *holder)
> > +{
> > +    /*
> > +     * In some cases, iothread user need the ctx to clearup other reso=
urce.
> > +     * When holder is empty, back to the legacy way.
>
> Let's avoid referring to the legacy way. Developers working on the code
> after this series has been merged may not know what the legacy way was.
>
> If an API to fetch iothread->ctx without taking a reference is needed,
> then it should probably be a separate API.
> iothread_ref_and_get_aio_context() calls should have a matching
> iothread_put_aio_context() call. That's not the case when
> iothread_ref_and_get_aio_context(iothread, NULL) is allowed.

Sorry, my comments are out of date, for the V7 patch, the legacy
way has been completely abandoned(you can double check it in the patch 14/1=
4).
I will remove this comments in the next version.

Thanks
Chen

>
> > +     */
> > +    if (holder) {
> > +        /* Add holder device path to the list */
> > +        iothread_ref(iothread, holder);
> > +    }
> >
> >      return iothread->ctx;
> >  }
> >
> > +void iothread_put_aio_context(IOThread *iothread, const char *holder)
> > +{
> > +    /* Delete holder device path from the list */
> > +    iothread_unref(iothread, holder);
> > +}
> > +
> >  static int query_one_iothread(Object *object, void *opaque)
> >  {
> >      IOThreadInfoList ***tail =3D opaque;
> > --
> > 2.49.0
> >

