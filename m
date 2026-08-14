Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F83C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wunxY-0003p3-2r; Fri, 14 Aug 2026 05:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wunxV-0003oi-A8
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:12:13 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wunxQ-00008Q-IC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:12:10 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso1085966a12.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 02:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786698727; cv=none;
 d=google.com; s=arc-20260327;
 b=d4sYnB0Jzd6wx3PhMx8v8n3PrhGil2f9de4JAE4xFUEB7+JUUQmqIjAe5il185YaiM
 d4YafbO679gBxOTLb6FOhI7l0dx88vOKEMVScEehN3v/qzHg2B661Cd8FUAdzp1Q09JR
 EaN+1pR8mkbpV+aXzGf8NKFZlHCCP6q1SyG6xkMHJzg1Hi5L+UZuHt9QR5/j4JHrnDOm
 uz4rgVgJvHl8WVayyxvRRMB3H9Zh778O3i/tW7hpIiAr+ms1z/0uFK/lnexHWLd4oTgK
 hIammYvx0PRu/GiNzjyNtSqqg9C0ldYRVsQLrzcz30nORejTyIIF6SHSjQBa7dIdWHGj
 sG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g2iHSQfSkH/SAsKMpa0Qf74hGUlVt02tj7lxmesFvNc=;
 fh=n6/2UOBJdzrbOVpO2mIshPknDCQEvsTEELAvmeOoM8E=;
 b=nsUuGV1m079sK6BU0VtmNZ68K4//Om0ToZHFiqapxmvMicxa8Z7qIKhw5W/TxVGcZM
 MzLO5R+aO0e/tXlvpotWZlhxMSjlfrE6IU6OMkzHrtJyQ+Ceqxx1HM3pFV9M50KfbkR5
 oCleXzFQp6FVoCRT1c4YxCFNoqpjS1i21QB8ujBQ01JN3tWV+iySV5pM3hNRdZoFvFpe
 KqWvwwbnNmakEt6b5dxxRJIHnkzmD1ZGLlpfynEMHj91xlSxsXc5qCGAGANIabNEk4s1
 64EdCvY9DUIpLkgWABJGeUdNgIRbdr+5QKZ8KOa6oqhfwhreNI+uUx5Lfh1ir6GgQm25
 kyDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786698727; x=1787303527; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g2iHSQfSkH/SAsKMpa0Qf74hGUlVt02tj7lxmesFvNc=;
 b=flP04U8n/vbJdkXrx/q1Z5CwNWQlf8LRGyENF/5A1hMl9TFkBMHy7DmtmawVk0DB0V
 lbrXEQlSbrEKfjSsScwdeNE1Kr2dtS6HYryUpomr9LQczGifrU62YcbrLIdjAVLNLXhY
 IwfPOAnL92Kqy1C+QIFZNgY89kv0IFgDjImD7Eau8UahnJTyVK4Wvdla1WJGDMYh6Fvt
 q/fx6yGnc8nsn3hS+k9/BiK3wKN2cdbk/fJHqxjXcvJPpYDYAebWTwIDZTQBgZAtQAnQ
 +26od/SaAdDSLf2Gus0M8GekUNRVRvW92xYGHhVYKKr7fPtVmLAQz597azsyHImUkeVV
 JUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786698727; x=1787303527;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g2iHSQfSkH/SAsKMpa0Qf74hGUlVt02tj7lxmesFvNc=;
 b=RV1bDZnUMQnLCW6trIuJ/RIukML/09HsF24BRCpW4G1ewo+I7V1/645JZlOlZKa9jV
 E8T42dJJXtGcwtXZ/6Cp4Zey0jaUZ2qMD8jb1ElaI9n6mXXy41xKERcTBfjNCzaWIzKE
 qQb13AJ70fqvuCjKP4gDGR7g1brSXh9VojCZAjle1fuhhep4FGdP2Zn3SIsQQzRwRArz
 c93WK/yLgNBi+3RR0uzLkDHmrhSEUtZeoLTMHWwu6WHBvGJ1adP7BT/UJ9ROkwUxgAr7
 SJldD7SSyFBYHWyobUjAQXWvGcffGpVrK0pzYtqXt9eT0nhVj+lnswfR9B4fDASBMfB+
 /XEg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+0V/Yco4aMJPwdoN9iMlR01ZF1KXgEy2wfzzkaS4MTuuS9zokFLoq48Tg4CY7tXFK8VH1O1jdssPD@nongnu.org
X-Gm-Message-State: AOJu0YzM+EXRsSlu7dqsAtL3sf5kfRcuEMzzFLatC5ymI72Oz7NeeDgg
 3ivhaCcM4Lxcma2ha4a5FDV3+GTqM8gaomYU8/JQuhL1KIdGxZVnUicGi+p1QR+IT8Z9HHXOeTW
 Ha+o0v5Q+JNokl4IosCdCwGHzWKYMhfk=
X-Gm-Gg: AR+sD11ycC8uJnLFs0cMEEMFJne9OAcNzw8KQfNcphDR3x1TQx2xUBiA7ho3qvkL7l2
 vlECn8LIdEkh1orJGwQ0YiXo9B2fyaXRJp6KhCJe8Zzdbig6l2ZtHgfx/LEntnVvycwc1ol0kjG
 8XGceOSsBPvyrsm3FldgOXOPMqlEp8SveYVhYSCYL/yZo7cja49cEl0d3Nox7f0lzkbA6Y9VllW
 cLSYat81qgZhORq8juU5MXWAnPDjfS7IknWZUgEwFeeU1YNsCvbIoJ6eRH1eR0Ca+8U7oeXgjJz
 h0Hz5wgN/rVqcJv0dXi9VASKI+CUgmhQ2NY3/fCCbu2cw196vOzGZHPx
X-Received: by 2002:a05:6402:4550:b0:69f:b347:a681 with SMTP id
 4fb4d7f45d1cf-6a38a9124d3mr1560493a12.4.1786698726734; Fri, 14 Aug 2026
 02:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-4-zhangckid@gmail.com>
 <87wlu2nj4h.fsf@pond.sub.org>
 <CAK3tnvLFvd6F=BLAgeE_preztLHZQDa1Va9i-Y1RAoEbiZ2vPA@mail.gmail.com>
 <20260811191913.GB170741@fedora>
In-Reply-To: <20260811191913.GB170741@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 14 Aug 2026 17:11:30 +0800
X-Gm-Features: AUfX_mx-3tZbiQSSgOmWz970AqDzOgcn90qIwGG9CXQ_YmL6_GWC3K_2t0xf1dk
Message-ID: <CAK3tnvJL0nJbH0erBf3UFc=ZAoBGGAEkeo3fmLPpZOXOpo+UXg@mail.gmail.com>
Subject: Re: [PATCH V11 03/15] iothread: track users with holder name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Aug 12, 2026 at 3:19=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Aug 11, 2026 at 04:51:55PM +0800, Zhang Chen wrote:
> > On Fri, Aug 7, 2026 at 9:41=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
> > >
> > > Zhang Chen <zhangckid@gmail.com> writes:
> > >
> > > > Introduce iothread_ref_and_get_aio_context() with a holder argument
> > > > and its counterpart iothread_put_aio_context().
> > > >
> > > > Previously, users of an IOThread AioContext did not explicitly reco=
rd
> > > > their identity, making it difficult to debug which devices or
> > > > subsystems were pinning an IOThread.
> > > >
> > > > Registering a holder takes an IOThread object reference so that the
> > > > IOThread and its AioContext stay alive until the matching put
> > > > operation. Document the ownership and BQL requirements.
> > > >
> > > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > > ---
> > > >  include/system/iothread.h | 21 +++++++++++++++++++++
> > > >  iothread.c                | 23 ++++++++++++++++++++++-
> > > >  2 files changed, 43 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > > > index b8aeb32b0e..b6664e7a38 100644
> > > > --- a/include/system/iothread.h
> > > > +++ b/include/system/iothread.h
> > > > @@ -67,6 +67,27 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> > > >  char *iothread_get_id(IOThread *iothread);
> > > >  IOThread *iothread_by_id(const char *id);
> > > >  AioContext *iothread_get_aio_context(IOThread *iothread);
> > > > +
> > > > +/*
> > > > + * Register @holder and return @iothread's AioContext.  The holder=
 is copied,
> > > > + * and a reference is taken on @iothread so that both the IOThread=
 and its
> > > > + * AioContext remain alive.
> > > > + *
> > > > + * The caller must eventually call iothread_put_aio_context() with=
 an
> > > > + * equivalent holder.  This function is not thread-safe and must b=
e called
> > > > + * under the Big QEMU Lock (BQL).
> > > > + */
> > > > +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > > > +                                             const IOThreadHolder =
*holder);
> > > > +
> > > > +/*
> > > > + * Unregister @holder and release the corresponding reference on @=
iothread.
> > > > + * Calling this function without a matching
> > > > + * iothread_ref_and_get_aio_context() call is a programming error.
> > > > + *
> > > > + * This function is not thread-safe and must be called under the B=
QL.
> > > > + */
> > > > +void iothread_put_aio_context(IOThread *iothread, const IOThreadHo=
lder *holder);
> > > >  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> > > >
> > > >  /*
> > > > diff --git a/iothread.c b/iothread.c
> > > > index 2a4c92e08b..0cc8344ee6 100644
> > > > --- a/iothread.c
> > > > +++ b/iothread.c
> > > > @@ -33,6 +33,11 @@ void iothread_ref(IOThread *iothread, const IOTh=
readHolder *holder)
> > > >      assert(holder);
> > > >
> > > >      QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder=
, holder));
> > > > +    /*
> > > > +     * This guarantees that the IOThread and its AioContext remain=
 alive
> > > > +     * as long as there is a holder.
> > > > +     */
> > > > +    object_ref(OBJECT(iothread));
> > > >  }
> > > >
> > > >  static int iothread_holder_compare(const IOThreadHolder *holder_a,
> > > > @@ -78,6 +83,7 @@ void iothread_unref(IOThread *iothread, const IOT=
hreadHolder *holder)
> > > >              *prev =3D curr->next;
> > > >              curr->next =3D NULL;
> > > >              qapi_free_IOThreadHolderList(curr);
> > > > +            object_unref(OBJECT(iothread));
> > > >              return;
> > > >          }
> > > >          prev =3D &curr->next;
> > > > @@ -199,7 +205,7 @@ static void iothread_init_gcontext(IOThread *io=
thread, const char *thread_name)
> > > >      g_autofree char *name =3D g_strdup_printf("%s aio-context", th=
read_name);
> > > >
> > > >      iothread->worker_context =3D g_main_context_new();
> > > > -    source =3D aio_get_g_source(iothread_get_aio_context(iothread)=
);
> > > > +    source =3D aio_get_g_source(iothread->ctx);
> > > >      g_source_set_name(source, name);
> > > >      g_source_attach(source, iothread->worker_context);
> > > >      g_source_unref(source);
> > > > @@ -421,6 +427,21 @@ AioContext *iothread_get_aio_context(IOThread =
*iothread)
> > > >      return iothread->ctx;
> > > >  }
> > > >
> > > > +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > > > +                                             const IOThreadHolder =
*holder)
> > > > +{
> > > > +    /* Add IOThreadHolder to the list */
> > > > +    iothread_ref(iothread, holder);
> > > > +
> > > > +    return iothread->ctx;
> > > > +}
> > > > +
> > > > +void iothread_put_aio_context(IOThread *iothread, const IOThreadHo=
lder *holder)
> > >
> > > Should we name this "unref" rather than "put"?  Perhaps Stefan has an
> > > opinion.
> >
> > It's OK for me. The original code was designed to match the
> > "iothread_get_aio_context",
> > If Stefan has no objection=EF=BC=8C I will change the name to
> > "iothread_unref_aio_context".
>
> iothread_unref_and_put_aio_context() would be consistent with
> iothread_ref_and_get_aio_context() :)

Sure, it looks much better.

Thanks
Chen

>
> Stefan
>
> >
> > Thanks
> >
> > Chen
> >
> > >
> > > > +{
> > > > +    /* Delete IOThreadHolder from the list */
> > > > +    iothread_unref(iothread, holder);
> > > > +}
> > > > +
> > > >  static int query_one_iothread(Object *object, void *opaque)
> > > >  {
> > > >      IOThreadInfoList ***tail =3D opaque;
> > >
> >

