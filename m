Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC50C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg99-0001R0-80; Mon, 23 Jun 2025 08:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg95-0001PZ-D5
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:31 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg93-0000Vx-3l
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso2281125f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681164; x=1751285964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyiBFk3PHsFTGgxQWIJAhORaZcy53iNw0vUcB4RUUDE=;
 b=LPB75QosysKBIu72/h9rHK7gFs5UE7R9g+Pgymju0JxaxaQYQGnVxuMnRMoXq4s6jg
 iJRW2k5lCYu2qKIdBn5nbs+d9BRk2p5JmM2+IC4uV0v+i3nZgD0liwpfZO6nPU/y03T+
 1WE0+jY6VbNO224f2EUI+afrpEr9ibtmgYj6ICqmnNVQeYJdxsqdB8jq3bmYG/mpZNVa
 LbOpaBpWYTM7QEPf62EHh/70zjEu5qndxXFGGkMGf773ZvxXSUaFcf5JVGRUYI2hPWhv
 V3EQIixTiX42iYX8Y1L37c1toPkTRErl0GZ381ffr+mZf1mbId4fBtzK6eZUkNJh/3X9
 HbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681164; x=1751285964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyiBFk3PHsFTGgxQWIJAhORaZcy53iNw0vUcB4RUUDE=;
 b=i0/WGlVbgwfwVf99zvz3WwRrRgrld8GM9VTgyyu/xQ8We3BxT71G6iG8LY5Qy+jmao
 Jqyua6Z3L31h8vz528k0jDhZ1yUOOLTqcP8foPd6DzTtVmr3Yb5IUv67BEDKnFfXq3I3
 rVDS6PxIC+qY2loK9/xHVvtd2BJ0TcyP5nZXIxcQ60jB2il+wpSzEKD9bbocb4rQcq1D
 zHMlqRu0S9U7NYBy/6uxKvP0+MC4ZbCkmF36TsfX7SOWRb/uQ1QyL7krp0oxRi7Thjvp
 c+plRKG6u02E3FEH2B4IeaPkFjdpD8EUMWReoFDSvW2sGjdyXW5SMWY8aaP27UC3xOlB
 vihQ==
X-Gm-Message-State: AOJu0YwJZjgR/ub9WeVtNRtnUwpVL9+GPtQ5uS7edpIFS0fS2KnPBnAU
 WvEf/gMcRGpo7IQpoegLJ4bO7EAb33VugXflyj35Rcrcp+X168qVeIXo2u3svYWi/yeq8GMMfX8
 fOWY1
X-Gm-Gg: ASbGnctG/+mko2GebkeGFMbaBdebMABC/a5UMrTHqyJOGd3VPXT2cFoHbrAC3Cg+ajG
 8P7Jf5/1BJNv2rNwjuTQQNDuHnnp2IQFbkB2FYkI+rGOTM9kKQBuoSieFO4NvlY17THz5i4BqFV
 4hbm8hPzBbbQeUD41xe3zGYQGlIEfp/YceSLl/OqgxLxOj+CO+xkGS98Ge1iBjnAEAUwWNobt3U
 IINJLqevXx9p26kTWKXEQ6ZYOp0siVIaA5eaYG9h///eVVND94NAVjmCpo7zNwYorORg5KnPV6u
 8GTHXcTkf8nWiSyZXty3MgtDkocntwTuFMlUaAm/x8pvlNI/Yd0zYrnqn9Xo7O3wf9w+npsVdd0
 XhHevkoi/J+/gETQZshC/sabv2F2lCPohMPOG
X-Google-Smtp-Source: AGHT+IE/ShLC0BNfarjCGNMSpPGAS0rfS+vL7cCj12GXMkaCbIYQsstL056tugsSAblfUqd+SodRWA==
X-Received: by 2002:a05:6000:38e:b0:3a4:fc37:70e4 with SMTP id
 ffacd0b85a97d-3a6d1331ec7mr9866453f8f.58.1750681163851; 
 Mon, 23 Jun 2025 05:19:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eada7adsm144615895e9.35.2025.06.23.05.19.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 07/26] accel/hvf: Trace VM memory mapping
Date: Mon, 23 Jun 2025 14:18:26 +0200
Message-ID: <20250623121845.7214-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


