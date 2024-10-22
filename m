Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B4ECDD0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LBL-0006Me-Du; Tue, 22 Oct 2024 16:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t3LBK-0006M8-Hv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1t3LBI-000522-Gd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729627717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K6sgiVlEaN9vzfOdqLxRCOUDJNhcRfYFPTN1vePHadM=;
 b=Spu9cS6DpvIgAmXHICPtUlGfNk7RNo52ZfEqUQvd6Si3/CJXpGi/5/3QAOmgR8DeohW2Ou
 PiBRVjbKOeasaAKMvHmFJSStu6JUma/2lctwVwEJx9dedJE4tRiK7XEHlaT5Hawk9ComYU
 CvZY+zP08tepwqHsAxP1tRInmoIb/2M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-UOrbmX7LOqmNM-_V2Cpbiw-1; Tue,
 22 Oct 2024 16:08:35 -0400
X-MC-Unique: UOrbmX7LOqmNM-_V2Cpbiw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA4F71955F68
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:08:34 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.64.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59CC219560A2; Tue, 22 Oct 2024 20:08:32 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, clg@redhat.com,
 peterx@redhat.com
Subject: [PATCH 0/2] vfio: Align mmaps
Date: Tue, 22 Oct 2024 14:08:27 -0600
Message-ID: <20241022200830.4129598-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

As described in patch /2, newer kernels may support pfnmap with PMD or
PUD sized mappings.  Mappings must be aligned in order to see the full
benefit of this support.  We're largely able to get PMD alignment for
free from mmap, but PUD alignment requires some effort.  Further, we
don't actually have an easy way to determine PMD or PUD alignment,
therefore we align all mmaps to the nearest power-of-two relative to the
region size, up to the maximum PUD size known the be currently available.

Enabling debug prints in the kernel shows that this exclusively enables
1GiB mappings for a GPU with a multi-gigabyte BAR whereas previously the
BAR is mapped with a combination of 2MiB and 1GiB mappings, only using
1GiB when opportunistically crossing an alignment boundary.

If there are ways to determine discrete alignment intervals or better
ways to generate a properly aligned address value for mmap, please share.
Thanks,

Alex

Alex Williamson (2):
  vfio/helpers: Refactor vfio_region_mmap() error handling
  vfio/helpers: Align mmaps

 hw/vfio/helpers.c | 66 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 19 deletions(-)

-- 
2.46.2


