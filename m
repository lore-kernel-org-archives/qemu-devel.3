Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF5FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZukq-0005VX-Db; Fri, 02 Aug 2024 12:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZukp-0005Uv-I4
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZukn-0005Hc-9z
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722614620;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MwiiCONDc6Ergp8uJztGzW0f32Hs0jYhWmftK6b37s=;
 b=GcOCuE73Q7ff85Y0fGjhWQmSagdxMzDNsLK1EHGRVow6XAeFSfZ8oo7b0vXgw8Ezhx9+Mb
 OgAa6hMufn4tsgrL0G/sWZLrj2mcZ6E47S5JMLWaFyACPseLKRMpvemoanZ45Z2OdBhFNW
 4MbOBVfNqt6BxRVVFznY+ezSV6Z4Sho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-H4AcFO5pMgy88kkG0aSm6Q-1; Fri,
 02 Aug 2024 12:03:36 -0400
X-MC-Unique: H4AcFO5pMgy88kkG0aSm6Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F350C1944CE4; Fri,  2 Aug 2024 16:03:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BBD919560AA; Fri,  2 Aug 2024 16:03:28 +0000 (UTC)
Date: Fri, 2 Aug 2024 17:03:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v4 00/17] Introduce support for IGVM files
Message-ID: <Zq0DTSvYRRGngPc9@redhat.com>
References: <cover.1720004383.git.roy.hopkins@suse.com>
 <ZqEr-YpjHHM5cT07@redhat.com>
 <826f5161946e4a26f9c1c6a08fdbf826d622d5b2.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <826f5161946e4a26f9c1c6a08fdbf826d622d5b2.camel@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Aug 02, 2024 at 04:57:13PM +0100, Roy Hopkins wrote:
> On Wed, 2024-07-24 at 17:29 +0100, Daniel P. Berrangé wrote:
> > On Wed, Jul 03, 2024 at 12:05:38PM +0100, Roy Hopkins wrote:
> > > Here is v4 of the set of patches to add support for IGVM files to QEMU. This
> > > is
> > > based on commit 1a2d52c7fc of qemu.
> > > 
> > > This version addresses all of the review comments from v3 along with a
> > > couple of
> > > small bug fixes. This is a much smaller increment than in the previous
> > > version
> > > of the series [1]. Thanks once again to the reviewers that have been looking
> > > at
> > > this series. This v4 patch series is also available on github: [2]
> > > 
> > > The previous version had a build issue when building without debug enabled.
> > > Patch 8/17 has been added to fix this and I've updated my own process to
> > > test
> > > both debug and release builds of QEMU.
> > > 
> > > For testing IGVM support in QEMU you need to generate an IGVM file that is
> > > configured for the platform you want to launch. You can use the `buildigvm`
> > > test tool [3] to allow generation of IGVM files for all currently supported
> > > platforms. Patch 11/17 contains information on how to generate an IGVM file
> > > using this tool.
> > 
> > Am I right that, currently, we can only use this IGVM support for plain
> > SEV/SNP boot *without*  SVSM ?  I'm told SVSM has a dependency on host
> > kernel KVM features not yet upstream, and I presume this means also needs
> > further QEMU patches ?
> 
> Yes, you are right in that the host kernel does not yet support SVSM. However,
> I've tried to ensure that the IGVM implementation in QEMU will not require any
> further patches when SVSM support arrives in the kernel. 
> 
> This obviously cannot be guaranteed as it is not clear exactly what the SVSM
> support will look like, but as an example, take a look at
> https://github.com/coconut-svsm/linux/pull/6 which is a kernel branch that
> contains patches to support hosting COCONUT-SVSM which works with this QEMU IGVM
> patch series at V4.

Ah good, I was getting worried for a minute thinking QEMU might need
to do extra KVM ioctl setup tasks to make it work.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


