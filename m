Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF12ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXyGA-0006KS-OI; Fri, 12 Jun 2026 05:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1wXyG9-0006IJ-7d
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 05:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1wXyG7-0007q3-Hs
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 05:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781256781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ugUvZ8pmP5tA3+NjmnLX/ds4sniDzhyr85r315k2Pw=;
 b=iB4W2zSGiQou17NzXpBwALidsvQBhBt9Nypf/FVXZ3B7pt0QIJpMkVFfBhFectrr8D9sb3
 GB4I2iie5KNwwLMy6xfwzESQ+CRuf88/a7Y/VOzHdj2wHGsOnAgzouVNF0xgrMHfTzT5DC
 WzSlk8C5ml1Axak8quZ2/RYXEVRqg6o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-yXjt1Sp-MLuJtr2UkvNQgQ-1; Fri, 12 Jun 2026 05:31:13 -0400
X-MC-Unique: yXjt1Sp-MLuJtr2UkvNQgQ-1
X-Mimecast-MFC-AGG-ID: yXjt1Sp-MLuJtr2UkvNQgQ_1781256672
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5177f07eb05so14892031cf.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 02:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781256672; cv=none;
 d=google.com; s=arc-20240605;
 b=Nh/ur3DAn+L3jZj4D9epeNuIIT3bSzANJKYKWpeNbY8ARA72EA44pAhTb2ZyRsKX/T
 5/kaC3Gcq6CcAzsnIf1QhkSnaTvHGbrH3WHwkic/TQq2vo47jG+lkq4RDfHWsIArvIU8
 juk2W9Dl06hVxdBHrMfGxY5xygqvvo9CDx85vCrUEa+DCd1Y9XruyZbYrCqu7ymYTrJz
 c2Qf7H9W4TIf8stxXJ+26CeYhLNJ3ms8P33oUBxXNwrKEKPe8ymd1+Qe9KLBc0cq9g2Y
 ehWNYhG7hHN8mx6sTX+tYFs+qcM20KG0yUL/jPiSwg3tvwy5VlrU7ZsD+e9+TWS3I0FQ
 CQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:references:in-reply-to:from:dkim-signature;
 bh=4ugUvZ8pmP5tA3+NjmnLX/ds4sniDzhyr85r315k2Pw=;
 fh=F2byhdnG07VYbHu6vGcL1csWBk7lDxGuko6VKTg5tKY=;
 b=D6OVX5BSu5Xeg/oJhDz0/FED5dQchFE6sPLDYzRKkroGZ42Cu7fSwNMpZPNIXXwmzw
 BirUQTPNinPwZIVZwFFOVfTuyQErzMMxJ4NYMSJKuRr264lH9XSTnFk8kFFg/X5si7H3
 mJoTashcEwqcF3wcFQHNoxiLZrwxbOmBouwjprapM5OPAxRnqnXxYUcchLubt/p8AdZT
 C7JdDjc/bBDFxkRQ3a1GKDQlFl3BBZdt21JK1QAMb0Yy8sbZVFaEMrd+iKAFgl1MJTEr
 FVyTc4SgmwPvHHWaaVvcV9eJZtgyRNQ5IalAqKrlLOtY1jKIYIBjlcHBya57GBIDEXdD
 kpiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781256672; x=1781861472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:references:in-reply-to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ugUvZ8pmP5tA3+NjmnLX/ds4sniDzhyr85r315k2Pw=;
 b=BBNKuIDFErphtkj/+2LRjxxdsc41knQOKh/PppYtdj6nw271F7H60X6nqxYYBkPEud
 jZYcE54JZ78rGLA/AoaDHCe0cLNLKtPpolzTYzpW3sByWTtG1r+ot85HXOw2lI7MJqHp
 009xetATcSaDL5hd9K6I6K0vJ+7R8I83V1mGyrV/+XaayUfRMipwazSB1HURE9UTj1Yg
 CqJDmVicjpy1kl59Im5tkWO5+vARTVcz82zZz8/pRN9FaqhfQMwZIdhZE6prmoIx+JTH
 uJ45c+IxefT6Ao8QRC9/4/g+wUsY9YDpHXy2u+r1WWo9MEeRdUbkqOVMsT0yTe7ygfwA
 lfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781256672; x=1781861472;
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ugUvZ8pmP5tA3+NjmnLX/ds4sniDzhyr85r315k2Pw=;
 b=qmNPOaPLFks5v2PdsCtGSae5Wx+bYRvGFk9k4IadVsX204oO2rbS+0Dk5fad2PP8Yd
 AAnuQeqKlZwI/7I2WSHZ/H8+n7Xa5OuQGbzcBG1vQ0CEzC/c/+GBWC8XoqAfodQxaUZd
 WijbxHQaCzlCnY2A6eGW/Numb5MePdFs4oR0ClLFh3MxOikjTjK9lYMQfxw3wKbIj2oK
 pYGlEfFpV3NYK7fimcjzRDSdNs8xdGik1NYQgo98sPoybNeXo5x7FKcGDEgno52F8iiC
 MbNjqA1mux+xA23N2Zs835RY0lphDaWEWjLQFJiQoifJ12QcadTGPEeJLHsIk6aZ3m29
 7Lzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+a5jHJqAUJeTFEru8509uAaCpmHtLsIDfgX6PIF4a0wtMNuPbhHRDJpb11kh1GlKPS5SzkuN+ZlnX8@nongnu.org
X-Gm-Message-State: AOJu0YwoontLqcU31tjbz5MK2M4q9NfPLWaVUcYcL2xKNeDq/YI4vYt8
 wslwrU8l+LSkUVpvhCusFN9PxRNmlvQkCGYqNbVk+cM7nSyDY9Izi45p7yrMCNHoBJFA3rb6Wdy
 GwE5t36Pt8tE0SmERquNkksOZnsxofHm8dWEUDSSGV1eYwb2nyK1qPhTtJiWkVA37CpK7QN4aQN
 kUSDnnuJFUV9PdGCKrBzn0YJ/YyIOCoWU=
X-Gm-Gg: Acq92OHUp/wfEtQtNUsxFoTNGhF9yYbFyc/kWnvbf836ej9hF1gF17mZXpTaBHsPRA1
 vdK26v76sM7VPKUBNT5SrRs/WLh4Sk0BPkOzuau8+VYDmfgFSiA0RIBR+9VLZWcixdV6O9z0/hr
 P00IUEe8WEmgl8BTIyfrkhZxUwdjrEEWuymSprgyHQbIQEkVr7b31+seonwVneOWhGCg7VGOzzv
 RRV
X-Received: by 2002:a05:622a:8c19:b0:516:e136:5fcf with SMTP id
 d75a77b69052e-517fe2449a4mr26475761cf.14.1781256672374; 
 Fri, 12 Jun 2026 02:31:12 -0700 (PDT)
X-Received: by 2002:a05:622a:8c19:b0:516:e136:5fcf with SMTP id
 d75a77b69052e-517fe2449a4mr26475201cf.14.1781256671917; Fri, 12 Jun 2026
 02:31:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 05:31:11 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 05:31:11 -0400
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20260611203915.GB237427@fedora>
References: <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
 <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
 <CAFEAcA9ZkbNK5kRL5+OiqgN2hk3JAmFN8Qd3cytqyTEm9hBkvg@mail.gmail.com>
 <aikiB90tij642pEZ@redhat.com> <20260611203915.GB237427@fedora>
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 05:31:11 -0400
X-Gm-Features: AVVi8CcKM1kpWzrfDXUOp8c4BzZOhBeMjK7lIC_DI4Oy3zorwd53Uql1rJXjLDM
Message-ID: <CAAiTLFW0oMWWhKnkvtRHPqT-7eUX3vxbyDxeRJiad-sURYj==w@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, 
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Demi Marie Obenour <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, 
 Mark Burton <MBURTON@qti.qualcomm.com>, Matti Moell <matti@qti.qualcomm.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Vishwanath Seshagiri <vishs@meta.com>, 
 Rob Bradford <rbradford@meta.com>, Zhengyu Zhao <zhaozhengyu@bytedance.com>, 
 "Jorge E. Moreira" <jemoreira@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=slopezpa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

$Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Wed, Jun 10, 2026 at 09:37:10AM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Jun 09, 2026 at 08:51:15PM +0100, Peter Maydell wrote:
>> > On Tue, 9 Jun 2026 at 20:45, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
>> > >
>> > > On Tue, Jun 9, 2026 at 2:51=E2=80=AFPM Peter Maydell <peter.maydell@=
linaro.org> wrote:
>> > > >
>> > > > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>> > > > > I'm not sure if anyone brought up this topic on qemu-devel and w=
ith
>> > > > > Michael before. As I mentioned in my reply, there are ways to av=
oid
>> > > > > blocking vhost-user spec changes when qemu.git is frozen:
>> > > > >
>> > > > > The simplest approach is to keep merging vhost-user.rst changes =
during
>> > > > > freeze since it does not jeopardize the release or introduce
>> > > > > instability.
>>
>> snip
>>
>> > I tend to view the specs subsection of the docs as being
>> > for things where either QEMU really is the authoritative
>> > source (eg fw_cfg), or where the spec is for something that's
>> > basically moribund and has no better home. If vhost-user is
>> > a cross-project specification that it so active that it
>> > cannot live within QEMU's release process, then I think
>> > it deserves to have its own independent home.
>>
>> Yes, the main impression I get having read through this whole thread
>> is that vhost-user spec should have its own home outside QEMU.
>>
>> We can come up with all sorts of rationalizations for how to make
>> things work in the context of QEMU, but they all just come across
>> as excuses to avoid changing the fairly arbitrary historical use
>> of qemu.git. Even if as QEMU maintainers we consider that we're a
>> "neutral" home, I can understand why it might not be perceived that
>> way from the outside.
>>
>> If people want agility such that we need to make exceptions for
>> our rules during freeze that is one flag that it doesn't belong
>> with the main qemu.git, but there are broader points that are
>> pushing my view in that direction too.
>>
>>
>> Not mentioned is that engaging with the QEMU mailing list as a
>> non-regular QEMU contributor is not a very attractive task.
>> While QEMU may be satisfied with email, QEMU are in a tiny
>> minority these days. The rest of the OSS community has
>> decided that git forges are the better way to collaborate.
>>
>> Our dev list is very high volume, with changes very easily (and
>> often) lost in the noise, even from regular contributors, such
>> that we have to teach people to (repeatedly) "ping" to attract
>> attention.
>
> A separate repo in a git forge definitely has the advantage of making
> communication easier to follow for anyone interested only in the
> vhost-user protocol.
>
>> If we want agility though, IMHO it is best to stay away from the
>> bureucracy of the OASIS virtio spec / committee, which is a big
>> turn off IME.
>
> Yes, OASIS adds overhead.
>
> The downside is that vhost-user suffers from being outside the VIRTIO
> spec umbrella. It's really a VIRTIO Transport and would benefit from the
> discipline of actually being part of the spec as such. At the moment
> vhost-user is not really bound to VIRTIO through any interface (i.e.
> VIRTIO Transport) or device lifecycle that is guaranteed to align with
> the VIRTIO spec. This has led to both design problems and bugs that
> would be prevented by making it a VIRTIO Transport.
>
> In addition to the OASIS overhead you mentioned, the other issue is that
> moving vhost-user into the VIRTIO spec would require reconciling the
> the vhost-user protocol with the VIRITO Transport's interface and also
> rewriting parts of the vhost-user spec that are not up to the level
> (e.g. adding conformance clauses, eliminating some informal language,
> etc).
>
> In other words, it's a bunch of work. Although from a purist perspective
> I think it's the right place for vhost-user, I think it would be an
> unpopular solution.

While I agree getting it into OASIS it's a lot of work and not something
particularly enticing, I also feel obligated to point that, in my
experience, vhost-user is not seen as an standard to be follow to the
same degree VIRTIO is across the industry.

If there's a lightweight mechanism for getting it included (as Michael
hinted there could be), getting vhost-user into VIRTIO could be useful
to strengthen and solidify it as an industry-wide specification.

Thanks,
Sergio.


