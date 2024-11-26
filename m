Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD591D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 12:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFuzT-0000g0-Bd; Tue, 26 Nov 2024 07:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFuzL-0000fK-7U
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:48:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFuzH-0005m4-G2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 07:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732625292;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3uDjIOuIBBBmffy6NPeIvifakQpofHlTffpbOUPghE=;
 b=cEwJRURVCNFYDNrCAUUYMEbv+esouPG0gvIx+9TloKy1YPmHoCdOinu2ml6wwSFN9yASOx
 4DpBE8yB5Pes1Fx1QqtfEzvjq9uPebEmBifRakbwnEKgC9aW9XfxomuCTotq1nY7qUlEg8
 FdbhvhA3brtVvjVIVMdsj2SI/CaQ9g0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-aLfjaZgEMuqz30yjQlf4yQ-1; Tue,
 26 Nov 2024 07:48:07 -0500
X-MC-Unique: aLfjaZgEMuqz30yjQlf4yQ-1
X-Mimecast-MFC-AGG-ID: aLfjaZgEMuqz30yjQlf4yQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59CD01955F56; Tue, 26 Nov 2024 12:48:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F36D195E483; Tue, 26 Nov 2024 12:48:02 +0000 (UTC)
Date: Tue, 26 Nov 2024 12:47:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 10/26] target/arm/kvm-rme: Add Realm Personalization
 Value parameter
Message-ID: <Z0XDfyDWc3OZSoj0@redhat.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-12-jean-philippe@linaro.org>
 <87wmgqsbp1.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmgqsbp1.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 26, 2024 at 08:20:42AM +0100, Markus Armbruster wrote:
> Jean-Philippe Brucker <jean-philippe@linaro.org> writes:
> 
> > The Realm Personalization Value (RPV) is provided by the user to
> > distinguish Realms that have the same initial measurement.
> >
> > The user provides up to 64 hexadecimal bytes. They are stored into the
> > RPV in the same order, zero-padded on the right.
> >
> > Cc: Eric Blake <eblake@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Eduardo Habkost <eduardo@habkost.net>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > v2->v3: Fix documentation
> > ---
> >  qapi/qom.json        |  15 ++++++
> >  target/arm/kvm-rme.c | 111 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 126 insertions(+)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index a8beeabf1f..f982850bca 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1068,6 +1068,19 @@
> >    'data': { '*cpu-affinity': ['uint16'],
> >              '*node-affinity': ['uint16'] } }
> >  
> > +##
> > +# @RmeGuestProperties:
> > +#
> > +# Properties for rme-guest objects.
> > +#
> > +# @personalization-value: Realm personalization value, as a 64-byte
> > +#     hex string. This optional parameter allows to uniquely identify
> > +#     the VM instance during attestation. (default: 0)
> 
> QMP commonly uses base64 for encoding binary data.  Any particular
> reason to deviate?
> 
> Is the "hex string" to be mapped to binary in little or big endian?  Not
> an issue with base64.

Agreed, using base64 is preferrable for consistency.

> 
> Nitpick: (default: all-zero), please, for consistency with similar
> documentation in SevSnpGuestProperties.
> 
> > +#
> > +# Since: 9.3

There is never any x.3 version of QEMU, as we bump the major
version once a year. IOW, next release you could target this
for will be 10.0

> > +##
> > +{ 'struct': 'RmeGuestProperties',
> > +  'data': { '*personalization-value': 'str' } }
> >  
> >  ##
> >  # @ObjectType:
> > @@ -1121,6 +1134,7 @@
> >      { 'name': 'pr-manager-helper',
> >        'if': 'CONFIG_LINUX' },
> >      'qtest',
> > +    'rme-guest',
> >      'rng-builtin',
> >      'rng-egd',
> >      { 'name': 'rng-random',
> 
> The commit message claims the patch adds a parameter.  It actually adds
> an entire object type.

The object should be added to qom.json earlier in this series when
the RmeGuest class is defined, then this patch would merely be adding
the parameter.

> 
> > @@ -1195,6 +1209,7 @@
> >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> >                                        'if': 'CONFIG_LINUX' },
> >        'qtest':                      'QtestProperties',
> > +      'rme-guest':                  'RmeGuestProperties',
> >        'rng-builtin':                'RngProperties',
> >        'rng-egd':                    'RngEgdProperties',
> >        'rng-random':                 { 'type': 'RngRandomProperties',

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


