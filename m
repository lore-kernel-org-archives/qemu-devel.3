Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A473FC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 12:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLiyY-00052C-Og; Mon, 24 Jun 2024 08:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLiyX-00051T-6z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 08:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLiyV-0004z3-E6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 08:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719232750;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCkXiUAP422+GKIba8BKRNsoqDrd/P+DTSVD2LrppTk=;
 b=Iw4Q+vwU70uE8wuk+RXWRh/+tHhaQglHbi3P19JlBvl6368BtVBnJJsHgqB0gjuv7PJDE8
 9o6yISyGBhzUZYvBPf+FTlt+3qYghlQwCNNlpC2tupEI2xrAWN/x5GVdO96QkvIilWQXoD
 JJptq62QLAs9v8HY5VRiWiS8AWX3L2g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-uYoI1mJAPMaD3NhUTvDxgQ-1; Mon,
 24 Jun 2024 08:39:06 -0400
X-MC-Unique: uYoI1mJAPMaD3NhUTvDxgQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0259819560AD; Mon, 24 Jun 2024 12:39:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FC0819560BF; Mon, 24 Jun 2024 12:38:59 +0000 (UTC)
Date: Mon, 24 Jun 2024 13:38:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, kvm@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] i386: revert defaults to 'legacy-vm-type=true' for
 SEV(-ES) guests
Message-ID: <Znlo4GMgJ91nKyft@redhat.com>
References: <20240614103924.1420121-1-berrange@redhat.com>
 <20240624080458-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624080458-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jun 24, 2024 at 08:27:01AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jun 14, 2024 at 11:39:24AM +0100, Daniel P. Berrangé wrote:
> > The KVM_SEV_INIT2 ioctl was only introduced in Linux 6.10, which will
> > only have been released for a bit over a month when QEMU 9.1 is
> > released.
> > 
> > The SEV(-ES) support in QEMU has been present since 2.12 dating back
> > to 2018. With this in mind, the overwhealming majority of users of
> > SEV(-ES) are unlikely to be running Linux >= 6.10, any time in the
> > forseeable future.
> > 
> > IOW, defaulting new QEMU to 'legacy-vm-type=false' means latest QEMU
> > machine types will be broken out of the box for most SEV(-ES) users.
> > Even if the kernel is new enough, it also affects the guest measurement,
> > which means that their existing tools for validating measurements will
> > also be broken by the new default.
> > 
> > This is not a sensible default choice at this point in time. Revert to
> > the historical behaviour which is compatible with what most users are
> > currently running.
> > 
> > This can be re-evaluated a few years down the line, though it is more
> > likely that all attention will be on SEV-SNP by this time. Distro
> > vendors may still choose to change this default downstream to align
> > with their new major releases where they can guarantee the kernel
> > will always provide the required functionality.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> This makes sense superficially, so
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> and I'll let kvm maintainers merge this.
> 
> However I wonder, wouldn't it be better to refactor this:
> 
>     if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
>         cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
>         
>         ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
>     } else {
>         struct kvm_sev_init args = { 0 };
>                 
>         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
>     }   
> 
> to something like:
> 
> if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) != KVM_X86_DEFAULT_VM) {
>         struct kvm_sev_init args = { 0 };
>                 
>         ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
> 	if (ret && errno == ENOTTY) {
> 		cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
> 
> 		ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
> 	}
> }
> 
> 
> Yes I realize this means measurement will then depend on the host
> but it seems nicer than failing guest start, no?

IMHO having an invariant measurement for a given guest configuration
is a critical guarantee. We should not be allowing guest attestation
to break as a side-effect of upgrading a software component, while
keeping the guest config unchanged.

IOW, I'd view measurement as being "guest ABI", and versioned machine
types are there to provide invariant guest ABI.

Personally, if we want simplicitly then just not using KVM_SEV_INIT2
at all would be the easiest option. SEV/SEV-ES are legacy technology
at this point, so we could be justified in leaving it unchanged and
only focusing on SEV-SNP. Unless someone can say what the critical
*must have* benefit of using KVM_SEV_INIT2 is ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


