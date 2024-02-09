Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4B3C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 13:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYROE-0003FS-OE; Fri, 09 Feb 2024 08:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSh-0003Ey-2U
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:31 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1rYPSc-0001e7-Gi
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1707479667; x=1739015667;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z7T5L3Tda6BxZYidR6fnaq/tpChYL2fRgPdxqk3pY3E=;
 b=nC5j6zw1scZtOxZeW6qHoXl0KOIrrhOCzrGuRcieOq0GP2dHSOsiiN0q
 bwJuFI923/l1aHu1xG0b/5sgcURLTQjQhEOM7QMhKy7GFqgdHVM4ohpfg
 DdNPJgLrBqp9ZhhT/ItdokMyBgJOQ52yD8SxL8i50xjAMzHUubc2n+3f9
 yd6k3cOf5LohKfHc4hn9jIf/+HuMFLhj3l4N6hJFFW+SHgrsnnLwdXUW6
 sVZ78qr1Naev2XjumQWzJlO7LDbBA9Kk2bcGTTPqwkY0OMPZYFFA/XFQ2
 iQ4aHQ0CnaYPv7jy5SO70IS12ickOjFydJB9tlnuwJjJP554B1tC4g/pM w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="148784721"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; d="scan'208";a="148784721"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 20:54:22 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E5E74D4801
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 13940D3E77
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A5FF221BD55
 for <qemu-devel@nongnu.org>; Fri,  9 Feb 2024 20:54:18 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 309C51A009A;
 Fri,  9 Feb 2024 19:54:18 +0800 (CST)
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 1/2] hw/cxl/type3: add missing flag bit for GMER
Date: Fri,  9 Feb 2024 19:54:11 +0800
Message-Id: <20240209115417.724638-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--6.570700-10.000000
X-TMASE-MatchedRID: UpZ+EYxJ0vn5S+IvXI7mDU7nLUqYrlslFIuBIWrdOeOjEIt+uIPPOC/6
 oQ/dDcvK+XV+0/kEbzbCWEJl/eJ/AWdMDh/Ba5IyngIgpj8eDcBpkajQR5gb3lQwtQm7iV5jKra
 uXd3MZDUcjalIOG21n4U/djnIxCr4sKweaq3mGKFHXsfuoS1sXjJ4wpepbn7q
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.47;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa1.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Feb 2024 08:57:57 -0500
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The "Volatile" should be set if current device is a volatile memory.
Per CXL Spec r3.0 8.2.9.2.1.1, Table 8-43.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 hw/mem/cxl_type3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 52647b4ac7..d8fb63b1de 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1285,6 +1285,9 @@ static const QemuUUID memory_module_uuid = {
                  0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
 };
 
+#define CXL_GMER_DPA_VOLATILE                           BIT(0)
+#define CXL_GMER_DPA_NOT_REPAIRABLE                     BIT(1)
+
 #define CXL_GMER_VALID_CHANNEL                          BIT(0)
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
@@ -1348,6 +1351,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
                             cxl_device_get_timestamp(&ct3d->cxl_dstate));
 
+    if (ct3d->hostvmem) {
+        dpa |= CXL_GMER_DPA_VOLATILE;
+    }
     stq_le_p(&gem.phys_addr, dpa);
     gem.descriptor = descriptor;
     gem.type = type;
-- 
2.34.1


