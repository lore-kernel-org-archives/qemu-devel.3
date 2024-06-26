Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33717C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 08:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMOEh-0008Aa-3U; Wed, 26 Jun 2024 04:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sMOEf-0008A3-BC
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sMOEd-0001aR-KB
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719391354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1FK0HXF/pUjhJL0NYY+JwgrUFD6QZo2BZwQzQgrgus=;
 b=QJLj/vzugtZKt/FfJmrvUZSy0ygl3Bthkajmg/gwb3l8kq14gBsm1s7w+uIn7WVOTTUBDk
 QKbjPBTBsMYCNpzOCL+OrY/sZVO2onkDUa6BghXX6s6CRuTV4HVm+8QjSXjO8sRwWr9QH2
 hi7jM2FtzlQWtI6QqAwUy2bTSx4UVLQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-aelFG2q5My6JGjRno__c5w-1; Wed,
 26 Jun 2024 04:42:32 -0400
X-MC-Unique: aelFG2q5My6JGjRno__c5w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2771419560B3; Wed, 26 Jun 2024 08:42:31 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.235])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 984763000225; Wed, 26 Jun 2024 08:42:28 +0000 (UTC)
Date: Wed, 26 Jun 2024 10:42:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2] Consider discard option when writing zeros
Message-ID: <ZnvUcQiXzQW-Mq1s@redhat.com>
References: <20240619174022.1298578-1-nsoffer@redhat.com>
 <CAMRbyyso9cMFueVS3SGtJ3G=-OGu+ueqqE5u2NYtsydBxf_J3Q@mail.gmail.com>
 <20240624152302.GA2402845@fedora.redhat.com>
 <ZnmZ-m38IAHg0UdX@redhat.com>
 <CAMRbyyv9utXsfXKiPz4fGw+S4JLgsZE2UDxUOxwG1fxZwGMHNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRbyyv9utXsfXKiPz4fGw+S4JLgsZE2UDxUOxwG1fxZwGMHNQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 24.06.2024 um 23:12 hat Nir Soffer geschrieben:
> On Mon, Jun 24, 2024 at 7:08 PM Kevin Wolf <kwolf@redhat.com> wrote:
> 
> > Am 24.06.2024 um 17:23 hat Stefan Hajnoczi geschrieben:
> > > On Wed, Jun 19, 2024 at 08:43:25PM +0300, Nir Soffer wrote:
> > > > Tested using:
> > >
> > > Hi Nir,
> > > This looks like a good candidate for the qemu-iotests test suite. Adding
> > > it to the automated tests will protect against future regressions.
> > >
> > > Please add the script and the expected output to
> > > tests/qemu-iotests/test/write-zeroes-unmap and run it using
> > > `(cd build && tests/qemu-iotests/check write-zeroes-unmap)`.
> > >
> > > See the existing test cases in tests/qemu-iotests/ and
> > > tests/qemu-iotests/tests/ for examples. Some are shell scripts and
> > > others are Python. I think shell makes sense for this test case. You
> > > can copy the test framework boilerplate from an existing test case.
> >
> > 'du' can't be used like this in qemu-iotests because it makes
> > assumptions that depend on the filesystem. A test case replicating what
> > Nir did manually would likely fail on XFS with its preallocation.
> 
> This is why I did not try to add a new qemu-iotest yet.
> 
> > Maybe we could operate on a file exposed by the FUSE export that is
> > backed by qcow2, and then you can use 'qemu-img map' on that qcow2 image
> > to verify the allocation status. Somewhat complicated, but I think it
> > could work.
> 
> Do we have examples of using the FUSE export? It sounds complicated but
> being able to test on any file system is awesome. The complexity can be
> hidden behind simple test helpers.

We seem to have a few tests that use it, and then the fuse protocol
implementation, too. 308 and file-io-error look relevant.

> Another option is to use a specific file system created for the tests,
> for example on a loop device. We used userstorage[1] in ovirt to test
> on specific file systems with known sector size.

Creating loop devices requires root privileges. If I understand
correctly, userstorage solved that by having a setup phase as root
before running the tests as a normal user? We don't really have that in
qemu-iotests.

Some tests require passwordless sudo and are skipped otherwise, but this
means that in practice they are almost always skipped.

> But more important, are you ok with the change?
> 
> I'm not sure about not creating sparse images by default - this is not
> consistent with qemu-img convert and qemu-nbd, which do sparsify by
> default. The old behavior seems better.

Well, your patches make it do what we always claimed it would do, so
that consistency is certainly a good thing. Unmapping on write_zeroes
and ignoring truncate is a weird combination anyway that doesn't really
make any sense to me, so I don't think it's worth preserving. The other
way around could have been more defensible, but that's not how our bug
works.

Now, if ignoring all discard requests is a good default these days is a
separate question and I'm not sure really. Maybe discard=unmap should
be the default (and apply to both discard are write_zeroes, of course).

Kevin


