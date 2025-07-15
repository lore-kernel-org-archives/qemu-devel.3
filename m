Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB03C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubd5u-000578-Pl; Tue, 15 Jul 2025 06:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5q-0004nI-2f
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:41:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubd5l-0005p7-5X
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:41:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so4200958f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752576055; x=1753180855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ok+5NmOXDrDv30p5CirWmLHiOG8wwlJI4Up4DP2l3ZM=;
 b=qXlLmNGa0d00Dk4H7RYkp3K+bPF6PEg/5f/PJmVi+XouGLz/ARehpSR42bZsXtZf9y
 MpUJJmLTkTRgoBMn7MYXxOg7Hdd8WdR53Lfg4nH/zzJASq/uvM6cBN0+Kx88xho6mxgw
 JwYQOqdyeM3kvhbGRoQ6dDxoxlbzvZCJ0G+//C7Kch4CYFJkF/rWJTc+GIFsFWht0r+Y
 RXP5KMPMMKZ8Dk9o+w3mJojeM/ytYeCcA/F44/7JVwaTCPrAlCy+EVXYfsd5vmojehv5
 z0Nc2VbuVQlHClx2OPbgLUVPJZRVKxjWqpFs4f243UuSt/02FjU481QfLwCXvQrOyXno
 NI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752576055; x=1753180855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ok+5NmOXDrDv30p5CirWmLHiOG8wwlJI4Up4DP2l3ZM=;
 b=LkGbw/FRHZxDN+ZwlXpRI633yaIUOr9ObkKeSMODm7TEIFFsYAYa71bivMvEr6inP4
 wOLHRTDpAbUIrerI1v6vgCy4ZPKx8oChRgusCIlrksuaUITRQ2Tk3kng3EUN3DeAzWvc
 +cv2XsuLOQm6jBfreyClDXFDWShkzMXFJS2ThICU1SK8zbz6UcrVOZE+t/owUOxjpMYN
 lsLKaWznotCEtD+HT1NjJTmwNSu8cxDyCa4mZ7mHNtr3lZygmrVFAxKTA0xTXXv9y3Cp
 +M4ZkH8i3BoZaItTDN2mbFqbdzzksXMSxr92EG1ZCY9BRidsO3n0VsldgfxW9yqhYjpI
 vnIA==
X-Gm-Message-State: AOJu0YzgHg2UiSLFwviyssKBo3V3NSHnvf21hnFHOqnJDfSYGPBHqs13
 ap9Pc9uL+fMOUi9albKg/EJwOcOSkplSPADdSBAF1zAcMv01Lpp5T6NbpjtcFuW0Qk2gb8hPmrY
 sCAdQ
X-Gm-Gg: ASbGncstRJGDA4D/XoIBQyvoc+pImOFIhZrmfF20NIcE/GnBe+W3tFiH5OMLsOq+5XQ
 j1cqCpcwQQZsyHhXz+M4AohClWc+VzxVxNTMLDVuW+pa63gKyVfTJzTdlL1CVxwjk35SbZP4bSh
 BEHL1cxK3R7tHR/r3prTDnWat/qUy3m/0qmYHMBCRsSLuENBaDBA09uFDYalKn4gx2BP6AwSPMa
 GdmHLA68jlcjVgzhfRfds1KNrOL+DBiA4AKQrnV+xyp+6lr++e3aW1Hm2LGvuE9qaXwY+n8zDsw
 P/wiw+4NEvizWE5JHpEE9oWxPEo5DT9mRIO1Ew3J9zJsr0y3e13zAng4PaQ5ae6TxxWaGiQeSPo
 KZN7gfKUALMIl1h7N6ZPGNHr9M0vjJAkp3vnUZFZWZf1ZaECQU04ANCm3gSMfxopU/XfQDU+WXl
 JaPudaDb0RNQq3
X-Google-Smtp-Source: AGHT+IGeen4Oiuf1b5nSro6AVTfh+lrHU9T+/kks8rkgpfUIRQMtpnuow4gE/hnKERCTuKk4fOF1nw==
X-Received: by 2002:a05:6000:2388:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3b5f187d0e3mr14375640f8f.7.1752576055162; 
 Tue, 15 Jul 2025 03:40:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1ecbsm14616772f8f.25.2025.07.15.03.40.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 03:40:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH-for-10.1 v5 7/7] accel/hvf: Implement get_vcpu_stats()
Date: Tue, 15 Jul 2025 12:40:15 +0200
Message-ID: <20250715104015.72663-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715104015.72663-1-philmd@linaro.org>
References: <20250715104015.72663-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Co-developed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Mads, I welcome your Signed-off-by tag on top :)
---
 accel/hvf/hvf-accel-ops.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 214454bd0b4..94a5bffb44e 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -58,6 +58,7 @@
 #include "system/cpus.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
+#include <mach/mach_time.h>
 
 HVFState *hvf_state;
 
@@ -118,6 +119,12 @@ static void dummy_signal(int sig)
 {
 }
 
+static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
+{
+    int r = hv_vcpu_get_exec_time(cpu->accel->fd, arg.host_ptr);
+    assert_hvf_ok(r);
+}
+
 static void hvf_vcpu_destroy(CPUState *cpu)
 {
     hv_return_t ret = hv_vcpu_destroy(cpu->accel->fd);
@@ -347,6 +354,20 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
     }
 }
 
+static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
+{
+    uint64_t time_mach; /* units of mach_absolute_time() */
+
+    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, RUN_ON_CPU_HOST_PTR(&time_mach));
+
+    mach_timebase_info_data_t timebase;
+    mach_timebase_info(&timebase);
+    uint64_t time_ns = time_mach * timebase.numer / timebase.denom;
+
+    g_string_append_printf(buf, "HVF cumulative execution time: %llu.%.3llus\n",
+                                time_ns / 1000000000, (time_ns % 1000000000) / 1000000);
+}
+
 static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -365,7 +386,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
     ops->update_guest_debug = hvf_update_guest_debug;
     ops->supports_guest_debug = hvf_arch_supports_guest_debug;
+
+    ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
+
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
 
-- 
2.49.0


