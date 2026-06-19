Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C78CD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVa6-00062w-Qr; Fri, 19 Jun 2026 05:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waVZs-0005zg-DB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waVZq-0003Lc-Va
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781861514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l69x28eIu7IEeWF/ak2zFIrpE92f0PygpQm5XD5ovWk=;
 b=JNwXCnVSlAy16OuQtrEo3+gzHDrqjZ1J0cdgTr7KCnKgPvsKmFu02fqDbnjuTXB7jRPzdU
 nIpwEwDSOQL45h41dZ2HPWyWDcCBySREfH4xAg/uVa0poj4WfVL7XmY/0O78KNL+qp8XmU
 QF6YQU1Gqp0RXwq1D3mkeBjzpE9f92w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-DF7B2LvIN3Kt_2YvTe5sZQ-1; Fri,
 19 Jun 2026 05:31:47 -0400
X-MC-Unique: DF7B2LvIN3Kt_2YvTe5sZQ-1
X-Mimecast-MFC-AGG-ID: DF7B2LvIN3Kt_2YvTe5sZQ_1781861506
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C41A3195604B; Fri, 19 Jun 2026 09:31:45 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FEB21956088; Fri, 19 Jun 2026 09:31:42 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 0/3] hw/tpm: fix tpm-tis-device backward migration on
 aarch64
Date: Fri, 19 Jun 2026 15:01:37 +0530
Message-ID: <20260619093140.832136-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64
virt") unconditionally registers a "tpm-ppi" RAMBlock when the TPM
TIS sysbus device is realized.  This breaks backward migration: a
QEMU with PPI support cannot migrate to an older QEMU without it:

  Unknown ramblock "tpm-ppi", cannot accept migration

The failure is 100% reproducible on any aarch64 guest that uses
tpm-tis-device when migrating to a host whose QEMU predates the PPI
commit.

Fix by gating the PPI memory region behind a new "ppi" device
property, and disabling it via hw_compat_11_0[] for machine types
<= virt-11.0.  Also move the sysbus_init_mmio() calls from
instance_init to realizefn so the memory regions are properly
initialized before being registered (Peter).

Not exposing the 2nd MMIO slot when ppi=off triggers a NULL
dereference in platform_bus_get_mmio_addr(), so patch 1 adds a
guard first.

Changes in v3:
- Reordered: platform-bus NULL guard is now patch 1 (Peter)

Changes in v2:
- Dropped zero-size memory region hack (Peter)
- Moved sysbus_init_mmio() from initfn to realizefn (Peter)
- Only expose PPI MMIO region when ppi=on (Peter)
- Added NULL guard in platform_bus_get_mmio_addr() (found via testing)
- v1: https://lore.kernel.org/qemu-devel/20260618123317.633869-1-mbawa@redhat.com
- v2: https://lore.kernel.org/qemu-devel/20260619053623.756021-1-mbawa@redhat.com

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>

Mohammadfaiz Bawa (3):
  hw/core/platform-bus: guard platform_bus_get_mmio_addr() against NULL
  hw/tpm: gate PPI support on tpm-tis-device behind a device property
  hw/core/machine: disable tpm-tis-device PPI for machine type <= 11.0

 hw/core/machine.c       |  1 +
 hw/core/platform-bus.c  |  3 +--
 hw/tpm/tpm_tis.h        |  1 +
 hw/tpm/tpm_tis_sysbus.c | 18 +++++++++++-------
 4 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.54.0


