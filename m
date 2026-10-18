Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EF7CCF2D1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 05:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIJ7V-0005HB-IR; Sun, 18 Oct 2026 01:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7N-0005Fz-8L
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:34 -0400
Received: from nx104.node02.secure-mailgate.com ([192.162.87.104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJ7J-0000RK-HA
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:07:32 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node02.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xIJ7G-00HSah-05; Sun, 18 Oct 2026 07:07:27 +0200
Received: from Zeuss.fritz.box (p57b2fda0.dip0.t-ipconnect.de [87.178.253.160])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 22052282AB1;
 Sun, 18 Oct 2026 07:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792300045;
 bh=ho22ubS8OSaULynIJkCJOF+Am/Qd/t6JqmPHlBLYuHs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GbZWBMY2kvLXUaZk9ULMsKIwkXuDz5RMhGsjVyPtzwdRbhNLPINbx83mzIknrX/be
 4BtuDWljTgbMexiXiRNzekxnOMv31tkENWPM2dVDkGN+/zQpiIS+nYkhy9T5p/IyIk
 7vmK4au+ViuGSGSPdVYIRDTIXJaMHdIixtYhh/A4=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/5] tests/qtest: add tests for the Cirrus BitBLT engine
Date: Sun, 18 Oct 2026 07:06:40 +0200
Message-ID: <20261018050643.9288-6-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018050643.9288-1-christian@quante.one>
References: <20261018050643.9288-1-christian@quante.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179230004573.350520.15919160623917232914@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (8.43192183297e-07)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV7RwrPKr7u81fjG5H8ZCDAaQIW1v7YYoZp
 UgG+EGbr7Cu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4ZT9g0xXHoQFcoBjLaj1yDrS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6A6B6pTstltS07kaQJ8I9sYal0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+u/6qIuBtLkUxxV/USyR/jsy3xQl12nwobNyEeX2iOu
 PBl1nTKzT0QzJq+XCCX+bItbKfrvYBbAljkt7Epzm3J555HUEfecDXLZTChT+dXw9cANBiw5IFvS
 J1+AiFojfzPxvTAOUZAymq64nP6eBCAXlLotyYa3jHxAO+eLLGkexw5uvJef8mVqbzbGrd9kfjMz
 JtEnZL7T4viKujMjLRbqYSzwjr1vpRkAvfd1aGp6GuUr7e3rKguV1/75QC4uRp/Egi+5tFGx/YER
 vDQsXWFPEo6Fw5tldaeQTD7oX0IbJmI/EcTe67+lFg16JEjoKkgfyFzdptj5x2Xs0Np8JC6g4s+x
 VWXt18LWSglFmXcG20WdUaEnAzrKtj2q24UDob0ub7T76xshSOuiuvUbo76cZzhh7v2iYWfi4Fnw
 z1DC9Pe13wDIzkKJlSZrrQUonzgKWxyndN2QfqgDqk+J/3SJfvGPO7To2xFpzad+qFkyH+EOwtjK
 uuff4Uza3eRtXeHZ2pJLJEsFo7eeWHjv6VlKvaJ4DkGgPykBDCm+SdtsjAaM6KVr7cAerFJU/J5e
 Z6py2DNwOgV373pfDhBQ21Od8Px2uW0YBguFiyOt4UgMCMOJnQd2h4zl0/7hwkh8dMyNKfvbwnpS
 9+19ePGD0GXiVkNMntLVqQTTb3SbSKh8/E6OUoXc2DfYzVpSUI2bAjk3oto0tveWGbkxfhWtKX3e
 xevHXeZU/cwVa7IDYbjreqeQ5gH55RCPMx3qa0pINniPSODOILBgTMuvbqOngFhz9jihx+Za/cV7
 0jOJzN2r4A==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=192.162.87.104; envelope-from=christian@quante.one;
 helo=nx104.node02.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

No test checks the result of a Cirrus BitBLT so far; display-vga-test
only starts the device.  Add cirrus-test, which programs BitBLTs through
the graphics controller registers (ports 0x3ce/0x3cf) and checks video
memory through the linear frame buffer of cirrus-vga:

 - pattern copies whose first pattern line is not line 0, with a
   monochrome and with an 8 bpp color pattern,
 - a color expansion from the CPU with DWORD granularity (GR33 bit 0),
 - color expansions from video memory with a source pitch of 0x40 and
   of 0, opaque and transparent, in 8 and 16 bpp,
 - a color expansion from video memory whose source would run past the
   end of video memory; QEMU drops it.

Without "keep the first pattern line of pattern copies", the two pattern
tests fail; without "fix the source pitch for DWORD granularity", the
DWORD test fails; without "allow a zero source pitch for color
expansion", the source pitch test fails.  The last test checks that the
bounds check of that patch stays in place.

The coalescing of the BitBLT registers only matters with KVM, so qtest
cannot check it.

Signed-off-by: Christian Quante <christian@quante.one>
---
 MAINTAINERS               |   1 +
 tests/qtest/cirrus-test.c | 317 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build   |   1 +
 3 files changed, 319 insertions(+)
 create mode 100644 tests/qtest/cirrus-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 22caaee967..834610ecef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3011,6 +3011,7 @@ M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
 W: https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
 F: hw/display/cirrus*
+F: tests/qtest/cirrus-test.c
 
 EDID Generator
 M: Gerd Hoffmann <kraxel@redhat.com>
diff --git a/tests/qtest/cirrus-test.c b/tests/qtest/cirrus-test.c
new file mode 100644
index 0000000000..ae693a888d
--- /dev/null
+++ b/tests/qtest/cirrus-test.c
@@ -0,0 +1,317 @@
+/*
+ * QTest testcase for the BitBLT engine of the Cirrus VGA emulation
+ *
+ * The tests program the BitBLT registers through the ports 0x3ce/0x3cf
+ * and check video memory through the linear frame buffer (BAR 0).
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "libqtest.h"
+#include "libqos/pci.h"
+#include "libqos/pci-pc.h"
+
+#define VRAM_SIZE       (4 * MiB)           /* default vgamem_mb=4 */
+
+#define FILL            0x11                /* video memory before a BitBLT */
+#define FG              0xee                /* foreground: GR1, GR11 */
+#define BG              0x22                /* background: GR0, GR10 */
+
+/* GR30, BLT mode */
+#define MODE_SYSSRC     0x04
+#define MODE_TRANSP     0x08
+#define MODE_16BPP      0x10
+#define MODE_PATTERN    0x40
+#define MODE_COLOREXP   0x80
+
+/* GR33, BLT mode extensions */
+#define MODEEXT_DWORD   0x01
+
+typedef struct {
+    QTestState *qts;
+    QPCIBus *bus;
+    QPCIDevice *dev;
+    QPCIBar fb;
+} Cirrus;
+
+typedef struct {
+    uint8_t mode, modeext;
+    int width, height;              /* width in bytes */
+    int dstpitch, srcpitch;
+    uint32_t dst, src;
+} Blt;
+
+static void sr(Cirrus *c, uint8_t index, uint8_t val)
+{
+    qtest_outb(c->qts, 0x3c4, index);
+    qtest_outb(c->qts, 0x3c5, val);
+}
+
+static void gr(Cirrus *c, uint8_t index, uint8_t val)
+{
+    qtest_outb(c->qts, 0x3ce, index);
+    qtest_outb(c->qts, 0x3cf, val);
+}
+
+static void cirrus_start(Cirrus *c)
+{
+    c->qts = qtest_init("-vga none -device cirrus-vga,addr=04.0");
+    c->bus = qpci_new_pc(c->qts, NULL);
+    c->dev = qpci_device_find(c->bus, QPCI_DEVFN(0x4, 0x0));
+    g_assert(c->dev);
+    qpci_device_enable(c->dev);
+    c->fb = qpci_iomap(c->dev, 0, NULL);
+
+    sr(c, 0x06, 0x12);              /* unlock the extension registers */
+    sr(c, 0x07, 0x01);              /* extended mode, 8 bpp */
+    gr(c, 0x00, BG);
+    gr(c, 0x01, FG);
+    gr(c, 0x10, BG);
+    gr(c, 0x11, FG);
+}
+
+static void cirrus_stop(Cirrus *c)
+{
+    g_free(c->dev);
+    qpci_free_pc(c->bus);
+    qtest_quit(c->qts);
+}
+
+static void vram_write(Cirrus *c, uint32_t addr, const void *buf, size_t len)
+{
+    qpci_memwrite(c->dev, c->fb, addr, buf, len);
+}
+
+static void vram_read(Cirrus *c, uint32_t addr, void *buf, size_t len)
+{
+    qpci_memread(c->dev, c->fb, addr, buf, len);
+}
+
+/* Fill the destination rectangle of @b with FILL */
+static void clear_dst(Cirrus *c, const Blt *b)
+{
+    g_autofree uint8_t *line = g_malloc(b->width);
+
+    memset(line, FILL, b->width);
+    for (int y = 0; y < b->height; y++) {
+        vram_write(c, b->dst + y * b->dstpitch, line, b->width);
+    }
+}
+
+static void blt_start(Cirrus *c, const Blt *b)
+{
+    gr(c, 0x20, (b->width - 1) & 0xff);
+    gr(c, 0x21, (b->width - 1) >> 8);
+    gr(c, 0x22, (b->height - 1) & 0xff);
+    gr(c, 0x23, (b->height - 1) >> 8);
+    gr(c, 0x24, b->dstpitch & 0xff);
+    gr(c, 0x25, b->dstpitch >> 8);
+    gr(c, 0x26, b->srcpitch & 0xff);
+    gr(c, 0x27, b->srcpitch >> 8);
+    gr(c, 0x28, b->dst & 0xff);
+    gr(c, 0x29, (b->dst >> 8) & 0xff);
+    gr(c, 0x2a, b->dst >> 16);
+    gr(c, 0x2c, b->src & 0xff);
+    gr(c, 0x2d, (b->src >> 8) & 0xff);
+    gr(c, 0x2e, b->src >> 16);
+    gr(c, 0x2f, 0x00);
+    gr(c, 0x30, b->mode);
+    gr(c, 0x32, 0x0d);              /* ROP: copy the source */
+    gr(c, 0x33, b->modeext);
+    gr(c, 0x31, 0x02);              /* start */
+}
+
+/*
+ * Check the destination of a color expansion: line y of the destination
+ * shows the bits of bits[y], most significant bit first.  Without
+ * transparency, 0 bits are drawn in the background color; with
+ * transparency, they leave FILL in place.
+ */
+static void check_expansion(Cirrus *c, const Blt *b, const uint8_t *bits)
+{
+    int bpp = b->mode & MODE_16BPP ? 2 : 1;
+    g_autofree uint8_t *line = g_malloc(b->width);
+
+    for (int y = 0; y < b->height; y++) {
+        vram_read(c, b->dst + y * b->dstpitch, line, b->width);
+        for (int x = 0; x < b->width; x++) {
+            bool set = bits[y] & (0x80 >> (x / bpp));
+            uint8_t expect = set ? FG : (b->mode & MODE_TRANSP) ? FILL : BG;
+
+            g_assert_cmphex(line[x], ==, expect);
+        }
+    }
+}
+
+/*
+ * A monochrome pattern starts on an 8-byte boundary, and the three low
+ * bits of the source address select its first line.
+ */
+static void test_mono_pattern_first_line(void)
+{
+    static const uint8_t pattern[8] = {
+        0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01
+    };
+    Blt b = {
+        .mode = MODE_COLOREXP | MODE_PATTERN,
+        .width = 8, .height = 8, .dstpitch = 64,
+        .dst = 0, .src = 0x10008 + 3,
+    };
+    uint8_t bits[8];
+    Cirrus c;
+
+    cirrus_start(&c);
+    vram_write(&c, 0x10008, pattern, sizeof(pattern));
+    clear_dst(&c, &b);
+    blt_start(&c, &b);
+    for (int y = 0; y < 8; y++) {
+        bits[y] = pattern[(3 + y) & 7];
+    }
+    check_expansion(&c, &b, bits);
+    cirrus_stop(&c);
+}
+
+/*
+ * An 8 bpp color pattern has 64 bytes, and the three low bits of the
+ * source address select its first line.
+ */
+static void test_color_pattern_first_line(void)
+{
+    Blt b = {
+        .mode = MODE_PATTERN,
+        .width = 8, .height = 8, .dstpitch = 64,
+        .dst = 0, .src = 0x10040 + 5,
+    };
+    uint8_t pattern[64], line[8];
+    Cirrus c;
+
+    for (int i = 0; i < 64; i++) {
+        pattern[i] = 0x40 + i;
+    }
+    cirrus_start(&c);
+    vram_write(&c, 0x10040, pattern, sizeof(pattern));
+    clear_dst(&c, &b);
+    blt_start(&c, &b);
+    for (int y = 0; y < 8; y++) {
+        vram_read(&c, b.dst + y * b.dstpitch, line, sizeof(line));
+        g_assert_cmpmem(line, sizeof(line), &pattern[((5 + y) & 7) * 8], 8);
+    }
+    cirrus_stop(&c);
+}
+
+/*
+ * With DWORD granularity (GR33 bit 0), each line of color expansion data
+ * from the CPU starts with a new dword.
+ */
+static void test_sysmem_expansion_dword(void)
+{
+    static const uint8_t bits[4] = { 0xf0, 0x81, 0x3c, 0x55 };
+    Blt b = {
+        .mode = MODE_COLOREXP | MODE_SYSSRC, .modeext = MODEEXT_DWORD,
+        .width = 8, .height = 4, .dstpitch = 64,
+        .dst = 0,
+    };
+    uint8_t data[16];
+    Cirrus c;
+
+    /* one byte of pixels per line, then 3 bytes of padding */
+    for (int y = 0; y < 4; y++) {
+        data[y * 4] = bits[y];
+        data[y * 4 + 1] = data[y * 4 + 2] = data[y * 4 + 3] = 0xff;
+    }
+    cirrus_start(&c);
+    clear_dst(&c, &b);
+    blt_start(&c, &b);
+    vram_write(&c, 0, data, sizeof(data));
+    check_expansion(&c, &b, bits);
+    cirrus_stop(&c);
+}
+
+/*
+ * The source pitch has no meaning for a color expansion from video
+ * memory: the source is a linear string of bytes.  Check it with a source
+ * pitch of 0x40 and of 0, opaque and transparent, in 8 and 16 bpp.
+ */
+static void test_vram_expansion_pitch(void)
+{
+    static const uint8_t glyph[8] = {
+        0xff, 0x81, 0xbd, 0xa5, 0xa5, 0xbd, 0x81, 0xff
+    };
+    static const uint8_t modes[] = {
+        MODE_COLOREXP,
+        MODE_COLOREXP | MODE_TRANSP,
+        MODE_COLOREXP | MODE_16BPP,
+        MODE_COLOREXP | MODE_16BPP | MODE_TRANSP,
+    };
+    static const int srcpitches[] = { 0x40, 0 };
+    Cirrus c;
+
+    cirrus_start(&c);
+    vram_write(&c, 0x4000, glyph, sizeof(glyph));
+    for (int i = 0; i < ARRAY_SIZE(modes); i++) {
+        for (int j = 0; j < ARRAY_SIZE(srcpitches); j++) {
+            Blt b = {
+                .mode = modes[i],
+                .width = modes[i] & MODE_16BPP ? 16 : 8, .height = 8,
+                .dstpitch = 64, .srcpitch = srcpitches[j],
+                .dst = 0, .src = 0x4000,
+            };
+
+            clear_dst(&c, &b);
+            blt_start(&c, &b);
+            check_expansion(&c, &b, glyph);
+        }
+    }
+    cirrus_stop(&c);
+}
+
+/*
+ * QEMU drops a color expansion whose source would run past the end of
+ * video memory.
+ */
+static void test_vram_expansion_beyond_end(void)
+{
+    static const uint8_t bits[4] = { 0xff, 0xff, 0xff, 0xff };
+    Blt b = {
+        .mode = MODE_COLOREXP,
+        .width = 8, .height = 8, .dstpitch = 64,
+        .dst = 0, .src = VRAM_SIZE - 4,
+    };
+    uint8_t line[8], fill[8];
+    Cirrus c;
+
+    memset(fill, FILL, sizeof(fill));
+    cirrus_start(&c);
+    vram_write(&c, VRAM_SIZE - 4, bits, sizeof(bits));
+    clear_dst(&c, &b);
+    blt_start(&c, &b);
+    for (int y = 0; y < b.height; y++) {
+        vram_read(&c, b.dst + y * b.dstpitch, line, sizeof(line));
+        g_assert_cmpmem(line, sizeof(line), fill, sizeof(fill));
+    }
+    cirrus_stop(&c);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (!qtest_has_device("cirrus-vga")) {
+        return g_test_run();
+    }
+
+    qtest_add_func("/cirrus/blt/mono-pattern-first-line",
+                   test_mono_pattern_first_line);
+    qtest_add_func("/cirrus/blt/color-pattern-first-line",
+                   test_color_pattern_first_line);
+    qtest_add_func("/cirrus/blt/sysmem-expansion-dword",
+                   test_sysmem_expansion_dword);
+    qtest_add_func("/cirrus/blt/vram-expansion-pitch",
+                   test_vram_expansion_pitch);
+    qtest_add_func("/cirrus/blt/vram-expansion-beyond-end",
+                   test_vram_expansion_beyond_end);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 019c63ca60..055642e211 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -70,6 +70,7 @@ qtests_i386 = \
   (igvm.found() and
    config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['launchupdate-test'] : []) +          \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
+  (config_all_devices.has_key('CONFIG_VGA_CIRRUS') ? ['cirrus-test'] : []) +                \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['test-x86-cpuid-compat'] : []) +          \
-- 
2.53.0


