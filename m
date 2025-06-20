Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B228C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfP4-0000pi-DN; Fri, 20 Jun 2025 13:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLq-0003Gf-RZ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLp-0004e7-3I
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:16:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so19857125e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439786; x=1751044586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0chn/PFHrz+xSOI0jlEUFPBGrfliVmmZpEFFKJ3P4VU=;
 b=WDqcsAy+Ryi3y8F8A/VXP+hj66yqJoMUvMie2dA8ZXjbMEu8H5oYezHXbhDdlZ/kIU
 6qnuejBDFhjeH1haxM+UjHQhw56pYARYTLOqG390qOW5xJOE6Bp0Vc57MxEn9G5nmLE9
 B150sLiRp7sXtokNctkpM49hXPb/T2wWdeWh988DVLnm07hH6q9ap/m8RAAmnwAbLoEJ
 v6VrPPQcMJIoLO/H4x490LAhHPF15Ci6uWbWDK9V9dDzKTuqvKEGHKFdatJhJJFBd6ou
 S2cvJxRUqMv2WA//akNlm9v5nSEGX+aPg2i2MJ9Xo/y7dskMm6nyLaA4w3DGg2zMX6i4
 N7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439786; x=1751044586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0chn/PFHrz+xSOI0jlEUFPBGrfliVmmZpEFFKJ3P4VU=;
 b=Kykt3pcfhcOd1i7bwF40LcYNxB7GVmVtU39D8tWopE0czCoXZ6Tp1+ZQkj+0CpqJrW
 Ar6chJg1ZWscUJaNt9GlIS+nCP/dldVLt7yhdQzHHanfqrcXpCWTXIodVtOz7d43uFU4
 MJCImA/8Q7s9SYqSus+sKv67s3+XD+tEjpVkONItrWP2r4WEl5HJRJDNIpDAYlkjlcKj
 gUfeELhwpUVJbuaOK+WfosVQIeoy1K3dI2VCfazOQ0tDDBNxzCatuejypoS0qnBMceD5
 Odi7hHAt1elpg8gcESqNZGC6fwU8RQJ3012fTtsl5FaLh9UscmNWNlTyZYwf7YbCfzCo
 eY8A==
X-Gm-Message-State: AOJu0YyugwkZIfNfvSRIC1zBO8vh7Qe9YSif8L30fS85YpvCOrcaBDzf
 Z1nKOraABbUkbplT5ATXmxvR//vJHBG+vjaJC2utVWOfFJKbSaCffG8qtSrFiXOOHujA0++zaB7
 UcsnlS0I=
X-Gm-Gg: ASbGnctsJPbprz1wLpKCAGZw5EWzrLrTUDzJ9lZrgPpH8SqXLjawnRW10nmGNfXYmhW
 9XK3nASs16RRLGr7E7mTpJEYKFHlCxlPXebo5gzMh6pXDTfdBTJ87HiP7D27uVVH1269Rb6Esq6
 rIkM2YIX+LLWyvQWcFKfs8AuvA51xgCvSbldrmF8K12EpHLiMcE+Jkynd+oP6H/c1rMt5LUt8SX
 ujXfFjc0weJPpJ+WTLciWh61aqJMJhI9/BJxjsPAopRWwtkGbyxdmLe0IyQpGlGkaJUpQ4bNryh
 4hTCCcZNxyDV0YVDDS2HgvuaPgwjpaKJrdq/2te8uw4ecrLRPjD5Z4jJYK8jJUx7BsdjcAHRHMN
 r203pUaMqaaO+09VgI3V5Ulu28MM7bOQKN8r2
X-Google-Smtp-Source: AGHT+IHoF6VuoePln54CqTE5ntReLP47+/6Ex3M/6Zpjnotqe+GTfgBvci8gOJYIr5vLpeXrh3lXYA==
X-Received: by 2002:a05:600c:4fc5:b0:453:2066:4a26 with SMTP id
 5b1f17b1804b1-453659ee9famr37781535e9.16.1750439786198; 
 Fri, 20 Jun 2025 10:16:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c66esm2501112f8f.47.2025.06.20.10.16.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:16:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 33/48] accel/hvf: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Fri, 20 Jun 2025 19:13:26 +0200
Message-ID: <20250620171342.92678-34-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 78bf0ac6cba..6bf7fcd7331 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -471,22 +471,6 @@ static void *hvf_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void hvf_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    /*
-     * HVF currently does not support TCG, and only runs in
-     * unrestricted-guest mode.
-     */
-    assert(hvf_enabled());
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
@@ -605,7 +589,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 
     ops->cpu_target_realize = hvf_arch_cpu_realize;
 
-    ops->create_vcpu_thread = hvf_start_vcpu_thread;
+    ops->cpu_thread_routine = hvf_cpu_thread_fn,
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
 
     ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
-- 
2.49.0


