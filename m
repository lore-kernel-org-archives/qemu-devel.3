Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFBDC28B22
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 09:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq7eI-0008Sk-V2; Thu, 06 Mar 2025 04:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eG-0008S2-EX
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eE-0002A0-5t
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741253768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EgcuTHvlXcfEotO4OUFKwqzMuaFqBKh1DlQUqPo7CsI=;
 b=fIN03+hHUI+JKyahKhInuPTLH5F1jQCoumC20U06CVbtu0YAeGglRGHIcwHtu5aPBosZmn
 VDxwa7im8XgT0+uwnnaDJt2z4VBm6oJAN1CB8Y0tQYiSWDTONFDMuRnG9ibFjaAiVXVyDb
 1R3UUpJ6vnX2OU4aEEhugxDv4CYnei8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-l2mffnA2OMWOJwW_oyzn9Q-1; Thu,
 06 Mar 2025 04:36:06 -0500
X-MC-Unique: l2mffnA2OMWOJwW_oyzn9Q-1
X-Mimecast-MFC-AGG-ID: l2mffnA2OMWOJwW_oyzn9Q_1741253765
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99FB81800349
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 502421955DCE
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B2B7F21E675F; Thu, 06 Mar 2025 10:36:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/10] QAPI patches patches for 2025-03-06
Date: Thu,  6 Mar 2025 10:35:51 +0100
Message-ID: <20250306093601.2264772-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The following changes since commit e8a01102936286e012ed0f00bd7f3b7474d415c9:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-03-05 21:58:23 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-03-06

for you to fetch changes up to 71ba2613ad470b6397868ae7333cd255e467be68:

  docs/devel/qapi-code-gen: Discourage use of 'prefix' (2025-03-06 10:33:05 +0100)

----------------------------------------------------------------
QAPI patches patches for 2025-03-06

----------------------------------------------------------------
Markus Armbruster (10):
      docs/about/build-platforms: Correct minimum supported Python version
      qapi: Eliminate OrderedDict
      qapi/introspect: Use @dataclass to simplify
      qdev: Delete unused qdev_prop_enum
      qdev: Change qdev_prop_pci_devfn member @name from "int32" to "str"
      qdev: Rename PropertyInfo member @name to @type
      qdev: Change values of PropertyInfo member @type to be QAPI types
      qdev: Improve PropertyInfo member @description for enum properties
      qdev: Improve a few more PropertyInfo @description members
      docs/devel/qapi-code-gen: Discourage use of 'prefix'

 docs/about/build-platforms.rst   |  2 +-
 docs/devel/qapi-code-gen.rst     |  3 +-
 include/hw/qdev-properties.h     |  3 +-
 backends/tpm/tpm_util.c          |  2 +-
 hw/block/xen-block.c             |  4 +-
 hw/core/qdev-properties-system.c | 80 +++++++++++++++++++---------------------
 hw/core/qdev-properties.c        | 44 ++++++++++------------
 hw/misc/xlnx-versal-trng.c       |  2 +-
 hw/nvme/nguid.c                  |  2 +-
 hw/nvram/xlnx-bbram.c            |  2 +-
 hw/nvram/xlnx-efuse.c            |  2 +-
 hw/pci/pci.c                     |  2 +-
 hw/s390x/ccw-device.c            |  6 +--
 hw/s390x/css.c                   |  4 +-
 hw/s390x/s390-pci-bus.c          |  3 +-
 hw/vfio/pci-quirks.c             |  2 +-
 target/riscv/cpu.c               | 44 +++++++++++++++-------
 target/sparc/cpu.c               |  3 +-
 hw/display/apple-gfx.m           |  2 +-
 scripts/qapi/introspect.py       | 12 +++---
 scripts/qapi/parser.py           |  5 +--
 scripts/qapi/schema.py           | 11 +++---
 tests/qapi-schema/test-qapi.py   | 11 +-----
 23 files changed, 123 insertions(+), 128 deletions(-)

-- 
2.48.1


