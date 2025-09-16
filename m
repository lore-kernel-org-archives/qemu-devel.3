Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30116CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 09:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyRn9-0006Uw-9f; Tue, 16 Sep 2025 05:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyRml-0006S4-3E
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyRmi-00022T-UJ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758014134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pljsxtslxWvZHzcKRWGZUMd6zpfmezqNzDxWn6v90oM=;
 b=QT+QmgL99PYrSE4HNOiiNdH/3hb89+Y54bTmKutxr+2r0ooiNYlfT/f+cykPSO+2r1yfRy
 mV1DMuhr3zuArUMP9512CmchLB4wDb9tZt1OOmIlnwhBVO7+VcnQafXcNA0SZ4TL8pfByl
 ySkHuGvoMEezeaJW4lkOe4yNB5zCgJI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-aG8IK1uYNRKB9SKCAn5UkQ-1; Tue,
 16 Sep 2025 05:15:25 -0400
X-MC-Unique: aG8IK1uYNRKB9SKCAn5UkQ-1
X-Mimecast-MFC-AGG-ID: aG8IK1uYNRKB9SKCAn5UkQ_1758014123
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 032F61800370; Tue, 16 Sep 2025 09:15:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 071631956056; Tue, 16 Sep 2025 09:15:20 +0000 (UTC)
Date: Tue, 16 Sep 2025 10:15:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 0/2] tests/functional: Adapt reverse_debugging to run
 w/o Avocado (yet another try)
Message-ID: <aMkqpc47sLNxZXFd@redhat.com>
References: <20250915124207.42053-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915124207.42053-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 02:42:05PM +0200, Thomas Huth wrote:
> Here's yet another attempt to remove the avocado dependency from the
> reverse debugging tests: I basically took Gustavo's patches to rework
> tests/functional/reverse_debugging.py, but instead of calling that
> through tests/guest-debug/run-test.py and adding the cumbersome code
> to support additional test execution logic, I kept our normal way of
> running tests via pycotap. Instead, the essential logic for running
> gdb is copied from tests/guest-debug/run-test.py into the new function
> reverse_debug() that then runs gdb directly with using
> tests/functional/reverse_debugging.py as the script.

Something I've not previously realized is that when run via GDB, we are
not honouring the Python version we chose to use with QEMU. GDB is not
actually running the python interpreter binary, instead it has linked to
the libpython.so and runs python code in-process to GDB. Thus the version
of python being used is out of our control, it is whatever the distro
chose to link GDB to. When I look back at how we've handled our min
python, vs what the distros use as system python, I think the constraint
is highly undesirable.

> Marked as an RFC since this still needs some love... The aarch64 test
> seems to work already (after applying the fix for the reverse debug there
> first: https://patchew.org/QEMU/20250603125459.17688-1-1844144@gmail.com/ ),
> but the ppc64 and x86 tests are currently still completely broken.
> Also we currently log into two different folders this way, into
> tests/functional/aarch64/test_reverse_debug.ReverseDebugging_AArch64.test_aarch64_virt
> for the normal outer test, and into
> tests/functional/aarch64/reverse_debugging.ReverseDebugging.test_reverse_debugging
> for the script that is run in gdb ... it's likely ok for the aarch64
> test, but the ppc64 test contains two subtests, so we need to come up
> with a better solution here for the final implementation.

Right, this is one of the things I rather dislike with this, as it is
making debugging much more painful.

In one base.log you just get stdout from gdb with no context of what
commands are run, and in the other base.log you get the logs from the
sub-process. Well at least you would if we fixed the tests to use
self.log, instead of creating a new logger category.

Even with that fixed though, it is very difficult to correlate GDB
output in one log, with GDB commands invoke in the other log, in
order to understand why it is failing in the x86/ppc tests.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


