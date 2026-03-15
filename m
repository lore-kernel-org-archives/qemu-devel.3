Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697DCF30282
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ruF-0006N8-14; Sun, 15 Mar 2026 16:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1rtz-0006Kj-M0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:31 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1rtT-0002LX-Jt
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 173CAC015D;
 Sun, 15 Mar 2026 23:16:58 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uGRM4I1ATSw0-x7KRZieK; Sun, 15 Mar 2026 23:16:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605817;
 bh=xju9CfSPT1DfYBW2oFrwhc0C2Ax+iiriDHMYm76fAYo=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=fXMM/MQjWlcqP17HrrmPTqqPMvhyyZs9gQigs6Elz8sT7Z9ZyTQUFPDeEzaQ5tOT/
 KP5t5EYGYfNT0AJeodvkAj6XCYiChEvIOA2PWryuHUy43U6MEu1e98UdcJPR9Nhwn/
 LWIh7UNclqLU025maLwyc/LSdqyi/XQggZqRRrks=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH v3 04/11] hw/audio/pcspk: change PCSPK behaviour with
 --disable-audio
Date: Mon, 16 Mar 2026 01:16:39 +0500
Message-Id: <20260315201646.96862-5-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315201646.96862-1-heifetz@yandex-team.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/pcspk.c | 12 +++++++++++-
 hw/i386/pc.c     |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 6b826507ce3..54e18822651 100644
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
index addf602da08..8a4adee78e9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1599,8 +1599,10 @@ static void pc_machine_initfn(Object *obj)
 
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


