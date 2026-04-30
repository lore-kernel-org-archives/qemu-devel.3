Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3EDCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITsf-0002OZ-RQ; Thu, 30 Apr 2026 12:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrK-0007c8-SE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrF-000792-Or
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777564995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zHItjbRmydxzgShosbschexFUUn4luf9pcS3lhU7UgY=;
 b=IHOLRwN0RnoCx4+dd1KixoRSqAyHX7Mdrn8KqXVyDcz9j3eaAleEnAsx+MfQzPYYiVVOZ3
 osuDB2FLJClI6oe3yhW8I2mLDXo2tzf3oAd8bJ8g3KsHspYUbgxL9fX26uyDsEIfXW2vrV
 roWpNrER3yJJkuHhMTHQV2tLfhFuTAY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-MScP-g7ZMqi2i5H3nNZybw-1; Thu,
 30 Apr 2026 12:03:13 -0400
X-MC-Unique: MScP-g7ZMqi2i5H3nNZybw-1
X-Mimecast-MFC-AGG-ID: MScP-g7ZMqi2i5H3nNZybw_1777564992
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84E8E1800601; Thu, 30 Apr 2026 16:03:12 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.50.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D39D1800347; Thu, 30 Apr 2026 16:03:10 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 00/11] First batch of s390x updates for 11.1
Date: Thu, 30 Apr 2026 18:02:56 +0200
Message-ID: <20260430160307.634093-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

[Changes from v1: dropped since-merged machine types patch, added fix for
functional test]

The following changes since commit 282771e1f9b9b6e0147adf5f9d676325175b1767:

  Merge tag 'pull-riscv-to-apply-20260429-1' of https://github.com/alistair23/qemu into staging (2026-04-29 09:22:51 -0400)

are available in the Git repository at:

  https://gitlab.com/cohuck/qemu tags/s390x-20260430

for you to fetch changes up to bbb412adc4a6e6a11806a5d778da6aa1c24edf56:

  tests/functional/s390x: Update expected virtio-pci IDs (2026-04-30 16:59:09 +0200)

----------------------------------------------------------------
First batch of s390x updates for 11.1:
- disable legacy virtio-pci from now on by default (did not work anyway)
- add a new boot test
- simplifications and cleanups

----------------------------------------------------------------

Eric Farman (1):
  MAINTAINERS: Update s390 trees

Jaehoon Kim (1):
  hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)

Matthew Rosato (1):
  tests/functional/s390x: Update expected virtio-pci IDs

Philippe Mathieu-Daudé (6):
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
  configs/targets: Restrict the legacy ldst_phys() API on s390x target
  target/s390x: Prefer MO_128 definition over magic value

Thomas Huth (2):
  target/s390x/kvm: Simplify the async pfault handling code
  tests/functional/s390x: Add test for booting from a disk with 4k
    sectors

 MAINTAINERS                               |   6 +-
 configs/targets/s390x-softmmu.mak         |   1 +
 hw/s390x/s390-virtio-ccw.c                |  26 ++++
 target/s390x/cpu-system.c                 |   2 +-
 target/s390x/kvm/kvm.c                    |  64 +++-------
 target/s390x/mmu_helper.c                 |   5 +-
 target/s390x/tcg/excp_helper.c            |  21 ++--
 target/s390x/tcg/mem_helper.c             |  12 +-
 target/s390x/tcg/translate_vx.c.inc       |   2 +-
 tests/functional/s390x/meson.build        |   1 +
 tests/functional/s390x/test_boot_4k.py    | 138 ++++++++++++++++++++++
 tests/functional/s390x/test_ccw_virtio.py |   4 +-
 12 files changed, 213 insertions(+), 69 deletions(-)
 create mode 100755 tests/functional/s390x/test_boot_4k.py

-- 
2.53.0


