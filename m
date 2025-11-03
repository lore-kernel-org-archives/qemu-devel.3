Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0B6CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrXk-0003Ax-OI; Mon, 03 Nov 2025 05:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrXg-00039m-CX
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:12:05 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrXd-0002eF-Gn
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:12:04 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-475dc0ed8aeso28578655e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164715; x=1762769515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYZPdSjIdF/EKh7X/rENMynZwEwjU3Z8rLiFolDwON0=;
 b=AO7j00GncKNzj+gAvIFfjc4XQmXMvsmLqYnojBrLrydetbEdcoyC20xPIXr3+1CrKc
 IvdOHOhg8QH7aeQkpUOqHgxUSmukoj+FjX/XZgggT3mrmyYuUezN/q6NV57wlUR+o3qu
 iQoCykBpekl92nz3VT+LgNZA+d5Pv3e5wjy9NyUt3QTCXpsld4q+Q0zxFYdOLihlbSvq
 O0nJVYpTbmvIoqHyQySocK77DJbjw0JzxIkj+vBoeO1/vN2cTr9eGz0rwxQQbIFLFgjA
 +Qe6U941hiUheO1vdR9UPJ6gFIfzHrQPB0CB3796VvSF7qBoRMwDj8t7TFUNWdTKTt0p
 CPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164715; x=1762769515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OYZPdSjIdF/EKh7X/rENMynZwEwjU3Z8rLiFolDwON0=;
 b=FMYXlvrZ9bK9ZcWnHJ5clxHFTrJhsANe6dJDb385X9UYrjZEuoa6apE/n+G35dHMEP
 BV7fmtFZEXxCRJyUv+NTlxEa4kZy7oNl1XXWQDg6vD9PlkJ4tCLkLZnOtq61fBaX3cr8
 Y3OwQI5AGTaPlJJBpr9UnTqIl5BPy9Jh3PkzLcASUUcsEyas0G6BlEp7QUTQZHa+SpLu
 vcplg3BnkyM3aUWFL4sWNZf60ZQ1c6lA8MKpQzFfp56YD5SgqtygPQpAHGvPURa9TvG7
 9j9j2mF4LpMXjQ8pq/3NcZWNTKQO2/4Ql246PRQNSBp8MFF6DSQ0FWaXftkSqW3ffmAm
 4okw==
X-Gm-Message-State: AOJu0YxkCJk1A6cwvVCrRiPoYJ7tSsYQCFVaIUTulHeeWXcyzCTVuzEW
 YRA0obqCwvBVxvDDUg0Un6FPE110oobX38HtZCIVoEL2dEndkW998A/O35Kb/sFynnDRQ/4VNop
 sKd5C3Ns=
X-Gm-Gg: ASbGncs5GHkxbi2yhJYSCvNKEzJxYFxJjkPDGF+09SNQtPZhCyCTm9x1L8cRNp3N2Km
 T3smSac+5vMrKnLfHK7UOpb9DCUgB+tnnf7xSozoZ6G29B7ajgT1zyI6CI0/OmdpKCyUWFj22Xg
 gTVvUTogZDI/3kt3nhxbwmgt6gHQCE8ySpjzImouzumBnM4lsrya88DKupzJGYXO13vmYNKwAwz
 xZtSKV9SwLLMYClcEgmWozS8dD+VjaMWXM8ZMC6pAr03VzJAbSofz3B785ML9QNcLNgPoUymVFL
 UDscCFuoeu9z86BtyBuVTFHzgKn0x7pOO3l1F3GM7T/DtuXf0FEdSTPPLIe7MmnUKSxNaEbSmKS
 qJPT83+FdC/eoSIagjNUUJ5CPDNsY8P58zOz26oa8S037jNQj3SMDqxnMBmXnMunTwLMEKDDSuO
 9dOxWOuseIMkCmp18L3LYtG2gS2XQey5oBBoiTe1cyFJQ9CDgc1R7Se8koDlc=
X-Google-Smtp-Source: AGHT+IE+GJDLMYtFJNOPkm7KPKOTWkGtSs0/iFcriJ/W7Vb/SOZUWpfZ1K4+zVjOEZbqm0RD3Ijzeg==
X-Received: by 2002:a05:600c:501e:b0:471:152a:e566 with SMTP id
 5b1f17b1804b1-477307c2944mr99799625e9.13.1762164715408; 
 Mon, 03 Nov 2025 02:11:55 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c394f17sm147900045e9.14.2025.11.03.02.11.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:11:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 03/23] accel/hvf: Enforce host alignment in hv_vm_protect()
Date: Mon,  3 Nov 2025 11:10:12 +0100
Message-ID: <20251103101034.59039-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

hv_vm_protect() arguments must be aligned to host page.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index e13abddbd9c..cb029e4dd4b 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "accel/accel-ops.h"
+#include "exec/cpu-common.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "system/hvf.h"
@@ -61,12 +62,15 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 static void do_hv_vm_protect(hwaddr start, size_t size,
                              hv_memory_flags_t flags)
 {
+    intptr_t page_mask = qemu_real_host_page_mask();
     hv_return_t ret;
 
     trace_hvf_vm_protect(start, size, flags,
                          flags & HV_MEMORY_READ  ? 'R' : '-',
                          flags & HV_MEMORY_WRITE ? 'W' : '-',
                          flags & HV_MEMORY_EXEC  ? 'X' : '-');
+    g_assert(!((uintptr_t)start & ~page_mask));
+    g_assert(!(size & ~page_mask));
 
     ret = hv_vm_protect(start, size, flags);
     assert_hvf_ok(ret);
-- 
2.51.0


