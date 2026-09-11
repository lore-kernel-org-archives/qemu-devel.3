Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD59C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52UB-0003e2-JH; Fri, 11 Sep 2026 10:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Nl-0002sO-VH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NQ-00088z-Ch
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPFHkXJSs0u/ISQJq2BRt28+2MaWYtAQufJCPx92BiY=;
 b=TPdd98mKrxNXL2+EIhIh10ltl/JLWBaLFfl54cozI6oTQbLaim9cIT2Q3avrt0lKHjEkbr
 SUEuQPExkrOvu8I4k5d0xCDjadi9P7Zv879tUUGwJ3y81pswFsWoqTH58BQtQdWa4WArOa
 tt7KhIqU38LYLhD7fdjfC8T6crjMpxQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-tL51sFxgNQuw0u-1lM6utQ-1; Fri,
 11 Sep 2026 10:37:12 -0400
X-MC-Unique: tL51sFxgNQuw0u-1lM6utQ-1
X-Mimecast-MFC-AGG-ID: tL51sFxgNQuw0u-1lM6utQ_1789137431
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D46641800671; Fri, 11 Sep 2026 14:37:10 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1256F3000229; Fri, 11 Sep 2026 14:37:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 18/28] hw/tpm: mark all TPM implementations as secure
Date: Fri, 11 Sep 2026 15:36:17 +0100
Message-ID: <20260911143627.2743803-19-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All of the TPM implementations are in scope of virtualization
usage, so mark them all as secure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/ppc/spapr_tpm_proxy.c | 1 +
 hw/tpm/tpm_crb.c         | 1 +
 hw/tpm/tpm_spapr.c       | 1 +
 hw/tpm/tpm_tis_i2c.c     | 1 +
 hw/tpm/tpm_tis_isa.c     | 1 +
 hw/tpm/tpm_tis_sysbus.c  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index 19889e80bc..bb6efec20c 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -166,6 +166,7 @@ static const TypeInfo spapr_tpm_proxy_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(SpaprTpmProxy),
     .class_init    = spapr_tpm_proxy_class_init,
+    .secure        = true,
 };
 
 static void spapr_tpm_proxy_register_types(void)
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 54fa2042b5..2e9445ad79 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -547,6 +547,7 @@ static const TypeInfo tpm_crb_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(CRBState),
     .class_init  = tpm_crb_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 19075d1f01..3957c5268b 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -414,6 +414,7 @@ static const TypeInfo tpm_spapr_info = {
     .parent        = TYPE_VIO_SPAPR_DEVICE,
     .instance_size = sizeof(SpaprTpmState),
     .class_init    = tpm_spapr_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index b4f258c7bc..302296affb 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -551,6 +551,7 @@ static const TypeInfo tpm_tis_i2c_info = {
     .name          = TYPE_TPM_TIS_I2C,
     .parent        = TYPE_I2C_SLAVE,
     .instance_size = sizeof(TPMStateI2C),
+    .secure        = true,
     .class_init    = tpm_tis_i2c_class_init,
         .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 2b1267133a..da3a932b03 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -187,6 +187,7 @@ static const TypeInfo tpm_tis_isa_info = {
     .instance_size = sizeof(TPMStateISA),
     .instance_init = tpm_tis_isa_initfn,
     .class_init  = tpm_tis_isa_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { TYPE_ACPI_DEV_AML_IF },
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index a7b0002d82..0afb52c3be 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -167,6 +167,7 @@ static const TypeInfo tpm_tis_sysbus_info = {
     .instance_init = tpm_tis_sysbus_initfn,
     .instance_finalize = tpm_tis_sysbus_finalize,
     .class_init  = tpm_tis_sysbus_class_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
-- 
2.55.0


