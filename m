Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CD5CCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAaYv-0007Lr-3k; Sun, 19 Oct 2025 17:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaYt-0007KR-BL
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaYr-0001zM-KD
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:31 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b00a9989633so798408466b.0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760907808; x=1761512608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFuBYoXthwAAHQXYSal9xNPgZEHCC/OlTSTKqa/XfA4=;
 b=Y+dJ/NoYKu1+YDTuh7hko2Yt16HlbL7+2PPK2ONhEYLniqYtt6QFAvuK8TjlV7BMPy
 hGJQINtMMs/0ghYiyil2bo9KRspxnT+0QiHYOIG/rtPzAFyiiLJ7A/KUGTmC4iiNQlza
 ZbK9Np+FkkEJ+5D3ivgQWJ+LaPcJAv/7XDUSJLsQ7GL6UdUdACcxvCO5Y0ZXDjJ/XV+x
 sPF4WrlXK7B0lFnCmt8o+ShMyd4uZhfZu/hr/eet1KJptAUu2LGwZt73mKUfgAy5UJ1v
 hMqp5ApNHk1U7eb9E9JH9LJHUcB83h0aNWE5dvF9e7pTI3wWv3qfsI4f5fnqNeIw630i
 8qbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760907808; x=1761512608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFuBYoXthwAAHQXYSal9xNPgZEHCC/OlTSTKqa/XfA4=;
 b=Rl9J7+iisjwJEGNKkOJ+6GSMojsy+oNpVjfIyy2LPp4fMf9F80qMclBN4yrasZ/1BN
 hdZb08JGf6nUmvE1xOpMRBeMVjaxF2sYQwierCPkgZKYr7GzBhTKA2OU+MqIqr57ptpE
 AYfidIeiidZIKlUp9rKT9V6n5NEVIK6+sFfBtGHVqXEpIOsrCiyXtvP3K6zoEYgjQQ1q
 ytoXend9E9ldmCJsCy/chlZHzBcaSZKquRBKppLQPRk7KGOkWwudXFTPwojf//dGJFod
 mNugfVXWVBmlRpr13IMsVEgpi1FqOyZc07EqtGvAx8oRofi8CJiLHkNe9bpRcQ6WSmI4
 P2fQ==
X-Gm-Message-State: AOJu0YxaNTyhvT9g1T5l7rcLelpnvjFpCklwhEMJRKOmdu28DfNinXmt
 z2NRRZUWTajQu5ehJMjzuPkUqpISot9WX4/vE3tNxPCkItQ7U01yVtrR4OPaJqC5
X-Gm-Gg: ASbGncuNRoXEuhOHoIPhihrUxC/VOnp6jzfrRDs08TMhal51FNnP7utPHn4pS8tXrJQ
 ecRrBMQrYVkYFWwZkMzmcauumbx4z09bdHDgqvVns2c4IwbP4p4jHLUWNTckOzsUavKRMAAWQRS
 NX37xNpd+AlJ/Gqv1SIIVbQKm1p4zoQQ3vdgqcm1Zdh2OcbwkhkZ8/DGRGzGGl7o4u/oXty+rQJ
 g+s5/x+1hxVb0hJ6YYxYXS2RD4A6Nz9fbfAbLfG1f9r9dQZTR3rWdqbvnCurV3u4rh3Gm2ztT0/
 vs7QJeXtTELRfBHTbu6rTIiP997nr3h4k/zYLOYXVpfsXMtFFRqdx3XoAnRrQycn+7N9OUeKSop
 d5J/gdiRc6eW1TNgGt7RPG6K3DAhQPb/cKdQOayw0EnUByvFZA0nTYNpc5MT17vEoXbpMqD/vqy
 V46w/mdFZ0+MszuWznHwC0IB+T8RNUk08Pb1iqti+ksrs5UopTSL2BvQ2ebA==
X-Google-Smtp-Source: AGHT+IEq801hCLtUohQJ3LOj0X3B+ZbYdyw4N64PsS7W265OlZV1xfYspqNnKezI+v90AM1dJWgHzw==
X-Received: by 2002:a17:907:3992:b0:b40:c49b:709 with SMTP id
 a640c23a62f3a-b605249d84dmr1777498366b.8.1760907807556; 
 Sun, 19 Oct 2025 14:03:27 -0700 (PDT)
Received: from archlinux (dynamic-002-245-026-170.2.245.pool.telefonica.de.
 [2.245.26.170]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm5107655a12.27.2025.10.19.14.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 14:03:26 -0700 (PDT)
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
Subject: [PATCH v3 01/10] hw/timer/i8254: Add I/O trace events
Date: Sun, 19 Oct 2025 23:02:54 +0200
Message-ID: <20251019210303.104718-2-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
References: <20251019210303.104718-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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
 hw/timer/i8254.c      | 6 ++++++
 hw/timer/trace-events | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 4b25c487f7..7033ebf50d 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -29,6 +29,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
 #include "qom/object.h"
+#include "trace.h"
 
 //#define DEBUG_PIT
 
@@ -130,6 +131,8 @@ static void pit_ioport_write(void *opaque, hwaddr addr,
     int channel, access;
     PITChannelState *s;
 
+    trace_pit_ioport_write(addr, val);
+
     addr &= 3;
     if (addr == 3) {
         channel = val >> 6;
@@ -248,6 +251,9 @@ static uint64_t pit_ioport_read(void *opaque, hwaddr addr,
             break;
         }
     }
+
+    trace_pit_ioport_read(addr, ret);
+
     return ret;
 }
 
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index c5b6db49f5..2bb51f95ea 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -49,6 +49,10 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK A
 cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 
+# i8254.c
+pit_ioport_read(uint8_t addr, uint32_t value) "[0x%" PRIx8 "] -> 0x%" PRIx32
+pit_ioport_write(uint8_t addr, uint32_t value) "[0x%" PRIx8 "] <- 0x%" PRIx32
+
 # imx_gpt.c
 imx_gpt_set_freq(uint32_t clksrc, uint32_t freq) "Setting clksrc %u to %u Hz"
 imx_gpt_read(const char *name, uint64_t value) "%s -> 0x%08" PRIx64
-- 
2.51.1.dirty


