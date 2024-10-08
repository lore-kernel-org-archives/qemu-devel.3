Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE02CEF14D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7eN-0007Rm-FH; Tue, 08 Oct 2024 06:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sy7eM-0007Rb-Ey
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sy7eK-0000DT-QN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728384063;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8Pr0LIgmYA2NXhvnN8tWzGXEjfVVDDmp1nZwSIdPdl0=;
 b=KCXQyDw+le0rDx0ccCzn7zAPb9loLX3n4L0km9kzV5c+vB4x76hHSyM+id/BrpX9Nl3oqe
 IZwHG5z53TAK7HXT18BtSqc2tsM3UpSj1ZPCjg1+EZfBRTZYgGMutCV82j0Rxww4MSuBEF
 yJNPiVD8Rw/tSyrk//rGWAU7YNDjPkI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-9vETlG0nNhO8Cxjy65qU1w-1; Tue,
 08 Oct 2024 06:41:01 -0400
X-MC-Unique: 9vETlG0nNhO8Cxjy65qU1w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8EC61955EE7; Tue,  8 Oct 2024 10:41:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA3A219560A3; Tue,  8 Oct 2024 10:40:58 +0000 (UTC)
Date: Tue, 8 Oct 2024 11:40:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: Re: pcie-root-port limits for q35?
Message-ID: <ZwUMN6P40sVwcmm-@redhat.com>
References: <9d0e5db9-aaf9-4536-ad9f-2f5c86523627@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d0e5db9-aaf9-4536-ad9f-2f5c86523627@nutanix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 08, 2024 at 03:44:33PM +0530, Tejus GK wrote:
> Hi, recently I was trying to play with the PCIe limits on the q35 machine
> type. I see that docs/pcie.txt mentions:
> 
> > The IO space is very limited, to 65536 byte-wide IO ports, and may
> > even be fragmented by fixed IO ports owned by platform devices
> > resulting in at most 10 PCI Express Root Ports or PCI Express
> > Downstream Ports per system if devices with IO BARs are used in the
> > PCI Express hierarchy
> 
> But in my own experimental setup, I was able to successfully create and
> power on a VM with 232 pcie-root-ports, with each root port hosting a
> virtio-net device on it. The root ports, and the network devices end up
> appearing inside the VM's PCI enumeration as well. So I'm left wondering
> where this limit exactly come from? And I'm not sure if I am missing
> something here, since I'm able to go way above the limit mentioned above.

Note the very last part of the text you quoted:

   ..if devices with IO BARs are used..

     ^^

AFAIK, the virtio devices (at least in modern mode) don't use IO BARs,
thus avoiding the mentioned limit.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


