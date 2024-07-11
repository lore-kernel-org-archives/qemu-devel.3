Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFDFC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 12:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtBJ-0002nn-3Z; Thu, 11 Jul 2024 08:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRtBB-0002mz-9I
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRtB7-0000ET-7c
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720701939;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tuU1/WvZGOHr844fjHnIAKSVx+ds6+k4Jg+CRbXbYJQ=;
 b=bP/woK+d89rVWFKCriOzMANQOFkSGBX+7WYfrg07x6YG/9t01b9aOFOo1gxgEO2CCP8FB5
 BWkXC9d9YsOAS1x9XPq7D2GDV4fN97mIx4v5kPv3JMbdV0SsVWJ+yA2kgbO9ycLkAw5F0/
 apwM1u7B2VJqVZpoiUhGGJvhZH5sOqM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-M5y1lsMKMfuzG4Rd3coERQ-1; Thu,
 11 Jul 2024 08:45:38 -0400
X-MC-Unique: M5y1lsMKMfuzG4Rd3coERQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAB3F19560B0; Thu, 11 Jul 2024 12:45:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5C8F19560AE; Thu, 11 Jul 2024 12:45:33 +0000 (UTC)
Date: Thu, 11 Jul 2024 13:45:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
Message-ID: <Zo_T6uc_8IRa7obL@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711115546.40859-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 11, 2024 at 01:55:38PM +0200, Thomas Huth wrote:
> The Avocado v88 that we use in QEMU is already on a life support
> system: It is not supported by upstream anymore, and with the latest
> versions of Python, it won't work anymore since it depends on the
> "imp" module that has been removed in Python 3.12.
> 
> There have been several attempts to update the test suite in QEMU
> to a newer version of Avocado, but so far no attempt has successfully
> been merged yet.
> 
> Additionally, the whole "make check" test suite in QEMU is using the
> meson test runner nowadays, so running the python-based tests via the
> Avocodo test runner looks and feels quite like an oddball, requiring
> the users to deal with the knowledge of multiple test runners in
> parallel.

The fewer / simpler the layers we have in the execution path
of tests the better our life will be in debugging IMHO.

Having each individual test registered with meson has the
particularly strong advantage that we can make use of meson's
timeout feature to force individual tests to abort if they
hang/run too slowly, as we did when converting the iotests
to individual meson tests.

> 
> So instead of trying to update the python-based test suite in QEMU
> to a newer version of Avocado, we should maybe try to better integrate
> it with the meson test runner instead. Indeed most tests work quite
> nicely without the Avocado framework already, as you can see with
> this patch series - it does not convert all tests, just a subset since
> it is just an RFC so far, but as you can see, many tests only need
> small modifications to work without Avocado.
> 
> If you want to try it: Apply the patches, make sure that you have the
> "pytest" program installed, then recompile and then run:
> 
>  make check-pytest
> 
> Things that need further attention though:
> 
> - All tests that use the LinuxTest / LinuxDistro classes (e.g. based
>   on cloud-init images) really depend on the Avocado framework,
>   thus we'd need a solution for those if we want to continue with
>   this approach

Right, avocado is providing 2 distinct things, the test execution
harness and the test framework APIs.

It could be valid to remove use of the harness but keep using
the framework APIs, especially if that's sufficient to unblock
updating to new avocado versions too ? Over the longer term
we can consider whether the framework APIs should remain or
be replaced by something else.

> - Same for all tests that require the LinuxSSHMixIn class - we'd
>   need to provide a solution for ssh-based tests, too.
> 
> - We lose the way of running tests via the avocado tags this way...
>   single targets can still be tested by running "make check-pytest-arm"
>   for example, but running selected tests by other tags does not
>   work anymore.

The meson "suites" concept is the logical equivalent of tags.
You've wired up a suite for each architecture. We could define
more suites if there are other useful criteria for filtering
tests to be run. Perhaps machine type ? "make check-pytest-arm-<machine>"

> - I haven't looked into logging yet ... this still needs some work
>   so that you could e.g. inspect the console output of the guests
>   somewhere

Yep, debuggability is probably the single biggest problem we face
with our tests. Simplifying the test execution harness will help
in this respect, but yeah, we must have a way to capture logs
of stuff executed.

> - I did not work on documentation updates yet (will do that if we
>   agree to continue with this patch series)
> 
> What's your thoughts? Is it worth to continue with this approach?
> Or shall I rather forget about it and wait for the Avocado version
> update?



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


