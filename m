Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1496AC5DF9F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRpt-0006Ug-Mp; Fri, 21 Aug 2026 12:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpr-0006T3-L8
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpo-0001X5-P0
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787328670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7YxZhX9W0QIrwYGrb3PZ2y1mXrGJtjPkFTFisIqGZos=;
 b=GGgH2aNSCyuJYkoaLaHaJ3yBzkMOSjAUnRVENdcAEiByfd6irpChUOGr0eIjPDgSRCyPVl
 6Tcu60nJv/k3UTFx2lQQQGM7hkaLSksS9rDoXoPB39E2KVb4EtBA79Ll7TY+tVTMAXoTlH
 7LjYEsEZl8yfOOW0zvP2pJj2HO3xzM0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-D0w-o_rFP42qW3_jgAOJXg-1; Fri,
 21 Aug 2026 12:11:08 -0400
X-MC-Unique: D0w-o_rFP42qW3_jgAOJXg-1
X-Mimecast-MFC-AGG-ID: D0w-o_rFP42qW3_jgAOJXg_1787328666
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF253195422F; Fri, 21 Aug 2026 16:11:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.30])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F46F1955F71; Fri, 21 Aug 2026 16:11:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3D13718003AC; Fri, 21 Aug 2026 18:11:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/12] Igvm 20260821 patches
Date: Fri, 21 Aug 2026 18:10:48 +0200
Message-ID: <20260821161103.3489298-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit ae4f3443209ab154b48b706a146e5f557ab147cb:

  Merge tag 'qtest-20260819-pull-request' of https://gitlab.com/farosas/qemu into staging (2026-08-19 08:21:57 -0700)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/igvm-20260821-pull-request

for you to fetch changes up to e27a2b5f36a0fc913ab9a55a00f77a33ec6cc4f0:

  Update MAINTAINERS (2026-08-20 16:40:33 +0200)

----------------------------------------------------------------
igvm + vmlaunchupdate: allow guests supply their own igvm firmware images.

----------------------------------------------------------------

Ani Sinha (9):
  MAINTAINERS: elevating myself to be a maintainer for igvm
  system/memory: add a tracepoint for memory_region_finalize
  backends/igvm: add a tracepoint for qigvm_cleanup_memory
  hw/misc/vmlaunchupdate: add api header
  hw/misc/vmlaunchupdate: Introduce hypervisor fw-cfg interface support
  docs/spec: Add a specification document for vm-launch-update device
  tests/qtest: Add small igvm files for testing purpose
  Add functional and unit tests for the vm-launch-update device
  Update MAINTAINERS

Gerd Hoffmann (3):
  igvm: store IgvmCfg pointer in QIgvm
  igvm: track memory regions
  igvm: cleanup memory regions

 .../aarch64/test_vm_launch_update_aarch.py    |  33 +
 .../x86_64/test_vm_launch_update.py           |  48 ++
 include/hw/misc/vmlaunchupdate.h              |  38 ++
 .../standard-headers/misc/vmlaunchupdate.h    | 102 +++
 include/system/igvm-internal.h                |   8 +-
 include/system/igvm.h                         |   1 +
 backends/igvm-cfg.c                           |   3 +
 backends/igvm.c                               |  97 ++-
 hw/misc/vmlaunchupdate.c                      | 333 ++++++++++
 system/memory.c                               |   1 +
 tests/qtest/launchupdate-test.c               | 625 ++++++++++++++++++
 MAINTAINERS                                   |  15 +-
 backends/trace-events                         |   1 +
 docs/specs/index.rst                          |   1 +
 docs/specs/vmlaunchupdate.rst                 | 198 ++++++
 hw/misc/meson.build                           |   3 +
 hw/misc/trace-events                          |   6 +
 system/trace-events                           |   1 +
 tests/data/igvm/README                        |  45 ++
 tests/data/igvm/hello.igvm                    | Bin 0 -> 137112 bytes
 tests/data/igvm/qemuinit.igvm                 | Bin 0 -> 137112 bytes
 tests/functional/aarch64/meson.build          |   4 +
 tests/functional/x86_64/meson.build           |   4 +
 tests/qtest/meson.build                       |   2 +
 24 files changed, 1535 insertions(+), 34 deletions(-)
 create mode 100755 tests/functional/aarch64/test_vm_launch_update_aarch.py
 create mode 100755 tests/functional/x86_64/test_vm_launch_update.py
 create mode 100644 include/hw/misc/vmlaunchupdate.h
 create mode 100644 include/standard-headers/misc/vmlaunchupdate.h
 create mode 100644 hw/misc/vmlaunchupdate.c
 create mode 100644 tests/qtest/launchupdate-test.c
 create mode 100644 docs/specs/vmlaunchupdate.rst
 create mode 100644 tests/data/igvm/README
 create mode 100644 tests/data/igvm/hello.igvm
 create mode 100644 tests/data/igvm/qemuinit.igvm

-- 
2.55.0


