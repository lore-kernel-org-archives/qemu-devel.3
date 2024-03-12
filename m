Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EEBC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4jB-0006j6-Eo; Tue, 12 Mar 2024 12:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4ij-00060m-87
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4ih-0007IU-ON
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710259875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IzIyBHphGbPNS4xIl9gbBGxoZiLCXyGk+veHTAfrusM=;
 b=IYZL6XJiL5U38G8M2I9NBAovTBsQY3TbDkugAnVA6fzKYt/h1mEl/bGgXxZfXO1oAIjOAE
 avtEHGEos9sKG9qaKjgWZfPvOpv48AIR5BKQyeeOogGCvL2bUjZiQ0BA0SZmEjuWlnOgp+
 p2a8V4jI1d1c8ZjWPMfSzD1CCyKYPs8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-aZO3EuyyOHuhal9PwEGXEQ-1; Tue,
 12 Mar 2024 12:11:12 -0400
X-MC-Unique: aZO3EuyyOHuhal9PwEGXEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE1F71C02D39;
 Tue, 12 Mar 2024 16:11:09 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18C023C21;
 Tue, 12 Mar 2024 16:11:08 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	mst@redhat.com,
	Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v3 14/20] smbios: clear smbios_type4_count before building
 tables
Date: Tue, 12 Mar 2024 17:10:44 +0100
Message-Id: <20240312161050.2248814-15-imammedo@redhat.com>
In-Reply-To: <20240312161050.2248814-1-imammedo@redhat.com>
References: <20240312161050.2248814-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

it will help to keep type 4 tables accounting correct in case
SMBIOS tables are built multiple times.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 hw/smbios/smbios.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 5a791fd9eb..d3d89b4dd0 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -973,6 +973,7 @@ void smbios_get_tables(MachineState *ms,
            ep_type == SMBIOS_ENTRY_POINT_TYPE_64);
 
     g_free(smbios_tables);
+    smbios_type4_count = 0;
     smbios_tables = g_memdup2(usr_blobs, usr_blobs_len);
     smbios_tables_len = usr_blobs_len;
     smbios_table_max = usr_table_max;
-- 
2.39.3


