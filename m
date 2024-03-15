Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261F6C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7KK-0006mh-Cr; Fri, 15 Mar 2024 09:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Jo-0005yH-0T
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Jk-0007kM-P3
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:50 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a36126ee41eso254024766b.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508187; x=1711112987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ztA/s++99kJlJQVkkhi5KVYRPW5VID21TBVzyIGr2Y=;
 b=jiGT8GrZ9igAjQoCC815i0lvzx2CR+1zxy8vL2gf9kgM5JRISixm7OQ3P1GuqzBu/g
 0b3grywW7QiWjM8vgXTcp3EaDAINKBXocmKH5Y8v0kogi5pWwHZrflfO/B32TUYMo6V+
 CMTkw5qh1pWpDfZlJc/iXBYaGBVoDWokXpiFA9W5oojGQ5u5vQ7w8aSGaJeMS/0l/B8M
 ND8Dss8NO+p3oHwxsW8N9gjSGeiRC6suG7esXapi/yKNAlsuUDkXuhfrQxlU9OGUWeCN
 yfcFuqC7VpwCTSZmWtTvNDgTK9Bc7gzyeNuTCFdwPSs6KCm/lxjJ4Zxyl8ghJ0+xrsmv
 sLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508187; x=1711112987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ztA/s++99kJlJQVkkhi5KVYRPW5VID21TBVzyIGr2Y=;
 b=rag2LlJ3wEvZjvc7vpBhrejK0tUtqsd/wS7hYBg+dUP/WyBb0pGH7FZ+1MH3uKDxOV
 hfmy1WlU2N0kGslKXXbwWhjktokVLeqyP6khJRF+wGaQ6X5R/IBwqK6Wkz04hOUFNQNS
 uDMyc0kvsHfV5NG+8vKenDlHkm26Yp4zJdCJl/7GmdR8h9giQVgOvk6JW9RoFFdwrnt+
 Qqxr+DMR2XY7SHHEjYzP6aD9+FUg/TSieqvH0At5jrIykr7YHDfIvMkNRTw7FD2TrueU
 sbNbzdOp/p0wPOD8IQGHg1SMrMOhA+q+kK5jJMmbjvmLPhNwhRrmgQDfn7eAL7JflEgl
 eUXw==
X-Gm-Message-State: AOJu0YxAyOpGWa3BbtPL43iH3ZZpasa3LodoK0W+fKEbuu/lWU/KTwOj
 rm1oJwRA56lpiqJv0SHwtmqaK3FT5cmszDn6ByABIsWeeK/ug46y9LwUKB8Rr+IqeMVrfJOSR3P
 E
X-Google-Smtp-Source: AGHT+IHGdVDgE0BV4E6ET1vnyKOiNgQutr60WkuR7/igTVB/b/2IuiYcgezn/mIAKkIya0Cm/N2Kbw==
X-Received: by 2002:a17:906:6bc8:b0:a46:800a:6358 with SMTP id
 t8-20020a1709066bc800b00a46800a6358mr1492199ejs.15.1710508187195; 
 Fri, 15 Mar 2024 06:09:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a1709067f9700b00a466a265ffcsm1722093ejr.145.2024.03.15.06.09.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:09:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH-for-9.1 05/21] cpus: Open code OBJECT_DECLARE_TYPE() in
 OBJECT_DECLARE_CPU_TYPE()
Date: Fri, 15 Mar 2024 14:08:53 +0100
Message-ID: <20240315130910.15750-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since the OBJECT_DECLARE_CPU_TYPE() macro uses the abstract ArchCPU
type, when declaring multiple CPUs of the same ArchCPU type we get
an error related to the indirect G_DEFINE_AUTOPTR_CLEANUP_FUNC()
use within OBJECT_DECLARE_TYPE():

  target/mips/cpu-qom.h:31:1: error: redefinition of 'glib_autoptr_clear_ArchCPU'
  OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
  ^
  include/hw/core/cpu.h:82:5: note: expanded from macro 'OBJECT_DECLARE_CPU_TYPE'
      OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
      ^
  include/qom/object.h:237:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
      G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
      ^
  /usr/include/glib-2.0/glib/gmacros.h:1371:3: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
    _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
    ^
  /usr/include/glib-2.0/glib/gmacros.h:1354:36: note: expanded from macro '_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
    static G_GNUC_UNUSED inline void _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) (TypeName *_ptr)                     \
                                     ^
  /usr/include/glib-2.0/glib/gmacros.h:1338:49: note: expanded from macro '_GLIB_AUTOPTR_CLEAR_FUNC_NAME'
  #define _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) glib_autoptr_clear_##TypeName
                                                  ^
  <scratch space>:54:1: note: expanded from here
  glib_autoptr_clear_ArchCPU
  ^
  target/mips/cpu-qom.h:30:1: note: previous definition is here
  OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
  ^

Avoid that problem by expanding the OBJECT_DECLARE_TYPE() macro
within OBJECT_DECLARE_CPU_TYPE().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
TODO: check rth comment:
What about adding an OBJECT_DECLARE_CPU_SUBTYPE that omits half the stuff instead?
We don't need another object typedef at all, for instance.
---
 include/hw/core/cpu.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ec14f74ce5..4c2e5095bf 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -78,7 +78,12 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
  */
 #define OBJECT_DECLARE_CPU_TYPE(CpuInstanceType, CpuClassType, CPU_MODULE_OBJ_NAME) \
     typedef struct ArchCPU CpuInstanceType; \
-    OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
+    typedef struct CpuClassType CpuClassType; \
+    \
+    G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuInstanceType, object_unref) \
+    \
+    DECLARE_OBJ_CHECKERS(CpuInstanceType, CpuClassType, \
+                         CPU_MODULE_OBJ_NAME, TYPE_##CPU_MODULE_OBJ_NAME)
 
 typedef enum MMUAccessType {
     MMU_DATA_LOAD  = 0,
-- 
2.41.0


