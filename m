Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6C606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e9fBMBmn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMp1-0006Wt-GF; Tue, 17 Nov 2026 12:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMot-0006VE-KY
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMor-0006XT-LM
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794935888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AB+XUP+Dtrs1fgH1rYxV/GclfPH4H6j3RvBCrBN+9Eg=;
 b=e9fBMBmn2Q8EJ5MDysWNMU08UeED1xoWc2f/npyGtADeKeJv62TMqfRcrpH2ceLVra/Xcp
 FKallG1Q5uJ0BqxRK8H7XjaD2G+3tn2qWJ28Xp3krRPlW8EpDJZSj5tA5x9xIFz9Z/8eHA
 TlUHYoST/Hr+rIBhpuUxcYLbUENDJf8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-HfqrvQkINVGTvgBP_1P5Pg-1; Tue,
 17 Nov 2026 12:18:05 -0500
X-MC-Unique: HfqrvQkINVGTvgBP_1P5Pg-1
X-Mimecast-MFC-AGG-ID: HfqrvQkINVGTvgBP_1P5Pg_1794935884
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA2401800370; Tue, 17 Nov 2026 17:18:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 989CD195B3C5; Tue, 17 Nov 2026 17:18:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 0/8] Block layer patches
Date: Tue, 17 Nov 2026 18:17:50 +0100
Message-ID: <20261117171758.237462-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 97c88c61d45dee6e1f9bc160a338048189846d28:

  Merge tag 'docs-security-devices-pull-request' of https://gitlab.com/berrange/qemu into staging (2026-11-16 15:48:48 -0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 4f5c09c6228f317eab3144ecc27e8b13b3526128:

  block: notify only the replaced child in bdrv_replace_child_bs() (2026-11-17 11:46:13 +0100)

----------------------------------------------------------------
Block layer patches

- vhdx, bochs: Image validation fixes
- Fix the size change notification in bdrv_replace_child_bs()
- iotests: Minor fixes to deal more correctly with exotic environments

----------------------------------------------------------------
Daniel P. Berrangé (1):
      iotests: better heuristics to find I/O tests build/source dirs

Denis V. Lunev (3):
      block: read the old child length after draining in bdrv_replace_child_bs()
      block: add bdrv_child_notify_resize() to notify a single parent
      block: notify only the replaced child in bdrv_replace_child_bs()

John Snow (1):
      iotests: fix false positive on running-outside-venv warning

Thomas Huth (2):
      block/vhdx-log: Improve sanity checks to avoid OOB accesses with bad images
      block/vhdx: Add alignment checks for region tables

malike (1):
      block/bochs: validate bitmap size and compute extent_blocks after validation

 include/block/block_int-io.h  |  8 ++++++-
 block.c                       |  7 +++---
 block/bochs.c                 |  9 +++++++-
 block/io.c                    | 14 +++++++++---
 block/vhdx-log.c              |  6 ++++-
 block/vhdx.c                  | 10 +++++++++
 tests/qemu-iotests/testenv.py |  8 +++----
 meson.build                   |  1 +
 tests/qemu-iotests/check      | 52 +++++++++++++++++++++++++++++++------------
 9 files changed, 88 insertions(+), 27 deletions(-)


