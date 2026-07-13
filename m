Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B004C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCD1-0003zN-2t; Mon, 13 Jul 2026 04:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjCCz-0003z0-Ah
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjCCx-0002se-Az
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783932010;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=laHc9OCkuNE5ZrgjPlrGGAED0pj7TY3I/XYByhIQynw=;
 b=T4wC9i7Av8g305Qyzok9LqQVVeSAYJmPVe8t+cOvcqXQTQbRKbi5WPzAqj/HCfivmMt4Zl
 bDn27jorhhocd/Wk+Qtf6eDw4goRitjxfLYXMwgVxNZqedFU/Ch0x+JzetKYYrVPl8O1bp
 XiC1BSQxI2Grl9m/LQIh9Cq+Hf8WLWQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-HfmF_QeHPfuDa-E-Gq1Rjw-1; Mon,
 13 Jul 2026 04:40:01 -0400
X-MC-Unique: HfmF_QeHPfuDa-E-Gq1Rjw-1
X-Mimecast-MFC-AGG-ID: HfmF_QeHPfuDa-E-Gq1Rjw_1783932000
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A55F71955DB5; Mon, 13 Jul 2026 08:39:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA9B319560A0; Mon, 13 Jul 2026 08:39:55 +0000 (UTC)
Date: Mon, 13 Jul 2026 09:39:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: what is qemu_system_guest_panicked() for?
Message-ID: <alSkWHw6ryhEEaDf@redhat.com>
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Fri, Jul 10, 2026 at 05:02:53PM +0100, Peter Maydell wrote:
> (cc list is a random mix of maintainers of code that calls this
> function, Paolo as "main loop maintainer" and a few others who
> I thought might have an opinion.)
> 
> We have a qemu_system_guest_panicked() function which causes QEMU
> to report this to the user and do one of a couple of possible options
> (shutdown, pause the VM, do nothing). This seems mostly intended for
> "the guest OS told us by some mechanism that it just panicked". But
> we use it more widely than that...
> 
> Cases which are "the guest told us about a panic":
>  - accel/kvm/kvm-all.c handling of the KVM_EXIT_SYSTEM_EVENT SEV_TERM
>    and CRASH subtypes
>  - the pvpanic device
>  - the spapr ibm,os-term RTAS call
>  - x86 kvm: tdx_panicked_on_fatal_error()
>  - x86 xen: the SHUTDOWN_crash shutdown subtype
> 
> Cases which are not:
>  - hw/spapr/rtas.c: if the FDT has no RTAS address during system reset
>  - hw/spapr/spapr_events.c: if we wanted to deliver a machine check
>    exception to the guest but the FDT has no RTAS address
>  - hw/spapr/spapr_events.c: if we want to deliver a machine check
>    but the guest is still dealing with a previous machine check
>  - arm whpx, if we get an unknown/unexpected exit code trying to run the VM
>  - x86 nvmm, for an unknown/unexpected VM exit code
>  - ppc TCG, in powerpc_checkstop(), for a machine check exception I think
>  - s390_handle_wait(): not sure exactly what this is
>  - s390 unmanageable_intercept(): again not sure, think this is where
>    the guest has gone off the rails and we can't keep running
> 
> At least one or two of the above have comments to the effect that
> they don't want to use e.g. cpu_abort() because they want to give
> the user the ability to examine the VM after this unrecoverable
> guest error, rather than just exiting QEMU.
> 
> So I guess my question is, is it OK to mash these two categories of
> "we can't keep running the VM" together, or should we define a new
> one for the "unrecoverable guest error" case, or do we already have
> some better thing to do that I missed?

IMHO we should NOT be abusing "panicked" for cases which are
not guest OS panics.

Adding new QMP events is cheap and we should do so. We need
at least a "MCE"  event.

IMHO the "unknown / unexpected" VM exits likely deserve a
different event again.

> 
> In particular, "do nothing" might be a reasonable response for the
> user to configure to a guest panic notification, since the guest will
> presumably stick the vcpu into a do-nothing loop, but "do nothing"
> doesn't make sense for "unrecoverable guest error" because we'll
> probably then sit in QEMU in a tight loop retrying whatever it
> was that failed.
> 
> If we had some kind of qemu_system_unrecoverable_guest_error() then
> we could maybe convert some uses of cpu_abort() over to that (though
> uses of cpu_abort() are a very mixed bunch, some of which should be
> LOG_UNIMP or LOG_GUEST_ERROR and continue and some of which should
> be straightforward assertions, as well as some which might be this
> new exit case).
> 
> (This query was prompted by a patch for arm whpx which adds a new
> qemu_system_guest_panicked() call for an unhandled VM exit situation.)
> 
> thanks
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


