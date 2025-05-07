Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F13CC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 20:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uClcp-00030y-Hm; Wed, 07 May 2025 16:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uClcn-0002yY-Aw
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:44:17 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uClcj-0002ms-MT
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:44:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22e7eff58a0so3445805ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 13:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746650651; x=1747255451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MGKhtEtKmIv/iqo3Q0C370p+aaMvKjOJBkZGTD/hQ3I=;
 b=CwfPyzeDpKPb/SapfzhWcYuOZH+wqDkyCPa1tKCJGvoO/T//OCUK2q3lna8CMcQdJQ
 GneB4z1dS2Em3dBdx+EbITnfH4spL/iIITsFnvnQFsWYXSdvgTbHKzIyis589hJqGwiX
 rKW+270B5tfie8wmbqpYszibYVb0yfiRgwxqZhTAA/BYrU0XquTEbBH8yU+56Kq8Mewk
 Jso6ew6z5BysvjpOVbACyVZcwVm1WgUF0ZylcLzDykWmBoTQafEECFd89Nc2HTC50gHl
 DwUrVMrV/XIXSdIgD1QPVMnw/VOZY4RPoEnMpUkP06fWi4WfdAShNcoy9VGPR4LyaDgS
 Lsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746650651; x=1747255451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGKhtEtKmIv/iqo3Q0C370p+aaMvKjOJBkZGTD/hQ3I=;
 b=IHc5fURXgbr0c98blXMbfODKoousmkWxpOUFhAeHfVYjz6byptHHDrVubjFZw4K/Du
 rB3nER0rHy5yGTY7DUM4G/JBHEW7sLjsUWiWBrwY2CRsVF6GTXLc+4s6tqCLYKN4OnuT
 VQsY0bPHVu6DN3yr/WYJUgCX3qRo8gxsQsXClEC5qWbUBETwzUbTugLxIKCei1CMsP7r
 8XpZtU54zexVUr9R6nzCCX9+Yd+ecWgHI4uO7SX9gmVhNSjRhPSZTR32BQ2oJ9l7/RnE
 YbLtLCYekUCAyiOTol2BB38YNuTS6v00/7e7qmClfHsG5/zd7d+M/T3HBntyFZ8DiseK
 Z9gQ==
X-Gm-Message-State: AOJu0YzlvB606IF1L05NA9opu/wOCLLYXtUYwr/uaKc3sOI5yHPoXG84
 SgjqUp7lpzNkwm+0e6VJeSHo5mEhBXmStwdfNxHhD0EyaskjFXsSeY0SvzoofOTr8c2q9hx4j3/
 ny+DUIA==
X-Gm-Gg: ASbGncu6dkZiQbSfzhX7aXvzuuk+S72UJXC+lNz3fSi9s6/LA+2DTkf6TQo0RJiM/Rq
 dBB8e8ZP5503sPDU8BuZLnTo1fWRP2Hj/5bpaUQzHNzWuDDeChiZr4LWaWToJUDXJCG9uPFFutK
 u924RAsU2vNthzOadS8Y5/xKy7TI6YrcQTeiiTv8vfEsc8VgM9NMCoAto0hbhjeDb+1MpfEoAD+
 r6U3GzbzyBw3jf+GDPqtRrKbb9fvhlFihDuEhKsjBKDfoDx0E++ScXPeDOtYEFMO2guyXZw2r4M
 35h5dic9aP5n/vkfdNYKjHmfJ2Sb4gzL30IJu5p11/4LFIQtJvuPBDN7fdHjE5NHVqtqN0+Te31
 YlqVIfn8m2kz2bItMiekF
X-Google-Smtp-Source: AGHT+IFlaXJh+QHwB3F75bEgVdpum6WfURuIe225/7BiQVyhHz50dF8mwAW/LIQA0YDVItLZiAQ8Aw==
X-Received: by 2002:a17:903:1a45:b0:220:f151:b668 with SMTP id
 d9443c01a7336-22e5ea8a5c2mr61177045ad.20.1746650651320; 
 Wed, 07 May 2025 13:44:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522a7e0sm98817315ad.208.2025.05.07.13.44.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 May 2025 13:44:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <m.ynddal@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] accel/hvf: Include missing 'hw/core/cpu.h' header
Date: Wed,  7 May 2025 22:44:01 +0200
Message-ID: <20250507204401.45379-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
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

Since commit d5bd8d8267e ("hvf: only update sysreg from owning
thread") hvf-all.c accesses the run_on_cpu_data type and calls
run_on_cpu(), both defined in the "hw/core/cpu.h" header.
Fortunately, it is indirectly included via:

  "system/hvf.h"
    -> "target/arm/cpu.h"
         -> "target/arm/cpu-qom.h"
              -> "hw/core/cpu.h"

"system/hvf.h" however doesn't need "target/arm/cpu.h" and we
want to remove it there. In order to do that we first need to
include it in the hvf-all.c file.

Cc: Mads Ynddal <m.ynddal@samsung.com>
Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 3fc65d6b231..8c387fda24d 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
+#include "hw/core/cpu.h"
 
 const char *hvf_return_string(hv_return_t ret)
 {
-- 
2.47.1


