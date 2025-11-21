Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002C8CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMeI9-000309-Fn; Fri, 21 Nov 2025 22:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMeI4-0002yZ-GJ; Fri, 21 Nov 2025 22:28:00 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMeHj-0002P6-0C; Fri, 21 Nov 2025 22:27:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 652AB16C701;
 Fri, 21 Nov 2025 16:51:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BA3F532199E;
 Fri, 21 Nov 2025 16:52:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 41/76] hw/pci-host/gpex-acpi: Fix _DSM function 0
 support return value
Date: Fri, 21 Nov 2025 16:51:19 +0300
Message-ID: <20251121135201.1114964-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Currently, only function 0 is supported. According to the ACPI
Specification, Revision 6.6, Section 9.1.1 “_DSM (Device Specific
Method)”, bit 0 should be 0 to indicate that no other functions
are supported beyond function 0.

The resulting AML change looks like this:

Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
{
    If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d")
    {
        If ((Arg2 == Zero))
        {
            Return (Buffer (One)
            {
-               0x01                                             // .
+               0x00                                             // .
            })
        }
    }
}

Fixes: 5b85eabe68f9 ("acpi: add acpi_dsdt_add_gpex")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251022080639.243965-3-skolothumtho@nvidia.com>
(cherry picked from commit 325aa2d86a20786c308b0874d15a60d1b924bd0e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 952a0ace19..4587baeb78 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -64,7 +64,7 @@ static Aml *build_pci_host_bridge_dsm_method(void)
     UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
     ifctx = aml_if(aml_equal(aml_arg(0), UUID));
     ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    uint8_t byte_list[1] = {1};
+    uint8_t byte_list[1] = {0};
     buf = aml_buffer(1, byte_list);
     aml_append(ifctx1, aml_return(buf));
     aml_append(ifctx, ifctx1);
-- 
2.47.3


