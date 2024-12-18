Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94840E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwTk-0007W7-5y; Wed, 18 Dec 2024 11:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNwTG-00073h-F3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:00:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNwTE-00089g-KK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734537617;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=s0X84kExHg3oacrlQZ9Uy/VSgjWiPJSewAt63suJqD0=;
 b=TWXtJVHSrlNse2PYRqLyuZpZbZo4CUm1NOjL27Yu8c7Ls7Gk4yNFEDrCO3fG15qFwpl402
 CZ+7uFKKEYlfCJFX5zi4ZBXrbrP5DlB1AgLPFW+Nx71+b/msNQtuC7WfBTLjKFm3Nf9Ia6
 gwJg4y2qkri1eSk8sVaYKOK6EeOaO8Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-OCq_Hcn4PISCDQ-oVXIEzA-1; Wed,
 18 Dec 2024 11:00:15 -0500
X-MC-Unique: OCq_Hcn4PISCDQ-oVXIEzA-1
X-Mimecast-MFC-AGG-ID: OCq_Hcn4PISCDQ-oVXIEzA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A98A1955F2C; Wed, 18 Dec 2024 16:00:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4470A1955F57; Wed, 18 Dec 2024 16:00:11 +0000 (UTC)
Date: Wed, 18 Dec 2024 16:00:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 5/5] tests/functional: Convert the migration avocado
 test
Message-ID: <Z2Lxh22H_ZcdmREg@redhat.com>
References: <20241218131439.255841-1-thuth@redhat.com>
 <20241218131439.255841-6-thuth@redhat.com> <87o719umj5.fsf@suse.de>
 <3399461b-b623-4950-a800-9e244dd10785@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3399461b-b623-4950-a800-9e244dd10785@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 04:51:24PM +0100, Thomas Huth wrote:
> On 18/12/2024 14.51, Fabiano Rosas wrote:
> > Thomas Huth <thuth@redhat.com> writes:
> > 
> > > Now that we've got a find_free_port() function in the functional
> > > test framework, we can convert the migration test, too.
> > > While the original avocado test was only meant to run on aarch64,
> > > ppc64 and x86, we can turn this into a more generic test by now
> > > and run it on all architectures that have a default machine that
> > > ships with a working firmware.
> > 
> > I'd rather drop this test. I haven't looked at it in ages and it has
> > never been useful.
> 
> I think I agree for the scope of the old avocado test - x86, ppc64 and
> aarch64 certainly have better test coverage by the qtest already... but we
> don't have any test coverage for other architectures at all yet, which is
> bad (see below).
> 
> So if you like I can change the patch so that the test is not run on x86,
> ppc64 and aarch64 anymore, just on the other architectures that do not have
> test coverage by the qtest yet?
> 
> > I haven't been following the development of the
> > functional suite so this might not apply this time (fingers crossed),
> > but Python tests have always been a pain to work with.
> 
> Well, one of the motivations with the functional test framework was to
> simplify things. You can now run the individual tests without any test
> runner at all, what makes debugging way easier (see
> docs/devel/testing/functional.rst for details)!
> 
> > About adding more architectures to the set, this is not simply enabling
> > more testing, it is also adding workload to maintain these other arches
> > that were never tested with migration. Is that something we want?
> 
> I think yes. Otherwise the bugs are just dormant until someone hits the
> issue, making bisection way more complicated later.
> Remember this one for example:
> 
>  https://mail.gnu.org/archive/html/qemu-commits/2023-02/msg00030.html
> 
> ?
> 
> It would have been good to have a migration test for alpha in the CI, then
> we could have prevented that bug from being merged.

IIUC, we run the migration-test  qtest for *every* softmmu target.

So, assuming you're referring to alpha guest, we were already
exercising it.

The migration qtest as it exists today is pushing the boundaries of
what a qtest is. I'd actually call the migration qtest a functional
test that happens to use the qtest framework for historical reasons.

The only slight thing that makes it not a functional test is that it
is using a specialized guest, which is just the custom boot sector
that dirties ram.

A true migration functional test is conceptually interesting, as we
have had bugs in the past which only hit when using real guest OS
in certain ways. The trouble is that worst bugs have been pretty
niche, such that its unlikely we would have pre-empatively have
a test combination that would have hit them.


Anyway, I think a true functional test for migration is relevant
to keep, as long as we make it clearly different from the qtest.
A simple smoke test using a real Linux guest is different enough
from our hand crafted boot sector that I think it is valuable
coverage. Even better if we make the functional test add *lots*
of different devices.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


