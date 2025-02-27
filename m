Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E560C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZgk-0003ca-9D; Thu, 27 Feb 2025 03:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnZgj-0003cO-6t
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnZgh-0001k0-2t
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740646569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FFQuXiQF1ESSl3fy9foLdxtXnjchWDdN0+l280fFDUs=;
 b=ZyCIjUU0Qmr9ZqmgCcied+7uoU6f08bgvAaCb/yqVp/xi46nwC2U+SwoU+Tv32pa/8S0cS
 YtdIXYxNqykKY/qC4MBbXQViYsgoYg05+OnVDzsCKdiNF4WvqN4UyDGWaJ53SOYMok+RRX
 Tl0qMjt0anDwkz/UeeFujqDZU24yBIA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-Wv4c5N8iPaKRRNoYXaPJlw-1; Thu,
 27 Feb 2025 03:56:06 -0500
X-MC-Unique: Wv4c5N8iPaKRRNoYXaPJlw-1
X-Mimecast-MFC-AGG-ID: Wv4c5N8iPaKRRNoYXaPJlw_1740646566
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0065319560B5; Thu, 27 Feb 2025 08:56:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95C231800357; Thu, 27 Feb 2025 08:56:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03E2821E6741; Thu, 27 Feb 2025 09:56:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com,
	eduardo@habkost.net
Subject: [PATCH v2 0/6] Property type reporting improvements
Date: Thu, 27 Feb 2025 09:55:55 +0100
Message-ID: <20250227085601.4140852-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

QOM properties could use similar work.  Left for another day.

v2: Rebased

Markus Armbruster (6):
  qdev: Delete unused qdev_prop_enum
  qdev: Change qdev_prop_pci_devfn member @name from "int32" to "str"
  qdev: Rename PropertyInfo member @name to @type
  qdev: Change values of PropertyInfo member @type to be QAPI types
  qdev: Improve PropertyInfo member @description for enum properties
  qdev: Improve a few more PropertyInfo @description members

 include/hw/qdev-properties.h     |  3 +-
 backends/tpm/tpm_util.c          |  2 +-
 hw/block/xen-block.c             |  4 +-
 hw/core/qdev-properties-system.c | 78 +++++++++++++++-----------------
 hw/core/qdev-properties.c        | 44 ++++++++----------
 hw/misc/xlnx-versal-trng.c       |  2 +-
 hw/nvme/nguid.c                  |  2 +-
 hw/nvram/xlnx-bbram.c            |  2 +-
 hw/nvram/xlnx-efuse.c            |  2 +-
 hw/pci/pci.c                     |  2 +-
 hw/s390x/ccw-device.c            |  6 +--
 hw/s390x/css.c                   |  4 +-
 hw/s390x/s390-pci-bus.c          |  3 +-
 hw/vfio/pci-quirks.c             |  2 +-
 target/riscv/cpu.c               | 44 ++++++++++++------
 target/sparc/cpu.c               |  3 +-
 hw/display/apple-gfx.m           |  2 +-
 17 files changed, 106 insertions(+), 99 deletions(-)

-- 
2.48.1


