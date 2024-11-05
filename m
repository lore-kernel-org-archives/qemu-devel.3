Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5796FD12692
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8I9X-0006b0-JC; Tue, 05 Nov 2024 06:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8I9V-0006Ry-MO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:55:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8I9T-0002Ec-M5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730807714;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbGyVdIM0bilx3FdtiaVh2tHO0JsOM+LxjXtPCL7FKo=;
 b=h1/svvZoNCqwKvzzJDg9+PaDNWr7/xB9zComp86fVjApWiji11nLucLFq6f5p6NjOQlEF6
 SWWNkvpzKM31Xx5LdhOmrqpHMT8SkMaBnYAHPRLvVao79Dw38Pe6h6AcGtVQgdaQllXc/n
 dQCPfjAFyiLMZbQddfyyj48wGoJHCVY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-75U2yIvnMamJ_vNCKkpwRQ-1; Tue,
 05 Nov 2024 06:55:10 -0500
X-MC-Unique: 75U2yIvnMamJ_vNCKkpwRQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94FA2195608F; Tue,  5 Nov 2024 11:55:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36011300018D; Tue,  5 Nov 2024 11:54:59 +0000 (UTC)
Date: Tue, 5 Nov 2024 11:54:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 13/60] i386/tdx: Validate TD attributes
Message-ID: <ZyoHkCyknQZTeISs@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-14-xiaoyao.li@intel.com>
 <Zyn1Jhxr8ip0lIcs@redhat.com>
 <7fbf9071-493a-4929-afaa-d0a669346f17@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fbf9071-493a-4929-afaa-d0a669346f17@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Tue, Nov 05, 2024 at 07:53:57PM +0800, Xiaoyao Li wrote:
> On 11/5/2024 6:36 PM, Daniel P. Berrangé wrote:
> > On Tue, Nov 05, 2024 at 01:23:21AM -0500, Xiaoyao Li wrote:
> > > Validate TD attributes with tdx_caps that fixed-0 bits must be zero and
> > > fixed-1 bits must be set.
> > > 
> > > Besides, sanity check the attribute bits that have not been supported by
> > > QEMU yet. e.g., debug bit, it will be allowed in the future when debug
> > > TD support lands in QEMU.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > > 
> > > ---
> > > Changes in v3:
> > > - using error_setg() for error report; (Daniel)
> > > ---
> > >   target/i386/kvm/tdx.c | 28 ++++++++++++++++++++++++++--
> > >   1 file changed, 26 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> > > index 6cf81f788fe0..5a9ce2ada89d 100644
> > > --- a/target/i386/kvm/tdx.c
> > > +++ b/target/i386/kvm/tdx.c
> > > @@ -20,6 +20,7 @@
> > >   #include "kvm_i386.h"
> > >   #include "tdx.h"
> > > +#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
> > >   #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
> > >   #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
> > >   #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
> > > @@ -141,13 +142,33 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
> > >       return KVM_X86_TDX_VM;
> > >   }
> > > -static void setup_td_guest_attributes(X86CPU *x86cpu)
> > > +static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
> > > +{
> > > +    if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
> > > +            error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
> > > +                       "(supported: 0x%llx)",
> > > +                       tdx->attributes, tdx_caps->supported_attrs);
> > > +            return -1;
> > 
> > Minor whitespace accident, with indentation too deep.
> 
> Good catch!
> 
> btw, how did you catch it? any tool like checkpatch.pl or just by your eyes?

Nah, I just notice the mis-alignment when reading the patches.

> 
> > > +    }
> > > +
> > > +    if (tdx->attributes & TDX_TD_ATTRIBUTES_DEBUG) {
> > > +        error_setg(errp, "Current QEMU doesn't support attributes.debug[bit 0] "
> > > +                         "for TDX VM");
> > > +        return -1;
> > > +    }
> > > +
> > > +    return 0;
> > > +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


