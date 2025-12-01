Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76674D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 15:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ5Y1-0001Le-Vm; Mon, 01 Dec 2025 10:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQ5Xy-0001Kp-Ql
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:10:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQ5Xv-0008Kz-Sg
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764601833;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=a24pTb94oO+4rCYyg7J5OcMpbSrbQIpLE5O9Bsy3MkM=;
 b=UAQLMMo6qJO3PANANsVN6Sa6YstkIlTxcqs3k7guU+FIQU3e8nBEhnN8C8DE5j16J6ciGO
 0iyLE3vmfjSxcCjRM/VABRsp8xgEfLxi0fbFsmzliFqGbEIjWnwIGMhaaX3CyNyuxLT5fm
 yXAP+PJnXhpn6iGroRf+aeW4Mv6PqyY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-9zq78jZkN5G5OsH0pMOxsQ-1; Mon,
 01 Dec 2025 10:10:24 -0500
X-MC-Unique: 9zq78jZkN5G5OsH0pMOxsQ-1
X-Mimecast-MFC-AGG-ID: 9zq78jZkN5G5OsH0pMOxsQ_1764601822
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62410195609F; Mon,  1 Dec 2025 15:10:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 325D118004A3; Mon,  1 Dec 2025 15:10:17 +0000 (UTC)
Date: Mon, 1 Dec 2025 15:10:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Chalios, Babis" <bchalios@amazon.es>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Graf (AWS), Alexander" <graf@amazon.de>,
 "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: Re: [RFC PATCH 0/4] vmclock: add support for VM generation counter
 and notifications
Message-ID: <aS2v1nTakVbWYbht@redhat.com>
References: <20251201125023.18344-1-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251201125023.18344-1-bchalios@amazon.es>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 01, 2025 at 12:50:24PM +0000, Chalios, Babis wrote:
> Latest specification of VMClock[1] adds support for VM generation counter
> and notifications. VM generation counter is similar to disruption_marker
> but it only changes when the guest has been loaded from a snapshot, not
> on live migration. Its purpose is to notify the guest about snapshot
> events and let it perform actions such as recreating UUIDs, resetting
> network connections, reseeding entropy, etc.
> 
> Moreover, the spec now describes a notification that the device can send
> after updating the seq counter to a new even number.
> 
> I have already sent the Linux changes to the mailing list here:
> https://lore.kernel.org/lkml/20251127103159.19816-1-bchalios@amazon.es/T/#u
> 
> [1] https://david.woodhou.se/VMClock.pdf

Should that spec document the expected behaviour of guests when a hypervisor
advertizes both vmclock and vmgenid devices ?

QEMU supports both, and to avoid assumptions about whether a guest supports
the newer vmclock, I could expect mgmt apps to expose both these QEMU
devices.

IIUC, your intent is that 'vmclock' obsoletes the need for 'vmgenid', so
should the spec say that explicitly, and suggest that guest kernels ignore
the vmgenid if both  are present, to avoid the same kind of actions being
triggered twice ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


