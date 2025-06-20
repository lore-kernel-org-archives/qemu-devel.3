Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D094C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 15:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSdRv-0002y1-4d; Fri, 20 Jun 2025 11:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSdRt-0002xq-Aj
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSdRr-00064G-Ui
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750432474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOg71voJ0ED8/lu34K936sWicaLbanvnyfw3YaaLIFU=;
 b=FNDoLst4ARRLm0GlQsPZ2DrJXZZnUwamQUtKPQOqhmyUN7ujLuOSJ1a2l5R6kG5ftk5sz3
 J6SRg5EmpTttHR5R5nfTyI2wZvnV/URUQed0+9uOcwo0bI9nCSfLgYU0OOxvR5MdGMY3E0
 PaYpZtSqwhQYmxBgvOKv1jOBvIM7HzY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-G6CdX_-SPB62mchbdslWjQ-1; Fri,
 20 Jun 2025 11:14:33 -0400
X-MC-Unique: G6CdX_-SPB62mchbdslWjQ-1
X-Mimecast-MFC-AGG-ID: G6CdX_-SPB62mchbdslWjQ_1750432472
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42A92195609D; Fri, 20 Jun 2025 15:14:32 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BCBB1956094; Fri, 20 Jun 2025 15:14:29 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, anisinha@redhat.com,
 elena.ufimtseva@oracle.com, jag.raman@oracle.com, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org
Subject: [PATCH 2/3] acpi: mark PMTIMER as unlocked
Date: Fri, 20 Jun 2025 17:14:17 +0200
Message-ID: <20250620151418.1166195-3-imammedo@redhat.com>
In-Reply-To: <20250620151418.1166195-1-imammedo@redhat.com>
References: <20250620151418.1166195-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reading QEMU_CLOCK_VIRTUAL is thread-safe.

with CLI
 -M q35,hpet=off -cpu host -enable-kvm -smp 240,sockets=4
patch makes WS2025 guest, that wasn't able to boot in 30min, to boot in 2-1min.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 58f8964e13..683fbdd8df 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -547,6 +547,8 @@ void acpi_pm_tmr_init(ACPIREGS *ar, acpi_update_sci_fn update_sci,
     ar->tmr.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, acpi_pm_tmr_timer, ar);
     memory_region_init_io(&ar->tmr.io, memory_region_owner(parent),
                           &acpi_pm_tmr_ops, ar, "acpi-tmr", 4);
+    memory_region_enable_lockless_ro_io(&ar->tmr.io);
+    ar->tmr.io.disable_reentrancy_guard = true;
     memory_region_add_subregion(parent, 8, &ar->tmr.io);
 }
 
-- 
2.43.5


