Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DCCCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwdu-0002Ga-0s; Fri, 12 Jun 2026 03:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wXwds-0002GB-8T
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wXwdo-0001SO-Gs
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781250563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/CQVyzkU0UAPREehS/SE9ug4vHgXSzleoaRx+VNsGk=;
 b=hQhROVebXZSx7blZZQB2ZpQhj6aotG3RRLx0AZnsCim7RlpJ9m3JtKCD1oFujleYjhQAEs
 Wg0servCFHf6nRJ4HbCGm6e++JiStU6pSFbVbTdDLJcJ3+rT9oySAYqbnfCDF4tdOPI29L
 RMHPUaLhw8eJqrCn9Y2nPy7cemFZUzE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-X-MuReURNLqkltx3FjwV_A-1; Fri, 12 Jun 2026 03:49:21 -0400
X-MC-Unique: X-MuReURNLqkltx3FjwV_A-1
X-Mimecast-MFC-AGG-ID: X-MuReURNLqkltx3FjwV_A_1781250561
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45efb6e60e4so600875f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781250560; x=1781855360; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8/CQVyzkU0UAPREehS/SE9ug4vHgXSzleoaRx+VNsGk=;
 b=s6nzW9gRRazv0Rz86ylbg36oQD3mzriBhpqPG1941LHlEF1AhyM9rObGkj9xfHPtJu
 NM7JxfKhzdI71+kL1+cATcKaNbkIJxOW5RhMC88s6EYb5xtzOFXeSM+ie4CcFnbl//RJ
 6cGzw1oqCyZJeujFuZ9jj1/Sk9oMUYwr6qd6CxgW+mvtCItGTbYPAYK2nD5ow4xgOnJn
 ovcsVrjf3rEyNowBTTy6QyJAcOGPn61tNfPZ2zjr/1DfWhP0pXI/n93m1CCwjEtgy4Qj
 3r/LSFvn2FCXM7ZslPfQGyYgp1zMhkXZMwbs417umrcosJlewKjbmrSV1h8R6/cd4hZL
 i1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781250560; x=1781855360;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8/CQVyzkU0UAPREehS/SE9ug4vHgXSzleoaRx+VNsGk=;
 b=ohKcKHDE0OUHkIbk3FUZvH0IJXx1cDgHoGwNvXLiFottnasY1J85o7BoCR09Jc0o93
 8BzpxEMJJe7Ct89YORWmJxlcgkfxe9bOA+7TGuYNmz4Wv1HBB1l11LJCYyON4Jjjf5oH
 KFb+2ujlY/WZ7Cu6OjV1Skrzcp0+yRZxZQGXffdLO2RyZr19/ZvJPaUWa28jzTyQIvH3
 yimG2WVXCFIIknXHhjHdsL+F3Abkq/QriSnAzBqZIzEYwlTNmm4g+wDxxl6JPnm6R/rO
 8QtP6nRlaOxB96jt+/chWYSGFrMFXvTQXwT99bwH73Vk6ukepZKcEkpdDjUGZmTkQEK6
 kGYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Av1SVQuW/u+wSFIy940lzx12VzZ/Dc0nEmkiNZZvVZJTCh96hqOhKVWDDVotOwnRNG1EFcZWfYKmG@nongnu.org
X-Gm-Message-State: AOJu0Yy8UlA/WYVkkyjW3rsSCrdhklRyPqQHqLiAOTqbP6yZtW1B5HTh
 LtzvtdLaEkuYrOwrvN4AFSK7qTlmcLAsEHyCAsXgNN7mPpzgxQwTCzDos/qRGCc4Yrx0wftBlga
 eIVbwvBpTdNntH3bYNIGRkUKczDAApdB1YloVrfPs1UHNTOTIofVYQrV6
X-Gm-Gg: Acq92OFUW6QxplDLde+iFqi7glzkwCZlsuiz0EIXXYtWwZU8TDlh1aBlsKE0izR/B+4
 TxUQpTPf535MBsUgr6zSivG3QGT6lezANLx66o1M2odjdvvyHyRD6DPkIW42LEFnIx58eru5/Qg
 vdLOTrkYN0+35UX9cyJJn5rD1l1dYgifLHSF1+0j9P6HiR09OZJgK/wE9Xpt+BsdIxJRuPMgExN
 vh1FURkZo/fVnHUP6kjzIgjgcGlZmzdtLYDXbmjx7di9dYF2bt4Uxf0k3TXr+T+G0J/t+Rpnnz6
 DdFvc+OaBBw91Kl0zCzpt34YTfu3ZhEWo7LxXz/ARO61lxUC2lOnzxFYtwNvPVszsykrmrOnmYp
 viXWIsC989zsOObFswv5c5TGukXWHhyiwUl0iuNd7FkIQgKgjxQA/x/wS+gDvLBcf+r0aMpE=
X-Received: by 2002:a5d:5d0e:0:b0:460:3210:434a with SMTP id
 ffacd0b85a97d-4606dbc6b71mr2436937f8f.43.1781250560475; 
 Fri, 12 Jun 2026 00:49:20 -0700 (PDT)
X-Received: by 2002:a5d:5d0e:0:b0:460:3210:434a with SMTP id
 ffacd0b85a97d-4606dbc6b71mr2436839f8f.43.1781250559362; 
 Fri, 12 Jun 2026 00:49:19 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26393asm3159156f8f.5.2026.06.12.00.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 00:49:18 -0700 (PDT)
Date: Fri, 12 Jun 2026 09:49:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@gmail.com>, Dorinda Bassey <dbassey@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Demi Marie Obenour <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, 
 Mark Burton <MBURTON@qti.qualcomm.com>, Matti Moell <matti@qti.qualcomm.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sergio Lopez <slp@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>, 
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <aiu26_Ha5NvyZUI0@sgarzare-redhat>
References: <20260601160352-mutt-send-email-mst@kernel.org>
 <CACzuRyxedVMHNGkRf7AVyPWUTMgBMa6_DBnSHn+V6H7wN7XzWw@mail.gmail.com>
 <20260604162853.GC115597@fedora>
 <CAJSP0QXR6MyqoE1Uh-X7DzsOabbbN69TUyxf8r6ghUDCQnrP=w@mail.gmail.com>
 <CAFEAcA_Kd5_k+XyagUbB2+YVEMB0Sb0AB=oUZu6bGDot9TaFrQ@mail.gmail.com>
 <CAJSP0QVuSvVwa1szAy_3WVtWOjGK=oYAXjqAzbg5YoEvgybRjA@mail.gmail.com>
 <CAFEAcA9ZkbNK5kRL5+OiqgN2hk3JAmFN8Qd3cytqyTEm9hBkvg@mail.gmail.com>
 <aikiB90tij642pEZ@redhat.com> <20260611203915.GB237427@fedora>
 <20260611164404-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611164404-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 04:45:10PM -0400, Michael S. Tsirkin wrote:
>On Thu, Jun 11, 2026 at 04:39:15PM -0400, Stefan Hajnoczi wrote:
>> On Wed, Jun 10, 2026 at 09:37:10AM +0100, Daniel P. Berrangé wrote:
>> > On Tue, Jun 09, 2026 at 08:51:15PM +0100, Peter Maydell wrote:
>> > > On Tue, 9 Jun 2026 at 20:45, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> > > >
>> > > > On Tue, Jun 9, 2026 at 2:51 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>> > > > >
>> > > > > On Tue, 9 Jun 2026 at 19:00, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> > > > > > I'm not sure if anyone brought up this topic on qemu-devel and with
>> > > > > > Michael before. As I mentioned in my reply, there are ways to avoid
>> > > > > > blocking vhost-user spec changes when qemu.git is frozen:
>> > > > > >
>> > > > > > The simplest approach is to keep merging vhost-user.rst changes during
>> > > > > > freeze since it does not jeopardize the release or introduce
>> > > > > > instability.
>> >
>> > snip
>> >
>> > > I tend to view the specs subsection of the docs as being
>> > > for things where either QEMU really is the authoritative
>> > > source (eg fw_cfg), or where the spec is for something that's
>> > > basically moribund and has no better home. If vhost-user is
>> > > a cross-project specification that it so active that it
>> > > cannot live within QEMU's release process, then I think
>> > > it deserves to have its own independent home.
>> >
>> > Yes, the main impression I get having read through this whole thread
>> > is that vhost-user spec should have its own home outside QEMU.
>> >
>> > We can come up with all sorts of rationalizations for how to make
>> > things work in the context of QEMU, but they all just come across
>> > as excuses to avoid changing the fairly arbitrary historical use
>> > of qemu.git. Even if as QEMU maintainers we consider that we're a
>> > "neutral" home, I can understand why it might not be perceived that
>> > way from the outside.
>> >
>> > If people want agility such that we need to make exceptions for
>> > our rules during freeze that is one flag that it doesn't belong
>> > with the main qemu.git, but there are broader points that are
>> > pushing my view in that direction too.
>> >
>> >
>> > Not mentioned is that engaging with the QEMU mailing list as a
>> > non-regular QEMU contributor is not a very attractive task.
>> > While QEMU may be satisfied with email, QEMU are in a tiny
>> > minority these days. The rest of the OSS community has
>> > decided that git forges are the better way to collaborate.
>> >
>> > Our dev list is very high volume, with changes very easily (and
>> > often) lost in the noise, even from regular contributors, such
>> > that we have to teach people to (repeatedly) "ping" to attract
>> > attention.
>>
>> A separate repo in a git forge definitely has the advantage of making
>> communication easier to follow for anyone interested only in the
>> vhost-user protocol.
>>
>> > If we want agility though, IMHO it is best to stay away from the
>> > bureucracy of the OASIS virtio spec / committee, which is a big
>> > turn off IME.
>>
>> Yes, OASIS adds overhead.
>>
>> The downside is that vhost-user suffers from being outside the VIRTIO
>> spec umbrella. It's really a VIRTIO Transport and would benefit from the
>> discipline of actually being part of the spec as such. At the moment
>> vhost-user is not really bound to VIRTIO through any interface (i.e.
>> VIRTIO Transport) or device lifecycle that is guaranteed to align with
>> the VIRTIO spec. This has led to both design problems and bugs that
>> would be prevented by making it a VIRTIO Transport.
>>
>> In addition to the OASIS overhead you mentioned, the other issue is 
>> that
>> moving vhost-user into the VIRTIO spec would require reconciling the
>> the vhost-user protocol with the VIRITO Transport's interface and also
>> rewriting parts of the vhost-user spec that are not up to the level
>> (e.g. adding conformance clauses, eliminating some informal language,
>> etc).
>
>And possibly getting an agreement to OASIS IPR from major past contributors.
>
>> In other words, it's a bunch of work. Although from a purist perspective
>> I think it's the right place for vhost-user, I think it would be an
>> unpopular solution.
>>

Yep, agree on this.

About the current workflow, Working on both QEMU and rust-vmm, I've seen 
people a bit scared by the QEMU review process when all they want is to 
propose a protocol change. As Daniel pointed out, our mailing list is 
high volume and unfamiliar to many. That's a real barrier both for 
contributors and perhaps also for those who would like to follow the 
development.

What about creating a new organization (e.g. "virtio") on gitlab or 
github, and hosting the vhost-user spec there in its own repo, using 
MRs/PRs for changes?

Under the same organization we could keep a read-only mirror of the 
OASIS virtio-spec repo. That wouldn't change virtio governance in any 
way, OASIS stays the authoritative source, but it gives a single place 
to find everything virtio-related.
As a side note, it could also serve as a starting point if the virtio 
community ever wanted to move the spec outside OASIS, but that's 
a completely separate discussion and not something I'm pushing for.

For the vhost-user spec itself, I think we should invite co-maintainers 
from other projects, and keep requiring a broadly complete 
implementation before merging non-trivial spec changes, but that's what 
we already tried to do for both vhost-user and virtio spce changes.

That said, honestly, this might lead to fragmentation (although the goal 
is to create a single hub for virtio), so perhaps the idea of having a 
repository in QEMU gitlab or rust-vmm github might be better.

I'm happy to help with the setup if we reach consensus.

Thanks,
Stefano


