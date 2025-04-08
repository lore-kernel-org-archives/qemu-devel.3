Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB57C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 13:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28a3-0006pe-IS; Tue, 08 Apr 2025 09:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u28Zb-0006lb-69
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 09:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u28ZZ-0005bq-3J
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 09:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744117259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RAd9S8vTP/JXZBq46HWiStXZGOPmVePRezTGa2hJIeo=;
 b=Oqv70PfdgCrW0w53W2ijvKmNDoGiLhQ41ZwzsFEJI+5tRo8/JcRn456ofIiZT4Xc4mJwED
 OahP0ZKUQmWGYgP8EtcjXRLQbC6ZgT8TZ9foZwXTB6kCBbPRpWYhiVY4esk2H30zOVTCy/
 eN4iyRF8eC/F87N5rVk7JB7ZL3GjpBI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-OtoTQsydMYW8xugXn40B5A-1; Tue,
 08 Apr 2025 09:00:54 -0400
X-MC-Unique: OtoTQsydMYW8xugXn40B5A-1
X-Mimecast-MFC-AGG-ID: OtoTQsydMYW8xugXn40B5A_1744117253
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22FA11955BC1; Tue,  8 Apr 2025 13:00:52 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C29541955BEF; Tue,  8 Apr 2025 13:00:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/4] Block layer patches
Date: Tue,  8 Apr 2025 15:00:44 +0200
Message-ID: <20250408130048.283364-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
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

The following changes since commit dfaecc04c46d298e9ee81bd0ca96d8754f1c27ed:

  Merge tag 'pull-riscv-to-apply-20250407-1' of https://github.com/alistair23/qemu into staging (2025-04-07 09:18:33 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to f8222bfba3409a3ce09c191941127a8cf2c7e623:

  test-bdrv-drain: Fix data races (2025-04-08 15:00:01 +0200)

----------------------------------------------------------------
Block layer patches

- scsi-disk: Apply error policy for host_status errors again
- qcow2: Fix qemu-img info crash with missing crypto header
- qemu-img bench: Fix division by zero for zero-sized images
- test-bdrv-drain: Fix data races

----------------------------------------------------------------
Denis Rastyogin (1):
      qemu-img: fix division by zero in bench_cb() for zero-sized images

Kevin Wolf (2):
      qcow2: Don't crash qemu-img info with missing crypto header
      scsi-disk: Apply error policy for host_status errors again

Vitalii Mordan (1):
      test-bdrv-drain: Fix data races

 include/qemu/job.h                            |  3 ++
 block/qcow2.c                                 |  4 +-
 hw/scsi/scsi-disk.c                           | 39 +++++++++-----
 job.c                                         |  6 +++
 qemu-img.c                                    |  6 ++-
 tests/unit/test-bdrv-drain.c                  | 32 +++++++-----
 tests/qemu-iotests/tests/qcow2-encryption     | 75 +++++++++++++++++++++++++++
 tests/qemu-iotests/tests/qcow2-encryption.out | 32 ++++++++++++
 8 files changed, 167 insertions(+), 30 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/qcow2-encryption
 create mode 100644 tests/qemu-iotests/tests/qcow2-encryption.out


