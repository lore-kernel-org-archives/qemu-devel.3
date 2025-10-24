Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A43CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNQP-0005BV-6Y; Fri, 24 Oct 2025 15:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNQM-0005AW-2e
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:26:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNQI-0000fn-5Q
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:26:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so22778135e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761333960; x=1761938760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GwqgehZVsbFB79GaS98pbRrXCd0QXF8i259SKWhblxM=;
 b=XYRepmdlGkijcOWBIfqpPxWxLb12s/vIWQPLqKDdKaqe2ZjZa2L6yuAutIpItVwap4
 1iuCRgAjSwrSoguNJVwUi7CbovCLZJmKPMKFb6XeHtfVf/eFw0BE94eLsFQqNWxGP+k3
 hdYFTcrrlNzoaJVJO9SsCNi1gl0Lvd/RbxVMUuTjhNAihIhewRVfN+CNytnHwWM3oVQV
 9O46uP2BX7FEJiOy0Jd4Jt7Wjy6bnRLpBCagxS34LHH3ZxFqzr2pQpvqLQMOa6dlI6PA
 B9XMW+9EProQ0IXJBdyP7H5f6zSpXbpAyv9OIzM5s1zgHY0A2aJTfW2uYLQndsELIxTb
 qEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333960; x=1761938760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GwqgehZVsbFB79GaS98pbRrXCd0QXF8i259SKWhblxM=;
 b=sVg0ao1GLlRYlV/INORDoZOHehPfFbBe0Bu2hmZRN1cNRkUPYlUNiESUddSg67+dRx
 bOxV6sxcn3t8pyPIzctPb07XVYXlld85P5r838he+9OAlzP9Nzvm2015P7eghKTiWjm9
 f5UzxmbFLoJpcFbZmURcxh7lA3wEt/1dcmrhtdwdlZYoeVFZc99Rwe+oYGIyTvIXvKGs
 h39Afn5MIUUtdgtX3cNkds2UVCNzhAEoLPYZbOtQTg2nz0tk+EveW8QtX2PsARUQ/kHk
 TItF24ZtqAxgd1lxG12c/MODRvNqxpBIitxESo1mjr8qTgBMV3RihTrqQ5GXN5TfYvAy
 rKHg==
X-Gm-Message-State: AOJu0YwvjIPwj/tUG0FIbFgLmTpkIGEysGiKIbBNg6mVa750AkOA2WbM
 egvOKcF5SGHbFnH8/YXiKqzXTGR9hn98b94sCTKlbkJD5m89a66xtMdVlsirCSGE481SR/Ozb1x
 ntxj8638=
X-Gm-Gg: ASbGnctIn6hQpEcdUkFFn5UT3oiIIhLI/FlEnjlOYVWdklWFNCFTOWfFuvbEIAuFRbV
 k3mCMZsl2lpxG9/ZnVOQ8M0BnInfpKEDylLOIRblfzp04fAHDXV7gX9NzntzakVS8jkv4blb5O7
 W7/Eq5yMiYPkWQORjBH/kugYzLVajqb3KtksGhKW83pfBEgJOHrKlOFhlmX7EY99lZWb46aSCvl
 Y7+ejJ6C0HK6/TDWJeKryfp5R6plEJtqjUhC5faylzonGhQRqia43c6Dq1ttsEoA2DR98HabDxt
 lr4SiIjKJCwr3btwow4MwytgmGNUL29WpBrLfU6P2v+va7tmlpJO+dOXwXwYBkRhs9tBOlkgobg
 abelcclQmoLfMEJmL09zz3rnldkiYmpvVi5GrzlpWGwSOBh9379zKb/WazK7rFCU2G3gw8Pc6QP
 efJbVbxktibyHdJ28dcqaquZc+JQgBjMLmB66qb/69WymMuU0zB7bp6Q+wC0C3
X-Google-Smtp-Source: AGHT+IFv2AKaZqiIcY9hzI5VLODEXV7jQcDdGTX1gQrQKLDL7Dwnu/U9sRqTvNe4mwY4DfrAuB5tAQ==
X-Received: by 2002:a05:600c:3e07:b0:471:13fc:e356 with SMTP id
 5b1f17b1804b1-471178760f8mr225087775e9.3.1761333960082; 
 Fri, 24 Oct 2025 12:26:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429930e35casm1914582f8f.30.2025.10.24.12.25.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:25:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: [PATCH 14/27] hw/usb/imx: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:04:01 +0200
Message-ID: <20251024190416.8803-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  include/hw/usb/imx-usb-phy.h:49:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     49 |     MemoryRegion iomem;
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/usb/imx-usb-phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/usb/imx-usb-phy.h b/include/hw/usb/imx-usb-phy.h
index d1e867b77a3..a267c03c7e1 100644
--- a/include/hw/usb/imx-usb-phy.h
+++ b/include/hw/usb/imx-usb-phy.h
@@ -4,6 +4,7 @@
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 enum IMXUsbPhyRegisters {
     USBPHY_PWD,
-- 
2.51.0


