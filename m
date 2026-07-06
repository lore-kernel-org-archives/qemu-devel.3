Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D3BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfIX-0002o2-Dg; Mon, 06 Jul 2026 05:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wgfIU-0002nh-Mz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:07:26 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wgfIS-0002RC-UM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:07:26 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so5193571a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783328843; cv=none;
 d=google.com; s=arc-20260327;
 b=QYhTwJYdaWGgOmXZpTSYfh49OLF8BuefeBk3wGEnS/sSPi6A4P8P5g0jLDg/9wNe4z
 S05qcCILi0EpksFQMv2V8ybPDtix5pWVgTBTv3EbJWBmfpnrNgGFXiDELGJfEQ4UiUp2
 x2km8s9rCeitR4ufH350Ptg6UWgTuP6F+R09o20Mjn07tjyeoKGtL7M78DqSTTTeBOKW
 MbOzYyHG6jR3EJavVgmKR9ECKktBJHz8G8W38o8SGEB2u4T0LU0mzAqdz/mhPGA7E7y8
 CjGhvbFMtzfhZW7FTFQXNF4SYfVxIAmEEo5o+wzjIzVzJvlhT11TaWit39+KoRx9zXvZ
 T9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f90l64fomCI4Q4i3aw+fYgZpIzi6PAm4mu8P3ZZO/Po=;
 fh=hCe7fhTvWgm7aze1oINXwc4Q2ljHDCj1vM1faYlyM2g=;
 b=p05g7FHA5nab61wiUXZo+O9sRQ/Hi1qljzEwgML6ui7bvZYUO5Fk0vDeCrOxJJwuJn
 y8XMfYYtfllnDoZt91nwUeE2M+XiDvhbG1GKVkUcetmF7RL2aLZ0Wi6QjvwbY0qcVreq
 duXd+khA8WPK/eiFvYZS0JEKQMOoCRa0mMIwPwJvl7V2A3wLbWjmfDCjWyszIuFkx1xQ
 ShinzrqPgw2UPel4psVxiZOdXykLyzBAQYzbNYcwYv6oG4Ta+Vl+++Nr8GAphisJJv7l
 xYHXkKz7hIfgr9ZJ0GDsmnE77MRCbunFxCbnNXqoar5gV+n5arSMECHQhRXVm30AObjD
 Wy7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783328843; x=1783933643; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f90l64fomCI4Q4i3aw+fYgZpIzi6PAm4mu8P3ZZO/Po=;
 b=VaBtdY0iqkw9lMvfQEJ6DAen9faES/vUu0Okv5948v8fHwUVxhLBRjYcZJ/m4oDaBh
 CnpP9jmAhFJYBZfGbRvl56OQHKj9dc9pRA44/u2kVohBsJQ9WqNlYryVbvwfelz1Yn7n
 RlL8Bc5yo9VuYay8yfaj/BD2og378E8V2mwPVWIr2vdIdmmpsDtAqUcT93MlzAnNORGV
 oc2mc36TkPhyMSByGWOs+jSr7rcVK94py0m+tgn4NtRQN0dlbgd7RBu9mMs4DVPuFxy6
 xc0mfIxh+dGO4ZEwYzol3hA4U1g9z4/x97WKprYtIDdW7MjiykZf0dc19OtrtLs5cc+q
 CleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783328843; x=1783933643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f90l64fomCI4Q4i3aw+fYgZpIzi6PAm4mu8P3ZZO/Po=;
 b=GRo7Sp5FC9QzIz0pzN1BZvDgN3BH+VyKRdHykkzaRQT3MuyttLaJFvecnBCyY1s4Xr
 jS5VAjHzEKUQ6uj+Tke8lMD5scO8bvXqCCKyHlQR+SqFOZ44qy0OWEToKqn3+nGHc5aq
 TQtGks2Eq3gtov+pmPKeipPAQixh9Pz6AkeyPoG1lyxdLSTMzOGPb9Njq6sbzCVQ2rC5
 lawoDO5c421BoLJixWaQjpkPfJBm+7nKAwOZBpoUcCN7aCfEtPquWruGhRiGnhJ2ceXo
 pWp1QAUgPHuE1gKMUojcgYzIwiag9TObACvjVwpLOQUg3oVA2kWv3FfREo2ms2UT9xYz
 /4FQ==
X-Gm-Message-State: AOJu0Yxp0hH3+rsXX7i4GdBOlusbWdF06qcov6xPLEpe3cvMiWSM2oEx
 c88nbOQ+HR2leiRkuU1/limcixbMfPHqKeQf2B8sucj/xrEUbE+YtgkMX2E/GqZ7SMOhW18DgGd
 kDiQEOB/smD6ZNhJ6OEtE7A5BQXVD3+E=
X-Gm-Gg: AfdE7cnBKjuAFrfwBwrMQ0IeB5Fld8yfWEDewyFUK4+p6bhMzw+IGhvpB+wPosH7llL
 7OysTpDbYkaRrGFL7sR72l6s/Mjbmjubrd9N+DHD8Xz+7ubg6W8Nd3j9SxS6wyDIm0Bi4CHaQ0i
 39Ihq0Fvk4mvlhcj473Rlq+TZ9dVsHqbKidUY0CrRD6lILxAvfYpqppI3xLhd/F2wYJNMI1U9jC
 gBche2bGnAOsbFVadFO8IfFcHg9GXHusRZ9KcyGJ2lqOXtyP7In3GDiftXQ7Oloiq2PWzi7
X-Received: by 2002:a05:6402:3814:b0:698:81ab:c61a with SMTP id
 4fb4d7f45d1cf-69a1a2ae0e1mr3135125a12.23.1783328843130; Mon, 06 Jul 2026
 02:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-3-zhangckid@gmail.com>
 <87o6gx1yg4.fsf@pond.sub.org>
 <CAK3tnv+YGdTPOgGSwz-KO22E_-UaaABmEKwTqrsuE7no91pXEQ@mail.gmail.com>
 <877bnhvda2.fsf@pond.sub.org>
In-Reply-To: <877bnhvda2.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 6 Jul 2026 17:06:46 +0800
X-Gm-Features: AVVi8Cdb6Nzow7vWGMYOKtOJe0kRdl-ubSzH-AuxVL3aP0aDmB2YOWNqHIcaH3M
Message-ID: <CAK3tnvKT1=_3KKq-790h5hpTDMU=2S3F-U5h4+BWUL=V1nWprA@mail.gmail.com>
Subject: Re: [PATCH V9 02/17] iothread: introduce iothread_ref/unref to track
 attached devices
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52e.google.com
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

On Mon, Jun 29, 2026 at 6:42=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Fri, Jun 26, 2026 at 4:46=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Looks like you missed my review of v8.  I'm replaying my review
> >> comments.
> >
> > Oh, my fault, very sorry about that, focused on other patch's comments =
fixes.
>
> Happens :)
>
> > Thank you for your detailed explanation.
> >
> > I will address your comments in next version.
> > Expect the:
> >   IOThreadHolder *h =3D QAPI_CLONE(IOThreadHolder, holder);
> >
> > Same as your estimate, this doesn't seem worthwhile.
>
> Replacing hand-written code by QAPI_CLONE() is worth a try.
>
> I additionally described how to avoid the copy entirely instead, but
> advised against it.
>
> > And the same issue in the [ PATCH V8 14/15] comments:
> > static IOThreadHolderList *iothread_get_holders_list(IOThread *iothread=
)
> >
> >> If iothread->holders was a IOThreadHolderList instead of a GList, this
> >> loop could be QAPI_CLONE(IOThreadHolderList, iothread->holders) instea=
d.
> >
> > If we change the GList *holders to the IOThreadHolderList *holders,
> > This means that we have to reimplement the  GList related API,
> > for example the "g_list_prepend", "g_list_find_custom" and the
> > "g_list_delete_link"
> >
> > This doesn't seem worthwhile.
>
> The replacement for g_list_prepend() would be trivial:
>
>     h->next =3D iothread->holders;
>     iothread->holders =3D h;
>
> iothread_unref() would turn into simple loop to find and delete the
> matching list element.  iothread_get_holders_list()'s similarly simple
> loop around QAPI_CLONE() would turn into a single QAPI_CLONE().
> Basically the same amount of code, I think.
>
> Your solution already exists, which is a valid argument.
>
> Mine stays within QAPI instead of mixing GList and QAPI.  Also a valid
> argument.
>
> Use your judgement.  I'd try to avoid the mixing.

Make sense, I will change the GList code to QAPI code in the next version.

By the way, do you think it's OK to make this series based on Daniel's
V5 patches
for the monitor QOM part.
https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg06427.html

This allows us to delete some of the code and directly use the monitor as Q=
OM.
https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg07323.html

Thanks
Chen

>

