Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF31606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=M4Egd2t9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCP-00040Q-K2; Thu, 29 Oct 2026 18:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC8-0003v8-Ah
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:02 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC2-0006WL-HT
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311302; x=1793916102; i=deller@gmx.de;
 bh=Ud2oj9k4fFI7A643qunLKX/2kev0r+HSbmDVLsNBxdI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=M4Egd2t9UF0mhpLmXypRo+KFuEla9gbbKq+Cvuqt9usMdN9GdVnz2DFUtChNnaBC
 0z5c+rlK0v72I4ms0yCKbO4xMtUuDe8LHQpfUMotSkfRwNQcKzdHC/odht4it4yLO
 ygdiUaeM/yXpJgdtijFwYh/mbZ8tWB9YG6fHMAP+yHTaFiUU1AeitMLp6G73ewaIL
 PXDc9Crp3XeFq9mKG1kX8niSh1gp1d/dh6c9ScbV/zqfGn9dThY0RUJCSuDOrkwJq
 pHlx9Y4kmVJ9bMocDDClTu1+vi0bPM+/lSnSHs2QXCQtj+5wH/wQBrsVopSeeVKES
 KVbpojJehpie3EG4pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9g4-1xLW0H2ttU-009iQH; Thu, 29
 Oct 2026 23:01:41 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 05/10] target/hppa: Implement local broadcast I/O space
Date: Thu, 29 Oct 2026 23:01:30 +0100
Message-ID: <20261029220135.412284-6-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029220135.412284-1-deller@gmx.de>
References: <20261029220135.412284-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ezoqjjKxSA8Xwk25kak/f4Wuy9FcJG+vmBLs6sXiE3KXnrHVJ//
 l9DBzqImvRs2UtU+LPtBJHyrZdIZVvYNmdoxBMHSZHaZ60NH+y7JV897caqmWHFcC1eRX69
 YgR58XhMvPM5Jl3RjxpT+4Acz9S8LF89RPQNNNsL2+m/lFJvTFBpFUV5S6XoiJSrTU2Vq+u
 Bxg7bdYC0g8zDKLSO+xgw==
UI-OutboundReport: notjunk:1;M01:P0:da+SiX9AVLc=;wEzMXo4EIcVYTCaAoHlrfoMJ9IV
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

The local broadcast I/O space is used by older operating systems like HP-U=
X 9.05
to send an interrupt to all CPUs, or to issue a system reset.
Wire it up on the emulated 715 machine to allow HP-UX 9.05 to run.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 96d57b9b0f..8d378385b2 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -573,6 +573,47 @@ static void machine_HP_common_init_tail(MachineState =
*machine, PCIBus *pci_bus,
     cpu[0]->env.kernel_entry =3D kernel_entry;
 }
=20
+/*
+ * Local broadcast I/O space: a write to IO_EIR (offset 0) posts an exter=
nal
+ * interrupt on all processors, CMD_RESET (5) written to IO_COMMAND (0x30=
)
+ * resets the system.  HP-UX 9 reboots through the latter.
+ */
+#define HPPA_BROADCAST_HPA      0xfffc0000
+#define HPPA_IO_COMMAND         0x30
+#define HPPA_CMD_RESET          5
+
+static uint64_t hppa_broadcast_read(void *opaque, hwaddr addr, unsigned s=
ize)
+{
+    return 0;
+}
+
+static void hppa_broadcast_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size)
+{
+    unsigned int i;
+
+    switch (addr) {
+    case 0:
+        for (i =3D 0; i < current_machine->smp.cpus; i++) {
+            hppa_io_eir_ops.write(cpu[i], 0, val, 4);
+        }
+        break;
+    case HPPA_IO_COMMAND:
+        if (val =3D=3D HPPA_CMD_RESET) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps hppa_broadcast_ops =3D {
+    .read =3D hppa_broadcast_read,
+    .write =3D hppa_broadcast_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+};
+
 /*
  * Create HP 715/64 workstation
  */
@@ -597,6 +638,14 @@ static void machine_HP_715_init(MachineState *machine=
)
     isa_bus =3D hppa_isa_bus(translate(NULL, IDE_HPA));
     assert(isa_bus);
=20
+    /* Local broadcast I/O space */
+    MemoryRegion *dev_mr_bcast =3D g_new(MemoryRegion, 1);
+    memory_region_init_io(dev_mr_bcast, NULL, &hppa_broadcast_ops, NULL,
+                          "local-broadcast", 0x1000);
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, HPPA_BROADCAST_HPA),
+                                dev_mr_bcast);
+
     /* Init Lasi chip */
     lasi_dev =3D DEVICE(lasi_init());
     hpm->lasi_dev =3D lasi_dev;
=2D-=20
2.56.0


