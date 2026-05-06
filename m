Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCEACD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKXOh-0001HC-3I; Wed, 06 May 2026 04:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wKWwJ-0000j4-1U
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:45:04 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wKWwC-0005Co-EC
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:45:00 -0400
DKIM-Signature: a=rsa-sha256; bh=JwHLBcJVcH4kV4SWyKth5pyWlJIYa0m+/eHjJhU5F8Q=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1778053490; v=1;
 b=mRzMXkM4rTEz8OfGC0XgiXpaP5ihuf2y3R2MBamMl//t4quhX+88vf8i5yNmN3b0DekMtSpS
 7Ym80GisljSLD2fTZjBs9PFmK5wYCjsjHSusROgVygLy1mKSTVqIHFIpMyiUtK2KJnPWaZCqmDz
 xkAJSC5mbn9DFFt5I2x9dMTIhG6A58o+eqV+Yl2MTwJOdfplLfIRygLM34NkGlLpotxhBvGRrBp
 LEChMabljvWTSQF/WaJwFkggWpBw0xppkyLVIstrhHsaaDavHf9VR/Gc95oxtsQI+gED7OAjyEz
 /LbBkoSGI963HCFOOE3Am/soQaKc9v1NAkePMZDi/sBFQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id CDE2420E6E;
 Wed, 06 May 2026 07:44:50 +0000 (UTC)
From: ~bboe <bboe@git.sr.ht>
Date: Tue, 05 May 2026 22:30:25 -0700
Subject: [PATCH qemu 3/3] Add OPL3 support to SB16
Message-ID: <177805349017.32250.15775019749727013358-2@git.sr.ht>
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
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095, HK_RANDOM_REPLYTO=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Nuked-OPL3 silently drops writes to bank-0 registers 0x02-0x04, so we maintain
the status byte ourselves. sb16_opl3_write updates opl3_status when the guest
writes register 0x04 (Timer Control). We use a similar advance-on-write patte=
rn
as hw/audio/adlib.c uses with fmopl.

Signed-off-by: Bryce Boe <bbzbryce@gmail.com>
---
 hw/audio/sb16.c              | 176 ++++++++++++++++++++++++++++++++++-
 tests/qtest/meson.build      |   2 +-
 tests/qtest/sb16-opl3-test.c |  45 +++++++++
 3 files changed, 217 insertions(+), 6 deletions(-)
 create mode 100644 tests/qtest/sb16-opl3-test.c

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 1838d3ef7b..a05337d9f9 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/audio/model.h"
+#include "hw/audio/nuked_opl3.h"
 #include "qemu/audio.h"
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
@@ -112,8 +113,22 @@ struct SB16State {
     int mixer_nreg;
     uint8_t mixer_regs[256];
     PortioList portio_list;
+
+    /* OPL3 (FM) integration; see nuked_opl3.h */
+    opl3_chip opl3;
+    bool opl3_active;
+    uint16_t opl3_latched_reg;
+    int16_t *opl3_mix_buffer;
+    PortioList opl3_portio_list_388;
+    PortioList opl3_portio_list_mirror;
+    unsigned int opl3_samples;
+    uint8_t opl3_status;
+    SWVoiceOut *opl3_voice;
 };
=20
+/* OPL native sample rate: 14.31818 MHz / 288. */
+#define SB16_OPL3_FREQ 49716
+
 #define SAMPLE_RATE_MIN 5000
 #define SAMPLE_RATE_MAX 45000
=20
@@ -1325,6 +1340,30 @@ static int sb16_post_load (void *opaque, int version_i=
d)
     return 0;
 }
=20
+static bool sb16_opl3_needed(void *opaque)
+{
+    SB16State *state =3D opaque;
+    return state->opl3_active;
+}
+
+static const VMStateDescription vmstate_sb16_opl3 =3D {
+    .name =3D "sb16/opl3",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D sb16_opl3_needed,
+    /*
+     * FM waveform state does not survive snapshots, so
+     * audio restarts after a snapshot reload until the guest writes
+     * registers again.
+     */
+    .fields =3D (const VMStateField[]) {
+        VMSTATE_BOOL(opl3_active, SB16State),
+        VMSTATE_UINT16(opl3_latched_reg, SB16State),
+        VMSTATE_UINT8(opl3_status, SB16State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_sb16 =3D {
     .name =3D "sb16",
     .version_id =3D 1,
@@ -1380,6 +1419,10 @@ static const VMStateDescription vmstate_sb16 =3D {
         VMSTATE_BUFFER (mixer_regs, SB16State),
=20
         VMSTATE_END_OF_LIST ()
+    },
+    .subsections =3D (const VMStateDescription * const []) {
+        &vmstate_sb16_opl3,
+        NULL
     }
 };
=20
@@ -1393,6 +1436,120 @@ static const MemoryRegionPortio sb16_ioport_list[] =
=3D {
     PORTIO_END_OF_LIST (),
 };
=20
+static void sb16_opl3_callback(void *opaque, int free)
+{
+    unsigned int samples;
+    SB16State *state =3D opaque;
+
+    if (!state->opl3_active || !state->opl3_voice || free < 4) {
+        return;
+    }
+
+    /* stereo has 4 bytes per frame; cap to mix_buffer capacity */
+    samples =3D MIN((unsigned int)(free / 4), state->opl3_samples);
+
+    OPL3_GenerateStream(&state->opl3, state->opl3_mix_buffer, samples);
+    audio_be_write(state->audio_be, state->opl3_voice, state->opl3_mix_buffe=
r,
+                   samples * 4);
+}
+
+static uint32_t sb16_opl3_read(void *opaque, uint32_t nport)
+{
+    SB16State *state =3D opaque;
+    return state->opl3_status;
+}
+
+static void sb16_opl3_write(void *opaque, uint32_t nport, uint32_t val)
+{
+    int port_offset =3D nport & 3;
+    SB16State *state =3D opaque;
+
+    if (!state->opl3_active) {
+        state->opl3_active =3D true;
+        audio_be_set_active_out(state->audio_be, state->opl3_voice, 1);
+    }
+
+    switch (port_offset) {
+    case 0:  /* bank-0 address latch */
+        state->opl3_latched_reg =3D val & 0xff;
+        break;
+    case 2:  /* bank-1 address latch */
+        state->opl3_latched_reg =3D (val & 0xff) | 0x100;
+        break;
+    case 1:  /* bank-0 data commit */
+    case 3:  /* bank-1 data commit; bank bit already in opl3_latched_reg */
+        /*
+         * Bank-0 reg 0x04 is OPL Timer Control. Nuked-OPL3 ignores it,
+         * so we synthesize the status byte here. Bit 7 =3D IRQ reset
+         * (clears status); else status reflects start+mask bits per
+         * AdLib/OPL3 semantics:
+         *   ctrl bit 0: T1 start    ctrl bit 6: T1 mask
+         *   ctrl bit 1: T2 start    ctrl bit 5: T2 mask
+         */
+        if (state->opl3_latched_reg =3D=3D 0x04) {
+            if (val & 0x80) {
+                state->opl3_status =3D 0;
+            } else {
+                uint8_t status =3D 0;
+                if ((val & 0x01) && !(val & 0x40)) {
+                    status |=3D 0x40;
+                }
+                if ((val & 0x02) && !(val & 0x20)) {
+                    status |=3D 0x20;
+                }
+                if (status) {
+                    status |=3D 0x80;
+                }
+                state->opl3_status =3D status;
+            }
+        }
+        OPL3_WriteRegBuffered(&state->opl3, state->opl3_latched_reg,
+                              val & 0xff);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "sb16-opl3: invalid port_offset %d\n", port_offset);
+    }
+}
+
+static const MemoryRegionPortio sb16_opl3_portio_list_388[] =3D {
+    { 0, 4, 1, .read =3D sb16_opl3_read, .write =3D sb16_opl3_write },
+    PORTIO_END_OF_LIST(),
+};
+static const MemoryRegionPortio sb16_opl3_portio_list_mirror[] =3D {
+    { 0, 4, 1, .read =3D sb16_opl3_read, .write =3D sb16_opl3_write },
+    PORTIO_END_OF_LIST(),
+};
+
+static void sb16_opl3_realize(SB16State *state, ISADevice *isadev)
+{
+    struct audsettings as =3D {
+        .freq =3D SB16_OPL3_FREQ,
+        .nchannels =3D 2,
+        .fmt =3D AUDIO_FORMAT_S16,
+        .big_endian =3D HOST_BIG_ENDIAN,
+    };
+
+    OPL3_Reset(&state->opl3, SB16_OPL3_FREQ);
+
+    state->opl3_voice =3D audio_be_open_out(state->audio_be, NULL, "sb16-opl=
3",
+                                          state, sb16_opl3_callback, &as);
+    if (!state->opl3_voice) {
+        warn_report("sb16: OPL3 audio voice open failed; FM disabled");
+        return;
+    }
+
+    state->opl3_samples =3D
+        audio_be_get_buffer_size_out(state->audio_be, state->opl3_voice) / 4;
+    state->opl3_mix_buffer =3D g_malloc0(state->opl3_samples * 4);
+    isa_register_portio_list(isadev, &state->opl3_portio_list_388,
+                             0x388, sb16_opl3_portio_list_388,
+                             state, "sb16-opl3-alt");
+    isa_register_portio_list(isadev, &state->opl3_portio_list_mirror,
+                             state->port, sb16_opl3_portio_list_mirror,
+                             state, "sb16-opl3-mirror");
+}
+
=20
 static void sb16_initfn (Object *obj)
 {
@@ -1437,6 +1594,8 @@ static void sb16_realizefn (DeviceState *dev, Error **e=
rrp)
     isa_register_portio_list(isadev, &s->portio_list, s->port,
                              sb16_ioport_list, s, "sb16");
=20
+    sb16_opl3_realize(s, isadev);
+
     k =3D ISADMA_GET_CLASS(s->isa_hdma);
     k->register_channel(s->isa_hdma, s->hdma, SB_read_DMA, s);
=20
@@ -1446,6 +1605,12 @@ static void sb16_realizefn (DeviceState *dev, Error **=
errp)
     s->can_write =3D 1;
 }
=20
+static void sb16_finalizefn(Object *obj)
+{
+    SB16State *state =3D SB16(obj);
+    g_free(state->opl3_mix_buffer);
+}
+
 static const Property sb16_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(SB16State, audio_be),
     DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
@@ -1467,11 +1632,12 @@ static void sb16_class_initfn(ObjectClass *klass, con=
st void *data)
 }
=20
 static const TypeInfo sb16_info =3D {
-    .name          =3D TYPE_SB16,
-    .parent        =3D TYPE_ISA_DEVICE,
-    .instance_size =3D sizeof (SB16State),
-    .instance_init =3D sb16_initfn,
-    .class_init    =3D sb16_class_initfn,
+    .name              =3D TYPE_SB16,
+    .parent            =3D TYPE_ISA_DEVICE,
+    .instance_size     =3D sizeof(SB16State),
+    .instance_init     =3D sb16_initfn,
+    .instance_finalize =3D sb16_finalizefn,
+    .class_init        =3D sb16_class_initfn,
 };
=20
 static void sb16_register_types (void)
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 43f83ffd3a..734132fb08 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -92,7 +92,7 @@ qtests_i386 =3D \
   (config_all_devices.has_key('CONFIG_VIRTIO_SCSI') ? ['fuzz-virtio-scsi-tes=
t'] : []) +     \
   (config_all_devices.has_key('CONFIG_VIRTIO_BALLOON') ? ['virtio-balloon-te=
st'] : []) + \
   (config_all_devices.has_key('CONFIG_Q35') ? ['q35-test'] : []) +          =
                \
-  (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +   =
                \
+  (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test','sb16-opl3-=
test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : [=
]) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) + =
                \
   (config_all_devices.has_key('CONFIG_VTD') ? ['intel-iommu-test'] : []) +  =
               \
diff --git a/tests/qtest/sb16-opl3-test.c b/tests/qtest/sb16-opl3-test.c
new file mode 100644
index 0000000000..debd47e0ed
--- /dev/null
+++ b/tests/qtest/sb16-opl3-test.c
@@ -0,0 +1,45 @@
+/*
+ * QTest integration for SB16 OPL3.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+static void test_opl3_basic(void)
+{
+    QTestState *s =3D qtest_init("-M pc "
+                               "-device sb16,audiodev=3Dsnd0 "
+                               "-audiodev none,id=3Dsnd0");
+
+    g_assert_cmpuint(qtest_inb(s, 0x388), =3D=3D, 0x00);
+    g_assert_cmpuint(qtest_inb(s, 0x220), =3D=3D, 0x00);
+
+    qtest_outb(s, 0x388, 0x04);
+
+    /* Start Timer 1 unmasked */
+    qtest_outb(s, 0x389, 0x21);
+    g_assert_cmpuint(qtest_inb(s, 0x388), =3D=3D, 0xC0);
+
+    /* IRQ reset (ctrl =3D 0x80) clears the status byte. */
+    qtest_outb(s, 0x389, 0x80);
+    g_assert_cmpuint(qtest_inb(s, 0x388), =3D=3D, 0x00);
+
+    /* Start Timer 2 unmasked */
+    qtest_outb(s, 0x389, 0x42);
+    g_assert_cmpuint(qtest_inb(s, 0x388), =3D=3D, 0xA0);
+
+    /* Mirror access at SB16 base (default 0x220). */
+    g_assert_cmpuint(qtest_inb(s, 0x220), =3D=3D, 0xA0);
+
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    if (qtest_has_machine("pc")) {
+        qtest_add_func("sb16-opl3/basic", test_opl3_basic);
+    }
+    return g_test_run();
+}
--=20
2.49.1

