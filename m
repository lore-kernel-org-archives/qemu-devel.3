Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB169D13C3E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOwc-00019z-B4; Mon, 26 Jan 2026 10:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vkOwU-00014i-Qp
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vkOwN-0003b9-0y
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769442810;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iox1kQun4RXA/qjl5BnOQ6ng4WgJ+hRB09OuUtTgjg0=;
 b=Ot8mXA0Rxb6ebDxTEVcUHCqEG+Gva7h+WiVOB6Dj/S4TXzsY/pjLf0dEqusOeZgxOLOMgg
 8RTB+Mc16FRdA77Pd2iq9VBv6YQa7e+wcGj/hRLF7tWqICtWIeDOwkf+CtMUJiOSD5EXzz
 hhaoIYOUHw8O/dTcUjbWbzm/syelvHo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-7GZXZAn4MPK5FLNr6nN-_w-1; Mon,
 26 Jan 2026 10:53:26 -0500
X-MC-Unique: 7GZXZAn4MPK5FLNr6nN-_w-1
X-Mimecast-MFC-AGG-ID: 7GZXZAn4MPK5FLNr6nN-_w_1769442804
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 821671944DF2; Mon, 26 Jan 2026 15:53:24 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.149])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCC3D19560B2; Mon, 26 Jan 2026 15:53:21 +0000 (UTC)
Date: Mon, 26 Jan 2026 15:53:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [REPORT] Double deletion of output directory in functional test
Message-ID: <aXeN7nEeOFCchT1E@redhat.com>
References: <aXOGKb88Yho2jb_o@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <652b1544-e008-441d-8d15-b31856b0359d@linux.ibm.com>
 <87h5s8gytr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5s8gytr.fsf@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 26, 2026 at 12:48:00PM -0300, Fabiano Rosas wrote:
> Aditya Gupta <adityag@linux.ibm.com> writes:
> 
> > +harsh
> >
> > On 23/01/26 20:07, Aditya Gupta wrote:
> >
> >> Hello,
> >>
> >> I notice a test failure with ppc64 functional tests, which only occurs when
> >> tests are run in parallel ('make check-functional-ppc64 -j8').
> >>
> >> I believe the issue might be with the generic migration testcase. The following
> >> backtrace happens on error:
> >>
> >> 	Traceback (most recent call last):
> >> 	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 421, in tearDown
> >> 	    super().tearDown()
> >> 	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
> >> 	    shutil.rmtree(self.workdir)
> >> 	  File "/usr/lib64/python3.11/shutil.py", line 742, in rmtree
> >> 	    onerror(os.lstat, path, sys.exc_info())
> >> 	  File "/usr/lib64/python3.11/shutil.py", line 740, in rmtree
> >> 	    orig_st = os.lstat(path, dir_fd=dir_fd)
> >> 	              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> 	FileNotFoundError: [Errno 2] No such file or directory: '<SRC_DIR>/build/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_with_exec/scratch'
> >
> > Git bisect points to this:
> >
> >
> >      f4e34d0fd56c25dd0c90722ed80a83a175160a6c is the first bad commit
> >      commit f4e34d0fd56c25dd0c90722ed80a83a175160a6c
> >      Date:   Fri Jan 9 09:35:19 2026 -0300
> >
> >          tests/functional: Add a OS level migration test for pseries
> >
> 
> I see, the test I added imports PpcMigrationTest which causes it to be
> instantiated by unittest and the setup method races with another test
> that uses the same class. I'll send a patch.

While looking at the issues in mail, I noticed another minor bug in
tests/functional/migration.py.  It is directly using the TemporaryDirectory
class to create a dir for UNIX sockets, when it should use  self.socket_dir()
so we get consistent dir prefixes.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


