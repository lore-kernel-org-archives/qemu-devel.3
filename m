Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6BDC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 07:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRRY3-0001kZ-SX; Wed, 10 Jul 2024 03:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRRXy-0001jR-11
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRRXu-0000en-UX
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720595719;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMU3qVQQd5gCJgegoVmffWhIQ56IyxVkzgTRd1PnKFg=;
 b=BkeWEn2KAdIQi94CKhbehyvOtwzZ/2oqgdsOX/lGEbcegqzj+IL7K9RFQoNRkH3QCx27yf
 mW2BIMg8WWk9p6o5lzIGEfVClzhJXGOXO+p9eh8TuDShYL2mcvMkPWqv4Mqv5TVecB+gbb
 ciAR959uruzn/1P5RjQ7Yg7E3jzEVHI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-yA7hdqIgMt63u7YsDBHEqw-1; Wed,
 10 Jul 2024 03:15:17 -0400
X-MC-Unique: yA7hdqIgMt63u7YsDBHEqw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 544C81955BCE; Wed, 10 Jul 2024 07:15:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A724E19560AE; Wed, 10 Jul 2024 07:15:14 +0000 (UTC)
Date: Wed, 10 Jul 2024 08:15:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH v2] i386/sev: Don't allow automatic fallback to legacy
 KVM_SEV*_INIT
Message-ID: <Zo40_2e1I4gXdNxx@redhat.com>
References: <20240710041005.83720-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710041005.83720-1-michael.roth@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue, Jul 09, 2024 at 11:10:05PM -0500, Michael Roth wrote:
> Currently if the 'legacy-vm-type' property of the sev-guest object is
> 'on', QEMU will attempt to use the newer KVM_SEV_INIT2 kernel
> interface in conjunction with the newer KVM_X86_SEV_VM and
> KVM_X86_SEV_ES_VM KVM VM types.
> 
> This can lead to measurement changes if, for instance, an SEV guest was
> created on a host that originally had an older kernel that didn't
> support KVM_SEV_INIT2, but is booted on the same host later on after the
> host kernel was upgraded.
> 
> Instead, if legacy-vm-type is 'off', QEMU should fail if the
> KVM_SEV_INIT2 interface is not provided by the current host kernel.
> Modify the fallback handling accordingly.
> 
> In the future, VMSA features and other flags might be added to QEMU
> which will require legacy-vm-type to be 'off' because they will rely
> on the newer KVM_SEV_INIT2 interface. It may be difficult to convey to
> users what values of legacy-vm-type are compatible with which
> features/options, so as part of this rework, switch legacy-vm-type to a
> tri-state OnOffAuto option. 'auto' in this case will automatically
> switch to using the newer KVM_SEV_INIT2, but only if it is required to
> make use of new VMSA features or other options only available via
> KVM_SEV_INIT2.
> 
> Defining 'auto' in this way would avoid inadvertantly breaking
> compatibility with older kernels since it would only be used in cases
> where users opt into newer features that are only available via
> KVM_SEV_INIT2 and newer kernels, and provide better default behavior
> than the legacy-vm-type=off behavior that was previously in place, so
> make it the default for 9.1+ machine types.
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> cc: kvm@vger.kernel.org
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
> v2:
>   - switch to OnOffAuto for legacy-vm-type 'property'
>   - make 'auto' the default for 9.1+, which will automatically use
>     KVM_SEV_INIT2 when strictly required by a particular set of options,
>     but will otherwise keep using the legacy interface.
> 
>  hw/i386/pc.c      |  2 +-
>  qapi/qom.json     | 18 ++++++----
>  target/i386/sev.c | 85 +++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 83 insertions(+), 22 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


