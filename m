Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67296C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmCcm-0002eP-Cs; Mon, 18 Mar 2024 09:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCcS-0002Ob-8n
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCcL-0007eO-Id
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710766888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xQX9GP1gk5DXFtS7l3lo8iA5EQC/5pxNmFjeUDgOxw0=;
 b=f4bwKj3o9Q12H+ueXLPNynQPFbe35xu1OZdRVXtFUUWFqMe0l1Q6YidiX4TC3St012Na7h
 K8ZeYkSWX+8aeKcMQ+QQ1RG5Sdj/3tLwsAtOKSCXIluMS0i16xrguBVPiX7GtlwbAvsxoo
 1A+H35QA6wUVnmCSDgTH/OwfNsFah1A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-9PbCJ3E-NEySRdKZwW0wtQ-1; Mon,
 18 Mar 2024 09:01:26 -0400
X-MC-Unique: 9PbCJ3E-NEySRdKZwW0wtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 177263801F5C;
 Mon, 18 Mar 2024 13:01:26 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD4B2166B33;
 Mon, 18 Mar 2024 13:01:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/15] Block layer patches
Date: Mon, 18 Mar 2024 14:01:03 +0100
Message-ID: <20240318130118.358920-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:

  Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 39a94d7c34ce9d222fa9c0c99a14e20a567456d7:

  iotests: adapt to output change for recently introduced 'detached header' field (2024-03-18 13:33:54 +0100)

----------------------------------------------------------------
Block layer patches

- mirror: Fix deadlock
- nbd/server: Fix race in draining the export
- qemu-img snapshot: Fix formatting with large values
- Fix blockdev-snapshot-sync error reporting for no medium
- iotests fixes

----------------------------------------------------------------
Abhiram Tilak (1):
      qemu-img: Fix Column Width and Improve Formatting in snapshot list

Fiona Ebner (1):
      iotests: adapt to output change for recently introduced 'detached header' field

Kevin Wolf (3):
      mirror: Don't call job_pause_point() under graph lock
      nbd/server: Fix race in draining the export
      iotests: Add test for reset/AioContext switches with NBD exports

Markus Armbruster (1):
      blockdev: Fix blockdev-snapshot-sync error reporting for no medium

Thomas Huth (9):
      tests/qemu-iotests: Fix test 033 for running with non-file protocols
      tests/qemu-iotests: Restrict test 066 to the 'file' protocol
      tests/qemu-iotests: Restrict test 114 to the 'file' protocol
      tests/qemu-iotests: Restrict test 130 to the 'file' protocol
      tests/qemu-iotests: Restrict test 134 and 158 to the 'file' protocol
      tests/qemu-iotests: Restrict test 156 to the 'file' protocol
      tests/qemu-iotests: Restrict tests that use --image-opts to the 'file' protocol
      tests/qemu-iotests: Fix some tests that use --image-opts for other protocols
      tests/qemu-iotests: Restrict tests using "--blockdev file" to the file protocol

 include/qemu/job.h                                 |  2 +-
 block/mirror.c                                     | 10 ++--
 block/qapi.c                                       | 10 ++--
 blockdev.c                                         |  3 +-
 nbd/server.c                                       | 15 +++--
 tests/qemu-iotests/033                             |  6 +-
 tests/qemu-iotests/066                             |  2 +-
 tests/qemu-iotests/114                             |  2 +-
 tests/qemu-iotests/130                             |  2 +-
 tests/qemu-iotests/134                             |  2 +-
 tests/qemu-iotests/156                             |  2 +-
 tests/qemu-iotests/158                             |  2 +-
 tests/qemu-iotests/176.out                         | 16 +++---
 tests/qemu-iotests/188                             |  2 +-
 tests/qemu-iotests/189                             |  2 +-
 tests/qemu-iotests/198                             |  2 +-
 tests/qemu-iotests/198.out                         |  2 +
 tests/qemu-iotests/206.out                         |  1 +
 tests/qemu-iotests/261                             |  4 +-
 tests/qemu-iotests/263                             |  6 +-
 tests/qemu-iotests/267.out                         | 48 ++++++++--------
 tests/qemu-iotests/284                             |  7 +--
 tests/qemu-iotests/286                             |  3 +-
 tests/qemu-iotests/286.out                         |  2 +-
 .../tests/detect-zeroes-registered-buf             |  4 +-
 tests/qemu-iotests/tests/iothreads-nbd-export      | 66 ++++++++++++++++++++++
 tests/qemu-iotests/tests/iothreads-nbd-export.out  | 19 +++++++
 tests/qemu-iotests/tests/qcow2-internal-snapshots  |  2 +-
 .../tests/qcow2-internal-snapshots.out             | 14 ++---
 tests/qemu-iotests/tests/qsd-jobs                  |  2 +-
 30 files changed, 178 insertions(+), 82 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/iothreads-nbd-export
 create mode 100644 tests/qemu-iotests/tests/iothreads-nbd-export.out


