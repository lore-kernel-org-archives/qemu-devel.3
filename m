Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551B5CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcpV-00053T-4M; Tue, 28 Oct 2025 02:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcpC-0004zj-AA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:04:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcp9-0005n9-Tn
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:04:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so3375441f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631490; x=1762236290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rAlH1/lu+rh7awee2lje3uE1FvJDSXtcSFDkovTFo0=;
 b=Ey/HZHUlloaZ/2+tZX7OQk9yvqOv4MQ3aukkEh84FqpBVvtLCRNrjJG21aCs8b8S6n
 f9w5MH5vAaBQSt0ISRdam0GqqKcnmBUwXcwV5QwopJ+WITSIPLvLR/w1RLY0VRBwQcNg
 fAtCrFtRLl5juTYzLQ2QXM36pPbfsro7Mb8fWKt0o8f77/5J95KNPdtWU6E7c3lHhyOa
 qJOcOlbjT8rKcQqizPb5i+yTZ3HS0pWGgmD2KbBxDUwTpmf8qbaX/qxZldAgygpGteRZ
 XBjxBGAM0E3MCGrlwtvCfvHisZHuPxXuVQBsNZuYTMEF49ByxZyzlynzw4ly/OCRSwrZ
 VU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631490; x=1762236290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rAlH1/lu+rh7awee2lje3uE1FvJDSXtcSFDkovTFo0=;
 b=kzUn2xQoMvUI1AE6OARMTcKnynalNsXkbB7ye/2DDWoAXdrNRz38OQZPDAh4JUxGPS
 f42AraaXYvSqDzWr3GQkcdW/aZ09+FQsGg1UJK5CxZFOYnM5ZWYa1aigNA4hkAl8aJ/9
 s4GTn5MIwj190Jr3cnYH/t1Drnj6A60f5GI+0iSeewi7WFTWVCddXqxvOaVlaa2dvsmA
 GhwRo4DM+SAgUXGeLa20+AumgNwnrpHFBLh7bga5SqByx8qH5tbXDoQXbKoGGS4BokH6
 NH+mGq9hNuX9CNs6GYjKAkbDCO7Dy/XvkJK2rMzzpfHLdZ8Ttb+ET/aUyNKio/RVP1fA
 utrA==
X-Gm-Message-State: AOJu0YyDJDvi97fDvZ2v4zEyJv8Jtq7h9+tnSZxXD1ho095UrxPabICr
 kglPFyPfwFT/RPf9EJmVqsmFGU2Re9PeBFfNeWZe5AZD5RjbtI0ldsfGnJbp4bwpGTGpXg3LrKD
 x5MpjDd8=
X-Gm-Gg: ASbGnctvf62uY7t99IzxpXA+gEQDQQCqqbBQd8jG6rJHWbSJUVUR10unN0eKlTA/+eu
 6byojie9i9s54N/uXzmL8H+AFe1Q0suNV+H+XyMk+4dp8kDPbus+G8VZKVP6SWVNnk7/s0UYOi0
 G8kOURQewCFa2AhHahM8fAIcyJpx0Tp01bXxLcRChH4ujvwQDCEN6ZRbimikCyO7UYsvU83Y2wK
 aZRDZKBgZvSb5tqwDIFUEAK20J9URe6Lsvwl/ZfCnGkee1hPdOO3C+ng6oDb1J43mHd2xfu3nYd
 hEiXFiI+ut/BZl7AeCDKVKSO20KKWA6PA1qTUJXDvlVUIOHeZMKZ+c7Uakwi9nV84zfmhRh5NRq
 puk9pYFkqPUh/ruGxS4eKn9ZdAmNnvYQvCae6jRRJq7kr9+W3rORU3UAXzOEjs0vfhk7oD9MfxV
 0NicQmOhNgtJdncE1U/5X0EDw5gR34Sfa/GggA+s8CjvnJ3vHn+m0oATVU5CY/nVoygA==
X-Google-Smtp-Source: AGHT+IG8zkd+TJv5KiWfrzhXB6ZTjqoPB1XyO0nMC8KbMR1x7q52BJzIfXG/0i5W8BVCYWo1X+isoQ==
X-Received: by 2002:a05:6000:430a:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-429a7e59dd4mr1695553f8f.16.1761631489856; 
 Mon, 27 Oct 2025 23:04:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db80fsm17842412f8f.31.2025.10.27.23.04.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:04:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 31/59] accel/hvf: Create hvf_protect_clean_range,
 hvf_unprotect_dirty_range
Date: Tue, 28 Oct 2025 06:42:07 +0100
Message-ID: <20251028054238.14949-32-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h |  3 +++
 accel/hvf/hvf-all.c      | 25 +++++++++++++++++++++++++
 accel/hvf/trace-events   |  1 +
 3 files changed, 29 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 3d2be4092ef..5a57691885f 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -89,6 +89,9 @@ int hvf_arch_get_registers(CPUState *);
 /* Must be called by the owning thread */
 void hvf_arch_update_guest_debug(CPUState *cpu);
 
+void hvf_protect_clean_range(hwaddr addr, size_t size);
+void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
+
 struct hvf_sw_breakpoint {
     vaddr pc;
     vaddr saved_insn;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0a4b498e836..e13abddbd9c 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -58,6 +58,31 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
     abort();
 }
 
+static void do_hv_vm_protect(hwaddr start, size_t size,
+                             hv_memory_flags_t flags)
+{
+    hv_return_t ret;
+
+    trace_hvf_vm_protect(start, size, flags,
+                         flags & HV_MEMORY_READ  ? 'R' : '-',
+                         flags & HV_MEMORY_WRITE ? 'W' : '-',
+                         flags & HV_MEMORY_EXEC  ? 'X' : '-');
+
+    ret = hv_vm_protect(start, size, flags);
+    assert_hvf_ok(ret);
+}
+
+void hvf_protect_clean_range(hwaddr addr, size_t size)
+{
+    do_hv_vm_protect(addr, size, HV_MEMORY_READ | HV_MEMORY_EXEC);
+}
+
+void hvf_unprotect_dirty_range(hwaddr addr, size_t size)
+{
+    do_hv_vm_protect(addr, size,
+                     HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
+}
+
 static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
 {
     struct mac_slot *macslot;
diff --git a/accel/hvf/trace-events b/accel/hvf/trace-events
index 2fd3e127c74..f989da59492 100644
--- a/accel/hvf/trace-events
+++ b/accel/hvf/trace-events
@@ -5,3 +5,4 @@
 # hvf-accel-ops.c
 hvf_vm_map(uint64_t paddr, uint64_t size, void *vaddr, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08"PRIx64" vaddr:%p flags:0x%02x/%c%c%c"
 hvf_vm_unmap(uint64_t paddr, uint64_t size) "paddr:0x%016"PRIx64" size:0x%08"PRIx64
+hvf_vm_protect(uint64_t paddr, size_t size, uint8_t flags, const char r, const char w, const char e) "paddr:0x%016"PRIx64" size:0x%08zx flags:0x%02x/%c%c%c"
-- 
2.51.0


