Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB2AC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 12:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR92t-0001HZ-Ma; Mon, 16 Jun 2025 08:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uR92r-0001G6-HU
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 08:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uR92o-0007Dm-Dl
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 08:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750077271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8xUPjgKNHcT3eMptsqgaiVwpYSNEmKsWFhFZg7erRg=;
 b=PiUjXqm/izX6HutJBUuo1zAGV80IEaecvr8X069Q3eob75ZGi2GNusA0JxZlhJQarWXov5
 phX/K+KD01KuPJqv//kxhc1woCs0FWm61yi/SwiN68q3eCl36/DfeHGS/Z+5/tnQB6rqit
 BIWgeyf1QEdKpHfp5i4+R6V+GEEBhBM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-jdpwMO5FNjODic5lUr_FwA-1; Mon,
 16 Jun 2025 08:34:27 -0400
X-MC-Unique: jdpwMO5FNjODic5lUr_FwA-1
X-Mimecast-MFC-AGG-ID: jdpwMO5FNjODic5lUr_FwA_1750077266
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB3C91809C86; Mon, 16 Jun 2025 12:34:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73A3830044D6; Mon, 16 Jun 2025 12:34:21 +0000 (UTC)
Date: Mon, 16 Jun 2025 13:34:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
Subject: Re: [PATCH 1/2] block/rbd: support selected key-value-pairs via QAPI
Message-ID: <aFAPSuuQy4RcstAe@redhat.com>
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-2-f.ebner@proxmox.com>
 <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
 <10336f91-fcb5-44bf-aebe-70ec5b274fd3@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10336f91-fcb5-44bf-aebe-70ec5b274fd3@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jun 16, 2025 at 02:29:56PM +0200, Fiona Ebner wrote:
> Am 16.06.25 um 11:41 schrieb Daniel P. Berrangé:
> > On Thu, May 15, 2025 at 01:29:07PM +0200, Fiona Ebner wrote:
> >> @@ -4327,6 +4360,9 @@
> >>  #     authentication.  This maps to Ceph configuration option "key".
> >>  #     (Since 3.0)
> >>  #
> >> +# @key-value-pairs: Key-value pairs for additional Ceph configuraton.
> >> +#     (Since 10.1)
> >> +#
> >>  # @server: Monitor host address and port.  This maps to the "mon_host"
> >>  #     Ceph option.
> >>  #
> >> @@ -4342,6 +4378,7 @@
> >>              '*user': 'str',
> >>              '*auth-client-required': ['RbdAuthMode'],
> >>              '*key-secret': 'str',
> >> +            '*key-value-pairs' : 'RbdKeyValuePairs',
> >
> > I'm not seeing any point in this 'RbdKeyValuePairs' struct. Why isn't
> > the 'rbd-cache-policy' field just directly part of the BlockdevOptionsRbd
> > struct like all the other options are ?
> >
> > Also, 'rbd-' as a prefix in the field name is redundant when this is
> > already in an RBD specific struct.
> 
> Am 16.06.25 um 11:25 schrieb Ilya Dryomov:
> > Hi Fiona,
> > 
> > I'm not following the rationale for introducing RbdKeyValuePairs
> > struct.  If there is a desire to expose rbd_cache_policy option this
> > way, couldn't it just be added to BlockdevOptionsRbd struct?  The
> > existing auth_client_required option has a very similar pattern.
> 
> Hi Ilya and Daniel,
> 
> my intention was to not "pollute" the top-level struct with rather
> uncommon options, but collect them separately and also make it explicit
> that those are the key-value pairs passed along to Ceph.

If these are useful things that users of ceph need to be able to
control for their QEMU VMs, then this is not "pollution".

> > If exposing rbd_cache_policy option, rbd_cache option (enabled/disabled
> > bool) should likely be exposed as well.  It doesn't make much sense to
> > provide a built-in way to adjust the cache policy without also providing
> > a built-in way to disable the cache entirely.  Then the question of what
> > would be better from the QAPI perspective arises: a bool option to map
> > to Ceph as close as possible or perhaps an additional 'disabled' value
> > in RbdCachePolicy enum?  And regardless of that, the need to remember
> > to update QEMU if a new cache policy is ever added because even though
> > these are just strings, QEMU is going to be validating them...
> 
> Good point! If going with the key-value-pairs approach, it would be
> nicer to go with a direct mapping IMHO. If adding it to the top-level,
> I'd be in favor of the 'disabled' value.

If this is stuff that users expect/need to be able to configure for
their VMs, that would bias towards formal modelling in QAPI, not plain
passthrough.

NB, any features intended to be configurable via libvirt would need
to be formalling modelled, as libvirt won't introduce a dependency
on things that QEMU declares "unstable" in QAPI.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


