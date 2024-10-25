Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4082AD0C5E6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 08:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Fyv-0005Km-FJ; Fri, 25 Oct 2024 04:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Fyt-0005KM-D6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Fyr-0005OH-JU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 04:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729846056;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uq3IhbU/yTH35/LWnljdNAvMNphm8dLQb3bhxKZeres=;
 b=iArG9Nxe5QhuB0f84BZ9KCVIg4DJBc9QBiDuJnZ6wXGpGWmX1ag9Cz2Aqh/Vht5Far58YE
 znrAEiMUBOiqGnBZcls1M1nYkVCw+EHdpArMVjOuitJpJNUprIu7uq4D6AZOpTo+JDjeBB
 NIFjfCOtfDnEspXPhKq6P/SGpSy/4eY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-Rz_weTKJOKilYDlrRF0BeQ-1; Fri,
 25 Oct 2024 04:47:35 -0400
X-MC-Unique: Rz_weTKJOKilYDlrRF0BeQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA65119560B5; Fri, 25 Oct 2024 08:47:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B01E19560A2; Fri, 25 Oct 2024 08:47:31 +0000 (UTC)
Date: Fri, 25 Oct 2024 09:47:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] test: make cached assets for functional tests read-only
Message-ID: <ZxtbIE6Xgp48_j8S@redhat.com>
References: <20241021123633.1391911-1-berrange@redhat.com>
 <610dc78f-2546-4dd8-95d2-e449c107bb67@redhat.com>
 <7b2e2801-ee8b-4e37-93a6-349fac361c14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b2e2801-ee8b-4e37-93a6-349fac361c14@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Fri, Oct 25, 2024 at 09:47:07AM +0200, Thomas Huth wrote:
> On 21/10/2024 17.02, Thomas Huth wrote:
> > On 21/10/2024 14.36, Daniel P. Berrangé wrote:
> > > This ensures that if a functional test runs QEMU with a writable
> > > disk pointing to a cached asset, an error will be reported, rather
> > > than silently modifying the cache file.
> > > 
> > > As an example, tweaking test_sbsaref.py to set snapshot=off,
> > > results in a clear error:
> > > 
> > >    Command: ./build/qemu-system-aarch64 ...snip... -drive
> > > file=/var/home/ berrange/.cache/qemu/ download/44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461,format=raw,snapshot=off
> > > -cpu max,pauth=off
> > >    Output: qemu-system-aarch64: Could not open
> > > '/var/home/berrange/.cache/ qemu/ download/44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461':
> > > Permission denied
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >   tests/functional/qemu_test/asset.py | 3 +++
> > >   1 file changed, 3 insertions(+)
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Tested-by: Thomas Huth <thuth@redhat.com>
> 
> Actually, if you start with a clean cache, or if you manually do:
> 
>  chmod a-w ~/.cache/qemu/download/*
> 
> a couple of tests are failing now. Could you please have a look?

Oooh, I thought I tested with all targets enabled, but I guess I must
have missed something.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


