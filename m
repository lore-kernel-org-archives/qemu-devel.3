Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5046FCDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 22:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcWOY-0001IN-Ig; Wed, 24 Jun 2026 18:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcWOV-0001Hv-8f
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 18:48:31 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcWOT-0006xq-Hh
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 18:48:31 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c074ac8adaaso199081966b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 15:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782341307; cv=none;
 d=google.com; s=arc-20240605;
 b=kmq9eqqjGMFJ1ZUYnqSDbPDJb8kzKFPrtDwKF/cXpvLJN9CfEFfs9PyahWhsEBown9
 fnTL3D0kWR9LJQLz3BcfAWbNRqOPKdRn+eDT4p9VRCAWSNjyB1wR7tNnfXorffop9yVq
 zPTKewzV4/ypm4FAJAXrIV+xjmYvn3oyFytvzQuaIU4hhEkt6qnKaZjC2AEkXMnGrHMp
 DlR4gu9UDqBHLWhFrc9F8Pu+vcSGlNLC+ZXEb3C1pj0fWa4Y92zzB8mGL3qZC5lUqHra
 8hiSZb3y/mMGEEDZBwtDNv1BZmZU2x0IIbXx2ZXzD+eAbKNmj5hsfI8Uqc39yGJMIUIg
 dLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cKcuGnCnmQHvmskSwk8bfzkCEdThBfeWpGr00nk3ark=;
 fh=dEcCJoizW0PIXIsgsrNAtfPedPj0hmKZvH/dXrAI1HE=;
 b=d7hsDwEqKLjwvSw20dLl72Cq4tj0Wjf6I3AKnmU+gcrpxVqDoY84csZfp98kp4toNc
 5JinKZO70BX0URKNZq9QYvsJzxO9PHhQDW82kWRnl9BJ/xjUhEbliTKlGFpeT9MitXY0
 S/tS4CGAqgORnndEQGx0u95mWWHZorFjoTpR/MNSpm1zzrZRWjH4+jyj1lub7tZtdVuN
 cAxuCP+x3L7XdlqnrwVSGlX+/BuCgctX3GFBOIPBV+SzjcvCZWO9GoedrzAYCNepw4uO
 oGZxwy3onzGdiqCjBq4ccTxwvv3KB6EQKLdsA/vLVvWGUais59nEectnz4ElUigGEAb9
 CfLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782341307; x=1782946107; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKcuGnCnmQHvmskSwk8bfzkCEdThBfeWpGr00nk3ark=;
 b=T0QVn9btsyX6OLZgLFTtsZHvBZcsysFW53zFNG3uFeZUj6CZwQDT0JXrWdT7NKotCk
 AwK77bfqaaVJxBNupQ0yv9YVfptsH1h0SuDb+aQJFBBh23dIqVSYH1zz3ygXKfm8XaJW
 wuQG24txjUpU9adlx9DKYcY9FIYXYJCM2+aDHZ8xDY/aqjcu8EVE3FcuPyV0qEQQ9Fx9
 jif/rJKp2A06zMaWnsNm/yc7VxqBf6pGbby0mqd7XCPIluZM/96zdD/uuPOf/YKF9Vxl
 9ZV7c1oxw0qkTJnOwhxhaDVSKr1Ip1siH9gSewWSmPxgx9z08qg9XpVbhZWMj1Iz3pAo
 FMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782341307; x=1782946107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cKcuGnCnmQHvmskSwk8bfzkCEdThBfeWpGr00nk3ark=;
 b=Ym8KLyDI+T+t5x4u9N4o4Pu6W0hvqhLQWA/zkShg8LHeFTK7Nt+/O7NuqyIWZ1brf2
 PomyFESz6bepOIN9/UQxxIxqvOWhnZ3mTsdyfidwEszHUNTqSA9ECUxjG4eJ566L9RLe
 FM7o2FDgldQ/Wi/avIuizkjHO1gOES1u2iAOodtbwgOYyyl7Hqh0UHOez+sYTsbr+EQq
 yTZVMZUw7k3SYnYAkP6rqlu18QTYLVjtLXQ0+CKx88Zc3N8ekPaXLd11HdpY2PqQv4r4
 JcjuOpE7baj4VIERmfghrjzzMn3OwVbeY9c0fqIQhC8lSPITkYtqW9IvYUIsK3SMg5Ls
 fvqA==
X-Gm-Message-State: AOJu0Yzh2ArMrIZtzM2lg+O053uiIDwc38wrxcNRqQ2tU3amlVpi+y8q
 5zp6qxyzTdej5+i8g7kKtT955P9pgtT//4dx9SKJg6d4S+/U6d0gN6liBIS21fDrCXGWm949Awa
 QQOs6KjJLuzjMWnC8iDSPL4ylpYjFAN8=
X-Gm-Gg: AfdE7cnY/zwpXlD+nFVrScF/BYMe6iiStiPHSq0S/Tqay3tl1kcwFDwqIKLoLU0z5XV
 nrbXQMkrmMjDQI2CHVjjv/djPfw7K5s+kwQahVih9KHeGnv6zfew04p/JuCQ2RQGoSQwrbHjGjN
 Uoe0ESSGODHgZfA6kHf703LY/pt6DYK/8OpmSAOVDwsWSyOfF5bNnckCOMMjoT9tpSuZbX418Kq
 OYZhrqWnazjdD8YJKKYHUlml4QXDagQ9B4ALZxZp1OxsBJ/mKbbN3cVrK8xmtf0xNt6W688
X-Received: by 2002:a17:907:e105:b0:c11:efec:6ca9 with SMTP id
 a640c23a62f3a-c11efecd9admr163104666b.8.1782341306670; Wed, 24 Jun 2026
 15:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-3-zhangckid@gmail.com>
 <20260624155133.GA109308@fedora>
In-Reply-To: <20260624155133.GA109308@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 25 Jun 2026 06:47:49 +0800
X-Gm-Features: AVVi8CeNTouTTb_HVEsupgsjDTwr1vWBB5xW2XQPlBFaW0p1t2BE4qrJrh4O9EA
Message-ID: <CAK3tnv+apnBGoyaXqt-CO2rtkC6L_WaQRmYmw9wQbQ4pci=b3Q@mail.gmail.com>
Subject: Re: [PATCH V9 02/17] iothread: introduce iothread_ref/unref to track
 attached devices
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62d.google.com
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

On Wed, Jun 24, 2026 at 11:51=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Wed, Jun 24, 2026 at 03:08:36PM +0800, Zhang Chen wrote:
> > Currently, IOThreads do not maintain a record of which devices are
> > associated with them. This makes it difficult to monitor the
> > workload distribution of IOThreads, especially in complex
> > hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
> >
> > This patch introduces a reference counting and tracking mechanism
> > within the IOThread object:
> >
> > - iothread_ref(): Prepends the device's IOThreadHolder to a list.
> > - iothread_unref(): Searches for the IOThreadHolder using a custom
> >   string comparison (g_strcmp0), releases the associated memory
> >   upon a successful match.
> > - holders: A GList storing the IOThreadHolder of attached devices
> >   for runtime introspection.
> >
> > A later commit will add QMP commands to let management applications
> > query the attachment status of IOThreads.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h |  5 +++
> >  iothread.c                | 94 +++++++++++++++++++++++++++++++++++++++
> >  qapi/misc.json            | 61 +++++++++++++++++++++++++
> >  3 files changed, 160 insertions(+)
>
> Minor comments below. This patch looks good overall:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks~

>
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index a1ef7696cb..b9207ad829 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -50,6 +50,11 @@ struct IOThread {
> >      bool stopping;              /* has iothread_stop() been called? */
> >      bool running;               /* should iothread_run() continue? */
> >      int thread_id;
> > +    /*
> > +     * The list elements are of type IOThreadHolder, which can
> > +     * represent either a QOM path or a block node name.
>
> This comment duplicates the IOThreadHolder types and will become
> outdated easily. It might already be outdated (there are 3 types, not
> just the 2 mentioned in the comment). I suggest replacing it with
> something like:
>
>   /* List of iothread_ref() holders (elements are of type IOThreadHolder)=
 */
>

OK, Sorry, I forgot to update the comments with the patch version updates.

> > +static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> > +{
> > +    const IOThreadHolder *holder_a =3D a;
> > +    const IOThreadHolder *holder_b =3D b;
> > +    const char *name_a, *name_b;
> > +
> > +    if (holder_a->type !=3D holder_b->type) {
> > +        return -1;
> > +    }
> > +
> > +    switch (holder_a->type) {
> > +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> > +        name_a =3D holder_a->u.qom_object.qom_path;
> > +        name_b =3D holder_b->u.qom_object.qom_path;
> > +        break;
> > +    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
> > +        name_a =3D holder_a->u.block_node.node_name;
> > +        name_b =3D holder_b->u.block_node.node_name;
> > +        break;
> > +    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
> > +        name_a =3D holder_a->u.monitor_name.monitor_name;
> > +        name_b =3D holder_b->u.monitor_name.monitor_name;
> > +        break;
> > +    default:
> > +       /*
> > +        * This should not happen. If it does, name_a/b remains
> > +        * NULL and g_strcmp0 will handle it safely.
> > +        */
> > +        name_a =3D NULL;
> > +        name_b =3D NULL;
>
> return -1 would be simpler and safer. g_strcmp0(NULL, NULL) returns 0,
> so callers will think they have found a match and proceed with their
> operation - it will likely result in undefined behavior since memory is
> probably corrupted if we got here. It's safer to fail the comparison so
> the caller does not proceed.

OK.

Thanks


Chen

