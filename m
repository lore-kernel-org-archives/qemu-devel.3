Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F4DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2p2b-0001h6-6O; Fri, 03 May 2024 05:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2Z-0001gr-FI
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2X-0003ZV-Ir
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41bab13ca4eso47913325e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714727831; x=1715332631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/nrhpPctNIFKbTVUUpB8iSj1laj4YlC2viiNoCursk=;
 b=CWddUIEsDjkjJn/C7tFITvsJvhbVTwmpRy1MdbpZMX19W5vghItn59iOjZjF0O3s7Q
 ihIfCX8PSPvTkQkNCNEARSWIXKEsM4ik8A01UoGSslC85CY6KYiTtZhpz+Nrbo+bfTF1
 OMpIKTVl0lBsHk6uVyaOCmbp49DtSJ0lMfAe34NE/3nQqM3qO+wG0QjW6wK2aU311ocM
 3pBVHQW+1V4ZlYbxxPGMJLrbb8MabJtupV4m3msCDMiLnWr92d+/w2nclKNpvp14f8xV
 eaKW9vc3vakyVZDH2S2siwvQfNbSvbKUCZT4lspF4MOB1XcFFE6uRCerdGsBHhv2ceDI
 EQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714727831; x=1715332631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/nrhpPctNIFKbTVUUpB8iSj1laj4YlC2viiNoCursk=;
 b=tP8mBrfFxzKcRy3rHtvn3fAo6Svn4bbL5NpsiLCydSkzsnXiQBkYmKi6sO8cy5E1aW
 vp/GbxeYFsHD7H0akF256/GYcDOy4i/jXm3OkKvf+3pYC//Pxh4W8smxOhekFzMwtRsQ
 C6ywcrlh8sEbQHzNzLs1g/GQ5eY7jrlLhRcPkY/WZDCwkNy2qi5dNI+fuu61OnWocyQa
 oajlYpFRyAFBM6H0XYJzxweJ5S4cC/PIDr6UPDTktOHBvCL+Jua2Td1qiSyKVr8TSm8R
 Sc+Y+ii6wBg0ntUPfDFL6NnaE0j1avLjknM/kfp5LEg9ag9/hb4CJbnFWgPINKRdq65Q
 Z4Iw==
X-Gm-Message-State: AOJu0Yz2Iy2IrndwZYo5ow63Nxe5ghlRmZCW6Gj5TEIaH5dn3OLfJ9oX
 DaJjDaZ2jOlKYbTaA5qqYjkZKbeo364FoiTqP2ChpdKfnEh/U+kQpVBJT8VNTnumif1jia1AbuJ
 o
X-Google-Smtp-Source: AGHT+IFhMFavlVYSQdlv0sePo5k2M3EhmwgnCeQeIZNBxg4ry9OwgJVPIy/Qax4P7lKC8rhSmdQyRw==
X-Received: by 2002:a05:600c:4505:b0:41a:a08f:2696 with SMTP id
 t5-20020a05600c450500b0041aa08f2696mr1765123wmo.12.1714727831576; 
 Fri, 03 May 2024 02:17:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a05600001c100b0034e0a3a9e14sm3273731wrx.75.2024.05.03.02.17.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 02:17:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] accel/tcg: Move system emulation files under sysemu/
 subdirectory
Date: Fri,  3 May 2024 11:16:54 +0200
Message-ID: <20240503091657.26468-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503091657.26468-1-philmd@linaro.org>
References: <20240503091657.26468-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Some files are specific to system emulation. Move them under
their own sysemu/ directory. This might help to notice what
is affected (user, system or both) when doing global refactors.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.h        |  0
 accel/tcg/{ => sysemu}/icount-common.c        |  0
 accel/tcg/{ => sysemu}/monitor.c              |  4 ++--
 accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c  |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c     |  0
 accel/tcg/{ => sysemu}/tcg-accel-ops.c        |  0
 accel/tcg/meson.build                         | 14 ++------------
 accel/tcg/sysemu/meson.build                  | 11 +++++++++++
 12 files changed, 15 insertions(+), 14 deletions(-)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.h (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.h (100%)
 rename accel/tcg/{ => sysemu}/icount-common.c (100%)
 rename accel/tcg/{ => sysemu}/monitor.c (99%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-icount.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-mttcg.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops-rr.c (100%)
 rename accel/tcg/{ => sysemu}/tcg-accel-ops.c (100%)
 create mode 100644 accel/tcg/sysemu/meson.build

diff --git a/accel/tcg/tcg-accel-ops-icount.h b/accel/tcg/sysemu/tcg-accel-ops-icount.h
similarity index 100%
rename from accel/tcg/tcg-accel-ops-icount.h
rename to accel/tcg/sysemu/tcg-accel-ops-icount.h
diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/sysemu/tcg-accel-ops-mttcg.h
similarity index 100%
rename from accel/tcg/tcg-accel-ops-mttcg.h
rename to accel/tcg/sysemu/tcg-accel-ops-mttcg.h
diff --git a/accel/tcg/tcg-accel-ops-rr.h b/accel/tcg/sysemu/tcg-accel-ops-rr.h
similarity index 100%
rename from accel/tcg/tcg-accel-ops-rr.h
rename to accel/tcg/sysemu/tcg-accel-ops-rr.h
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/sysemu/tcg-accel-ops.h
similarity index 100%
rename from accel/tcg/tcg-accel-ops.h
rename to accel/tcg/sysemu/tcg-accel-ops.h
diff --git a/accel/tcg/icount-common.c b/accel/tcg/sysemu/icount-common.c
similarity index 100%
rename from accel/tcg/icount-common.c
rename to accel/tcg/sysemu/icount-common.c
diff --git a/accel/tcg/monitor.c b/accel/tcg/sysemu/monitor.c
similarity index 99%
rename from accel/tcg/monitor.c
rename to accel/tcg/sysemu/monitor.c
index 093efe9714..620c18d267 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/sysemu/monitor.c
@@ -17,8 +17,8 @@
 #include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 #include "tcg/tcg.h"
-#include "internal-common.h"
-#include "tb-context.h"
+#include "../internal-common.h"
+#include "../tb-context.h"
 
 
 static void dump_drift_info(GString *buf)
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/sysemu/tcg-accel-ops-icount.c
similarity index 100%
rename from accel/tcg/tcg-accel-ops-icount.c
rename to accel/tcg/sysemu/tcg-accel-ops-icount.c
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/sysemu/tcg-accel-ops-mttcg.c
similarity index 100%
rename from accel/tcg/tcg-accel-ops-mttcg.c
rename to accel/tcg/sysemu/tcg-accel-ops-mttcg.c
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/sysemu/tcg-accel-ops-rr.c
similarity index 100%
rename from accel/tcg/tcg-accel-ops-rr.c
rename to accel/tcg/sysemu/tcg-accel-ops-rr.c
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/sysemu/tcg-accel-ops.c
similarity index 100%
rename from accel/tcg/tcg-accel-ops.c
rename to accel/tcg/sysemu/tcg-accel-ops.c
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index f40959436e..8d263a71cd 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,19 +20,9 @@ if get_option('plugins')
   specific_ss.add(files('plugin-gen.c'))
 endif
 
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: files(
+specific_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: files( # SOFTMMU
   'cputlb.c',
   'watchpoint.c',
 ))
 
-system_ss.add(files(
-  'icount-common.c',
-  'monitor.c',
-))
-
-tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: files(
-  'tcg-accel-ops.c',
-  'tcg-accel-ops-mttcg.c',
-  'tcg-accel-ops-icount.c',
-  'tcg-accel-ops-rr.c',
-))
+subdir('sysemu')
diff --git a/accel/tcg/sysemu/meson.build b/accel/tcg/sysemu/meson.build
new file mode 100644
index 0000000000..d0b4939ba9
--- /dev/null
+++ b/accel/tcg/sysemu/meson.build
@@ -0,0 +1,11 @@
+system_ss.add(files(
+  'icount-common.c',
+  'monitor.c',
+))
+
+tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: files(
+  'tcg-accel-ops.c',
+  'tcg-accel-ops-mttcg.c',
+  'tcg-accel-ops-icount.c',
+  'tcg-accel-ops-rr.c',
+))
-- 
2.41.0


