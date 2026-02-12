Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3135EDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRmo-0006eT-HT; Thu, 12 Feb 2026 03:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqRmk-0006dY-MR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:10:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqRmi-0001dd-NU
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770883848;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+aK5lmUmXRk+Ikrvxvve1bppvK2OTW/Ho8XjR3gjNkc=;
 b=Bnf19b9qNv6DklkAo/sG/G6PA4iMFGzq8zxqcjlwXFkRKdpqruvPrT8QOxoNK2fHsEIZUP
 Z5hEI9/UR9ycY4fzUs1raE2I3f15o9zTuBTkyFxO8u74PYM8SWnxPrVe344Z1tFMX21fci
 Fn6V9D7jwoi/rLdSYaeq8uGSLE/3wd8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-5TUh1n4vNcKqC04HH2-ImQ-1; Thu,
 12 Feb 2026 03:10:46 -0500
X-MC-Unique: 5TUh1n4vNcKqC04HH2-ImQ-1
X-Mimecast-MFC-AGG-ID: 5TUh1n4vNcKqC04HH2-ImQ_1770883845
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A41AF18004BB; Thu, 12 Feb 2026 08:10:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.206])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C306180066E; Thu, 12 Feb 2026 08:10:42 +0000 (UTC)
Date: Thu, 12 Feb 2026 08:10:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 vkuznets@redhat.com, graf@amazon.com
Subject: Re: [PATCH v4 00/31] Introduce support for confidential guest reset
 (x86)
Message-ID: <aY2K_9mEj2oT_I0l@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 12, 2026 at 11:54:44AM +0530, Ani Sinha wrote:
> This change introduces support for confidential guests
> (SEV-ES, SEV-SNP and TDX) to reset/reboot just like other non-confidential
> guests. Currently, a reboot intiated from the confidential guest results
> in termination of the QEMU hypervisor as the CPUs are not resettable. As the
> initial state of the guest including private memory is locked and encrypted,
> the contents of that memory will not be accessible post reset. Hence a new
> KVM file descriptor must be opened to create a new confidential VM context
> closing the old one. All KVM VM specific ioctls must be called again. New
> VCPU file descriptors must be created against the new KVM fd and most VCPU
> ioctls must be called again as well.
> 
> This change perfoms closing of the old KVM fd and creating a new one. After
> the new KVM fd is opened, all generic and architecture specific ioctl calls
> are issued again. Notifiers are added to notify subsystems that:
> - The KVM file fd is about to be changed to state sync-ing from KVM to QEMU
>   should be done if required.
> - The KVM file fd has changed, so ioctl calls to the new KVM fd has to be
>   performed again.
> - That new VCPU fds are created so that VCPU ioctl calls must be called again
>   where required.
> 
> Specific subsystems use these notifiers to re-issue ioctl calls where required.
> 
> Changes are made to SEV and TDX modules to reinitialize the confidential guest
> state and seal it again. Along the way, some bug fixes are made so that some
> initialization functions can be called again. Some refactoring of existing
> code is done so that both init and reset paths can use them.
> 
> Tested on TDX, SEV-ES and SEV-SNP. Tested on non-coco hardware. Tested with Xen
> emulation enabled.

I see no QOM changes here, so is there any way for a mgmt app to
detect that QEMU is now capable of guest reset with TDX/SEV/SNP,
compared to the current behaviour ?


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


