Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F58C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACVt-0003Iz-Bc; Wed, 30 Apr 2025 14:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uACVm-0003IJ-Ik
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:27 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uACVk-0008B3-SK
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:50:26 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso335749a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746039023; x=1746643823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5i8SKjd40xYQyrMGgzw7crqd7kl9R+VF5f9d8t1mxb8=;
 b=fwOvTfZM1Aq4im7uxbpE9RINvL2JENGmOWR+RSIHVX8nkVikVORLqPdNNOK84MMUpt
 Kk2TN1LIGMRJEbSanK1OeO9rFYPnBSDbALcR02/2fBslTHswT2E3Sc17CM7Sk9vPhweM
 vU+Qe8jvovq9y/QqH1E/I6vy1SoLgk7JpQ+jm6GKMWrc8szAYeDVisP9ARZ+ckrpxGVj
 0QoeIUNqmCV5wW9XZjn5yYGcUW0CPjL3r4vX6qs7XuIIZNYHt/+jqAngE5BbZymV1blh
 6ECq/spau4qXFFV2V9c1lA/YuxGS2uvYc9FLDZSCSIvI55xIYBIOOILkYoe3SMh4Yv3C
 qnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746039023; x=1746643823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5i8SKjd40xYQyrMGgzw7crqd7kl9R+VF5f9d8t1mxb8=;
 b=kk+2wtqj7W1HrP00N3BQpo7ea/l63TKebevCzvSE744vzuQmwERN2JMce9nhq7y2cC
 aaKdtrlg+6vkfV+bS0VSL/EoOgiuc9WzaVh3wSU7wKL1yhBIj/j6eNb5hGc4yxt5Ic9V
 9YkWW4iAOq+2trG2IYNDJHEt9jyvBhewZJ2kc1Ao+/DhlBWFnkxL3yQeSn+CCzQBQxJE
 bRw1D58VLhC8Tb6oZ01yTsyRlEgDXwCmxxG2mDwTge8EIWQs0X13iQKAKTXgys+qh69c
 Dx/pmBbMaX4ckMkLDEfr2AB8uEo7rMt4apDqRhABizv0knFy341jQxArE1jnD0sNfn7n
 Z0/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0KWob5Ei6h24PLvBLHhG5fy5Fw0NJ2JmPoOE3k9qL7T/yQj1BwAtQR6eAD/TW08WUzvH0RyjJ8Rte@nongnu.org
X-Gm-Message-State: AOJu0YyEzLnbmVWi4s2o6NMn4A6LI1FYFrpes3XQ42fcLDTFxfKvSll+
 e0S6ZIpY/jgIxe6vYUmZ3l3vxE2asLyMUYzPppwjpwAWc/n1TwDisRmnYgSDwAjIhWAjJelY1dg
 FQqAJbAjN3R1wxrmpSUrTohrBWSE=
X-Gm-Gg: ASbGncuj8i6wHOQKG+7gqlPBknGUExsHmea3K0cfKTZpYqlFRYubDAQH3w09v8P3o0R
 PZds7SdEY3EwqOZ3pTakDTdfF+Fhewpj9pUiygCYsR1+5P3ZsNJaemWUaC20aek0Q8qhD2mSx2g
 ljdJxNaj0sBVrz3KrZGLK8
X-Google-Smtp-Source: AGHT+IHy+cDK49t0y0tpN93fbRwVSb92Cm59P79jguldsD+AX8AJcKkVlRGD7ABYSGeE6HQ+CR92//Sq7XHWYY657iI=
X-Received: by 2002:a05:6402:51c7:b0:5f4:d22e:28b9 with SMTP id
 4fb4d7f45d1cf-5f89ab6826fmr4260766a12.3.1746039022595; Wed, 30 Apr 2025
 11:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
 <32df0a6d-93c7-4474-bae5-2254e6c1ecd2@proxmox.com>
 <d6c6916a-5112-4c78-894c-d01fd756a2f7@virtuozzo.com>
In-Reply-To: <d6c6916a-5112-4c78-894c-d01fd756a2f7@virtuozzo.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 30 Apr 2025 14:50:10 -0400
X-Gm-Features: ATxdqUE6PA6g2zgHzxYcrFAcXpxvdss3Z5TZ2W6MhBO7-yolEhs3yQHyIWKEfpo
Message-ID: <CAJSP0QWo9fxGovRbUPmLb3Oma2ankbKE0KG=9pWGj0U7ggDhFw@mail.gmail.com>
Subject: Re: [BUG, RFC] Block graph deadlock on job-dismiss
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org, 
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, 
 "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 30, 2025 at 10:11=E2=80=AFAM Andrey Drobyshev
<andrey.drobyshev@virtuozzo.com> wrote:
>
> On 4/30/25 11:47 AM, Fiona Ebner wrote:
> > Am 24.04.25 um 19:32 schrieb Andrey Drobyshev:
> >> So it looks like main thread is processing job-dismiss request and is
> >> holding write lock taken in block_job_remove_all_bdrv() (frame #20
> >> above).  At the same time iothread spawns a coroutine which performs I=
O
> >> request.  Before the coroutine is spawned, blk_aio_prwv() increases
> >> 'in_flight' counter for Blk.  Then blk_co_do_preadv_part() (frame #5) =
is
> >> trying to acquire the read lock.  But main thread isn't releasing the
> >> lock as blk_root_drained_poll() returns true since blk->in_flight > 0.
> >> Here's the deadlock.
> >
> > And for the IO test you provided, it's client->nb_requests that behaves
> > similarly to blk->in_flight here.
> >
> > The issue also reproduces easily when issuing the following QMP command
> > in a loop while doing IO on a device:
> >
> >> void qmp_block_locked_drain(const char *node_name, Error **errp)
> >> {
> >>     BlockDriverState *bs;
> >>
> >>     bs =3D bdrv_find_node(node_name);
> >>     if (!bs) {
> >>         error_setg(errp, "node not found");
> >>         return;
> >>     }
> >>
> >>     bdrv_graph_wrlock();
> >>     bdrv_drained_begin(bs);
> >>     bdrv_drained_end(bs);
> >>     bdrv_graph_wrunlock();
> >> }
> >
> > It seems like either it would be necessary to require:
> > 1. not draining inside an exclusively locked section
> > or
> > 2. making sure that variables used by drained_poll routines are only se=
t
> > while holding the reader lock
> > ?
> >
> > Those seem to require rather involved changes, so a third option might
> > be to make draining inside an exclusively locked section possible, by
> > embedding such locked sections in a drained section:
> >
> >> diff --git a/blockjob.c b/blockjob.c
> >> index 32007f31a9..9b2f3b3ea9 100644
> >> --- a/blockjob.c
> >> +++ b/blockjob.c
> >> @@ -198,6 +198,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
> >>       * one to make sure that such a concurrent access does not attemp=
t
> >>       * to process an already freed BdrvChild.
> >>       */
> >> +    bdrv_drain_all_begin();
> >>      bdrv_graph_wrlock();
> >>      while (job->nodes) {
> >>          GSList *l =3D job->nodes;
> >> @@ -211,6 +212,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
> >>          g_slist_free_1(l);
> >>      }
> >>      bdrv_graph_wrunlock();
> >> +    bdrv_drain_all_end();
> >>  }
> >>
> >>  bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
> >
> > This seems to fix the issue at hand. I can send a patch if this is
> > considered an acceptable approach.

Kevin is aware of this thread but it's a public holiday tomorrow so it
may be a little longer.

Stefan

