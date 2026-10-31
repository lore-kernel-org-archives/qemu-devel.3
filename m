Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B6606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YSgwxAtg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4Ts-0002Zj-EF; Sat, 31 Oct 2026 04:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SX-0001jG-Uq
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:07 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SV-0001sN-3V
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435338; x=1794040138; i=deller@gmx.de;
 bh=Ud2oj9k4fFI7A643qunLKX/2kev0r+HSbmDVLsNBxdI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=YSgwxAtgs2RuU20temAFkvLYRAEDW4Ax0XiHx5029Cu6IS53g4Mw50E34T6VgPos
 2+qN3AWUlZvai6OpbliiM/GIb6KIe0PLj2YCsXQzXpE0nM9ullhdq8ACiCKz25ZWf
 8DZ9QQQuapEsRlJL7/Zky8x5Kr1jvbaWeBuiLR/an/0r8jod1e6iDSKehfRiwFu7f
 /vRr7ReCoOgjncI5F9SlYtoMUZQYfzLmD9+LpGQrKpGGUlYsuTpFXeQuXBSqXIKn2
 kKKrV1z43W648V2pN0nDuO3kvU4mWtN18q7LmCuSbVxLN4o5E85LhB9VfP5W3YMWd
 qomDM80rcPEWPU9GEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1wdNUe0Ky2-014mFj; Sat, 31
 Oct 2026 09:28:58 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 05/10] target/hppa: Implement local broadcast I/O space
Date: Sat, 31 Oct 2026 09:28:45 +0100
Message-ID: <20261031082850.439293-6-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
References: <20261031082850.439293-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zfLVS4aVLK5hzgSdd3MYs3Xale1duRK7eFOmsaw4OJ2gk2LiODh
 jsmFa5SdFmOvKZxzpHV+7gR6M/OCcmjbxsxWu62fhezYIN/cXOupvW9VIq09QR/+xGwUY3N
 dgcA9g6vQwJXG98G1Yj38jZysiCsm8E8HG1V/4JmYPwe9CaWV/PXC6MEiOtmNUV/LTc977m
 CIJhsR/5B8ed/i9iqY5YA==
UI-OutboundReport: notjunk:1;M01:P0:RWlaLHQy0S4=;ei30UANVmWFDPjoGlt6eiC1MKZj
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


