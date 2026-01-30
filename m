Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A43D73EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhM3-00023M-AM; Fri, 30 Jan 2026 00:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vlhM0-00020e-Lx
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vlhLz-0005SG-6U
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769752054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKeoqLnw94ekV3SKkVoM9wLZ2GlZHZ0eY7j3K1tcDgA=;
 b=g6e0hMBHS9l4Aipgc2Z4MLMyKLOX/AHplBD3kxj8WZ8TsAE3+fyP7glows3c9eJ4dqc3Zj
 dxQ3nw7hnH+QnLW8aRts3Gl7ARCC+uO/ujEbN5pcf9als4rURfUs44tg9PpDbPUtNnBr35
 RmS9gERVrmxYnLTOwWrTlNd6DGR0sLY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-Xg4ZZ5_KOomfVzHsx3HC0A-1; Fri,
 30 Jan 2026 00:47:30 -0500
X-MC-Unique: Xg4ZZ5_KOomfVzHsx3HC0A-1
X-Mimecast-MFC-AGG-ID: Xg4ZZ5_KOomfVzHsx3HC0A_1769752049
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA21F1956054; Fri, 30 Jan 2026 05:47:28 +0000 (UTC)
Received: from osteffen-thinkpadx1carbongen12.rmtde.csb (unknown
 [10.45.226.150])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E72619560A2; Fri, 30 Jan 2026 05:47:22 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Luigi Leonardi <leonardi@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v6 1/9] hw/acpi: Make acpi_checksum() public
Date: Fri, 30 Jan 2026 06:47:06 +0100
Message-ID: <20260130054714.715928-2-osteffen@redhat.com>
In-Reply-To: <20260130054714.715928-1-osteffen@redhat.com>
References: <20260130054714.715928-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
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

Make the ACPI table checksum calculation function (in core.c) public so
it can be reused in other parts of the ACPI code.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 hw/acpi/core.c         | 5 ++++-
 include/hw/acpi/acpi.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index d9979b0da9..6b65e587f2 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -83,7 +83,10 @@ bool acpi_builtin(void)
     return true;
 }
 
-static int acpi_checksum(const uint8_t *data, int len)
+/* Calculate the ACPI checksum value so that if used in the corresponding
+ * header field, the ACPI checksum verification will be successful.
+ */
+int acpi_checksum(const uint8_t *data, int len)
 {
     int sum, i;
     sum = 0;
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index 4b8ee094c4..b036116dfb 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -203,4 +203,7 @@ struct AcpiSlicOem {
 };
 int acpi_get_slic_oem(AcpiSlicOem *oem);
 
+/* core.c */
+int acpi_checksum(const uint8_t *data, int len);
+
 #endif /* QEMU_HW_ACPI_H */
-- 
2.52.0


