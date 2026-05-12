Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94716CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuXk-00020Z-Jm; Tue, 12 May 2026 17:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuXV-0001JZ-BH; Tue, 12 May 2026 17:21:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuXM-0000a5-Jw; Tue, 12 May 2026 17:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619498; bh=QDzQ9Z/iLPEiGCNsQMy3lqSumWj/0txSEiDQDLcMbJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PQZqkIQGcXENeH27ivw7Slnhsgdii4kdXprWQVXhJ8uotRHknFqATltO2KZflb3eq
 gyOZttO+FAlzhPrDEN0LfYoSVuE3xa6G/sHu11XoZKEeGlSKHRwHLtU0Ah3zO2FNyX
 5pwJVQpunmg/Ze9kosZIpd9v9ghbGcOCkjWJDCJ0O6x5gyheS8vGPUnDgmvQvQV7Xn
 +0PZGnPKa86hmcchbBetxUc2jweOrsyedplU3L9mhDsoyLtH0pnKV3pDVCos2k50lZ
 oyM8v+3azTGttkn4ttdEkQwG549/SxPNyKq9oEanu5h6iR5VDK0l8YihFYzWg+edQR
 VoTYYU3Mdi8SA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ED6BC1AA3EA;
 Tue, 12 May 2026 23:58:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 037103ABD42;
 Tue, 12 May 2026 23:58:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Luc Michel <luc.michel@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 31/58] hw/core/register: add register_array_get_owner
Date: Tue, 12 May 2026 23:57:52 +0300
Message-ID: <20260512205820.361821-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Luc Michel <luc.michel@amd.com>

Add the register_array_get_owner function to the register API. This
function can be used to retrieve the device owning the given
RegisterInfoArray.

This was previously done inline by some devices.
5c6367bc1c8850f74812eeaaf87cff9911be58de modified the way register
blocks are created and parented to the device. Since this is an
implementation detail of the register API, it makes sense to have a
function for this.

Use it in the Versal OSPI and Versal/ZynqMP eFuse models instead of
tinkering with the API internals.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3421
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3422
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3423
Signed-off-by: Luc Michel <luc.michel@amd.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Fixes: 5c6367bc1c8 ("hw/core/register: add the REGISTER_ARRAY type")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260424155646.533334-1-luc.michel@amd.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 57abf6b1d5762380765673a17cba74c481cc4b29)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/register.c b/hw/core/register.c
index c3f3c936e7..99ca5e1775 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -322,6 +322,11 @@ static void register_array_finalize(Object *obj)
     g_free(r_array->r);
 }
 
+DeviceState *register_array_get_owner(const RegisterInfoArray *reg_array)
+{
+    return DEVICE(OBJECT(reg_array)->parent);
+}
+
 static const TypeInfo register_array_info = {
     .name  = TYPE_REGISTER_ARRAY,
     .parent = TYPE_OBJECT,
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 69acdfa304..f5d5587cb6 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -619,11 +619,11 @@ static void efuse_ctrl_reg_write(void *opaque, hwaddr addr,
 {
     RegisterInfoArray *reg_array = opaque;
     XlnxVersalEFuseCtrl *s;
-    Object *dev;
+    DeviceState *dev;
 
     assert(reg_array != NULL);
 
-    dev = reg_array->mem.owner;
+    dev = register_array_get_owner(reg_array);
     assert(dev);
 
     s = XLNX_VERSAL_EFUSE_CTRL(dev);
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index e6bc54fc6b..028120f824 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -724,11 +724,11 @@ static void zynqmp_efuse_reg_write(void *opaque, hwaddr addr,
 {
     RegisterInfoArray *reg_array = opaque;
     XlnxZynqMPEFuse *s;
-    Object *dev;
+    DeviceState *dev;
 
     assert(reg_array != NULL);
 
-    dev = reg_array->mem.owner;
+    dev = register_array_get_owner(reg_array);
     assert(dev);
 
     s = XLNX_ZYNQMP_EFUSE(dev);
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index 467f0ce703..e25e4c26c2 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1569,15 +1569,11 @@ static RegisterAccessInfo ospi_regs_info[] = {
 };
 
 /* Return dev-obj from reg-region created by register_init_block32 */
-static XlnxVersalOspi *xilinx_ospi_of_mr(void *mr_accessor)
+static XlnxVersalOspi *xilinx_ospi_of_mr(void *opaque)
 {
-    RegisterInfoArray *reg_array = mr_accessor;
-    Object *dev;
+    RegisterInfoArray *reg_array = REGISTER_ARRAY(opaque);
 
-    dev = reg_array->mem.owner;
-    assert(dev);
-
-    return XILINX_VERSAL_OSPI(dev);
+    return XILINX_VERSAL_OSPI(register_array_get_owner(reg_array));
 }
 
 static void ospi_write(void *opaque, hwaddr addr, uint64_t value,
diff --git a/include/hw/core/register.h b/include/hw/core/register.h
index 1f265f4ed7..c6f648fe95 100644
--- a/include/hw/core/register.h
+++ b/include/hw/core/register.h
@@ -209,4 +209,15 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
                                          bool debug_enabled,
                                          uint64_t memory_size);
 
+/**
+ * register_array_get_owner
+ *
+ * Retrieve the device owning the register info array @reg_array.
+ *
+ * @reg_array The register info array to retrieve the owner from
+ *
+ * Returns: the device owning @reg_array
+ */
+DeviceState *register_array_get_owner(const RegisterInfoArray *reg_array);
+
 #endif
-- 
2.47.3


