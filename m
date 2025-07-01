Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42467C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSb-0005gX-Ez; Tue, 01 Jul 2025 13:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSZ-0005fx-KD
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSX-0003cs-N5
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso29782355e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389671; x=1751994471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5oBh13H1TdU88xyMHvWj3WuPRavIjEcQBhtY7QPCsZ0=;
 b=OZJwecNvY9f5fYIsGu3MXfkhlsV61p/blWi3cQo6RJ0cQD9pDoC9MN1DxFVla8zjPq
 VLxnQnXwRiLbzniIwLNale/ccTslAuyxMIlz3c7eabknQy8AF//xNzi12dT5GqzOj40+
 CfLBtF6hGU8MNnNncgoGpxg8DcS9Ige0MCkMr07EUlby2lyfc370GMLkqWQculHCTmmu
 UkM9HoLJJhJCpuvI7w5Hq6TeHYU0Wz7tE8AAGZL6X/HnpQfEqCN2J6HsMqLmqPYai4Qc
 XvdnAUhdWn7FC8cYfZaTcQu765ohn4ryExUFeWfjxn42e8xWFdbvILEGoYs9BOckIwFu
 epZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389671; x=1751994471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5oBh13H1TdU88xyMHvWj3WuPRavIjEcQBhtY7QPCsZ0=;
 b=dR5ug0ZMN7HjIigpJHylG1A+OeYLwYLraGGKX3swqzQ/KGmMnY9mqQXNY68HV1flf0
 ORYQAWixlMXeAbd5lZhZX3BOKe9vuMksHtQOZC+wL9LvcQ6KcAA0LLsLa1jDqknwNBvO
 q/R34BmkSzYvL2Q1/ou9t17qk8BaFZPRbkGf6AonIWq1IVzZq5Wrvj9ZeDTeGyjrkGKQ
 QHKk7A7DUOBGNnf+oHz4/342b5I0TixCZW2vI98vuNqnQJYTM/cb5mEZoJ5C/R4j90H+
 jUdjXiBXuJ85BdwRrzlDtw3V4bBgIt369hQcew5yYsGgMhXOXw7PqHLunY8l7Pt0eh/m
 gXTg==
X-Gm-Message-State: AOJu0YzsBzH0eDGkFuYfQGi02JMJB667zEsi9BYSxhrZevtNdSDYVZxF
 8hcpRhNm/dESRrfUzAav4+CXRwDuoO9OHqsuEUbINB/sBSp7gnO7Ym4YZKBXgOu6rGRxQ2B2Dqo
 7EpOu
X-Gm-Gg: ASbGncv/6sx6D4J8X97LzzlEYfI+J8G+KRomCc4EXtEfkhuiOGg8Cp3WkdEbK1fYjdl
 jIgXgAuj44UcdoUkUiM41yfk+80ojk27h5T0m+hCbaFBDfOfaFrJmQIe4Uiia9os+5pQWiwFqw7
 Nl0SAxPK1DTkgiaOtXIuHhcbFVuy+/fGCEImpr0mOu4yAmm7zm9HUiN8SRnJB8z35JQrfD/v1ou
 tuO2lyjkfgXUOm5yY1yLmvrCHPoqQBSrLgPXtsd7Tgc7u1uKPUbGA18ipZVTmDffB4jflfGHhH3
 q9yHMqn4z1s7CMydN2aTjci07CYt0VXkyqBpjSNyuSyiPNsuOPXMruJB/tkLWVXwYXdL
X-Google-Smtp-Source: AGHT+IH/Ua17eq+goyvC5ptbIe684OdpLiLI60DdX52B3BAO5zVOHM9CLR9O1XseRE/U9J9xBQ8E8A==
X-Received: by 2002:a05:600c:1d18:b0:444:34c7:3ed9 with SMTP id
 5b1f17b1804b1-4538ee7995emr172366715e9.26.1751389671365; 
 Tue, 01 Jul 2025 10:07:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/43] accel/hvf: Trace VM memory mapping
Date: Tue,  1 Jul 2025 18:07:05 +0100
Message-ID: <20250701170720.4072660-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Trace memory mapped / unmapped in the guest.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-8-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build               | 1 +
 accel/hvf/trace.h         | 2 ++
 accel/hvf/hvf-accel-ops.c | 6 ++++++
 accel/hvf/trace-events    | 7 +++++++
 4 files changed, 16 insertions(+)
 create mode 100644 accel/hvf/trace.h
 create mode 100644 accel/hvf/trace-events

diff --git a/meson.build b/meson.build
index dbc97bfdf7a..b5f74aa37a7 100644
--- a/meson.build
+++ b/meson.build
@@ -3630,6 +3630,7 @@ if have_block
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
2.43.0


