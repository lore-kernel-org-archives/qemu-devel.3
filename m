Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA21E7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 08:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJqcX-0007cB-B7; Sat, 07 Dec 2024 03:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqcM-0007VQ-G5; Sat, 07 Dec 2024 03:56:50 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqcJ-0002Sp-KV; Sat, 07 Dec 2024 03:56:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id EA92BA40471;
 Sat,  7 Dec 2024 08:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E403BC4CEE1;
 Sat,  7 Dec 2024 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733561804;
 bh=WUvT8Ughz2H3l7zFkf4yAqTlDCn4hpG5JQNObbE2feQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TLgcJh+PNVwrx9KKnJJvfccScC/9MftfmPrAQrAcG4MYVUJaZij4950BRp9msAyxF
 d1r+eTzRRcofoi92PzlN3E1lGyHJFVJqWefX/oQ/eBB5mN3kUEBnN/glpEIbE2OuQm
 zsfu9qDeY6+iPBQFM7DiVJ3oHuJY3SmRsiBtOJU0YrWZs8TzgGp+6WfswJJSygHZM7
 WCXCvE2rjJRTNKVLMawfowmWn6oOpitGfgvLlW8BSV59ryY2roms6KKKyH5FB7qdGz
 Yqv+ZaQ+yGJ5wYJvQ+GY6rBVy/4bGfitDh/CIXrV7V4028uLZJIGW/sl3IzRu5/qkL
 WqG53FOSS+l4A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJqcF-00000005j4o-0BhY; Sat, 07 Dec 2024 09:56:43 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v6 05/16] acpi/ghes: Fix acpi_ghes_record_errors() argument
Date: Sat,  7 Dec 2024 09:54:11 +0100
Message-ID: <d2c93ea407f127b404fabbc9c7e428abf600284d.1733561462.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733561462.git.mchehab+huawei@kernel.org>
References: <cover.1733561462.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Align the header file with the actual implementation of
this function, as the first argument is source ID and not
notification type.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---

Changes from v8:
- Non-rename/cleanup changes merged altogether;
- source ID is now more generic, defined per guest target.
  That should make easier to add support for 86.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/hw/acpi/ghes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 20016c226d1f..50e3a25ea384 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
+int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
-- 
2.47.1


