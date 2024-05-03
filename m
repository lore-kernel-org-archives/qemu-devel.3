Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691CDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rz6-0006kk-5w; Fri, 03 May 2024 08:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2ryx-0006j1-B0
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:25:44 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2rys-0000o1-Vt
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:25:43 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a599332afcbso109464666b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739135; x=1715343935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ/5slWG25YGe7Sfq3Hc99Zz9GmHkCwksopYYuykw+4=;
 b=muHaCnIBzvEkdsefcEZBJ9vldcxpEMJccATT6w+ug9kaG4a1UofrwandJhJeZbZ9S2
 VxSJT3yFaOncAGxMT/sO8rx/GE3m5lnpzinalOVfxPLqxO8e5v+KB3mnUSHLgcIq7M2N
 DMtai937Itctu2SBfIqIzniETY+qr9iz82VR1J32r1NugqnrmCU8ChPnHIBV4Ff8bajM
 2ImWG+rMIGk9kQ9Gap9ahhtKzpO3Q/WbdxXanXybq4YKLl6z/+6loQ1mX52ZjCnteQZH
 hsXzB61/0qidMY37oHEKmesX6r+ufgWQAt/LhQAXXvpEQ/HfjxjoAooiM7j01LHct5jP
 7YZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739135; x=1715343935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZ/5slWG25YGe7Sfq3Hc99Zz9GmHkCwksopYYuykw+4=;
 b=QdUcZppxxnI1MVFIQT3ie/+DWIaJ/LVb0DAUgEm6L+y/1WeMQUMbVKV/z6upfyzzKr
 OUPLuHy6LLN1Gmt3JbOLL06mwhOJvYgr9S6aDTpM03mmp5s39Xq+Nniqn//SIVDyvow6
 Un+f7foLHaerZttl2GcRMbGADZ9kBnSldUc0w24T7nEgrT4sKrITQLZYxLyvx6n4twv5
 7sM50NKwVm2i7VtxWMrmKU1xvGx/WGsejiBPDr5UZlOGdEz8SAYejBLr+m3WQNZS3S77
 snwB5D1Jj4xS3Gk8N39NRVNQ3VKIivkFGBMzdD1rtUO7lQyJxMlfkidcP4yiA7S1UDuB
 c7bg==
X-Gm-Message-State: AOJu0YwhEORSdmtmzRunfq57c1wFnHcTL1b+5KJzRZi5lpIkEkguYxGp
 U3daoLGaxPJFfdHsTBNUxRZi9XCnYrgwdjyUokb1Si586ls2dFvILYkK/f4mIKL8vNvJf/axMEd
 N
X-Google-Smtp-Source: AGHT+IGSF5xOyEL6LIstzZ94n5wbNGV8xL/ul6jjoydb62kkyyKYed/Lt1rEeYN4gv1jru7q0zV/lQ==
X-Received: by 2002:a17:906:cf83:b0:a52:6e3b:fcf1 with SMTP id
 um3-20020a170906cf8300b00a526e3bfcf1mr1561615ejb.17.1714739135466; 
 Fri, 03 May 2024 05:25:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a170906715500b00a599c8b6531sm161905ejj.178.2024.05.03.05.25.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:25:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] accel/tcg: Move system emulation files under sysemu/
 subdirectory
Date: Fri,  3 May 2024 14:25:23 +0200
Message-ID: <20240503122526.28312-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503122526.28312-1-philmd@linaro.org>
References: <20240503122526.28312-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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
index aef80de967..1b91f26a7f 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -18,19 +18,9 @@ if get_option('plugins')
 endif
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
+specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files( # SoftMMU
   'cputlb.c',
   'watchpoint.c',
 ))
 
-system_ss.add(when: ['CONFIG_TCG'], if_true: files(
-  'icount-common.c',
-  'monitor.c',
-))
-
-tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
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


