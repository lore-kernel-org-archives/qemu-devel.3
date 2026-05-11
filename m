Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBB1CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMWGD-0000lB-Ew; Mon, 11 May 2026 15:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMWG4-0000iS-N5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:25:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMWG2-0005xN-Sl
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:25:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bc66ad3742fso766486566b.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778527537; cv=none;
 d=google.com; s=arc-20240605;
 b=Bh37+DIYpXF0IoEmumEVTADIpO9p9SJKKRRmYZ2iOjxPMh8OQebmo7AIyM8RweCG9n
 mZuRe5m1r6CC7Y00C4l9yNQGViB+wuaVmmgZejuXasnWI+OudGJQLIyxDdio1xOOVAm4
 wZ4SiVE07L79rrMohBhrxSC0VuzmwwVUgr+YMQk17TZa+q9ce4UIhJ7oUcKXbRWoes6T
 qKO27wAefjoUaOjci/1kpfe/X5TVWy2N+LOa1MW3LDep9dQ2ehltCgO6Xi79CxA8cWQX
 c/phzxCRDM5+yPqkjgZWZMuyUaVr/3jjVHV/CtDA8LbBcFUDjZNEdY2GlXP0Aj1y/s2q
 jbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RW8Oa/jgeLirSJv50q54g20Gsc6f/BwR8EGsiyq53Uw=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=D3DFtlIbDfQQq9Ggc2EPJRsvGmQcUqahc43sdull9hg774KMu8baMviBYSAkvjdZxL
 VoIvHs8rBteG3Zr93vBJ0AQa6NoNCULnGdo56JZ+AjEoZhCG+YL2pF37SANUBCP+JIkE
 yggBGy/CSmbuOOjjscFRIaXCZYhIA0l5GLzN0b6btLdlArrl+qvnYmL+eBfYY5LX9b1I
 /T5norc79riXbiF4CZ6kEGREjCOx95L/ykd6VPiAK0nexKTnpLJqhH5mmjj6yK9LUV8e
 ia1n62VUQVS+WbNosd9VKZvBWb0mferzjxkQu/v75vId1Pr7CKLtozj3p3+jOkpKS2wE
 eikQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778527537; x=1779132337; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RW8Oa/jgeLirSJv50q54g20Gsc6f/BwR8EGsiyq53Uw=;
 b=onBh8sOiWcGYDBGrGhoxaTJAmZVRgn8G6Od/l6XYQeeO1/1lMpYWch4NKkOM04e3L3
 7AOsKPma5K5CwK+w+Ocpn89IWgs4dQ3AwF/R7+SXrF4XEpfJaezc9fGLDkPxsWH8GQS6
 s/S5j3kkDg3nsvhQtuglX5RYoHUpXL9f8oQBRITVCBBn3cELtWztAJh97eA2GOhrUHRO
 HvthqxmIkBL937seGv6pQJdnt2HpfC5NF5q/iOFosmSUxJQUnV2kDHJFVGY5THe9VIKK
 TkBdhgVWYpbcBWaes4uuomQDsoOslRB9y/y3mqr/VjTC68hf0qdE3tNXzgQNIdTyJIS7
 g0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778527537; x=1779132337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RW8Oa/jgeLirSJv50q54g20Gsc6f/BwR8EGsiyq53Uw=;
 b=AJAJADQtvOV+L2R+H6SvCy3Pi18fGuoeYmiVMTLIl+rAxh2P6f+DftSgxOO1iN/O3r
 iK0dvyla3/OmVJN/6Unv8U5GkcdI1+Bk9bDIvBcKwXG/DVLtJkhGyJCQycQPpI3araH2
 9y7mlZB85b3dcpxOfNsdL0Td41Ca8hA5OXoS8XYP1nLbznYigRIw6IiiV8NMHLP9/WPP
 jsplrdJoAOlwc2euCWoVFkN4z7U0F0pfFsLAtWd+HR2pnpuSf417Gn2fZkZIg/7enErW
 ZC/GiXBvEbqfobnz52QkeL4jmpz1vpHNPifF0cG++hf0pSnodJNBXQUIYAJgJoQ6GM1s
 iw3A==
X-Gm-Message-State: AOJu0Yy0rlJJOmZdZbTHlm52g89bGqh972o0OfZ20jlWTU4bwKMmDSoz
 en9r8uV9LBlByDKATEBCqt78ZkmHtrPi0MJUBeJ0HKO+QdQNOaHhO/uoeFQInezCCb2AdOrJbxZ
 bIypWQTj7LyhwC3OWRT4cN/Ijv5NaJJg=
X-Gm-Gg: Acq92OF2NdBTF+MnuRjnDgjnBC72BzlN/vILIrY4Nljq4IWSxXl/pnCImbd2Os0yJZE
 PMcHUDgDDOSw8sNcXHiHnJV9A0YX/cWwAmN2nWVJk9IamFObWBNVG0nDYUdZJKK4p5374GGWB8o
 c4TLcI49bh1gUS/7L4X6dw+pm36XQhjBapOR8tlsIga+kSoszFoed71Wb2gu0xObz8gp5CNMgmM
 A0azq+jzNl9CRdiXMKCAgemnPtB3ArQ3HLaGxop2JI+C6eNlxuGr2jqtTz6hCFrtM6JDn8uYRp+
 ZVogiGCcKNjCc8uueoU=
X-Received: by 2002:a17:907:3948:b0:bd2:2852:683b with SMTP id
 a640c23a62f3a-bd228526f98mr76237966b.16.1778527536908; Mon, 11 May 2026
 12:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-5-zhangckid@gmail.com>
 <20260511190523.GF536999@fedora>
In-Reply-To: <20260511190523.GF536999@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 12 May 2026 03:25:00 +0800
X-Gm-Features: AVHnY4JKAnJHfzkPIQA6ZqZaNc4eCu7wH4-3HLirH09q_dDeIn64PEvtbPzp0FE
Message-ID: <CAK3tnvKQGEVpMGyqzftritSQ4Vw1KGd3WWhaJEsR=GwrZJPZcg@mail.gmail.com>
Subject: Re: [PATCH V7 04/14] blockdev: Update tracking iothread users with
 holder name
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

On Tue, May 12, 2026 at 3:05=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, May 11, 2026 at 10:04:06PM +0800, Zhang Chen wrote:
> > Currently, x-blockdev-set-iothread changes the AioContext but does not
> > track the IOThread object itself within the block layer. This makes it
> > difficult to manage IOThread reference counting (put/get) during
> > dynamic context switching.
> >
> > Introduce an 'iothread' field to BlockDriverState to store the current
> > assigned IOThread. Update qmp_x_blockdev_set_iothread to perform
> > proper reference counting using iothread_ref/put when moving nodes
> > between an IOThread and the main loop.
> >
> > This ensures 'info iothreads' (holders) accurately reflects the block
> > device attachment state after dynamic migrations.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  blockdev.c                       | 6 +++++-
> >  include/block/block_int-common.h | 5 +++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/blockdev.c b/blockdev.c
> > index 6e86c6262f..6e20579187 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -3683,8 +3683,12 @@ void qmp_x_blockdev_set_iothread(const char *nod=
e_name, StrOrNull *iothread,
> >              goto out;
> >          }
> >
> > -        new_context =3D iothread_get_aio_context(obj);
> > +        new_context =3D iothread_ref_and_get_aio_context(obj, node_nam=
e);
> > +        bs->iothread =3D obj;
> >      } else {
> > +        if (bs->iothread) {
> > +            iothread_put_aio_context(bs->iothread, node_name);
> > +        }
> >          new_context =3D qemu_get_aio_context();
> >      }
>
> This command is the wrong place to associate an IOThread with a
> BlockDriverState:
> 1. Do we need to call iothread_put_aio_context() on the current IOThread
>    when x-blockdev-set-iothread is called with a new IOThread?
> 2. Is the AioContext leaked when x-blockdev-set-iothread iothread=3Dnull
>    is not called before the BlockDriverState is freed?
>
> Every BlockDriverState would need to get/put the IOThread AioContext in
> bdrv_change_aio_context() or related functions.
>
> However, the QEMU block layer has been moving away from having a
> per-BlockDriverState AioContext. It is possible to use a
> BlockDriverState from any AioContext (including multiple AioContexts at
> the same time). I'm in favor of not associating BlockDriverStates with
> IOThreads and instead relying on their device owners (e.g. emulated
> storage controllers) to be the IOThread holders. That means you could
> use iothread->ctx directly or create an
> iothread_unsafe_get_aio_context() API to document that this is a
> low-level unsafe way of getting the AioContext.

It's fine for me, I was troubled for a long time by the specific
implementation of this problem.

Thanks
Chen

>
> >
> > diff --git a/include/block/block_int-common.h b/include/block/block_int=
-common.h
> > index 147c08155f..6edaf53377 100644
> > --- a/include/block/block_int-common.h
> > +++ b/include/block/block_int-common.h
> > @@ -1101,6 +1101,8 @@ typedef struct BdrvBlockStatusCache {
> >      int64_t data_end;
> >  } BdrvBlockStatusCache;
> >
> > +typedef struct IOThread IOThread;
> > +
> >  struct BlockDriverState {
> >      /*
> >       * Protected by big QEMU lock or read-only after opening.  No spec=
ial
> > @@ -1289,6 +1291,9 @@ struct BlockDriverState {
> >
> >      /* array of write pointers' location of each zone in the zoned dev=
ice. */
> >      BlockZoneWps *wps;
> > +
> > +    /* Track the iothread for detach aio context*/
> > +    IOThread *iothread;
> >  };
> >
> >  struct BlockBackendRootState {
> > --
> > 2.49.0
> >

