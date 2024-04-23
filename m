Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E95C16B13
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnO-0005j6-KT; Tue, 23 Apr 2024 11:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn0-0004Y2-56
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmy-0000Fu-I5
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPERydqbaBDZuUCv9C5JabcjB73wzXykKHQAmPAuFH0=;
 b=iV73J1tXEMjfLwL99BTFEOE+ZIDsOZ8eLDkoqPg1OdNeaeFGSfJT0LpN1zt8BMpKvCOhOK
 SjLohJSfMezeuoRzYVjJYnY+OUDa86ZBHF3RL9miMyxysSIp7fp0365+naSpMb3DivynCC
 11FwEpcikeoywXCdbVLrJr9nTMFLvvo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-DQeEPtzXNrq-l9QgXugUzw-1; Tue, 23 Apr 2024 11:10:26 -0400
X-MC-Unique: DQeEPtzXNrq-l9QgXugUzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56BD9834FB8;
 Tue, 23 Apr 2024 15:10:26 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B311C20128F3;
 Tue, 23 Apr 2024 15:10:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 31/63] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
Date: Tue, 23 Apr 2024 17:09:19 +0200
Message-ID: <20240423150951.41600-32-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

A value 1 of PCAT_COMPAT (bit 0) of MADT.Flags indicates that the system
also has a PC-AT-compatible dual-8259 setup, i.e., the PIC.  When PIC
is not enabled (pic=off) for x86 machine, the PCAT_COMPAT bit needs to
be cleared.  The PIC probe should then print:

   [    0.155970] Using NULL legacy PIC

However, no such log printed in guest kernel unless PCAT_COMPAT is
cleared.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240403145953.3082491-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/acpi-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 20f19269da4..0cc2919bb85 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -107,7 +107,9 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     acpi_table_begin(&table, table_data);
     /* Local APIC Address */
     build_append_int_noprefix(table_data, APIC_DEFAULT_ADDRESS, 4);
-    build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
+    /* Flags. bit 0: PCAT_COMPAT */
+    build_append_int_noprefix(table_data,
+                              x86ms->pic != ON_OFF_AUTO_OFF ? 1 : 0 , 4);
 
     for (i = 0; i < apic_ids->len; i++) {
         pc_madt_cpu_entry(i, apic_ids, table_data, false);
-- 
2.44.0



