Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87057C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrYk-0004TO-Vy; Tue, 25 Aug 2026 09:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wyrYi-0004St-Pl
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 09:51:24 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wyrYg-00043z-Kc
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 09:51:24 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so551520866b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 06:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665880; cv=none;
 d=google.com; s=arc-20260327;
 b=X0BbebVbPAv9WA2l4g94GmQXvBYTOJrsvIUZbwr8tY7MImspcC3szmieAfERF0/5U2
 2Yz2rfPv4l4f+3XvmslZqL/41GX6H/7wZo4NBpzls3aJ7Uz9UCMjx05Feb8Yeg1EnJVX
 viy3r6TTuRtKP+eevUpPkeUfnMflEMOcmLwKGYeSoGGSNyAwDaSK8Dx0IL0SXjrTtlHb
 qOAorlYDZJsjxa0qA87fHKZVu3AOkHZWjoobMg/fiD7muIT2hOPol/OpNnIlTsFSgWHL
 DDZnuQhH4anf/tndrLbK9dubjQkOtTuH2TbkCy9Id3dmKww9n2S99U+QSaD6i4Axo1lN
 TViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8ZZcvA4m8VqBesYlWZnx+XK6nlh+DgyUi/+upvEXi10=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=Ah3AmMMk3ajBPnYKcpyMvlZjCnqaWaIoWD+RKdeORUY1pvELgA4iegopO8ghnKUpXJ
 Ev3HJLRxhQw9pYVu3iTiE/VP7+sLLiHoPlunmpVaeluDiGQVYqbW6joifj5fKO58zsUF
 rJOztinxX+1AOmr/ovJkjJa/LyK3pKMmouQ1V1UzYvR5GMabzbBlGtzAGYncdw3cbpp5
 ATrCP1USO6A0Jwh18Crq6tlao/lAeOoKEXJdmyo5cygO5CJ1efHhcoOkEDQ04k7QeTco
 YUV8VqzS6S4lP7/TKjaUlj011/C64XTyPnNWSkPPtG2WU0/GRyAxF2ybte+t5DlqxdzU
 fsPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787665880; x=1788270680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ZZcvA4m8VqBesYlWZnx+XK6nlh+DgyUi/+upvEXi10=;
 b=a8U5zpH6atohA2JoCT/Juqcm94g5689VxfFZ2isNd4jPuWwmHO7dsTMJAVkZcVzrjp
 inFWfOUwJGU7CDueUXtwLqLvVCBEW99Nh55/BDsCH5Ah2eOIv7GxLfuTf+j2vhQ4b5sW
 SRkFTEL+ycBfi46pHvLrof3GtYpSNSzkvFzp0nqL5gOMvv7kTm6ttpQVPOoxs7rB5765
 dE+QMVn4804XSv2COtN322V1iqWHo/WxZ3Pd5Xjs26aj8WDwXV5qvVeMIFESaOxT2VzO
 QLsF4gRcAyZ9qGuHxLOCfhqXPblNWoj8Yn6cNd+hBaamFwmv/z/jAjUHD5nnWmIKRKML
 Bwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787665880; x=1788270680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ZZcvA4m8VqBesYlWZnx+XK6nlh+DgyUi/+upvEXi10=;
 b=hZs94AWXxla7fUJdWbd4adynt8UUqFKjFKpsMXtX7NFI9CzfjKnepYjTJ5YpbPxBGq
 b9RX5XHfCR2HRo/UBPTSKNTmAj2EQfe9AcCKS2sIThWryJQdy2nmmUst7DViue+Csxym
 XihOmp8sl9vGb4TgbxHW1vsGLTK3Sj4ObVKhMzhBwVg7hV1ufoVTCYPzemf2IQni7lH4
 svu0UICCjfIh5SRiBoXWt+uubFJnhkp5htVS92oMeVaTWUcNd505MQYfcPn+/pzIUki4
 nAzlWZgMfANXtlO7Gih9XUUofyJ942EQKMIV7aMJm+s1NX2DyAJ4UHlpVJWHLYpk6oCc
 ZIow==
X-Gm-Message-State: AFuF++mbWyXeffP93cRgIoyZjO5Oc06XxAsBxqH9Dbtt8Vt0dI1t/opy
 ogGzh0MHmtzcXjIXC1xHI4NXQBo+KItNCl/BJbXNBNjfp5cNkeQJsP2VYaA5OjsLZkieYbJSAL8
 xD0pM2pKP+nze7v5nwGyvlmtZOp+b2q4=
X-Gm-Gg: AR+sD10nWaEYmjS5ZJ9OD0YMzPj8gal6T2804CSxE1K6f6K4yzxtZ8pXBjnDin+yEkU
 ou/IPWM0f3/BqxQbBz8OCeoJ0seHQ6WtZ8YgdbuT85QjCpo6/AgwzTWnGywpgjFK7oP6JgduOBg
 DYxmWHqOSn0EOPD86RE/125my5kTjPAhplbx6GYcfvsEVsVQ5jVXfXmhQNz68qkgfatd90Wqq2A
 961Y5hsI8/5CjkJ5q86/WJFl4ile+cjcZGnvtd6FTJoTLnkdPtzArm7tKFyTrqv50IkjoAawJE3
 wq1FKX3Nl7NhyctZZQRVxfGt93ODhcIaas675dVPsavc
X-Received: by 2002:a17:907:1c07:b0:c15:f26a:3438 with SMTP id
 a640c23a62f3a-c24e5c1ffd3mr745203466b.24.1787665880065; Tue, 25 Aug 2026
 06:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260822213343.661939-1-zhangckid@gmail.com>
 <20260822213343.661939-3-zhangckid@gmail.com>
 <874igipqbu.fsf@pond.sub.org>
In-Reply-To: <874igipqbu.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 25 Aug 2026 21:50:43 +0800
X-Gm-Features: AcwNN1XcYyF9tMQqZ7rOOcPK_R_OupvbJmLPeBGV7RRkUYee7-CY3uhZCpHRh_g
Message-ID: <CAK3tnv+YRY3F5kfWC_4qh5WY9TGxP7wPCPN6fbEq1_yoWsfpCw@mail.gmail.com>
Subject: Re: [PATCH V13 02/15] iothread: introduce holder tracking
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x632.google.com
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

On Tue, Aug 25, 2026 at 4:17=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > IOThreads do not record the QOM objects and block exports that use
> > them, making runtime introspection and hotplug debugging difficult.
> >
> > Add:
> >
> > - holders: a list describing what is holding an iothread
> > - iothread_ref(): add a holder to the list
> > - iothread_unref(): remove a holder from the list
> >
> > A holder can identify either a QOM object or a block export. A later
> > patch will expose this information through query-iothreads.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> I'm suspending my R-by, see below why.
>
> [...]
>
> > diff --git a/iothread.c b/iothread.c
> > index 3558535b40..66dfde626e 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -21,10 +21,71 @@
> >  #include "system/iothread.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-commands-misc.h"
> > +#include "qapi/clone-visitor.h"
> > +#include "qapi/qapi-visit-misc.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/rcu.h"
> >  #include "qemu/main-loop.h"
> >
> > +/* Add a deep copy of @holder to @iothread's list of holders. */
> > +void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
> > +{
> > +    assert(holder);
> > +
> > +    QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, ho=
lder));
> > +}
> > +
> > +static int iothread_holder_compare(const IOThreadHolder *holder_a,
> > +                                   const IOThreadHolder *holder_b)
> > +{
> > +    const char *name_a, *name_b;
> > +
> > +    if (holder_a->type !=3D holder_b->type) {
> > +        return holder_a->type - holder_b->type;
>
> Why did you swap the operands in v13?  Not mentioned in the cover
> letter's change log.  I requested the other order in review of v8[*] and
> v9, and you complied in v10.  Unless you have a compelling reason, swap
> them right back, please.
>
> In general, rocking the boat like this when you're at v13 is
> inadvisable.  It risks delaying the series even more and annoying
> reviewers.

Please allow me to explain the details, I have always respected the
opinions of the community.
Yes, I remember your comments in V9 and I fixed it. This change wasn't
something I made secretly or accidentally.
However, Stefan gave the opposite opinion in the V12, and I see you
didn't object,
so it was changed according to his suggestion. This might be a misunderstan=
ding.

https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg05089.html

I look forward to your reply so we can discuss this issue clearly.

Thanks
Chen


>
> > +    }
> > +
> > +    switch (holder_a->type) {
> > +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> > +        name_a =3D holder_a->u.qom_object.qom_path;
> > +        name_b =3D holder_b->u.qom_object.qom_path;
> > +        break;
> > +    case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> > +        name_a =3D holder_a->u.block_export.export_id;
> > +        name_b =3D holder_b->u.block_export.export_id;
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +
> > +    return strcmp(name_a, name_b);
> > +}
>
> [...]
>
> [*] Here's my review of v8:
>
>     Date: Tue, 02 Jun 2026 13:29:19 +0200
>     Message-ID: <87tsrl2nao.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/87tsrl2nao.fsf@pond.sub.org
>

