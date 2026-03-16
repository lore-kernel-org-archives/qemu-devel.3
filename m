Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB140F4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25Ng-0006B7-Hc; Mon, 16 Mar 2026 06:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Nc-0006AL-Bi
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Nb-0003PK-09
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0YG7IMsFrTBvRsWwNyhx32ATgEM7ENGPd8cRv9PZXE=;
 b=BAc/TkgqGV1hGPSpqEwBbxdab6LswcLQB1JrDMj2UZo+NnHXYdxsG0i/Gtf19BwrYU8xC/
 nA5Y8IqQYl8G9nqswWifTOp3nZ8EWwYQHB1TYV65VmcZ/kfFzXGcEVpFuplb+k28n09GLW
 I0A8sSg2Q9LNLkvB4HSIZiU2i5gSfYI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-_ljphtOEMay3NAhH1mC13Q-1; Mon,
 16 Mar 2026 06:40:55 -0400
X-MC-Unique: _ljphtOEMay3NAhH1mC13Q-1
X-Mimecast-MFC-AGG-ID: _ljphtOEMay3NAhH1mC13Q_1773657654
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A9EB19560B1; Mon, 16 Mar 2026 10:40:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0919519560AB; Mon, 16 Mar 2026 10:40:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 04/14] hw/riscv: microchip_pfsoc: Don't call qdev_get_machine
 in soc init
Date: Mon, 16 Mar 2026 11:40:29 +0100
Message-ID: <20260316104039.195960-5-thuth@redhat.com>
In-Reply-To: <20260316104039.195960-1-thuth@redhat.com>
References: <20260316104039.195960-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

Calling qdev_get_machine() in the soc_init function would result in
the following assert

    ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.

when trying to run

    ./qemu-system-riscv64 -S -display none -M virt -device microchip.pfsoc,help

as the machine wasn't created yet. We call qdev_get_machine() to obtain
the number of CPUs in the machine. So instead of setting the CPU
num-harts in the init function let's set it in realise where the machine
will exist.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260312043158.4191378-3-alistair.francis@wdc.com>
[thuth: Fix a complaint from checkpatch.pl with regards to multi-line comment]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/riscv/microchip_pfsoc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4ff83e49403..743f31f0057 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -143,7 +143,6 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
 
 static void microchip_pfsoc_soc_instance_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     MicrochipPFSoCState *s = MICROCHIP_PFSOC(obj);
 
     object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
@@ -162,7 +161,10 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
 
     object_initialize_child(OBJECT(&s->u_cluster), "u-cpus", &s->u_cpus,
                             TYPE_RISCV_HART_ARRAY);
-    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
+    /*
+     * Set the `num-harts` property later as the machine is potentially not
+     * created yet.
+     */
     qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type",
                          TYPE_RISCV_CPU_SIFIVE_U54);
@@ -204,6 +206,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     int i;
 
     sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
+    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
     sysbus_realize(SYS_BUS_DEVICE(&s->u_cpus), &error_abort);
     /*
      * The cluster must be realized after the RISC-V hart array container,
-- 
2.53.0


