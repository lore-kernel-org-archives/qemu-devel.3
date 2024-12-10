Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04355E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3HE-0003dl-UT; Tue, 10 Dec 2024 11:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3HD-0003dM-Df
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3HB-00028i-01
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733848795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNJkPs+RHe7hahsiRyWvbmTQApHBBLIMrWltpogGef8=;
 b=Woy7ee4bn1MURcI+cR6zMthNblKw5SpokBeNI2TCmySafgk3LSWfOxGkeWd+/F2eamW0sN
 Y8A567ephLL9/g55F26726ehJ2VSRj/Z2V/NfzCvJaLRNm8abKz0MrWviSa9ULLr8t4u7u
 GVhXM1ucdZ0vEotCVQ5QJpzc9/1uVdA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-jIZiP20hPJ6KbVPHo9-dOg-1; Tue,
 10 Dec 2024 11:39:54 -0500
X-MC-Unique: jIZiP20hPJ6KbVPHo9-dOg-1
X-Mimecast-MFC-AGG-ID: jIZiP20hPJ6KbVPHo9-dOg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B40A1956057; Tue, 10 Dec 2024 16:39:53 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05B8A300018D; Tue, 10 Dec 2024 16:39:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, eric.mackay@oracle.com,
 anisinha@redhat.com
Subject: [PATCH 1/3] tests: acpi: whitelist expected blobs
Date: Tue, 10 Dec 2024 17:39:43 +0100
Message-ID: <20241210163945.3422623-2-imammedo@redhat.com>
In-Reply-To: <20241210163945.3422623-1-imammedo@redhat.com>
References: <20241210163945.3422623-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 42 +++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a1047913af 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,43 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.xapic",
-- 
2.43.0


