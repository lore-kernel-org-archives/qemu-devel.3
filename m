Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110ECC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVEb-0003NS-R6; Mon, 10 Mar 2025 00:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEP-0002xc-IY
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:13 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEM-0008Ht-N3
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:13 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso5724933a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582749; x=1742187549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yo5TAW5cQeh1DHP1d5HtuffIuVKJac+rUoQhULbtd80=;
 b=jLPqevBtlhY7745DKYvPHrRFxIFvApoW5Sal+uA+E2NTEbez2Qc4GUaEoDpLXoE34U
 +gbOrOh+awYNhahSqzxyPecPvCd+E/qxcm2x1xdwEbnC91krU9iYUYCdK745ub8/Dwch
 DO3u2zoVwar4c9WDX2zqxD8peyjJUtjEyO8mtsrXX1AAI22tf8BnTpfG6Ai1FLODEbCg
 e81B2IWDcm3CVd8E1lm6VoeykiGI2OdpBUkqb/oCmOq/dHcFeJ3KfneyG96NISUQ+UHE
 PPRND3AQ9ZY8yuH03DiQMRhcz/BU6pWTWCkT0zuyryj3aoXfa7v98JAVLeQ0mvt2vbnB
 awEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582749; x=1742187549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yo5TAW5cQeh1DHP1d5HtuffIuVKJac+rUoQhULbtd80=;
 b=K2kCUD1cPo7a1jrNyTXhRx8ZCYmj6wdRkjHKePbm8R1zyOUsBcg1CgtHrWuMUosIdj
 9f46Fz21rs3JAYYXH1Xk8E+dkL7MeeoYmUY0r+Bd8xB8EyULLGy6ruxzJO6cY+5fmZzk
 KgvnW9I5z165mIb3Olrtn+I62UaHKnfafO7l+XWawXHRLg//6PK9aqgGGzvitQyr+O/5
 qbiKL1ghahsp1N9z+yFxGQoATuVJ8zffquPwPYxwov8uUcxGvsXeN4m4BGfgFjReYjkV
 4mNIu+SYnGy0eD+RYlHdYaWfHWcb/q1oCL6BoV+9QNt26iHRNifsoqL2ERwWqZv/gh8A
 YHhg==
X-Gm-Message-State: AOJu0Yyo4HpjBEf0j6+J2fcMk2HpS8BTp7PKbdaMJegduCbiS+i/BNkh
 ASN4L6y3BMNlbO34+HKA7vMZmlpDp3psijA1iluMhmAzunhXCOo2Ilflj78AA5dO5k+Z+V10AxI
 1En0=
X-Gm-Gg: ASbGncv6663vFBg3hLyuTHGI7Z7Zb/mMIi0rWBWticNSfWJqW9d81JPo1rSZg08qk54
 SR445mH0dqv07S11kd4ft5NzKJcyZxkrHOGM6pnIIglobR6Kg8PXgNYiMDRtL7mAUrVHlUNssO6
 lcsMfgwfAQjymdrSz7lG7+7Y9fzWCUGCCqpuEoeDs0I+MmjDZ+vuiX6arxpW5E4Chav1O08++db
 tshlcUEg9BLw54t0Mgtqaab2tGZJQDLTsMgF/FJz6uUsn+DcUq1MJEPs9iJP8JeZaaHA3IWVTIi
 K1c2Eb5AJjWfXxrt5od8teNS0fyHhkHWtOWX1mUy2xKp
X-Google-Smtp-Source: AGHT+IE5gWrqVh7MPBsCW9xpH4WbBfOw86WZFsUWQXQSa3FRghy/XQpC1OkuRKA1xd7a02NCd2RqPg==
X-Received: by 2002:a05:6a21:6e93:b0:1f5:6e00:14da with SMTP id
 adf61e73a8af0-1f56e0016d7mr7868375637.40.1741582749217; 
 Sun, 09 Mar 2025 21:59:09 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:59:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 16/16] system/ioport: make compilation unit common
Date: Sun,  9 Mar 2025 21:58:42 -0700
Message-Id: <20250310045842.2650784-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/ioport.c    | 1 -
 system/meson.build | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 55c2a752396..89daae9d602 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -26,7 +26,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
diff --git a/system/meson.build b/system/meson.build
index 881cb2736fe..3faec7e4dfb 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,6 +1,5 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
-  'ioport.c',
 )])
 
 system_ss.add(files(
@@ -12,6 +11,7 @@ system_ss.add(files(
   'dirtylimit.c',
   'dma-helpers.c',
   'globals.c',
+  'ioport.c',
   'memory_mapping.c',
   'memory.c',
   'physmem.c',
-- 
2.39.5


