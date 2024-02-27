Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FB3C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezhY-0006x9-MI; Tue, 27 Feb 2024 10:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rezhS-0006bH-Sl
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:48:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rezhB-0008UT-N6
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709048921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4XcAZqKOfS7DTleSAQCnGHI1cZWEQbqT3upL1ikAauE=;
 b=AsYbQpnP3xNCJixn28HrnOxdFrdzBxPXFe6PBc0pixS4NShOfERDEMcYRn92WL4b9IvTnQ
 uGp/TB3k7Kb64QWwI+QKrvKjXxQA3JD1mkF6dG64zXy4Wbpmh20TSAMKNIbtCocg4KauBi
 4gWQ0m+UZyrg05t4BOAc1gb0ZWMrhYU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-esWAYJ4WMq6QfDOvQnSyYA-1; Tue,
 27 Feb 2024 10:48:37 -0500
X-MC-Unique: esWAYJ4WMq6QfDOvQnSyYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3CA1380450E;
 Tue, 27 Feb 2024 15:48:36 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E5BF2166B5E;
 Tue, 27 Feb 2024 15:48:34 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 gaosong@loongson.cn, alistair.francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@linaro.org, wangyanan55@huawei.com, eblake@redhat.com,
 armbru@redhat.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 f.ebner@proxmox.com
Subject: [PATCH 15/19] smbios: error out when building type 4 table is not
 possible
Date: Tue, 27 Feb 2024 16:47:45 +0100
Message-Id: <20240227154749.1818189-16-imammedo@redhat.com>
In-Reply-To: <20240227154749.1818189-1-imammedo@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

If SMBIOS v2 version is requested but number of cores/threads
are more than it's possible to describe with v2, error out
instead of silently ignoring the fact and filling core/thread
count with bogus values.

This will help caller to decide if it should fallback to
SMBIOSv3 when smbios-entry-point-type='auto'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/smbios/smbios.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index e54a9f21e6..bf5c7a8885 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -605,7 +605,8 @@ static void smbios_build_type_3_table(void)
 }
 
 static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
-                                      SmbiosEntryPointType ep_type)
+                                      SmbiosEntryPointType ep_type,
+                                      Error **errp)
 {
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
@@ -659,6 +660,12 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
         t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
         t->thread_count2 = cpu_to_le16(threads_per_socket);
+    } else if (t->core_count == 0xFF || t->thread_count == 0xFF) {
+        error_setg(errp, "SMBIOS 2.0 doesn't support number of processor "
+                         "cores/threads more than 255, use "
+                         "-machine smbios-entry-point-type=64 option to enable "
+                         "SMBIOS 3.0 support");
+        return;
     }
 
     SMBIOS_BUILD_TABLE_POST;
@@ -987,7 +994,10 @@ static bool smbios_get_tables_ep(MachineState *ms,
     assert(ms->smp.sockets >= 1);
 
     for (i = 0; i < ms->smp.sockets; i++) {
-        smbios_build_type_4_table(ms, i, ep_type);
+        smbios_build_type_4_table(ms, i, ep_type, errp);
+        if (*errp) {
+            goto err_exit;
+        }
     }
 
     smbios_build_type_8_table();
-- 
2.39.3


