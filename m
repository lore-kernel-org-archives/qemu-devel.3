Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7BCD4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSTG-0007NS-3j; Thu, 15 Jan 2026 13:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgSTC-0007LG-Jn
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgSTA-0005Hp-0N
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768503197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVRQ43fty3LRv7RRjgEy1YVkB1oEH+D5YYsmPnYWrQI=;
 b=A/B0syf7E24LA1zOljszdgl+S1Tqt7JOOq8pO3LUbeQmplIE/PckDp3wjteJUTwovbHO9O
 lJWpeS5z20wxJ1lgeGlFBok1Op2bn4Z7Kdpvxgi1TZQex5j2hiz2bVU1mDkM46GOCp2nKt
 zze9eZCBV6e88TwxYLtMaQ0OJWxVrl8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-W9FUUCA3My23IxKxE7J-Jg-1; Thu, 15 Jan 2026 13:53:16 -0500
X-MC-Unique: W9FUUCA3My23IxKxE7J-Jg-1
X-Mimecast-MFC-AGG-ID: W9FUUCA3My23IxKxE7J-Jg_1768503196
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c52fd47227so245307085a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768503196; x=1769107996; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lVRQ43fty3LRv7RRjgEy1YVkB1oEH+D5YYsmPnYWrQI=;
 b=K2yhDN3e6o4GOGBf9krQfvrT7C44TRMpLuOaAq3HZPP/uzAGVp6qxyTrHMn6cwG8FZ
 ehkz5gBoEQ7lhzvWzSofsWyjHFA1YJfgGH8x3L6rv/nKcpHVo8DCNmdeaJzMqRsPZlz6
 TZ5qFsTys3wxVz4hTAs9MTmQvrJsRsR6UnithWugjgE8Y/mnl2+KpSDZHedEK3kf6DpV
 IsEyxRGgG7+yzTMWvX8l2YZkqpJTObCwPRII4yeiTvLmqb7AK0YfJ+6F5HymZxOeBepn
 V4AlraJxjwvv6TRtrLYFtWdbZcyKnzNroAaILWk4jXR53Sfnj/MDSERmZOJmcv5/A4Ly
 9tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503196; x=1769107996;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lVRQ43fty3LRv7RRjgEy1YVkB1oEH+D5YYsmPnYWrQI=;
 b=WRFDyfhXwPDDfCbDu0BSzvxsntsZe88G4lPtD6TQhM7wRnwNK5c08uG3nri1c1sSeT
 cYNAqZ6nMB6NwHqFA4w7nQEmEI4bgj/abrMtWN9hNalTx2xGLjdnyrsQ5gG9EVXuiX1r
 rZNbOQoad39deCRrJ+VhTAdvE6hLwW3WoAoEe6afuN954Ef1aUh8zyc+Z7270AERUd3v
 uq2jYDMP0UgfKCig/v/l77CB0CLdQ4XfIS2h0Oz+5+4uKITF6dmdKKyUu5CYicYxJxlc
 uwcV5imX1Z+qjnVLqEE7P6R6vuct9FWWkMBv6yR4Q7AhjYNlOCfd9PUYgk7mbK9xbuCs
 pIxg==
X-Gm-Message-State: AOJu0YweRM6ENO/cEAOaOe7xHsP204YyXyDq1RFEe0nL61iAC+mN3JR2
 q3r+1x324CFRkYeewtXQN7tPtB6S4Y7j+qscpUhOCARfQvi2XvJiag4OmolxOORW3mAB1Qs/7pl
 eA6FzmTUnMBv88dSQoqGG/dToJxMqSS81vMTSw6g5WR6ixf0VCRl7ncTo
X-Gm-Gg: AY/fxX6uQLaO8ei7ozVaD20/ynR1G75tV5qnsKNBNyFmEnnKxdo0JuESp5MNLmHrCze
 6chiZ/rU6XKux/eW4AUPuH1vigV9qqDBeh+zp+cC9ghpzitoNLcVmLmN+5ojvQx84iX0Z0g46Kf
 SJrnJGNdZdb/rHGp1esm27sHN0MyAoG0hxYMJxbqqgewMrS918iapv9qXI705qz7G9SSuX/Qc7k
 Bmx1K3BJAcJ+/OanHb8cuFIrUXuR2ACt8gamahTb0Ss2klz3vow0rdYpY2zKawC5HtBtlU6THi1
 K6cLDqX+ORcSnjoLMdC/k4oAiET8kAtRCo8OC0SXb27hCJA6aWbgOTqK2pTXBv8MXckSsCjPF5Q
 fDQA=
X-Received: by 2002:a05:620a:44ce:b0:8c5:1fb5:1631 with SMTP id
 af79cd13be357-8c6a694a426mr49045885a.76.1768503195712; 
 Thu, 15 Jan 2026 10:53:15 -0800 (PST)
X-Received: by 2002:a05:620a:44ce:b0:8c5:1fb5:1631 with SMTP id
 af79cd13be357-8c6a694a426mr49041685a.76.1768503195153; 
 Thu, 15 Jan 2026 10:53:15 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a7260229sm10920785a.42.2026.01.15.10.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:53:14 -0800 (PST)
Date: Thu, 15 Jan 2026 13:53:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aWk3kgeAqbYEom5v@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <875x93zae6.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875x93zae6.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 15, 2026 at 06:56:49AM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > COLO was broken for QEMU release 10.0/10.1 without anyone noticed.
> 
> We could arguably drop this right away.  I'm not demanding we do, just
> pointing out.
> 
> First, COLO is marked 'unstable' in the QAPI schema:
> 
> * MigrationCapability member x-colo:
> 
>     # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> 
> * MigrationParameter and MigrationParameters member x-checkpoint-delay:
> 
>     # @unstable: Members @x-checkpoint-delay and
>     #     @x-vcpu-dirty-limit-period are experimental.
> 
> * Command x-colo-lost-heartbeat:
> 
>     # @unstable: This command is experimental.
> 
> There's more COLO stuff we neglected to mark, e.g. MigrationStatus
> member @colo, event COLO_EXIT, commands xen-colo-do-checkpoint,
> query-colo-status.  We should clean that up.  More on that below.
> 
> Second, it's been broken for two releases, our deprecation grace period.
> In my opinion, "broken" is even stronger notice than "deprecated".

I agree.

> 
> >                                                                     One
> > reason might be that we don't have an unit test for COLO (which we
> > explicitly require now for any new migration feature).  The other reason
> > should be that there are just no more active COLO users, at least based on
> > the latest development of QEMU.
> >
> > I don't remember seeing anything really active in the past few years in
> > COLO development.
> >
> > Meanwhile, COLO migration framework maintainer (Hailiang Zhang)'s last
> > email to qemu-devel is in Dec 2021 where the patch proposed an email
> > change (<20211214075424.6920-1-zhanghailiang@xfusion.com>).
> >
> > We've discussed this for a while, see latest discussions here (our thoughts
> > of deprecating COLO framework might be earlier than that, but still):
> >
> > https://lore.kernel.org/r/aQu6bDAA7hnIPg-y@x1.local/
> > https://lore.kernel.org/r/20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de
> >
> > Let's make it partly official and put COLO into deprecation list.  If
> > anyone cares about COLO and is deploying it, please send an email to
> > qemu-devel to discuss.
> >
> > Otherwise, let's try to save some energy for either maintainers or
> > developers who is looking after QEMU. Let's save the work if we don't even
> > know what the work is for.
> >
> > Cc: Lukáš Doktor <ldoktor@redhat.com>
> > Cc: Juan Quintela <quintela@trasno.org>
> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > Cc: Zhang Chen <zhangckid@gmail.com>
> > Cc: zhanghailiang@xfusion.com
> > Cc: Li Zhijian <lizhijian@fujitsu.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  docs/about/deprecated.rst | 6 ++++++
> >  qapi/migration.json       | 5 ++---
> >  migration/options.c       | 4 ++++
> >  3 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index 7abb3dab59..b499b2acb0 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -580,3 +580,9 @@ command documentation for details on the ``fdset`` usage.
> >  
> >  The ``zero-blocks`` capability was part of the block migration which
> >  doesn't exist anymore since it was removed in QEMU v9.1.
> > +
> > +COLO migration framework (since 11.0)
> > +'''''''''''''''''''''''''''''''''''''
> > +
> > +To be removed with no replacement, as the COLO migration framework doesn't
> > +seem to have any active user for a while.
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 201dedd982..3c868efe38 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -531,8 +531,7 @@
> >  #
> >  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> >  #
> > -# @deprecated: Member @zero-blocks is deprecated as being part of
> > -#     block migration which was already removed.
> > +# @deprecated: Member @zero-blocks and @x-colo are deprecated.
> >  #
> >  # Since: 1.2
> >  ##
> > @@ -540,7 +539,7 @@
> >    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
> >             { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
> >             'events', 'postcopy-ram',
> > -           { 'name': 'x-colo', 'features': [ 'unstable' ] },
> > +           { 'name': 'x-colo', 'features': [ 'unstable', 'deprecated' ] },
> >             'release-ram',
> >             'return-path', 'pause-before-switchover', 'multifd',
> >             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
> 
> Issues / doubts:
> 
> 1. We delete the text why @zero-blocks is deprecated.  Harmless; the
> next patch drops @zero-blocks entirely.  Better: swap the patches.

Will do.

> 
> 2. The text for @x-colo is lacking.  Suggest something like "Member
> @x-colo" is deprecated without replacement."
> 
> 3. Does it make sense to keep x-colo @unstable?
> 
> 4. Shouldn't we mark *all* the COLO interfaces the same way?

All questions are fair asks.  For issue 4, it means we will need to add new
tag to COLO if we have the deprecation window..

Let me try to propose removal of COLO in 11.0 directly and see if there'll
be objections.

> 
> > diff --git a/migration/options.c b/migration/options.c
> > index 9a5a39c886..318850ba94 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -580,6 +580,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
> >          warn_report("zero-blocks capability is deprecated");
> >      }
> >  
> > +    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
> > +        warn_report("COLO migration framework is deprecated");
> > +    }
> > +
> >  #ifndef CONFIG_REPLICATION
> >      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
> >          error_setg(errp, "QEMU compiled without replication module"
> 

-- 
Peter Xu


