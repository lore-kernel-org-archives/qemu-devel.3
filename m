Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A856C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbCL-00026K-VE; Thu, 15 May 2025 12:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFbC0-0001ud-4o
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFbBw-0001Fi-9U
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747325534;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=f+03C0qHpYv2bqXKgJN1iu3MnRwSFPJv40ItqYcQPyk=;
 b=ceX0M+Pze88J6Qi/RuTS2YGXckRQFRIiEisIZsMqOv0ZEUFiY4dUyAUL7TKntxXq8+e7sO
 P4nA7uCzCbTWuvNVQFcHIkk5FC7P+tPzMV6mwH0CjT73szVcg9jy1fHteAYDtCLsuXNxwi
 aKx/6X+Sc/QRNWWGuhTV07p6i1+PPSw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-VG3p0nEtN1KzMYGzeo2ivA-1; Thu,
 15 May 2025 12:12:10 -0400
X-MC-Unique: VG3p0nEtN1KzMYGzeo2ivA-1
X-Mimecast-MFC-AGG-ID: VG3p0nEtN1KzMYGzeo2ivA_1747325526
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A409F19560AE; Thu, 15 May 2025 16:12:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CC75180087A; Thu, 15 May 2025 16:11:59 +0000 (UTC)
Date: Thu, 15 May 2025 17:11:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Message-ID: <aCYSTHiXtBsjw510@redhat.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-9-zhao1.liu@intel.com>
 <e0146386-ccf4-44ba-b58f-0bb4d3317f89@redhat.com>
 <aCS8aHsF+VAuj01D@intel.com>
 <7dec9c8e-93d6-81f0-b075-e29b8ede44a2@eik.bme.hu>
 <aCXxHEVZb8+ZCW/m@intel.com>
 <c2466a27-8f8a-780d-ff78-491921bb41e5@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2466a27-8f8a-780d-ff78-491921bb41e5@eik.bme.hu>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 15, 2025 at 05:41:40PM +0200, BALATON Zoltan wrote:
> On Thu, 15 May 2025, Zhao Liu wrote:
> > On Wed, May 14, 2025 at 06:24:03PM +0200, BALATON Zoltan wrote:
> > > Date: Wed, 14 May 2025 18:24:03 +0200
> > > From: BALATON Zoltan <balaton@eik.bme.hu>
> > > Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
> > >  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> > > 
> > > On Wed, 14 May 2025, Zhao Liu wrote:
> > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest,
> > > > > > +                                          s390_pv_guest,
> > > > > > +                                          S390_PV_GUEST,
> > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > +                                          { TYPE_USER_CREATABLE },
> > > > > > +                                          { NULL })
> > > > > 
> > > > > I'll note that existing callers of OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> > > > > happily ignore the line limit and put it into a single line.
> > > > > 
> > > > > (which ends up looking better IMHO)
> > > > 
> > > > Ok, I'll onor the existing conventions (which I'll apply to other
> > > > patches as well).
> > > 
> > > There are two line limits. If something is clearer on one line you could
> > > exceed the normal 80 chars and put up to 90 chars on one line for which
> > > checkpatch will issue a warning that can be ignored for these cases. Over 90
> > > lines checkpatch will give an error and I think you should not ignore that.
> > 
> > Thank you. This makes sense!
> > 
> > > Maybe try to put as much on one line as possible instead of new line after
> > > each argument but without exceeding the 80 chars or if the whole line fits
> > > in 90 chars then use that. Or maybe do not indent second line under ( but
> > > with 4 spaces then you can fit it in two lines but lines over 90 chars are
> > > undesirable.
> > 
> > HMM, I understand you mean:
> > 
> > OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest, s390_pv_guest,
> >    S390_PV_GUEST, CONFIDENTIAL_GUEST_SUPPORT, { TYPE_USER_CREATABLE }, { NULL })
> > 
> > The second line is 82 chars and now I think this version is better.
> 
> Yes and maybe can even fit in 80 chars if using { } instead of { NULL }.

Personally, once you have to break the line, I would be inclined
to have *nothing* after the '(' on the first line, and then break
at the list of interfaces. ie

 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(
    S390PVGuest, s390_pv_guest, S390_PV_GUEST, CONFIDENTIAL_GUEST_SUPPORT,
    { TYPE_USER_CREATABLE }, { NULL })
 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


