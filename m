Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB53C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXtA-0005F4-Tl; Thu, 27 Aug 2026 07:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzXt9-0005Eg-0b
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzXt6-0003b4-O3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787828595;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hrMJGKOvoGpsqjqe72hQfz5qOEBcuiO3mBThby3GIPY=;
 b=NQLPs8kNSdJ6uLaagvPfrpWZ2y/edaQ8xKYtDa/KTiVjKl8VV5XvNOzzhT1R5acxBix4Hh
 TXVnHgfMRUuAXn2Giq/QYLhnQG6DxlJ1csqhyncTjC9yI8GrddoPgQ6sJ68aKEyklDtygN
 tz8qtAKCjYmixxCBz5O2dYgH9KDraCc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-1A_5FqnHOYyH3Sfy6eJxcQ-1; Thu,
 27 Aug 2026 07:03:12 -0400
X-MC-Unique: 1A_5FqnHOYyH3Sfy6eJxcQ-1
X-Mimecast-MFC-AGG-ID: 1A_5FqnHOYyH3Sfy6eJxcQ_1787828591
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA2F01955F39; Thu, 27 Aug 2026 11:03:10 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BBE51955F75; Thu, 27 Aug 2026 11:03:08 +0000 (UTC)
Date: Thu, 27 Aug 2026 12:03:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/7] tests/qtest: fix the disk tests on a host with a
 small /tmp
Message-ID: <apAZaRwIdm1yLiLV@redhat.com>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
 <20260824200627.2180635-1-den@openvz.org>
 <a1a7cdc7-5458-4d1b-bf1e-9aa89502317b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1a7cdc7-5458-4d1b-bf1e-9aa89502317b@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Aug 27, 2026 at 12:16:56PM +0200, Thomas Huth wrote:
> 
>  Hi Denis!
> 
> Please make sure to CC: the qtest maintainer (Fabiano Rosas) on series like
> this.
> 
> On 24/08/2026 22.06, Denis V. Lunev wrote:
> > John reported ide-test dying at startup in the NetBSD VM:
> > 
> >    ERROR:../src/tests/qtest/ide-test.c:1260:main: assertion failed:
> >    (ret == 0)
> > 
> > The hypothesys is that the ftruncate() of a 64 MiB scratch image. NetBSD
> > mounts /tmp as a tmpfs sized at 25% of RAM and charges a file its full
> > length themoment it is extended, so a sparse image is not free there and
> > the call returns ENOSPC. The assert dates to 2013, nothing regressed.
> 
> Does NetBSD have another file like /var/tmp that might be friendlier to
> sparse files? If so, maybe that should be used instead?
> 
> OTOH, our NetBSD VM in tests/vm/ uses 4G of RAM, so a temporary file with
> just 64 MiB should really not be a problem...?

Or this is a concurrency scaling problem, or racing with another test
that also uses stuff ?

We hard code memory to 4 GB, but -smp we scale to "$NUM-CPUs / 2"
for the "make vm-build-DIST" commands.

IOW, regardless of whether QEMU is launched with -smp 1 or -smp 20,
we only give it 4 GB to play with. We could be using a lot of RAM
for concurrent build jobs leaving almost nothing for the tmpfs for
the test.

If we were that close to exhaustion I'd expected to see out of
memory errors, but I'm unclear what NetBSD's behaviour is in
this respect ?  Maybe normal RAM usage can be pushed to swap
(of which I see another 4 GB) while tmpfs can't be pushed
to swap ?




With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


