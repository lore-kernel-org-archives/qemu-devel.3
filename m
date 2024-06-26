Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E6C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMOmn-0004yN-Ep; Wed, 26 Jun 2024 05:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMOmf-0004xH-8F
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 05:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMOmd-0007pV-Dz
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 05:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719393462;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rbxSVY0gpqKOR67+xBD4o9JdRHsVjzViEp3G8A/dizg=;
 b=QZka+Ma58fl+E+KPuC/BXlYg6TIF/vtvzOZsFpONLwEcQTxF/nffn7qWRB8gKxwiGEVj9e
 ACxspGTIypGd/EUwH5nSAG2x43DERkWcOZJ2IlCG6mOhnvi1F5eVi13zvdpZ4w6HsFuz9B
 SEW4Cac8hQ06TQpElI7E2uNCSyd8u58=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-hvQ30NZhODiDLiNqO1R2DA-1; Wed,
 26 Jun 2024 05:17:39 -0400
X-MC-Unique: hvQ30NZhODiDLiNqO1R2DA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF17119560AB; Wed, 26 Jun 2024 09:17:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFFDC1955F2D; Wed, 26 Jun 2024 09:17:34 +0000 (UTC)
Date: Wed, 26 Jun 2024 10:17:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
Message-ID: <Znvcq1H7sGtwxIAd@redhat.com>
References: <20240619174022.1298578-1-nsoffer@redhat.com>
 <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
 <20240624152302.GA2402845@fedora.redhat.com>
 <ZnmZ-m38IAHg0UdX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnmZ-m38IAHg0UdX@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jun 24, 2024 at 06:08:26PM +0200, Kevin Wolf wrote:
> Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:
> > On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:
> > > Tested using:
> > 
> > Hi Nir,
> > This looks like a good candidate for the qemu-iotests test suite. Adding
> > it to the automated tests will protect against future regressions.
> > 
> > Please add the script and the expected output to
> > tests/qemu-iotests/test/write-zeroes-unmap and run it using
> > `(cd build && tests/qemu-iotests/check write-zeroes-unmap)`.
> > 
> > See the existing test cases in tests/qemu-iotests/ and
> > tests/qemu-iotests/tests/ for examples. Some are shell scripts and
> > others are Python. I think shell makes sense for this test case. You
> > can copy the test framework boilerplate from an existing test case.
> 
> 'du' can't be used like this in qemu-iotests because it makes
> assumptions that depend on the filesystem. A test case replicating what
> Nir did manually would likely fail on XFS with its preallocation.
> 
> Maybe we could operate on a file exposed by the FUSE export that is
> backed by qcow2, and then you can use 'qemu-img map' on that qcow2 image
> to verify the allocation status. Somewhat complicated, but I think it
> could work.

A simpler option would be to use 'du' but with a fuzzy range test,
rather than an exact equality test.

For the tests which write 1 MB, check the 'du' usage is "at least 1MB",
for the tests which expect to unmap blocks, check that the 'du' usage
is "less than 256kb". This should be within bounds of xfs speculative
allocation.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


