Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CE1D5CC8A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 10:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t661J-0007ua-8L; Wed, 30 Oct 2024 06:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t661G-0007u8-M7
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t661E-00070T-AG
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730284417;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YKUnc8I63knl+8rDZDnDnCw50ytdt3zFrwBTOs/QWs0=;
 b=dmtKDHpsemtaWXwiwzmE3/MmYYlKrRniYVsJmWUSqCQZicP7xVKNi1pP7VybT69SvzXseu
 awLrfwu61nnhiN/YHxQrTsH4LiszazGqbUOEGKA9AgCste2VBeQgLqIgyuAgFYeiKkRpNo
 W9xfWxiR8qnKK3SnRezSu4HJOkAXXyY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-heYYvHFGOnGDon9-YbMwrg-1; Wed,
 30 Oct 2024 06:33:35 -0400
X-MC-Unique: heYYvHFGOnGDon9-YbMwrg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0669195608C; Wed, 30 Oct 2024 10:33:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 670C0300018D; Wed, 30 Oct 2024 10:33:26 +0000 (UTC)
Date: Wed, 30 Oct 2024 10:33:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC v2 5/7] x86/iommu: Make x86-iommu a singleton object
Message-ID: <ZyILcz3XnwK0nRI8@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
 <20241029211607.2114845-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029211607.2114845-6-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Oct 29, 2024 at 05:16:05PM -0400, Peter Xu wrote:
> X86 IOMMUs cannot be created more than one on a system yet.  Make it a
> singleton so it guards the system from accidentally create yet another
> IOMMU object when one already presents.
> 
> Now if someone tries to create more than one, e.g., via:
> 
>   ./qemu -M q35 -device intel-iommu -device intel-iommu
> 
> The error will change from:
> 
>   qemu-system-x86_64: -device intel-iommu: QEMU does not support multiple vIOMMUs for x86 yet.
> 
> To:
> 
>   qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only supports one instance
> 
> Unfortunately, yet we can't remove the singleton check in the machine
> hook (pc_machine_device_pre_plug_cb), because there can also be
> virtio-iommu involved, which doesn't share a common parent class yet.
> 
> But with this, it should be closer to reach that goal to check singleton by
> QOM one day.

Looking at the other iommu impls, I noticed that they all have something
in common, in that they call pci_setup_iommu from their realize()
function to register their set of callback functions.

This pci_setup_iommu can happily be called multiple times and just
over-writes previously registered callbacks. I wonder if this is a better
place to diagnose incorrect usage of multiple impls. If pci_setup_iommu
raised an error, it wouldn't matter that virtio-iommu doesn't share
a common parent with intel-iommu. This would also perhaps be better for
a future heterogeneous machine types, where it might be valid to have
multiple iommus concurrently. Checking at the resource setup/registration
point reflects where the physical constraint comes from.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


