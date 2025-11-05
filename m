Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A15FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbyW-0005vE-AC; Wed, 05 Nov 2025 06:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGby2-0005hl-0O
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbxy-0002Fn-PL
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762343177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjQCgzUuMt/tIaUujFGLuYD4UMTT/LdKiuJpGFsSVAc=;
 b=D1qD0jn/42r1FJaVZ/svj5X9GOq0qRxjleEw1w4BD7kbRKYHIVAhPVNIj3kHUR6a1pIQIH
 Kb+DjW6nOeqdsLo65v+fSGNvH+n+y9trS5n1/l5lX4j11za6LRHDuevIE50uEM570zb7H1
 vgv0PUITPefG942zoCVredMt5TSsJSI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-yiCSwjuTPqSOo0HAdq2y5A-1; Wed,
 05 Nov 2025 06:46:14 -0500
X-MC-Unique: yiCSwjuTPqSOo0HAdq2y5A-1
X-Mimecast-MFC-AGG-ID: yiCSwjuTPqSOo0HAdq2y5A_1762343173
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4EA618001FE; Wed,  5 Nov 2025 11:46:12 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16A3D180049F; Wed,  5 Nov 2025 11:46:06 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 2/8] acpi/ghes: Increase GHES raw data maximal length to
 4KiB
Date: Wed,  5 Nov 2025 21:44:47 +1000
Message-ID: <20251105114453.2164073-3-gshan@redhat.com>
In-Reply-To: <20251105114453.2164073-1-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The current GHES raw data maximal length isn't enough for 16 consecutive
CPER errors, which will be sent to a guest with 4KiB page size on a
erroneous 64KiB host page. Note those 16 CPER errors will be contained
in one single error block, meaning all CPER errors should be identical
in terms of type and severity and all of them should be delivered in
one shot.

Increase GHES raw data maximal length from 1KiB to 4KiB so that the
error block has enough storage space for 16 consecutive CPER errors.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 docs/specs/acpi_hest_ghes.rst | 2 +-
 hw/acpi/ghes.c                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index aaf7b1ad11..acf31d6eeb 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -68,7 +68,7 @@ Design Details
     and N Read Ack Register entries. The size for each entry is 8-byte.
     The Error Status Data Block table contains N Error Status Data Block
     entries. The size for each entry is defined at the source code as
-    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 1024 bytes). The total size
+    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 4096 bytes). The total size
     for the "etc/hardware_errors" fw_cfg blob is
     (N * 8 * 2 + N * ACPI_GHES_MAX_RAW_DATA_LENGTH) bytes.
     N is the number of the kinds of hardware error sources.
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 06555905ce..a9c08e73c0 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -33,7 +33,7 @@
 #define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
 
 /* The max size in bytes for one error block */
-#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
+#define ACPI_GHES_MAX_RAW_DATA_LENGTH   (4 * KiB)
 
 /* Generic Hardware Error Source version 2 */
 #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
-- 
2.51.0


