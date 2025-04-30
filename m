Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D942DC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA9vN-0006P3-2P; Wed, 30 Apr 2025 12:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uA9tm-0004QP-II
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uA9ti-0003Hd-TU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746028976;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QdZNS+moj1pIDwBZhjpZlxInzDaBkSBSJxCtFzdDxjs=;
 b=d6LIgQrhxfdXihBUav6CnRk4obhbQaOZyIApY69U7xKXPIEiO2iOFcB6hOwf02VF/T6FSK
 /skCJzLS0VmOpguQgHLZTQ0Hx6lxsSHeA83j+kiqKe/48rBk5yULGTMH2gtzLAc05DZMJ+
 n1Qf6q+gQeb7stJzczy/sXqfhvAzalw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-SvJv5-DgNBaYxmMkuySQ_A-1; Wed,
 30 Apr 2025 12:02:54 -0400
X-MC-Unique: SvJv5-DgNBaYxmMkuySQ_A-1
X-Mimecast-MFC-AGG-ID: SvJv5-DgNBaYxmMkuySQ_A_1746028974
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C3D71955DE7; Wed, 30 Apr 2025 16:02:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A32D19560A3; Wed, 30 Apr 2025 16:02:52 +0000 (UTC)
Date: Wed, 30 Apr 2025 17:02:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Functional tests precache behaviour
Message-ID: <aBJJqtzQaTH_xcKK@redhat.com>
References: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
 <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
 <6e9a3cb3-e238-48a7-a67c-c95b36a517bc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e9a3cb3-e238-48a7-a67c-c95b36a517bc@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Apr 30, 2025 at 08:48:59AM -0700, Pierrick Bouvier wrote:
> On 4/30/25 8:00 AM, Thomas Huth wrote:
> > On 30/04/2025 16.34, Pierrick Bouvier wrote:
> > > Hi folks,
> > > 
> > > $ ninja -C build precache-functional
> > > 2025-04-30 07:23:20,382 - qemu-test - ERROR - Unable to download https://
> > > archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
> > > gzimg/armv7.img.gz: HTTP error 503
> > > 2025-04-30 07:23:23,131 - qemu-test - ERROR - Unable to download https://
> > > archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
> > > gzimg/armv7.img.gz: HTTP error 503
> > > 2025-04-30 07:23:25,870 - qemu-test - ERROR - Unable to download https://
> > > archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
> > > gzimg/armv7.img.gz: HTTP error 503
> > > 2025-04-30 07:23:25,871 - qemu-test - ERROR - https://archive.netbsd.org/
> > > pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz:
> > > Download retries exceeded: skipping asset precache
> > > $ echo $?
> > > 0
> > > 
> > > Since we silently skip the asset precaching, how can we identify that an
> > > asset is not available anymore (temporarily or not)?
> > > Should we rely on test itself failing when trying to download again this asset?
> > 
> > The current logic fails hard for 404 errors, so if the asset is completely
> > gone, we should notice it. For other error codes, we assume that it is only
> > a temporary server problem that will hopefully be fixed on the server side
> > sooner or later.
> > 
> 
> Sounds good.
> Should we replicate this semantic when running the test itself?
> It would be more useful to skip it because an asset is missing instead of
> reporting an error, except if it's a 404 error.

The tests already gracefully skip if one or more required assets
are not available. See the 'setUp' method of QemuBaseTest

        if not self.assets_available():
            self.skipTest('One or more assets is not available')


In the 404 case, the pre-cache step should fail and thus we shouldn't
even get to running the test.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


