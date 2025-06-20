Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C99C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 15:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSdRz-0002zH-Un; Fri, 20 Jun 2025 11:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSdRy-0002z5-1H
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSdRw-00065I-JD
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750432479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68oPZUBcR0lOIUXgVaaOSLm+CVhFgV3mNyxRSCWThXU=;
 b=cctxJUrZhFexBiM+yOKfaypn8aiGXARM47r8wyj+2yOyL0rBJ0WLGzhMBbpcps5Vznk48P
 B2dpi1Vm5/R/58ttvEWsGSY1PZ/pu0uRw0cIPLWIC92xquM6AGSNhxa5pBCLyXxLhRnkQY
 6lUu6VUPub4Mb/tXtk73zOAR0f0hHi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-gs-BzYYcO7GQ5ybyng8AVA-1; Fri,
 20 Jun 2025 11:14:36 -0400
X-MC-Unique: gs-BzYYcO7GQ5ybyng8AVA-1
X-Mimecast-MFC-AGG-ID: gs-BzYYcO7GQ5ybyng8AVA_1750432475
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96E161956096; Fri, 20 Jun 2025 15:14:35 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D69741956094; Fri, 20 Jun 2025 15:14:32 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, anisinha@redhat.com,
 elena.ufimtseva@oracle.com, jag.raman@oracle.com, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org
Subject: [PATCH 3/3] mark HPET as unlocked
Date: Fri, 20 Jun 2025 17:14:18 +0200
Message-ID: <20250620151418.1166195-4-imammedo@redhat.com>
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
 -M q35,hpet=on -cpu host -enable-kvm -smp 240,sockets=4
patch makes WS2025 guest, that was able to boot in 4/2min, to boot in 2/1min.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/timer/hpet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 0fd1337a15..1ebd715529 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -681,6 +681,8 @@ static void hpet_init(Object *obj)
 
     /* HPET Area */
     memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
+    memory_region_enable_lockless_ro_io(&s->iomem);
+    s->iomem.disable_reentrancy_guard = true;
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-- 
2.43.5


