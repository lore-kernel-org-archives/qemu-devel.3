Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7193DD0E6F5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 16:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvjC-0006vL-Ed; Tue, 25 Nov 2025 11:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNvj0-0006iD-C2
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNviy-00055n-Ls
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764087424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9EYne/U2lOtK4WxmzRZ90O8UCLP1jtk4ugZslSlcZgk=;
 b=glSiTScG4Y5RAxyqj3cvIStPO7MdnyUe2FKo4VOYj1mwV/bFLBFaD7HZp5SuvV5vZs6y8P
 qI1lxKF3d49bHy0799fVSqoNOulHluRdqOxvb4BMglomPa6DaX3gfWLfrGqy79CweiGavO
 wPyGARZBlLLXQFKJcJJgl1bqHtu0ZH4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-gsijGdPHOmuR_V9oiCdkIQ-1; Tue,
 25 Nov 2025 11:17:00 -0500
X-MC-Unique: gsijGdPHOmuR_V9oiCdkIQ-1
X-Mimecast-MFC-AGG-ID: gsijGdPHOmuR_V9oiCdkIQ_1764087419
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69E6E1954237; Tue, 25 Nov 2025 16:16:59 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB75E1800576; Tue, 25 Nov 2025 16:16:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 0/4] Block layer patches
Date: Tue, 25 Nov 2025 17:16:44 +0100
Message-ID: <20251125161648.259321-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit de074358e99b8eb5076d3efa267e44c292c90e3e:

  Merge tag 'pull-target-arm-20251124' of https://gitlab.com/pm215/qemu into staging (2025-11-24 09:03:12 -0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 59a1cf0cd31597d2f6e2c18dc400a1de8427d47d:

  iotests: add Linux loop device image creation test (2025-11-25 15:26:22 +0100)

----------------------------------------------------------------
Block layer patches

- Image creation: Honour pwrite_zeroes_alignment for zeroing first sector
- block-backend: Fix race (causing a crash) when resuming queued requests

----------------------------------------------------------------
Kevin Wolf (1):
      block-backend: Fix race when resuming queued requests

Stefan Hajnoczi (3):
      file-posix: populate pwrite_zeroes_alignment
      block: use pwrite_zeroes_alignment when writing first sector
      iotests: add Linux loop device image creation test

 include/system/block-backend-io.h             |  1 +
 block.c                                       |  3 +-
 block/block-backend.c                         | 19 +++++++--
 block/file-posix.c                            | 16 ++++++++
 tests/qemu-iotests/tests/loop-create-file     | 59 +++++++++++++++++++++++++++
 tests/qemu-iotests/tests/loop-create-file.out |  8 ++++
 6 files changed, 102 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/loop-create-file
 create mode 100644 tests/qemu-iotests/tests/loop-create-file.out


