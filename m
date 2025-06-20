Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32827C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbTN-0002ZE-Sx; Fri, 20 Jun 2025 09:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTI-0002VS-Hz
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTE-0004Yh-P2
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:54 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450dd065828so13296095e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424871; x=1751029671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q43gncpn959Q6vZG2TfwFzrP1CTDyk3SKCOoBpm/1fs=;
 b=TSmQQYdJ0O2tKdPY417QHnevALRHTi/C0D/UPXZuhRNn9fmdvhVNMARf8Yau6I+HVD
 SQWhTZF9kuwHivYGzdVYZPS+dlqJXP0leHbA+TeaJhIi/UyAPZF0DMEUtc7H37L3PjCf
 WWZTM22GzFZdZmCiFxOfe3AWvy3x/dY/ahvYYfDbpGpTLpJJsYIoqQJSHOS2MlmsFOZ0
 fmAkJEmhOScFRXDOS0hKdXk6YJ0nQ/DfgmNA4m4ASFjBhBWXwkhZPD2A6azWVUJrwvwg
 qH09hyNdrAMM2BPizSANjft6oxWQ16VO1rcvH+KFDswCokrVlboIeWw4AtPzRAUhUFuy
 tqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424871; x=1751029671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q43gncpn959Q6vZG2TfwFzrP1CTDyk3SKCOoBpm/1fs=;
 b=BJBQ4BMKGc7pBUOBUJLTwu19RHT+wP5+mVldGDtyI809oRK449By1vc7fNtYIALmOt
 /TURTK86hPQXgcvQG790kgLqAmYYGy1bmjOqqNTEqp9wYMzNmY168tLz9azm53lIFYIg
 d7IfBHZIjszfpqKpK0TxODuiKWiCkmzdUgSPXAKpTxerqy1/9nJSoteElqTMHUtPO8HG
 GF9Y6fokZ4HCrhhPpMJGY2ghOKbO/3xluYCWIgJk+wgBaYmb/PX1uyZoHUeg5p/bF9Bj
 bNfwQyef714+VDc3wAmatUg3l8BqXg1UaT358yubDjAcmJqzUS8cFYyXbJA7Q/rKdcaO
 ZuIQ==
X-Gm-Message-State: AOJu0YzwMG/P9mp0ZzWR3y/5Xg0ml0EPxO3M08Umx8bS5ZPAJaPTjO1u
 0hwpT0rS067pJbF+RJqAGrABZTT67j5uM1jw9R8MAe+UrdN+W08qrS/toTaqWPBGR0j0DxfARwQ
 MnIwRxSM=
X-Gm-Gg: ASbGncs8wn+Ch9f0v4Vie49qa3AzvmuFEZ7e3m7XmNAda1InI2o3Mhmji/dmbY+epgR
 Ts2d4CVX/Re7e1Wpqlb8sRiRlP4gzWcXo97UpVKBYUacdgIHFJE3sUsX5Aueli0Dj5txiqGcgBr
 Bi0cm4JEDQmXlw6DMGULwdwjxPWbrShmTWZpS7gNTA9zpun4M+qbCrTZzcUaQhdrD5Mmqlb0ZKR
 p5sAdNc3p4ZHLZfwvQTxorvPDJVJTNvlDhCG3wjhNflCPtZi0bACulggOGbGz+4C9G0MmMjWMmD
 G/1nPeahc63YHhWtfNTL2e4iZJ+2c9eBS9alY+HPGXuLhyGPBMSdsZiLpxt6/m1zhsYZWD95SbU
 WViFYdwjGunE1XlGrbvlnrkEeZdTWxDXPBmFv
X-Google-Smtp-Source: AGHT+IEV1rnW6Q6vc9usSp2h/xg/oNVsZIj/bM4fFPHRe8OtleGcivh/UCl8l6pejkhU6VSf44Ctdg==
X-Received: by 2002:a05:600c:3545:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-453654cc009mr23346725e9.8.1750424870729; 
 Fri, 20 Jun 2025 06:07:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117e520sm2053595f8f.56.2025.06.20.06.07.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:07:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 07/26] accel/hvf: Trace VM memory mapping
Date: Fri, 20 Jun 2025 15:06:50 +0200
Message-ID: <20250620130709.31073-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Trace memory mapped / unmapped in the guest.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build               | 1 +
 accel/hvf/trace.h         | 2 ++
 accel/hvf/hvf-accel-ops.c | 6 ++++++
 accel/hvf/trace-events    | 7 +++++++
 4 files changed, 16 insertions(+)
 create mode 100644 accel/hvf/trace.h
 create mode 100644 accel/hvf/trace-events

diff --git a/meson.build b/meson.build
index 34729c2a3dd..5004678a26b 100644
--- a/meson.build
+++ b/meson.build
@@ -3633,6 +3633,7 @@ if have_block
 endif
 if have_system
   trace_events_subdirs += [
+    'accel/hvf',
     'accel/kvm',
     'audio',
     'backends',
diff --git a/accel/hvf/trace.h b/accel/hvf/trace.h
new file mode 100644
index 00000000000..83a1883343a
--- /dev/null
+++ b/accel/hvf/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-accel_hvf.h"
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d60446b85b8..b38977207d2 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -59,6 +59,7 @@
 #include "system/hvf_int.h"
 #include "system/runstate.h"
 #include "qemu/guest-random.h"
+#include "trace.h"
 
 HVFState *hvf_state;
 
@@ -97,6 +98,7 @@ static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
     if (macslot->present) {
         if (macslot->size != slot->size) {
             macslot->present = 0;
+            trace_hvf_vm_unmap(macslot->gpa_start, macslot->size);
             ret = hv_vm_unmap(macslot->gpa_start, macslot->size);
             assert_hvf_ok(ret);
         }
@@ -109,6 +111,10 @@ static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
     macslot->present = 1;
     macslot->gpa_start = slot->start;
     macslot->size = slot->size;
+    trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
+                     flags & HV_MEMORY_READ ?  'R' : '-',
+                     flags & HV_MEMORY_WRITE ? 'W' : '-',
+                     flags & HV_MEMORY_EXEC ?  'E' : '-');
     ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
     assert_hvf_ok(ret);
     return 0;
diff --git a/accel/hvf/trace-events b/accel/hvf/trace-events
new file mode 100644
index 00000000000..2fd3e127c74
--- /dev/null
+++ b/accel/hvf/trace-events
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# See docs/devel/tracing.rst for syntax documentation.
+
+# hvf-accel-ops.c
+hvf_vm_map(uint64_t paddr, uint64_t size, void *vaddr, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08"PRIx64" vaddr:%p flags:0x%02x/%c%c%c"
+hvf_vm_unmap(uint64_t paddr, uint64_t size) "paddr:0x%016"PRIx64" size:0x%08"PRIx64
-- 
2.49.0


