Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14E2C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnNK5-0000TD-Ai; Fri, 24 Jul 2026 17:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wnNJo-0000Q1-Rd
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 17:20:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wnNJl-0000fk-M9
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 17:20:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so778910b3a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 14:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784928027; cv=none;
 d=google.com; s=arc-20260327;
 b=pKnOiICskGnCEyf4TTHlmLV/61113A2tNgGZbUWXsTj0dVVd7Eq0OJvL1ECDWjCmLx
 UYhaRbJE0FPCiCe6B2e1aaLteKlpypYYdEu8SB0AqPeV3UdD7pMyV4Jd5J+GrvlJ+C39
 u9zLo07Ntag1ANgmqrEedW0aLvm5RacGnZo0q2UEX7I9ZyZPgv2VUixdXO8sleUO4KGd
 7XX7JhHPWwx/YzD1kEjupbbBAK7JqZ2eZqZWFStcl7Q4TZsWpxBUlSnKst7KlgDpOkNV
 CeCadI7xQ7aX/UQAnqzg2OjxTkiEllbL4B6whZ2pz1UFzdIu4MNd+KdHsTYx/J0jQvYv
 DRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/2m0dqcoMneC3Zf15VEtk2J/x4FvDYNzHSWnoIQbyCM=;
 fh=zZCzVSfxc8e4dVkWVmGV7fTEpV0QFLc26lm9X8SUaes=;
 b=VbMBhu8JFJbrTKInj9ST1cLOoYNHQa88NlfS6PnFfURStgoVzqJmpBmZBRmVYeIJ9A
 CPqREPlZf9FaJeFyoAopL3VLIeF/0nX4glErZK1qHLiPxYrYHgoeKnApCUi0XAQf+P+s
 Hh0z13g3Tm9f5R6vBWVT5hzxylg1k17wEapxi/cH5uZCza4v9pztc/DQVJP9nIrSosFs
 IrZDrTYQ09nc79onmrOw2E2AT1QE91ff/wn7ydQU+ZQnmZyPsoyQ1SoARnKwXnkAzsix
 i25LyLu/bzbfmG+QQZZzkG69cIOcp5EcZW3ZnEYa99Fj9Uu+q2xFd24SJ4y38BzK38xV
 nNEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784928027; x=1785532827; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/2m0dqcoMneC3Zf15VEtk2J/x4FvDYNzHSWnoIQbyCM=;
 b=iVTiFOIqi+JHQmyfMZbYZSoc/N1m5lpA7x6R5UeHF2lW/PLjGPtvvmOlIijX2XPsjo
 SEsOoRYzh5m8a5Z9JnolYQDRBU2B1/ioFKw9AdsDvXkvUqdS41qo5x1SP0/Uj6fhECeF
 H7udD2DAcpg+H5602qM431BrDkfcl5weHioolgffM7Jg1l5hbQLsDwjole4VmdDPG6ip
 99wzegEsuHL7T3OGAd0vT9idKon77XvZ5Ys11+4TxVZ9/Vgr/6oEGyLKDhuL3LoH4PQF
 Hehp4iZSTajWeBCuFVyPos3IqnDXenwhRIs3fL9wx3+ptHId3ZY+ymL3IAhZ4YNS1aVb
 +CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784928027; x=1785532827;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/2m0dqcoMneC3Zf15VEtk2J/x4FvDYNzHSWnoIQbyCM=;
 b=s22YMko0k7h8Cjobx6ZqhuomUWM+MeZDESeNSFHvpsrHHdO0s14KjlydKU0i36MKJ7
 mK4pBgIiHoSSWmMjSk1ptxq4n5WLX1WG1ozZfpIkhwnKq6ODZkWQLRSAJGbbkdrjX1Ea
 qL+xA869qZuua7+81nKrz7u3UqxY/pJbW8aGXi26OIxCPxMfb9tth1CiXAFAvH/dOvyI
 1INBAE+eHJ2WE/UDxtubO26kh4aGgS0c6RHEDQq3uX94RPZg7zeSDEkU9dx+sqco0sqG
 7HwRx5nQxD/s285gCiuCf+ziYOJ5Votu+G/6s2Id2bBXcwf1hAGBpVy2b+Ch65b1CfUN
 R2bg==
X-Gm-Message-State: AOJu0Yz+ICl3lVpebDz8A7WOLL8zvjfy6jnPkP5hFprq2zyY4uI9YMvt
 aIz9SDQS7KUrjTQdkJrQSWRq9nB7ylpLNfQKQxZThIQ6WOY+ML+SrUn3fzL99nmkg11UIWnjibd
 oXwUjc1bXtJTPdKRULxobyr/DuMui0Xc=
X-Gm-Gg: AR+sD10WcUkpPRq4HBK1dg6LLAC1pOuvOcxVQoOStTdCvEHXxIglWumsmvJptJ08tez
 zDsMp2te1MF7dYgS6ogWPGsOMyFJ2Qh4Y6K0KRw6z9HEiF0/FuHXQTYcvqQ0veyEHN86d/oZ1wm
 PD4xK40uRMjASkcGExi2jj9eZflnEWO3fIGAxBFiGu9U73BL6UyK78CTohaHXhki4gYqoUSNGdi
 r5HKkKwTIrwKWwxbovPPMiBdyqEWrNK/g5GZHQxGX/t69r0qca3v18xpwx+WHhfbcMgLV7DHcgg
 SKIWziOqSMaNeIpwIw==
X-Received: by 2002:a05:6a21:2e02:b0:3bf:8604:9a3c with SMTP id
 adf61e73a8af0-3c67da8d681mr56518637.28.1784928027076; Fri, 24 Jul 2026
 14:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-6-fabb4db3c204@redhat.com>
 <amNmcTIfZT0OFpkB@redhat.com>
In-Reply-To: <amNmcTIfZT0OFpkB@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 01:20:14 +0400
X-Gm-Features: AUfX_mxsI_64kq8171cFbZT8qZ79qBeV5buGN6-oXL7LsfnfAmcoPqSLGoAWWgs
Message-ID: <CAJ+F1CJ-fO719E=LSi6TWXC8wV6uZ-=0ereP_AgnNZQOaJZdNw@mail.gmail.com>
Subject: Re: [PATCH 6/8] block: add missing coroutine_fn annotations
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Fri, Jul 24, 2026 at 5:20=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 20.07.2026 um 09:55 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > The functions call coroutine functions or are called by coroutine.
>
> That it's called only by coroutines isn't a reason to make a function
> coroutine_fn as long as it theoretically could be called by
> non-coroutine code and it would still work fine (i.e. it doesn't yield).
>
> > Add an assert() in qcow2_do_close() code path which calls a
> > no_coroutine_fn bdrv_graph_wrlock_drained().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > diff --git a/block/parallels.c b/block/parallels.c
> > index 7a90fb5220b..46a6e8f2743 100644
> > --- a/block/parallels.c
> > +++ b/block/parallels.c
> > @@ -142,8 +142,9 @@ static uint32_t host_cluster_index(BDRVParallelsSta=
te *s, int64_t off)
> >      return off / s->cluster_size;
> >  }
> >
> > -static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
> > -                            int nb_sectors, int *pnum)
> > +static int64_t coroutine_fn
> > +block_status(BDRVParallelsState *s, int64_t sector_num,
> > +             int nb_sectors, int *pnum)
> >  {
> >      int64_t start_off =3D -2, prev_end_off =3D -2;
> >
>
> Specifically this hunk is unclear to me.
>
> As far as I can see, block_status() can't yield. Why did you add the
> coroutine_fn marker here, but not e.g. for seek_to_sector() or
> cluster_remainder(), which are only called by block_status() and
> therefore also always only in coroutine context?
>

Indeed, that's a wrong annotation I added

> I believe the right way to stay consistent is to leave all of them
> unmarked because there is no fundamental reason why they would only make
> sense in coroutine context.
>
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 19271b10a49..161626fa3cb 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -1287,9 +1287,10 @@ fail:
> >  }
> >
> >  /* s_locked specifies whether s->lock is held or not */
> > -static void qcow2_update_options_commit(BlockDriverState *bs,
> > -                                        Qcow2ReopenState *r,
> > -                                        bool s_locked)
> > +static void coroutine_fn
> > +qcow2_update_options_commit(BlockDriverState *bs,
> > +                            Qcow2ReopenState *r,
> > +                            bool s_locked)
> >  {
> >      BDRVQcow2State *s =3D bs->opaque;
> >      int i;
> > @@ -2126,7 +2127,8 @@ fail:
> >      return ret;
> >  }
> >
> > -static void qcow2_reopen_commit(BDRVReopenState *state)
> > +static void coroutine_fn
> > +qcow2_reopen_commit(BDRVReopenState *state)
> >  {
> >      BDRVQcow2State *s =3D state->bs->opaque;
> >
>
> This doesn't match the declaration of the .bdrv_reopen_commit callback
> in BlockDriver, and as far as I can see, the callers are actually
> guaranteed to _not_ be in coroutine context.
>
> If this is true, qcow2_update_options_commit() should probably be marked
> coroutine_mixed_fn and this one stay unannotated or no_coroutine_fn.

it calls qcow2_update_options_commit(), which itself calls coroutine
cache_clean_timer_co_locked_del_and_wait(bs).

But since s_locked is false, the function is safe it call in non-coroutine.

Given that there are 2 callers, I suggest we move the coroutine call
outside and drop the annotation.


>
> The other parts of the patch looks correct.
>
> Kevin
>
>

