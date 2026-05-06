Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FE2CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcpQ-00077J-SK; Wed, 06 May 2026 10:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcoX-0006Sm-Ga
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcoV-0000nT-PD
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:01:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso71289185e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076081; x=1778680881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b9z/R1UZ+seu1cNfJAMd4B4iA/6hNLkGQbEviHCyG7c=;
 b=d3G+L/YA/IGYBBDoIezhr3YmGUkV/A6rfTBFgAVFGhaPARrJHwiBaIgtfEb2Z28FnN
 5ta97iW19/D0vgHdfhn8AMbuxxfUxdgpBM+snNlidk3+TlVl1pnLw54AS2nrn5uuHFci
 xdIpi8v6Cg+pfiy0VJsUOc50TcNvKsNYsiS+EjrK8zAKJ4zDG0DRAOVGO1iHj/ldHx01
 P6quLugHZppWOpRmM6UECgyOKB4Iwmk5PeDUhIBcjD++QQcPndG7a6Kw93Z9d1bk59rl
 4gyKkPG5Ms1FBJU+YgCg3EME5qmVuk73UU1KSA9fZRvgms8OEr+PTCoN8KdM1rInoeZw
 +BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076081; x=1778680881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b9z/R1UZ+seu1cNfJAMd4B4iA/6hNLkGQbEviHCyG7c=;
 b=WWGEY+i1480/+oKyzmdmGISFLCWsrO0gl3INL4BmU9vDd/r7LvqrOu/73Bn5C0lO5A
 cmj+oseGx/eNFg22Fv0JuhcenYmb+7sfQsIiTe1nMzk8lsa4hAJJqPaH85eIfctbaDvJ
 g+s9fV6/vWrT4N2YwhwyWUIIgvegzVKAzkmj3M/BNZBBkmTKuaOWrk0GSB9ngXU/sx01
 r6bSargHhHV9m6eMuJGqfQ9nWCa0Wc18L+upv2mu6dGiTw+vVn1kOmoc1e2GNClgun8k
 z8fYLDq8BgCptu3eFUXBWkrWs8BdWRJu6Ucoow/I0ukheu1MxEy5VI6T7VoKR5l0g5DC
 W2XQ==
X-Gm-Message-State: AOJu0YwjqZY3jtSskaaTj1T9feCRIAGdOGEtWOQkFZFAg8CXr1wQxgH9
 kHhd+NT9z4rz08MHPH8+9TQUFDekeNk58JEE85ItmX3nXV+AC4raLnrs/FHRnTrAPegQtu3yzJx
 XHIKGQ4c=
X-Gm-Gg: AeBDiesZxqbq2x5yVwhgvEZ/oGzZf4kpKs0Fd++Nf16DULHBdzQRAm9W/nabj/Fcrni
 pSVF6h+fxor3d3DobgNaWP/OA5YGdwcGAxutaCFoDFvew5NZPukVDw0SsfIR40RAFPaoANSXmg5
 cXIwVE9P9krisPx+FVtCBtCLs4bywQdfIcML08FOBODeW6x0bFOrPbbLBoHNZ0pKKT0BklDfMqG
 2tfTK3EDQTIzkw2sGrxmPTwiFCg+vHZ7tDeMgMfXagU4f7HuMeZ4Qge+YejUmSyD4C/p8+bPEUf
 EQCzBV4KF/nMEVeUo13qfNLUtqgZkb+Sk09FpffXYUVtWGkCTmqw64uq8Y1FkPiq5GuCoxZLnBH
 nczc/KGvAQuze9a3B53kp3M0hwJJT9JzI6BibzuZZXW8DGMKlSBSLjUxHUmFvcppFVEwFgT0bj7
 q+t/Uxnwas3/z3nFRA7zBGtoMNF+LFaVNWmsUkZWNE9QqxurYRWd5acy0PByf8A1WCGOlpapSiZ
 MPIwUwSuiU=
X-Received: by 2002:a05:600c:c094:b0:487:5c0:671f with SMTP id
 5b1f17b1804b1-48e51e1a7c4mr45904155e9.9.1778076079482; 
 Wed, 06 May 2026 07:01:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a50d0sm83503015e9.5.2026.05.06.07.01.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:01:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 046/110] system: Expose 'arch_init.h' as 'qemu/base-arch-defs.h'
Date: Wed,  6 May 2026 15:54:18 +0200
Message-ID: <20260506135524.20617-47-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We already have a file unit outside of the local system'
folder which include "system/arch_init.h". We want more files
to use it, so make it official it is a generic header by moving
it under include. Rename as "qemu/base-arch-defs.h" which is
more descriptive.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-11-philmd@linaro.org>
---
 system/arch_init.h => include/qemu/base-arch-defs.h | 10 ++++++++--
 hw/pci/pci.c                                        |  2 +-
 system/arch_init.c                                  |  2 +-
 system/qdev-monitor.c                               |  2 +-
 system/vl.c                                         |  2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)
 rename system/arch_init.h => include/qemu/base-arch-defs.h (92%)

diff --git a/system/arch_init.h b/include/qemu/base-arch-defs.h
similarity index 92%
rename from system/arch_init.h
rename to include/qemu/base-arch-defs.h
index 0c2b1f3a5d0..f33465738c9 100644
--- a/system/arch_init.h
+++ b/include/qemu/base-arch-defs.h
@@ -1,5 +1,11 @@
-#ifndef QEMU_ARCH_INIT_H
-#define QEMU_ARCH_INIT_H
+/*
+ * QEMU base architecture bit definitions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_BASE_ARCH_DEFS_H
+#define QEMU_BASE_ARCH_DEFS_H
 
 #include "qapi/qapi-types-machine.h"
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a0dbb81fd90..4298adf5a0a 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -36,7 +36,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
diff --git a/system/arch_init.c b/system/arch_init.c
index 604d5909ed0..1ad2f3d6f78 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "qemu/bitops.h"
 #include "qemu/target-info-qapi.h"
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index e90eb6247ea..e5b55e3004c 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -23,7 +23,7 @@
 #include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
diff --git a/system/vl.c b/system/vl.c
index 516ed7890b4..705f0d3a4a9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -112,7 +112,7 @@
 #include "trace/control.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/confidential-guest-support.h"
 
 #include "ui/qemu-spice.h"
-- 
2.53.0


