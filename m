Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71321C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2HN-0000H9-Aa; Sat, 09 Mar 2024 14:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2HK-0000G0-W2
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:43 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2HI-0002TO-Sh
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:42 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5683089d4bbso1940853a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012159; x=1710616959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tC/kiuQFLzAJIELEDb51aw3s24kLy7eDbWP5W63QeD8=;
 b=LrTYXNRcvDKTSH6APYZi8ttX7KMHjSzNikukosk3P6FDhMnOvmM1U5zpMalSoQCA73
 2S8pjOgjs52wILRm1dWrE8ntnCoy+gwqYmaHRUUH8DazlALIz9luec7mumfH3hj5gGWg
 gQQsMcJYkQ+pFlKOZ3JOQVckH0pvlSMK58EykPCJ/kt5xykZ/OIBX07g1MZm9ooidBBm
 z9axii3WqIrSjIwsOUwDv8YPtkbB9eJaRGcwdAayNoB8hYryX7BPUYoA22+PYxp6PeCk
 QwsemhQAwirijWLOB5fFkktJiD8PMGBl7IsiGAkDfHvOVvKJka7g+rcts5KyCViMFFnB
 vNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012159; x=1710616959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tC/kiuQFLzAJIELEDb51aw3s24kLy7eDbWP5W63QeD8=;
 b=FCRRPnOLnE/8fVJPzi7nAqZex91euzM6t6M4Q+2soPYtcib2PPuE1/Pqr+ZVI7y4Nx
 kyG4SD1V6eJWJVuhN7Ycv5Ebfv+2R/CqZI2fKQ9lGvM0BTpvK1OCsJLyQUDtbNoa286M
 7wCBsbYDCRSuMS7X3Bf3khM+qMuRwuAUln8V4Qmxp8wOGszoGkN6h8gDd8wAtjkd7egX
 R9cXEb79ptPuPywxf+J9qE2eJbnhFbKh4HaGNepngxb7Y4siqz1DbAcuCW5wd6/i7yD3
 hr4a6rsM9sI0e3HsqZ/RQrb5WJ8VxaEq7ayTTDradKCFzDFz/rX01ZuZiGoQTV6xh/mp
 h5xA==
X-Gm-Message-State: AOJu0YxUQD5s2aEEJiYs9LnBSr1in7eytjQaLoGZ23fPT7HVB4ztYex8
 cwbfZ4FQuYsi9Zoe+pj6dQ5uQjTQpSAWT/82uOkC04Dk0kXwpuF089FX9AQCAqM9/Mdv4t5BmTb
 W
X-Google-Smtp-Source: AGHT+IHu7iErUaQhb/iOqdqNUztKh6+iIcuL2bT4JOaVPS9pbXCOM/MCUyWhBzpVIGeMmuHeD9ew8g==
X-Received: by 2002:a50:8717:0:b0:568:1b9f:d6b3 with SMTP id
 i23-20020a508717000000b005681b9fd6b3mr1590136edb.40.1710012159128; 
 Sat, 09 Mar 2024 11:22:39 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a50e703000000b005661badcccesm1148488edn.87.2024.03.09.11.22.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:22:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 04/43] system/physmem: Do not include 'hw/xen/xen.h' but
 'sysemu/xen.h'
Date: Sat,  9 Mar 2024 20:21:31 +0100
Message-ID: <20240309192213.23420-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

physmem.c doesn't use any declaration from "hw/xen/xen.h",
it only requires "sysemu/xen.h" and "system/xen-mapcache.h".

Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20231114143816.71079-5-philmd@linaro.org>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 3adda08ebf..6e9ed97597 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -35,7 +35,7 @@
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
-#include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "sysemu/qtest.h"
-- 
2.41.0


