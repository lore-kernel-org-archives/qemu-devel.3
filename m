Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01699C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZY0C-0000Qw-1w; Thu, 01 Aug 2024 11:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZXzn-0007g5-T9
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZXzi-0005TU-Ep
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722527133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DsP3ZOdqIXAVhQSHR1Eh11f8cfruZNnVOkRlVO3yiN8=;
 b=eBWISJBfJEW221PdTb8xOz9wXJ0rInTDhmdiO8+hSpyZ4RF63kui05algwwTqwqqowuGuS
 R2S3HQLfuCJ0a7rkRqFNfRqsfrNvYL1FQFvUPK5FIs6lXWO9vzc9DMvcCN52wacStXAbQN
 mJrmFo+PyJ6nHn9keKIVKg3ozv6GEQY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-panVCtr4NTqwfkzv7k-x-g-1; Thu,
 01 Aug 2024 11:45:29 -0400
X-MC-Unique: panVCtr4NTqwfkzv7k-x-g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3982D1955BF8; Thu,  1 Aug 2024 15:45:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4409E1955D42; Thu,  1 Aug 2024 15:45:20 +0000 (UTC)
Date: Thu, 1 Aug 2024 16:45:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqutjR8WH2Owm9q8@redhat.com>
References: <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
 <Zqnh-AJC4JPl5EkS@redhat.com>
 <20240731033803-mutt-send-email-mst@kernel.org>
 <Zqo00Na1MZpksY9A@x1n>
 <20240801014222-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801014222-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Thu, Aug 01, 2024 at 01:51:00AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 31, 2024 at 08:57:52AM -0400, Peter Xu wrote:
> > Could you elaborate why it would fail if with what I proposed?
> 
> First I think I was wrong I misunderstood what you said.
> To summarise, you said:
> 
> - any new feature depending on another package is off by default
> - starting qemu on destination with feature enabled will fail
>   thus migration is not started
> 
> 
> My comment is that this "started" is from qemu point of view,
> from user's POV starting qemu on destination is just the 1st
> step of migration.
> 
> 
> However I agree, this is better since we do not waste bandwidth,
> and I was wrong to say we do.
> 
> My other comment is that adding features becomes even more work
> than it is now.
> 
> So I suggest a single command that dumps some description of host
> features, to be passed to qemu on destination. qemu then fails to
> start on destination if some of these do not work.
> The advantage is that this also helps things like -cpu host,
> and a bunch of other things like vdpa where we like to pass through
> config from kernel.
> 
> The disadvantage is that it does not exactly *fix* migration,
> it just does not let you start it.

This feels like only half a solution, and not the most helpful half.
It prevents you accidentally migrating to a host that lacks some
features, but doesn't help with starting a VM that has migrate
compatible features in the first place.

From a user POV, the latter is what's most important. Checking for
incompatible features is just a safety net that you should never
need to hit, if QEMU was configured suitably to start with.

So to ensure a QEMU is started with migration compatible features
will still require teaching libvirt about every single feature
that has a host kernel dependancy, so libvirt (or the app using
libvirt) knows to turn this off. This is alot more work for both
libvirt & the mgmt app, than having QEMU provide the generic
"platforms" concept which is extensible without needing further
work outside QEMU.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


