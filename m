Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941D4CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 11:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ij4-0000nY-Pg; Fri, 17 Oct 2025 07:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9ij1-0000m2-FX
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:34:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9iil-0005zw-UM
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:34:22 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso5240345e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760700839; x=1761305639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYtLEyH2FfideJwdnFZ4JM8eULzVedauT+XtbsfYWyM=;
 b=HqAMVMMVlEl9cecj8OqQDncywfDO4bTAnsEKkUgCqITbV728ISx0bhzp1LYRMPJHcz
 raJ5dUCrxaxG7QQMi1iVPv/cVvl/ucguK5rBHz+XlLhv9pmVbUpiWZmWr1l54+klv+fz
 kD8NJRoP9Dru4jXKjoWTtXt7QRTt94eForGBY+fFVwr3xnmhb3W3rJ45GRl9A4v0o4uc
 vNaEsLkVZZcjPWZwcfrkxoUMNazRrNKeCB+wL7rKx2g4G64ChOJhcE64IDuLBy8YtYO/
 4qz2gl7Khsdo0zHm7mP9EBGTKl3h5gSYS/yHOrlC2WFZ8/e0FbDODgcHZ82/rySRByhq
 GIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760700839; x=1761305639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYtLEyH2FfideJwdnFZ4JM8eULzVedauT+XtbsfYWyM=;
 b=n3dHxQHOmU6me3Qn/TzE2QlU+Ci6T6AeZJBeblWOmXHtEn2aYN8ppMfjHecF0ePBB4
 PhNj0/wv2oBeWsCQllhMOUx/QD0M8e9abSSvHs3j6BTshkJqLhUANdxMDKXywccQKzqW
 S9tqndLmEhLUAewPNt1JLQ5/Qro2mBeO8LUasX0nzN+JU+hr3YKVmL2uUSXzBvHBp8IH
 3v7o59ntiGBY7F4ncNU00mcKJ5Dgd93KV4EWm7NaQkJvL1nxtLMdz4WkfzOMCJd+eBLm
 rfqbkK9cHReER12sLSx8PKflUFPjzba9mPlLI0JK+Wqtn7H3sKKL6Nm1Nv+hTMXy4sMI
 nMMg==
X-Gm-Message-State: AOJu0Yx/yFawrJ/5/gX3kmQwt00G2P2L54BqLpybpozeakSYK5HWqap/
 c4MNJmV7y99zWUNE4Aur0MKv6a+TrcuKpkc8k16lwvbd1I2vnxSYSPNN03A03A==
X-Gm-Gg: ASbGncs9Pu/nHyRwxUwa9uyHN5suC6ybeG0MCg2fEqC0W43hAc0KGMVRHJgV2rW3lqa
 Ro3FWXSeOP9lFXCPzlp4pAqJuu+LjIEFpekcpseCh/W+rz/QXLZFxEnOK3igzGJSmb0YEeDLfRo
 grDsKM1nfbkM11GkzpLJ/PbHFbbE9ix4Q7vjE/oZi1dOBbPLXYAYkkN906qPoV5fwtTq7hS9vJW
 YdNb5r9s7cLLcIFva+WHSAr62/guByw5KxeMu8+89Fe/SQd0mX+zva6DT9PRQn3TolfhlefG+vE
 cpWknHbyXWoKoG/iQ38thx6Dotgjzozt3cAau4LmWg4UUI8gWvkJFloFVJ8qNbijW1J8vcAgSC8
 TcnPx4CFnhM8dABxiKvbWwDVPxJXylV6dK0M8vsT55x05Bix7NFIiVZPk/tMwTUjt4V3sMFMddP
 tH5RIo1n2ac7iUvEYLqtK1wiGPayOH89OYhjdc/iyCObqB5OQ15SRdhw==
X-Google-Smtp-Source: AGHT+IEpC0YXq4lxNd0tPQVqaII3/WfItW0xvbTEycBAe8uupL4fpuonmWCOMkLkt2on9PH29+CgFA==
X-Received: by 2002:a05:600c:19d4:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47117907234mr29387625e9.19.1760700838815; 
 Fri, 17 Oct 2025 04:33:58 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711444c8adsm80395435e9.13.2025.10.17.04.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 04:33:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-trivial@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/8] hw/audio/pcspk: Add I/O trace events
Date: Fri, 17 Oct 2025 13:33:32 +0200
Message-ID: <20251017113338.7953-3-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017113338.7953-1-shentey@gmail.com>
References: <20251017113338.7953-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

Allows to see how the guest interacts with the device.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/audio/pcspk.c      | 10 +++++++++-
 hw/audio/trace-events |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a419161b5b..f8020593b0 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -34,6 +34,7 @@
 #include "hw/audio/pcspk.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "trace.h"
 
 #define PCSPK_BUF_LEN 1792
 #define PCSPK_SAMPLE_RATE 32000
@@ -137,13 +138,18 @@ static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
 {
     PCSpkState *s = opaque;
     PITChannelInfo ch;
+    uint8_t val;
 
     pit_get_channel_info(s->pit, 2, &ch);
 
     s->dummy_refresh_clock ^= (1 << 4);
 
-    return ch.gate | (s->data_on << 1) | s->dummy_refresh_clock |
+    val = ch.gate | (s->data_on << 1) | s->dummy_refresh_clock |
        (ch.out << 5);
+
+    trace_pcspk_io_read(s->iobase, val);
+
+    return val;
 }
 
 static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
@@ -152,6 +158,8 @@ static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
     PCSpkState *s = opaque;
     const int gate = val & 1;
 
+    trace_pcspk_io_write(s->iobase, val);
+
     s->data_on = (val >> 1) & 1;
     pit_set_gate(s->pit, 2, gate);
     if (s->voice) {
diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index b8ef572767..30f5921545 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -23,6 +23,10 @@ hda_audio_format(const char *stream, int chan, const char *fmt, int freq) "st %s
 hda_audio_adjust(const char *stream, int pos) "st %s, pos %d"
 hda_audio_overrun(const char *stream) "st %s"
 
+# pcspk.c
+pcspk_io_read(uint16_t addr, uint8_t val) "[0x%"PRIx16"] -> 0x%"PRIx8
+pcspk_io_write(uint16_t addr, uint8_t val) "[0x%"PRIx16"] <- 0x%"PRIx8
+
 #via-ac97.c
 via_ac97_codec_write(uint8_t addr, uint16_t val) "0x%x <- 0x%x"
 via_ac97_sgd_fetch(uint32_t curr, uint32_t addr, char stop, char eol, char flag, uint32_t len) "curr=0x%x addr=0x%x %c%c%c len=%d"
-- 
2.51.1.dirty


