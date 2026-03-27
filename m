Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F3E10ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65gK-0006ru-K5; Fri, 27 Mar 2026 07:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w65gE-0006pu-P7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w65gD-0000MJ-0V
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774612123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R+UShz0ocf2lXLj47f99T6mQvINGjIfIkVdm8+t1xMQ=;
 b=Ml1LYOJDwSYm+tr6irTPvo8Cxp78CWx1StIwVH+hBH61VmGX85owD2d4kqX1Eg9mBpGPqN
 MoDXSk6puWpriHHydeUiRjJjteB8ykqZMMjoBfZ/say/tjgXPAfxAe98B6rYthmKUY2TMT
 sbEA6AxLiK6FmsUrSolRP6V/stNWBIc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-zbAWsZbtO9ydtA8XHEmXww-1; Fri,
 27 Mar 2026 07:48:40 -0400
X-MC-Unique: zbAWsZbtO9ydtA8XHEmXww-1
X-Mimecast-MFC-AGG-ID: zbAWsZbtO9ydtA8XHEmXww_1774612118
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72323195608B; Fri, 27 Mar 2026 11:48:38 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.bengluru.csb (unknown [10.74.88.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8869219560B1; Fri, 27 Mar 2026 11:48:32 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, pierrick.bouvier@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, mohamed@unpredictable.fr,
 Mohammadfaiz Bawa <mbawa@redhat.com>
Subject: [PATCH v2 0/3] hw/tpm: add PPI support to tpm-tis-device on ARM64 virt
Date: Fri, 27 Mar 2026 17:18:21 +0530
Message-ID: <20260327-tpm-tis-sysbus-ppi-v2-0-d8ec84d25dbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260324-tpm-tis-sysbus-ppi-ef31a7d71753
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The ARM virt machine's tpm-tis-device lacks Physical Presence Interface
(PPI) support - no _DSM, _STA, or PPI operation regions in the ACPI
namespace. This causes Windows 11 ARM64 guests to log Event ID 15
(tpm.sys) errors per boot.

This series documents the change, refactors tpm_build_ppi_acpi() to
accept a dynamic PPI base address, then wires up PPI MMIO and ACPI
on tpm-tis-sysbus via the platform bus.

Tested: aarch64 KVM, upstream QEMU, Win11 ARM64 25H2, swtpm.
Event ID 15 eliminated.

Changes in v2:
- Moved tpm.rst documentation hunk from patch 3 into patch 1 (Stefan)
- Added Reviewed-by tags

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
Mohammadfaiz Bawa (3):
      docs/specs/tpm: document PPI support on ARM64 virt
      hw/acpi/tpm: parameterize PPI base address in tpm_build_ppi_acpi
      hw/tpm: add PPI support to tpm-tis-device for ARM64 virt

 docs/specs/tpm.rst       | 24 ++++++++++++++++++++++++
 hw/acpi/tpm.c            |  8 ++++----
 hw/arm/virt-acpi-build.c |  9 ++++++++-
 hw/tpm/tpm_tis_isa.c     |  2 +-
 hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
 include/hw/acpi/tpm.h    |  3 ++-
 6 files changed, 50 insertions(+), 7 deletions(-)
---
base-commit: 8e711856d7639cbffa51405f2cc2366e3d9e3a23
change-id: 20260324-tpm-tis-sysbus-ppi-ef31a7d71753

Best regards,
-- 
Mohammadfaiz Bawa <mbawa@redhat.com>


