Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9731EC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZdr-0005nX-Vk; Thu, 30 Jan 2025 13:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdZdn-0005mi-Us
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:51:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdZdm-0006nm-8O
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738263109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eFWeuFFPqEdkhZa+kl3R2VQiM1X61//GUYMABZQZe40=;
 b=Os6wzNRL8otoetPgPbIXJbH9H9jT2ooFEYOzEly2jPsYBihO3XjD7R5VYLrrORAFXYKmCR
 +IU93cnR7aGkM7nlo338gZgAOY1YpBmuT6B3vLdRpVeKhpKQTuBxdmE7sTOFEakQTSswtM
 wkedL1fyM1JDVmDaSBdb36yXQDzhGyQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-VhCiS8C5Oee5HuUIIVW8iQ-1; Thu,
 30 Jan 2025 13:51:45 -0500
X-MC-Unique: VhCiS8C5Oee5HuUIIVW8iQ-1
X-Mimecast-MFC-AGG-ID: VhCiS8C5Oee5HuUIIVW8iQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99F0E1956063; Thu, 30 Jan 2025 18:51:44 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDD3319560A3; Thu, 30 Jan 2025 18:51:41 +0000 (UTC)
Date: Thu, 30 Jan 2025 12:51:39 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pkrempa@redhat.com, 
 peterx@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/9] block: Add option to create inactive nodes
Message-ID: <xorcaqexfkkb7kri3b2ur37zbdvliusvdlhvbz7akc3kmikgh4@7lq4len56bgn>
References: <20250122115046.51216-1-kwolf@redhat.com>
 <20250122115046.51216-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122115046.51216-3-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On Wed, Jan 22, 2025 at 12:50:39PM +0100, Kevin Wolf wrote:
> In QEMU, nodes are automatically created inactive while expecting an
> incoming migration (i.e. RUN_STATE_INMIGRATE). In qemu-storage-daemon,
> the notion of runstates doesn't exist. It also wouldn't necessarily make
> sense to introduce it because a single daemon can serve multiple VMs
> that can be in different states.
> 
> Therefore, allow the user to explicitly open images as inactive with a
> new option. The default is as before: Nodes are usually active, except
> when created during RUN_STATE_INMIGRATE.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json         | 6 ++++++
>  include/block/block-common.h | 1 +
>  block.c                      | 9 +++++++++
>  3 files changed, 16 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


