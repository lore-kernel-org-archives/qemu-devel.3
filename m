Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DBEC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9cM-0002If-VR; Mon, 04 Mar 2024 09:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rh9cM-0002I7-8c
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:48:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rh9cK-0007BX-GV
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709563714;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7tRov8v8Y3BArfMii+r2YRMHeN0uMGZT9Uy8xiKMgo0=;
 b=fu6qvDekUesQ8sgixeay+sp9IOD8D2ron+Zym41yTtGITwMIBXEPjqWDiSscuRQXLHnyA4
 plg/I89ZeIeHL3+RpXX17zCypZr7gZrMSJYaQax99N7NQOHRDHKetexbei/1SIaXsSuroc
 xNXkTWhVwuZ4lRGw10hCXGrIqX6X8MQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-XB6hXlgaMkSTros2FUVwhw-1; Mon, 04 Mar 2024 09:48:32 -0500
X-MC-Unique: XB6hXlgaMkSTros2FUVwhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F74185A588
 for <qemu-devel@nongnu.org>; Mon,  4 Mar 2024 14:48:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B45314024643;
 Mon,  4 Mar 2024 14:48:31 +0000 (UTC)
Date: Mon, 4 Mar 2024 14:48:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZeXfPdp-Ul3vxlxL@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com>
 <Zbi9vjPCsia58LG4@redhat.com> <CZL1LKPLC005.2WG9X653U6H6D@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CZL1LKPLC005.2WG9X653U6H6D@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 04, 2024 at 03:41:02PM +0100, Anthony Harivel wrote:
> 
> Hi Daniel,
> 
> > > +        if (s->msr_energy.enable == true) {
> >
> > This looks to be where we need to check that both the host CPU
> > vendor is intel, and the guest CPU vendor is intel, and that
> > the host CPU has the RAPL feature we're using.
>
> Checking for the host cpu and RAPL enable is fine and done. 
> 
> But checking for guest CPU is confusing me. 
> The RAPL feature is enable only with KVM enable. 
> This means "-cpu" can only be "host" or its derivative that essentially 
> copy the host CPU definition, no?

KVM can use any named CPU.

> That means if we are already checking the host cpu we don't need to do 
> anything for the guest, do we ?

When I first wrote this I though it would be as simple as checknig a
CPUID feature flag. That appears to not be the case, however, as Linux
is just checking for various CPU models directly. With that in mind
perhaps we should just check of the guest CPU model vendor
== CPUID_VENDOR_INTEL and leave it at that.

eg, create an error if running an AMD CPU such as $QEMU -cpu EPYC

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


