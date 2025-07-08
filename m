Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC78C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZF9b-0000RS-2X; Tue, 08 Jul 2025 16:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZDR6-0008Kc-Ii
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZDQM-0007xg-LE
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752000723;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3vC8C8sVRnVeZDTVWM7CQFE9e3gCk7D8qALWmelOzZQ=;
 b=fJYpJqY1cseZvgo69eDNacFkYycIRk/q/Qm+c6bfNPK6ttWNtwmQ3Yjqi1iXYKhfYcHQvd
 VPiGqwIDDn9x+H/pNtVlhU0slOTywPVb1FD7uSEq0ej2UVZgFqte6fFdiFXPXF54C6dUVQ
 HAiepGtuDUEKwrTZbX6Mn0/XWPGKjz8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-wy6iZ3MSPimkOAbCKdXpxQ-1; Tue,
 08 Jul 2025 11:32:47 -0400
X-MC-Unique: wy6iZ3MSPimkOAbCKdXpxQ-1
X-Mimecast-MFC-AGG-ID: wy6iZ3MSPimkOAbCKdXpxQ_1751988765
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCD711801217; Tue,  8 Jul 2025 15:32:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F6AA19560AB; Tue,  8 Jul 2025 15:32:37 +0000 (UTC)
Date: Tue, 8 Jul 2025 16:32:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v9 00/16] Introduce support for IGVM files
Message-ID: <aG06EnbOg3a--2jl@redhat.com>
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 03, 2025 at 03:59:33PM +0100, Roy Hopkins wrote:
> Here is v9 of the set of patches to add support for IGVM files to QEMU. This is
> based on commit c77283dd5d79149f4e7e9edd00f65416c648ee59 of qemu.
> 
> Once again, this is mostly a rebase of the previous patch series. However,
> thanks to those reviewers who have provided feedback on v8 which has now been
> addressed in this new version.
> 
> This v9 patch series is also available on github: [2]
> 
> For testing IGVM support in QEMU you need to generate an IGVM file that is
> configured for the platform you want to launch. You can use the `buildigvm`
> test tool [3] to allow generation of IGVM files for all currently supported
> platforms. Patch 11/17 contains information on how to generate an IGVM file
> using this tool.
> 
> Changes in v9:
> 
> * Address review comments from v8
> * Add metadata to relevant commits.
> 
> Patch summary:
> 
> 1-11: Add support and documentation for processing IGVM files for SEV, SEV-ES,
> SEV-SNP and native platforms. 
> 
> 12-15: Processing of policy and SEV-SNP ID_BLOCK from IGVM file. 
> 
> 16: Add pre-processing of IGVM file to support synchronization of 'SEV_FEATURES'
> from IGVM VMSA to KVM.

IIRC, way back in the early draft of this you have included some pieces
related to TDX which we then dropped since TDX wasn't ready in QEMU
upstream.

Now that TDX merged in QEMU a few weeks back, I'm wondering what gaps there
are in this series wrt TDX support ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


