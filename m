Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F424C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 17:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIVw9-0002Rz-CH; Fri, 23 May 2025 13:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIVw5-0002RW-5Q
 for qemu-devel@nongnu.org; Fri, 23 May 2025 13:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIVw3-0003Yr-9y
 for qemu-devel@nongnu.org; Fri, 23 May 2025 13:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748020313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jj0KlCxUjE1OnOUnNbf2bI/IedxjekU9L+TWogVwEsA=;
 b=PMOnd99UdmdYyNvGGj7VzyByiyRrA2gLovn356G9inPlc7hcEYQzaCpSJoAR2xLkYctCIw
 dCRwmNX3uIm3XbaQ1Xllf6moRLOgmBtvRwCOQAa8E6SLO5fx30EQFh2WBPGasyC7plDHt8
 LqZNygOwBKwesCMkKvzW7vLgYwyxIJc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-CNvXRGEdPzSYdSkL96mJFQ-1; Fri,
 23 May 2025 13:11:51 -0400
X-MC-Unique: CNvXRGEdPzSYdSkL96mJFQ-1
X-Mimecast-MFC-AGG-ID: CNvXRGEdPzSYdSkL96mJFQ_1748020310
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7632195608C; Fri, 23 May 2025 17:11:49 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8088E19560AF; Fri, 23 May 2025 17:11:47 +0000 (UTC)
Date: Fri, 23 May 2025 12:11:44 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, f.ebner@proxmox.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/3] iotests: Improve mirror-sparse on ext4
Message-ID: <okdyhwzwcdpkea6t5nc242jvoddxk6favfyibmsv2kg6vu4ldy@ax26kgvcek64>
References: <20250523163041.2548675-5-eblake@redhat.com>
 <20250523163041.2548675-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523163041.2548675-7-eblake@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 23, 2025 at 11:27:22AM -0500, Eric Blake wrote:
> Fiona reported that an ext4 filesystem on top of LVM can sometimes
> report over-allocation to du (based on the hueristics the filesystem

and despite my other edits, I still missed fixing my typo on heuristics

> is making while observing the contents being mirrored); even though
> the contents and actual size matched, about 50% of the time the size
> reported by disk_usage was too large by 4k, failing the test.  In
> auditing other iotests, this is a common problem we've had to deal
> with.
> 
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Fixes: c0ddcb2c ("tests: Add iotest mirror-sparse for recent patches")
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


