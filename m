Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734CFC3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAUK-0005yj-Mk; Wed, 30 Apr 2025 12:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uAATn-0005qj-O4
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uAATg-0000vQ-4d
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746031206;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+OUqpisuuZ80svS9YCGtrW1ZvvCotPcAHhrT3jPQe0=;
 b=IYmPfTjTWLJhVZulIXFjjtqMZXFA/cSsGplf8k5D+EAL8TnXc7UeN67zUzeI7rACTWqm+P
 JTOtf4BA8jjw6OVfgRvEUC0Azo3bMMV6/yk8HCVnIbR2pb+tJ6rXiPGcxc/usTUbqJnInK
 BBaKVUFq4Wz6kStO9hRqyd96IeKEtkA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-i6AVBgQJP92XQ8gSvZcixg-1; Wed,
 30 Apr 2025 12:40:04 -0400
X-MC-Unique: i6AVBgQJP92XQ8gSvZcixg-1
X-Mimecast-MFC-AGG-ID: i6AVBgQJP92XQ8gSvZcixg_1746031204
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE53B1956078; Wed, 30 Apr 2025 16:40:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7EF81800871; Wed, 30 Apr 2025 16:40:02 +0000 (UTC)
Date: Wed, 30 Apr 2025 17:39:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Functional tests precache behaviour
Message-ID: <aBJSX6kcYQVM2hp7@redhat.com>
References: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
 <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
 <6e9a3cb3-e238-48a7-a67c-c95b36a517bc@linaro.org>
 <aBJJqtzQaTH_xcKK@redhat.com>
 <efbaccd1-9ef2-4aed-88ed-d6a2bcb7902b@linaro.org>
 <aBJP-_KJudesY_Pk@redhat.com>
 <f8ca0b3f-5a9a-4182-b0e0-352a90bd9374@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8ca0b3f-5a9a-4182-b0e0-352a90bd9374@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

On Wed, Apr 30, 2025 at 09:34:10AM -0700, Pierrick Bouvier wrote:
> On 4/30/25 9:29 AM, Daniel P. Berrangé wrote:
> > On Wed, Apr 30, 2025 at 09:21:41AM -0700, Pierrick Bouvier wrote:
> > > On 4/30/25 9:02 AM, Daniel P. Berrangé wrote:
> > > > On Wed, Apr 30, 2025 at 08:48:59AM -0700, Pierrick Bouvier wrote:
> > > > > On 4/30/25 8:00 AM, Thomas Huth wrote:
> > > > > > On 30/04/2025 16.34, Pierrick Bouvier wrote:
> > > > > > > Hi folks,
> > > > > > > 
> > > > > > > $ ninja -C build precache-functional
> > > > > > > 2025-04-30 07:23:20,382 - qemu-test - ERROR - Unable to download https://
> > > > > > > archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
> > > > > > > gzimg/armv7.img.gz: HTTP error 503
> > > > > > > 2025-04-30 07:23:23,131 - qemu-test - ERROR - Unable to download https://
> > > > > > > archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
> > > > > > > gzimg/armv7.img.gz: HTTP error 503
> > > > > > > 2025-04-30 07:23:25,870 - qemu-test - ERROR - Unable to download https://
> > > > > > > archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
> > > > > > > gzimg/armv7.img.gz: HTTP error 503
> > > > > > > 2025-04-30 07:23:25,871 - qemu-test - ERROR - https://archive.netbsd.org/
> > > > > > > pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz:
> > > > > > > Download retries exceeded: skipping asset precache
> > > > > > > $ echo $?
> > > > > > > 0
> > > > > > > 
> > > > > > > Since we silently skip the asset precaching, how can we identify that an
> > > > > > > asset is not available anymore (temporarily or not)?
> > > > > > > Should we rely on test itself failing when trying to download again this asset?
> > > > > > 
> > > > > > The current logic fails hard for 404 errors, so if the asset is completely
> > > > > > gone, we should notice it. For other error codes, we assume that it is only
> > > > > > a temporary server problem that will hopefully be fixed on the server side
> > > > > > sooner or later.
> > > > > > 
> > > > > 
> > > > > Sounds good.
> > > > > Should we replicate this semantic when running the test itself?
> > > > > It would be more useful to skip it because an asset is missing instead of
> > > > > reporting an error, except if it's a 404 error.
> > > > 
> > > > The tests already gracefully skip if one or more required assets
> > > > are not available. See the 'setUp' method of QemuBaseTest
> > > > 
> > > >           if not self.assets_available():
> > > >               self.skipTest('One or more assets is not available')
> > > > 
> > > > 
> > > > In the 404 case, the pre-cache step should fail and thus we shouldn't
> > > > even get to running the test.
> > > > 
> > > 
> > > This is not the behaviour I observe (error, with server returning 503) [1],
> > > thus my original email.
> > > 
> > > Maybe something is missing in the associated test, or in our test
> > > infrastructure?
> > > 
> 
> Or... in my command :)
> 
> > > Nothing funky in the command line used, you can reproduce it with:
> > > $ rm -rf ~/.cache/qemu build/
> > > $ ./configure
> > > $ ./build/pyvenv/bin/meson test -C build --setup thorough --suite func-quick
> > > --suite func-thorough -t 5 --print-errorlogs func-ppc-ppc_40p
> > 
> > Oh, you're running meson test directly.
> > 
> > The behaviour I describe is wrt the official way of running tests via
> > 'make check' or 'make check-functional'.
> > 
> > When you use 'make', we set 'QEMU_TEST_NO_DOWNLOAD=1' when the tests
> > themselves are run, so only the 'make precache-functional' will be
> > permitted to try downloading.
> > 
> 
> Oh thanks, that's what I was missing!
> 
> I'm running meson because the Makefile wrapper does not allow to pass any
> additional parameters, or running specific test.

FWIW, if you want to run a specific test, personally don't use meson
or make, as you can just invoke the file directly:

 $ QEMU_TEST_QEMU_BINARY=./build/qemu-system-x86_64 \
   PYTHONPATH=./python \
   ./tests/functional/test_x86_cpu_model_versions.py 

This was the key feature I wanted when we replaced avocado, as debugging
tests without a harness getting in the way is much simpler

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


