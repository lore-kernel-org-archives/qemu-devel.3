Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDCAC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 20:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tah9a-0007AM-QB; Wed, 22 Jan 2025 15:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tah9G-00079H-P0
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 15:16:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tah9C-0002Aj-0V
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 15:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737576980;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vCNqWs9ImXxipCSsenIHpvtvEMrfPIQD8+8bk/Q+Y0=;
 b=UFkGCbT+D5p0s41e6fee7rOGoGbT6o46I4CChh4aMWXzS22SHgeedTmnQlwhtwDTMfATXT
 AABiTSc5BLcvgxsL6+vpsV38cm5a3dd0xuKGUQuoxEXvhEiXF8fU0sjopKkCplPYPVj9Hy
 K22aZo2NB5bQ4bljU3fVERhHYBvhtC0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-SjShgEKaOsmSpwQf8pWSgg-1; Wed,
 22 Jan 2025 15:16:16 -0500
X-MC-Unique: SjShgEKaOsmSpwQf8pWSgg-1
X-Mimecast-MFC-AGG-ID: SjShgEKaOsmSpwQf8pWSgg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC6E91956068; Wed, 22 Jan 2025 20:16:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.43])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B459619560B7; Wed, 22 Jan 2025 20:16:10 +0000 (UTC)
Date: Wed, 22 Jan 2025 20:16:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] crypto: fix bogus error benchmarking pbkdf on fast
 machines
Message-ID: <Z5FSBzXWMv-r8Ir-@redhat.com>
References: <20250108184354.997818-1-berrange@redhat.com>
 <dc801052-432f-45eb-9fee-a2850401cffd@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc801052-432f-45eb-9fee-a2850401cffd@tls.msk.ru>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Wed, Jan 22, 2025 at 10:19:41PM +0300, Michael Tokarev wrote:
> 08.01.2025 21:43, Daniel P. Berrangé пишет:
> > We're seeing periodic reports of errors like:
> > 
> > $ qemu-img create -f luks --object secret,data=123456,id=sec0 \
> >                    -o key-secret=sec0 luks-info.img 1M
> >    Formatting 'luks-info.img', fmt=luks size=1048576 key-secret=sec0
> >    qemu-img: luks-info.img: Unable to get accurate CPU usage
> > 
> > This error message comes from a recent attempt to workaround a
> > kernel bug with measuring rusage in long running processes:
> > 
> >    commit c72cab5ad9f849bbcfcf4be7952b8b8946cc626e
> >    Author: Tiago Pasqualini <tiago.pasqualini@canonical.com>
> >    Date:   Wed Sep 4 20:52:30 2024 -0300
> > 
> >      crypto: run qcrypto_pbkdf2_count_iters in a new thread
> > 
> > Unfortunately this has a subtle bug on machines which are very fast.
> > 
> > On the first time around the loop, the 'iterations' value is quite
> > small (1 << 15), and so will run quite fast. Testing has shown that
> > some machines can complete this benchmarking task in as little as
> > 7 milliseconds.
> > 
> > Unfortunately the 'getrusage' data is not updated at the time of
> > the 'getrusage' call, it is done asynchronously by the schedular.
> > The 7 millisecond completion time for the benchmark is short
> > enough that 'getrusage' sometimes reports 0 accumulated execution
> > time.
> > 
> > As a result the 'delay_ms == 0' sanity check in the above commit
> > is triggering non-deterministically on such machines.
> > 
> > The benchmarking loop intended to run multiple times, increasing
> > the 'iterations' value until the benchmark ran for > 500 ms, but
> > the sanity check doesn't allow this to happen.
> > 
> > To fix it, we keep a loop counter and only run the sanity check
> > after we've been around the loop more than 5 times. At that point
> > the 'iterations' value is high enough that even with infrequent
> > updates of 'getrusage' accounting data on fast machines, we should
> > see a non-zero value.
> > 
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Reported-by: Richard W.M. Jones <rjones@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Is this a qemu-stable material (9.2)?

Yes, please include it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


