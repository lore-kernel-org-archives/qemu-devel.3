Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90571CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wUM-0001Eu-NZ; Sat, 04 Oct 2025 03:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUD-00018c-KH
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUA-0005JW-Pe
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:15:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so22725525e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562116; x=1760166916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ObimSgFdkUXq5Hleq+lD7TF64oYZAf0YcsClnFqO4Rc=;
 b=EO3ulMDTOGVaBpEorflpJ6CJKLNUT7VH1vAJSsy8Dh45CapUqMIUWpsmIsRzslTG9N
 FaJ5eWSSsjwmwZeZ8FhlYcNKWPDsN/GRe5yrSL7YnuitvmmugwnttbOz5eZzxtAJHfz5
 i+3VvsdV+mxqyzN5gaagbxGH5yttgStQ7pZ5gvpa/7sxGZv1o8jfuqP5oHHjHF2hVKxp
 cwILsRRoZV1qvksKooPYvPxqLs/8m6eiU7ar02Hlr+KrYpm9qZr1Mc08BNfFHsY9y56J
 GcR1D7rp3+I/5EH5C0xIQb2z7favUZJ00+C3U+CPgE3fCE+fkO276eZ8WtW0BvJeugvY
 HWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562116; x=1760166916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObimSgFdkUXq5Hleq+lD7TF64oYZAf0YcsClnFqO4Rc=;
 b=KUQ+Q+4Ox3kBlCIm+X/w3YHGVxgWcbByTs5lNj96xMBK9hXE+vyiJ04nj1HdgxkEZV
 qZFsGH8U75CI7F54teiKq+wW1rBfnX1738TcEJMrVPdPvcJC3AIrgKZ9xNqis8dAeNRA
 /oTfkq+P+zdROupo7uBsqQvZ2Q5bbLxmYcu/xoMeb8yVEKYizP29MM6EJuNhaZNQsdEg
 Fo45QwAx7JHnzQMLKRYrkzAp25sOAsYRXW7uvArIxPa7gt6A8J0tSSrvZZyu1HzvmoFd
 fU9xeAH4d3hx8XJLbBLYph/Y4IqAwETbC8CMbvXzqf98r1qIyEWAyXn7tWsiKifyPrfu
 /tUQ==
X-Gm-Message-State: AOJu0YxJ7jDpNO3jvw3p22nyxfN1S7JlTgMO8EjSBXGXN4XknD2O+FZ3
 Qg37qqPzcuLQ+AIaWrIEOzpVJS1aWhs62aG5+nkN/zjHk9GOE3SwlEkvO4+Ado7Eg5K1Oa8mUbj
 i7PlHrWauBQ==
X-Gm-Gg: ASbGnctmtu3sWv28vaHP129iGExxHFPpe0FZgwBCO+dUqABzBlPxUxrfXRnNbhprYjx
 bfjtKKlHpV3Gij2bBef9J0C6VG1qbTCpn6SSbtRfFRYM6u80+sQpZqgiGoqBJUkS84jypE0w4oK
 x/Lub+eER1gdRNHRVIhGpXP0YI0UMpxQVviQotlvVj1g88yGpuDwZnePxa/y4QHOtYvArm8fSPe
 iS3cuV3B5dmEAAjKOK4L9V3nfPxL27nJ4efOT7sfVUP5WaxBrwC4BKeEeI27toIpgyKzxGxRLvt
 zB/TTEExnuZQrqExe8ZV0f0ZgaAuIMsqmRS7PUU5RpXCd9CwRyPDwdG7ChvHBI6AhwByZTqZ8m2
 ELO93kJPXE64Sv9IOmqgh5Q/9E1Pe0gya08ivntV/oZwRhLvUqGXgMh7ofs0EupL3qwgqPp0jr7
 VcoXIDl5krindPy2T4yc2bBUkx8CCDIHl6xuU=
X-Google-Smtp-Source: AGHT+IFqNs/OSSYr5+BcMpXjbdAmdweYbDhugu4vY7VaK6U4lebf8xpk7K8T7Uw/edP5NbpLlCExqA==
X-Received: by 2002:a05:600c:19ce:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-46e7110c3d5mr47066315e9.16.1759562116291; 
 Sat, 04 Oct 2025 00:15:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723437d8sm61310215e9.3.2025.10.04.00.15.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/41] hw/vfio/listener: Include missing 'exec/target_page.h'
 header
Date: Sat,  4 Oct 2025 09:12:53 +0200
Message-ID: <20251004071307.37521-28-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
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

  hw/vfio/listener.c: In function ‘vfio_ram_discard_register_listener’:
  hw/vfio/listener.c:258:28: error: implicit declaration of function ‘qemu_target_page_size’; did you mean ‘qemu_ram_pagesize’?
    258 |     int target_page_size = qemu_target_page_size();
        |                            ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20251001175448.18933-5-philmd@linaro.org>
---
 hw/vfio/listener.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index a2c19a3cec1..b5cefc9395c 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -25,6 +25,7 @@
 #endif
 #include <linux/vfio.h>
 
+#include "exec/target_page.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "system/address-spaces.h"
-- 
2.51.0


