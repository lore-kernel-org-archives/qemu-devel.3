Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98057FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIjV-0007yU-4S; Mon, 27 Apr 2026 05:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjO-0007la-Ba
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjM-000889-MR
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777283900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4/PW9AX1SjdG091xg18qEgQhoURcREzm5rwdhlIg+A=;
 b=KyKOXd4FqduSyGLtASby2jnyJi+qu0zvDAMIxNZik6AF+wJ6cb8xoFmxripd+h8QNIaOZ/
 EKGpoIN6+PGKzeCm1U9O6Z3vcFbaf7ZhsaKc6ma7QDAy5k0Y9kEoeGIU7mfM6NcpshfN0S
 Ky13B20e0e0Q7Ufp15IxM2o4ANvhI8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-zedaxh50O-2-XZY2BpetJg-1; Mon,
 27 Apr 2026 05:58:18 -0400
X-MC-Unique: zedaxh50O-2-XZY2BpetJg-1
X-Mimecast-MFC-AGG-ID: zedaxh50O-2-XZY2BpetJg_1777283897
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AB671800451; Mon, 27 Apr 2026 09:58:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 517053000709; Mon, 27 Apr 2026 09:58:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/10] hw/core/register: add register_array_get_owner
Date: Mon, 27 Apr 2026 11:57:44 +0200
Message-ID: <20260427095747.1070244-8-thuth@redhat.com>
In-Reply-To: <20260427095747.1070244-1-thuth@redhat.com>
References: <20260427095747.1070244-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
---
 include/hw/core/register.h        | 11 +++++++++++
 hw/core/register.c                |  5 +++++
 hw/nvram/xlnx-versal-efuse-ctrl.c |  4 ++--
 hw/nvram/xlnx-zynqmp-efuse.c      |  4 ++--
 hw/ssi/xlnx-versal-ospi.c         | 10 +++-------
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/hw/core/register.h b/include/hw/core/register.h
index 1f265f4ed71..c6f648fe95e 100644
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
diff --git a/hw/core/register.c b/hw/core/register.c
index c3f3c936e70..99ca5e17758 100644
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
index 69acdfa3047..f5d5587cb65 100644
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
index e6bc54fc6bd..028120f824d 100644
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
index 467f0ce7033..e25e4c26c2e 100644
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
-- 
2.53.0


