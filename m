Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A23ECD9BE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCp4-00079v-Rc; Thu, 05 Feb 2026 22:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1voCp3-00079n-Nu
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:47:57 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1voCp1-0007Et-QQ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:47:57 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65939428896so2532347a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770349674; cv=none;
 d=google.com; s=arc-20240605;
 b=X9/PBQ3uS2AX7ghRSgruFKzm2iuZNeztGBbXs4mksdCercBfq9WwxaljAZU0mGchln
 s0aOrasX6PxwvOeGQF1QcRdXxItkyBLvXs1oQ8lZ2IwvbNxkZZ9nxiiJaLv5CRABhuFG
 y8Owuisjnore3LNzWKAMduE2GP7FCUh5pue9sww8EE72exIHQ83o1YrndgHlbNMvYh6B
 exW5G4G742a3ieZKTooHAWkq+FQqTND+AesqLOJ+7Rclcg2/YxEdgpPPbNweN0+yJ+iP
 rf5cXtXBKpq7urjBjBt4rVFRwQDFAZG0arieTg5dFtcYPhsIgyEeZGKAimKM6hllSzlj
 GpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WwC4tkgHzw41DzD8gBE/5yQIPKNmrcSY5GOhv7uCegA=;
 fh=cQ7hnC6fLJLg4X0VdG++3DarxbRbY0MROLW3rb9G9r4=;
 b=U3eBzZHJzkM59p1+aD3jlRcKKLpM5qXhVlaWjFSnXhsg79tw8bNPZ4xA7Wb3Clw2PT
 V5px36kuy0j0jGND3HJmpu+0gdY/BZM69E0WUuh63w70T008TPBHoLWFB7+9mW+2vwmR
 P4sIGs6Z2KVpGD/MaY+rVXybY2Ncuq6OQNCXKMlKlz2usO1Ww/lMvMxMv25vZBCpbjpc
 NgEWK2LHGeKqEgBe1l+7omIOVt23fKwUH6hyWAjRmFfKQBIFcX9ReaH1LIDPVSsIav55
 eSmps20dws3X6Hat7vebgrK28pweka1MxK8CiodhnqJheDz7WcY5SKoZ1xECZsYeM6io
 PvQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770349674; x=1770954474; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwC4tkgHzw41DzD8gBE/5yQIPKNmrcSY5GOhv7uCegA=;
 b=meXI7NnfziaGLeNg7xBV15Zf64VCV0nSLmGiC1R22IAI/EGm2m8pqjOB/LqLrBiAJJ
 jLo/Hk5CBAMfxpGKjRvt21JxUzCsB6jL8XZFI0on44cf2V8zShmcU9OteKApqztwWCnw
 RYzPobDeNRhHa8VpI+51sYzC9NqmaH8fBrDvu3Rqppi7F5zva4aolWEFhtKRPBHBaiSW
 /uMv8KolE2Ulr5Ok1tcO5+/ovo2jvSr6UwYgGI9LDkmSQ58UnxBPzIJ8Tm12sAYTfhdF
 ub8snsB3qxYd0EGxnPQESaOh2EEpGqonu/CFbviA2NfFL+1FYH7fireVKX4Tmyp6T5sU
 j3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770349674; x=1770954474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WwC4tkgHzw41DzD8gBE/5yQIPKNmrcSY5GOhv7uCegA=;
 b=U09ENUEtKxCTfbp+brTXGmlipHvouDm0nJTDXTUwJaKNSIxr021YUaMlTV+S2RY/RT
 vq6OdWX5866CHgW9vZgCwu3jS/3AHNl0P40BKTFa6ySxpFi1UXsT5Z5J2NCqbpCEhxzs
 FHynkyG0WaAqsf0DzNUXnqnzYGy8vHLdPG/hZgJy8yv5lXRXF0/GbkZZK4tII2Gjww6P
 Z1m0iAYiUN2tQ/J5zozzuuHB2T/9Exar5Y+LWt6CDZWjONPy7wVaSEj0s9SR0UDWxSRu
 eG90znQ0ZT58G2rpnetbZo68VPY1Mba99bQyq0jF4ohui5W1WCnGufd/dilyeBBBLrM1
 idXQ==
X-Gm-Message-State: AOJu0Yy7A1pIGXz77cEHi8Hthoe7Wd8rQzjPCIo2zC+zDYiaVr75OspW
 3edpqz1Hkeu64DmiIN6bHfoov2MtYT7XJI2jbaecqTwSw8xgmZw3xPVrUeD5HG2lHfHRqIQMZ+S
 FJiHZkn5laIckpKnMaMvtyjMYKbXywYs=
X-Gm-Gg: AZuq6aKMpw69urKs3/mSWbFH6Vgye5hHXw3SjyYyO6InH9hz4cTNG5n0WXKxrUF8cPE
 1yUqgh/EdoBV3AD30EeqV/BKZoetcS84v8Vmge71KxkMS2yHKD3GZfZIxRXGh0u/k//HUJGAyjA
 ul5/13LECxFnNB7g+lQq+6PER6x2msVo4OPKdc1P4r5R0mQb47O4LhlpchIb+lGVQKlchmZDDzQ
 BZAuQDkdGQfK68OkJDiCz39L9qZccA6NyWk4n7ENNLWxRy6vdWVAmWQIOO8Q+F4zTHwy6giaDnI
 fPCTow==
X-Received: by 2002:a17:907:940e:b0:b83:b7c5:de2c with SMTP id
 a640c23a62f3a-b8edf166657mr75400466b.10.1770349673326; Thu, 05 Feb 2026
 19:47:53 -0800 (PST)
MIME-Version: 1.0
References: <20260126094422.23116-1-zhangckid@gmail.com>
 <20260126094422.23116-3-zhangckid@gmail.com>
 <CAJSP0QWRNwXGgC4ZGMpkD=LQ27DeD7BybEqsKkRr7zrnw+ZhDQ@mail.gmail.com>
In-Reply-To: <CAJSP0QWRNwXGgC4ZGMpkD=LQ27DeD7BybEqsKkRr7zrnw+ZhDQ@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 6 Feb 2026 11:47:16 +0800
X-Gm-Features: AZwV_QiTtG8Ugbx_nVdM5L4E9VOlBWZxwgfXb9Zp3JJ9-Gks0MolwdI-yaT_hVE
Message-ID: <CAK3tnvJZtawvPS1rqQZ0P_SaHyFHRFqLn2fkyc17aZfKavYxpQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 3/3] qapi: Add attached flag for iothread
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
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

On Fri, Feb 6, 2026 at 12:25=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Mon, Jan 26, 2026 at 4:52=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> =
wrote:
> >
> > The attached flag depends on struct IOThreadInfo's
> > 'attached': 'bool'. It can show whether the iothread
> > is attached to an actual device. Show in the qmp/hmp
> > CMD with "attached": true/false.
>
> I mentioned that a ref/unref API is needed in my reply to Patch 2/3.
> The API could look like:
>
> void iothread_ref(IOThread *iothread, const char *holder);
>
> And the holder string is added to a list inside iothread. That way the
> monitor commands can report an actual list of holders rather than just
> true/false:
>
>   attached =3D ["/qom/path/to/virtio-blk-0", "/qom/path/to/block/export/n=
bd-0"]
>
> The QOM path would be a useful string to use as a unique identifier.

OK, this looks more specific.
I will try to add it next version.

>
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  iothread.c         |  1 +
> >  monitor/hmp-cmds.c |  2 ++
> >  qapi/misc.json     | 12 ++++++++++++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/iothread.c b/iothread.c
> > index 38e38fb44d..fb4898e491 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -358,6 +358,7 @@ static int query_one_iothread(Object *object, void =
*opaque)
> >      info =3D g_new0(IOThreadInfo, 1);
> >      info->id =3D iothread_get_id(iothread);
> >      info->thread_id =3D iothread->thread_id;
> > +    info->attached =3D iothread->attached;
> >      info->poll_max_ns =3D iothread->poll_max_ns;
> >      info->poll_grow =3D iothread->poll_grow;
> >      info->poll_shrink =3D iothread->poll_shrink;
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index 5a673cddb2..7463f34bf5 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -202,6 +202,8 @@ void hmp_info_iothreads(Monitor *mon, const QDict *=
qdict)
> >          value =3D info->value;
> >          monitor_printf(mon, "%s:\n", value->id);
> >          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->thre=
ad_id);
> > +        monitor_printf(mon, "  attached=3D%s" "\n",
> > +                       value->attached ? "true" : "false");
> >          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->po=
ll_max_ns);
> >          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->poll=
_grow);
> >          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->po=
ll_shrink);
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 1f5062df2a..cb865d6e48 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -76,6 +76,15 @@
> >  #
> >  # @thread-id: ID of the underlying host thread
> >  #
> > +# @attached: The attached parameter is a flag indicating whether
> > +#     the IOThread is currently associated with an active device
> > +#     (e.g., virtio-blk).  In hotplug scenarios, users can
> > +#     pre-allocate multiple iothread objects to serve as a persistent
> > +#     thread pool.  When a device is hot-unplugged, the corresponding
> > +#     IOThread is released but remains available, allowing subsequent
> > +#     hot-plugged devices to attach to and reuse the existing thread.
> > +#     (since 12.0)
>
> How is this supposed to work since Patch 2 does not support hot unplug
> (attached remains true)?

Will fix it next version.

>
> I'm also curious what the use case for this property is. First I
> thought it's for debugging, but based on this documentation it sounds
> like maybe you want to use it to avoid having to keep track of which
> IOThreads are used in a management tool?

Debugging is a use case, but more is for some cloud-native use
cases(like kata container).
The VM life cycle may not sync with the real workload(container
running in the VM),
As we know, elastic computing focuses on the dynamic management of resource=
s.
So this series try to optimize hotplug/unplug path by keep the iothread poo=
l.
After the previous task, the management tool need to unplug a virtio-blk de=
vice,
When the next task comes, the managent tool need API to check which
iothread in idle state,
and attach some iothreads to another hot plug virtio-blk device.

Thanks
Chen

>
> > +#
> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >  #     disabled (since 2.9)
> >  #
> > @@ -93,6 +102,7 @@
> >  { 'struct': 'IOThreadInfo',
> >    'data': {'id': 'str',
> >             'thread-id': 'int',
> > +           'attached': 'bool',
> >             'poll-max-ns': 'int',
> >             'poll-grow': 'int',
> >             'poll-shrink': 'int',
> > @@ -118,6 +128,7 @@
> >  #              {
> >  #                 "id":"iothread0",
> >  #                 "thread-id":3134,
> > +#                 "attached":false,
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
> > @@ -126,6 +137,7 @@
> >  #              {
> >  #                 "id":"iothread1",
> >  #                 "thread-id":3135,
> > +#                 "attached":true,
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
> > --
> > 2.49.0
> >
> >

