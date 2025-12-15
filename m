Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA67D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 10:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV5yy-000319-G8; Mon, 15 Dec 2025 05:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vV5yu-00030r-G6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 05:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vV5yr-00030t-Sw
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 05:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765795144;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=s65/hNOg8hnFQrq49cDiKmMEMPRk/FYd/TE9DDu8Tqc=;
 b=i08Gw1JhD9rZH94eKvY2bE8WddX/lzEzANWDCneC8+Wz/3WTWskCdUd94rnlFQRUSzSEwl
 1FAuARCViEI7280mxX9JSqKaPaOTrKvzdZAEDJReLkiKcVNH3s2wtZQ2d64tqrS8gNq9M1
 /MClS7vZ2nmDrnTHZOvv7YeMDT5zItE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-dCCliR_gMT2VB7mb-zULbA-1; Mon,
 15 Dec 2025 05:39:02 -0500
X-MC-Unique: dCCliR_gMT2VB7mb-zULbA-1
X-Mimecast-MFC-AGG-ID: dCCliR_gMT2VB7mb-zULbA_1765795141
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 386FA195606D
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 10:39:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D53E11800660; Mon, 15 Dec 2025 10:38:58 +0000 (UTC)
Date: Mon, 15 Dec 2025 10:38:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/28] Introduce support for confidential guest reset
Message-ID: <aT_lP8l7lS-QlMBd@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Dec 12, 2025 at 08:33:28PM +0530, Ani Sinha wrote:
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

Presumably this re-opening of VCPU FDs means that all  the KVM vCPU PIDs
are going to change ?

If so, this is a significant semantic change that will break management
applications. vCPU PIDs are exposed in QMP and applications like libvirt
query them upon QEMU startup *BEFORE* vCPUs are started, and then do
things like setting CPU pinning or NUMA policies against them.

They cannot re-query the vCPU PIDs at time of reset, as by that point QEMU
has been running guest code, and so mgmt applications must assume that the
QEMU process (and thus QMP replies) are hostile. They cannot trust the vCPU
PIDs that would be reported as QEMU might have been compromised and now be
reporting vCPU PIDs of a completely different process as a form of DoS
against the mgmt app.

Can we get this reset functionality into KVM natively instead so QEMU
doesn't have todo this dance to re-create everything ? 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


