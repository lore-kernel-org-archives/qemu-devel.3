Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5910CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wUe-0001bK-86; Sat, 04 Oct 2025 03:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUG-0001Dz-Tq
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:25 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUE-0005KQ-Mo
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so22725795e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562121; x=1760166921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d11jXMzNSLNsrMSr+ncGCM97av0F6CGJZ7JjKGpji38=;
 b=hJh6bJ2nrQq4FyopJe775QOBb+oWBkwWh6MNkbhoSjc8MhSiHREaeZQ/O7UyOOabvw
 DaYlsNFdcYXogds4pnk/Iuk+yQTKC1pq+ecUlDmryiJlSmGJSkeknVytiY4ZVWTqzp6d
 7Ddp+mdfOXIwpwqMHaIigcuysnlEBEBsTvUuf286XdvKs5svV+ooJxZrH41bISrmdx9U
 b/0rXLehSHnIHowfH/t+smXalOUjCZ5+j2F4/mvQV6WeCVZiJhX4TwPrrkzc/r3NIqGZ
 pzr6wcQsU8bUzRW42DJUGOma1DvjTQkHf6XqiaxtJpFm0+MNZ63X4YTwWHIeMp27LiWc
 rF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562121; x=1760166921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d11jXMzNSLNsrMSr+ncGCM97av0F6CGJZ7JjKGpji38=;
 b=fdhRDTd6maFfdAiKp1X4LaFijuQ+uqoKHfh2dlQEHEAl7eBIrOpIb+5Dav2nvfSXf1
 CQFcrus6kD7LIsDjUs9CHu+r5CzHs8Fd/4BaxfDNW2OoxC4rabiIPvq9XKWM7L6njfx3
 9F2K86PBU+LupmI+Y6sVzHeyutuf4V7Cv/L16lrTon6vffkCcM168pbkSqSRE8GgaOno
 CehhYhDDlM9bg5st4PReFhrRtSKm/LDGe1gpiWPP278SKnE6BTOUMgxEQ73E4mqtPhqZ
 FMjC/uYuXe+gZJ++QlPb9m9ekOUzOP4QqnXC0vMhJpyQ5oSEYUMZZ8Nuj+LiKpPMsIS1
 gm2w==
X-Gm-Message-State: AOJu0YxgQSEwzoTXFgCltutxcN9SAS0H4x2fTm9opQbRtwcdGaFFJMrl
 fgBCjQV7DwvcbrLif2GkKFypcpyi7y/t4g7G3sPvJ/SBNX+MNDdDLclRxyszOTR6QCzNSpofs3B
 UdaSTSwqDGQ==
X-Gm-Gg: ASbGncuGRvTGDNDOHR4nWNXDBQ1AwCi77FlXafXiSMt5Hjtbr+nHvtxYri3HlY96sXN
 D31GuCM/CRoHu6OHnb0TTFi1+FkCTFt6VJGMNNLOX2GA2nYW+SCHBO7Br9MTvKHDWHQqj8iIzfE
 okUsirCqmW1gGVm68bTuPsQPDYYWm8DXppa/gPvlmpKB4k1tk2JJLA4SZzoR/uWNMZLLJIppeIy
 osyuCq/As9KM5JpPejuh5O6yxJS8aU5cNIPdCnIe7Rejsll+eHBi9vItWOa2Uuc8+J2qcsY4kCt
 aVdqSfI5vJL1BT//Cb446b9kAySFpaI+KFByPvexb+PjQktBp6Yeluti2hvsuXCiRJz767cDPah
 fq3GM9ZPq/SoJzL9EyK2ZRcTfQEOLiEsfuVt4SI47c08CTlGy3Cw4My2zRxmy9uIwDUbuH5nvdL
 HDrczG2weGZIXplQoPE04Am00A
X-Google-Smtp-Source: AGHT+IHQ2EL+t+pPTz2EdewJiQA4o5o2AzMHcSW8ejRL1721W+mhwUxkvfvkzT3yKOBBo/k2K1i67A==
X-Received: by 2002:a05:600c:1909:b0:46e:326e:4501 with SMTP id
 5b1f17b1804b1-46e7110aecfmr41625415e9.10.1759562120729; 
 Sat, 04 Oct 2025 00:15:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c49sm11132009f8f.3.2025.10.04.00.15.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/41] target/arm/tcg/mte: Include missing 'exec/target_page.h'
 header
Date: Sat,  4 Oct 2025 09:12:54 +0200
Message-ID: <20251004071307.37521-29-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The "exec/target_page.h" header is indirectly pulled from
"system/ram_addr.h". Include it explicitly, in order to
avoid unrelated issues when refactoring "system/ram_addr.h":

  target/arm/tcg/mte_helper.c:815:23: error: use of undeclared identifier 'TARGET_PAGE_MASK'
    815 |     prev_page = ptr & TARGET_PAGE_MASK;
        |                       ^
  target/arm/tcg/mte_helper.c:816:29: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
    816 |     next_page = prev_page + TARGET_PAGE_SIZE;
        |                             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-6-philmd@linaro.org>
---
 target/arm/tcg/mte_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 302e899287c..7d80244788e 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "internals.h"
+#include "exec/target_page.h"
 #include "exec/page-protection.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/cpu_loop.h"
-- 
2.51.0


