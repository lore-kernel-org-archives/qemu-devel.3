Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D4CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 09:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlDG-0000Oh-In; Thu, 27 Jun 2024 05:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMlDB-0000O6-R4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 05:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMlD9-0007Sm-VA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 05:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719479674;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TZM2C7Bu+3h6O1W7k9XuzFQ2gjmFwO5uohT8V00BBQ4=;
 b=ORcFoIEtWQponVc3QUOT4fthtmDxU6Z4ttqPLNMyPxhfPlYe7wdc/MbTI3qzgBy+4LRrum
 3/CZsYG7HBnVvYa3li6bgZic9pfeYnpxUSs8K8cInAw9r8L72XPBPVc2rQPb9KC4HGhg/N
 RJLhnj24s3iw4arc6VTtN87gpDKInc8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-WCoG-1gnMJWozpz6CETn_A-1; Thu,
 27 Jun 2024 05:14:31 -0400
X-MC-Unique: WCoG-1gnMJWozpz6CETn_A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BA61955E7E; Thu, 27 Jun 2024 09:14:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1BEA19560AA; Thu, 27 Jun 2024 09:14:21 +0000 (UTC)
Date: Thu, 27 Jun 2024 10:14:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Roy Hopkins <roy.hopkins@suse.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v3 03/15] backends/igvm: Add IGVM loader and configuration
Message-ID: <Zn0taV-uq0MlSalm@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <31e19ee36bdbf0ba91d95bc2d71865d7d0007ff1.1718979106.git.roy.hopkins@suse.com>
 <jyfhkynory4jydxrlx7cfvbrnibq2klk5lekn656gcob4kls6m@3u7qugxmxjsq>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jyfhkynory4jydxrlx7cfvbrnibq2klk5lekn656gcob4kls6m@3u7qugxmxjsq>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

On Thu, Jun 27, 2024 at 11:06:50AM +0200, Stefano Garzarella wrote:
> On Fri, Jun 21, 2024 at 03:29:06PM GMT, Roy Hopkins wrote:
> > Adds an IGVM loader to QEMU which processes a given IGVM file and
> > applies the directives within the file to the current guest
> > configuration.
> > 
> > The IGVM loader can be used to configure both confidential and
> > non-confidential guests. For confidential guests, the
> > ConfidentialGuestSupport object for the system is used to encrypt
> > memory, apply the initial CPU state and perform other confidential guest
> > operations.
> > 
> > The loader is configured via a new IgvmCfg QOM object which allows the
> > user to provide a path to the IGVM file to process.
> > 
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > qapi/qom.json             |  16 +
> > backends/igvm.h           |  37 ++
> > include/sysemu/igvm-cfg.h |  54 +++
> > backends/igvm-cfg.c       |  66 ++++
> > backends/igvm.c           | 791 ++++++++++++++++++++++++++++++++++++++
> > backends/meson.build      |   2 +
> > 6 files changed, 966 insertions(+)
> > create mode 100644 backends/igvm.h
> > create mode 100644 include/sysemu/igvm-cfg.h
> > create mode 100644 backends/igvm-cfg.c
> > create mode 100644 backends/igvm.c
> > 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 8bd299265e..e586707c4c 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -874,6 +874,18 @@
> >   'base': 'RngProperties',
> >   'data': { '*filename': 'str' } }
> > 
> > +##
> > +# @IgvmCfgProperties:
> > +#
> > +# Properties common to objects that handle IGVM files.
> > +#
> > +# @file: IGVM file to use to configure guest (default: none)
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'IgvmCfgProperties',
> > +  'data': { '*file': 'str' } }
> 
>     'if': 'CONFIG_IGVM'
> 
> I recently did a similar modification to QAPIs and Markus suggested to add
> the if here as well, see
> https://lore.kernel.org/qemu-devel/87zfs2z7jo.fsf@pond.sub.org/

Yes, it avoids the code generator emitting an otherwise unusd
struct when CONFIG_IGVM is unset.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


