Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE5FC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyPr-0005gy-Sp; Thu, 06 Feb 2025 04:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfyPl-0005co-Oq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfyPj-0002LD-00
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738834992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=n0D41HcxzuIuMF3Ilv9lg4Eg79loAfwsZ77xrh64FxA=;
 b=TYANMaEw/5QqPazBTwLCcalAC2LUCIRW1Ua/8jg/IEoGocFPe5Ksb1pkNfpy0euR4MqUv5
 UzCYSAD6Nn3cCdLxJfN4PH6t7GRD/fk/tmCFA8+OoT1z0UiiXYvRf5B3ycMkBgr4gwfh0b
 ZspUHGC/OI06joNdbBxSU0fLBRZufK4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-0FhaY-lBNee7YywCtJKvEg-1; Thu,
 06 Feb 2025 04:43:11 -0500
X-MC-Unique: 0FhaY-lBNee7YywCtJKvEg-1
X-Mimecast-MFC-AGG-ID: 0FhaY-lBNee7YywCtJKvEg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FE0B1800871; Thu,  6 Feb 2025 09:43:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F2BE19560A3; Thu,  6 Feb 2025 09:43:02 +0000 (UTC)
Date: Thu, 6 Feb 2025 09:42:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
Message-ID: <Z6SEIqhJEWrMWTU1@redhat.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-4-zhao1.liu@intel.com>
 <87zfj01z8x.fsf@pond.sub.org> <Z6SG2NLxxhz4adlV@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6SG2NLxxhz4adlV@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 06, 2025 at 05:54:32PM +0800, Zhao Liu wrote:
> On Wed, Feb 05, 2025 at 11:07:10AM +0100, Markus Armbruster wrote:
> > Date: Wed, 05 Feb 2025 11:07:10 +0100
> > From: Markus Armbruster <armbru@redhat.com>
> > Subject: Re: [RFC v2 3/5] i386/kvm: Support event with select & umask
> >  format in KVM PMU filter
> > 
> > Zhao Liu <zhao1.liu@intel.com> writes:
> > 
> > > The select&umask is the common way for x86 to identify the PMU event,
> > > so support this way as the "x86-default" format in kvm-pmu-filter
> > > object.
> > 
> > So, format 'raw' lets you specify the PMU event code as a number, wheras
> > 'x86-default' lets you specify it as select and umask, correct?
> 
> Yes!
> 
> > Why do we want both?
> 
> This 2 formats are both wildly used in x86(for example, in perf tool).
> 
> x86 documents usually specify the umask and select fields.
> 
> But raw format could also be applied for ARM since ARM just uses a number
> to encode event.
> 
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > 
> > [...]
> > 
> > > diff --git a/qapi/kvm.json b/qapi/kvm.json
> > > index d51aeeba7cd8..93b869e3f90c 100644
> > > --- a/qapi/kvm.json
> > > +++ b/qapi/kvm.json
> > > @@ -27,11 +27,13 @@
> > >  #
> > >  # @raw: the encoded event code that KVM can directly consume.
> > >  #
> > > +# @x86-default: standard x86 encoding format with select and umask.
> > 
> > Why is this named -default?
> 
> Intel and AMD both use umask+select to encode events, but this format
> doesn't have a name... so I call it `default`, or what about
> "x86-umask-select"?
> 
> > > +#
> > >  # Since 10.0
> > >  ##
> > >  { 'enum': 'KVMPMUEventEncodeFmt',
> > >    'prefix': 'KVM_PMU_EVENT_FMT',
> > > -  'data': ['raw'] }
> > > +  'data': ['raw', 'x86-default'] }
> > >  
> > >  ##
> > >  # @KVMPMURawEvent:
> > > @@ -46,6 +48,25 @@
> > >  { 'struct': 'KVMPMURawEvent',
> > >    'data': { 'code': 'uint64' } }
> > >  
> > > +##
> > > +# @KVMPMUX86DefalutEvent:
> > 
> > Default, I suppose.
> 
> Thanks!
> 
> > > +#
> > > +# x86 PMU event encoding with select and umask.
> > > +# raw_event = ((select & 0xf00UL) << 24) | \
> > > +#              (select) & 0xff) | \
> > > +#              ((umask) & 0xff) << 8)
> > 
> > Sphinx rejects this with "Unexpected indentation."
> > 
> > Is the formula needed here?
> 
> I tried to explain the relationship between raw format and umask+select.
> 
> Emm, where do you think is the right place to put the document like
> this?
> 
> ...
> 
> > > +##
> > > +# @KVMPMUX86DefalutEventVariant:

Typo   s/Defalut/Default/ - repeated many times in this patch.

> > > +#
> > > +# The variant of KVMPMUX86DefalutEvent with the string, rather than
> > > +# the numeric value.
> > > +#
> > > +# @select: x86 PMU event select field.  This field is a 12-bit
> > > +#     unsigned number string.
> > > +#
> > > +# @umask: x86 PMU event umask field. This field is a uint8 string.
> > 
> > Why are these strings?  How are they parsed into numbers?
> 
> In practice, the values associated with PMU events (code for arm, select&
> umask for x86) are often expressed in hexadecimal. Further, from linux
> perf related information (tools/perf/pmu-events/arch/*/*/*.json), x86/
> arm64/riscv/nds32/powerpc all prefer the hexadecimal numbers and only
> s390 uses decimal value.
> 
> Therefore, it is necessary to support hexadecimal in order to honor PMU
> conventions.

IMHO having a data format that matches an arbitrary external tool is not
a goal for QMP. It should be neutral and exclusively use the normal JSON
encoding, ie base-10 decimal. Yes, this means a user/client may have to
convert from hex to dec before sending data over QMP. This is true of
many areas of QMP/QEMU config though and thus normal/expected behaviour.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


