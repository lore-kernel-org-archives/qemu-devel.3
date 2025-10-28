Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E610CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstc-00031A-BC; Tue, 28 Oct 2025 19:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstZ-0002zy-Jc
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:29 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstL-000182-RN
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:29 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4DCB781753;
 Wed, 29 Oct 2025 02:14:03 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-2KUF3LFw; Wed, 29 Oct 2025 02:14:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693243;
 bh=FJe9bBDqhj2CZOs8zGPWoZRXXGpH1eDzzeZX4vIEKoE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WvdEhIttMn2vNqBnoLrt3/vZmwkbiWezFgw26R+rw07XPNiIpgDeTEBoMUh/ExTos
 Kt+Mc32ACm+a2TotEx5pNTn9N/QOH4eD28kNKy9GT9JCENMRbzQkEWtCMih7ZObLuQ
 lecquitGHeyvx3wZ9Em3Z09iOYvKxMMj3exPmqlM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 16/22] hw/nvram/fw_cfg.c: use new migration APIs
Date: Wed, 29 Oct 2025 02:13:40 +0300
Message-ID: <20251028231347.194844-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/nvram/fw_cfg.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index aa24050493..d02e5802cd 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -565,27 +565,28 @@ static void fw_cfg_reset(DeviceState *d)
    Or we broke compatibility in the state, or we can't use struct tm
  */
 
-static int get_uint32_as_uint16(QEMUFile *f, void *pv, size_t size,
-                                const VMStateField *field)
+static bool get_uint32_as_uint16(QEMUFile *f, void *pv, size_t size,
+                                 const VMStateField *field, Error **errp)
 {
     uint32_t *v = pv;
     *v = qemu_get_be16(f);
-    return 0;
+    return true;
 }
 
-static int put_unused(QEMUFile *f, void *pv, size_t size,
-                      const VMStateField *field, JSONWriter *vmdesc)
+static bool put_unused(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc,
+                       Error **errp)
 {
-    fprintf(stderr, "uint32_as_uint16 is only used for backward compatibility.\n");
-    fprintf(stderr, "This functions shouldn't be called.\n");
-
-    return 0;
+    error_setg(errp,
+               "uint32_as_uint16 is only used for backward compatibility. "
+               "This function shouldn't be called.");
+    return false;
 }
 
 static const VMStateInfo vmstate_hack_uint32_as_uint16 = {
     .name = "int32_as_uint16",
-    .get  = get_uint32_as_uint16,
-    .put  = put_unused,
+    .load = get_uint32_as_uint16,
+    .save = put_unused,
 };
 
 #define VMSTATE_UINT16_HACK(_f, _s, _t)                                    \
@@ -631,7 +632,8 @@ static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
     memory_region_ram_resize(mr, size, &error_abort);
 }
 
-static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id)
+static bool fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id,
+                                             Error **errp)
 {
     FWCfgState *s = opaque;
     int i, index;
@@ -650,7 +652,7 @@ static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id)
         }
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_fw_cfg_dma = {
@@ -667,7 +669,7 @@ static const VMStateDescription vmstate_fw_cfg_acpi_mr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = fw_cfg_acpi_mr_restore,
-    .post_load = fw_cfg_acpi_mr_restore_post_load,
+    .post_load_errp = fw_cfg_acpi_mr_restore_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(table_mr_size, FWCfgState),
         VMSTATE_UINT64(linker_mr_size, FWCfgState),
-- 
2.48.1


