Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D4BD6B6B8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 18:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6D6U-0001MG-Dz; Wed, 30 Oct 2024 14:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6D6N-0001Lu-7d
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6D6K-000842-EW
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730311642;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VjD9zsbNNhHZBTwDtpBMaia1jrPp7YZgKGzy2X8XrsA=;
 b=bEjgy29byio7+sI+AEF867vbAK8c5irZTHfQj/LZAjVb/3bkhmcANFAY9j+ofG0w9hiOrP
 7lM27yBB+EBnepPJ2dwntw6iGOrLsehlhvIgs4oXGLsw+K1u4xn2Te3ZGTAaSnsUmd1W7R
 vmIv1A9IeGLgsE2Dz2sKc81UcFz99Bc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-HiVwqIGuO6WTeAU2xKuRgw-1; Wed,
 30 Oct 2024 14:07:18 -0400
X-MC-Unique: HiVwqIGuO6WTeAU2xKuRgw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 631CF1955D57; Wed, 30 Oct 2024 18:07:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7392F1956086; Wed, 30 Oct 2024 18:07:11 +0000 (UTC)
Date: Wed, 30 Oct 2024 18:07:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 0/7] QOM: Singleton interface
Message-ID: <ZyJ1zJoOaLuNHPI-@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029211607.2114845-1-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Oct 29, 2024 at 05:16:00PM -0400, Peter Xu wrote:
> v1: https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com
> 
> This patchset introduces the singleton interface for QOM.  I didn't add a
> changelog because there're quite a few changes here and there, plus new
> patches.  So it might just be easier to re-read, considering the patchset
> isn't large.
> 
> I switched v2 into RFC, because we have reviewer concerns (Phil and Dan so
> far) that it could be error prone to try to trap every attempts to create
> an object.  My argument is, if we already have abstract class, meanwhile we
> do not allow instantiation of abstract class, so the complexity is already
> there.  I prepared patch 1 this time to collect and track all similar
> random object creations; it might be helpful as a cleanup on its own to
> deduplicate some similar error messages.  Said that, I'm still always open
> to rejections to this proposal.
> 
> I hope v2 looks slightly cleaner by having not only object_new_allowed()
> but also object_new_or_fetch().

For me, that doesn't really make it much more appealing. Yes, we already have
an abstract class, but that has narrower impact, as there are fewer places
in which which we can trigger instantiation of an abstract class, than
where we can trigger instantiation of arbitrary objects and devices.

The conversion of the iommu code results in worse error reporting, and
doesn't handle the virtio-iommu case, and the migration problems appear
solvable without inventing a singleton interface. So this doesn't feel
like it is worth the the trouble.

NB, my view point would have been different if  'object_new' had an
"Error *errp" parameter. That would have made handling failure a
standard part of the design pattern for object construction, thus
avoiding adding asserts in the 'object_new' codepath which could be
triggered by unexpected/badly validated user input.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


