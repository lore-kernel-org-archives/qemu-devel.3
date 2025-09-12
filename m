Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35C5CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3qL-0001lB-S5; Fri, 12 Sep 2025 09:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux3qJ-0001kj-L8
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux3qC-0002P8-4x
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757683765;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2kql92xQbiJeC3eElGHRHFYne2lK2BEArmk8qpku95g=;
 b=UsCQQLTyV6qrNJlv6n2rThyHDDkPPPfVanoWMD+fnSWpHFqOuSj11wsb5P7mtlD6w7Xf9k
 XoZIiO704T94t8KyQ8oAyjzlZbsyb4g+wA6l3U83jys/EMgNiUIhgziSHNlBdwVx7Ekcet
 e5B83WRuaUaJJE5jIGRiw3AW6pkf7Bo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-KTnxmm98Mde--EHCh73hlQ-1; Fri,
 12 Sep 2025 09:29:23 -0400
X-MC-Unique: KTnxmm98Mde--EHCh73hlQ-1
X-Mimecast-MFC-AGG-ID: KTnxmm98Mde--EHCh73hlQ_1757683762
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C26B11955EAC; Fri, 12 Sep 2025 13:29:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFE9F18003FC; Fri, 12 Sep 2025 13:29:19 +0000 (UTC)
Date: Fri, 12 Sep 2025 14:29:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 roy.hopkins@randomman.co.uk
Subject: Re: [PATCH] igvm: add initial support for non-cc firmware in igvm
 format
Message-ID: <aMQgLMnz2YD6Tlo_@redhat.com>
References: <20250709123007.1039675-1-kraxel@redhat.com>
 <ub32mvhexl7ppqwzie53ztfnplamfsl6ahrlwlirvno56es36s@m6ozo7p4ao2j>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ub32mvhexl7ppqwzie53ztfnplamfsl6ahrlwlirvno56es36s@m6ozo7p4ao2j>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 03:25:08PM +0200, Gerd Hoffmann wrote:
> On Wed, Jul 09, 2025 at 02:30:07PM +0200, Gerd Hoffmann wrote:
> > Implement a ConfidentialGuestSupportClass for non-confidential VMs.
> > This allows the igvm support code work without sev/tdx.
> > 
> > RfC: Not fully sure this is the best way to implement this.
> > Alternatively we could add this directly into the igvm backend and run
> > it in case no confidential guest support object is present.
> 
> Started to look at this again.  Noticed that at least simple native
> igvm files (with memory regions only) boot just fine without an
> ConfidentialGuestSupportClass.  Which kind-of underlines that going for
> a pseudo-ConfidentialGuestSupportClass for native mode is maybe not the
> best design idea ...
> 
> Nevertheless we'll go need target-specific code for some IGVM features.
> That is obviously the case for loading some custom initial CPU state.
> But also things like the memory map are not the same across targets,
> even though some targets might share an implementation (e820 on x86,
> fdt elsewhere).
> 
> Suggestions how to wire that up best?

I'm not familiar with the details of IGVM wrt varying technologies.
Consider that x86 can boot a guest non-confidential, SEV-SNP or TDX.
Do we have a single IGVM file that provides enough data for all
three scenarios, or does each deployment technology need a separate
IGVM file to be provided ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


