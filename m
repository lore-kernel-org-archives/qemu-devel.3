Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99584C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONA-00011N-5N; Tue, 01 Sep 2026 09:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON4-0000zY-88
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:50 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMz-00078f-Nr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:49 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c250c6a6a9aso749295366b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268664; x=1788873464; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P2MBWA2TMfgwFY+UVp3Avh31Z1wHTxd78goSFCjmXBc=;
 b=V1Hcj0PCyBJ8sp2MKTbqpfd+hjR/y4pvyHF5EseFA7z5ffp5nb2d6bKMHHIqhqNxIK
 iJuhDZ2pVrCXho4d6aUVFiotyCWAgaxtMHrZmp3lvttsF8Sk0IjSA/b9JfWtXOSi0xLp
 RPuEGx7NDEMJQNfqG3i/GPEsrbySEVIZPEHEr9K1AfMO/JUD2GOl3FTujpFWuikG4/A/
 jSekaCHcLxhBf2S6cokFkkEa5jF9xv7p0IXLH1ZWiNrz+yKXVl18DE6BO7enCTGhlJCN
 +UpCchEsGMxP+B2wNzgKBPESPHxiqe72cYfvBhDrV+AOUlGryHrzAHzoUU3sPuTbSbc6
 U/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268664; x=1788873464;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P2MBWA2TMfgwFY+UVp3Avh31Z1wHTxd78goSFCjmXBc=;
 b=ne0UM/RF6c5F51FV+NsyxslwkxHXQ6WxOtWgXSuYte0b/l2Km77o4DZKdbg2lZ/CNZ
 8C9Gsx6X987BnORIW/4FdIPu9uH9oUBJW/VKSKSAqNHZ86EQ0zAauSKEp2+ryGIk8l6F
 kyPdl7Zy/lFR9Eo7/HF/7Lg88W6nPCd2mFzLiY0VV/ZpfbA6CDky1YpBg4CsxoDF2JS1
 9Wwix5xnpXwD+dXf/EvZ6csv7s7KNZtgac5hoGsCIpu9rHZQSrSva2wwNxnhOvesmoWj
 LQjY5q7dU9SsoiUf5+LgmtsQc0Hdy0+uK5G+bV0LD1MvWBOoi3TLEqtT2T7+qb3m1Esc
 besQ==
X-Gm-Message-State: AFuF++lyfshxOekh6PtW7ol+6MEz2LOkCjk9FWh2pb1OM5SWf/9yKwyO
 rj4wNyspu72LDMp3uY3WZZQtQFy+tfn4k6YadrScuj9QczzTpzWOt/29XNaSx+MRAOqX99lVxeR
 mAZAoWW0=
X-Gm-Gg: AR+sD11WWJe3Kjp8FPGWSfH0Ey6RDWvbxEGSV8vNGEFGR2mY/HTg4HACfxnAWgKTbO1
 NOWce7rjFmQkC/lqG0Igl4gvyi9QVd+6Z4akIqPVaHN+m6LK6n1r24QebihwkZEABwPRVHmxvaT
 EjtZCXB4pEhHk93NtYPbIhQCECj3aGlApkTn4XkpgwDiUKxsJzTSW9jtRO/2TTRv4k5DATJBYOq
 Q5Yh+CbvvTVENtCzU70Soiat6npZzaTArJhpKhkKKs4c60P+gq8F1mNEi0HgpYNd91rJegykyVI
 1F47DCot7qI0YkVV3DGl4XWPI3AkuSb4KYYHxjbDAK7+rggIqxpr9cCLXl+i3H4NHLR5n1RfvV9
 b3gZ24dKJkXIExqeGSKpmzz4pgu0DTDdJVW+SFD2UGaF7a5HOQk7TSBm88gnXkzt3b6qUp0Tdci
 oVYYY2PYTwDPrRP3SIBrge6rABrDY9BH9SWWFS0tdcwDSuDjzBcBlWuXI622a1Fa2BrqR//3Sw8
 zbrE820H8N2l9hAdVyS3938orDGh9pYVZCbOAOxikEyhEqr2TCDlDxRzb/bmn307YEfkg==
X-Received: by 2002:a17:906:170b:b0:c24:d6f0:1223 with SMTP id
 a640c23a62f3a-c25b3cba78bmr438843766b.12.1788268663844; 
 Tue, 01 Sep 2026 06:17:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/58] hw/audio: Remove wm8750 I2C audio device
Date: Tue,  1 Sep 2026 14:16:43 +0100
Message-ID: <20260901131732.2263947-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The wm8750 audio I2C device was used only by the audio device on the
SoC used in the now-removed musicpal machine.  Since it has no users,
we can delete it entirely.

Although the wm8750 is an I2C device that could technically have been
created on the command line, it isn't possible to do this usefully
because the device only works when C code calls functions like
wm8750_data_req_set() and wm8750_dac_buffer().

This resolves the problem noted in issue #4135 that there's a buffer
overflow in the interaction between the marvell_88w8618 audio device
and the wm8750, by removing the offending code entirely.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4135
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Jan Kiszka <jan.kiszka@web.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260819185430.3467629-6-peter.maydell@linaro.org
---
 hw/audio/Kconfig          |   4 -
 hw/audio/meson.build      |   1 -
 hw/audio/wm8750.c         | 738 --------------------------------------
 include/hw/audio/wm8750.h |  30 --
 4 files changed, 773 deletions(-)
 delete mode 100644 hw/audio/wm8750.c
 delete mode 100644 include/hw/audio/wm8750.h

diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index daf060e1be0..ed93fa26984 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -38,10 +38,6 @@ config PCSPK
     default y
     depends on I8254
 
-config WM8750
-    bool
-    depends on I2C
-
 config PL041
     bool
 
diff --git a/hw/audio/meson.build b/hw/audio/meson.build
index c977679e23a..3312bcec101 100644
--- a/hw/audio/meson.build
+++ b/hw/audio/meson.build
@@ -11,6 +11,5 @@ system_ss.add(when: 'CONFIG_PCSPK', if_true: files('pcspk.c'))
 system_ss.add(when: 'CONFIG_PL041', if_true: files('pl041.c', 'lm4549.c'))
 system_ss.add(when: 'CONFIG_SB16', if_true: files('sb16.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('via-ac97.c'))
-system_ss.add(when: 'CONFIG_WM8750', if_true: files('wm8750.c'))
 system_ss.add(when: ['CONFIG_VIRTIO_SND', 'CONFIG_VIRTIO'], if_true: files('virtio-snd.c'))
 system_ss.add(when: ['CONFIG_VIRTIO_SND', 'CONFIG_VIRTIO', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-snd-pci.c'))
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
deleted file mode 100644
index e2507b0269a..00000000000
--- a/hw/audio/wm8750.c
+++ /dev/null
@@ -1,738 +0,0 @@
-/*
- * WM8750 audio CODEC.
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This file is licensed under GNU GPL.
- */
-
-#include "qemu/osdep.h"
-#include "hw/i2c/i2c.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
-#include "hw/audio/wm8750.h"
-#include "qemu/audio.h"
-#include "qom/object.h"
-
-#define IN_PORT_N	3
-#define OUT_PORT_N	3
-
-#define CODEC		"wm8750"
-
-typedef struct {
-    int adc;
-    int adc_hz;
-    int dac;
-    int dac_hz;
-} WMRate;
-
-OBJECT_DECLARE_SIMPLE_TYPE(WM8750State, WM8750)
-
-struct WM8750State {
-    I2CSlave parent_obj;
-
-    uint8_t i2c_data[2];
-    int i2c_len;
-    AudioBackend *audio_be;
-    SWVoiceIn *adc_voice[IN_PORT_N];
-    SWVoiceOut *dac_voice[OUT_PORT_N];
-    int enable;
-    void (*data_req)(void *, int, int);
-    void *opaque;
-    uint8_t data_in[4096];
-    uint8_t data_out[4096];
-    int idx_in, req_in;
-    int idx_out, req_out;
-
-    SWVoiceOut **out[2];
-    uint8_t outvol[7], outmute[2];
-    SWVoiceIn **in[2];
-    uint8_t invol[4], inmute[2];
-
-    uint8_t diff[2], pol, ds, monomix[2], alc, mute;
-    uint8_t path[4], mpath[2], power, format;
-    const WMRate *rate;
-    uint8_t rate_vmstate;
-    int adc_hz, dac_hz, ext_adc_hz, ext_dac_hz, master;
-};
-
-/* pow(10.0, -i / 20.0) * 255, i = 0..42 */
-static const uint8_t wm8750_vol_db_table[] = {
-    255, 227, 203, 181, 161, 143, 128, 114, 102, 90, 81, 72, 64, 57, 51, 45,
-    40, 36, 32, 29, 26, 23, 20, 18, 16, 14, 13, 11, 10, 9, 8, 7, 6, 6, 5, 5,
-    4, 4, 3, 3, 3, 2, 2
-};
-
-#define WM8750_OUTVOL_TRANSFORM(x)	wm8750_vol_db_table[(0x7f - x) / 3]
-#define WM8750_INVOL_TRANSFORM(x)	(x << 2)
-
-static inline void wm8750_in_load(WM8750State *s)
-{
-    if (s->idx_in + s->req_in <= sizeof(s->data_in))
-        return;
-    s->idx_in = MAX(0, (int) sizeof(s->data_in) - s->req_in);
-    audio_be_read(s->audio_be, *s->in[0], s->data_in + s->idx_in,
-             sizeof(s->data_in) - s->idx_in);
-}
-
-static inline void wm8750_out_flush(WM8750State *s)
-{
-    int sent = 0;
-    while (sent < s->idx_out)
-        sent += audio_be_write(s->audio_be, *s->out[0],
-                               s->data_out + sent, s->idx_out - sent)
-                ?: s->idx_out;
-    s->idx_out = 0;
-}
-
-static void wm8750_audio_in_cb(void *opaque, int avail_b)
-{
-    WM8750State *s = (WM8750State *) opaque;
-    s->req_in = avail_b;
-    s->data_req(s->opaque, s->req_out >> 2, avail_b >> 2);
-}
-
-static void wm8750_audio_out_cb(void *opaque, int free_b)
-{
-    WM8750State *s = (WM8750State *) opaque;
-
-    if (s->idx_out >= free_b) {
-        s->idx_out = free_b;
-        s->req_out = 0;
-        wm8750_out_flush(s);
-    } else
-        s->req_out = free_b - s->idx_out;
-
-    s->data_req(s->opaque, s->req_out >> 2, s->req_in >> 2);
-}
-
-static const WMRate wm_rate_table[] = {
-    {  256, 48000,  256, 48000 },	/* SR: 00000 */
-    {  384, 48000,  384, 48000 },	/* SR: 00001 */
-    {  256, 48000, 1536,  8000 },	/* SR: 00010 */
-    {  384, 48000, 2304,  8000 },	/* SR: 00011 */
-    { 1536,  8000,  256, 48000 },	/* SR: 00100 */
-    { 2304,  8000,  384, 48000 },	/* SR: 00101 */
-    { 1536,  8000, 1536,  8000 },	/* SR: 00110 */
-    { 2304,  8000, 2304,  8000 },	/* SR: 00111 */
-    { 1024, 12000, 1024, 12000 },	/* SR: 01000 */
-    { 1526, 12000, 1536, 12000 },	/* SR: 01001 */
-    {  768, 16000,  768, 16000 },	/* SR: 01010 */
-    { 1152, 16000, 1152, 16000 },	/* SR: 01011 */
-    {  384, 32000,  384, 32000 },	/* SR: 01100 */
-    {  576, 32000,  576, 32000 },	/* SR: 01101 */
-    {  128, 96000,  128, 96000 },	/* SR: 01110 */
-    {  192, 96000,  192, 96000 },	/* SR: 01111 */
-    {  256, 44100,  256, 44100 },	/* SR: 10000 */
-    {  384, 44100,  384, 44100 },	/* SR: 10001 */
-    {  256, 44100, 1408,  8018 },	/* SR: 10010 */
-    {  384, 44100, 2112,  8018 },	/* SR: 10011 */
-    { 1408,  8018,  256, 44100 },	/* SR: 10100 */
-    { 2112,  8018,  384, 44100 },	/* SR: 10101 */
-    { 1408,  8018, 1408,  8018 },	/* SR: 10110 */
-    { 2112,  8018, 2112,  8018 },	/* SR: 10111 */
-    { 1024, 11025, 1024, 11025 },	/* SR: 11000 */
-    { 1536, 11025, 1536, 11025 },	/* SR: 11001 */
-    {  512, 22050,  512, 22050 },	/* SR: 11010 */
-    {  768, 22050,  768, 22050 },	/* SR: 11011 */
-    {  512, 24000,  512, 24000 },	/* SR: 11100 */
-    {  768, 24000,  768, 24000 },	/* SR: 11101 */
-    {  128, 88200,  128, 88200 },	/* SR: 11110 */
-    {  192, 88200,  192, 88200 },	/* SR: 11111 */
-};
-
-static void wm8750_vol_update(WM8750State *s)
-{
-    /* FIXME: multiply all volumes by s->invol[2], s->invol[3] */
-
-    audio_be_set_volume_in_lr(s->audio_be, s->adc_voice[0], s->mute,
-                    s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
-                    s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
-    audio_be_set_volume_in_lr(s->audio_be, s->adc_voice[1], s->mute,
-                    s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
-                    s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
-    audio_be_set_volume_in_lr(s->audio_be, s->adc_voice[2], s->mute,
-                    s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
-                    s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
-
-    /* FIXME: multiply all volumes by s->outvol[0], s->outvol[1] */
-
-    /* Speaker: LOUT2VOL ROUT2VOL */
-    audio_be_set_volume_out_lr(s->audio_be, s->dac_voice[0], s->mute,
-                    s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[4]),
-                    s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[5]));
-
-    /* Headphone: LOUT1VOL ROUT1VOL */
-    audio_be_set_volume_out_lr(s->audio_be, s->dac_voice[1], s->mute,
-                    s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[2]),
-                    s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[3]));
-
-    /* MONOOUT: MONOVOL MONOVOL */
-    audio_be_set_volume_out_lr(s->audio_be, s->dac_voice[2], s->mute,
-                    s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]),
-                    s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]));
-}
-
-static void wm8750_set_format(WM8750State *s)
-{
-    int i;
-    struct audsettings in_fmt;
-    struct audsettings out_fmt;
-
-    wm8750_out_flush(s);
-
-    if (s->in[0] && *s->in[0])
-        audio_be_set_active_in(s->audio_be, *s->in[0], 0);
-    if (s->out[0] && *s->out[0])
-        audio_be_set_active_out(s->audio_be, *s->out[0], 0);
-
-    for (i = 0; i < IN_PORT_N; i ++)
-        if (s->adc_voice[i]) {
-            audio_be_close_in(s->audio_be, s->adc_voice[i]);
-            s->adc_voice[i] = NULL;
-        }
-    for (i = 0; i < OUT_PORT_N; i ++)
-        if (s->dac_voice[i]) {
-            audio_be_close_out(s->audio_be, s->dac_voice[i]);
-            s->dac_voice[i] = NULL;
-        }
-
-    if (!s->enable)
-        return;
-
-    /* Setup input */
-    in_fmt.big_endian = false;
-    in_fmt.nchannels = 2;
-    in_fmt.freq = s->adc_hz;
-    in_fmt.fmt = AUDIO_FORMAT_S16;
-
-    s->adc_voice[0] = audio_be_open_in(s->audio_be, s->adc_voice[0],
-                    CODEC ".input1", s, wm8750_audio_in_cb, &in_fmt);
-    s->adc_voice[1] = audio_be_open_in(s->audio_be, s->adc_voice[1],
-                    CODEC ".input2", s, wm8750_audio_in_cb, &in_fmt);
-    s->adc_voice[2] = audio_be_open_in(s->audio_be, s->adc_voice[2],
-                    CODEC ".input3", s, wm8750_audio_in_cb, &in_fmt);
-
-    /* Setup output */
-    out_fmt.big_endian = false;
-    out_fmt.nchannels = 2;
-    out_fmt.freq = s->dac_hz;
-    out_fmt.fmt = AUDIO_FORMAT_S16;
-
-    s->dac_voice[0] = audio_be_open_out(s->audio_be, s->dac_voice[0],
-                    CODEC ".speaker", s, wm8750_audio_out_cb, &out_fmt);
-    s->dac_voice[1] = audio_be_open_out(s->audio_be, s->dac_voice[1],
-                    CODEC ".headphone", s, wm8750_audio_out_cb, &out_fmt);
-    /* MONOMIX is also in stereo for simplicity */
-    s->dac_voice[2] = audio_be_open_out(s->audio_be, s->dac_voice[2],
-                    CODEC ".monomix", s, wm8750_audio_out_cb, &out_fmt);
-    /* no sense emulating OUT3 which is a mix of other outputs */
-
-    wm8750_vol_update(s);
-
-    /* We should connect the left and right channels to their
-     * respective inputs/outputs but we have completely no need
-     * for mixing or combining paths to different ports, so we
-     * connect both channels to where the left channel is routed.  */
-    if (s->in[0] && *s->in[0])
-        audio_be_set_active_in(s->audio_be, *s->in[0], 1);
-    if (s->out[0] && *s->out[0])
-        audio_be_set_active_out(s->audio_be, *s->out[0], 1);
-}
-
-static void wm8750_clk_update(WM8750State *s, int ext)
-{
-    if (s->master || !s->ext_dac_hz)
-        s->dac_hz = s->rate->dac_hz;
-    else
-        s->dac_hz = s->ext_dac_hz;
-
-    if (s->master || !s->ext_adc_hz)
-        s->adc_hz = s->rate->adc_hz;
-    else
-        s->adc_hz = s->ext_adc_hz;
-
-    if (s->master || (!s->ext_dac_hz && !s->ext_adc_hz)) {
-        if (!ext)
-            wm8750_set_format(s);
-    } else {
-        if (ext)
-            wm8750_set_format(s);
-    }
-}
-
-static void wm8750_reset(I2CSlave *i2c)
-{
-    WM8750State *s = WM8750(i2c);
-
-    s->rate = &wm_rate_table[0];
-    s->enable = 0;
-    wm8750_clk_update(s, 1);
-    s->diff[0] = 0;
-    s->diff[1] = 0;
-    s->ds = 0;
-    s->alc = 0;
-    s->in[0] = &s->adc_voice[0];
-    s->invol[0] = 0x17;
-    s->invol[1] = 0x17;
-    s->invol[2] = 0xc3;
-    s->invol[3] = 0xc3;
-    s->out[0] = &s->dac_voice[0];
-    s->outvol[0] = 0xff;
-    s->outvol[1] = 0xff;
-    s->outvol[2] = 0x79;
-    s->outvol[3] = 0x79;
-    s->outvol[4] = 0x79;
-    s->outvol[5] = 0x79;
-    s->outvol[6] = 0x79;
-    s->inmute[0] = 0;
-    s->inmute[1] = 0;
-    s->outmute[0] = 0;
-    s->outmute[1] = 0;
-    s->mute = 1;
-    s->path[0] = 0;
-    s->path[1] = 0;
-    s->path[2] = 0;
-    s->path[3] = 0;
-    s->mpath[0] = 0;
-    s->mpath[1] = 0;
-    s->format = 0x0a;
-    s->idx_in = sizeof(s->data_in);
-    s->req_in = 0;
-    s->idx_out = 0;
-    s->req_out = 0;
-    wm8750_vol_update(s);
-    s->i2c_len = 0;
-}
-
-static int wm8750_event(I2CSlave *i2c, enum i2c_event event)
-{
-    WM8750State *s = WM8750(i2c);
-
-    switch (event) {
-    case I2C_START_SEND:
-        s->i2c_len = 0;
-        break;
-    case I2C_FINISH:
-#ifdef VERBOSE
-        if (s->i2c_len < 2)
-            printf("%s: message too short (%i bytes)\n",
-                            __func__, s->i2c_len);
-#endif
-        break;
-    default:
-        break;
-    }
-
-    return 0;
-}
-
-#define WM8750_LINVOL	0x00
-#define WM8750_RINVOL	0x01
-#define WM8750_LOUT1V	0x02
-#define WM8750_ROUT1V	0x03
-#define WM8750_ADCDAC	0x05
-#define WM8750_IFACE	0x07
-#define WM8750_SRATE	0x08
-#define WM8750_LDAC	0x0a
-#define WM8750_RDAC	0x0b
-#define WM8750_BASS	0x0c
-#define WM8750_TREBLE	0x0d
-#define WM8750_RESET	0x0f
-#define WM8750_3D	0x10
-#define WM8750_ALC1	0x11
-#define WM8750_ALC2	0x12
-#define WM8750_ALC3	0x13
-#define WM8750_NGATE	0x14
-#define WM8750_LADC	0x15
-#define WM8750_RADC	0x16
-#define WM8750_ADCTL1	0x17
-#define WM8750_ADCTL2	0x18
-#define WM8750_PWR1	0x19
-#define WM8750_PWR2	0x1a
-#define WM8750_ADCTL3	0x1b
-#define WM8750_ADCIN	0x1f
-#define WM8750_LADCIN	0x20
-#define WM8750_RADCIN	0x21
-#define WM8750_LOUTM1	0x22
-#define WM8750_LOUTM2	0x23
-#define WM8750_ROUTM1	0x24
-#define WM8750_ROUTM2	0x25
-#define WM8750_MOUTM1	0x26
-#define WM8750_MOUTM2	0x27
-#define WM8750_LOUT2V	0x28
-#define WM8750_ROUT2V	0x29
-#define WM8750_MOUTV	0x2a
-
-static int wm8750_tx(I2CSlave *i2c, uint8_t data)
-{
-    WM8750State *s = WM8750(i2c);
-    uint8_t cmd;
-    uint16_t value;
-
-    if (s->i2c_len >= 2) {
-#ifdef VERBOSE
-        printf("%s: long message (%i bytes)\n", __func__, s->i2c_len);
-#endif
-        return 1;
-    }
-    s->i2c_data[s->i2c_len ++] = data;
-    if (s->i2c_len != 2)
-        return 0;
-
-    cmd = s->i2c_data[0] >> 1;
-    value = ((s->i2c_data[0] << 8) | s->i2c_data[1]) & 0x1ff;
-
-    switch (cmd) {
-    case WM8750_LADCIN:	/* ADC Signal Path Control (Left) */
-        s->diff[0] = (((value >> 6) & 3) == 3);	/* LINSEL */
-        if (s->diff[0])
-            s->in[0] = &s->adc_voice[0 + s->ds * 1];
-        else
-            s->in[0] = &s->adc_voice[((value >> 6) & 3) * 1 + 0];
-        break;
-
-    case WM8750_RADCIN:	/* ADC Signal Path Control (Right) */
-        s->diff[1] = (((value >> 6) & 3) == 3);	/* RINSEL */
-        if (s->diff[1])
-            s->in[1] = &s->adc_voice[0 + s->ds * 1];
-        else
-            s->in[1] = &s->adc_voice[((value >> 6) & 3) * 1 + 0];
-        break;
-
-    case WM8750_ADCIN:	/* ADC Input Mode */
-        s->ds = (value >> 8) & 1;	/* DS */
-        if (s->diff[0])
-            s->in[0] = &s->adc_voice[0 + s->ds * 1];
-        if (s->diff[1])
-            s->in[1] = &s->adc_voice[0 + s->ds * 1];
-        s->monomix[0] = (value >> 6) & 3;	/* MONOMIX */
-        break;
-
-    case WM8750_ADCTL1:	/* Additional Control (1) */
-        s->monomix[1] = (value >> 1) & 1;	/* DMONOMIX */
-        break;
-
-    case WM8750_PWR1:	/* Power Management (1) */
-        s->enable = ((value >> 6) & 7) == 3;	/* VMIDSEL, VREF */
-        wm8750_set_format(s);
-        break;
-
-    case WM8750_LINVOL:	/* Left Channel PGA */
-        s->invol[0] = value & 0x3f;		/* LINVOL */
-        s->inmute[0] = (value >> 7) & 1;	/* LINMUTE */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_RINVOL:	/* Right Channel PGA */
-        s->invol[1] = value & 0x3f;		/* RINVOL */
-        s->inmute[1] = (value >> 7) & 1;	/* RINMUTE */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_ADCDAC:	/* ADC and DAC Control */
-        s->pol = (value >> 5) & 3;		/* ADCPOL */
-        s->mute = (value >> 3) & 1;		/* DACMU */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_ADCTL3:	/* Additional Control (3) */
-        break;
-
-    case WM8750_LADC:	/* Left ADC Digital Volume */
-        s->invol[2] = value & 0xff;		/* LADCVOL */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_RADC:	/* Right ADC Digital Volume */
-        s->invol[3] = value & 0xff;		/* RADCVOL */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_ALC1:	/* ALC Control (1) */
-        s->alc = (value >> 7) & 3;		/* ALCSEL */
-        break;
-
-    case WM8750_NGATE:	/* Noise Gate Control */
-    case WM8750_3D:	/* 3D enhance */
-        break;
-
-    case WM8750_LDAC:	/* Left Channel Digital Volume */
-        s->outvol[0] = value & 0xff;		/* LDACVOL */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_RDAC:	/* Right Channel Digital Volume */
-        s->outvol[1] = value & 0xff;		/* RDACVOL */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_BASS:	/* Bass Control */
-        break;
-
-    case WM8750_LOUTM1:	/* Left Mixer Control (1) */
-        s->path[0] = (value >> 8) & 1;		/* LD2LO */
-        /* TODO: mute/unmute respective paths */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_LOUTM2:	/* Left Mixer Control (2) */
-        s->path[1] = (value >> 8) & 1;		/* RD2LO */
-        /* TODO: mute/unmute respective paths */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_ROUTM1:	/* Right Mixer Control (1) */
-        s->path[2] = (value >> 8) & 1;		/* LD2RO */
-        /* TODO: mute/unmute respective paths */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_ROUTM2:	/* Right Mixer Control (2) */
-        s->path[3] = (value >> 8) & 1;		/* RD2RO */
-        /* TODO: mute/unmute respective paths */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_MOUTM1:	/* Mono Mixer Control (1) */
-        s->mpath[0] = (value >> 8) & 1;		/* LD2MO */
-        /* TODO: mute/unmute respective paths */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_MOUTM2:	/* Mono Mixer Control (2) */
-        s->mpath[1] = (value >> 8) & 1;		/* RD2MO */
-        /* TODO: mute/unmute respective paths */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_LOUT1V:	/* LOUT1 Volume */
-        s->outvol[2] = value & 0x7f;		/* LOUT1VOL */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_LOUT2V:	/* LOUT2 Volume */
-        s->outvol[4] = value & 0x7f;		/* LOUT2VOL */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_ROUT1V:	/* ROUT1 Volume */
-        s->outvol[3] = value & 0x7f;		/* ROUT1VOL */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_ROUT2V:	/* ROUT2 Volume */
-        s->outvol[5] = value & 0x7f;		/* ROUT2VOL */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_MOUTV:	/* MONOOUT Volume */
-        s->outvol[6] = value & 0x7f;		/* MONOOUTVOL */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_ADCTL2:	/* Additional Control (2) */
-        break;
-
-    case WM8750_PWR2:	/* Power Management (2) */
-        s->power = value & 0x7e;
-        /* TODO: mute/unmute respective paths */
-        wm8750_vol_update(s);
-        break;
-
-    case WM8750_IFACE:	/* Digital Audio Interface Format */
-        s->format = value;
-        s->master = (value >> 6) & 1;			/* MS */
-        wm8750_clk_update(s, s->master);
-        break;
-
-    case WM8750_SRATE:	/* Clocking and Sample Rate Control */
-        s->rate = &wm_rate_table[(value >> 1) & 0x1f];
-        wm8750_clk_update(s, 0);
-        break;
-
-    case WM8750_RESET:	/* Reset */
-        wm8750_reset(I2C_SLAVE(s));
-        break;
-
-#ifdef VERBOSE
-    default:
-        printf("%s: unknown register %02x\n", __func__, cmd);
-#endif
-    }
-
-    return 0;
-}
-
-static uint8_t wm8750_rx(I2CSlave *i2c)
-{
-    return 0x00;
-}
-
-static int wm8750_pre_save(void *opaque)
-{
-    WM8750State *s = opaque;
-
-    s->rate_vmstate = s->rate - wm_rate_table;
-
-    return 0;
-}
-
-static int wm8750_post_load(void *opaque, int version_id)
-{
-    WM8750State *s = opaque;
-
-    s->rate = &wm_rate_table[s->rate_vmstate & 0x1f];
-    return 0;
-}
-
-static const VMStateDescription vmstate_wm8750 = {
-    .name = CODEC,
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .pre_save = wm8750_pre_save,
-    .post_load = wm8750_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(i2c_data, WM8750State, 2),
-        VMSTATE_INT32(i2c_len, WM8750State),
-        VMSTATE_INT32(enable, WM8750State),
-        VMSTATE_INT32(idx_in, WM8750State),
-        VMSTATE_INT32(req_in, WM8750State),
-        VMSTATE_INT32(idx_out, WM8750State),
-        VMSTATE_INT32(req_out, WM8750State),
-        VMSTATE_UINT8_ARRAY(outvol, WM8750State, 7),
-        VMSTATE_UINT8_ARRAY(outmute, WM8750State, 2),
-        VMSTATE_UINT8_ARRAY(invol, WM8750State, 4),
-        VMSTATE_UINT8_ARRAY(inmute, WM8750State, 2),
-        VMSTATE_UINT8_ARRAY(diff, WM8750State, 2),
-        VMSTATE_UINT8(pol, WM8750State),
-        VMSTATE_UINT8(ds, WM8750State),
-        VMSTATE_UINT8_ARRAY(monomix, WM8750State, 2),
-        VMSTATE_UINT8(alc, WM8750State),
-        VMSTATE_UINT8(mute, WM8750State),
-        VMSTATE_UINT8_ARRAY(path, WM8750State, 4),
-        VMSTATE_UINT8_ARRAY(mpath, WM8750State, 2),
-        VMSTATE_UINT8(format, WM8750State),
-        VMSTATE_UINT8(power, WM8750State),
-        VMSTATE_UINT8(rate_vmstate, WM8750State),
-        VMSTATE_I2C_SLAVE(parent_obj, WM8750State),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void wm8750_realize(DeviceState *dev, Error **errp)
-{
-    WM8750State *s = WM8750(dev);
-
-    if (!audio_be_check(&s->audio_be, errp)) {
-        return;
-    }
-
-    wm8750_reset(I2C_SLAVE(s));
-}
-
-#if 0
-static void wm8750_fini(I2CSlave *i2c)
-{
-    WM8750State *s = WM8750(i2c);
-
-    wm8750_reset(I2C_SLAVE(s));
-    g_free(s);
-}
-#endif
-
-void wm8750_data_req_set(DeviceState *dev, data_req_cb *data_req, void *opaque)
-{
-    WM8750State *s = WM8750(dev);
-
-    s->data_req = data_req;
-    s->opaque = opaque;
-}
-
-void wm8750_dac_dat(void *opaque, uint32_t sample)
-{
-    WM8750State *s = (WM8750State *) opaque;
-
-    *(uint32_t *) &s->data_out[s->idx_out] = sample;
-    s->req_out -= 4;
-    s->idx_out += 4;
-    if (s->idx_out >= sizeof(s->data_out) || s->req_out <= 0)
-        wm8750_out_flush(s);
-}
-
-void *wm8750_dac_buffer(void *opaque, int samples)
-{
-    WM8750State *s = (WM8750State *) opaque;
-    /* XXX: Should check if there are <i>samples</i> free samples available */
-    void *ret = s->data_out + s->idx_out;
-
-    s->idx_out += samples << 2;
-    s->req_out -= samples << 2;
-    return ret;
-}
-
-void wm8750_dac_commit(void *opaque)
-{
-    WM8750State *s = (WM8750State *) opaque;
-
-    wm8750_out_flush(s);
-}
-
-uint32_t wm8750_adc_dat(void *opaque)
-{
-    WM8750State *s = (WM8750State *) opaque;
-    uint32_t *data;
-
-    if (s->idx_in >= sizeof(s->data_in)) {
-        wm8750_in_load(s);
-        if (s->idx_in >= sizeof(s->data_in)) {
-            return 0x80008000; /* silence in AUDIO_FORMAT_S16 sample format */
-        }
-    }
-
-    data = (uint32_t *) &s->data_in[s->idx_in];
-    s->req_in -= 4;
-    s->idx_in += 4;
-    return *data;
-}
-
-void wm8750_set_bclk_in(void *opaque, int new_hz)
-{
-    WM8750State *s = (WM8750State *) opaque;
-
-    s->ext_adc_hz = new_hz;
-    s->ext_dac_hz = new_hz;
-    wm8750_clk_update(s, 1);
-}
-
-static const Property wm8750_properties[] = {
-    DEFINE_AUDIO_PROPERTIES(WM8750State, audio_be),
-};
-
-static void wm8750_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
-
-    dc->realize = wm8750_realize;
-    sc->event = wm8750_event;
-    sc->recv = wm8750_rx;
-    sc->send = wm8750_tx;
-    dc->vmsd = &vmstate_wm8750;
-    device_class_set_props(dc, wm8750_properties);
-}
-
-static const TypeInfo wm8750_info = {
-    .name          = TYPE_WM8750,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(WM8750State),
-    .class_init    = wm8750_class_init,
-};
-
-static void wm8750_register_types(void)
-{
-    type_register_static(&wm8750_info);
-}
-
-type_init(wm8750_register_types)
diff --git a/include/hw/audio/wm8750.h b/include/hw/audio/wm8750.h
deleted file mode 100644
index f7bafd5e384..00000000000
--- a/include/hw/audio/wm8750.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2 or later, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef HW_DAC_WM8750_H
-#define HW_DAC_WM8750_H
-
-
-#define TYPE_WM8750 "wm8750"
-#define TYPE_MV88W8618_AUDIO "mv88w8618_audio"
-
-typedef void data_req_cb(void *opaque, int free_out, int free_in);
-
-void wm8750_data_req_set(DeviceState *dev, data_req_cb *data_req, void *opaque);
-void wm8750_dac_dat(void *opaque, uint32_t sample);
-uint32_t wm8750_adc_dat(void *opaque);
-void *wm8750_dac_buffer(void *opaque, int samples);
-void wm8750_dac_commit(void *opaque);
-void wm8750_set_bclk_in(void *opaque, int new_hz);
-
-#endif
-- 
2.43.0


