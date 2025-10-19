Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16044CCD1A4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAaYx-0007Mv-Ax; Sun, 19 Oct 2025 17:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaYv-0007Lt-7A
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:33 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaYt-0001zs-FX
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:32 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso2884731a12.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760907809; x=1761512609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYtLEyH2FfideJwdnFZ4JM8eULzVedauT+XtbsfYWyM=;
 b=O/0Onks4Q5sPZH9OaKbqChVK1t1GbJh+YfETYocDRJoM6mDM+Y5AfeYIQcM4kYqHOp
 kMvpujLQ1xYcrHGu34QOxCbpX4FvKkDx3bn/S50NEdrUqcMwAwYpyhMRv9BpSaLuKNni
 Gn5ftRLpCW25uLsevXMyE3zD2ACKRlkkZhRtJ3q/qeO6JVz2QuSlB6RAGHE0ErXRnfSl
 s2vO2ykgjPnhbrylX1+hphxEIll0QIRv1TNpmQL6VSCzON4nMIhcELJB1Aosnbekc7Iy
 fLKp7lRAHIYi+S88OS+8ojv/1hMXXoHFsEbePCorSEAZ7pJScAox5Xe5S134sJzaO5Or
 HVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760907809; x=1761512609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYtLEyH2FfideJwdnFZ4JM8eULzVedauT+XtbsfYWyM=;
 b=hBs2+5yaeRyWWC6ybK6C5Has0pN9NbKHYOuOkqJ3pj9EYgvT07zpzq85gg+8UX2NOy
 stvXoOAXYMBX3zm1a8rNq0KFtaytrhOfBG18IJJGMiXfrIw9rkO073m7N1M34DkHXJjS
 dkBKxGDGJZ+iwL+0eg1lrmQmSm4DukrAcsda3/6fDMPdzGoG0h1KUAENq2vY1CymIksp
 XiXZyR4ucMgZQRdu/rJfk9FnzkKKe4KaMl5HjO+ia2pwHc3UxTI/Ur3EIN/ipSyYww6c
 0G+rJnij8orj6dL76b3fkdAcxvSgrryr+b2HY/RXm8XLFzfMNiZXYOGfq8aXSAvsUcCY
 dj/g==
X-Gm-Message-State: AOJu0YycdfY6U5znuNN6Cr7ETu5inrVnSGEr7/xXrOKpBosjsI/j8OLV
 0pAl/y6ZmKr5GNbVNOXiotTK/0hNaQj5YykXd2Zf8vmek2fT90C2X0gChFx/YZBI
X-Gm-Gg: ASbGncvd9SnwRtv6fpFH1HqYOq/6ml6BWcrlrfki+E6malM4G45S/FV7/vJpfuJ4T7h
 0CUMWyPvFiilsMeUK9xRH/togXeOBvmNbFgMTj/fLGg73/4avrs23U19CcD6xbpMMQo22WSgjqv
 yiNOnL0sbwlcosYO9E2j0W9DiKfjxcleOXBCaGTiAtoD3gwRnAJtGxBH1EM1fxEDOvY7v5uE08U
 ojxLiITnOx6+LYKJQmy0+kQ5VzPbGCYW6dWzyfemRXfyrTzaNboLtATMQuWmOr+m8RcTmCWz0xn
 W8a2AEeNkNx2tVNs5nHhHSgNXLUHmPMSmaZGNqqURoOBM2XcUxeE9ixmV0btAJ0sP7uT8q4jeeR
 Ia+KadaatGV4pJuj8ZdVcK5iypT+jflQmQk6A2AZMa+lGag6sbq3CUEa9xlPAEs7sbCyZ7IClMw
 OJJaLRCRCzxVmL/EtsbliKvhuW6YSvnILHJsYYOVoNXqku+tdHQiSQweqwaA==
X-Google-Smtp-Source: AGHT+IGYnIE2LGluxdoaFLFcoZghgUMjydsnhpN1IFNQiDdS64MjZIRWB4CUyErfVctu0dYes/zOGQ==
X-Received: by 2002:aa7:d1c4:0:b0:633:14bb:dcb1 with SMTP id
 4fb4d7f45d1cf-63bfde71dc3mr10725278a12.11.1760907809154; 
 Sun, 19 Oct 2025 14:03:29 -0700 (PDT)
Received: from archlinux (dynamic-002-245-026-170.2.245.pool.telefonica.de.
 [2.245.26.170]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm5107655a12.27.2025.10.19.14.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 14:03:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 02/10] hw/audio/pcspk: Add I/O trace events
Date: Sun, 19 Oct 2025 23:02:55 +0200
Message-ID: <20251019210303.104718-3-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
References: <20251019210303.104718-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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


