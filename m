Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824E0CA0EDB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 20:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulv9w-0001mX-8p; Tue, 12 Aug 2025 15:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulv9Y-0001hf-M5
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 15:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ulv9O-0006LS-SA
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 15:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755028749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u19Ue/jtFWlQDRK24acRKFbAKxp2l1khq7fKiBn7iyk=;
 b=ds8jj8ro/csuc5lIjYB3a4zwB9SuPSoqMT/mV/feuVoO09SLbIfporJCbHdy2L9Nw2Z866
 m87gN4xlYO/k0vrZI/ilgPrLgHhRz4qg9aSHj6URGF1mkFvYdD6VnSi+0v6CT43JG9U1Ts
 PyoTy740ZGIEKwfGD0iLgGIdM5ULQUg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-ITCVlavlN0aFXXZusuzASg-1; Tue,
 12 Aug 2025 15:59:06 -0400
X-MC-Unique: ITCVlavlN0aFXXZusuzASg-1
X-Mimecast-MFC-AGG-ID: ITCVlavlN0aFXXZusuzASg_1755028745
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0AD61800347; Tue, 12 Aug 2025 19:59:05 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.181])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A873D180028D; Tue, 12 Aug 2025 19:59:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/3] Patches for QEMU 10.1.0-rc3
Date: Tue, 12 Aug 2025 21:58:58 +0200
Message-ID: <20250812195901.305895-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit 624d7463043c120facfab2b54985fcfb679d5379:

  Merge tag 'pull-nvme-20250811' of https://gitlab.com/birkelund/qemu into staging (2025-08-11 12:57:55 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to c0df98ab1f3d348bc05f09d1c093abc529f2b530:

  qemu-iotests: Ignore indentation in Killed messages (2025-08-12 17:13:13 +0200)

----------------------------------------------------------------
Patches for QEMU 10.1.0-rc3

- configure: Don't disable Rust for too old meson version
- rbd: Fix hang in query-named-block-nodes if the server is down
- iotests: Fix reference output for newer bash versions

----------------------------------------------------------------
Kevin Wolf (2):
      configure: Don't disable Rust for too old meson version
      rbd: Fix .bdrv_get_specific_info implementation

Werner Fink (1):
      qemu-iotests: Ignore indentation in Killed messages

 qapi/block-core.json             |   9 +++-
 configure                        |   8 +--
 block/rbd.c                      | 104 +++++++++++++++++++++++++--------------
 pythondeps.toml                  |   4 ++
 tests/qemu-iotests/039.out       |  10 ++--
 tests/qemu-iotests/061.out       |   4 +-
 tests/qemu-iotests/137.out       |   2 +-
 tests/qemu-iotests/common.filter |   2 +-
 8 files changed, 94 insertions(+), 49 deletions(-)


