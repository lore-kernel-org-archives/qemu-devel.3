Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA7DD767D8
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 15:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6XYw-0000hJ-1w; Thu, 31 Oct 2024 11:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6XYu-0000gm-63
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6XYs-0006im-3q
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730390292;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05NNA//5SrjxtfS8Q+J3PZZuqlTVC6E42OAJmltZxCE=;
 b=h+GVaSvso7DE3/iPRvU+2dQABNT2EzpcmePHelrnPfnpAwWw8Mu/5st7M2SmbUJct+krM5
 o/UIKc6Dl0zMYtSFDlxrAHDpqrT/NjxYjg2yBwlbi8nqFgsMBPtXgNh4P6ZQV8DCug1/Zf
 K1tP41ZQAeXf2PXZ8ATndEiXsdqcDsQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-bX8kGMBjNiyy0ZNrg0RbNQ-1; Thu,
 31 Oct 2024 11:58:07 -0400
X-MC-Unique: bX8kGMBjNiyy0ZNrg0RbNQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A97A1955F68; Thu, 31 Oct 2024 15:58:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14C5F300018D; Thu, 31 Oct 2024 15:58:00 +0000 (UTC)
Date: Thu, 31 Oct 2024 15:57:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 0/7] QOM: Singleton interface
Message-ID: <ZyOpBR7unllm1-0K@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
 <ZyJ1zJoOaLuNHPI-@redhat.com> <ZyKEGIQzVZ7c1OTV@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyKEGIQzVZ7c1OTV@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Oct 30, 2024 at 03:08:08PM -0400, Peter Xu wrote:
> On Wed, Oct 30, 2024 at 06:07:08PM +0000, Daniel P. Berrangé wrote:
> > On Tue, Oct 29, 2024 at 05:16:00PM -0400, Peter Xu wrote:
> > > v1: https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com
> > > 
> > > This patchset introduces the singleton interface for QOM.  I didn't add a
> > > changelog because there're quite a few changes here and there, plus new
> > > patches.  So it might just be easier to re-read, considering the patchset
> > > isn't large.
> > > 
> > > I switched v2 into RFC, because we have reviewer concerns (Phil and Dan so
> > > far) that it could be error prone to try to trap every attempts to create
> > > an object.  My argument is, if we already have abstract class, meanwhile we
> > > do not allow instantiation of abstract class, so the complexity is already
> > > there.  I prepared patch 1 this time to collect and track all similar
> > > random object creations; it might be helpful as a cleanup on its own to
> > > deduplicate some similar error messages.  Said that, I'm still always open
> > > to rejections to this proposal.
> > > 
> > > I hope v2 looks slightly cleaner by having not only object_new_allowed()
> > > but also object_new_or_fetch().
> > 
> > For me, that doesn't really make it much more appealing. Yes, we already have
> > an abstract class, but that has narrower impact, as there are fewer places
> > in which which we can trigger instantiation of an abstract class, than
> > where we can trigger instantiation of arbitrary objects and devices.
> 
> There should be exactly the same number of places that will need care for
> either abstract or singleton.  I tried to justify this with patch 1.
> 
> I still think patch 1 can be seen as a cleanup too on its own (dedups the
> same "The class is abstract" error message), tracking random object
> creations so logically we could have the idea on whether a class can be
> instantiated at all, starting with abstract class.

I think patch 1 might be incomplete, as I'm not seeing what checks
for abstract or singleton classes in the 'qdev_new' code paths, used
by -device / device_add QMP. This is an example of the risks of adding
more failure scenarios to object_add.

> > NB, my view point would have been different if  'object_new' had an
> > "Error *errp" parameter. That would have made handling failure a
> > standard part of the design pattern for object construction, thus
> > avoiding adding asserts in the 'object_new' codepath which could be
> > triggered by unexpected/badly validated user input.
> 
> Yes I also wished object_new() can take an Error** when I started working
> on it.  It would make this much easier, indeed.  I suppose we don't need
> that by not allowing instance_init() to fail at all, postponing things to
> realize().  I suppose that's a "tactic" QEMU chose explicitly to make it
> easy that object_new() callers keep like before with zero error handling
> needed.  At least for TYPE_DEVICE it looks all fine if all such operations
> can be offloaded into realize().  I'm not sure user creatable has those
> steps also because of this limitation.
> 
> I was trying to do that with object_new_allowed() here instead, whenever it
> could be triggered by an user input.  We could have an extra layer before
> reaching object_new() to guard any user input, and I think
> object_new_allowed() could play that role.  When / If we want to introduce
> Error** to object_new() some day (or a variance of it), we could simply
> move object_new_allowed() into it.

Yes, having thought about this today, I came up with a way that we could
introduce a object_new_dynamic() variant with "Error *errp" instead of
asserts, and *crucially* force its use in the unsafe scenarios. ie any
place that is not passing a const,static string.  I've CC'd you on an
RFC series that mocks up this idea. That would be sufficient to remove
my objections wrt the singleton concept.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


