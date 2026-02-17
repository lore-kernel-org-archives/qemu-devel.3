Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F31DE83857
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 05:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsDcq-0002c5-KX; Tue, 17 Feb 2026 00:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcm-0002ab-OS
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:52 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcj-0006cS-Mc
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:52 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A73C488503;
 Tue, 17 Feb 2026 08:27:46 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b54::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id eRRjrX2Ak0U0-no4eOMdv; 
 Tue, 17 Feb 2026 08:27:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771306066;
 bh=af12Emi/cCgStn/UwxBq6KWZOfBbIxl3KK7Jm000Jrw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=SURyeHnvSEZV/Cw7htk6hFT91JgzgDqGty7JuzLp0yo23bgQKQ/GC6TSqxHBQa7sW
 8NErywTjVtw+lamF6sbcnVHOCy1Vv8n9GTxMBHV/4nglxA7OchVUa10oepWVyOicHC
 aXyL7zoWJJn3lV4PJBMIWW+EnK+tMf02IJNihl7k=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 4/8] hw/audio/pcspk: change PCSPK behaviour with
 --disable-audio
Date: Tue, 17 Feb 2026 10:27:36 +0500
Message-Id: <20260217052740.114117-5-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217052740.114117-1-heifetz@yandex-team.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

PCSPK (PC Speaker) is an embedded audio device. We don't want it to use audio
when QEMU is configured with `--disable-audio`. This is achieved with minimal,
non-invasive changes to the code.

In essence, the changes ensure that PCSPK does not use the corresponding
audio backend, while functioning the same way in non-audio aspects.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 hw/audio/pcspk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 916c56fa4c..03fe816024 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -36,10 +36,12 @@
 #include "qom/object.h"
 #include "trace.h"
 
+#ifdef CONFIG_AUDIO
 #define PCSPK_BUF_LEN 1792
 #define PCSPK_SAMPLE_RATE 32000
 #define PCSPK_MAX_FREQ (PCSPK_SAMPLE_RATE >> 1)
 #define PCSPK_MIN_COUNT DIV_ROUND_UP(PIT_FREQ, PCSPK_MAX_FREQ)
+#endif
 
 OBJECT_DECLARE_SIMPLE_TYPE(PCSpkState, PC_SPEAKER)
 
@@ -48,18 +50,25 @@ struct PCSpkState {
 
     MemoryRegion ioport;
     uint32_t iobase;
+#ifdef CONFIG_AUDIO
     uint8_t sample_buf[PCSPK_BUF_LEN];
+#endif
     AudioBackend *audio_be;
+#ifdef CONFIG_AUDIO
     SWVoiceOut *voice;
+#endif
     PITCommonState *pit;
+#ifdef CONFIG_AUDIO
     unsigned int pit_count;
     unsigned int samples;
     unsigned int play_pos;
+#endif
     uint8_t data_on;
     uint8_t dummy_refresh_clock;
     bool migrate;
 };
 
+#ifdef CONFIG_AUDIO
 static const char *s_spk = "pcspk";
 
 static inline void generate_samples(PCSpkState *s)
@@ -131,6 +140,7 @@ static int pcspk_audio_init(PCSpkState *s)
 
     return 0;
 }
+#endif
 
 static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
                               unsigned size)
@@ -161,11 +171,13 @@ static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
 
     s->data_on = (val >> 1) & 1;
     pit_set_gate(s->pit, 2, gate);
+#ifdef CONFIG_AUDIO
     if (s->voice) {
         if (gate) /* restart */
             s->play_pos = 0;
         AUD_set_active_out(s->voice, gate & s->data_on);
     }
+#endif
 }
 
 static const MemoryRegionOps pcspk_io_ops = {
@@ -196,10 +208,12 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
+#ifdef CONFIG_AUDIO
     if (s->audio_be && AUD_backend_check(&s->audio_be, errp)) {
         pcspk_audio_init(s);
         return;
     }
+#endif
 }
 
 static bool migrate_needed(void *opaque)
-- 
2.34.1


