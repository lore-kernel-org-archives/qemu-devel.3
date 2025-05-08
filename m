Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B77C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD29G-0004sz-TW; Thu, 08 May 2025 10:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD298-0004mn-Jf
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uD292-0002Fl-U5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746714159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=txgwWtnbTUer9ScQN6IxeYYWMUoE3S0dPeJnxCeBbiQ=;
 b=N/zmaq0CMrgafuSIa/DGKbZSeDE2JuqCUJSCfJpLBGVKmHp9R2achIGjTT2T+inyABL4dR
 pxK3mRhWC5nHmJE/AUtdPC7S3esbuFpbDJNMQ+9Esl62yxqHyzAr+Vmt/p6rmRcuuuIVrL
 89r0zkT0mcp39+xScLtqo7SNBnoIlEk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-MRFOxKSrNaqb8YXj0BRnfw-1; Thu,
 08 May 2025 10:22:37 -0400
X-MC-Unique: MRFOxKSrNaqb8YXj0BRnfw-1
X-Mimecast-MFC-AGG-ID: MRFOxKSrNaqb8YXj0BRnfw_1746714156
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CA331956089; Thu,  8 May 2025 14:22:36 +0000 (UTC)
Received: from localhost (unknown [10.2.16.129])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A5E618003FC; Thu,  8 May 2025 14:22:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/3] Block patches
Date: Thu,  8 May 2025 10:22:31 -0400
Message-ID: <20250508142234.44974-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

The following changes since commit 57b6f8d07f1478375f85a4593a207e936c63ff59:

  Merge tag 'pull-target-arm-20250506' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2025-05-07 14:28:20 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 624379be3a8136db420ec3a3fee36fe91e9f789e:

  block/nvme: Use host PCI MMIO API (2025-05-08 10:21:10 -0400)

----------------------------------------------------------------
Pull request

Farhan Ali's s390x host PCI support for the block/nvme.c driver.

----------------------------------------------------------------

Farhan Ali (3):
  util: Add functions for s390x mmio read/write
  include: Add a header to define host PCI MMIO functions
  block/nvme: Use host PCI MMIO API

 include/qemu/host-pci-mmio.h  | 136 +++++++++++++++++++++++++++++++
 include/qemu/s390x_pci_mmio.h |  24 ++++++
 block/nvme.c                  |  41 +++++-----
 util/s390x_pci_mmio.c         | 146 ++++++++++++++++++++++++++++++++++
 util/meson.build              |   2 +
 5 files changed, 331 insertions(+), 18 deletions(-)
 create mode 100644 include/qemu/host-pci-mmio.h
 create mode 100644 include/qemu/s390x_pci_mmio.h
 create mode 100644 util/s390x_pci_mmio.c

-- 
2.49.0


