Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5797CF532E8
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 07:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4vuD-0007pt-UD; Tue, 24 Mar 2026 03:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w4vuC-0007kj-3A
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w4vuA-00076X-MT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774336221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QvmtY2ndE20U9ZusduT+0Ynd7e7T3ItiupShUkpl02w=;
 b=cO5gw87MJFH3u4wnaRnnxzgyKrcjB5BK8DuqvVtE/0fBoKMpOdd1I2g/xlWkmnqMIQYnSF
 GnqcQYaTxl6CQAcTKoMKfdIEFqyBoIClPHX8MdfgzMpkCQdVkcAIruCmjezKz0tXh5XP6/
 YIkq+8A0Y6ut+0sZ5LRGBdUT1Hpzp1Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-UawIxxhGPeKCmg44X7FQVA-1; Tue,
 24 Mar 2026 03:10:15 -0400
X-MC-Unique: UawIxxhGPeKCmg44X7FQVA-1
X-Mimecast-MFC-AGG-ID: UawIxxhGPeKCmg44X7FQVA_1774336213
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68E8A1955E89; Tue, 24 Mar 2026 07:10:13 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.bengluru.csb (unknown [10.74.88.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86E0519560AB; Tue, 24 Mar 2026 07:10:07 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohammadfaiz Bawa <mbawa@redhat.com>
Subject: [PATCH 0/3] hw/tpm: add PPI support to tpm-tis-device on ARM64 virt
Date: Tue, 24 Mar 2026 12:40:00 +0530
Message-ID: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The ARM virt machine's tpm-tis-device lacks Physical Presence Interface
(PPI) support - no _DSM, _STA, or PPI operation regions in the ACPI
namespace. This causes Windows 11 ARM64 guests logs Event ID 15
(tpm.sys) errors after boot repeatedly.

This series documents the change, refactors tpm_build_ppi_acpi() to
accept a dynamic PPI base address, then wires up PPI MMIO and ACPI
on tpm-tis-sysbus via the platform bus.

Tested: aarch64 KVM, upstream QEMU, Win11 ARM64 25H2, swtpm.
Event ID 15 eliminated.

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


