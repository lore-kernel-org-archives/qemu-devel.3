Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7FC606A335
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XMBvEe3c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTc4F-0007DH-09; Wed, 18 Nov 2026 04:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xTc4E-0007D8-82
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 04:35:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xTc4C-0004HF-P8
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 04:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794994497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJHCfyCIcMHjIF7lpJa74JFNqYRTFxjdv8nfJkW0BBA=;
 b=XMBvEe3cyIuauDbJw2IY/l7tRT9xjnKnTnGnFJRtGsTtHq2tnSsEEkulVfMzPF3/Ummkux
 bh5BmnueyDh7KmserKDAzmncfc9nfGhQbuhImxPD4g9v0ERFRjUs8zo4Uo2Lkp4an4F01o
 /oGcuLVbCG8kXEDKcrx2QPBvB4Kf+/g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-o2dBQ9AyMZmczMm9og1ZYA-1; Wed,
 18 Nov 2026 04:34:56 -0500
X-MC-Unique: o2dBQ9AyMZmczMm9og1ZYA-1
X-Mimecast-MFC-AGG-ID: o2dBQ9AyMZmczMm9og1ZYA_1794994495
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3749C1955F61; Wed, 18 Nov 2026 09:34:55 +0000 (UTC)
Received: from nucbdw.ghoffman.csb.home.kraxel.org
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 173821956045; Wed, 18 Nov 2026 09:34:54 +0000 (UTC)
Received: by nucbdw.ghoffman.csb.home.kraxel.org (Postfix, from userid 11758)
 id EBF2740775CB; Wed, 18 Nov 2026 10:34:51 +0100 (CET)
Date: Wed, 18 Nov 2026 10:34:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
Message-ID: <av1wIjP6jez7fIco@nucbdw.ghoffman.csb.home.kraxel.org>
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <87bj7vwokb.fsf@pond.sub.org> <avRfKD2snrmJC3c-@redhat.com>
 <87jymjwl0w.fsf@redhat.com> <avR4m8ZtI-m8-V4r@redhat.com>
 <87h5hnwe4i.fsf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5hnwe4i.fsf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Hi,

> >> adcf33a504de ("s390x: modularize virtio-gpu-ccw") seems to indicate that
> >> this is needed for virtio-gpu-ccw being a module, not sure if that is
> >> still the case.
> >
> > I'm not understanding why modules affects this though ?
> 
> Yeah, me neither.
> 
> >
> > If CONFIG_VIRTIO_CCW is set, then we know virtio-ccw is builtin,
> > and the module loading for virtio-gpu-ccw is fine.
> >
> > If CONFIG_VIRTIO_CCW is unset, then neither virtio-gpu-ccw or
> > virtio-ccw are built at all, so there's no module to load.
> 
> Gerd, Halil: do you remember why this is needed?

Uh, it's been a while.  I *think* this is somehow related to the fact
that modules are not arch-specific, i.e. qemu-system-x86_64 can try
load the virtio-gpu-ccw module.

take care,
  Gerd


