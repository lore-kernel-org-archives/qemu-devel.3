Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2191EC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBgD-0000ct-Rp; Wed, 29 May 2024 01:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBg5-0000Yu-Vi
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBfs-0005SL-FV
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:16:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35508106cc2so1589554f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959790; x=1717564590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+2b8ynGFv/PyqBaoMz4GdmSkSdilvbxFOBLh9vRr24=;
 b=oXGdyagvcQ8O0XH6UhdZPr9CgQYC9jnHEiE31lrMT2Aiz+zbDskwpYtD1e/jzRb5/L
 7qpzX/BUFvuQ/I7+0sfCX29pto2oe5giHdLXKCDxyqA7SoqKWyNVCq0isorAckdwSh8c
 8st7Sz88tJPWkF2ZhNqALMpp+7cyxNc4xrTPLEYON0UGmK4Xgp3MTURDbBYgdTQPm/Ps
 hEjip5CVy0cjtnajRVlhmO1s3IOKufuRmj+zf2imB3fCoBbt9MRmzp/3Oyjm05vgpQcJ
 xog9lo+Z6Hr+kRc0dN4YFFc3X2hpLByo8GNlP7Jv2qvXNAKUQry4dH+NNMBqE7P2PMdo
 /MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959790; x=1717564590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+2b8ynGFv/PyqBaoMz4GdmSkSdilvbxFOBLh9vRr24=;
 b=rNomJG6KucG7py+kgC2hjAHHsN4nLeRY2I/pWExWXyi295WCPUj/3PWo1B5z8XMrEc
 5j4wR6f4ibPo4ul1IyfmG5l1vEcyYVWTxuVE/612CArfgbajVhY2qiZVuUqJ8OXqDX6J
 gCLJ5Rj2JFOhhrm3psw7umcuTXmfaAB4HShs5VMbcbfPKtfH+NPFdV/iqWRN+DiixA2W
 RiMJ+gE7kh92ON9ZzIRpkipJUeAiY5mfFb1BHMjkcznGyxSYYfFdOvB6l6nSS0+Lwfg2
 m067VOI+5ODMu5+djbcJq9Rcjdd7cD2EGkrhEtJ2aLmXpIfiY6FydPadbbIIZ5nd13OD
 pVIw==
X-Gm-Message-State: AOJu0Yz3MDNghI4M6A1Iy44jQQcG4+QcxwylmVzSZft7BeeMkdLdsThV
 N27wcwX3mOwnJSz08s7Yk1UX6Bg9qI7Raxr1YVAK4LKmgRX/phryN0k1HYsSXGuhyeBjFT+RloD
 k
X-Google-Smtp-Source: AGHT+IGrN+Q05h/vBY+zxCFDHGU+CskyikH/fZPjX237UZUROptjqqjl+2Sy22rJAdAAAKcq3sp8yw==
X-Received: by 2002:adf:fd06:0:b0:355:130:98a7 with SMTP id
 ffacd0b85a97d-3552fddfa4cmr9648860f8f.54.1716959790307; 
 Tue, 28 May 2024 22:16:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c93c6sm13634147f8f.85.2024.05.28.22.16.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:16:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 09/23] target/i386/kvm: Remove x86_cpu_change_kvm_default()
 and 'kvm-cpu.h'
Date: Wed, 29 May 2024 07:15:25 +0200
Message-ID: <20240529051539.71210-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

x86_cpu_change_kvm_default() was only used out of kvm-cpu.c by
the pc-i440fx-2.1 machine, which got removed. Make it static,
and remove its declaration. "kvm-cpu.h" is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm-cpu.h | 41 ---------------------------------------
 target/i386/kvm/kvm-cpu.c |  3 +--
 2 files changed, 1 insertion(+), 43 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-cpu.h

diff --git a/target/i386/kvm/kvm-cpu.h b/target/i386/kvm/kvm-cpu.h
deleted file mode 100644
index e858ca21e5..0000000000
--- a/target/i386/kvm/kvm-cpu.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * i386 KVM CPU type and functions
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef KVM_CPU_H
-#define KVM_CPU_H
-
-#ifdef CONFIG_KVM
-/*
- * Change the value of a KVM-specific default
- *
- * If value is NULL, no default will be set and the original
- * value from the CPU model table will be kept.
- *
- * It is valid to call this function only for properties that
- * are already present in the kvm_default_props table.
- */
-void x86_cpu_change_kvm_default(const char *prop, const char *value);
-
-#else /* !CONFIG_KVM */
-
-#define x86_cpu_change_kvm_default(a, b)
-
-#endif /* CONFIG_KVM */
-
-#endif /* KVM_CPU_H */
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index f76972e47e..f9b99b5f50 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "host-cpu.h"
-#include "kvm-cpu.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -178,7 +177,7 @@ static PropValue kvm_default_props[] = {
 /*
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
-void x86_cpu_change_kvm_default(const char *prop, const char *value)
+static void x86_cpu_change_kvm_default(const char *prop, const char *value)
 {
     PropValue *pv;
     for (pv = kvm_default_props; pv->prop; pv++) {
-- 
2.41.0


