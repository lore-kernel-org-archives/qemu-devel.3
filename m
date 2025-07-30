Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2184C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 14:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh7Z0-0006HY-HN; Wed, 30 Jul 2025 10:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh663-0005cf-Gk
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uh660-0006tl-HD
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 08:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753879187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VRDAzl4q6o2ZOj98CGNsHZ+fXsoqdX1zXUVWLEyK8NA=;
 b=Q7hnKKAm67WnFj0GqMbYN39g9jdVnctD5lb0jJ60EsDHcds6ea0jNsHQBipV4WrEcUP2v8
 lOVizvY2iZORYpV0eznab1YEdmtKdGVJOSa++yDY8ET5adOp7y35X3YeZpD2hqgOPKY8a4
 43fdnA8y5GheRIChD08Fa32RpNgkJ/4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-2OKdExiFP_aPweoNyNZmPA-1; Wed,
 30 Jul 2025 08:39:45 -0400
X-MC-Unique: 2OKdExiFP_aPweoNyNZmPA-1
X-Mimecast-MFC-AGG-ID: 2OKdExiFP_aPweoNyNZmPA_1753879184
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D2AC1956080; Wed, 30 Jul 2025 12:39:44 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CB7330001BE; Wed, 30 Jul 2025 12:39:42 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2 2/6] acpi: mark PMTIMER as unlocked
Date: Wed, 30 Jul 2025 14:39:30 +0200
Message-ID: <20250730123934.1787379-3-imammedo@redhat.com>
In-Reply-To: <20250730123934.1787379-1-imammedo@redhat.com>
References: <20250730123934.1787379-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reading QEMU_CLOCK_VIRTUAL is thread-safe, write access is NOP.

This makes possible to boot Windows with large vCPUs count when
hv-time is not used.

Reproducer:
  -M q35,hpet=off -cpu host -enable-kvm -smp 240,sockets=4 -m 8G WS2025.img
fails to boot within 30min.

With this fix it boots within 2-1min.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 58f8964e13..ff16582803 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -547,6 +547,7 @@ void acpi_pm_tmr_init(ACPIREGS *ar, acpi_update_sci_fn update_sci,
     ar->tmr.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, acpi_pm_tmr_timer, ar);
     memory_region_init_io(&ar->tmr.io, memory_region_owner(parent),
                           &acpi_pm_tmr_ops, ar, "acpi-tmr", 4);
+    memory_region_enable_lockless_io(&ar->tmr.io);
     memory_region_add_subregion(parent, 8, &ar->tmr.io);
 }
 
-- 
2.47.1


