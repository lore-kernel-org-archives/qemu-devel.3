Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844E8CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 20:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU8ss-0002ty-Mi; Mon, 01 Jun 2026 16:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU8sm-0002sD-QY
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 16:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wU8sk-0005MJ-Kf
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 16:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780344304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plaHHP/owetcd3quHl6OhFcQ/AAirdRtHSTz6XMkIes=;
 b=OuUb3hvcVjYa0eYLnxmi+eLwQl3Fv3i+LgPHrByKr/zhD13a5Pgax6sT9sptk9H/fo1DVC
 ZRV9xmAtMDcYnz2oyswZw7amfJo7HSem+k96R94JfEM1rRo0JCeqo1biMtzlXUCjGyY2Uy
 VpJoouHdqfSJAc0oKUqn4s6ZuT9Dye0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-FqUeqpd6PoGZy_Y0mdeYQg-1; Mon, 01 Jun 2026 16:05:02 -0400
X-MC-Unique: FqUeqpd6PoGZy_Y0mdeYQg-1
X-Mimecast-MFC-AGG-ID: FqUeqpd6PoGZy_Y0mdeYQg_1780344302
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a7aeaddbso13309205e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780344301; x=1780949101; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=plaHHP/owetcd3quHl6OhFcQ/AAirdRtHSTz6XMkIes=;
 b=FvatrkCVapD2xS8aNQlC9M3nB5eSjK0TEOPr5UYPYeJtlFI/FyvqOzh9fAyqskReFp
 Zi1HDPojuoigNo3eCY8aD7g/2hd48vt/l3w2emsYiKdUgjVhLARQmjHhDVhkk5EZwSL/
 ZL4jIhoXDEeb1WBWex0mRxiQrXxTnPfi3n3y+Abfdbsx1MMfgVizanNtjlWSGVxfHDoR
 dFE3MaZo+W0lEy8bUi3qV+nNGc+IhYYLOd/OW8T8tGhAvTvsluM350APhqRX2WWcteVC
 7rrNua3h2T21yEI0VbdfHHDD2NX4wsompxANBj+PsltmYtYI5ZuhoRpdnzEbaMSuONnu
 9tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780344301; x=1780949101;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=plaHHP/owetcd3quHl6OhFcQ/AAirdRtHSTz6XMkIes=;
 b=XklEknd0p8hWJiGbXKzj3pI59FVbKKWeFCYwS7LA0vn8UaRdNyeZBnwTVdPWQnQb4w
 vQUlUDaWAkxRAEgE6CIhMbakLGRKP1Sk7dlEOZZkhA3uCoA41D5YxhcVct8tZXayvESY
 fYlXdkP3t5MQwtwpB/qXAxzZ6tGVMLAwA2nE7p20FfYt5CK2o1Yr+6ubvWBt+ExxHv43
 61mqoII7pTqHkZP22+kLrj3Thkkud/zjxOzL5td/7ApVSBlff5QJfszMb23Ci2widqlf
 0ogPYgJyo/RPDSrJnJkxztH0RsR+00QbPDQqqBvBiGJ+dpNQpZrf/h/t06iMxEv0yYT3
 w8+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Pj/ypS/HUdd+oCDIZ571OdcDztx3IZbQte0plWzUFLiNo0i5NI5P6oPIsFChfvfOUeFoR2pjjCFyd@nongnu.org
X-Gm-Message-State: AOJu0YxYQR4+AkPK88XplKB2ncY1fm18qqK6dnskep6IlZoWZSmDh4Uw
 5+124Ri3jr5ZQZ6bvjKVWJ2uD0OZinFHsguyW9lLt6dGQL/fBzhSW3pWBYeytNcbW3AUFK3tsAw
 9ISgYuGhofdQXZLS9OVg5BYj7feM2Nqpz1aY/vGx3837p1VsbuptbEehX
X-Gm-Gg: Acq92OHY45CcrQLgNBGnk5fVJWU/zhxjLkEYkquLP0DXE0Uv8dSb9Kto49gVVhCUsvs
 UY0zHfdb5gnjTS3N004+/6WFupp4KRw0rkLmyVeB40TrCwbEBn0RfpEf8tkpOnfj10XEK6OnfNl
 MiGID9KvV0pukSeqkBD7GVSu1XBVHR3yLraFsp9jMKVimrR/BXbMS7u3+vWC+nEsBef62s6sAgN
 kmgdU2k2ffZufrilsrHUyBnySyAAx3ZrJ3VXsXqeZIE7ipkYhcJzctJ6/gvJOQB5nKTAy1mIxG4
 9vfg0eEFzLeCfXNHXGa8+hLNciVe/5SjPvVpL7P6HAo6ucVAXQOm/mr6UfScKuITt2ZXW7erdnO
 bbu2QBxFxllS/Hlb34bPguj5+PbVQRhMf/X4yrjU5fNu2Ua5tgFICgA==
X-Received: by 2002:a05:600c:8a09:20b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-490b0e9355cmr10784465e9.13.1780344301424; 
 Mon, 01 Jun 2026 13:05:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8a09:20b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-490b0e9355cmr10784075e9.13.1780344300888; 
 Mon, 01 Jun 2026 13:05:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e19a06sm15089025e9.5.2026.06.01.13.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 13:05:00 -0700 (PDT)
Date: Mon, 1 Jun 2026 16:04:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Alyssa Ross <hi@alyssa.is>, Mark Burton <MBURTON@qti.qualcomm.com>,
 Matti Moell <matti@qti.qualcomm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>,
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Subject: Re: Where should the vhost-user specification live?
Message-ID: <20260601160352-mutt-send-email-mst@kernel.org>
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
 <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
 <20260601090953-mutt-send-email-mst@kernel.org>
 <CAJSP0QV4W=5MJsSGggACv-tqxDtiieKc0YzEn8t-R=RD94KJaQ@mail.gmail.com>
 <CADSE00+ziHc8W2FqNT-aJU0Lt4sZ=NfQLc65m16vpT++pZM+xQ@mail.gmail.com>
 <20260601151815.GC411459@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601151815.GC411459@fedora>
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

On Mon, Jun 01, 2026 at 11:18:15AM -0400, Stefan Hajnoczi wrote:
> On Mon, Jun 01, 2026 at 04:27:46PM +0200, Albert Esteve wrote:
> > On Mon, Jun 1, 2026 at 3:51 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >
> > > On Mon, Jun 1, 2026 at 9:12 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 01, 2026 at 03:05:50PM +0200, Albert Esteve wrote:
> > > > > On Mon, Jun 1, 2026 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote:
> > > > > > >  But also because, in my opinion, separating
> > > > > > > the specification would improve development agility by decoupling
> > > > > > > specification development from QEMU's review and release cycles.
> > > > > >
> > > > > > Generally for QEMU this will be less agility, unless I misunderstand
> > > > > > what is proposed)
> > > > > >
> > > > > > Because presumably there will need to be spec releases then?
> > > > > >
> > > > > > So
> > > > > >         new feature -> spec tree -> spec release -> qemu implementation -> qemu release
> > > > > >
> > > > > > is surely longer that what we have now.
> > > > >
> > > > > I see your point.
> > > > >
> > > > > However, we do not really need to introduce a heavy release management
> > > > > layer. We could just operate it as a living document, where the main
> > > > > branch is the authoritative source of truth.
> > > > >
> > > > > For the workflow, development doesn't have to be strictly sequential
> > > > > either. A contributor can propose the spec update while working on the
> > > > > implementation, much like we do for VirtIO updates. Actually, this way
> > > > > one update/change supports the other.
> > > > >
> > > > > I guess my point is that a dedicated repository could lower the
> > > > > barrier for new changes AND keep QEMU's own development speed mostly
> > > > > unaffected.
> > > > >
> > > > > BR,
> > > > > Albert
> > > >
> > > > Something something submodule? Possibly. If you want to make progress
> > > > on this, pls think of the process, try it out.
> > >
> > > If I understand correctly, the motivation for moving the spec
> > > somewhere else is to replace the email patch review process with a git
> > > forge review process?
> > >
> > > This seems like a superficial change and is not worth in my opinion if
> > > you consider we'll have to redirect from the old spec location and
> > > move the community over to the new repo.
> > 
> > The core issue from my perspective is project neutrality and
> > decoupling lifecycles.
> >
> > Currently, protocol updates are tied to QEMU's tree rules and release
> > freezes for example. Since these changes also affect other projects
> > (like rust-vmm, crosvm, DPDK, etc.), separating them may make sense
> > and could streamline the process.
> 
> I don't see a reason to block vhost-user.rst changes during QEMU's
> freeze. If Michael sent a vhost-user spec pull request during freeze I
> would merge it.
> 
> > >We could actually lose spec
> > > change reviewers in the process either because they don't know what's
> > > going on or decide that they prefer to spend time elsewhere when faced
> > > with switching processes (the people who review and participate in
> > > discussion do so out of personal interest and as far as I'm aware no
> > > one is employed to work on vhost-user as their #1 priority).
> > 
> > This is a fair concern. I hope we maintain reviewer engagement. But it
> > could also be argued that contributors from other communities may be
> > more comfortable with a dedicated project-neutral home. It could well
> > go both ways, but it also represents an opportunity to grow.
> > 
> > >
> > > Having said that, here is what I imagine it would involve:
> > >
> > > 1. Michael creates a new repo on a git forge (if he wants it to be
> > > under the GitLab qemu-project organization I can help with creating
> > > the repo, otherwise he creates a new organization and repo).
> > > 2. Discussion happens in Issues.
> > > 3. Spec changes are proposed in Merge Requests. Michael merges them
> > > once consensus has been reached.
> > 
> > Mostly yes, though we wouldn't necessarily need Michael as the sole
> > gatekeeper. We could invite co-maintainers from other key projects to
> > share the reviewer load.
> >
> > Also I'd want to clarify that although I am advocating for this
> > change, I do not claim to have the definitive roadmap. I am just
> > sharing my view on why this could be a positive evolution. Consensus
> > may end up being to remain with the current status quo, or any of the
> > other options proposed by Alex.
> 
> I get a sense that this is about politics in the end. Do people feel
> they are not represented and would like to have more influence in the
> vhost-user spec?
> 
> You bring up project neutrality and a model where Michael is no longer
> the sole maintainer. It will be necessary to propose a concrete roadmap
> and also to explain the concerns about neutrality more so it's clear
> they won't be an issue anymore in the future system.
> 
> Why is the current system not neutral and how will the new system solve
> that?
> 
> Who should be a co-maintainer?
> 
> Stefan

And also, qemu currently acts like a reference implementation.
Which is something.

-- 
MST


