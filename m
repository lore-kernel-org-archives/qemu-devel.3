Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DCAC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXgT-0002er-PU; Thu, 01 Aug 2024 11:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZXgR-0002dm-PO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZXgF-0006RU-Sa
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722525925;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HRxp1FCm+PYLVUhihCS2lS8QnG0y1jl8FCuOVBsPuD4=;
 b=DVFvbZi6YwrBgvlNh7S7J6Han37hjDrkUIu2oc+ZmAILs8jiQXKBIWA0yeOEzxpz3zCXmU
 XRg7NK5kGgu6CH/+72UseHtD481hv/mGeTjK7ChUv9az3di87zmdAn3uJ/R/6i62GR26uY
 y05l4PdRwLmFDg7aAPESoZD3tUe+ECc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-e2u0jA0zONS6rIGZ_u0_uw-1; Thu,
 01 Aug 2024 11:25:24 -0400
X-MC-Unique: e2u0jA0zONS6rIGZ_u0_uw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14CD81955F43; Thu,  1 Aug 2024 15:25:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 198B919560AE; Thu,  1 Aug 2024 15:25:14 +0000 (UTC)
Date: Thu, 1 Aug 2024 16:25:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <Zquo11q12lqbDlY4@redhat.com>
References: <ZqQLbGxEW3XT7qL-@x1n> <Zqe8C9AfaojKHM8A@redhat.com>
 <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
 <20240801111435-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801111435-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 01, 2024 at 11:15:47AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 01, 2024 at 11:13:37AM -0400, Peter Xu wrote:
> > Do we really concern about users not enabling features that much?  I
> > thought users always can manually change the XML and add whatever they
> > need, and device properties do not like too special here to me.  I mean, we
> > have bunch of "features" exported as new "-devices" and users must opt-in
> > for them by changing the XML.  We never worried on user not using them.  I
> > doubt whether we worried too much on user not opt-in, especially for
> > performance features, because they're, IMHO, targeting advanced users.
> 
> What I do not like, is pushing the knowledge of what good defaults
> are to libvirt.

With the -platform concept, libvirt wouldn't need to know anything about
the settings being used, nor the defaults.

Consider how it works for machine types. Libvirt queries the machine
types, and gets a list back, and QEMU expresses a default. eg saying
that 'pc-i440fx-9.1.0' is aliased to 'pc'. So libvirt can expand
'pc' to a particular version that QEMU has chosen as the default.

Conceptually I could see something similar working for the -platform
concept. Libvirt would ask QEMU for all the "platform" variants that
are available on the current running kernel. QEMU can reply with the
list, and indicate which of those is the "newest" in some manner.

Absent any preference from the mgmt app, libvirt would use whichever
one QEMU indicates was the newest. This optimizes for best featureset
on the current kernel, as the cost of possibly reduced migration
compatibility.

When a mgmt app is caring about migration, they would explicitly tell
libvirt which platform version to use, just as they would explicitly
ask for a specific machine type version, rather than accepting the 'pc'
default.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


