Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8FFE64A8A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tISod-0001G3-96; Tue, 03 Dec 2024 08:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tISoa-0001Fa-PP
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:19:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tISoY-0007CB-G3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:19:44 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y2h4s1BXWz6K5lY;
 Tue,  3 Dec 2024 21:16:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0BB681400F4;
 Tue,  3 Dec 2024 21:19:39 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 14:19:35 +0100
To: <qemu-devel@nongnu.org>
CC: <philmd@linaro.org>, <kraxel@redhat.com>, <imammedo@redhat.com>,
 <wangzhou1@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH v3] fw_cfg: Don't set callback_opaque NULL in
 fw_cfg_modify_bytes_read()
Date: Tue, 3 Dec 2024 13:18:06 +0000
Message-ID: <20241203131806.37548-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) AC_FROM_MANY_DOTS=2.497, BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On arm/virt platform, Chen Xiang reported a Guest crash while
attempting the below steps,

1. Launch the Guest with nvdimm=on
2. Hot-add a NVDIMM dev
3. Reboot
4. Guest boots fine.
5. Reboot again.
6. Guest boot fails.

QEMU_EFI reports the below error:
ProcessCmdAddPointer: invalid pointer value in "etc/acpi/tables"
OnRootBridgesConnected: InstallAcpiTables: Protocol Error

Debugging shows that on first reboot(after hot adding NVDIMM),
Qemu updates the etc/table-loader len,

qemu_ram_resize()
  fw_cfg_modify_file()
     fw_cfg_modify_bytes_read()

And in fw_cfg_modify_bytes_read() we set the "callback_opaque" for
the key entry to NULL. Because of this, on the second reboot,
virt_acpi_build_update() is called with a NULL "build_state" and
returns without updating the ACPI tables. This seems to be
upsetting the firmware.

To fix this, don't change the callback_opaque in fw_cfg_modify_bytes_read().

Fixes: bdbb5b1706d165 ("fw_cfg: add fw_cfg_machine_reset function")
Reported-by: chenxiang <chenxiang66@hisilicon.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
Hi,

I forgot to follow-up on the v2 and it never got picked up.
Thanks to Wangzhou who recently re-run the tests and found that
the problem mentioned above still exists. Hence resending the v2.

v2-->v3:
 -Just rebase.

v2: https://lore.kernel.org/qemu-devel/20220908160354.2023-1-shameerali.kolothum.thodi@huawei.com/
v1: https://lore.kernel.org/all/20220825161842.841-1-shameerali.kolothum.thodi@huawei.com/

Thanks,
Shameer
---
 hw/nvram/fw_cfg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b644577734..74edb1e4cf 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -730,7 +730,6 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
     ptr = s->entries[arch][key].data;
     s->entries[arch][key].data = data;
     s->entries[arch][key].len = len;
-    s->entries[arch][key].callback_opaque = NULL;
     s->entries[arch][key].allow_write = false;
 
     return ptr;
-- 
2.34.1


