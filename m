Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F40CC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtXW-0000vM-SN; Wed, 02 Jul 2025 05:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWtXU-0000th-1X
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uWtXR-0007fM-3w
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751447635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jEnQ4nz+X5M4Ucn7h6Hbhao8+9F+1031khsV7bMuMBE=;
 b=HTmZt1YZamU3x8elhMzrbBHPMWVKLOftYeSxEbTXBUvFHrlXTEbBzGZLdwKXWuefpWP2PW
 DcM7qfZFlKeey4K5dcLN60BZP6FLfLc30/r04Lf9cVO+SsdKEd72GKEMd4CgEt1yTGlrhn
 RJ2sZtAf/TOOTGZ6o71wlHHc7vOzHq4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-XEqEvgeoM2CDe6dddeWJkQ-1; Wed,
 02 Jul 2025 05:13:52 -0400
X-MC-Unique: XEqEvgeoM2CDe6dddeWJkQ-1
X-Mimecast-MFC-AGG-ID: XEqEvgeoM2CDe6dddeWJkQ_1751447632
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6970180028A; Wed,  2 Jul 2025 09:13:51 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.171])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58D8D180045B; Wed,  2 Jul 2025 09:13:48 +0000 (UTC)
Date: Wed, 2 Jul 2025 11:13:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2] block: include child references in block device info
Message-ID: <aGT4SoV76ViyN6XS@redhat.com>
References: <20250701162124.1313813-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701162124.1313813-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 01.07.2025 um 18:21 hat Fiona Ebner geschrieben:
> In combination with using a throttle filter to enforce IO limits for
> a guest device, knowing the 'file' child of a block device can be
> useful. If the throttle filter is only intended for guest IO, block
> jobs should not also be limited by the throttle filter, so the
> block operations need to be done with the 'file' child of the top
> throttle node as the target. In combination with mirroring, the name
> of that child is not fixed.
> 
> Another scenario is when unplugging a guest device after mirroring
> below a top throttle node, where the mirror target is added explicitly
> via blockdev-add. After mirroring, the target becomes the new 'file'
> child of the throttle node. For unplugging, both the top throttle node
> and the mirror target need to be deleted, because only implicitly
> added child nodes are deleted automatically, and the current 'file'
> child of the throttle node was explicitly added (as the mirror
> target).
> 
> In other scenarios, it could be useful to follow the backing chain.
> 
> Note that iotests 191 and 273 use _filter_img_info, so the 'children'
> information is filtered out there.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1df6644f0d..8816feec2d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -461,6 +461,19 @@
>              'direct': 'bool',
>              'no-flush': 'bool' } }
>  
> +##
> +# @BlockdevChild:
> +#
> +# @child: The name of the child, for example 'file' or 'backing'.
> +#
> +# @node-name: The name of the child's block driver node.
> +#
> +# Since: 10.1
> +##
> +{ 'struct': 'BlockdevChild',
> +  'data': { 'child': 'str',
> +            '*node-name': 'str' } }

Is node-name really optional? I don't think we have nodes without a node
name any more, do we?

Same with your check for child->bs, I don't think a BdrvChild without a
bs can exist (or only while creating/destroying the BdrvChild, which
holds the graph lock and doesn't allow monitor commands to run in the
middle).

Kevin


