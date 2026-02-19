Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9F3E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 12:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt3OT-0007M9-4w; Thu, 19 Feb 2026 07:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vt3OG-0007Kz-CK
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:44:22 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vt3OC-0008As-Fo
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:44:20 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7754860054;
 Thu, 19 Feb 2026 12:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B80C4CEF7;
 Thu, 19 Feb 2026 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771505053;
 bh=B9qVYZiwKR+KMalwfv4UURWgIIX0zekfhi+LaKql/4M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jxoogA62XXkceYKiO1qNimU87xwb0AsUPmOdqlYHjUh7FVTrGckRkR8KnOAuSG8lC
 8cRjg4TUVXpvc62yK6LI4LGdt0uv940bBHBgFbS/3OSt6AzK4OMxi04nu9RW01HJp5
 pvVbBi9htgrLu4wdI3dk70+9/dD1zYZ5f8zNeiN7NSobVF+12vHATKZun9HH+ug44w
 sWmgTObQVD6o9RHMup8JVNH+qqHc9/7Urx/YIe7UXgkqXxv8bjH4vSRJ+apb6rb1S2
 Q1Vh+L7RYtwHVvXTKz7/s6iOXo808WJymz6so/i0JZpV8b0YzJkzZDb1NHd2bBK0Bk
 P7IQXi4gPkeBA==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 1/4] hw/hppa: Add BMC on 64-bit machines only
Date: Thu, 19 Feb 2026 13:44:05 +0100
Message-ID: <20260219124408.3515-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219124408.3515-1-deller@kernel.org>
References: <20260219124408.3515-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Prevent adding the BMC with it's serial ports on 32-bit machines, even
if they have a PCI bus like the B160L. This fixes boot problems with
HP-UX on B160L.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 557bc5260cfd ("hw/hppa: PCI devices depend on availability of PCI bus")
Cc: qemu-stable@nongnu.org
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 hw/hppa/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c3680667ae..d6aeb793c0 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -376,7 +376,9 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     if (pci_bus) {
         pci_init_nic_devices(pci_bus, mc->default_nic);
+    }
 
+    if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
         /* BMC board: HP Diva GSP PCI card */
         dev = qdev_new("diva-gsp");
         if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {
-- 
2.53.0


