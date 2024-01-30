Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348C6C48285
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUw1C-00027P-Tp; Tue, 30 Jan 2024 16:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1B-00026T-6y
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:51:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw19-0005mf-KT
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706651503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aaODQ68S45z0LXYKCzC3/t9low2kjHz4u1O0LnZTkco=;
 b=ei4KNp9EckjZkOJ/nHM0PpPyEntAsHr5+vlqHd64mXGlf3erYEpDsCdFgdDnrZvjdGW7B2
 RTlK0Qdd9DGsnQEUzM3hSeqDE0SL0kHDIfQymcVdLLJLnPPwphkWMQe9mxR324GhGfiBAF
 zmcGh7Us7agUh/xbcHsuvAjTIAg/3FM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-aIV68sjPOVCoRuWxVPV2LQ-1; Tue, 30 Jan 2024 16:51:37 -0500
X-MC-Unique: aIV68sjPOVCoRuWxVPV2LQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13D7B10135EF;
 Tue, 30 Jan 2024 21:51:37 +0000 (UTC)
Received: from localhost (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3314A492BC7;
 Tue, 30 Jan 2024 21:51:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 0/5] Block patches
Date: Tue, 30 Jan 2024 16:51:29 -0500
Message-ID: <20240130215134.346557-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit 11be70677c70fdccd452a3233653949b79e97908:

  Merge tag 'pull-vfio-20240129' of https://github.com/legoater/qemu into staging (2024-01-29 10:53:56 +0000)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 954b33daee83fe79293fd81c2f7371db48e7d6bd:

  hw/block/block.c: improve confusing blk_check_size_and_read_all() error (2024-01-30 16:19:00 -0500)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Fiona Ebner (1):
  block/io_uring: improve error message when init fails

Manos Pitsidianakis (2):
  hw/core/qdev.c: add qdev_get_human_name()
  hw/block/block.c: improve confusing blk_check_size_and_read_all()
    error

Richard W.M. Jones (1):
  block/blkio: Make s->mem_region_alignment be 64 bits

Stefan Hajnoczi (1):
  pflash: fix sectors vs bytes confusion in blk_pread_nonzeroes()

 include/hw/block/block.h |  4 ++--
 include/hw/qdev-core.h   | 14 ++++++++++++++
 block/blkio.c            |  2 +-
 block/io_uring.c         |  2 +-
 hw/block/block.c         | 27 ++++++++++++++++-----------
 hw/block/m25p80.c        |  3 ++-
 hw/block/pflash_cfi01.c  |  4 ++--
 hw/block/pflash_cfi02.c  |  2 +-
 hw/core/qdev.c           |  8 ++++++++
 9 files changed, 47 insertions(+), 19 deletions(-)

-- 
2.43.0


