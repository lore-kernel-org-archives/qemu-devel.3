Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE12D12D69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnd3-00060o-Sr; Wed, 03 Dec 2025 09:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1vQgdX-0004pK-Hz
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:46:53 -0500
Received: from ci-2001l-snip4-8.eps.apple.com ([57.103.91.121]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1vQgdT-0000Yo-Ei
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:46:51 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPS id
 8F1AA1800128; Wed,  3 Dec 2025 06:46:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 bh=VOSBhgq7WLlF7/B14/u71wMzfDLQjPSE/11xaCuz7bE=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=Kd8x11pA9cAsFWWFerEoOuVBZ4//2Sxm9NJRNjlHaSTgSSzHwJYWoZj0lVN+791nTLr5NB1zpLLzUhFRo7TGNPag3VzwVENfqllA4eSeXd7DFOGRhCdtdRbYkE/hphFfEEPBEqUY8jTWcgDcok7T5QeKrpblmQl7c8WNj8XiKicHHrs+q5P0xDU6S1EPJnVQJtzaVGjKFtuhvmSXsYmXFgA0BWD2TNGQBfywEPBR4PPTAITrwLkL86v+0jE8O8pUqWXZO4+WABAInrIpgr1ih/93mT8joGfASag0oyQv5JtEFAnO6TGPxudKaOWHgfdDa0QfpL7A3HH3P4EOvCHOhg==
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPSA id
 4D06E1800122; Wed,  3 Dec 2025 06:46:43 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH 1/1] hw/m68k: add working floppy controller for q800
Date: Wed,  3 Dec 2025 01:43:36 -0500
Message-Id: <20251203064336.79847-2-mhjacobson@me.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251203064336.79847-1-mhjacobson@me.com>
References: <20251203064336.79847-1-mhjacobson@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ET5NRHkh-zqEx9ajIvZrc0KUTncHWMv2
X-Authority-Info: v=2.4 cv=YvUChoYX c=1 sm=1 tr=0 ts=692fdcd5 cx=c_apl:c_pps
 a=2G65uMN5HjSv0sBfM2Yj2w==:117 a=2G65uMN5HjSv0sBfM2Yj2w==:17
 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10 a=Z7GCepxVSdIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=1a8cTrDogMghikJSfXsA:9
X-Proofpoint-GUID: ET5NRHkh-zqEx9ajIvZrc0KUTncHWMv2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA1MiBTYWx0ZWRfXyNknitACs9n0
 60BZGsEmBlQZFvZOMRHeSHKrC6OSLj9maZz6BYZyKekXVxFWkdSWctIQq6++B5oLu/O2PJ1cmig
 53NA8EwlXyMwxSq9ywWd5gPDb7TbVOMZh58gnXZn36asMLVR6RNwUYzp1ltoIzHj94PXu8X9MlR
 zDWsiPrO9im59HQe2WanccuI8aA570riywq1v53JC7HR1hMAsuP5Vy//cZ88yYj4wL3B1BL736d
 9xW6rT2AN+Gq9hc8ByBLW+D9n4f1IpFioyFw+sguZd+6cTngez3SmI4IGCOMGovqUaZTW5RABdV
 2mIBjH5/lxkFbNt+WBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030052
X-JNJ: AAAAAAAB8OdkLcO68BDFGpWDsc3FLk+NYOjFqgco16g+vhPXd5gZp/tigsgPSsHZVuYx9LTwD9oV+fU2cXM6SQhEPaRaywUX4hUgMTnOukvcJwVMZbgSAmTr1/mSijQF0DvpVEU3WKFB4/eP2J4gR4rk6jvuFpLyIe+fktiRgw76cl0p5kgfT26ZhHmhb43DwIgt3XnErI+ZoziwaOR9HEtLIlWXUDct5+qkgbHDtSSmdDL0lGo0126Tq4C1mEZFXrjwd3NVsudiMtMdKelBYmUSVgHfPeiztsSPBkFB1DUAa1W6qV+ogJ/IKCeVMTBDmYs8DmBqjH4cno9ZeMCUgZLuLXm/KDFkw4pebXyXQjx8X9WhIpxnIfgcD/2sB1HMJoKRRXzOnnQFjwCoB6EtQanA5pMPmZod8vSFUh9SJFk/6CPqhjZFaM7bmtJQVkZapqukVcjMx0VeO7L2hSUulfaYgnvjR60GkPSXCgt/ACuYX10H9uS/sQgwIl4kfb8Mrk7I5ExjmC6bjS8FpAHNbBNR9ZKiHVg/eESorIPwB1/7ifMX34WdpFPeO38gag/Z9SVgEXsJcEdytiUMPIDdsSfgLOAZNUMvmbKUx5P/aNBE044XBN/Fuc1S7bygRezqXPxk+EbwQVUMllEHTj704eZ2M/HCIFQzngzCc2hX
Received-SPF: pass client-ip=57.103.91.121; envelope-from=mhjacobson@me.com;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Dec 2025 09:14:36 -0500
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

The Quadra 800 contains a SWIM2 floppy controller, which is a
simplified revision of the original SWIM controller.  Implement it
based on publicly available specs, and likewise implement the floppy
drives it connects to, supporting both GCR (400 kB and 800 kB) and MFM
(1440 kB) diskette images.

Signed-off-by: Matt Jacobson <mhjacobson@me.com>
---
 hw/block/meson.build               |   2 +-
 hw/block/sony_superdrive.c         | 940 +++++++++++++++++++++++++++++
 hw/block/swim2.c                   | 657 ++++++++++++++++++++
 hw/block/trace-events              |  17 +
 hw/m68k/q800.c                     |   4 +-
 include/hw/block/sony_superdrive.h |  55 ++
 include/hw/block/swim2.h           |  66 ++
 include/hw/m68k/q800.h             |   4 +-
 8 files changed, 1740 insertions(+), 5 deletions(-)
 create mode 100644 hw/block/sony_superdrive.c
 create mode 100644 hw/block/swim2.c
 create mode 100644 include/hw/block/sony_superdrive.h
 create mode 100644 include/hw/block/swim2.h

diff --git a/hw/block/meson.build b/hw/block/meson.build
index 43ed296cf4..7b6a9f60d0 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -10,7 +10,7 @@ system_ss.add(when: 'CONFIG_PFLASH_CFI01', if_true: files('pflash_cfi01.c'))
 system_ss.add(when: 'CONFIG_PFLASH_CFI02', if_true: files('pflash_cfi02.c'))
 system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
 system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80_sfdp.c'))
-system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c'))
+system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c', 'swim2.c', 'sony_superdrive.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
 
 specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
diff --git a/hw/block/sony_superdrive.c b/hw/block/sony_superdrive.c
new file mode 100644
index 0000000000..5c1608ca4f
--- /dev/null
+++ b/hw/block/sony_superdrive.c
@@ -0,0 +1,940 @@
+/*
+ * QEMU Macintosh SuperDrive floppy disk drive emulator
+ *
+ * Copyright (c) 2025 Matt Jacobson <mhjacobson@me.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <assert.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include "qemu/error-report.h"
+#include "hw/block/sony_superdrive.h"
+#include "system/block-backend.h"
+#include "system/block-backend-io.h"
+#include "system/blockdev.h"
+#include "trace.h"
+
+/* Sony drive register selects (CA2-CA1-CA0-SEL) */
+#define SONY_REG_DIRTN       0x0
+#define SONY_REG_CSTIN       0x1 /* a.k.a. dipAdr ("disk in place") */
+#define SONY_REG_STEP        0x2
+#define SONY_REG_WRTPRT      0x3
+#define SONY_REG_MOTORON     0x4
+#define SONY_REG_TKO         0x5
+#define SONY_REG_EJECT_L     0x6
+#define SONY_REG_TACH        0x7
+#define SONY_REG_RDDATA0     0x8
+#define SONY_REG_RDDATA1     0x9
+#define SONY_REG_SUPERDRIVE  0xa /* a.k.a. mfmDrvAdr */
+#define SONY_REG_GCR         0xb
+#define SONY_REG_SINGLE_SIDE 0xc
+#define SONY_REG_READY       0xd
+#define SONY_REG_INSTALLED   0xe /* a.k.a. DRVIN, a.k.a. drvExstAdr */
+#define SONY_REG_TWOMEG      0xf
+
+static const char *const sony_drive_reg_names[] = {
+    [SONY_REG_DIRTN] = "DIRTN",
+    [SONY_REG_CSTIN] = "CSTIN",
+    [SONY_REG_STEP] = "STEP",
+    [SONY_REG_WRTPRT] = "WRTPRT",
+    [SONY_REG_MOTORON] = "MOTOR_ON",
+    [SONY_REG_TKO] = "TKO",
+    [SONY_REG_EJECT_L] = "EJECT_L",
+    [SONY_REG_TACH] = "TACH",
+    [SONY_REG_RDDATA0] = "RDDATA0",
+    [SONY_REG_RDDATA1] = "RDDATA1",
+    [SONY_REG_SUPERDRIVE] = "SUPERDRIVE",
+    [SONY_REG_GCR] = "GCR",
+    [SONY_REG_SINGLE_SIDE] = "SINGLE_SIDE",
+    [SONY_REG_READY] = "READY",
+    [SONY_REG_INSTALLED] = "INSTALLED",
+    [SONY_REG_TWOMEG] = "TWOMEG",
+};
+
+/* Sony drive write commands (CA2-CA1-CA0-SEL) */
+#define SONY_CMD_TRACK_POS   0x0
+#define SONY_CMD_TRACK_NEG   0x8
+#define SONY_CMD_TRACK_STEP  0x2
+#define SONY_CMD_SET_MFM     0x3
+#define SONY_CMD_SET_GCR     0xb
+#define SONY_CMD_MOTOR_ON    0x4
+#define SONY_CMD_MOTOR_OFF   0xc
+#define SONY_CMD_EJECT       0xe
+
+static const char *const sony_drive_cmd_names[] = {
+    [SONY_CMD_TRACK_POS] = "TRACK_POS",
+    [SONY_CMD_TRACK_NEG] = "TRACK_NEG",
+    [SONY_CMD_TRACK_STEP] = "TRACK_STEP",
+    [SONY_CMD_SET_MFM] = "SET_MFM",
+    [SONY_CMD_SET_GCR] = "SET_GCR",
+    [SONY_CMD_MOTOR_ON] = "MOTOR_ON",
+    [SONY_CMD_MOTOR_OFF] = "MOTOR_OFF",
+    [SONY_CMD_EJECT] = "EJECT",
+};
+
+#define SONY_GCR_TAG_LENGTH      12
+#define SONY_GCR_DATA_LENGTH    512
+#define SONY_GCR_SECTOR_LENGTH  (SONY_GCR_TAG_LENGTH + SONY_GCR_DATA_LENGTH)
+#define SONY_GCR_ENCODED_LENGTH 699 /* i.e., sony_6and2_packed_len(524) */
+#define SONY_GCR_SYNC_LEN         6
+#define SONY_MFM_SECTOR_LENGTH  512
+
+static uint8_t sony_drive_sectors_for_track(const SonyDrive *const drive,
+                                            const uint8_t track)
+{
+    if (drive->sectors_per_track) {
+        return drive->sectors_per_track;
+    } else {
+        /*
+         * 400K/800K GCR media use zone recording with variable sectors per
+         * track; each zone spans 16 tracks.
+         */
+        static const uint8_t gcr_zone_spt[] = { 12, 11, 10, 9, 8 };
+        uint8_t zone = track / 16;
+
+        if (zone >= ARRAY_SIZE(gcr_zone_spt)) {
+            zone = ARRAY_SIZE(gcr_zone_spt) - 1;
+        }
+
+        return gcr_zone_spt[zone];
+    }
+}
+
+static void bitset_set(uint8_t *const bitset, const unsigned int index,
+                       const bool value) {
+    const uint8_t mask = (uint8_t)(1u << (index & 0x7));
+
+    if (value)
+        bitset[index >> 3] |= mask;
+    else
+        bitset[index >> 3] &= (uint8_t)~mask;
+}
+
+static void bitset_set_range(uint8_t *const bitset, const unsigned int index,
+                             const unsigned int length, const bool value) {
+    for (unsigned int i = index; i < index + length; i++) {
+        bitset_set(bitset, i, value);
+    }
+}
+
+static bool bitset_get(const uint8_t *const bitset, const unsigned int index) {
+    const uint8_t mask = (uint8_t)(1u << (index & 0x7));
+    return (bitset[index >> 3] & mask) != 0;
+}
+
+static const uint8_t sony_gcr_encode_table[] = {
+    0x96, 0x97, 0x9a, 0x9b, 0x9d, 0x9e, 0x9f, 0xa6,
+    0xa7, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb2, 0xb3,
+    0xb4, 0xb5, 0xb6, 0xb7, 0xb9, 0xba, 0xbb, 0xbc,
+    0xbd, 0xbe, 0xbf, 0xcb, 0xcd, 0xce, 0xcf, 0xd3,
+    0xd6, 0xd7, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde,
+    0xdf, 0xe5, 0xe6, 0xe7, 0xe9, 0xea, 0xeb, 0xec,
+    0xed, 0xee, 0xef, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6,
+    0xf7, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
+};
+
+/* 0xff is used as filler for bytes the decoder should never see. */
+static const uint8_t sony_gcr_decode_table[] = {
+    0x00, 0x01, 0xff, 0xff, 0x02, 0x03, 0xff, 0x04,
+    0x05, 0x06, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0x07, 0x08, 0xff, 0xff, 0xff, 0x09, 0x0a, 0x0b,
+    0x0c, 0x0d, 0xff, 0xff, 0x0e, 0x0f, 0x10, 0x11,
+    0x12, 0x13, 0xff, 0x14, 0x15, 0x16, 0x17, 0x18,
+    0x19, 0x1a, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0x1b, 0xff, 0x1c,
+    0x1d, 0x1e, 0xff, 0xff, 0xff, 0x1f, 0xff, 0xff,
+    0x20, 0x21, 0xff, 0x22, 0x23, 0x24, 0x25, 0x26,
+    0x27, 0x28, 0xff, 0xff, 0xff, 0xff, 0xff, 0x29,
+    0x2a, 0x2b, 0xff, 0x2c, 0x2d, 0x2e, 0x2f, 0x30,
+    0x31, 0x32, 0xff, 0xff, 0x33, 0x34, 0x35, 0x36,
+    0x37, 0x38, 0xff, 0x39, 0x3a, 0x3b, 0x3c, 0x3d,
+    0x3e, 0x3f,
+};
+
+static uint8_t sony_gcr_encode_byte(const uint8_t value)
+{
+    assert((value & 0xc0) == 0);
+    return sony_gcr_encode_table[value];
+}
+
+static uint8_t sony_gcr_decode_byte(const uint8_t value)
+{
+    assert(value & 0x80);
+    const uint8_t result = sony_gcr_decode_table[value - 0x96];
+    assert(result != 0xff);
+    return result;
+}
+
+static void sony_gcr_encode_bytes(const uint8_t *const in, uint8_t *const out,
+                                  const size_t len)
+{
+    for (size_t i = 0; i < len; i++) {
+        out[i] = sony_gcr_encode_byte(in[i]);
+    }
+}
+
+static void sony_gcr_decode_bytes(const uint8_t *const in, uint8_t *const out,
+                                  const size_t len)
+{
+    for (size_t i = 0; i < len; i++) {
+        out[i] = sony_gcr_decode_byte(in[i]);
+    }
+}
+
+static size_t sony_6and2_packed_len(const size_t in_size) {
+    const size_t groups = in_size / 3;
+    const size_t rem = in_size % 3;
+    return groups * 4 + (rem ? (rem + 1) : 0);
+}
+
+static void sony_6and2_pack(const uint8_t *in, const size_t in_size,
+                            uint8_t *restrict out, const size_t out_size)
+{
+    assert(sony_6and2_packed_len(in_size) == out_size);
+
+    for (size_t i = 0; i < in_size; i += 3) {
+        /* Allow partial groupings. */
+        const bool have_b = (i + 1) < in_size;
+        const bool have_c = (i + 2) < in_size;
+
+        const uint8_t a = *in++;
+        const uint8_t b = have_b ? *in++ : 0;
+        const uint8_t c = have_c ? *in++ : 0;
+
+        /* High two bits (A7:6, B7:6, C7:6), then low six bits. */
+        const uint8_t high  = (uint8_t)(((a & 0xC0u) >> 2) |
+                                        ((b & 0xC0u) >> 4) |
+                                        ((c & 0xC0u) >> 6));
+        const uint8_t low_a = (uint8_t)(a & 0x3Fu);
+        const uint8_t low_b = (uint8_t)(b & 0x3Fu);
+        const uint8_t low_c = (uint8_t)(c & 0x3Fu);
+
+        *out++ = high;
+        *out++ = low_a;
+        if (have_b) *out++ = low_b;
+        if (have_c) *out++ = low_c;
+    }
+}
+
+static void sony_6and2_unpack(const uint8_t *in, const size_t in_size,
+                              uint8_t *restrict out, const size_t out_size)
+{
+    assert(sony_6and2_packed_len(out_size) == in_size);
+
+    for (size_t i = 0; i < in_size; i += 4) {
+        /* Allow partial groupings. */
+        const bool have_b = (i + 2) < in_size;
+        const bool have_c = (i + 3) < in_size;
+
+        /* High two bits (A7:6, B7:6, C7:6), then low six bits. */
+        const uint8_t high = *in++;
+        const uint8_t low_a = *in++;
+        const uint8_t low_b = have_b ? *in++ : 0;
+        const uint8_t low_c = have_c ? *in++ : 0;
+
+        const uint8_t a = (uint8_t)((high << 2) & 0xC0u) | low_a;
+        const uint8_t b = (uint8_t)((high << 4) & 0xC0u) | low_b;
+        const uint8_t c = (uint8_t)((high << 6) & 0xC0u) | low_c;
+
+        *out++ = a;
+        if (have_b) *out++ = b;
+        if (have_c) *out++ = c;
+    }
+}
+
+static void sony_checksum_encode(const uint8_t *in, const size_t in_size,
+                                 uint8_t *out, const size_t out_size,
+                                 uint8_t *sum_out)
+{
+    assert(in_size == out_size);
+
+    uint16_t sum_a = 0, sum_b = 0, sum_c = 0;
+
+    for (size_t i = 0; i < in_size; i += 3) {
+        const bool have_b = (i + 1) < in_size;
+        const bool have_c = (i + 2) < in_size;
+
+        const uint8_t a = *in++;
+        const uint8_t b = have_b ? *in++ : 0;
+        const uint8_t c = have_c ? *in++ : 0;
+
+        /* Per-group left-rotate on sum_c. */
+        sum_c = (uint16_t)((sum_c & 0x00FFu) << 1);
+        if (sum_c >= 0x0100u) { sum_c++; } /* insert 1 on carry */
+
+        /* Add to sum_a; carry from sum_c bumps sum_a. */
+        sum_a += a;
+        if (sum_c >= 0x0100u) { sum_a++; sum_c &= 0x00FFu; }
+        const uint8_t a2 = a ^ (uint8_t)sum_c;
+
+        /* Add to sum_b; carry from sum_a bumps sum_b. */
+        if (have_b) {
+            sum_b += b;
+            if (sum_a >= 0x0100u) { sum_b++; sum_a &= 0x00FFu; }
+        }
+        const uint8_t b2 = b ^ (uint8_t)sum_a;
+
+        /* Add to sum_c; carry from sum_b bumps sum_c. */
+        if (have_c) {
+            sum_c += c;
+            if (sum_b >= 0x0100u) { sum_c++; sum_b &= 0x00FFu; }
+        }
+        const uint8_t c2 = c ^ (uint8_t)sum_b;
+
+        *out++ = a2;
+        if (have_b) *out++ = b2;
+        if (have_c) *out++ = c2;
+    }
+
+    *sum_out++ = (uint8_t)sum_a;
+    *sum_out++ = (uint8_t)sum_b;
+    *sum_out++ = (uint8_t)sum_c;
+}
+
+static bool sony_checksum_decode(const uint8_t *in, const size_t in_size,
+                                 uint8_t *out, const size_t out_size,
+                                 const uint8_t *const sum)
+{
+    assert(in_size == out_size);
+
+    uint16_t sum_a = 0, sum_b = 0, sum_c = 0;
+
+    for (size_t i = 0; i < in_size; i += 3) {
+        const bool have_b = (i + 1) < in_size;
+        const bool have_c = (i + 2) < in_size;
+
+        const uint8_t a2 = *in++;
+        const uint8_t b2 = have_b ? *in++ : 0;
+        const uint8_t c2 = have_c ? *in++ : 0;
+
+        /* Per-group left-rotate on sum_c. */
+        sum_c = (uint16_t)((sum_c & 0x00FFu) << 1);
+        if (sum_c >= 0x0100u) { sum_c++; } /* insert 1 on carry */
+
+        /* Add to sum_a; carry from sum_c bumps sum_a. */
+        const uint8_t a = a2 ^ (uint8_t)sum_c;
+        sum_a += a;
+        if (sum_c >= 0x0100u) { sum_a++; sum_c &= 0x00FFu; }
+
+        /* Add to sum_b; carry from sum_a bumps sum_b. */
+        const uint8_t b = b2 ^ (uint8_t)sum_a;
+        if (have_b) {
+            sum_b += b;
+            if (sum_a >= 0x0100u) { sum_b++; sum_a &= 0x00FFu; }
+        }
+
+        /* Add to sum_c; carry from sum_b bumps sum_c. */
+        const uint8_t c = c2 ^ (uint8_t)sum_b;
+        if (have_c) {
+            sum_c += c;
+            if (sum_b >= 0x0100u) { sum_c++; sum_b &= 0x00FFu; }
+        }
+
+        *out++ = a;
+        if (have_b) *out++ = b;
+        if (have_c) *out++ = c;
+    }
+
+    if (sum) {
+        return sum[0] == (uint8_t)sum_a &&
+               sum[1] == (uint8_t)sum_b &&
+               sum[2] == (uint8_t)sum_c;
+    } else {
+        return false;
+    }
+}
+
+static bool sony_validate_address(SonyDrive *const drive, const uint8_t track,
+                                  const uint8_t head, const uint8_t sector)
+{
+    const uint8_t sectors = sony_drive_sectors_for_track(drive, track);
+    assert(sectors > 0);
+
+    if (track >= drive->cylinders) {
+        return false;
+    } else if (head > 0 && !drive->double_sided) {
+        return false;
+    } else if (sector >= sectors) {
+        return false;
+    } else {
+        return true;
+    }
+}
+
+static uint64_t sony_lba(SonyDrive *const drive, const uint8_t track,
+                         const uint8_t head, const uint8_t sector)
+{
+    const uint8_t heads = drive->double_sided ? 2 : 1;
+
+    if (drive->sectors_per_track) {
+        return ((uint64_t)track * heads + head)
+                * drive->sectors_per_track + sector;
+    } else {
+        uint64_t lba = 0;
+
+        for (uint8_t i = 0; i < track; i++) {
+            const uint8_t sectors = sony_drive_sectors_for_track(drive, i);
+            assert(sectors > 0);
+            lba += sectors * heads;
+        }
+
+        const uint8_t sectors = sony_drive_sectors_for_track(drive, track);
+        assert(sectors > 0);
+        lba += sectors * head;
+
+        lba += sector;
+
+        return lba;
+    }
+}
+
+static bool sony_drive_prepare_gcr(SonyDrive *const drive, const uint64_t lba,
+                                   const uint8_t track, const uint8_t head,
+                                   const uint8_t sector)
+{
+    assert(head < 2);
+    const uint8_t format_byte = drive->double_sided ? 0x22 : 0x2;
+
+    uint8_t header_vals[5];
+    header_vals[0] = track & 0x3f;
+    header_vals[1] = sector;
+    header_vals[2] = (head << 5) | ((track >> 6) & 0x1f);
+    header_vals[3] = format_byte;
+    header_vals[4] = header_vals[0] ^ header_vals[1] ^
+                     header_vals[2] ^ header_vals[3];
+
+    uint8_t sector_data[SONY_GCR_SECTOR_LENGTH];
+    size_t sector_data_pos = 0;
+    sector_data[sector_data_pos++] = track;
+    sector_data[sector_data_pos++] = head;
+    sector_data[sector_data_pos++] = sector;
+    sector_data[sector_data_pos++] = format_byte;
+    sector_data[sector_data_pos++] = 0x00; /* reserved */
+    sector_data[sector_data_pos++] = 0x00;
+    sector_data[sector_data_pos++] = (lba >> 8) & 0xff;
+    sector_data[sector_data_pos++] = lba & 0xff;
+    sector_data[sector_data_pos++] = 0x00;
+    sector_data[sector_data_pos++] = 0x00;
+    sector_data[sector_data_pos++] = 0x00;
+    sector_data[sector_data_pos++] = 0x00;
+
+    const int ret = blk_pread(drive->blk, lba * 512, SONY_GCR_DATA_LENGTH,
+                              sector_data + sector_data_pos, 0);
+    if (ret < 0) {
+        return false;
+    }
+    sector_data_pos += SONY_GCR_DATA_LENGTH;
+    assert(sector_data_pos == sizeof sector_data);
+
+    /* Fill drive->xfer_buffer. */
+    size_t idx = 0;
+
+    /*
+     * Sync field.  Note that we don't actually have to replicate the sync bytes
+     * as on disk; we can just return what the IWM/SWIM would see.
+     * We use a six-byte field since that matches the size of what the CPU
+     * will write.
+     */
+    memset(&drive->xfer_buffer[idx], 0xff, SONY_GCR_SYNC_LEN);
+    idx += SONY_GCR_SYNC_LEN;
+
+    drive->xfer_buffer[idx++] = 0xd5;
+    drive->xfer_buffer[idx++] = 0xaa;
+    drive->xfer_buffer[idx++] = 0x96;
+
+    sony_gcr_encode_bytes(header_vals, &drive->xfer_buffer[idx],
+                          sizeof header_vals);
+    idx += sizeof header_vals;
+
+    drive->xfer_buffer[idx++] = 0xde;
+    drive->xfer_buffer[idx++] = 0xaa;
+
+    drive->xfer_write_position = idx;
+
+    /* Sync field. */
+    memset(&drive->xfer_buffer[idx], 0xff, SONY_GCR_SYNC_LEN);
+    idx += SONY_GCR_SYNC_LEN;
+
+    drive->xfer_buffer[idx++] = 0xd5;
+    drive->xfer_buffer[idx++] = 0xaa;
+    drive->xfer_buffer[idx++] = 0xad;
+    drive->xfer_buffer[idx++] = sony_gcr_encode_byte(sector);
+
+    /* Sector data. */
+    uint8_t sector_checksum[3];
+    sony_checksum_encode(sector_data, sizeof sector_data,
+                         sector_data, sizeof sector_data, sector_checksum);
+    sony_6and2_pack(sector_data, sizeof sector_data,
+                    drive->xfer_buffer + idx, SONY_GCR_ENCODED_LENGTH);
+    sony_gcr_encode_bytes(drive->xfer_buffer + idx,
+                          drive->xfer_buffer + idx, SONY_GCR_ENCODED_LENGTH);
+    idx += SONY_GCR_ENCODED_LENGTH;
+
+    /* Encode and append checksum. */
+    sony_6and2_pack(sector_checksum, sizeof sector_checksum,
+                    drive->xfer_buffer + idx, 4);
+    sony_gcr_encode_bytes(drive->xfer_buffer + idx,
+                          drive->xfer_buffer + idx, 4);
+    idx += 4;
+
+    /* Trail marks. */
+    drive->xfer_buffer[idx++] = 0xde;
+    drive->xfer_buffer[idx++] = 0xaa;
+
+    /* Add some empty space; the Mac driver overwrites this area. */
+    drive->xfer_buffer[idx++] = 0xff;
+    drive->xfer_buffer[idx++] = 0xff;
+    drive->xfer_buffer[idx++] = 0xff;
+    drive->xfer_buffer[idx++] = 0xff;
+
+    drive->xfer_length = idx;
+    drive->xfer_position = 0;
+    drive->xfer_active = true;
+
+    return true;
+}
+
+static bool sony_drive_persist_gcr(SonyDrive *const drive)
+{
+    uint8_t encoded_data[SONY_GCR_ENCODED_LENGTH];
+    uint8_t sector_data[SONY_GCR_SECTOR_LENGTH];
+
+    uint8_t *const encoded_buffer = drive->xfer_buffer + SONY_GCR_SYNC_LEN + 3
+                                     + 5 + 2 + SONY_GCR_SYNC_LEN + 4;
+    sony_gcr_decode_bytes(encoded_buffer, encoded_data,
+                          SONY_GCR_ENCODED_LENGTH);
+    sony_6and2_unpack(encoded_data, sizeof encoded_data,
+                      sector_data, sizeof sector_data);
+
+    uint8_t encoded_checksum[4];
+    uint8_t checksum[3];
+    sony_gcr_decode_bytes(encoded_buffer + SONY_GCR_ENCODED_LENGTH,
+                          encoded_checksum, 4);
+    sony_6and2_unpack(encoded_checksum, sizeof encoded_checksum,
+                      checksum, sizeof checksum);
+    const bool result = sony_checksum_decode(sector_data, sizeof sector_data,
+                                             sector_data, sizeof sector_data,
+                                             checksum);
+
+    if (!result) {
+        return false;
+    } else {
+        const int ret = blk_pwrite(drive->blk, drive->xfer_lba * 512,
+                                   SONY_GCR_DATA_LENGTH,
+                                   &sector_data[SONY_GCR_TAG_LENGTH], 0);
+        return ret >= 0;
+    }
+}
+
+static bool sony_drive_prepare_mfm(SonyDrive *const drive, const uint64_t lba,
+                                   const uint8_t track, const uint8_t head,
+                                   const uint8_t sector)
+{
+    size_t idx = 0;
+
+    /* Sync field. */
+    memset(drive->xfer_buffer + idx, 0x00, 12);
+    idx += 12;
+
+    /* Address field. */
+    bitset_set_range(drive->xfer_mark_bitset, idx, 3, true);
+    drive->xfer_buffer[idx++] = 0xA1;
+    drive->xfer_buffer[idx++] = 0xA1;
+    drive->xfer_buffer[idx++] = 0xA1;
+
+    drive->xfer_buffer[idx++] = 0xFE;
+    drive->xfer_buffer[idx++] = track;
+    drive->xfer_buffer[idx++] = head;
+    drive->xfer_buffer[idx++] = sector + 1; /* NOTE: 1-indexed, unlike GCR! */
+    drive->xfer_buffer[idx++] = 0x02; /* 512 bytes/sector */
+    drive->xfer_buffer[idx++] = 0x00; /* CRC (unimplemented) */
+    drive->xfer_buffer[idx++] = 0x00; /* CRC (unimplemented) */
+
+    /* Intra-sector gap. */
+    memset(drive->xfer_buffer + idx, 0x4E, 22);
+    idx += 22;
+
+    /* Sync field. */
+    memset(drive->xfer_buffer + idx, 0x00, 12);
+    idx += 12;
+
+    /* Data mark. */
+    bitset_set_range(drive->xfer_mark_bitset, idx, 3, true);
+    drive->xfer_buffer[idx++] = 0xA1;
+    drive->xfer_buffer[idx++] = 0xA1;
+    drive->xfer_buffer[idx++] = 0xA1;
+
+    drive->xfer_write_position = idx;
+    drive->xfer_buffer[idx++] = 0xFB;
+
+    /* Data. */
+    const int ret = blk_pread(drive->blk, lba * 512, SONY_MFM_SECTOR_LENGTH,
+                              drive->xfer_buffer + idx, 0);
+    if (ret < 0) {
+        return false;
+    }
+    idx += SONY_MFM_SECTOR_LENGTH;
+
+    drive->xfer_buffer[idx++] = 0; /* CRC (unimplemented) */
+    drive->xfer_buffer[idx++] = 0; /* CRC (unimplemented) */
+
+    /* Inter-sector gap. */
+    memset(drive->xfer_buffer + idx, 0x4E, 101);
+    idx += 101;
+
+    drive->xfer_length = idx;
+    drive->xfer_position = 0;
+    drive->xfer_active = true;
+
+    return true;
+}
+
+static bool sony_drive_persist_mfm(SonyDrive *const drive)
+{
+    const size_t offset = 12 + 10 + 22 + 12 + 4;
+    const int ret = blk_pwrite(drive->blk, drive->xfer_lba * 512,
+                               SONY_MFM_SECTOR_LENGTH,
+                               drive->xfer_buffer + offset, 0);
+    return ret >= 0;
+}
+
+static void sony_drive_transfer_reset(SonyDrive *const drive)
+{
+    /* First, persist any dirty xfer. */
+    if (drive->xfer_dirty) {
+        bool result;
+
+        if (drive->gcr_encode) {
+            result = sony_drive_persist_gcr(drive);
+        } else {
+            result = sony_drive_persist_mfm(drive);
+        }
+
+        assert(result);
+        trace_sony_drive_persist(drive, drive->xfer_lba);
+    }
+
+    drive->xfer_active = false;
+    drive->xfer_dirty = false;
+    drive->xfer_lba = UINT64_MAX;
+    drive->xfer_position = 0;
+    drive->xfer_write_position = 0;
+    drive->xfer_length = 0;
+    memset(drive->xfer_buffer, 0, sizeof drive->xfer_buffer);
+    memset(drive->xfer_mark_bitset, 0, sizeof drive->xfer_mark_bitset);
+}
+
+static bool sony_drive_prepare(SonyDrive *const drive)
+{
+    if (!drive->disk_in) {
+        trace_sony_drive_prepare(drive, 0, 0, 0, 0, 0);
+        return false;
+    }
+
+    sony_drive_transfer_reset(drive);
+
+    const uint8_t sectors = sony_drive_sectors_for_track(drive,
+                                                         drive->current_track);
+    const uint8_t head = drive->sel ? 1 : 0;
+    const uint8_t track = drive->current_track;
+
+    assert(head == 0 || drive->double_sided);
+    assert(sectors != 0);
+
+    const uint8_t sector = drive->current_sector;
+    drive->current_sector = (drive->current_sector + 1) % sectors;
+    assert(sony_validate_address(drive, track, head, sector));
+
+    const uint64_t lba = sony_lba(drive, track, head, sector);
+    assert(lba < drive->total_sectors);
+
+    bool result;
+    if (drive->gcr_encode) {
+        result = sony_drive_prepare_gcr(drive, lba, track, head, sector);
+    } else {
+        result = sony_drive_prepare_mfm(drive, lba, track, head, sector);
+    }
+
+    drive->xfer_lba = lba;
+    trace_sony_drive_prepare(drive, track, head, sector, drive->gcr_encode,
+                             drive->xfer_length);
+    return result;
+}
+
+static uint8_t sony_drive_selected_drive_reg(const SonyDrive *const drive)
+{
+    uint8_t selector = 0;
+
+    if (drive->phases & 0x4) { /* CA2 */
+        selector |= 0x8;
+    }
+    if (drive->phases & 0x2) { /* CA1 */
+        selector |= 0x4;
+    }
+    if (drive->phases & 0x1) { /* CA0 */
+        selector |= 0x2;
+    }
+    if (drive->sel) {
+        selector |= 0x1;
+    }
+
+    return selector;
+}
+
+static void sony_drive_step(SonyDrive *const drive)
+{
+    if (drive->seek_direction < 0) {
+        if (drive->current_track > 0) {
+            drive->current_track--;
+        }
+    } else {
+        if (!drive->cylinders || drive->current_track + 1 < drive->cylinders) {
+            drive->current_track++;
+        }
+    }
+
+    sony_drive_transfer_reset(drive);
+    trace_sony_drive_step(drive, drive->seek_direction, drive->current_track);
+}
+
+static void sony_drive_strobe_drive(SonyDrive *const drive)
+{
+    const uint8_t selector = sony_drive_selected_drive_reg(drive);
+    trace_sony_drive_strobe(drive, selector, sony_drive_cmd_names[selector]);
+
+    switch (selector) {
+    case SONY_CMD_TRACK_POS:
+        drive->seek_direction = 1;
+        break;
+    case SONY_CMD_TRACK_NEG:
+        drive->seek_direction = -1;
+        break;
+    case SONY_CMD_TRACK_STEP:
+        sony_drive_step(drive);
+        break;
+    case SONY_CMD_SET_MFM:
+        drive->use_gcr = false;
+        break;
+    case SONY_CMD_SET_GCR:
+        drive->use_gcr = true;
+        break;
+    case SONY_CMD_MOTOR_ON:
+        drive->motor_on = true;
+        break;
+    case SONY_CMD_MOTOR_OFF:
+        drive->motor_on = false;
+        sony_drive_transfer_reset(drive);
+        break;
+    case SONY_CMD_EJECT:
+        blk_eject(drive->blk, true);
+        drive->disk_in = false;
+        sony_drive_reset(drive);
+        break;
+    default:
+        break;
+    }
+}
+
+bool sony_drive_read_sense(SonyDrive *const drive)
+{
+    const uint8_t reg = sony_drive_selected_drive_reg(drive);
+    bool value;
+
+    switch (reg) {
+    case SONY_REG_DIRTN:
+        /* "Direction". */
+        value = drive->seek_direction < 0;
+        break;
+    case SONY_REG_CSTIN:
+        /* "Cassette in". */
+        value = !drive->disk_in; /* sense inverted */
+        break;
+    case SONY_REG_STEP:
+        value = true; /* not emulated; our seeks are instantaneous */
+        break;
+    case SONY_REG_WRTPRT:
+        value = !drive->write_protected; /* sense inverted */
+        break;
+    case SONY_REG_MOTORON:
+        value = !drive->motor_on; /* sense inverted */
+        break;
+    case SONY_REG_TKO:
+        /* "Track zero". */
+        value = drive->current_track != 0; /* sense inverted */
+        break;
+    case SONY_REG_EJECT_L:
+        /* Not pressing eject switch. */
+        value = false;
+        break;
+    case SONY_REG_TACH:
+        /* Tacho functionality not emulated. */
+        value = !drive->motor_on;
+        break;
+    case SONY_REG_RDDATA0:
+    case SONY_REG_RDDATA1:
+        /* Single-bit reads are not emulated. */
+        value = true;
+        break;
+    case SONY_REG_SUPERDRIVE:
+        value = true;
+        break;
+    case SONY_REG_GCR:
+        value = !drive->use_gcr; /* sense inverted */
+        break;
+    case SONY_REG_SINGLE_SIDE:
+        /* We are a double-sided drive. */
+        value = true; /* sense inverted */
+        break;
+    case SONY_REG_READY:
+        value = !(drive->disk_in && drive->motor_on); /* sense inverted */
+        break;
+    case SONY_REG_INSTALLED:
+        value = false; /* sense inverted */
+        break;
+    case SONY_REG_TWOMEG:
+        /* "Two-meg" refers to the unformatted size of HD MFM floppies. */
+        value = !(drive->hd_media && drive->disk_in); /* sense inverted */
+        break;
+    default:
+        value = true;
+        break;
+    }
+
+    trace_sony_drive_read_sense(drive, reg, sony_drive_reg_names[reg], value);
+    return value;
+}
+
+void sony_drive_set_inputs(SonyDrive *const drive, const uint8_t phases,
+                           const bool sel, const bool enabled)
+{
+    const bool prev_strobe = (drive->phases & 0x8) != 0 && drive->enabled;
+    const bool cur_strobe = (phases & 0x8) != 0 && enabled;
+
+    drive->phases = phases;
+    drive->sel = sel;
+    drive->enabled = enabled;
+
+    if (!prev_strobe && cur_strobe) {
+        sony_drive_strobe_drive(drive);
+    }
+}
+
+bool sony_drive_read_byte(SonyDrive *const drive,
+                          uint8_t *const value_out, bool *const is_mark_out)
+{
+    if (!drive->xfer_active || drive->xfer_position >= drive->xfer_length) {
+        sony_drive_prepare(drive);
+    }
+
+    if (!drive->xfer_active) {
+        return false;
+    } else {
+        const uint16_t offset = drive->xfer_position;
+        drive->xfer_position++;
+        const uint8_t value = drive->xfer_buffer[offset];
+        const bool is_mark = bitset_get(drive->xfer_mark_bitset, offset);
+
+        if (drive->gcr_encode) {
+            assert(value & 0x80);
+        }
+
+        *value_out = value;
+        *is_mark_out = is_mark;
+
+        trace_sony_drive_read_byte(drive, value, is_mark,
+                                   drive->xfer_lba, offset);
+        return true;
+    }
+}
+
+bool sony_drive_write_byte(SonyDrive *const drive, const uint8_t value)
+{
+    if (drive->write_protected) return false;
+
+    /*
+     * NOTE: for now, we should't get a write unless we have an active sector.
+     * We'll have to revisit this to implement duplicating/formatting.
+     */
+    assert(drive->xfer_active);
+
+    if (!drive->xfer_active) {
+        return false;
+    } else {
+        const uint16_t offset = drive->xfer_write_position;
+        assert(offset < drive->xfer_length);
+
+        drive->xfer_buffer[offset] = value;
+        drive->xfer_write_position++;
+        drive->xfer_dirty = true;
+
+        trace_sony_drive_write_byte(drive, value, drive->xfer_lba, offset);
+        return true;
+    }
+}
+
+void sony_drive_set_block_backend(SonyDrive *const drive,
+                                  BlockBackend *const block)
+{
+    sony_drive_transfer_reset(drive);
+    drive->blk = block;
+    drive->disk_in = blk_is_inserted(block);
+    sony_drive_reset(drive);
+}
+
+void sony_drive_reset(SonyDrive *const drive)
+{
+    sony_drive_transfer_reset(drive);
+
+    drive->motor_on = false;
+    drive->write_protected = false;
+    drive->hd_media = false;
+    drive->double_sided = false;
+    drive->use_gcr = true;
+    drive->gcr_encode = true;
+    drive->cylinders = 0;
+    drive->sectors_per_track = 0;
+    drive->total_sectors = 0;
+    drive->current_track = 0;
+    drive->current_sector = 0;
+    drive->seek_direction = 1;
+
+    if (drive->disk_in) {
+        const int64_t length = blk_getlength(drive->blk);
+
+        if (length <= 0 || length % 512 != 0) {
+            warn_report_once("%s: unsupported floppy size %" PRId64,
+                             __func__, length);
+            drive->disk_in = false;
+        } else {
+            drive->write_protected = !blk_is_writable(drive->blk);
+            drive->total_sectors = length / 512;
+
+            if (drive->total_sectors == 1600) {
+                /* 800 kB (double-sided GCR). */
+                drive->cylinders = 80;
+                drive->double_sided = true;
+                drive->gcr_encode = true;
+            } else if (drive->total_sectors == 800) {
+                /* 400 kB (single-sided GCR). */
+                drive->cylinders = 80;
+                drive->double_sided = false;
+                drive->gcr_encode = true;
+            } else if (drive->total_sectors == 2880) {
+                /* 1440 kB (double-sided MFM). */
+                drive->cylinders = 80;
+                drive->sectors_per_track = 18;
+                drive->hd_media = true;
+                drive->double_sided = true;
+                drive->gcr_encode = false;
+            } else {
+                warn_report_once("%s: unable to determine geometry for media"
+                                 " (%" PRId64 " bytes)", __func__, length);
+                drive->disk_in = false;
+            }
+        }
+    }
+}
diff --git a/hw/block/swim2.c b/hw/block/swim2.c
new file mode 100644
index 0000000000..1d62115165
--- /dev/null
+++ b/hw/block/swim2.c
@@ -0,0 +1,657 @@
+/*
+ * QEMU Macintosh floppy disk controller emulator (SWIM2)
+ *
+ * Copyright (c) 2025 Matt Jacobson <mhjacobson@me.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <assert.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
+#include "hw/block/sony_superdrive.h"
+#include "hw/block/swim2.h"
+#include "system/block-backend.h"
+#include "system/blockdev.h"
+#include "trace.h"
+
+#define SWIM2_MMIO_SIZE            0x2000
+#define SWIM2_REG_SHIFT            9
+
+#define SWIM2_FIFO_FLAG_MARK       0x01
+
+#define SWIM2_SETUP_INVERT_WRDATA  BIT(0)
+#define SWIM2_SETUP_3_5_OUTPUT     BIT(1)
+#define SWIM2_SETUP_GCR_MODE       BIT(2)
+#define SWIM2_SETUP_CLOCK_DIV_2    BIT(3)
+#define SWIM2_SETUP_TEST_MODE      BIT(4)
+#define SWIM2_SETUP_IBM_DATA_MODE  BIT(5)
+#define SWIM2_SETUP_GCR_WRITES     BIT(6)
+#define SWIM2_SETUP_RESERVED       BIT(7)
+
+#define SWIM2_MODE_CLR_FIFO        BIT(0)
+#define SWIM2_MODE_ENBL1           BIT(1)
+#define SWIM2_MODE_ENBL2           BIT(2)
+#define SWIM2_MODE_ACTION          BIT(3)
+#define SWIM2_MODE_WRITE           BIT(4)
+#define SWIM2_MODE_SIDE            BIT(5)
+#define SWIM2_MODE_ALWAYS1         BIT(6)
+#define SWIM2_MODE_MOTORON         BIT(7)
+
+#define SWIM2_ERROR_UNDERRUN       BIT(0)
+#define SWIM2_ERROR_MARK_IN_DATA   BIT(1)
+#define SWIM2_ERROR_OVERRUN        BIT(2)
+#define SWIM2_ERROR_SHORT          BIT(3)
+#define SWIM2_ERROR_LONG           BIT(4)
+
+/*
+ * These are shifted versions of the "SWIM offsets" in HardwareEqu.a in the
+ * System 7.1 source.
+ */
+typedef enum {
+    SWIM2_REG_DATA = 0,
+    SWIM2_REG_MARK = 1,
+    SWIM2_REG_ERROR = 2,
+    SWIM2_REG_PARAMETER = 3,
+    SWIM2_REG_PHASE = 4,
+    SWIM2_REG_SETUP = 5,
+    SWIM2_REG_WRITE_ZEROES = 6,
+    SWIM2_REG_WRITE_ONES = 7,
+} SWIM2Register;
+
+#define SWIM2_REG_WRITE_CRC  SWIM2_REG_ERROR
+#define SWIM2_REG_STATUS     SWIM2_REG_WRITE_ZEROES
+#define SWIM2_REG_HANDSHAKE  SWIM2_REG_WRITE_ONES
+
+static const char *const swim2_read_reg_names[] = {
+    [SWIM2_REG_DATA] = "DATA",
+    [SWIM2_REG_MARK] = "MARK",
+    [SWIM2_REG_ERROR] = "ERROR",
+    [SWIM2_REG_PARAMETER] = "PARAM",
+    [SWIM2_REG_PHASE] = "PHASE",
+    [SWIM2_REG_SETUP] = "SETUP",
+    [SWIM2_REG_STATUS] = "STATUS",
+    [SWIM2_REG_HANDSHAKE] = "HANDSHAKE",
+};
+
+static const char *const swim2_write_reg_names[] = {
+    [SWIM2_REG_DATA] = "DATA",
+    [SWIM2_REG_MARK] = "MARK",
+    [SWIM2_REG_WRITE_CRC] = "WRITE_CRC",
+    [SWIM2_REG_PARAMETER] = "PARAM",
+    [SWIM2_REG_PHASE] = "PHASE",
+    [SWIM2_REG_SETUP] = "SETUP",
+    [SWIM2_REG_WRITE_ZEROES] = "WRITE0",
+    [SWIM2_REG_WRITE_ONES] = "WRITE1",
+};
+
+static inline const char *swim2_reg_name(const uint8_t reg,
+                                         const bool write)
+{
+    assert(reg < 8);
+    const char *const *table = write ? swim2_write_reg_names :
+                                       swim2_read_reg_names;
+    return table[reg];
+}
+
+static void swim2_set_error(SWIM2State *const ctrl, const uint8_t err)
+{
+    const uint8_t prev = ctrl->error_reg;
+    ctrl->error_reg |= err;
+    trace_swim2_error_set(prev, ctrl->error_reg, err, ctrl->mode_reg,
+                          (ctrl->mode_reg & SWIM2_MODE_WRITE) != 0,
+                          ctrl->fifo_count);
+}
+
+static void swim2_fifo_clear(SWIM2State *const ctrl)
+{
+    ctrl->fifo_head = 0;
+    ctrl->fifo_tail = 0;
+    ctrl->fifo_count = 0;
+    trace_swim2_fifo_clear();
+}
+
+static bool swim2_fifo_push(SWIM2State *const ctrl, const uint8_t data,
+                            const bool is_mark)
+{
+    if (ctrl->fifo_count >= ARRAY_SIZE(ctrl->fifo)) {
+        return false;
+    } else {
+        ctrl->fifo[ctrl->fifo_tail].data = data;
+        ctrl->fifo[ctrl->fifo_tail].is_mark = is_mark;
+        ctrl->fifo_tail = (ctrl->fifo_tail + 1) % ARRAY_SIZE(ctrl->fifo);
+        ctrl->fifo_count++;
+        trace_swim2_fifo_push(ctrl->fifo_count, data, is_mark);
+        return true;
+    }
+}
+
+static bool swim2_fifo_pop(SWIM2State *const ctrl, uint8_t *const data,
+                           bool *const is_mark)
+{
+    if (ctrl->fifo_count == 0) {
+        trace_swim2_fifo_pop(ctrl->fifo_count, 0, false, false);
+        return false;
+    } else {
+        SWIM2FIFOEntry *const entry = &ctrl->fifo[ctrl->fifo_head];
+
+        *data = entry->data;
+        if (is_mark) *is_mark = entry->is_mark;
+
+        ctrl->fifo_head = (ctrl->fifo_head + 1) % ARRAY_SIZE(ctrl->fifo);
+        ctrl->fifo_count--;
+
+        trace_swim2_fifo_pop(ctrl->fifo_count, entry->data, entry->is_mark, true);
+        return true;
+    }
+}
+
+static SonyDrive *swim2_active_drive(SWIM2State *const ctrl)
+{
+    uint8_t selected;
+
+    if (ctrl->mode_reg & SWIM2_MODE_ENBL1) {
+        selected = 0;
+    } else if (ctrl->mode_reg & SWIM2_MODE_ENBL2) {
+        selected = 1;
+    } else {
+        return NULL;
+    }
+
+    if (ctrl->drives[selected]) {
+        return &ctrl->drives[selected]->sony;
+    } else {
+        return NULL;
+    }
+}
+
+static void swim2_apply_drive_lines(SWIM2State *const ctrl)
+{
+    SonyDrive *const active = swim2_active_drive(ctrl);
+
+    for (uint8_t i = 0; i < SWIM2_MAX_FD; i++) {
+        SWIM2Drive *const entry = ctrl->drives[i];
+
+        if (!entry) {
+            continue;
+        }
+
+        SonyDrive *const drive = &entry->sony;
+
+        const uint8_t phases = (ctrl->phase_reg & 0xF) &
+                                    (ctrl->phase_reg >> 4);
+        const bool head = (ctrl->mode_reg & SWIM2_MODE_SIDE);
+        const bool enabled = (drive == active) &&
+                             ((ctrl->mode_reg & SWIM2_MODE_MOTORON) != 0);
+
+        sony_drive_set_inputs(drive, phases, head, enabled);
+    }
+}
+
+static void swim2_fill_fifo_from_drive(SWIM2State *const ctrl)
+{
+    SonyDrive *const drive = swim2_active_drive(ctrl);
+
+    if (!drive) {
+        return;
+    }
+
+    while (ctrl->fifo_count < ARRAY_SIZE(ctrl->fifo)) {
+        uint8_t data;
+        bool is_mark;
+
+        if (!sony_drive_read_byte(drive, &data, &is_mark)) {
+            break;
+        } else if (!ctrl->wait_for_mark || is_mark) {
+            ctrl->wait_for_mark = false;
+            const bool did_push = swim2_fifo_push(ctrl, data, is_mark);
+            assert(did_push);
+        }
+    }
+}
+
+static void swim2_push_fifo_to_drive(SWIM2State *const ctrl)
+{
+    SonyDrive *const drive = swim2_active_drive(ctrl);
+
+    if (!drive) {
+        /*
+         * The Mac ROM does this to measure how quickly we can spit bytes out
+         * to a drive.  Just consume the FIFO without error.
+         */
+        swim2_fifo_clear(ctrl);
+    } else {
+        uint8_t data;
+        bool is_mark;
+
+        while (swim2_fifo_pop(ctrl, &data, &is_mark)) {
+            if (ctrl->wait_for_mark && is_mark) {
+                ctrl->wait_for_mark = false;
+            } else if (!ctrl->wait_for_mark && !is_mark) {
+                sony_drive_write_byte(drive, data);
+            }
+        }
+    }
+}
+
+static void swim2_update_mode(SWIM2State *const ctrl, const uint8_t mask,
+                              const bool set_bits)
+{
+    const uint8_t prev_mode = ctrl->mode_reg;
+
+    if (set_bits) {
+        ctrl->mode_reg |= mask;
+    } else {
+        ctrl->mode_reg &= ~mask;
+        ctrl->mode_reg |= SWIM2_MODE_ALWAYS1;
+    }
+
+    if (!set_bits) {
+        ctrl->parameter_index = 0;
+    }
+
+    if ((mask & SWIM2_MODE_CLR_FIFO) && set_bits) {
+        swim2_fifo_clear(ctrl);
+    }
+
+    swim2_apply_drive_lines(ctrl);
+
+    const bool prev_action = prev_mode & SWIM2_MODE_ACTION;
+    const bool action = ctrl->mode_reg & SWIM2_MODE_ACTION;
+
+    if (!prev_action && action) {
+        ctrl->did_handshake = false;
+        ctrl->wait_for_mark = !(ctrl->setup_reg & SWIM2_SETUP_GCR_MODE);
+
+        if (ctrl->mode_reg & SWIM2_MODE_WRITE) {
+            swim2_push_fifo_to_drive(ctrl);
+        } else {
+            swim2_fill_fifo_from_drive(ctrl);
+        }
+    }
+}
+
+static void swim2_handle_phase_write(SWIM2State *const ctrl,
+                                     const uint8_t value)
+{
+    ctrl->phase_reg = value;
+    swim2_apply_drive_lines(ctrl);
+}
+
+static void swim2_handle_setup_write(SWIM2State *const ctrl,
+                                     const uint8_t value)
+{
+    ctrl->setup_reg = value;
+}
+
+/*
+ * We don't actually do anything with these parameter values other than store
+ * them.
+ */
+static void swim2_handle_parameter_write(SWIM2State *const ctrl,
+                                         const uint8_t value)
+{
+    ctrl->parameter_data[ctrl->parameter_index] = value;
+    ctrl->parameter_index = (ctrl->parameter_index + 1) & 0x3;
+}
+
+static uint8_t swim2_handle_parameter_read(SWIM2State *const ctrl)
+{
+    const uint8_t value = ctrl->parameter_data[ctrl->parameter_index];
+    ctrl->parameter_index = (ctrl->parameter_index + 1) & 0x3;
+    return value;
+}
+
+static uint8_t swim2_handle_handshake_read(SWIM2State *const ctrl) {
+    SonyDrive *const drive = swim2_active_drive(ctrl);
+
+    ctrl->did_handshake = true;
+
+    const bool empty = ctrl->fifo_count == 0;
+    const bool full = ctrl->fifo_count == ARRAY_SIZE(ctrl->fifo);
+    const bool error = ctrl->error_reg != 0;
+    const bool sense = drive ? sony_drive_read_sense(drive) : true;
+    const bool mark_next = ctrl->fifo_count > 0 ?
+                                        ctrl->fifo[ctrl->fifo_head].is_mark :
+                                        false;
+
+    uint8_t value = 0;
+    if (mark_next) value |= BIT(0);
+    /* bit 1: 1 when invalid CRC (i.e., never, for us) */
+    /* bit 2: rddata, not emulated */
+    if (sense)                value |= BIT(3);
+    /* bit 4: unused */
+    if (error)                value |= BIT(5);
+
+    if ((ctrl->mode_reg & SWIM2_MODE_WRITE) != 0) {
+        if (empty)            value |= BIT(6);
+        if (!full || error)   value |= BIT(7);
+    } else {
+        if (full)             value |= BIT(6);
+        if (!empty)           value |= BIT(7);
+    }
+
+    return value;
+}
+
+static uint64_t swim2_read(void *const opaque, const hwaddr addr,
+                           const unsigned int size)
+{
+    SWIM2State *const ctrl = SWIM2(opaque);
+    const uint8_t reg = (addr >> SWIM2_REG_SHIFT) & 0x7;
+    uint8_t value = 0xff;
+
+    switch (reg) {
+    case SWIM2_REG_DATA: {
+        bool is_mark;
+
+        if (!swim2_fifo_pop(ctrl, &value, &is_mark)) {
+            value = 0xff;
+            swim2_set_error(ctrl, SWIM2_ERROR_OVERRUN);
+        } else {
+            if (is_mark) {
+                swim2_set_error(ctrl, SWIM2_ERROR_MARK_IN_DATA);
+            }
+
+            swim2_fill_fifo_from_drive(ctrl);
+        }
+
+        break;
+    }
+    case SWIM2_REG_MARK: {
+        /*
+         * Allow reading data bytes from here; the specs seem unclear on whether
+         * this is allowed, but the Mac Sony driver does so.
+         */
+
+        if (!ctrl->did_handshake) {
+            /*
+             * The Mac ROM does something weird when reading an MFM disk.
+             * Immediately after setting ACTION, it pulls and discards two bytes
+             * from MARK.  To avoid needing to emulate this with timing,
+             * simply detect the reads that are not preceded by a HANDSHAKE
+             * and give back the garbage they seem to expect.
+             */
+            value = 0xff;
+        } else if (!swim2_fifo_pop(ctrl, &value, NULL)) {
+            value = 0xff;
+            swim2_set_error(ctrl, SWIM2_ERROR_OVERRUN);
+        } else {
+            swim2_fill_fifo_from_drive(ctrl);
+        }
+
+        break;
+    }
+    case SWIM2_REG_ERROR:
+        value = ctrl->error_reg;
+        ctrl->error_reg = 0;
+        break;
+    case SWIM2_REG_PARAMETER:
+        value = swim2_handle_parameter_read(ctrl);
+        break;
+    case SWIM2_REG_PHASE:
+        value = ctrl->phase_reg;
+        break;
+    case SWIM2_REG_SETUP:
+        value = ctrl->setup_reg;
+        break;
+    case SWIM2_REG_STATUS:
+        value = ctrl->mode_reg;
+        break;
+    case SWIM2_REG_HANDSHAKE:
+        value = swim2_handle_handshake_read(ctrl);
+        break;
+    default:
+        value = 0xff;
+        break;
+    }
+
+    trace_swim2_mmio_read(addr, size, reg, swim2_reg_name(reg, false), value,
+                          ctrl->mode_reg, ctrl->setup_reg, ctrl->phase_reg,
+                          ctrl->fifo_count);
+    return value;
+}
+
+static void swim2_write(void *const opaque, const hwaddr addr,
+                        const uint64_t data, const unsigned int size)
+{
+    SWIM2State *const ctrl = SWIM2(opaque);
+    const uint8_t reg = (addr >> SWIM2_REG_SHIFT) & 0x7;
+    const uint8_t value = data & 0xff;
+
+    switch (reg) {
+    case SWIM2_REG_DATA:
+        if (!swim2_fifo_push(ctrl, value, 0)) {
+            swim2_set_error(ctrl, SWIM2_ERROR_OVERRUN);
+        } else if ((ctrl->mode_reg & SWIM2_MODE_ACTION)) {
+            swim2_push_fifo_to_drive(ctrl);
+        }
+        break;
+    case SWIM2_REG_MARK:
+        if (!swim2_fifo_push(ctrl, value, SWIM2_FIFO_FLAG_MARK)) {
+            swim2_set_error(ctrl, SWIM2_ERROR_OVERRUN);
+        } else if ((ctrl->mode_reg & SWIM2_MODE_ACTION)) {
+            swim2_push_fifo_to_drive(ctrl);
+        }
+        break;
+    case SWIM2_REG_WRITE_CRC:
+        /* Nothing to do. */
+        break;
+    case SWIM2_REG_PARAMETER:
+        swim2_handle_parameter_write(ctrl, value);
+        break;
+    case SWIM2_REG_PHASE:
+        swim2_handle_phase_write(ctrl, value);
+        break;
+    case SWIM2_REG_SETUP:
+        swim2_handle_setup_write(ctrl, value);
+        break;
+    case SWIM2_REG_WRITE_ZEROES:
+        swim2_update_mode(ctrl, value, false);
+        break;
+    case SWIM2_REG_WRITE_ONES:
+        swim2_update_mode(ctrl, value, true);
+        break;
+    default:
+        break;
+    }
+
+    trace_swim2_mmio_write(addr, size, reg, swim2_reg_name(reg, true), value,
+                           ctrl->mode_reg, ctrl->setup_reg, ctrl->phase_reg,
+                           ctrl->fifo_count);
+}
+
+static const MemoryRegionOps swim2_mmio_ops = {
+    .read = swim2_read,
+    .write = swim2_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void swim2_change_cb(void *const opaque, const bool load,
+                            Error **const errp)
+{
+    SWIM2Drive *const drive = opaque;
+
+    if (!load) {
+        blk_set_perm(drive->conf.blk, 0, BLK_PERM_ALL, &error_abort);
+    } else if (!blkconf_apply_backend_options(&drive->conf,
+                 !blk_supports_write_perm(drive->conf.blk), false, errp)) {
+        return;
+    }
+
+    sony_drive_set_block_backend(&drive->sony, drive->conf.blk);
+}
+
+static void swim2_drive_realize(DeviceState *const dev, Error **const errp)
+{
+    SWIM2Drive *const drive = SWIM2_DRIVE(dev);
+    SWIM2State *const ctrl = SWIM2(dev->parent_bus->parent);
+
+    if (!drive->conf.blk) {
+        drive->conf.blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
+        const int ret = blk_attach_dev(drive->conf.blk, dev);
+        assert(ret == 0);
+    }
+
+    if (drive->unit < 0 || drive->unit >= SWIM2_MAX_FD) {
+        error_setg(errp, "unit %d out of range (0-%d)", drive->unit,
+                   SWIM2_MAX_FD - 1);
+        return;
+    }
+
+    if (ctrl->drives[drive->unit]) {
+        error_setg(errp, "floppy unit %d already in use", drive->unit);
+        return;
+    }
+
+    if (!blkconf_blocksizes(&drive->conf, errp)) {
+        /* errp set by blkconf_blocksizes(). */
+        return;
+    }
+
+    if (drive->conf.logical_block_size  != 512 ||
+        drive->conf.physical_block_size != 512) {
+        error_setg(errp, "physical and logical block size must be 512 for"
+                   " floppy");
+        return;
+    }
+
+    drive->conf.rerror = BLOCKDEV_ON_ERROR_AUTO;
+    drive->conf.werror = BLOCKDEV_ON_ERROR_AUTO;
+
+    if (!blkconf_apply_backend_options(&drive->conf,
+          !blk_supports_write_perm(drive->conf.blk), false, errp)) {
+        /* errp set by blkconf_apply_backend_options(). */
+        return;
+    }
+
+    if (blk_get_on_error(drive->conf.blk, 0) != BLOCKDEV_ON_ERROR_ENOSPC &&
+        blk_get_on_error(drive->conf.blk, 0) != BLOCKDEV_ON_ERROR_REPORT) {
+        error_setg(errp, "SWIM2 doesn't support drive option werror");
+        return;
+    }
+
+    if (blk_get_on_error(drive->conf.blk, 1) != BLOCKDEV_ON_ERROR_REPORT) {
+        error_setg(errp, "SWIM2 doesn't support drive option rerror");
+        return;
+    }
+
+    ctrl->drives[drive->unit] = drive;
+    sony_drive_set_block_backend(&drive->sony, drive->conf.blk);
+
+    static const BlockDevOps swim2_block_ops = {
+        .change_media_cb = swim2_change_cb,
+    };
+    blk_set_dev_ops(drive->conf.blk, &swim2_block_ops, drive);
+}
+
+static void swim2_init(Object *const obj)
+{
+    SWIM2State *const ctrl = SWIM2(obj);
+
+    memory_region_init_io(&ctrl->mmio, obj, &swim2_mmio_ops, ctrl,
+                          "swim2", SWIM2_MMIO_SIZE);
+    sysbus_init_mmio(&ctrl->parent_obj, &ctrl->mmio);
+
+    for (int i = 0; i < SWIM2_MAX_FD; i++) {
+        ctrl->drives[i] = NULL;
+    }
+
+    memset(ctrl->parameter_data, 0, sizeof ctrl->parameter_data);
+    ctrl->parameter_index = 0;
+    ctrl->phase_reg = 0;
+    ctrl->setup_reg = 0;
+    ctrl->mode_reg = SWIM2_MODE_ALWAYS1;
+    ctrl->error_reg = 0;
+    ctrl->wait_for_mark = false;
+    swim2_fifo_clear(ctrl);
+}
+
+static void swim2_realize(DeviceState *const dev, Error **const errp)
+{
+    SWIM2State *const ctrl = SWIM2(dev);
+    ctrl->bus = qbus_new(TYPE_SWIM2_BUS, dev, "SWIM2 dummy bus");
+
+    for (int unit = 0; unit < SWIM2_MAX_FD; unit++) {
+        DriveInfo *const dinfo = drive_get(IF_FLOPPY, 0, unit);
+
+        if (dinfo) {
+            DeviceState *const drive = qdev_new(TYPE_SWIM2_DRIVE);
+            qdev_prop_set_int32(drive, "unit", unit);
+            qdev_prop_set_drive_err(drive, "drive",
+                                    blk_by_legacy_dinfo(dinfo), &error_abort);
+            qdev_realize_and_unref(drive, ctrl->bus, &error_abort);
+        }
+    }
+}
+
+/* TODO: support migration */
+static void swim2_class_init(ObjectClass *const oc, const void *const opaque)
+{
+    DeviceClass *const dc = DEVICE_CLASS(oc);
+    dc->realize = swim2_realize;
+    dc->desc = "Apple Macintosh SWIM2 floppy diskette drive controller";
+}
+
+static void swim2_bus_class_init(ObjectClass *const oc,
+                                 const void *const opaque)
+{
+    BusClass *const bc = BUS_CLASS(oc);
+    bc->max_dev = 2;
+}
+
+/* TODO: support migration */
+static void swim2_drive_class_init(ObjectClass *const oc,
+                                   const void *const opaque)
+{
+    DeviceClass *const dc = DEVICE_CLASS(oc);
+    dc->bus_type = TYPE_SWIM2_BUS;
+    dc->realize = swim2_drive_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    static const Property swim2_drive_properties[] = {
+        DEFINE_BLOCK_PROPERTIES(SWIM2Drive, conf),
+        DEFINE_PROP_INT32("unit", SWIM2Drive, unit, -1),
+    };
+    device_class_set_props(dc, swim2_drive_properties);
+
+    dc->desc = "Apple Macintosh SuperDrive floppy diskette drive";
+}
+
+static const TypeInfo swim2_info = {
+    .name = TYPE_SWIM2,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof (SWIM2State),
+    .instance_init = swim2_init,
+    .class_init = swim2_class_init,
+};
+
+static const TypeInfo swim2_bus_info = {
+    .name = TYPE_SWIM2_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = 0,
+    .class_init = swim2_bus_class_init,
+};
+
+static const TypeInfo swim2_drive_info = {
+    .name = TYPE_SWIM2_DRIVE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof (SWIM2Drive),
+    .class_init = swim2_drive_class_init,
+};
+
+static void swim2_register_types(void)
+{
+    type_register_static(&swim2_info);
+    type_register_static(&swim2_bus_info);
+    type_register_static(&swim2_drive_info);
+}
+
+type_init(swim2_register_types)
diff --git a/hw/block/trace-events b/hw/block/trace-events
index cc9a9f2460..8568992678 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -101,3 +101,20 @@ swim_iwmctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg
 swim_iwmctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
 swim_switch_to_ism(void) "switch from IWM to ISM mode"
 swim_switch_to_iwm(void) "switch from ISM to IWM mode"
+
+# swim2.c
+swim2_mmio_read(uint64_t addr, unsigned size, int reg, const char *name, uint64_t value, uint8_t mode, uint8_t setup, uint8_t phase, uint32_t fifo_count) "addr=0x%"PRIx64" size=%u reg=%d [%s] value=0x%"PRIx64" mode=0x%02x setup=0x%02x phase=0x%02x fifo=%u"
+swim2_mmio_write(uint64_t addr, unsigned size, int reg, const char *name, uint64_t value, uint8_t mode, uint8_t setup, uint8_t phase, uint32_t fifo_count) "addr=0x%"PRIx64" size=%u reg=%d [%s] value=0x%"PRIx64" mode=0x%02x setup=0x%02x phase=0x%02x fifo=%u"
+swim2_fifo_push(uint32_t count, uint8_t data, uint8_t flags) "fifo=%u data=0x%02x flags=0x%02x"
+swim2_fifo_pop(uint32_t count, uint8_t data, uint8_t flags, bool success) "fifo=%u data=0x%02x flags=0x%02x success=%d"
+swim2_fifo_clear(void) "clear FIFO"
+swim2_error_set(uint8_t prev, uint8_t curr, uint8_t new_err, uint8_t mode, bool write_mode, uint32_t fifo_count) "prev=0x%02x curr=0x%02x new=0x%02x mode=0x%02x write=%d fifo=%u"
+
+# sony_superdrive.c
+sony_drive_prepare(void *drive, uint8_t track, uint8_t head, uint8_t sector, bool gcr, uint16_t payload_len) "drive=%p track=%"PRIu8" head=%"PRIu8" sector=%"PRIu8" gcr=%d length=%"PRIu16
+sony_drive_persist(void *drive, uint64_t lba) "drive=%p lba=0x%"PRIx64
+sony_drive_strobe(void *drive, uint8_t command, const char *name) "drive=%p cmd=0x%02"PRIx8" [%s]"
+sony_drive_read_sense(void *drive, uint8_t reg, const char *name, bool value) "drive=%p reg=0x%02"PRIx8" [%s] value=%d"
+sony_drive_read_byte(void *drive, uint8_t value, bool is_mark, uint64_t lba, uint16_t position) "drive=%p value=0x%02"PRIx8", is_mark=%d, lba=0x%"PRIx64", position=0x%"PRIx16
+sony_drive_write_byte(void *drive, uint8_t value, uint64_t lba, uint16_t position) "drive=%p value=0x%02"PRIx8", lba=0x%"PRIx64", position=0x%"PRIx16
+sony_drive_step(void *drive, uint8_t seek_direction, uint8_t current_track) "drive=%p direction=%"PRId8", track=%"PRId8
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b8676feb41..8c94d7a351 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -47,7 +47,7 @@
 #include "hw/audio/asc.h"
 #include "hw/nubus/mac-nubus-bridge.h"
 #include "hw/display/macfb.h"
-#include "hw/block/swim.h"
+#include "hw/block/swim2.h"
 #include "net/net.h"
 #include "net/util.h"
 #include "qapi/error.h"
@@ -511,7 +511,7 @@ static void q800_machine_init(MachineState *machine)
     /* SWIM floppy controller */
 
     object_initialize_child(OBJECT(machine), "swim", &m->swim,
-                            TYPE_SWIM);
+                            TYPE_SWIM2);
     sysbus = SYS_BUS_DEVICE(&m->swim);
     sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, SWIM_BASE - IO_BASE,
diff --git a/include/hw/block/sony_superdrive.h b/include/hw/block/sony_superdrive.h
new file mode 100644
index 0000000000..016d6bb05d
--- /dev/null
+++ b/include/hw/block/sony_superdrive.h
@@ -0,0 +1,55 @@
+/*
+ * QEMU Macintosh SuperDrive floppy disk drive emulator
+ *
+ * Copyright (c) 2025 Matt Jacobson <mhjacobson@me.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_BLOCK_SWIM_SONY_H
+#define HW_BLOCK_SWIM_SONY_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include "hw/block/block.h"
+
+typedef struct {
+    BlockBackend *blk;
+
+    uint8_t phases;
+    bool sel;
+    bool enabled;
+
+    bool motor_on;
+    bool disk_in;
+    bool write_protected;
+    bool hd_media;
+    bool double_sided;
+    bool use_gcr;
+    bool gcr_encode;
+    uint8_t cylinders;
+    uint8_t sectors_per_track;
+    uint8_t current_track;
+    uint8_t current_sector;
+    int8_t seek_direction;
+    uint32_t total_sectors;
+
+    bool xfer_active;
+    bool xfer_dirty;
+    uint64_t xfer_lba;
+    uint16_t xfer_position;
+    uint16_t xfer_write_position;
+    uint16_t xfer_length;
+    uint8_t xfer_buffer[1024];
+    uint8_t xfer_mark_bitset[1024 / 8];
+} SonyDrive;
+
+void sony_drive_set_block_backend(SonyDrive *drive, BlockBackend *block);
+void sony_drive_reset(SonyDrive *drive);
+bool sony_drive_read_sense(SonyDrive *drive);
+void sony_drive_set_inputs(SonyDrive *drive, uint8_t phases, bool sel, bool enabled);
+bool sony_drive_read_byte(SonyDrive *drive, uint8_t *value_out, bool *is_mark_out);
+bool sony_drive_write_byte(SonyDrive *const drive, const uint8_t value);
+
+#endif /* HW_BLOCK_SWIM_SONY_H */
diff --git a/include/hw/block/swim2.h b/include/hw/block/swim2.h
new file mode 100644
index 0000000000..4999cdcc2b
--- /dev/null
+++ b/include/hw/block/swim2.h
@@ -0,0 +1,66 @@
+/*
+ * QEMU Macintosh floppy disk controller emulator (SWIM2)
+ *
+ * Copyright (c) 2025 Matt Jacobson <mhjacobson@me.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_BLOCK_SWIM2_H
+#define HW_BLOCK_SWIM2_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
+#include "hw/block/block.h"
+#include "hw/block/sony_superdrive.h"
+#include "qom/object.h"
+
+#define TYPE_SWIM2 "swim2"
+#define TYPE_SWIM2_BUS "swim2-bus"
+#define TYPE_SWIM2_DRIVE "swim2-drive"
+
+OBJECT_DECLARE_SIMPLE_TYPE(SWIM2State, SWIM2)
+OBJECT_DECLARE_SIMPLE_TYPE(SWIM2Drive, SWIM2_DRIVE)
+
+#define SWIM2_MAX_FD 2
+
+struct SWIM2Drive {
+    DeviceState parent_obj;
+
+    BlockConf conf;
+    SonyDrive sony;
+    int32_t unit;
+};
+
+typedef struct {
+    uint8_t data;
+    bool is_mark;
+} SWIM2FIFOEntry;
+
+struct SWIM2State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    BusState *bus;
+
+    SWIM2Drive *drives[SWIM2_MAX_FD];
+
+    uint8_t parameter_data[4];
+    uint8_t parameter_index;
+    uint8_t phase_reg;
+    uint8_t setup_reg;
+    uint8_t mode_reg;
+    uint8_t error_reg;
+    bool did_handshake;
+    bool wait_for_mark;
+
+    SWIM2FIFOEntry fifo[2];
+    uint8_t fifo_head;
+    uint8_t fifo_tail;
+    uint8_t fifo_count;
+};
+
+#endif /* HW_BLOCK_SWIM2_H */
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 9caaed9692..788e7cd885 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -33,7 +33,7 @@
 #include "hw/char/escc.h"
 #include "hw/or-irq.h"
 #include "hw/scsi/esp.h"
-#include "hw/block/swim.h"
+#include "hw/block/swim2.h"
 #include "hw/nubus/mac-nubus-bridge.h"
 #include "hw/display/macfb.h"
 #include "hw/misc/djmemc.h"
@@ -59,7 +59,7 @@ struct Q800MachineState {
     ESCCState escc;
     OrIRQState escc_orgate;
     SysBusESPState esp;
-    Swim swim;
+    SWIM2State swim;
     MacNubusBridge mac_nubus_bridge;
     MacfbNubusState macfb;
     DJMEMCState djmemc;
-- 
2.37.1 (Apple Git-137.1)


