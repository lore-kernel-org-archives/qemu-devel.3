Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AB8CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3mL-0002LH-OK; Mon, 01 Jun 2026 10:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU3mJ-0002Kr-Ud
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU3mI-00082a-6g
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780324684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgfJn6jgdDZ5kywXtUqLLHdwAjzX+oqe3dGLFNRDz44=;
 b=c1FRIdE8dec4hTSCAxEeCBwMsITFqso5ddGpyLGoQTZSnuz+sABlDVqAILXzAtcnF6+WrU
 3Av7vKPU96RIz+LekzZDfe9243aKaArYT5pq4lin/SvPAKEX+dLaKzAvdWGsx7IOGb6yF8
 MAObucV+asvxji9LZjmO9L0mmrRfgmQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-mHaGOPP_OyaSyHW8xMP2iA-1; Mon, 01 Jun 2026 10:38:03 -0400
X-MC-Unique: mHaGOPP_OyaSyHW8xMP2iA-1
X-Mimecast-MFC-AGG-ID: mHaGOPP_OyaSyHW8xMP2iA_1780324682
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a7aeaddbso11273495e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780324682; x=1780929482; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zgfJn6jgdDZ5kywXtUqLLHdwAjzX+oqe3dGLFNRDz44=;
 b=fCgxfv16PlCU20HkmDRdgV1Ndkhlu3Fqk0naXzah6jOrXVBGDXIZiVjYwP+dxicxfI
 u8V0gwWtvIwMw/g1uy3xvdoS7uzx1K/oLJDhf0X9/eGdFgpCqBDcYgFqzq8rqbVsWLR3
 Qric+HRhXClNJ1ZQohEkCwi09mi7kZ2ritnrfpOes8jF7xOupXugTjqQc9/RPjgDQr4f
 Mx007gE4ShaRgpNvHq0mzhSm+B+dCQ9tKzsa1TJsrTes7Sbg0k0QFp46n0KcI4HA5fyc
 nduoiozEFY4A26dJG19L8eu/RLw3sll7tQzxUebvAgLVVErib23674vyzEy1qUyrQAax
 Ku2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780324682; x=1780929482;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zgfJn6jgdDZ5kywXtUqLLHdwAjzX+oqe3dGLFNRDz44=;
 b=TyAess/hRPtz5wJNFyfMX+YquY2MUGa9/J8qrK2BK8QBoNFyIHME/1nEBx1X462Sc1
 LFxR16/4qfC3kjnwgtWY4wD4moZs+tesRpq8e7H15X6G/ZEAQTgptnTAoRfn+v0YHUOK
 swVlFk2GrTdUHwbDeDb8wkEp04Wd2nDGHRiB4mi47YsJau7yx2W1KE/cj2daILNIOU4c
 bf/kMve+A3j+7niGE7fEFb9l7McrP/KHtZMaWVLzuYfKdCxxm9PA4F69qvSmdDnakvbH
 b8M9g5kA9pu2KlxqrRShzH2qrQ4A0PXG2ucFBOwx3fUfW+evEz8B2l22rJFpeO2QG7KP
 H3Fw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9o4eHrp+DsSaUCGrUkXk3i2OxpaQ6UBa2bdcmHdOfJoooy08yXAtg0ZUr6o7xNTeJUilI7h6AVmINw@nongnu.org
X-Gm-Message-State: AOJu0YzEUdCB7rdTrKH4GALYlMjVCmHDaZYvaYkz0JzOxnJ+AZr1L/gr
 yt9s4iuZ5I/3WlMYBJGGcfusVJ1MgWD/dKWKXp2UOMH0T6XRU+lRtHjnk+P6uV656IimOIZP9v8
 gKLfF/iZ40RffAcgBrCBjLKnN4DU8mnvD7anExshzpVCorWmn+1Jk6ISh
X-Gm-Gg: Acq92OFRSHay7mF7QYLS4vsHFKjdLBpIPv9scPHSYnmU44frhxuvui63cqD66EdAbhI
 U/vim9nG23hl0Kam5mRKk6r9yhD9GMaohY2OPfwr4b2zZdUxGbjiNcEfbqXOw1joMMhUEMnW1lR
 DTZ+qRVd9c4Io+hT5204STG+0Lu3nY+8In2l808hXW6I1+8SFizfEhRnVmQwiBFidBlDb+2oreW
 i0wSmeNpUpwBHmJrPS1gT6+pkPJg/IkM6+LzPexXrjIzlOP3b3U4kZgcUCMYXZWlkvJOLeKybRQ
 z+NWvfBk6LdX+bu2qahIcv3UwQvmNOJUd6zmwoDVTyOWZuGwx+OZJWj5H1vXo1gDQlULvpLkqs+
 4afIktX0rlQwkB/xm5agrijDwJyY5ZFCM8pe7JRtLhsct8XR3m6lspQ==
X-Received: by 2002:a05:600c:314e:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-490a2a78973mr166523595e9.15.1780324681758; 
 Mon, 01 Jun 2026 07:38:01 -0700 (PDT)
X-Received: by 2002:a05:600c:314e:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-490a2a78973mr166523055e9.15.1780324681159; 
 Mon, 01 Jun 2026 07:38:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0467957sm5583625e9.13.2026.06.01.07.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 07:38:00 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:37:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260601103715-mutt-send-email-mst@kernel.org>
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Jun 01, 2026 at 04:27:46PM +0200, Albert Esteve wrote:
> On Mon, Jun 1, 2026 at 3:51 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Mon, Jun 1, 2026 at 9:12 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Jun 01, 2026 at 03:05:50PM +0200, Albert Esteve wrote:
> > > > On Mon, Jun 1, 2026 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote:
> > > > > >  But also because, in my opinion, separating
> > > > > > the specification would improve development agility by decoupling
> > > > > > specification development from QEMU's review and release cycles.
> > > > >
> > > > > Generally for QEMU this will be less agility, unless I misunderstand
> > > > > what is proposed)
> > > > >
> > > > > Because presumably there will need to be spec releases then?
> > > > >
> > > > > So
> > > > >         new feature -> spec tree -> spec release -> qemu implementation -> qemu release
> > > > >
> > > > > is surely longer that what we have now.
> > > >
> > > > I see your point.
> > > >
> > > > However, we do not really need to introduce a heavy release management
> > > > layer. We could just operate it as a living document, where the main
> > > > branch is the authoritative source of truth.
> > > >
> > > > For the workflow, development doesn't have to be strictly sequential
> > > > either. A contributor can propose the spec update while working on the
> > > > implementation, much like we do for VirtIO updates. Actually, this way
> > > > one update/change supports the other.
> > > >
> > > > I guess my point is that a dedicated repository could lower the
> > > > barrier for new changes AND keep QEMU's own development speed mostly
> > > > unaffected.
> > > >
> > > > BR,
> > > > Albert
> > >
> > > Something something submodule? Possibly. If you want to make progress
> > > on this, pls think of the process, try it out.
> >
> > If I understand correctly, the motivation for moving the spec
> > somewhere else is to replace the email patch review process with a git
> > forge review process?
> >
> > This seems like a superficial change and is not worth in my opinion if
> > you consider we'll have to redirect from the old spec location and
> > move the community over to the new repo.
> 
> The core issue from my perspective is project neutrality and
> decoupling lifecycles.


Then maybe we can keep the email based review? Still the only
one with a decent offline capability.


> Currently, protocol updates are tied to QEMU's tree rules and release
> freezes for example. Since these changes also affect other projects
> (like rust-vmm, crosvm, DPDK, etc.), separating them may make sense
> and could streamline the process.
> 
> >We could actually lose spec
> > change reviewers in the process either because they don't know what's
> > going on or decide that they prefer to spend time elsewhere when faced
> > with switching processes (the people who review and participate in
> > discussion do so out of personal interest and as far as I'm aware no
> > one is employed to work on vhost-user as their #1 priority).
> 
> This is a fair concern. I hope we maintain reviewer engagement. But it
> could also be argued that contributors from other communities may be
> more comfortable with a dedicated project-neutral home. It could well
> go both ways, but it also represents an opportunity to grow.
> 
> >
> > Having said that, here is what I imagine it would involve:
> >
> > 1. Michael creates a new repo on a git forge (if he wants it to be
> > under the GitLab qemu-project organization I can help with creating
> > the repo, otherwise he creates a new organization and repo).
> > 2. Discussion happens in Issues.
> > 3. Spec changes are proposed in Merge Requests. Michael merges them
> > once consensus has been reached.
> 
> Mostly yes, though we wouldn't necessarily need Michael as the sole
> gatekeeper. We could invite co-maintainers from other key projects to
> share the reviewer load.
> 
> Also I'd want to clarify that although I am advocating for this
> change, I do not claim to have the definitive roadmap. I am just
> sharing my view on why this could be a positive evolution. Consensus
> may end up being to remain with the current status quo, or any of the
> other options proposed by Alex.

> >
> > It's similar to what we have now in qemu.git, except that a git forge is used.
> >
> > Stefan
> >


