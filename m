Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47483CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKXOc-0001Ff-BJ; Wed, 06 May 2026 04:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wKWwG-0000i3-79
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:45:01 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wKWwA-0005Cn-3D
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:44:59 -0400
DKIM-Signature: a=rsa-sha256; bh=3+wP/vIMmkfO3LJ9pesq4t/M6R76ZDPDIePik4g08h4=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1778053490; v=1;
 b=E0/cvaTR6Z3zcdCfdLF+etfaBRQP4Bb+T0Ea4/Ly/NSy1neRMm36wtA5swqJqpGWjFR47aJK
 DTJ/Igmzt91b3Ip1bC8+3R3rRXNiKUTFd5tVr9hiqH4la4n2+Yrz6eK39yE2CQ9WkcS9W+d+MAK
 b4oOQTcYBR2bGVU+uihYzrgcCpb/CI2e3wxUt7jhA5XvsAj1dZdHE4afooon8fEtQHl0oTMzfJ6
 RXz6SVL+M0FHYMLHy0t+fK4kkUS3rrjY/WuPlm3pLk3HCcvEcz1dtv9BMZVpvOTsWK1O2jqU5pE
 lD+hOau216t8jHGHorwwpsGdVeEGC2NCPS9/VFVdl4xeQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 8983E20E6D;
 Wed, 06 May 2026 07:44:50 +0000 (UTC)
From: ~bboe <bboe@git.sr.ht>
Date: Tue, 05 May 2026 21:20:58 -0700
Subject: [PATCH qemu 2/3] Add the Nuked OPL3 emulator
Message-ID: <177805349017.32250.15775019749727013358-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177805349017.32250.15775019749727013358-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 30
X-Spam_score: 3.0
X-Spam_bar: +++
X-Spam_report: (3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 HK_RANDOM_REPLYTO=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 May 2026 04:14:14 -0400
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
Reply-To: ~bboe <bbzbryce@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bryce Boe <bbzbryce@gmail.com>

I chose this emulator, by Alexey Khokholov, as it appears to be well used amo=
ng
DOS-target emulation software.

Source:
https://github.com/nukeykt/Nuked-OPL3/tree/cfedb09efc03f1d7b5fc1f04dd449d77d8=
c49d50

Two files were copied verbatim with the following exceptions:

- Added `nuked_` prefix to clearly mark the source.
- Modified the header import due to the rename

Please note that I did not adapt the style of these files to make it easier to
diff with upstream.

I added the test file under unit tests because it does not depend on a running
Qemu instance. There doesn't seem to be precedence for hardware unit tests.

Signed-off-by: Bryce Boe <bbzbryce@gmail.com>
---
 hw/audio/meson.build         |    2 +-
 hw/audio/nuked_opl3.c        | 1530 ++++++++++++++++++++++++++++++++++
 hw/audio/nuked_opl3.h        |  173 ++++
 tests/unit/test-nuked-opl3.c |  109 +++
 4 files changed, 1813 insertions(+), 1 deletion(-)
 create mode 100644 hw/audio/nuked_opl3.c
 create mode 100644 hw/audio/nuked_opl3.h
 create mode 100644 tests/unit/test-nuked-opl3.c

diff --git a/hw/audio/meson.build b/hw/audio/meson.build
index 2154cbdb57..5bd0b6e4c2 100644
--- a/hw/audio/meson.build
+++ b/hw/audio/meson.build
@@ -10,7 +10,7 @@ system_ss.add(when: 'CONFIG_HDA', if_true: files('intel-hda=
.c', 'hda-codec.c'))
 system_ss.add(when: 'CONFIG_MARVELL_88W8618', if_true: files('marvell_88w861=
8.c'))
 system_ss.add(when: 'CONFIG_PCSPK', if_true: files('pcspk.c'))
 system_ss.add(when: 'CONFIG_PL041', if_true: files('pl041.c', 'lm4549.c'))
-system_ss.add(when: 'CONFIG_SB16', if_true: files('sb16.c'))
+system_ss.add(when: 'CONFIG_SB16', if_true: files('sb16.c', 'nuked_opl3.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('via-ac97.c'))
 system_ss.add(when: 'CONFIG_WM8750', if_true: files('wm8750.c'))
 system_ss.add(when: ['CONFIG_VIRTIO_SND', 'CONFIG_VIRTIO'], if_true: files('=
virtio-snd.c'))
diff --git a/hw/audio/nuked_opl3.c b/hw/audio/nuked_opl3.c
new file mode 100644
index 0000000000..a50817d7bc
--- /dev/null
+++ b/hw/audio/nuked_opl3.c
@@ -0,0 +1,1530 @@
+/* Nuked OPL3
+ * Copyright (C) 2013-2020 Nuke.YKT
+ *
+ * This file is part of Nuked OPL3.
+ *
+ * Nuked OPL3 is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU Lesser General Public License as
+ * published by the Free Software Foundation, either version 2.1
+ * of the License, or (at your option) any later version.
+ *
+ * Nuked OPL3 is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with Nuked OPL3. If not, see <https://www.gnu.org/licenses/>.
+
+ *  Nuked OPL3 emulator.
+ *  Thanks:
+ *      MAME Development Team(Jarek Burczynski, Tatsuyuki Satoh):
+ *          Feedback and Rhythm part calculation information.
+ *      forums.submarine.org.uk(carbon14, opl3):
+ *          Tremolo and phase generator calculation information.
+ *      OPLx decapsulated(Matthew Gambrell, Olli Niemitalo):
+ *          OPL2 ROMs.
+ *      siliconpr0n.org(John McMaster, digshadow):
+ *          YMF262 and VRC VII decaps and die shots.
+ *
+ * version: 1.8
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "nuked_opl3.h"
+
+#if OPL_ENABLE_STEREOEXT && !defined OPL_SIN
+#ifndef _USE_MATH_DEFINES
+#define _USE_MATH_DEFINES 1
+#endif
+#include <math.h>
+/* input: [0, 256), output: [0, 65536] */
+#define OPL_SIN(x) ((int32_t)(sin((x) * M_PI / 512.0) * 65536.0))
+#endif
+
+/* Quirk: Some FM channels are output one sample later on the left side than=
 the right. */
+#ifndef OPL_QUIRK_CHANNELSAMPLEDELAY
+#define OPL_QUIRK_CHANNELSAMPLEDELAY (!OPL_ENABLE_STEREOEXT)
+#endif
+
+#define RSM_FRAC    10
+
+/* Channel types */
+
+enum {
+    ch_2op =3D 0,
+    ch_4op =3D 1,
+    ch_4op2 =3D 2,
+    ch_drum =3D 3
+};
+
+/* Envelope key types */
+
+enum {
+    egk_norm =3D 0x01,
+    egk_drum =3D 0x02
+};
+
+
+/*
+    logsin table
+*/
+
+static const uint16_t logsinrom[256] =3D {
+    0x859, 0x6c3, 0x607, 0x58b, 0x52e, 0x4e4, 0x4a6, 0x471,
+    0x443, 0x41a, 0x3f5, 0x3d3, 0x3b5, 0x398, 0x37e, 0x365,
+    0x34e, 0x339, 0x324, 0x311, 0x2ff, 0x2ed, 0x2dc, 0x2cd,
+    0x2bd, 0x2af, 0x2a0, 0x293, 0x286, 0x279, 0x26d, 0x261,
+    0x256, 0x24b, 0x240, 0x236, 0x22c, 0x222, 0x218, 0x20f,
+    0x206, 0x1fd, 0x1f5, 0x1ec, 0x1e4, 0x1dc, 0x1d4, 0x1cd,
+    0x1c5, 0x1be, 0x1b7, 0x1b0, 0x1a9, 0x1a2, 0x19b, 0x195,
+    0x18f, 0x188, 0x182, 0x17c, 0x177, 0x171, 0x16b, 0x166,
+    0x160, 0x15b, 0x155, 0x150, 0x14b, 0x146, 0x141, 0x13c,
+    0x137, 0x133, 0x12e, 0x129, 0x125, 0x121, 0x11c, 0x118,
+    0x114, 0x10f, 0x10b, 0x107, 0x103, 0x0ff, 0x0fb, 0x0f8,
+    0x0f4, 0x0f0, 0x0ec, 0x0e9, 0x0e5, 0x0e2, 0x0de, 0x0db,
+    0x0d7, 0x0d4, 0x0d1, 0x0cd, 0x0ca, 0x0c7, 0x0c4, 0x0c1,
+    0x0be, 0x0bb, 0x0b8, 0x0b5, 0x0b2, 0x0af, 0x0ac, 0x0a9,
+    0x0a7, 0x0a4, 0x0a1, 0x09f, 0x09c, 0x099, 0x097, 0x094,
+    0x092, 0x08f, 0x08d, 0x08a, 0x088, 0x086, 0x083, 0x081,
+    0x07f, 0x07d, 0x07a, 0x078, 0x076, 0x074, 0x072, 0x070,
+    0x06e, 0x06c, 0x06a, 0x068, 0x066, 0x064, 0x062, 0x060,
+    0x05e, 0x05c, 0x05b, 0x059, 0x057, 0x055, 0x053, 0x052,
+    0x050, 0x04e, 0x04d, 0x04b, 0x04a, 0x048, 0x046, 0x045,
+    0x043, 0x042, 0x040, 0x03f, 0x03e, 0x03c, 0x03b, 0x039,
+    0x038, 0x037, 0x035, 0x034, 0x033, 0x031, 0x030, 0x02f,
+    0x02e, 0x02d, 0x02b, 0x02a, 0x029, 0x028, 0x027, 0x026,
+    0x025, 0x024, 0x023, 0x022, 0x021, 0x020, 0x01f, 0x01e,
+    0x01d, 0x01c, 0x01b, 0x01a, 0x019, 0x018, 0x017, 0x017,
+    0x016, 0x015, 0x014, 0x014, 0x013, 0x012, 0x011, 0x011,
+    0x010, 0x00f, 0x00f, 0x00e, 0x00d, 0x00d, 0x00c, 0x00c,
+    0x00b, 0x00a, 0x00a, 0x009, 0x009, 0x008, 0x008, 0x007,
+    0x007, 0x007, 0x006, 0x006, 0x005, 0x005, 0x005, 0x004,
+    0x004, 0x004, 0x003, 0x003, 0x003, 0x002, 0x002, 0x002,
+    0x002, 0x001, 0x001, 0x001, 0x001, 0x001, 0x001, 0x001,
+    0x000, 0x000, 0x000, 0x000, 0x000, 0x000, 0x000, 0x000
+};
+
+/*
+    exp table
+*/
+
+static const uint16_t exprom[256] =3D {
+    0x7fa, 0x7f5, 0x7ef, 0x7ea, 0x7e4, 0x7df, 0x7da, 0x7d4,
+    0x7cf, 0x7c9, 0x7c4, 0x7bf, 0x7b9, 0x7b4, 0x7ae, 0x7a9,
+    0x7a4, 0x79f, 0x799, 0x794, 0x78f, 0x78a, 0x784, 0x77f,
+    0x77a, 0x775, 0x770, 0x76a, 0x765, 0x760, 0x75b, 0x756,
+    0x751, 0x74c, 0x747, 0x742, 0x73d, 0x738, 0x733, 0x72e,
+    0x729, 0x724, 0x71f, 0x71a, 0x715, 0x710, 0x70b, 0x706,
+    0x702, 0x6fd, 0x6f8, 0x6f3, 0x6ee, 0x6e9, 0x6e5, 0x6e0,
+    0x6db, 0x6d6, 0x6d2, 0x6cd, 0x6c8, 0x6c4, 0x6bf, 0x6ba,
+    0x6b5, 0x6b1, 0x6ac, 0x6a8, 0x6a3, 0x69e, 0x69a, 0x695,
+    0x691, 0x68c, 0x688, 0x683, 0x67f, 0x67a, 0x676, 0x671,
+    0x66d, 0x668, 0x664, 0x65f, 0x65b, 0x657, 0x652, 0x64e,
+    0x649, 0x645, 0x641, 0x63c, 0x638, 0x634, 0x630, 0x62b,
+    0x627, 0x623, 0x61e, 0x61a, 0x616, 0x612, 0x60e, 0x609,
+    0x605, 0x601, 0x5fd, 0x5f9, 0x5f5, 0x5f0, 0x5ec, 0x5e8,
+    0x5e4, 0x5e0, 0x5dc, 0x5d8, 0x5d4, 0x5d0, 0x5cc, 0x5c8,
+    0x5c4, 0x5c0, 0x5bc, 0x5b8, 0x5b4, 0x5b0, 0x5ac, 0x5a8,
+    0x5a4, 0x5a0, 0x59c, 0x599, 0x595, 0x591, 0x58d, 0x589,
+    0x585, 0x581, 0x57e, 0x57a, 0x576, 0x572, 0x56f, 0x56b,
+    0x567, 0x563, 0x560, 0x55c, 0x558, 0x554, 0x551, 0x54d,
+    0x549, 0x546, 0x542, 0x53e, 0x53b, 0x537, 0x534, 0x530,
+    0x52c, 0x529, 0x525, 0x522, 0x51e, 0x51b, 0x517, 0x514,
+    0x510, 0x50c, 0x509, 0x506, 0x502, 0x4ff, 0x4fb, 0x4f8,
+    0x4f4, 0x4f1, 0x4ed, 0x4ea, 0x4e7, 0x4e3, 0x4e0, 0x4dc,
+    0x4d9, 0x4d6, 0x4d2, 0x4cf, 0x4cc, 0x4c8, 0x4c5, 0x4c2,
+    0x4be, 0x4bb, 0x4b8, 0x4b5, 0x4b1, 0x4ae, 0x4ab, 0x4a8,
+    0x4a4, 0x4a1, 0x49e, 0x49b, 0x498, 0x494, 0x491, 0x48e,
+    0x48b, 0x488, 0x485, 0x482, 0x47e, 0x47b, 0x478, 0x475,
+    0x472, 0x46f, 0x46c, 0x469, 0x466, 0x463, 0x460, 0x45d,
+    0x45a, 0x457, 0x454, 0x451, 0x44e, 0x44b, 0x448, 0x445,
+    0x442, 0x43f, 0x43c, 0x439, 0x436, 0x433, 0x430, 0x42d,
+    0x42a, 0x428, 0x425, 0x422, 0x41f, 0x41c, 0x419, 0x416,
+    0x414, 0x411, 0x40e, 0x40b, 0x408, 0x406, 0x403, 0x400
+};
+
+/*
+    freq mult table multiplied by 2
+
+    1/2, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 12, 12, 15, 15
+*/
+
+static const uint8_t mt[16] =3D {
+    1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 20, 24, 24, 30, 30
+};
+
+/*
+    ksl table
+*/
+
+static const uint8_t kslrom[16] =3D {
+    0, 32, 40, 45, 48, 51, 53, 55, 56, 58, 59, 60, 61, 62, 63, 64
+};
+
+static const uint8_t kslshift[4] =3D {
+    8, 1, 2, 0
+};
+
+/*
+    envelope generator constants
+*/
+
+static const uint8_t eg_incstep[4][4] =3D {
+    { 0, 0, 0, 0 },
+    { 1, 0, 0, 0 },
+    { 1, 0, 1, 0 },
+    { 1, 1, 1, 0 }
+};
+
+/*
+    address decoding
+*/
+
+static const int8_t ad_slot[0x20] =3D {
+    0, 1, 2, 3, 4, 5, -1, -1, 6, 7, 8, 9, 10, 11, -1, -1,
+    12, 13, 14, 15, 16, 17, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static const uint8_t ch_slot[18] =3D {
+    0, 1, 2, 6, 7, 8, 12, 13, 14, 18, 19, 20, 24, 25, 26, 30, 31, 32
+};
+
+#if OPL_ENABLE_STEREOEXT
+/*
+    stereo extension panning table
+*/
+
+static int32_t panpot_lut[256];
+static uint8_t panpot_lut_build =3D 0;
+#endif
+
+/*
+    Envelope generator
+*/
+
+typedef int16_t(*envelope_sinfunc)(uint16_t phase, uint16_t envelope);
+typedef void(*envelope_genfunc)(opl3_slot *slott);
+
+static int16_t OPL3_EnvelopeCalcExp(uint32_t level)
+{
+    if (level > 0x1fff)
+    {
+        level =3D 0x1fff;
+    }
+    return (exprom[level & 0xffu] << 1) >> (level >> 8);
+}
+
+static int16_t OPL3_EnvelopeCalcSin0(uint16_t phase, uint16_t envelope)
+{
+    uint16_t out =3D 0;
+    uint16_t neg =3D 0;
+    phase &=3D 0x3ff;
+    if (phase & 0x200)
+    {
+        neg =3D 0xffff;
+    }
+    if (phase & 0x100)
+    {
+        out =3D logsinrom[(phase & 0xffu) ^ 0xffu];
+    }
+    else
+    {
+        out =3D logsinrom[phase & 0xffu];
+    }
+    return OPL3_EnvelopeCalcExp(out + (envelope << 3)) ^ neg;
+}
+
+static int16_t OPL3_EnvelopeCalcSin1(uint16_t phase, uint16_t envelope)
+{
+    uint16_t out =3D 0;
+    phase &=3D 0x3ff;
+    if (phase & 0x200)
+    {
+        out =3D 0x1000;
+    }
+    else if (phase & 0x100)
+    {
+        out =3D logsinrom[(phase & 0xffu) ^ 0xffu];
+    }
+    else
+    {
+        out =3D logsinrom[phase & 0xffu];
+    }
+    return OPL3_EnvelopeCalcExp(out + (envelope << 3));
+}
+
+static int16_t OPL3_EnvelopeCalcSin2(uint16_t phase, uint16_t envelope)
+{
+    uint16_t out =3D 0;
+    phase &=3D 0x3ff;
+    if (phase & 0x100)
+    {
+        out =3D logsinrom[(phase & 0xffu) ^ 0xffu];
+    }
+    else
+    {
+        out =3D logsinrom[phase & 0xffu];
+    }
+    return OPL3_EnvelopeCalcExp(out + (envelope << 3));
+}
+
+static int16_t OPL3_EnvelopeCalcSin3(uint16_t phase, uint16_t envelope)
+{
+    uint16_t out =3D 0;
+    phase &=3D 0x3ff;
+    if (phase & 0x100)
+    {
+        out =3D 0x1000;
+    }
+    else
+    {
+        out =3D logsinrom[phase & 0xffu];
+    }
+    return OPL3_EnvelopeCalcExp(out + (envelope << 3));
+}
+
+static int16_t OPL3_EnvelopeCalcSin4(uint16_t phase, uint16_t envelope)
+{
+    uint16_t out =3D 0;
+    uint16_t neg =3D 0;
+    phase &=3D 0x3ff;
+    if ((phase & 0x300) =3D=3D 0x100)
+    {
+        neg =3D 0xffff;
+    }
+    if (phase & 0x200)
+    {
+        out =3D 0x1000;
+    }
+    else if (phase & 0x80)
+    {
+        out =3D logsinrom[((phase ^ 0xffu) << 1u) & 0xffu];
+    }
+    else
+    {
+        out =3D logsinrom[(phase << 1u) & 0xffu];
+    }
+    return OPL3_EnvelopeCalcExp(out + (envelope << 3)) ^ neg;
+}
+
+static int16_t OPL3_EnvelopeCalcSin5(uint16_t phase, uint16_t envelope)
+{
+    uint16_t out =3D 0;
+    phase &=3D 0x3ff;
+    if (phase & 0x200)
+    {
+        out =3D 0x1000;
+    }
+    else if (phase & 0x80)
+    {
+        out =3D logsinrom[((phase ^ 0xffu) << 1u) & 0xffu];
+    }
+    else
+    {
+        out =3D logsinrom[(phase << 1u) & 0xffu];
+    }
+    return OPL3_EnvelopeCalcExp(out + (envelope << 3));
+}
+
+static int16_t OPL3_EnvelopeCalcSin6(uint16_t phase, uint16_t envelope)
+{
+    uint16_t neg =3D 0;
+    phase &=3D 0x3ff;
+    if (phase & 0x200)
+    {
+        neg =3D 0xffff;
+    }
+    return OPL3_EnvelopeCalcExp(envelope << 3) ^ neg;
+}
+
+static int16_t OPL3_EnvelopeCalcSin7(uint16_t phase, uint16_t envelope)
+{
+    uint16_t out =3D 0;
+    uint16_t neg =3D 0;
+    phase &=3D 0x3ff;
+    if (phase & 0x200)
+    {
+        neg =3D 0xffff;
+        phase =3D (phase & 0x1ff) ^ 0x1ff;
+    }
+    out =3D phase << 3;
+    return OPL3_EnvelopeCalcExp(out + (envelope << 3)) ^ neg;
+}
+
+static const envelope_sinfunc envelope_sin[8] =3D {
+    OPL3_EnvelopeCalcSin0,
+    OPL3_EnvelopeCalcSin1,
+    OPL3_EnvelopeCalcSin2,
+    OPL3_EnvelopeCalcSin3,
+    OPL3_EnvelopeCalcSin4,
+    OPL3_EnvelopeCalcSin5,
+    OPL3_EnvelopeCalcSin6,
+    OPL3_EnvelopeCalcSin7
+};
+
+enum envelope_gen_num
+{
+    envelope_gen_num_attack =3D 0,
+    envelope_gen_num_decay =3D 1,
+    envelope_gen_num_sustain =3D 2,
+    envelope_gen_num_release =3D 3
+};
+
+static void OPL3_EnvelopeUpdateKSL(opl3_slot *slot)
+{
+    int16_t ksl =3D (kslrom[slot->channel->f_num >> 6u] << 2)
+               - ((0x08 - slot->channel->block) << 5);
+    if (ksl < 0)
+    {
+        ksl =3D 0;
+    }
+    slot->eg_ksl =3D (uint8_t)ksl;
+}
+
+static void OPL3_EnvelopeCalc(opl3_slot *slot)
+{
+    uint8_t nonzero;
+    uint8_t rate;
+    uint8_t rate_hi;
+    uint8_t rate_lo;
+    uint8_t reg_rate =3D 0;
+    uint8_t ks;
+    uint8_t eg_shift, shift;
+    uint16_t eg_rout;
+    int16_t eg_inc;
+    uint8_t eg_off;
+    uint8_t reset =3D 0;
+    slot->eg_out =3D slot->eg_rout + (slot->reg_tl << 2)
+                 + (slot->eg_ksl >> kslshift[slot->reg_ksl]) + *slot->trem;
+    if (slot->key && slot->eg_gen =3D=3D envelope_gen_num_release)
+    {
+        reset =3D 1;
+        reg_rate =3D slot->reg_ar;
+    }
+    else
+    {
+        switch (slot->eg_gen)
+        {
+        case envelope_gen_num_attack:
+            reg_rate =3D slot->reg_ar;
+            break;
+        case envelope_gen_num_decay:
+            reg_rate =3D slot->reg_dr;
+            break;
+        case envelope_gen_num_sustain:
+            if (!slot->reg_type)
+            {
+                reg_rate =3D slot->reg_rr;
+            }
+            break;
+        case envelope_gen_num_release:
+            reg_rate =3D slot->reg_rr;
+            break;
+        }
+    }
+    slot->pg_reset =3D reset;
+    ks =3D slot->channel->ksv >> ((slot->reg_ksr ^ 1) << 1);
+    nonzero =3D (reg_rate !=3D 0);
+    rate =3D ks + (reg_rate << 2);
+    rate_hi =3D rate >> 2;
+    rate_lo =3D rate & 0x03;
+    if (rate_hi & 0x10)
+    {
+        rate_hi =3D 0x0f;
+    }
+    eg_shift =3D rate_hi + slot->chip->eg_add;
+    shift =3D 0;
+    if (nonzero)
+    {
+        if (rate_hi < 12)
+        {
+            if (slot->chip->eg_state)
+            {
+                switch (eg_shift)
+                {
+                case 12:
+                    shift =3D 1;
+                    break;
+                case 13:
+                    shift =3D (rate_lo >> 1) & 0x01;
+                    break;
+                case 14:
+                    shift =3D rate_lo & 0x01;
+                    break;
+                default:
+                    break;
+                }
+            }
+        }
+        else
+        {
+            shift =3D (rate_hi & 0x03) + eg_incstep[rate_lo][slot->chip->eg_=
timer_lo];
+            if (shift & 0x04)
+            {
+                shift =3D 0x03;
+            }
+            if (!shift)
+            {
+                shift =3D slot->chip->eg_state;
+            }
+        }
+    }
+    eg_rout =3D slot->eg_rout;
+    eg_inc =3D 0;
+    eg_off =3D 0;
+    /* Instant attack */
+    if (reset && rate_hi =3D=3D 0x0f)
+    {
+        eg_rout =3D 0x00;
+    }
+    /* Envelope off */
+    if ((slot->eg_rout & 0x1f8) =3D=3D 0x1f8)
+    {
+        eg_off =3D 1;
+    }
+    if (slot->eg_gen !=3D envelope_gen_num_attack && !reset && eg_off)
+    {
+        eg_rout =3D 0x1ff;
+    }
+    switch (slot->eg_gen)
+    {
+    case envelope_gen_num_attack:
+        if (!slot->eg_rout)
+        {
+            slot->eg_gen =3D envelope_gen_num_decay;
+        }
+        else if (slot->key && shift > 0 && rate_hi !=3D 0x0f)
+        {
+            eg_inc =3D ~slot->eg_rout >> (4 - shift);
+        }
+        break;
+    case envelope_gen_num_decay:
+        if ((slot->eg_rout >> 4) =3D=3D slot->reg_sl)
+        {
+            slot->eg_gen =3D envelope_gen_num_sustain;
+        }
+        else if (!eg_off && !reset && shift > 0)
+        {
+            eg_inc =3D 1 << (shift - 1);
+        }
+        break;
+    case envelope_gen_num_sustain:
+    case envelope_gen_num_release:
+        if (!eg_off && !reset && shift > 0)
+        {
+            eg_inc =3D 1 << (shift - 1);
+        }
+        break;
+    }
+    slot->eg_rout =3D (eg_rout + eg_inc) & 0x1ff;
+    /* Key off */
+    if (reset)
+    {
+        slot->eg_gen =3D envelope_gen_num_attack;
+    }
+    if (!slot->key)
+    {
+        slot->eg_gen =3D envelope_gen_num_release;
+    }
+}
+
+static void OPL3_EnvelopeKeyOn(opl3_slot *slot, uint8_t type)
+{
+    slot->key |=3D type;
+}
+
+static void OPL3_EnvelopeKeyOff(opl3_slot *slot, uint8_t type)
+{
+    slot->key &=3D ~type;
+}
+
+/*
+    Phase Generator
+*/
+
+static void OPL3_PhaseGenerate(opl3_slot *slot)
+{
+    opl3_chip *chip;
+    uint16_t f_num;
+    uint32_t basefreq;
+    uint8_t rm_xor, n_bit;
+    uint32_t noise;
+    uint16_t phase;
+
+    chip =3D slot->chip;
+    f_num =3D slot->channel->f_num;
+    if (slot->reg_vib)
+    {
+        int8_t range;
+        uint8_t vibpos;
+
+        range =3D (f_num >> 7) & 7;
+        vibpos =3D slot->chip->vibpos;
+
+        if (!(vibpos & 3))
+        {
+            range =3D 0;
+        }
+        else if (vibpos & 1)
+        {
+            range >>=3D 1;
+        }
+        range >>=3D slot->chip->vibshift;
+
+        if (vibpos & 4)
+        {
+            range =3D -range;
+        }
+        f_num +=3D range;
+    }
+    basefreq =3D (f_num << slot->channel->block) >> 1;
+    phase =3D (uint16_t)(slot->pg_phase >> 9);
+    if (slot->pg_reset)
+    {
+        slot->pg_phase =3D 0;
+    }
+    slot->pg_phase +=3D (basefreq * mt[slot->reg_mult]) >> 1;
+    /* Rhythm mode */
+    noise =3D chip->noise;
+    slot->pg_phase_out =3D phase;
+    if (slot->slot_num =3D=3D 13) /* hh */
+    {
+        chip->rm_hh_bit2 =3D (phase >> 2) & 1;
+        chip->rm_hh_bit3 =3D (phase >> 3) & 1;
+        chip->rm_hh_bit7 =3D (phase >> 7) & 1;
+        chip->rm_hh_bit8 =3D (phase >> 8) & 1;
+    }
+    if (slot->slot_num =3D=3D 17 && (chip->rhy & 0x20)) /* tc */
+    {
+        chip->rm_tc_bit3 =3D (phase >> 3) & 1;
+        chip->rm_tc_bit5 =3D (phase >> 5) & 1;
+    }
+    if (chip->rhy & 0x20)
+    {
+        rm_xor =3D (chip->rm_hh_bit2 ^ chip->rm_hh_bit7)
+               | (chip->rm_hh_bit3 ^ chip->rm_tc_bit5)
+               | (chip->rm_tc_bit3 ^ chip->rm_tc_bit5);
+        switch (slot->slot_num)
+        {
+        case 13: /* hh */
+            slot->pg_phase_out =3D rm_xor << 9;
+            if (rm_xor ^ (noise & 1))
+            {
+                slot->pg_phase_out |=3D 0xd0;
+            }
+            else
+            {
+                slot->pg_phase_out |=3D 0x34;
+            }
+            break;
+        case 16: /* sd */
+            slot->pg_phase_out =3D (chip->rm_hh_bit8 << 9)
+                               | ((chip->rm_hh_bit8 ^ (noise & 1)) << 8);
+            break;
+        case 17: /* tc */
+            slot->pg_phase_out =3D (rm_xor << 9) | 0x80;
+            break;
+        default:
+            break;
+        }
+    }
+    n_bit =3D ((noise >> 14) ^ noise) & 0x01;
+    chip->noise =3D (noise >> 1) | (n_bit << 22);
+}
+
+/*
+    Slot
+*/
+
+static void OPL3_SlotWrite20(opl3_slot *slot, uint8_t data)
+{
+    if ((data >> 7) & 0x01)
+    {
+        slot->trem =3D &slot->chip->tremolo;
+    }
+    else
+    {
+        slot->trem =3D (uint8_t*)&slot->chip->zeromod;
+    }
+    slot->reg_vib =3D (data >> 6) & 0x01;
+    slot->reg_type =3D (data >> 5) & 0x01;
+    slot->reg_ksr =3D (data >> 4) & 0x01;
+    slot->reg_mult =3D data & 0x0f;
+}
+
+static void OPL3_SlotWrite40(opl3_slot *slot, uint8_t data)
+{
+    slot->reg_ksl =3D (data >> 6) & 0x03;
+    slot->reg_tl =3D data & 0x3f;
+    OPL3_EnvelopeUpdateKSL(slot);
+}
+
+static void OPL3_SlotWrite60(opl3_slot *slot, uint8_t data)
+{
+    slot->reg_ar =3D (data >> 4) & 0x0f;
+    slot->reg_dr =3D data & 0x0f;
+}
+
+static void OPL3_SlotWrite80(opl3_slot *slot, uint8_t data)
+{
+    slot->reg_sl =3D (data >> 4) & 0x0f;
+    if (slot->reg_sl =3D=3D 0x0f)
+    {
+        slot->reg_sl =3D 0x1f;
+    }
+    slot->reg_rr =3D data & 0x0f;
+}
+
+static void OPL3_SlotWriteE0(opl3_slot *slot, uint8_t data)
+{
+    slot->reg_wf =3D data & 0x07;
+    if (slot->chip->newm =3D=3D 0x00)
+    {
+        slot->reg_wf &=3D 0x03;
+    }
+}
+
+static void OPL3_SlotGenerate(opl3_slot *slot)
+{
+    slot->out =3D envelope_sin[slot->reg_wf](slot->pg_phase_out + *slot->mod=
, slot->eg_out);
+}
+
+static void OPL3_SlotCalcFB(opl3_slot *slot)
+{
+    if (slot->channel->fb !=3D 0x00)
+    {
+        slot->fbmod =3D (slot->prout + slot->out) >> (0x09 - slot->channel->=
fb);
+    }
+    else
+    {
+        slot->fbmod =3D 0;
+    }
+    slot->prout =3D slot->out;
+}
+
+/*
+    Channel
+*/
+
+static void OPL3_ChannelSetupAlg(opl3_channel *channel);
+
+static void OPL3_ChannelUpdateRhythm(opl3_chip *chip, uint8_t data)
+{
+    opl3_channel *channel6;
+    opl3_channel *channel7;
+    opl3_channel *channel8;
+    uint8_t chnum;
+
+    chip->rhy =3D data & 0x3f;
+    if (chip->rhy & 0x20)
+    {
+        channel6 =3D &chip->channel[6];
+        channel7 =3D &chip->channel[7];
+        channel8 =3D &chip->channel[8];
+        channel6->out[0] =3D &channel6->slotz[1]->out;
+        channel6->out[1] =3D &channel6->slotz[1]->out;
+        channel6->out[2] =3D &chip->zeromod;
+        channel6->out[3] =3D &chip->zeromod;
+        channel7->out[0] =3D &channel7->slotz[0]->out;
+        channel7->out[1] =3D &channel7->slotz[0]->out;
+        channel7->out[2] =3D &channel7->slotz[1]->out;
+        channel7->out[3] =3D &channel7->slotz[1]->out;
+        channel8->out[0] =3D &channel8->slotz[0]->out;
+        channel8->out[1] =3D &channel8->slotz[0]->out;
+        channel8->out[2] =3D &channel8->slotz[1]->out;
+        channel8->out[3] =3D &channel8->slotz[1]->out;
+        for (chnum =3D 6; chnum < 9; chnum++)
+        {
+            chip->channel[chnum].chtype =3D ch_drum;
+        }
+        OPL3_ChannelSetupAlg(channel6);
+        OPL3_ChannelSetupAlg(channel7);
+        OPL3_ChannelSetupAlg(channel8);
+        /* hh */
+        if (chip->rhy & 0x01)
+        {
+            OPL3_EnvelopeKeyOn(channel7->slotz[0], egk_drum);
+        }
+        else
+        {
+            OPL3_EnvelopeKeyOff(channel7->slotz[0], egk_drum);
+        }
+        /* tc */
+        if (chip->rhy & 0x02)
+        {
+            OPL3_EnvelopeKeyOn(channel8->slotz[1], egk_drum);
+        }
+        else
+        {
+            OPL3_EnvelopeKeyOff(channel8->slotz[1], egk_drum);
+        }
+        /* tom */
+        if (chip->rhy & 0x04)
+        {
+            OPL3_EnvelopeKeyOn(channel8->slotz[0], egk_drum);
+        }
+        else
+        {
+            OPL3_EnvelopeKeyOff(channel8->slotz[0], egk_drum);
+        }
+        /* sd */
+        if (chip->rhy & 0x08)
+        {
+            OPL3_EnvelopeKeyOn(channel7->slotz[1], egk_drum);
+        }
+        else
+        {
+            OPL3_EnvelopeKeyOff(channel7->slotz[1], egk_drum);
+        }
+        /* bd */
+        if (chip->rhy & 0x10)
+        {
+            OPL3_EnvelopeKeyOn(channel6->slotz[0], egk_drum);
+            OPL3_EnvelopeKeyOn(channel6->slotz[1], egk_drum);
+        }
+        else
+        {
+            OPL3_EnvelopeKeyOff(channel6->slotz[0], egk_drum);
+            OPL3_EnvelopeKeyOff(channel6->slotz[1], egk_drum);
+        }
+    }
+    else
+    {
+        for (chnum =3D 6; chnum < 9; chnum++)
+        {
+            chip->channel[chnum].chtype =3D ch_2op;
+            OPL3_ChannelSetupAlg(&chip->channel[chnum]);
+            OPL3_EnvelopeKeyOff(chip->channel[chnum].slotz[0], egk_drum);
+            OPL3_EnvelopeKeyOff(chip->channel[chnum].slotz[1], egk_drum);
+        }
+    }
+}
+
+static void OPL3_ChannelWriteA0(opl3_channel *channel, uint8_t data)
+{
+    if (channel->chip->newm && channel->chtype =3D=3D ch_4op2)
+    {
+        return;
+    }
+    channel->f_num =3D (channel->f_num & 0x300) | data;
+    channel->ksv =3D (channel->block << 1)
+                 | ((channel->f_num >> (0x09 - channel->chip->nts)) & 0x01);
+    OPL3_EnvelopeUpdateKSL(channel->slotz[0]);
+    OPL3_EnvelopeUpdateKSL(channel->slotz[1]);
+    if (channel->chip->newm && channel->chtype =3D=3D ch_4op)
+    {
+        channel->pair->f_num =3D channel->f_num;
+        channel->pair->ksv =3D channel->ksv;
+        OPL3_EnvelopeUpdateKSL(channel->pair->slotz[0]);
+        OPL3_EnvelopeUpdateKSL(channel->pair->slotz[1]);
+    }
+}
+
+static void OPL3_ChannelWriteB0(opl3_channel *channel, uint8_t data)
+{
+    if (channel->chip->newm && channel->chtype =3D=3D ch_4op2)
+    {
+        return;
+    }
+    channel->f_num =3D (channel->f_num & 0xff) | ((data & 0x03) << 8);
+    channel->block =3D (data >> 2) & 0x07;
+    channel->ksv =3D (channel->block << 1)
+                 | ((channel->f_num >> (0x09 - channel->chip->nts)) & 0x01);
+    OPL3_EnvelopeUpdateKSL(channel->slotz[0]);
+    OPL3_EnvelopeUpdateKSL(channel->slotz[1]);
+    if (channel->chip->newm && channel->chtype =3D=3D ch_4op)
+    {
+        channel->pair->f_num =3D channel->f_num;
+        channel->pair->block =3D channel->block;
+        channel->pair->ksv =3D channel->ksv;
+        OPL3_EnvelopeUpdateKSL(channel->pair->slotz[0]);
+        OPL3_EnvelopeUpdateKSL(channel->pair->slotz[1]);
+    }
+}
+
+static void OPL3_ChannelSetupAlg(opl3_channel *channel)
+{
+    if (channel->chtype =3D=3D ch_drum)
+    {
+        if (channel->ch_num =3D=3D 7 || channel->ch_num =3D=3D 8)
+        {
+            channel->slotz[0]->mod =3D &channel->chip->zeromod;
+            channel->slotz[1]->mod =3D &channel->chip->zeromod;
+            return;
+        }
+        switch (channel->alg & 0x01)
+        {
+        case 0x00:
+            channel->slotz[0]->mod =3D &channel->slotz[0]->fbmod;
+            channel->slotz[1]->mod =3D &channel->slotz[0]->out;
+            break;
+        case 0x01:
+            channel->slotz[0]->mod =3D &channel->slotz[0]->fbmod;
+            channel->slotz[1]->mod =3D &channel->chip->zeromod;
+            break;
+        }
+        return;
+    }
+    if (channel->alg & 0x08)
+    {
+        return;
+    }
+    if (channel->alg & 0x04)
+    {
+        channel->pair->out[0] =3D &channel->chip->zeromod;
+        channel->pair->out[1] =3D &channel->chip->zeromod;
+        channel->pair->out[2] =3D &channel->chip->zeromod;
+        channel->pair->out[3] =3D &channel->chip->zeromod;
+        switch (channel->alg & 0x03)
+        {
+        case 0x00:
+            channel->pair->slotz[0]->mod =3D &channel->pair->slotz[0]->fbmod;
+            channel->pair->slotz[1]->mod =3D &channel->pair->slotz[0]->out;
+            channel->slotz[0]->mod =3D &channel->pair->slotz[1]->out;
+            channel->slotz[1]->mod =3D &channel->slotz[0]->out;
+            channel->out[0] =3D &channel->slotz[1]->out;
+            channel->out[1] =3D &channel->chip->zeromod;
+            channel->out[2] =3D &channel->chip->zeromod;
+            channel->out[3] =3D &channel->chip->zeromod;
+            break;
+        case 0x01:
+            channel->pair->slotz[0]->mod =3D &channel->pair->slotz[0]->fbmod;
+            channel->pair->slotz[1]->mod =3D &channel->pair->slotz[0]->out;
+            channel->slotz[0]->mod =3D &channel->chip->zeromod;
+            channel->slotz[1]->mod =3D &channel->slotz[0]->out;
+            channel->out[0] =3D &channel->pair->slotz[1]->out;
+            channel->out[1] =3D &channel->slotz[1]->out;
+            channel->out[2] =3D &channel->chip->zeromod;
+            channel->out[3] =3D &channel->chip->zeromod;
+            break;
+        case 0x02:
+            channel->pair->slotz[0]->mod =3D &channel->pair->slotz[0]->fbmod;
+            channel->pair->slotz[1]->mod =3D &channel->chip->zeromod;
+            channel->slotz[0]->mod =3D &channel->pair->slotz[1]->out;
+            channel->slotz[1]->mod =3D &channel->slotz[0]->out;
+            channel->out[0] =3D &channel->pair->slotz[0]->out;
+            channel->out[1] =3D &channel->slotz[1]->out;
+            channel->out[2] =3D &channel->chip->zeromod;
+            channel->out[3] =3D &channel->chip->zeromod;
+            break;
+        case 0x03:
+            channel->pair->slotz[0]->mod =3D &channel->pair->slotz[0]->fbmod;
+            channel->pair->slotz[1]->mod =3D &channel->chip->zeromod;
+            channel->slotz[0]->mod =3D &channel->pair->slotz[1]->out;
+            channel->slotz[1]->mod =3D &channel->chip->zeromod;
+            channel->out[0] =3D &channel->pair->slotz[0]->out;
+            channel->out[1] =3D &channel->slotz[0]->out;
+            channel->out[2] =3D &channel->slotz[1]->out;
+            channel->out[3] =3D &channel->chip->zeromod;
+            break;
+        }
+    }
+    else
+    {
+        switch (channel->alg & 0x01)
+        {
+        case 0x00:
+            channel->slotz[0]->mod =3D &channel->slotz[0]->fbmod;
+            channel->slotz[1]->mod =3D &channel->slotz[0]->out;
+            channel->out[0] =3D &channel->slotz[1]->out;
+            channel->out[1] =3D &channel->chip->zeromod;
+            channel->out[2] =3D &channel->chip->zeromod;
+            channel->out[3] =3D &channel->chip->zeromod;
+            break;
+        case 0x01:
+            channel->slotz[0]->mod =3D &channel->slotz[0]->fbmod;
+            channel->slotz[1]->mod =3D &channel->chip->zeromod;
+            channel->out[0] =3D &channel->slotz[0]->out;
+            channel->out[1] =3D &channel->slotz[1]->out;
+            channel->out[2] =3D &channel->chip->zeromod;
+            channel->out[3] =3D &channel->chip->zeromod;
+            break;
+        }
+    }
+}
+
+static void OPL3_ChannelUpdateAlg(opl3_channel *channel)
+{
+    channel->alg =3D channel->con;
+    if (channel->chip->newm)
+    {
+        if (channel->chtype =3D=3D ch_4op)
+        {
+            channel->pair->alg =3D 0x04 | (channel->con << 1) | (channel->pa=
ir->con);
+            channel->alg =3D 0x08;
+            OPL3_ChannelSetupAlg(channel->pair);
+        }
+        else if (channel->chtype =3D=3D ch_4op2)
+        {
+            channel->alg =3D 0x04 | (channel->pair->con << 1) | (channel->co=
n);
+            channel->pair->alg =3D 0x08;
+            OPL3_ChannelSetupAlg(channel);
+        }
+        else
+        {
+            OPL3_ChannelSetupAlg(channel);
+        }
+    }
+    else
+    {
+        OPL3_ChannelSetupAlg(channel);
+    }
+}
+
+static void OPL3_ChannelWriteC0(opl3_channel *channel, uint8_t data)
+{
+    channel->fb =3D (data & 0x0e) >> 1;
+    channel->con =3D data & 0x01;
+    OPL3_ChannelUpdateAlg(channel);
+    if (channel->chip->newm)
+    {
+        channel->cha =3D ((data >> 4) & 0x01) ? ~0 : 0;
+        channel->chb =3D ((data >> 5) & 0x01) ? ~0 : 0;
+        channel->chc =3D ((data >> 6) & 0x01) ? ~0 : 0;
+        channel->chd =3D ((data >> 7) & 0x01) ? ~0 : 0;
+    }
+    else
+    {
+        channel->cha =3D channel->chb =3D (uint16_t)~0;
+        // TODO: Verify on real chip if DAC2 output is disabled in compat mo=
de
+        channel->chc =3D channel->chd =3D 0;
+    }
+#if OPL_ENABLE_STEREOEXT
+    if (!channel->chip->stereoext)
+    {
+        channel->leftpan =3D channel->cha << 16;
+        channel->rightpan =3D channel->chb << 16;
+    }
+#endif
+}
+
+#if OPL_ENABLE_STEREOEXT
+static void OPL3_ChannelWriteD0(opl3_channel* channel, uint8_t data)
+{
+    if (channel->chip->stereoext)
+    {
+        channel->leftpan =3D panpot_lut[data ^ 0xffu];
+        channel->rightpan =3D panpot_lut[data];
+    }
+}
+#endif
+
+static void OPL3_ChannelKeyOn(opl3_channel *channel)
+{
+    if (channel->chip->newm)
+    {
+        if (channel->chtype =3D=3D ch_4op)
+        {
+            OPL3_EnvelopeKeyOn(channel->slotz[0], egk_norm);
+            OPL3_EnvelopeKeyOn(channel->slotz[1], egk_norm);
+            OPL3_EnvelopeKeyOn(channel->pair->slotz[0], egk_norm);
+            OPL3_EnvelopeKeyOn(channel->pair->slotz[1], egk_norm);
+        }
+        else if (channel->chtype =3D=3D ch_2op || channel->chtype =3D=3D ch_=
drum)
+        {
+            OPL3_EnvelopeKeyOn(channel->slotz[0], egk_norm);
+            OPL3_EnvelopeKeyOn(channel->slotz[1], egk_norm);
+        }
+    }
+    else
+    {
+        OPL3_EnvelopeKeyOn(channel->slotz[0], egk_norm);
+        OPL3_EnvelopeKeyOn(channel->slotz[1], egk_norm);
+    }
+}
+
+static void OPL3_ChannelKeyOff(opl3_channel *channel)
+{
+    if (channel->chip->newm)
+    {
+        if (channel->chtype =3D=3D ch_4op)
+        {
+            OPL3_EnvelopeKeyOff(channel->slotz[0], egk_norm);
+            OPL3_EnvelopeKeyOff(channel->slotz[1], egk_norm);
+            OPL3_EnvelopeKeyOff(channel->pair->slotz[0], egk_norm);
+            OPL3_EnvelopeKeyOff(channel->pair->slotz[1], egk_norm);
+        }
+        else if (channel->chtype =3D=3D ch_2op || channel->chtype =3D=3D ch_=
drum)
+        {
+            OPL3_EnvelopeKeyOff(channel->slotz[0], egk_norm);
+            OPL3_EnvelopeKeyOff(channel->slotz[1], egk_norm);
+        }
+    }
+    else
+    {
+        OPL3_EnvelopeKeyOff(channel->slotz[0], egk_norm);
+        OPL3_EnvelopeKeyOff(channel->slotz[1], egk_norm);
+    }
+}
+
+static void OPL3_ChannelSet4Op(opl3_chip *chip, uint8_t data)
+{
+    uint8_t bit;
+    uint8_t chnum;
+    for (bit =3D 0; bit < 6; bit++)
+    {
+        chnum =3D bit;
+        if (bit >=3D 3)
+        {
+            chnum +=3D 9 - 3;
+        }
+        if ((data >> bit) & 0x01)
+        {
+            chip->channel[chnum].chtype =3D ch_4op;
+            chip->channel[chnum + 3u].chtype =3D ch_4op2;
+            OPL3_ChannelUpdateAlg(&chip->channel[chnum]);
+        }
+        else
+        {
+            chip->channel[chnum].chtype =3D ch_2op;
+            chip->channel[chnum + 3u].chtype =3D ch_2op;
+            OPL3_ChannelUpdateAlg(&chip->channel[chnum]);
+            OPL3_ChannelUpdateAlg(&chip->channel[chnum + 3u]);
+        }
+    }
+}
+
+static int16_t OPL3_ClipSample(int32_t sample)
+{
+    if (sample > 32767)
+    {
+        sample =3D 32767;
+    }
+    else if (sample < -32768)
+    {
+        sample =3D -32768;
+    }
+    return (int16_t)sample;
+}
+
+static void OPL3_ProcessSlot(opl3_slot *slot)
+{
+    OPL3_SlotCalcFB(slot);
+    OPL3_EnvelopeCalc(slot);
+    OPL3_PhaseGenerate(slot);
+    OPL3_SlotGenerate(slot);
+}
+
+inline void OPL3_Generate4Ch(opl3_chip *chip, int16_t *buf4)
+{
+    opl3_channel *channel;
+    opl3_writebuf *writebuf;
+    int16_t **out;
+    int32_t mix[2];
+    uint8_t ii;
+    int16_t accm;
+    uint8_t shift =3D 0;
+
+    buf4[1] =3D OPL3_ClipSample(chip->mixbuff[1]);
+    buf4[3] =3D OPL3_ClipSample(chip->mixbuff[3]);
+
+#if OPL_QUIRK_CHANNELSAMPLEDELAY
+    for (ii =3D 0; ii < 15; ii++)
+#else
+    for (ii =3D 0; ii < 36; ii++)
+#endif
+    {
+        OPL3_ProcessSlot(&chip->slot[ii]);
+    }
+
+    mix[0] =3D mix[1] =3D 0;
+    for (ii =3D 0; ii < 18; ii++)
+    {
+        channel =3D &chip->channel[ii];
+        out =3D channel->out;
+        accm =3D *out[0] + *out[1] + *out[2] + *out[3];
+#if OPL_ENABLE_STEREOEXT
+        mix[0] +=3D (int16_t)((accm * channel->leftpan) >> 16);
+#else
+        mix[0] +=3D (int16_t)(accm & channel->cha);
+#endif
+        mix[1] +=3D (int16_t)(accm & channel->chc);
+    }
+    chip->mixbuff[0] =3D mix[0];
+    chip->mixbuff[2] =3D mix[1];
+
+#if OPL_QUIRK_CHANNELSAMPLEDELAY
+    for (ii =3D 15; ii < 18; ii++)
+    {
+        OPL3_ProcessSlot(&chip->slot[ii]);
+    }
+#endif
+
+    buf4[0] =3D OPL3_ClipSample(chip->mixbuff[0]);
+    buf4[2] =3D OPL3_ClipSample(chip->mixbuff[2]);
+
+#if OPL_QUIRK_CHANNELSAMPLEDELAY
+    for (ii =3D 18; ii < 33; ii++)
+    {
+        OPL3_ProcessSlot(&chip->slot[ii]);
+    }
+#endif
+
+    mix[0] =3D mix[1] =3D 0;
+    for (ii =3D 0; ii < 18; ii++)
+    {
+        channel =3D &chip->channel[ii];
+        out =3D channel->out;
+        accm =3D *out[0] + *out[1] + *out[2] + *out[3];
+#if OPL_ENABLE_STEREOEXT
+        mix[0] +=3D (int16_t)((accm * channel->rightpan) >> 16);
+#else
+        mix[0] +=3D (int16_t)(accm & channel->chb);
+ #endif
+        mix[1] +=3D (int16_t)(accm & channel->chd);
+    }
+    chip->mixbuff[1] =3D mix[0];
+    chip->mixbuff[3] =3D mix[1];
+
+#if OPL_QUIRK_CHANNELSAMPLEDELAY
+    for (ii =3D 33; ii < 36; ii++)
+    {
+        OPL3_ProcessSlot(&chip->slot[ii]);
+    }
+#endif
+
+    if ((chip->timer & 0x3f) =3D=3D 0x3f)
+    {
+        chip->tremolopos =3D (chip->tremolopos + 1) % 210;
+    }
+    if (chip->tremolopos < 105)
+    {
+        chip->tremolo =3D chip->tremolopos >> chip->tremoloshift;
+    }
+    else
+    {
+        chip->tremolo =3D (210 - chip->tremolopos) >> chip->tremoloshift;
+    }
+
+    if ((chip->timer & 0x3ff) =3D=3D 0x3ff)
+    {
+        chip->vibpos =3D (chip->vibpos + 1) & 7;
+    }
+
+    chip->timer++;
+
+    if (chip->eg_state)
+    {
+        while (shift < 13 && ((chip->eg_timer >> shift) & 1) =3D=3D 0)
+        {
+            shift++;
+        }
+        if (shift > 12)
+        {
+            chip->eg_add =3D 0;
+        }
+        else
+        {
+            chip->eg_add =3D shift + 1;
+        }
+        chip->eg_timer_lo =3D (uint8_t)(chip->eg_timer & 0x3u);
+    }
+
+    if (chip->eg_timerrem || chip->eg_state)
+    {
+        if (chip->eg_timer =3D=3D UINT64_C(0xfffffffff))
+        {
+            chip->eg_timer =3D 0;
+            chip->eg_timerrem =3D 1;
+        }
+        else
+        {
+            chip->eg_timer++;
+            chip->eg_timerrem =3D 0;
+        }
+    }
+
+    chip->eg_state ^=3D 1;
+
+    while ((writebuf =3D &chip->writebuf[chip->writebuf_cur]), writebuf->tim=
e <=3D chip->writebuf_samplecnt)
+    {
+        if (!(writebuf->reg & 0x200))
+        {
+            break;
+        }
+        writebuf->reg &=3D 0x1ff;
+        OPL3_WriteReg(chip, writebuf->reg, writebuf->data);
+        chip->writebuf_cur =3D (chip->writebuf_cur + 1) % OPL_WRITEBUF_SIZE;
+    }
+    chip->writebuf_samplecnt++;
+}
+
+void OPL3_Generate(opl3_chip *chip, int16_t *buf)
+{
+    int16_t samples[4];
+    OPL3_Generate4Ch(chip, samples);
+    buf[0] =3D samples[0];
+    buf[1] =3D samples[1];
+}
+
+void OPL3_Generate4ChResampled(opl3_chip *chip, int16_t *buf4)
+{
+    while (chip->samplecnt >=3D chip->rateratio)
+    {
+        chip->oldsamples[0] =3D chip->samples[0];
+        chip->oldsamples[1] =3D chip->samples[1];
+        chip->oldsamples[2] =3D chip->samples[2];
+        chip->oldsamples[3] =3D chip->samples[3];
+        OPL3_Generate4Ch(chip, chip->samples);
+        chip->samplecnt -=3D chip->rateratio;
+    }
+    buf4[0] =3D (int16_t)((chip->oldsamples[0] * (chip->rateratio - chip->sa=
mplecnt)
+                        + chip->samples[0] * chip->samplecnt) / chip->ratera=
tio);
+    buf4[1] =3D (int16_t)((chip->oldsamples[1] * (chip->rateratio - chip->sa=
mplecnt)
+                        + chip->samples[1] * chip->samplecnt) / chip->ratera=
tio);
+    buf4[2] =3D (int16_t)((chip->oldsamples[2] * (chip->rateratio - chip->sa=
mplecnt)
+                        + chip->samples[2] * chip->samplecnt) / chip->ratera=
tio);
+    buf4[3] =3D (int16_t)((chip->oldsamples[3] * (chip->rateratio - chip->sa=
mplecnt)
+                        + chip->samples[3] * chip->samplecnt) / chip->ratera=
tio);
+    chip->samplecnt +=3D 1 << RSM_FRAC;
+}
+
+void OPL3_GenerateResampled(opl3_chip *chip, int16_t *buf)
+{
+    int16_t samples[4];
+    OPL3_Generate4ChResampled(chip, samples);
+    buf[0] =3D samples[0];
+    buf[1] =3D samples[1];
+}
+
+void OPL3_Reset(opl3_chip *chip, uint32_t samplerate)
+{
+    opl3_slot *slot;
+    opl3_channel *channel;
+    uint8_t slotnum;
+    uint8_t channum;
+    uint8_t local_ch_slot;
+
+    memset(chip, 0, sizeof(opl3_chip));
+    for (slotnum =3D 0; slotnum < 36; slotnum++)
+    {
+        slot =3D &chip->slot[slotnum];
+        slot->chip =3D chip;
+        slot->mod =3D &chip->zeromod;
+        slot->eg_rout =3D 0x1ff;
+        slot->eg_out =3D 0x1ff;
+        slot->eg_gen =3D envelope_gen_num_release;
+        slot->trem =3D (uint8_t*)&chip->zeromod;
+        slot->slot_num =3D slotnum;
+    }
+    for (channum =3D 0; channum < 18; channum++)
+    {
+        channel =3D &chip->channel[channum];
+        local_ch_slot =3D ch_slot[channum];
+        channel->slotz[0] =3D &chip->slot[local_ch_slot];
+        channel->slotz[1] =3D &chip->slot[local_ch_slot + 3u];
+        chip->slot[local_ch_slot].channel =3D channel;
+        chip->slot[local_ch_slot + 3u].channel =3D channel;
+        if ((channum % 9) < 3)
+        {
+            channel->pair =3D &chip->channel[channum + 3u];
+        }
+        else if ((channum % 9) < 6)
+        {
+            channel->pair =3D &chip->channel[channum - 3u];
+        }
+        channel->chip =3D chip;
+        channel->out[0] =3D &chip->zeromod;
+        channel->out[1] =3D &chip->zeromod;
+        channel->out[2] =3D &chip->zeromod;
+        channel->out[3] =3D &chip->zeromod;
+        channel->chtype =3D ch_2op;
+        channel->cha =3D 0xffff;
+        channel->chb =3D 0xffff;
+#if OPL_ENABLE_STEREOEXT
+        channel->leftpan =3D 0x10000;
+        channel->rightpan =3D 0x10000;
+#endif
+        channel->ch_num =3D channum;
+        OPL3_ChannelSetupAlg(channel);
+    }
+    chip->noise =3D 1;
+    chip->rateratio =3D (samplerate << RSM_FRAC) / 49716;
+    chip->tremoloshift =3D 4;
+    chip->vibshift =3D 1;
+
+#if OPL_ENABLE_STEREOEXT
+    if (!panpot_lut_build)
+    {
+        int32_t i;
+        for (i =3D 0; i < 256; i++)
+        {
+            panpot_lut[i] =3D OPL_SIN(i);
+        }
+        panpot_lut_build =3D 1;
+    }
+#endif
+}
+
+void OPL3_WriteReg(opl3_chip *chip, uint16_t reg, uint8_t v)
+{
+    uint8_t high =3D (reg >> 8) & 0x01;
+    uint8_t regm =3D reg & 0xff;
+    switch (regm & 0xf0)
+    {
+    case 0x00:
+        if (high)
+        {
+            switch (regm & 0x0f)
+            {
+            case 0x04:
+                OPL3_ChannelSet4Op(chip, v);
+                break;
+            case 0x05:
+                chip->newm =3D v & 0x01;
+#if OPL_ENABLE_STEREOEXT
+                chip->stereoext =3D (v >> 1) & 0x01;
+#endif
+                break;
+            }
+        }
+        else
+        {
+            switch (regm & 0x0f)
+            {
+            case 0x08:
+                chip->nts =3D (v >> 6) & 0x01;
+                break;
+            }
+        }
+        break;
+    case 0x20:
+    case 0x30:
+        if (ad_slot[regm & 0x1fu] >=3D 0)
+        {
+            OPL3_SlotWrite20(&chip->slot[18u * high + ad_slot[regm & 0x1fu]]=
, v);
+        }
+        break;
+    case 0x40:
+    case 0x50:
+        if (ad_slot[regm & 0x1fu] >=3D 0)
+        {
+            OPL3_SlotWrite40(&chip->slot[18u * high + ad_slot[regm & 0x1fu]]=
, v);
+        }
+        break;
+    case 0x60:
+    case 0x70:
+        if (ad_slot[regm & 0x1fu] >=3D 0)
+        {
+            OPL3_SlotWrite60(&chip->slot[18u * high + ad_slot[regm & 0x1fu]]=
, v);
+        }
+        break;
+    case 0x80:
+    case 0x90:
+        if (ad_slot[regm & 0x1fu] >=3D 0)
+        {
+            OPL3_SlotWrite80(&chip->slot[18u * high + ad_slot[regm & 0x1fu]]=
, v);
+        }
+        break;
+    case 0xe0:
+    case 0xf0:
+        if (ad_slot[regm & 0x1fu] >=3D 0)
+        {
+            OPL3_SlotWriteE0(&chip->slot[18u * high + ad_slot[regm & 0x1fu]]=
, v);
+        }
+        break;
+    case 0xa0:
+        if ((regm & 0x0f) < 9)
+        {
+            OPL3_ChannelWriteA0(&chip->channel[9u * high + (regm & 0x0fu)], =
v);
+        }
+        break;
+    case 0xb0:
+        if (regm =3D=3D 0xbd && !high)
+        {
+            chip->tremoloshift =3D (((v >> 7) ^ 1) << 1) + 2;
+            chip->vibshift =3D ((v >> 6) & 0x01) ^ 1;
+            OPL3_ChannelUpdateRhythm(chip, v);
+        }
+        else if ((regm & 0x0f) < 9)
+        {
+            OPL3_ChannelWriteB0(&chip->channel[9u * high + (regm & 0x0fu)], =
v);
+            if (v & 0x20)
+            {
+                OPL3_ChannelKeyOn(&chip->channel[9u * high + (regm & 0x0fu)]=
);
+            }
+            else
+            {
+                OPL3_ChannelKeyOff(&chip->channel[9u * high + (regm & 0x0fu)=
]);
+            }
+        }
+        break;
+    case 0xc0:
+        if ((regm & 0x0f) < 9)
+        {
+            OPL3_ChannelWriteC0(&chip->channel[9u * high + (regm & 0x0fu)], =
v);
+        }
+        break;
+#if OPL_ENABLE_STEREOEXT
+    case 0xd0:
+        if ((regm & 0x0f) < 9)
+        {
+            OPL3_ChannelWriteD0(&chip->channel[9u * high + (regm & 0x0fu)], =
v);
+        }
+        break;
+#endif
+    }
+}
+
+void OPL3_WriteRegBuffered(opl3_chip *chip, uint16_t reg, uint8_t v)
+{
+    uint64_t time1, time2;
+    opl3_writebuf *writebuf;
+    uint32_t writebuf_last;
+
+    writebuf_last =3D chip->writebuf_last;
+    writebuf =3D &chip->writebuf[writebuf_last];
+
+    if (writebuf->reg & 0x200)
+    {
+        OPL3_WriteReg(chip, writebuf->reg & 0x1ff, writebuf->data);
+
+        chip->writebuf_cur =3D (writebuf_last + 1) % OPL_WRITEBUF_SIZE;
+        chip->writebuf_samplecnt =3D writebuf->time;
+    }
+
+    writebuf->reg =3D reg | 0x200;
+    writebuf->data =3D v;
+    time1 =3D chip->writebuf_lasttime + OPL_WRITEBUF_DELAY;
+    time2 =3D chip->writebuf_samplecnt;
+
+    if (time1 < time2)
+    {
+        time1 =3D time2;
+    }
+
+    writebuf->time =3D time1;
+    chip->writebuf_lasttime =3D time1;
+    chip->writebuf_last =3D (writebuf_last + 1) % OPL_WRITEBUF_SIZE;
+}
+
+void OPL3_Generate4ChStream(opl3_chip *chip, int16_t *sndptr1, int16_t *sndp=
tr2, uint32_t numsamples)
+{
+    uint_fast32_t i;
+    int16_t samples[4];
+
+    for(i =3D 0; i < numsamples; i++)
+    {
+        OPL3_Generate4ChResampled(chip, samples);
+        sndptr1[0] =3D samples[0];
+        sndptr1[1] =3D samples[1];
+        sndptr2[0] =3D samples[2];
+        sndptr2[1] =3D samples[3];
+        sndptr1 +=3D 2;
+        sndptr2 +=3D 2;
+    }
+}
+
+void OPL3_GenerateStream(opl3_chip *chip, int16_t *sndptr, uint32_t numsampl=
es)
+{
+    uint_fast32_t i;
+
+    for(i =3D 0; i < numsamples; i++)
+    {
+        OPL3_GenerateResampled(chip, sndptr);
+        sndptr +=3D 2;
+    }
+}
diff --git a/hw/audio/nuked_opl3.h b/hw/audio/nuked_opl3.h
new file mode 100644
index 0000000000..03126921c8
--- /dev/null
+++ b/hw/audio/nuked_opl3.h
@@ -0,0 +1,173 @@
+/* Nuked OPL3
+ * Copyright (C) 2013-2020 Nuke.YKT
+ *
+ * This file is part of Nuked OPL3.
+ *
+ * Nuked OPL3 is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU Lesser General Public License as
+ * published by the Free Software Foundation, either version 2.1
+ * of the License, or (at your option) any later version.
+ *
+ * Nuked OPL3 is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with Nuked OPL3. If not, see <https://www.gnu.org/licenses/>.
+
+ *  Nuked OPL3 emulator.
+ *  Thanks:
+ *      MAME Development Team(Jarek Burczynski, Tatsuyuki Satoh):
+ *          Feedback and Rhythm part calculation information.
+ *      forums.submarine.org.uk(carbon14, opl3):
+ *          Tremolo and phase generator calculation information.
+ *      OPLx decapsulated(Matthew Gambrell, Olli Niemitalo):
+ *          OPL2 ROMs.
+ *      siliconpr0n.org(John McMaster, digshadow):
+ *          YMF262 and VRC VII decaps and die shots.
+ *
+ * version: 1.8
+ */
+
+#ifndef OPL_OPL3_H
+#define OPL_OPL3_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <inttypes.h>
+
+#ifndef OPL_ENABLE_STEREOEXT
+#define OPL_ENABLE_STEREOEXT 0
+#endif
+
+#define OPL_WRITEBUF_SIZE   1024
+#define OPL_WRITEBUF_DELAY  2
+
+typedef struct _opl3_slot opl3_slot;
+typedef struct _opl3_channel opl3_channel;
+typedef struct _opl3_chip opl3_chip;
+
+struct _opl3_slot {
+    opl3_channel *channel;
+    opl3_chip *chip;
+    int16_t out;
+    int16_t fbmod;
+    int16_t *mod;
+    int16_t prout;
+    uint16_t eg_rout;
+    uint16_t eg_out;
+    uint8_t eg_inc;
+    uint8_t eg_gen;
+    uint8_t eg_rate;
+    uint8_t eg_ksl;
+    uint8_t *trem;
+    uint8_t reg_vib;
+    uint8_t reg_type;
+    uint8_t reg_ksr;
+    uint8_t reg_mult;
+    uint8_t reg_ksl;
+    uint8_t reg_tl;
+    uint8_t reg_ar;
+    uint8_t reg_dr;
+    uint8_t reg_sl;
+    uint8_t reg_rr;
+    uint8_t reg_wf;
+    uint8_t key;
+    uint32_t pg_reset;
+    uint32_t pg_phase;
+    uint16_t pg_phase_out;
+    uint8_t slot_num;
+};
+
+struct _opl3_channel {
+    opl3_slot *slotz[2];/*Don't use "slots" keyword to avoid conflict with Q=
t applications*/
+    opl3_channel *pair;
+    opl3_chip *chip;
+    int16_t *out[4];
+
+#if OPL_ENABLE_STEREOEXT
+    int32_t leftpan;
+    int32_t rightpan;
+#endif
+
+    uint8_t chtype;
+    uint16_t f_num;
+    uint8_t block;
+    uint8_t fb;
+    uint8_t con;
+    uint8_t alg;
+    uint8_t ksv;
+    uint16_t cha, chb;
+    uint16_t chc, chd;
+    uint8_t ch_num;
+};
+
+typedef struct _opl3_writebuf {
+    uint64_t time;
+    uint16_t reg;
+    uint8_t data;
+} opl3_writebuf;
+
+struct _opl3_chip {
+    opl3_channel channel[18];
+    opl3_slot slot[36];
+    uint16_t timer;
+    uint64_t eg_timer;
+    uint8_t eg_timerrem;
+    uint8_t eg_state;
+    uint8_t eg_add;
+    uint8_t eg_timer_lo;
+    uint8_t newm;
+    uint8_t nts;
+    uint8_t rhy;
+    uint8_t vibpos;
+    uint8_t vibshift;
+    uint8_t tremolo;
+    uint8_t tremolopos;
+    uint8_t tremoloshift;
+    uint32_t noise;
+    int16_t zeromod;
+    int32_t mixbuff[4];
+    uint8_t rm_hh_bit2;
+    uint8_t rm_hh_bit3;
+    uint8_t rm_hh_bit7;
+    uint8_t rm_hh_bit8;
+    uint8_t rm_tc_bit3;
+    uint8_t rm_tc_bit5;
+
+#if OPL_ENABLE_STEREOEXT
+    uint8_t stereoext;
+#endif
+
+    /* OPL3L */
+    int32_t rateratio;
+    int32_t samplecnt;
+    int16_t oldsamples[4];
+    int16_t samples[4];
+
+    uint64_t writebuf_samplecnt;
+    uint32_t writebuf_cur;
+    uint32_t writebuf_last;
+    uint64_t writebuf_lasttime;
+    opl3_writebuf writebuf[OPL_WRITEBUF_SIZE];
+};
+
+void OPL3_Generate(opl3_chip *chip, int16_t *buf);
+void OPL3_GenerateResampled(opl3_chip *chip, int16_t *buf);
+void OPL3_Reset(opl3_chip *chip, uint32_t samplerate);
+void OPL3_WriteReg(opl3_chip *chip, uint16_t reg, uint8_t v);
+void OPL3_WriteRegBuffered(opl3_chip *chip, uint16_t reg, uint8_t v);
+void OPL3_GenerateStream(opl3_chip *chip, int16_t *sndptr, uint32_t numsampl=
es);
+
+void OPL3_Generate4Ch(opl3_chip *chip, int16_t *buf4);
+void OPL3_Generate4ChResampled(opl3_chip *chip, int16_t *buf4);
+void OPL3_Generate4ChStream(opl3_chip *chip, int16_t *sndptr1, int16_t *sndp=
tr2, uint32_t numsamples);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tests/unit/test-nuked-opl3.c b/tests/unit/test-nuked-opl3.c
new file mode 100644
index 0000000000..123c41e838
--- /dev/null
+++ b/tests/unit/test-nuked-opl3.c
@@ -0,0 +1,109 @@
+/*
+ * Tests for vendored Nuked-OPL3.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "hw/audio/nuked_opl3.h"
+
+#define OPL_FREQ 49716
+
+static const struct {
+    uint16_t reg;
+    uint8_t val;
+} sequence[] =3D {
+    /* Modulator slot 0 */
+    { 0x20, 0x01 }, { 0x40, 0x10 }, { 0x60, 0xF0 }, { 0x80, 0x77 },
+    /* Carrier slot 3 */
+    { 0x23, 0x01 }, { 0x43, 0x00 }, { 0x63, 0xF0 }, { 0x83, 0x77 },
+    /* Carrier waveform 7: OPL3-only; OPL2 masks to waveform 3 */
+    { 0xE3, 0x07 },
+    /* Frequency + key on */
+    { 0xA0, 0x40 }, { 0xB0, 0x32 },
+};
+
+
+static void test_basic_tone_nonzero(void)
+{
+    int16_t buffer[8192];
+    opl3_chip chip;
+    unsigned peak =3D 0;
+
+    OPL3_Reset(&chip, OPL_FREQ);
+    OPL3_WriteRegBuffered(&chip, 0x105, 0x01);
+
+    for (unsigned i =3D 0; i < ARRAY_SIZE(sequence); i++) {
+        OPL3_WriteRegBuffered(&chip, sequence[i].reg, sequence[i].val);
+    }
+    OPL3_GenerateStream(&chip, buffer, 4096);
+
+    for (unsigned i =3D 0; i < 8192; i++) {
+        peak =3D MAX(peak, (unsigned)abs(buffer[i]));
+    }
+
+    if (g_test_verbose()) {
+        g_test_message("test_basic_tone_nonzero peak=3D%u", peak);
+    }
+
+    g_assert_cmpuint(peak, >, 1000);
+}
+
+static void test_opl2_opl3_distinct(void)
+{
+    int16_t buffer_opl2[8192];
+    int16_t buffer_opl3[8192];
+    opl3_chip chip_opl2;
+    opl3_chip chip_opl3;
+
+    OPL3_Reset(&chip_opl2, OPL_FREQ);
+    OPL3_Reset(&chip_opl3, OPL_FREQ);
+    OPL3_WriteRegBuffered(&chip_opl3, 0x105, 0x01);
+
+    for (unsigned i =3D 0; i < ARRAY_SIZE(sequence); i++) {
+        OPL3_WriteRegBuffered(&chip_opl2, sequence[i].reg, sequence[i].val);
+        OPL3_WriteRegBuffered(&chip_opl3, sequence[i].reg, sequence[i].val);
+    }
+    OPL3_GenerateStream(&chip_opl2, buffer_opl2, 4096);
+    OPL3_GenerateStream(&chip_opl3, buffer_opl3, 4096);
+
+    g_assert_cmpint(memcmp(buffer_opl2, buffer_opl3, sizeof(buffer_opl2)),
+                    !=3D, 0);
+}
+
+static void test_reset_silent(void)
+{
+    int16_t buffer[2048];
+    opl3_chip chip;
+
+    memset(buffer, 0xcc, sizeof(buffer));
+    OPL3_Reset(&chip, OPL_FREQ);
+    OPL3_GenerateStream(&chip, buffer, 1024);
+
+    for (unsigned i =3D 0; i < 2048; i++) {
+        g_assert_cmpint(buffer[i], =3D=3D, 0);
+    }
+}
+
+static void test_status_after_reset(void)
+{
+    opl3_chip chip;
+
+    memset(&chip, 0xcc, sizeof(chip));
+    OPL3_Reset(&chip, OPL_FREQ);
+    g_assert_cmpint(chip.timer, =3D=3D, 0);
+    g_assert_cmpint(chip.rhy, =3D=3D, 0);
+    g_assert_cmpint(chip.newm, =3D=3D, 0);
+    g_assert_cmpint(chip.channel[0].f_num, =3D=3D, 0);
+    g_assert_cmpint(chip.channel[0].block, =3D=3D, 0);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/nuked_opl3/basic_tone_nonzero", test_basic_tone_nonzer=
o);
+    g_test_add_func("/nuked_opl3/opl2_vs_opl3_distinct",
+                    test_opl2_vs_opl3_distinct);
+    g_test_add_func("/nuked_opl3/reset_silent", test_reset_silent);
+    g_test_add_func("/nuked_opl3/status_after_reset", test_status_after_rese=
t);
+    return g_test_run();
+}
--=20
2.49.1


