Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9510606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkArkYCM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyWn-0007Zg-P5; Sun, 08 Nov 2026 03:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWl-0007Y4-0X; Sun, 08 Nov 2026 03:45:27 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWj-0000HU-Cc; Sun, 08 Nov 2026 03:45:26 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDAEB612F8;
 Sun,  8 Nov 2026 08:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C651F008A4;
 Sun,  8 Nov 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794127516;
 bh=pKRyi/P8OXU4hT2prHBcACIMzgezdIbO+h5QJsXXbDw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BkArkYCMZfwSckb55IDsFd454rLz/obmEjUAondI9pwNIZZXokQA8uDksjIE3nT/z
 AxXZ+M1hquu9yfDv0NR1WpDbOubDBkixIbvuX0yjxKdnCsoK9UNKbeSNmYQcbpZNx2
 SGrrf/GeYFySreSnOu2+n/E7SP00GA1u06IUdyR75IYJu23S5pswBGVTzKi/5qFrKB
 sFXzeukaap7cLxA5t0DMTITjOHHm2zxP0Ey9UhH4Ulg7kjjw7YOZI87Tv/ksB7Yox+
 Nv2jHSDnOB/STezmm/Hd7RphdRlDS/EATnYsnJISYZGpNJiqyB6Fra4hdSsPTZfVLh
 g4U7NHUyS/l0g==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyWY-00000005TMf-2ovO; Sun, 08 Nov 2026 09:45:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 6/8] docs: acpi_hest_ghes: document notification mechanisms
Date: Sun,  8 Nov 2026 09:45:07 +0100
Message-ID: <5474e7a37809445a46c862c61f96005204cd0ccb.1794124132.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794124132.git.mchehab+huawei@kernel.org>
References: <cover.1794124132.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, the HEST spec mixes generic support with arch dependent
notification mechanisms.

Move the arm-specific notifications to a separate chapter and add
a new one describing x86 mechanisms.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 docs/specs/acpi_hest_ghes.rst | 44 ++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index aaf7b1ad11a5..1a32550ef3a1 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -7,6 +7,7 @@ APEI tables generating and CPER record
    This work is licensed under the terms of the GNU GPL, version 2 or later.
    See the COPYING file in the top-level directory.
 
+
 Design Details
 --------------
 
@@ -105,14 +106,39 @@ Design Details
     firmware will write back the start address of either "etc/hardware_errors"
     or HEST table at the corresponding fw_cfg file.
 
-(9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
-    "Error Status Data Block", guest memory, and then injects platform specific
-    interrupt (in case of arm/virt machine it's Synchronous External Abort) as a
-    notification which is necessary for notifying the guest.
+.. note::
 
-(10) This notification (in virtual hardware) will be handled by the guest
-     kernel, on receiving notification, guest APEI driver could read the CPER error
-     and take appropriate action.
+    GHES support requires ACPI and ``-machine ras=on``.
 
-(11) kvm_arch_on_sigbus_vcpu() reports RAS errors via a SEA notifications,
-     when a SIGBUS event is triggered.
+Notifications on ARM64
+----------------------
+
+The ARM64 ``virt`` machine supports two GHESv2 notification sources:
+
+* source 0: Synchronous External Abort (SEA);
+* source 1: GPIO notification delivered through a Generic Event Device (GED).
+
+Source 0 reports hardware-memory RAS events on the ``virt`` machine:
+
+* When QEMU receives a ``SIGBUS`` from the kernel, it writes the CPER into the
+  corresponding ``Error Status Data Block`` in guest memory and reports the
+  event through a Synchronous External Abort (SEA). The guest kernel handle
+  the SEA,
+
+* The guest APEI driver can read and process the CPER record.
+
+* ``kvm_arch_on_sigbus_vcpu()`` reports these RAS events through SEA.
+
+When source 1 is available, QEMU supports GHES error injection through the QMP
+interface.
+
+
+Notifications on x86
+--------------------
+
+The ``pc`` and ``q35`` machines support one GHESv2 source:
+
+* source 1: System Control Interrupt (SCI).
+
+When source 1 is available, QEMU supports GHES error injection through
+the QMP interface.
-- 
2.56.0


