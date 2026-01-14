Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD281D39005
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 17:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg50s-0001nW-Rl; Wed, 14 Jan 2026 12:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vg50r-0001n5-9Y
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:50:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vg50p-0008TY-Ud
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768413031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpEw8yEkNdxIl1el1j22OB3dfzc6fkynrGThqY7HmlA=;
 b=R5EOo0Xa9vOhoheSvKlg0362rAGisCbt3lUYCdx3yEhNJjYwdC5FmZKUXVy0vel+EcGENv
 2pFCh/a6ZlgfhyPobvd+EABMSBVA9R9Rf1fjGiejf8piIE22pN7WqZEHom5YbR3edjCNj9
 Xi5he8XDXJ+GjA3ARKdGfpVk1MNU0+Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-L3KsthLzNiiRluxTJVe7tQ-1; Wed,
 14 Jan 2026 12:50:29 -0500
X-MC-Unique: L3KsthLzNiiRluxTJVe7tQ-1
X-Mimecast-MFC-AGG-ID: L3KsthLzNiiRluxTJVe7tQ_1768413028
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4270B18005A7; Wed, 14 Jan 2026 17:50:28 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.224.90])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95A5F1800665; Wed, 14 Jan 2026 17:50:22 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v4 2/5] hw/acpi: Add standalone function to build MADT
Date: Wed, 14 Jan 2026 18:50:04 +0100
Message-ID: <20260114175007.90845-3-osteffen@redhat.com>
In-Reply-To: <20260114175007.90845-1-osteffen@redhat.com>
References: <20260114175007.90845-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add a fuction called `acpi_build_madt_standalone()` that builds a MADT
without the rest of the ACPI table structure.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 hw/i386/acpi-build.c | 9 +++++++++
 hw/i386/acpi-build.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9446a9f862..19c62362e3 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2249,3 +2249,12 @@ void acpi_setup(void)
      */
     acpi_build_tables_cleanup(&tables, false);
 }
+
+GArray *acpi_build_madt_standalone(MachineState *machine)
+{
+  X86MachineState *x86ms = X86_MACHINE(machine);
+  GArray *table = g_array_new(false, true, 1);
+  acpi_build_madt(table, NULL, x86ms, x86ms->oem_id,
+                  x86ms->oem_table_id);
+  return table;
+}
diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 8ba3c33e48..00e19bbe5e 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -8,4 +8,6 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 void acpi_setup(void);
 Object *acpi_get_i386_pci_host(void);
 
+GArray *acpi_build_madt_standalone(MachineState *machine);
+
 #endif
-- 
2.52.0


