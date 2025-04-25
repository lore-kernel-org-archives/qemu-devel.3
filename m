Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D325C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 17:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8NEd-0000ug-U7; Fri, 25 Apr 2025 13:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEY-0000rI-9t
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEW-0007P3-Go
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745603583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ipn/C2QhrkyoU8W57i5OHlBxRGCYnKhqpi2hGGIqUt8=;
 b=Qh6Ap7RYHHfn+rI3EgA5tu3on8b3GkDGdOzVEj4PENZ/uaPwDyqJz57dsqY87KN2ib4xYL
 2YcJILb83fWylRzAnydTVe/i/QvMSxzH67dj7rSoQ1ieS//YlrAeAlZ71jQ/l1b1lARnh+
 rpIa4rYG54cvb8sTQDRASlmVci426vo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-gmvnldrvNumu7pNq4JhN9g-1; Fri,
 25 Apr 2025 13:52:57 -0400
X-MC-Unique: gmvnldrvNumu7pNq4JhN9g-1
X-Mimecast-MFC-AGG-ID: gmvnldrvNumu7pNq4JhN9g_1745603577
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C93E1956094; Fri, 25 Apr 2025 17:52:56 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.183])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F0241800D97; Fri, 25 Apr 2025 17:52:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/4] Block layer patches
Date: Fri, 25 Apr 2025 19:52:48 +0200
Message-ID: <20250425175252.316807-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 019fbfa4bcd2d3a835c241295e22ab2b5b56129b:

  Merge tag 'pull-misc-2025-04-24' of https://repo.or.cz/qemu/armbru into staging (2025-04-24 13:44:57 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 2b689db0bedd24eda8b491cb1fcfb015dfec5a31:

  qemu-img: improve queue depth validation in img_bench (2025-04-25 18:09:04 +0200)

----------------------------------------------------------------
Block layer patches

- Discard alignment fixes
- Remove unused callback .bdrv_aio_pdiscard()
- qemu-img bench: Input validation fix

----------------------------------------------------------------
Denis Rastyogin (1):
      qemu-img: improve queue depth validation in img_bench

Stefan Hajnoczi (2):
      file-posix: probe discard alignment on Linux block devices
      block/io: skip head/tail requests on EINVAL

Sunny Zhu (1):
      block: Remove unused callback function *bdrv_aio_pdiscard

 include/block/block_int-common.h |  4 ---
 block/file-posix.c               | 67 +++++++++++++++++++++++++++++++++++++++-
 block/io.c                       | 35 +++++++--------------
 qemu-img.c                       |  2 +-
 4 files changed, 79 insertions(+), 29 deletions(-)


