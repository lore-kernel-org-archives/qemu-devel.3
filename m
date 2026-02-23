Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55B3EC1130
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucV9-0003Zm-PL; Mon, 23 Feb 2026 15:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUp-0003A6-3Z
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:37 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vucUi-0002Or-Qj
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:25:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2918B8E413;
 Mon, 23 Feb 2026 23:25:24 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:12d::1:2c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id CPmvPN6Ap8c0-rY4DI9og; 
 Mon, 23 Feb 2026 23:25:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771878323;
 bh=Yq0CWubq2cVL00aDsB6wDvjl/NGJ8QzW3ZUX45lNfyg=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lXJxtGdHcQuI9mHVb6hc1whmnGTlx8g1IBAHkB+6ZKItvYNLC8/HrdOnXLIt6zL2V
 xNdGGBqp8UqTkPrWyhJSxi7lB7dB3X4wzAizfEj0bXrAuJXPxTd3rgUk/u/T/t86mJ
 3WbpgSDtONUUmQsZg2OUneN+5IdkIgEISjS83WbY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 04/10] hw/audio/pcspk: change PCSPK behaviour with
 --disable-audio
Date: Tue, 24 Feb 2026 01:25:06 +0500
Message-Id: <20260223202512.1308205-5-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223202512.1308205-1-heifetz@yandex-team.com>
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

PCSPK (PC Speaker) is an embedded audio device. We don't want it to use audio
when QEMU is configured with `--disable-audio`. This is achieved with minimal,
non-invasive changes to the code.

In essence, the changes ensure that PCSPK does not have a corresponding
audio backend, while functioning the same way in non-audio aspects.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 hw/audio/pcspk.c | 12 +++++++++++-
 hw/i386/pc.c     |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 6b826507ce..54e1882265 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -48,17 +48,20 @@ struct PCSpkState {
 
     MemoryRegion ioport;
     uint32_t iobase;
+    PITCommonState *pit;
+#ifdef CONFIG_AUDIO
     uint8_t sample_buf[PCSPK_BUF_LEN];
     AudioBackend *audio_be;
     SWVoiceOut *voice;
-    PITCommonState *pit;
     unsigned int pit_count;
     unsigned int samples;
     unsigned int play_pos;
+#endif
     uint8_t data_on;
     uint8_t dummy_refresh_clock;
 };
 
+#ifdef CONFIG_AUDIO
 static const char *s_spk = "pcspk";
 
 static inline void generate_samples(PCSpkState *s)
@@ -130,6 +133,7 @@ static int pcspk_audio_init(PCSpkState *s)
 
     return 0;
 }
+#endif
 
 static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
                               unsigned size)
@@ -160,11 +164,13 @@ static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
 
     s->data_on = (val >> 1) & 1;
     pit_set_gate(s->pit, 2, gate);
+#ifdef CONFIG_AUDIO
     if (s->voice) {
         if (gate) /* restart */
             s->play_pos = 0;
         audio_be_set_active_out(s->audio_be, s->voice, gate & s->data_on);
     }
+#endif
 }
 
 static const MemoryRegionOps pcspk_io_ops = {
@@ -195,10 +201,12 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
+#ifdef CONFIG_AUDIO
     if (s->audio_be && audio_be_check(&s->audio_be, errp)) {
         pcspk_audio_init(s);
         return;
     }
+#endif
 }
 
 static const VMStateDescription vmstate_spk = {
@@ -213,7 +221,9 @@ static const VMStateDescription vmstate_spk = {
 };
 
 static const Property pcspk_properties[] = {
+#ifdef CONFIG_AUDIO
     DEFINE_AUDIO_PROPERTIES(PCSpkState, audio_be),
+#endif
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
     DEFINE_PROP_LINK("pit", PCSpkState, pit, TYPE_PIT_COMMON, PITCommonState *),
 };
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0dd3fd01d9..3992553c2a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1679,8 +1679,10 @@ static void pc_machine_initfn(Object *obj)
 
     pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
+#ifdef CONFIG_AUDIO
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
+#endif
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
-- 
2.34.1


