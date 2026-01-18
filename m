Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA37EC9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhatv-0003Ua-Ob; Sun, 18 Jan 2026 17:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatQ-0002B2-F6
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:12 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatN-0000oA-MS
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:08 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso21316555ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773904; x=1769378704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsCu8YjwoP3qndepqs66QlB075g8dS34UiTzdMRlo7I=;
 b=RDoukg824a2Zia3MQGgRz1VK341lszvmEwiXZqjDdBL05tpCTfsi33+huvd69bbBGG
 VMtPPUiZtUyaYwQoC1r3yXgESSOJvihWVhaZLJmfPc6YsA98WSUDQAYbaVSa0R1AfyNZ
 iZa+7iYmcF3T+5cqSIdFt8qVGdUNu+E1vhIbidORsDv475wIfKpeIHjt3M8EqOCWAzF9
 Iu0/HsSRI3xQitEcn+1X6nmfRXVUFzf4HgxFI9A+zvdcrS8tAMUDBvAAHBdzE47DWMdT
 C5d8WRU3ja1L48UdEw3gFR4OXNglicKN86x8DXHpTdmA0UjxilwUdO4EwuOfM4BWVva1
 Bp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773904; x=1769378704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tsCu8YjwoP3qndepqs66QlB075g8dS34UiTzdMRlo7I=;
 b=YUmToM3ZuRBDjy2LRLTvFius4vbCAVQ1V+gRPm8iDR6Bo1mYqkk9QXmlMEYwW0TUwn
 IkEUScx3a1V6FnCJXAIhXDWjmpAQ1RBXfujaE0LZzBXlIYGaUWC6qHbxUuJOXQI3vEb2
 2DcJaf6EA18Mvy+jJSImjTkzcb28jJR5njdE+v411YBJQWm6bimaFte01jcMN/uDoryo
 5O1I8qdPwYlAWavK1T7M1sGRrRAMlWkvNdEVfTMFBcHcB5QxliGN0n8OwSbY3ZYsaKam
 X7jst5/8hBs52oDWML+hNOZYAAfDo556UrZfrHGzhYEDrbIjBpERV8d08wHuxeMJMk0w
 05Cw==
X-Gm-Message-State: AOJu0YykoSi5HOpbJjs9ACycrw9HZYsuNgQDUIPm3vBdsUepE05IPCx3
 rCRmbOPWEsJT+ASnkaWdQ6fSvDCltU96tVxkdXc+XhmmwwdRVwZ3MEOe+vs5pVg+BXocfJUUzpy
 weYC1DFYB4w==
X-Gm-Gg: AY/fxX7wvy1e5WcDKpgCQfJa/4AKclD19eT0PQyvMFCSiy+QzC0JZy9fz3IUZaXhX+n
 7WZ8u+UBqpGrT3Nc4CZ1OHnpgp0b2cVJQY3Ng4Jclj3hfOH19rBMZR4IiDrprpWyUVfBf6SvaJL
 kvbG2UAKNpu/9Ha49p0YtezzAbwN4jl/7OxojSQKWFb/jJY/L6reKgLE3+eKGfFh7dB1uUxCM3I
 hWNHGLkPfNw/bNL1rVj+umUk6F/Ybp8NXMACWDwSSQmvyBngG5z0rEdH+bxslXYarQHcsPUo3TO
 85MTrmf/O+wDu1mebpKwOWW12u4kFUWZSGGGmqC0i1Cbxr26saH2iyLALx2Hzm9wVSBwVyMHi7r
 OwdbFeKB9i0fWuNqCnjocqqWj59ZM0Vu/F8wophVVj1w+HOZ/+nWX8dGZre1kIPoA5JGgNQwAQ/
 dTdz9+Ed0R/eMPOk2xpA==
X-Received: by 2002:a17:902:8ecc:b0:29e:5623:7fc3 with SMTP id
 d9443c01a7336-2a71751c5d0mr60501765ad.12.1768773904089; 
 Sun, 18 Jan 2026 14:05:04 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 18/54] meson: Remove cpu == riscv32 tests
Date: Mon, 19 Jan 2026 09:03:38 +1100
Message-ID: <20260118220414.8177-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The 32-bit riscv host is no longer supported.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure   | 10 +++-------
 meson.build |  4 +---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index ee09f90125..e69b3e474e 100755
--- a/configure
+++ b/configure
@@ -408,12 +408,8 @@ elif check_define __s390__ ; then
   else
     cpu="s390"
   fi
-elif check_define __riscv ; then
-  if check_define _LP64 ; then
-    cpu="riscv64"
-  else
-    cpu="riscv32"
-  fi
+elif check_define __riscv && check_define _LP64 ; then
+  cpu="riscv64"
 elif check_define __aarch64__ ; then
   cpu="aarch64"
 elif check_define __loongarch64 ; then
@@ -1280,7 +1276,7 @@ EOF
     test "$bigendian" = no && rust_arch=${rust_arch}el
     ;;
 
-  riscv32|riscv64)
+  riscv64)
     # e.g. riscv64gc-unknown-linux-gnu, but riscv64-linux-android
     test "$android" = no && rust_arch=${rust_arch}gc
     ;;
diff --git a/meson.build b/meson.build
index e1ac764793..0189d8fd44 100644
--- a/meson.build
+++ b/meson.build
@@ -50,7 +50,7 @@ qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
-supported_cpus = ['ppc64', 's390x', 'riscv32', 'riscv64', 'x86_64',
+supported_cpus = ['ppc64', 's390x', 'riscv64', 'x86_64',
   'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm64']
 
 cpu = host_machine.cpu_family()
@@ -279,8 +279,6 @@ elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
 elif cpu == 'mips64'
   kvm_targets = ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mips64el-softmmu']
-elif cpu == 'riscv32'
-  kvm_targets = ['riscv32-softmmu']
 elif cpu == 'riscv64'
   kvm_targets = ['riscv64-softmmu']
 elif cpu == 'loongarch64'
-- 
2.43.0


