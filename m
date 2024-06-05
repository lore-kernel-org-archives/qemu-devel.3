Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9C6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEo8m-0008Ll-7Z; Wed, 05 Jun 2024 06:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8k-0008Kc-4u
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8h-0007Vq-KZ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717584307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zU5ST+LjPYW3KgKQ7pUnf5LGDTq9Q6W7MWns3nuyCKc=;
 b=VOx/lRw9lrQYsS3nZhmIdFDX8z/kkcqlAwe/zEJ3oHPaceKVB+mHMEd4IeAPrlAVkHEYJM
 aI9qARv+IJdeTAEqF9hcwIC4vn6OXwNtSc88lr0ZmzEekIUjqLO45YwxmdDVqFCyIm322Q
 JDGAs0ZfTQIQVGz1MVRFHevw7/QRyC0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-MHgDNfZ6NhGprqCTDlyxyw-1; Wed,
 05 Jun 2024 06:45:03 -0400
X-MC-Unique: MHgDNfZ6NhGprqCTDlyxyw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31EEF195E912
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:02 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F00319560A2
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:00 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/5] backends/hostmem: Report more errors on failures
Date: Wed,  5 Jun 2024 12:44:53 +0200
Message-ID: <cover.1717584048.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

v4 of:

https://mail.gnu.org/archive/html/qemu-devel/2024-05/msg06511.html

diff to v3:
- In 2/5 instead of fixing up posix_madvise() retval at runtime, just
  don't use posix_madvise() on Darwin at all (resulted in new patch 1/5).
  Since 2/5 is now the same as 1/4 from v2 I'm including David's
  Reviewed-by line.
- The last patch was tested by Mario, so I've included his Tested-by
  line. Thanks!

Michal Privoznik (5):
  meson: Don't even detect posix_madvise() on Darwin
  osdep: Make qemu_madvise() to set errno in all cases
  osdep: Make qemu_madvise() return ENOSYS on unsupported OSes
  backends/hostmem: Report error on qemu_madvise() failures
  backends/hostmem: Report error when memory size is unaligned

 backends/hostmem.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 meson.build        | 14 ++++++++++----
 util/osdep.c       |  9 +++++++--
 3 files changed, 55 insertions(+), 14 deletions(-)

-- 
2.44.1


