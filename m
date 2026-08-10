Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67518C5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtLnD-0007SE-Ak; Mon, 10 Aug 2026 04:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtLnB-0007Rq-Pb
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtLn9-0007zR-M8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786352130;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DyeUvB9xTZqYkRV2YaikTYbrKjVxHbpykZML8ACsro=;
 b=XkG57C4+k114UKP29r9G2bLAMC5c3Yt57trNmZADJd3hOTduqL8RnBPlyvQYRsMrI2YfjR
 RNpGNGb2s5U9PgwCYLPyzilfzZXUTuNQh2IG/O/aiwnYF/8BJ+ZYoqDPFen4m8QDZxKJQF
 mowwVB4LfJroxmw7HEvyjJIVCkemJWc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-Z5G3lzKuPTG5Yt9Z2P-mIA-1; Mon,
 10 Aug 2026 04:55:26 -0400
X-MC-Unique: Z5G3lzKuPTG5Yt9Z2P-mIA-1
X-Mimecast-MFC-AGG-ID: Z5G3lzKuPTG5Yt9Z2P-mIA_1786352125
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A05F0195609F; Mon, 10 Aug 2026 08:55:21 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FF64195DF93; Mon, 10 Aug 2026 08:55:20 +0000 (UTC)
Date: Mon, 10 Aug 2026 09:55:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Valentino Paulon <valentino.paulon88@gmail.com>, qemu-devel@nongnu.org,
 yvugenfi@redhat.com, michael.roth@amd.com
Subject: Re: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
Message-ID: <anmR9aKJcdtL_xTL@redhat.com>
References: <20260709105707.91209-1-kkostiuk@redhat.com>
 <alYRTj0_B-HA3t_Y@redhat.com>
 <CAPMcbCpHZPMRMFas8FOjNZtohozc96M7pcdce5Xnpur-ThwJQQ@mail.gmail.com>
 <alYdwKHMWoVcay_B@redhat.com>
 <CAF2ANE06ah2B37BmL=WQfJYutt1zGP7sPkOWZ+=+-dLdLqZ_MA@mail.gmail.com>
 <CAPMcbCp0vNA5RwR2W9C7-JYUyd-9QWdSKtLERsSW6mEr1nx9YQ@mail.gmail.com>
 <anmJvO2PUDM0xa7l@redhat.com>
 <CAPMcbCoKduRuKdt8P6ULrc43uX_2z=hBp_N87yi8F4GHdVqPeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCoKduRuKdt8P6ULrc43uX_2z=hBp_N87yi8F4GHdVqPeA@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 10, 2026 at 11:37:34AM +0300, Kostiantyn Kostiuk wrote:
> On Mon, Aug 10, 2026 at 11:20 AM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Mon, Aug 10, 2026 at 11:06:27AM +0300, Kostiantyn Kostiuk wrote:
> > > Hi Valentino,
> > >
> > > Sorry for the long delay.
> > > I have a question for you
> > >
> > > On Tue, Jul 14, 2026 at 7:10 PM Valentino Paulon <
> > > valentino.paulon88@gmail.com> wrote:
> > >
> > > > > > So, you propose to call seteuid/setegid before any I/O operation?
> > > > >
> > > > > Yes, specifically for the SSH commands, because they're unusual in
> > > > > that we're doing stuff on behalf of an unprivileged user.
> > > >
> > > > +1 on the euid/egid direction -- as the reporter that's the outcome I
> > > > was hoping for. It confines every step (read, mkdir, create, rename,
> > > > chown) to what the target user could already do himself, which removes
> > > > the whole TOCTOU class instead of chasing one instance of it.
> > > >
> > > > A few implementation details that tend to bite with this pattern, in
> > > > case they save a round-trip:
> > > >
> > > > - drop the supplementary groups too, not just egid: initgroups() (or
> > > > setgroups() with the user's list) while still root, otherwise the
> > > > agent's effective access won't match the user's in either direction
> > > >
> > >
> > > Technically, there is no limitation to running QGA in unprivileged mode.
> > > Normally, it is a system daemon, but this is not mandatory.
> > > In this case, we can not call initgroups because the caller must
> > > have CAP_SETGID.
> > > We can call initgroups only when QGA runs as root. What do you think?
> >
> > In any practical sense it is a system daemon given the set of commands
> > it is exposing. Thus, IMHO, deploying as an unprivileged user should
> > be considered a broken deployment. We could make that explicit by
> > refusing to launch.
> >
> 
> Makes sense, but we have one more issue with QGA unit tests in this case.
> They are called by an unprivileged user (build user), and initgroups broke
> it.
> Is it possible to enter the namespace automatically by the test engine?

We can't assume that is possible todo in all build/test environments.

Doing things as different user accounts feels pretty dubious for the
scope of a unit test too - that is really functional or integration
testing.

Can we somehow restructure the tests and/or agent code to avoid the
changing groups stuff in unit tests.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


