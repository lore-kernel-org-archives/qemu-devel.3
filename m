Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79641CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZzN-0000GN-UD; Mon, 08 Jun 2026 09:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWZzI-0000FR-SD
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWZzH-0008Vl-G6
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780925154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+EEbiLf3OKcgyz9n1CRLnSbxD8pzXi7kZbFtz2Y50Og=;
 b=Y+kmGqmbHhAJjNOawGvOrKSWo4DJyffgoP3XEUh+Hza6W8/M/mqAQof4TAyi1EQTW3tdwJ
 yHuiWgLqAEUMneh1BxdbbWNTXA7bkBoO1rcgC90ctGA/HqJ0tSdt73pJLgBYt8vGLKDRNY
 wD9GJzKUVTH6TpqbRPO8xOtQ5xQ0ugU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-Fw0Yikw-Mn-TVPZbkFN4kQ-1; Mon,
 08 Jun 2026 09:25:51 -0400
X-MC-Unique: Fw0Yikw-Mn-TVPZbkFN4kQ-1
X-Mimecast-MFC-AGG-ID: Fw0Yikw-Mn-TVPZbkFN4kQ_1780925150
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B86A419560AA; Mon,  8 Jun 2026 13:25:50 +0000 (UTC)
Received: from localhost (unknown [10.2.16.156])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38CC53008B3B; Mon,  8 Jun 2026 13:25:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 0/2] Block patches
Date: Mon,  8 Jun 2026 09:25:22 -0400
Message-ID: <20260608132524.470459-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 3390aba56c354637eccd2d5ab5fd6efc2f026f06:

  Merge tag 'qom-tests-pr-v2' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-06-06 14:47:04 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 3f3ba1408b52a5ffc10096936451489fe7d066d7:

  MAINTAINERS: remove Julia Suvorova from Linux io_uring (2026-06-08 08:38:30 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Fiona Ebner (1):
  block/io: fallback to bounce buffer if BLKZEROOUT is not supported
    because of alignment

Stefan Hajnoczi (1):
  MAINTAINERS: remove Julia Suvorova from Linux io_uring

 MAINTAINERS |  1 -
 block/io.c  | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.54.0


