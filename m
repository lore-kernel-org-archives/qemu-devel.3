Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCDCE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfic-0002cY-Fe; Fri, 20 Dec 2024 11:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhV-00088m-OL
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:06 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhT-00086j-CO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:05 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so1120684f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711481; x=1735316281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxugupw79htvaUw9aq16HSGO4uyraCdzCFFHOSWBluM=;
 b=Eo4/UI1JCIK4e3cfZFBRUV6Rk+lkSfARgr6HpRifS2Rdjo1fxfpTlhDDLsRl1Qp/q6
 4GAu/CKLe7i73yNcAcxpr/OgAc4f5JcxR2h/Zz2nxHJ59NMnJJiKfr6ZZj7TuknJnDrW
 CE236KCFxv0RCizN47dCg8MNbUVBsGesVTuLZKpvOyVv9ZhHR9TASnndqNANsXfswq/4
 kM69gA9o9gGlClY8tfDxZR9znvsQkLNUztVMdv8g8tH4in16eZzu0LgE/eMYIoOqtT//
 IQfRA4lnOopwMq0y5v1HL0/uHE/A4R2WlZXXMp6g41lvrrL7F0sFx73DHriFqBvnhzpr
 MK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711481; x=1735316281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxugupw79htvaUw9aq16HSGO4uyraCdzCFFHOSWBluM=;
 b=rFxJjWI7H+QJIKHH/bu0lZIrJDdgf4db9PbvCe1aMN9x2mVCsXG0rgzYRf2/c0WcFb
 MaCe8Bdhf5PEv2nUfjSanzrmcDCVbsIKobj8X3KW5eVNM9k9gDKpuS6OcLVyTZPA5/Pe
 Eyej92TG+Z6znQ1yv1ygGr8mAFxwxeIvbHRYGvjnJ1gVK3MVrGQqTm5DCKpR/jZDmAsi
 68PWMPRP9M5RO4GFKM+bb6ZDhEtKf1GjRMjSAyibtXG52RR81Jh21bAH9sy//imjJuml
 3l8Bl2mLCEkB09xUh+WhHKAXHqcCXs3gIhZtX+HYmDnILz66wS6S3Mz5tIpR2Z1+FYAx
 vGmA==
X-Gm-Message-State: AOJu0YxWTSNeNR1hTgytjTehHqBFjd5vpb6tQ0WEU85thdgukeDo2jrM
 eVqmccGluYsN6qBGH2P/FwS5MHWaIP6y0wbIjsJmhq7M1OcVqv8UueHoVpc6qwjbiaN2gA+zBXZ
 a
X-Gm-Gg: ASbGncuYre7ggrGuDdbTaNrzGoo5NKFcxgxwLyu0A2bzAzcMe2rRUScsF8aUwz57Kks
 2CJyGx5YbVdS7qs5NgAWYE0SfUBYlUahdZLLXSB5uR6OAP2R4bvqxcalxxpcbqv/+1z2C6iJUN0
 XzgkxtTaK0L/I8hsL4/nX6dBT3NFmRm8zCcsM2zXe5CMShn4kER8ShxvKesXKvUCJoyUmQzxREc
 u2sGKO1D2QezRMy8Yox5Awb1k6XXax3hL8KSoyimw9hkC6JmHy/eRvuTKDqwsW1SLXyBXK3BDg=
X-Google-Smtp-Source: AGHT+IE8RUcTErw97I4wfKcemod9Z389e9KaiIvgOIRRtTwoT3uobKxdtQPhWEbgChrj5B197XyEVw==
X-Received: by 2002:a05:6000:1848:b0:38a:19a4:ca9e with SMTP id
 ffacd0b85a97d-38a221f2d57mr3420737f8f.29.1734711481462; 
 Fri, 20 Dec 2024 08:18:01 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c515sm49866335e9.30.2024.12.20.08.18.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 28/59] system: Remove unnecessary 'exec/translate-all.h' include
Date: Fri, 20 Dec 2024 17:15:19 +0100
Message-ID: <20241220161551.89317-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
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

At this point "exec/translate-all.h" only declare
tb_check_watchpoint(), which isn't used by any of
cpu-target.c or system/physmem.c, so remove its
inclusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-8-philmd@linaro.org>
---
 cpu-target.c     | 1 -
 system/physmem.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 5480cfb7218..e9fc4a5be0e 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -41,7 +41,6 @@
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "exec/translate-all.h"
 #include "exec/log.h"
 #include "hw/core/accel-cpu.h"
 #include "trace/trace-root.h"
diff --git a/system/physmem.c b/system/physmem.c
index c0e95e6f7cd..1459dd15eb5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -61,7 +61,6 @@
 
 #include "qemu/rcu_queue.h"
 #include "qemu/main-loop.h"
-#include "exec/translate-all.h"
 #include "system/replay.h"
 
 #include "exec/memory-internal.h"
-- 
2.47.1


