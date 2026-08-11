Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6634C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtiDu-0005uc-IP; Tue, 11 Aug 2026 04:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wtiDs-0005uP-0L
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:52:36 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wtiDq-0001xK-8O
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:52:35 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a17f91so4403957a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786438353; cv=none;
 d=google.com; s=arc-20260327;
 b=KCtwlTS/beQ/wCTz6l/5DrQUhzMQgmdXGRx0TnChNYHhO/Zs72CN2ba2Ddn3izEvkr
 5+VyXB559Exeq/lDSEZ8Psx8vkgHcOnHE5PxphEsaQZ/EwZ00FoaEmFyczBtiQeyBTsj
 DB3nwBiZUWP5UTzR0mHxx94iF5klKuaUt7gH50wi3kxbD+m/H98CvaPSPjmlclU30YwH
 mTtVT2E6WUHdxJD9unkpg0J7zBwPZlvCqs28jBy62Hd32AmLzilmXQh8GT364Dcl2Vj3
 OVPhcrbM0YCR7AS8AtTZs6FPT2y5DecLMK+RBnuC/YIaDYW2YJk2UR3z9FCxKxUeJfCP
 otvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kBhIEUMSM4rRcnPUQ5T8iDvGzxNZeqzEPruSFEhYgQw=;
 fh=RNR0fx3lVXtwzBb+Z+kUg6SLYrgtIDSvnMyWvrMTeRk=;
 b=RzveEb14Q0Zk7FUGHgI0BIfV7ubpkLu2dMcoZgdJfxQQ8UerOacvJXWXJvdv/jMkwM
 k0TpFEfGlXBJsX9mdVFiLFs2buNr6jKNKwI6TolpGqa2pE3U12vmAzY/+6RaFZGeSnWt
 n5/hD/p+9UtiDnYONmtb30b9kty32sEPo8HaVws5Vqmg1gu5XbFGlroN1GwvbnWkG6jr
 lTfdX9og2wM+qEa4QkFqBiwBweSgczoiyQW1oVwydPiR9ka4T8rjP39ohR6ECw/YHyPE
 IbVCBqp5d9ZdNWPas/jc+qBFmLqQYrwlpI1UYIKWq10414hA/drXf3PKdOi3A+NyZVbp
 zXOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786438353; x=1787043153; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kBhIEUMSM4rRcnPUQ5T8iDvGzxNZeqzEPruSFEhYgQw=;
 b=IqRNZqFZaolj001BQSiCKt5AdFh4nsbz1bODkqbOW3i26JSrYWTSyxujF5W3fHeNxa
 n+LHzh/5s+zD59JaPVUb3fizs6sZlxQBnFfMDX2WH9BN8dNPMcrkU5qJnv3iPr4HfCed
 Ur7NT0MS0OFpNq+YefifYfpQsFWpyff+s0Wqwrixg0Vab186D0aJfc8cFG2zD2KksMEv
 Ve5rYpMKmdKWks0fORSguqZWG1JyFTI1UNaMIPTjuEXugvo1mukl2VPbO8E66o7GL/go
 S9j0IyFZrC3SGVCaw0+2seMZEIGftXfhHTWnmXT45t9omg4n5xRZxAaFxkLsDH9CQDQz
 L7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786438353; x=1787043153;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kBhIEUMSM4rRcnPUQ5T8iDvGzxNZeqzEPruSFEhYgQw=;
 b=A3cqeOEentZ95Pd6dEm7NUJK0u44yBNZB4RAohcPH84qNAXbyDGvN//nDzJ2Pk31nF
 A+1gM7rbgZ/bRmF3102c5K2Q0iGiwy3SK5PxZDfH6lx/p+sIl+QN3igH3oChStQ+x2z6
 HNIEEiobSZRN2UkNlOVbj41qfbI5ZjbTgdY+05h5vpkz9gXTiztOUirfBDl5Q9Lh1pju
 +qeO0tkZoC0WQjTgxKpFPF4cYTiTMoWmjNWS2j9bnxAGP09Va0/Zxd9aNSQp5lEpp7iz
 KbMY7yRYZjP1AqwHAKvyIhlPKBP66pcOlLWqodPua/2melYUMzbTkATf9Dox1UTPgfN7
 /Vug==
X-Gm-Message-State: AOJu0YzjQdBDElqiJ833G4Xj9SptFlgOUn2NodgTFRjJqgBSgriMl/Nr
 rlb4P9r0CUACknNcdDemhFLx3l7TOOZBFc79dLtRFVpRrEyUscU/53s8OyRfSnBMEQTeFaVhliw
 2jJdiELLjkmoIgB4KIlTPFThus5LGp1o=
X-Gm-Gg: AR+sD12CIR4ew3oqmo8Vl8GyqJOiWvaEWKa4aoiun5d5m3AdAjn58Eq5q6djxAvOpId
 hIUMcJEbIzmWdfkGXLo1esv+LjgFPp3izQ1wH6XdWT32RDPyaZznxmyINCO+/IJdEBV80pmza4l
 d84EICeCdBpOFvCz0ZLems5kzu9OJM1y2IQ39T3G2HBiSrjWSYKCS0jcEALoQ+4dErxv1H/wauk
 oGXPW8b4UNDM3MD+2HYmaVCwUqP4swwsNcMjPilJIHlPrTY0JH70ofmW/XeNyFFsFPtdIx85DDy
 whwatf2aGsWQ0X/S8unHuZgwoImrFId/duy8PfznMIJQaLNZUqtfOw==
X-Received: by 2002:a05:6402:280d:b0:6a1:f16a:796e with SMTP id
 4fb4d7f45d1cf-6a36447a8bamr1073903a12.1.1786438352385; Tue, 11 Aug 2026
 01:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-4-zhangckid@gmail.com>
 <87wlu2nj4h.fsf@pond.sub.org>
In-Reply-To: <87wlu2nj4h.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 11 Aug 2026 16:51:55 +0800
X-Gm-Features: AUfX_my5EUdz5q25PrB5J1-ONralAqswJ9-NKRyUqx8BWfuy7LfSN35d8N-sWUo
Message-ID: <CAK3tnvLFvd6F=BLAgeE_preztLHZQDa1Va9i-Y1RAoEbiZ2vPA@mail.gmail.com>
Subject: Re: [PATCH V11 03/15] iothread: track users with holder name
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52b.google.com
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

On Fri, Aug 7, 2026 at 9:41=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Introduce iothread_ref_and_get_aio_context() with a holder argument
> > and its counterpart iothread_put_aio_context().
> >
> > Previously, users of an IOThread AioContext did not explicitly record
> > their identity, making it difficult to debug which devices or
> > subsystems were pinning an IOThread.
> >
> > Registering a holder takes an IOThread object reference so that the
> > IOThread and its AioContext stay alive until the matching put
> > operation. Document the ownership and BQL requirements.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h | 21 +++++++++++++++++++++
> >  iothread.c                | 23 ++++++++++++++++++++++-
> >  2 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index b8aeb32b0e..b6664e7a38 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -67,6 +67,27 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
> >  char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> >  AioContext *iothread_get_aio_context(IOThread *iothread);
> > +
> > +/*
> > + * Register @holder and return @iothread's AioContext.  The holder is =
copied,
> > + * and a reference is taken on @iothread so that both the IOThread and=
 its
> > + * AioContext remain alive.
> > + *
> > + * The caller must eventually call iothread_put_aio_context() with an
> > + * equivalent holder.  This function is not thread-safe and must be ca=
lled
> > + * under the Big QEMU Lock (BQL).
> > + */
> > +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > +                                             const IOThreadHolder *hol=
der);
> > +
> > +/*
> > + * Unregister @holder and release the corresponding reference on @ioth=
read.
> > + * Calling this function without a matching
> > + * iothread_ref_and_get_aio_context() call is a programming error.
> > + *
> > + * This function is not thread-safe and must be called under the BQL.
> > + */
> > +void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder=
 *holder);
> >  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >
> >  /*
> > diff --git a/iothread.c b/iothread.c
> > index 2a4c92e08b..0cc8344ee6 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -33,6 +33,11 @@ void iothread_ref(IOThread *iothread, const IOThread=
Holder *holder)
> >      assert(holder);
> >
> >      QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, ho=
lder));
> > +    /*
> > +     * This guarantees that the IOThread and its AioContext remain ali=
ve
> > +     * as long as there is a holder.
> > +     */
> > +    object_ref(OBJECT(iothread));
> >  }
> >
> >  static int iothread_holder_compare(const IOThreadHolder *holder_a,
> > @@ -78,6 +83,7 @@ void iothread_unref(IOThread *iothread, const IOThrea=
dHolder *holder)
> >              *prev =3D curr->next;
> >              curr->next =3D NULL;
> >              qapi_free_IOThreadHolderList(curr);
> > +            object_unref(OBJECT(iothread));
> >              return;
> >          }
> >          prev =3D &curr->next;
> > @@ -199,7 +205,7 @@ static void iothread_init_gcontext(IOThread *iothre=
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
> > @@ -421,6 +427,21 @@ AioContext *iothread_get_aio_context(IOThread *iot=
hread)
> >      return iothread->ctx;
> >  }
> >
> > +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> > +                                             const IOThreadHolder *hol=
der)
> > +{
> > +    /* Add IOThreadHolder to the list */
> > +    iothread_ref(iothread, holder);
> > +
> > +    return iothread->ctx;
> > +}
> > +
> > +void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder=
 *holder)
>
> Should we name this "unref" rather than "put"?  Perhaps Stefan has an
> opinion.

It's OK for me. The original code was designed to match the
"iothread_get_aio_context",
If Stefan has no objection=EF=BC=8C I will change the name to
"iothread_unref_aio_context".

Thanks

Chen

>
> > +{
> > +    /* Delete IOThreadHolder from the list */
> > +    iothread_unref(iothread, holder);
> > +}
> > +
> >  static int query_one_iothread(Object *object, void *opaque)
> >  {
> >      IOThreadInfoList ***tail =3D opaque;
>

