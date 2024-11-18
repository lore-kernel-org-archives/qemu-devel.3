Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8156D4921B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1SV-0000pr-L4; Mon, 18 Nov 2024 08:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tD1ST-0000pU-7j
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:06:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tD1SR-0008Hr-05
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731935181;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLzHsA5pK8feAMtZoob7PjO2W0dmZ9iC632RmmBe4TE=;
 b=T8jquvzHROpgnFoDtnXRD8vF/IeQTo7VaOq+ahCxizVZxlb6Ab4ZyEv+4XCv3x7qLLSDBr
 alOESSf9tZ6ExNUP055IoDrAWW8dRVs0QUc4o2mjvGtnIaRNJXkl5fN/lIsVcG4Zkz89Ee
 cD9HfEmzCG/9I4Gj814Qtjoe3vg2NuM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-4UXoBUGXO2-3eskFQTkm4A-1; Mon,
 18 Nov 2024 08:06:19 -0500
X-MC-Unique: 4UXoBUGXO2-3eskFQTkm4A-1
X-Mimecast-MFC-AGG-ID: 4UXoBUGXO2-3eskFQTkm4A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52D8519560AB; Mon, 18 Nov 2024 13:06:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BD0F1956089; Mon, 18 Nov 2024 13:06:16 +0000 (UTC)
Date: Mon, 18 Nov 2024 13:06:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: tests/functional is eating disk space
Message-ID: <Zzs7xCN7zlpG74p5@redhat.com>
References: <CAFEAcA8hHMj0718haB_uZhE-LQF4W9PYrL-na0iznp4ueDsq7g@mail.gmail.com>
 <15635bd3-97fa-4c11-9427-c615d1b57dd1@redhat.com>
 <Zzs5hKLic2XU4FBc@redhat.com>
 <c3fcead1-3f3e-41bc-aac9-31a2eb3a8306@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3fcead1-3f3e-41bc-aac9-31a2eb3a8306@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 18, 2024 at 02:01:22PM +0100, Thomas Huth wrote:
> On 18/11/2024 13.56, Daniel P. Berrangé wrote:
> > On Mon, Nov 18, 2024 at 01:10:14PM +0100, Thomas Huth wrote:
> > > On 18/11/2024 11.57, Peter Maydell wrote:
> > > > I just ran out of disk space on my dev machine, because:
> > > > 
> > > > $ du -h build/clang/tests/functional/
> > > > [...]
> > > > 11G     build/clang/tests/functional/
> > > 
> > > That's indeed a lot. I only got 6.9G in my build tree for all targets ... I
> > > guess there are some stale files lying around, so as a temporary mitigation,
> > > just try to delete that folder (it should get recreated the next time you
> > > run the tests).
> > > 
> > > > The new functional tests seem to be eating disk space.
> > > > 
> > > > Even the build tree I have that's just arm targets is 7.1GB.
> > > > 
> > > > Could you have a look at what's happening here?
> > > 
> > > I am aware of the problem and got it on my TODO list already... I think we
> > > best should set the "workdir" to a temporary folder that we can remove once
> > > the test has finished, that will automatically delete all binary assets that
> > > the test created during its runtime.
> > 
> > workdir also stores the logs currently, which we want to preserve, but we
> > can just move assets to a sub-tree instead. Something approx like this:
> 
> Yes, this is pretty much similar to what I had in mind! ... do you maybe
> want to send it as a proper patch?

Sure, I'll test it and then send it.


> > @@ -56,6 +58,8 @@ def setUp(self, bin_prefix):
> >           self.log.addHandler(self._log_fh)
> >       def tearDown(self):
> > +        if not "QEMU_TEST_SKIP_RMTREE" in os.environ:
> 
> I'd maybe call it "QEMU_TEST_KEEP_SCRATCHDIR" instead... but that's just
> bikeshedpainting.

Yes, thats fine

> Anyway, we'd then also need to document the env variable in
> docs/devel/testing/functional.rst, I think.

Ok


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


