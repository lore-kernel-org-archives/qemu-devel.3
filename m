Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C9CCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 15:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyXDa-0006c3-DO; Tue, 16 Sep 2025 11:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyXDM-0006Wb-TW
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 11:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyXDK-0006RX-3h
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 11:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758034995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mz4q4r7x8FVp7T3wM1kV8XwhENOApW+a+HoqsplWyoU=;
 b=cQKt3fVDU/EcSdDvLO8xXQgNUc81OBwwjFPt4lDDmrMN6UjUhlwPmbr3XRo8GyaR82ud4O
 aE6FIQX+CVtVRhSHdLK8YD7FNXMK0EhEWfSn1eAp0xTMZEVFbzDSiq/Rd0QrHavUcM9mOM
 Nl8c4yqf8jhYHAGGoc3JUUqZr9k80VA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-9DU3rbQlOaCjfqxPuMXTFw-1; Tue,
 16 Sep 2025 11:03:12 -0400
X-MC-Unique: 9DU3rbQlOaCjfqxPuMXTFw-1
X-Mimecast-MFC-AGG-ID: 9DU3rbQlOaCjfqxPuMXTFw_1758034990
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC0E91955D6E; Tue, 16 Sep 2025 15:03:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4D1B180057B; Tue, 16 Sep 2025 15:03:05 +0000 (UTC)
Date: Tue, 16 Sep 2025 16:03:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Naveen N Rao <naveen@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [RFC PATCH 3/7] target/i386: SEV: Add support for enabling
 debug-swap SEV feature
Message-ID: <aMl8JsHtO0Cmbb1p@redhat.com>
References: <cover.1757589490.git.naveen@kernel.org>
 <0a77cf472bc36fee7c1be78fc7d6d514d22bca9a.1757589490.git.naveen@kernel.org>
 <87jz239at0.fsf@pond.sub.org>
 <m5fnfafkzxqamg4iyc6xjun7jlxulcuufgugtrweap6myvmgov@5cmxu5n3pl2p>
 <87plbqo998.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plbqo998.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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

On Tue, Sep 16, 2025 at 02:46:27PM +0200, Markus Armbruster wrote:
> Naveen N Rao <naveen@kernel.org> writes:
> 
> > Hi Markus,
> >
> > On Fri, Sep 12, 2025 at 01:20:43PM +0200, Markus Armbruster wrote:
> >> "Naveen N Rao (AMD)" <naveen@kernel.org> writes:
> >> 
> >> > Add support for enabling debug-swap VMSA SEV feature in SEV-ES and
> >> > SEV-SNP guests through a new "debug-swap" boolean property on SEV guest
> >> > objects. Though the boolean property is available for plain SEV guests,
> >> > check_sev_features() will reject setting this for plain SEV guests.
> >> 
> >> Let's see whether I understand...
> >> 
> >> It's a property of sev-guest and sev-snp-guest objects.  These are the
> >> "SEV guest objects".
> >> 
> >> I guess a sev-snp-guest object implies it's a SEV-SNP guest, and setting
> >> @debug-swap on such an object just works.
> >> 
> >> With a sev-guest object, it's either a "plain SEV guest" or a "SEV-ES"
> >> guest.
> >> 
> >> If it's the latter, setting @debug-swap just works.
> >> 
> >> If it's the former, and you set @debug-swap to true, then KVM
> >> accelerator initialization will fail later on.  This might trigger
> >> fallback to TCG.
> >> 
> >> Am I confused?
> >
> > You're spot on, except that in the last case above (plain old SEV 
> > guest), qemu throws an error:
> > 	qemu-system-x86_64: check_sev_features: SEV features require either SEV-ES or SEV-SNP to be enabled
> 
> Okay.
> 
> Can you (or anyone) explain to me why SEV-SNP gets its own object type,
> but SEV-ES does not?

SEV-ES is a minor incremental enhancement over SEV, with the user provided
configuration in QEMU largely common between the two.

SEV-SNP is a significant improvement that requires new/different user
config data to be provided to QEMU. It also changes the way attestation
is driven, moving out of host/QEMU, into the guest.

It made more sense to separate the configuration for SEV-SNP from that
used for SEV/SEV-ES. It also helps reinforce the message that SEV-SNP
is where the long term focus should be, with SEV/SEV-ES (ideally) only
used on old platforms that predate SNP, or running OS that lack the
more recent software support for SNP.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


