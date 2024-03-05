Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1712DC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 16:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXBd-0006J1-T6; Tue, 05 Mar 2024 10:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhXB6-0005dc-Co
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:58:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhXB3-0000Y8-MV
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709654281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPxefcrUSoOBOHuk1sFV5x9qKOwla4dnMHg+sDmbLZE=;
 b=OxCWFEoYBfJeANClOfIbxpCA4szDr5WMc9dJr2m0QESiXq9CxNyOPqWochRIVWQTUOG5Dm
 ajfTcM7C3gshTOGc4Tg3HPn7zecRnOMAvoZy1kbto+c/JrIdLmOW9HaV7/9QIvpD51fY93
 lpU4DK1SaDhSo/k44JKeZ92YGflJ0T4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-XDlEVkooNNOMW4UBYOWFBA-1; Tue, 05 Mar 2024 10:57:58 -0500
X-MC-Unique: XDlEVkooNNOMW4UBYOWFBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CA0B8164E4;
 Tue,  5 Mar 2024 15:57:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF24417A99;
 Tue,  5 Mar 2024 15:57:53 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 gaosong@loongson.cn, alistair.francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@linaro.org, wangyanan55@huawei.com, eblake@redhat.com,
 armbru@redhat.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 f.ebner@proxmox.com
Subject: [PATCH v2 09/20] smbios: add smbios_add_usr_blob_size() helper
Date: Tue,  5 Mar 2024 16:57:13 +0100
Message-Id: <20240305155724.2047069-10-imammedo@redhat.com>
In-Reply-To: <20240305155724.2047069-1-imammedo@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

it will be used by follow up patch when legacy handling
is moved out into a separate file.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/smbios/smbios.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 97cf762228..01180bd82c 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1287,6 +1287,14 @@ static bool save_opt_list(size_t *ndest, char ***dest, QemuOpts *opts,
     return true;
 }
 
+static void smbios_add_usr_blob_size(size_t size)
+{
+    if (!usr_blobs_sizes) {
+        usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
+    }
+    g_array_append_val(usr_blobs_sizes, size);
+}
+
 void smbios_entry_add(QemuOpts *opts, Error **errp)
 {
     const char *val;
@@ -1334,10 +1342,12 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             smbios_type4_count++;
         }
 
-        if (!usr_blobs_sizes) {
-            usr_blobs_sizes = g_array_new(false, false, sizeof(size_t));
-        }
-        g_array_append_val(usr_blobs_sizes, size);
+        /*
+         * preserve blob size for legacy mode so it could build its
+         * blobs flavor from 'usr_blobs'
+         */
+        smbios_add_usr_blob_size(size);
+
         usr_blobs_len += size;
         if (size > usr_table_max) {
             usr_table_max = size;
-- 
2.39.3


