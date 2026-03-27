Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49F210F2861
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6B35-0006YL-Fh; Fri, 27 Mar 2026 13:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w6B33-0006Y1-1t
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w6B30-0007y7-1Y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774632756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gn3jrtSyozbHerGqTPMze7M1HW6JN1Jbqrfe547XgwE=;
 b=Ifw+a4m/jAin3xWGiJFbRfQ192BJkDXrfoVo6FiuCf9TAg+S1jWsLqX4DmTLc0Hx8phFau
 VoutL/08GKHY6Thi/Hlm1QSfN4pmFd5Wb+lBmqOTO+RRWK4k4R2ksbh7Ungl0twtGihh6p
 WmkvUOuftYSdIFQZZ/JY816dyiw5R3k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-U5MYos7pPhyL5CRyhdxYaA-1; Fri,
 27 Mar 2026 13:32:33 -0400
X-MC-Unique: U5MYos7pPhyL5CRyhdxYaA-1
X-Mimecast-MFC-AGG-ID: U5MYos7pPhyL5CRyhdxYaA_1774632749
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A85EC180044D; Fri, 27 Mar 2026 17:32:28 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.bengluru.csb (unknown [10.74.88.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17DD730001A1; Fri, 27 Mar 2026 17:32:20 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, pierrick.bouvier@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, mohamed@unpredictable.fr, philmd@linaro.org,
 Mohammadfaiz Bawa <mbawa@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 1/3] docs/specs/tpm: document PPI support on ARM64 virt
Date: Fri, 27 Mar 2026 23:02:07 +0530
Message-ID: <20260327173209.148180-2-mbawa@redhat.com>
In-Reply-To: <20260327173209.148180-1-mbawa@redhat.com>
References: <20260327173209.148180-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Document that tpm-tis-device on the ARM virt machine supports PPI
with dynamically allocated MMIO via the platform bus, unlike x86
where PPI is at the fixed address 0xFED45000.

Also add hw/arm/virt-acpi-build.c and hw/acpi/tpm.c to the list
of files related to TPM ACPI tables.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 docs/specs/tpm.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index b630a351b4..ba2b0d7267 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -187,8 +187,32 @@ The location of the table is given by the fw_cfg ``tpmppi_address``
 field.  The PPI memory region size is 0x400 (``TPM_PPI_ADDR_SIZE``) to
 leave enough room for future updates.
 
+PPI on ARM64 virt
+-----------------
+
+The ARM virt machine supports PPI for ``tpm-tis-device`` as defined
+in the `PPI specification`_.
+
+Unlike the x86 TIS device where the PPI memory region is mapped at
+the fixed address ``0xFED45000`` (within the TIS MMIO range), the
+ARM64 sysbus device registers PPI memory as a second MMIO region
+on the platform bus. The platform bus assigns the guest physical
+address dynamically at device plug time. The ACPI ``_DSM`` method
+and PPI operation regions reference this dynamically resolved
+address.
+
+PPI is controlled by the ``ppi`` property (default ``on``)::
+
+    -device tpm-tis-device,tpmdev=tpm0,ppi=on
+
+Without PPI, guest operating systems such as Windows 11
+ARM64 will log errors when attempting to query TPM Physical
+Presence capabilities via the ACPI ``_DSM`` method.
+
 QEMU files related to TPM ACPI tables:
  - ``hw/i386/acpi-build.c``
+ - ``hw/arm/virt-acpi-build.c``
+ - ``hw/acpi/tpm.c``
  - ``include/hw/acpi/tpm.h``
 
 TPM backend devices
-- 
2.53.0


