Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EC3C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Q0-0003fm-Nv; Mon, 19 Feb 2024 09:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4Pz-0003ej-8N
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:14:51 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4Pw-0008Sm-2G
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:14:50 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d10ad265d5so44735411fa.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708352085; x=1708956885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=daMydCoKKjW/BM3LMOveVy0d9uKVycJYmVQBhTRBuqo=;
 b=LORgC9+N5hXmGsDhZ7T3uVN+cbwxJCT3tMewfvov5Te5q0EXACBqGg+XlGS+4QPTxJ
 7IpKo+UntF0Fhl6hx/2qmBoJH9rvCn9QP4iOtdD49rqO/SXNM7NFwIYBSwhGcw5szi5K
 bHe09ERo2ZOlE0uNbaXPy3KtqHrDHsf+q+IaSnUIbHDQP9AlrIc6pI9hfmuNjSYq9Fqa
 0E7fZg7fnL2MfXGk3HzYktT0ya/Np/11KmKSPNM4ZSik0IyLuj+d4BvnGvHd0AgUnXgl
 Xw1+snYUdTapNhHH0NJYC5fqwp0lg8nUNwsVwbKz/5d8RVimeL/W82Rf3ErjHCjrPsqz
 5bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708352085; x=1708956885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=daMydCoKKjW/BM3LMOveVy0d9uKVycJYmVQBhTRBuqo=;
 b=K0VL0dRkSDCgN+60rQbQXxHAzkBrCO7nDWxt43thDoe1a2UODhHTbZsXFpegllCPjE
 BPoF4kk9kDmdE3RPV60Ji6PJPdlwP4rRzBwEjdpKfdv4hW7tTZwviNTdIT4dw/fPvmpd
 DyhI2E5yKo1cyizBYahfRKr96vrAmi5UlYv+Af/PDueojdNvTS615GwJVhqKwvY2pIkU
 28DBtP0DdGyT8Cz5Jw5KFGyDe/HXLL8MJQJxMG3nVrSO9OANoIfA7NbA0LzPROwMe9Bi
 NP8QL0FyFmZt/HHzlG6Z+Nwhn0YCTknXoi3LPBAZPXoWTprCB1UDd8hvguC7FscmqkVa
 RSJg==
X-Gm-Message-State: AOJu0YzEnLmu7g7Xqplthgrn6B5bcDgY1WGi5eh8Zu3YlvWAr6q21zff
 S/GCYINgitjLocb/ldSNHf7dglhFdFKNSRh0j+iIfJa4sdAfHtBxBnOqoQvyPlQ/6ezKC0TMgDb
 F
X-Google-Smtp-Source: AGHT+IFAilRjevCe6058c9xDUe1XJi/5FzlEXXDLcFbJHJ8YA+aJL7lvfR89+XQEahFnGOMsKmwffg==
X-Received: by 2002:a05:6512:e8f:b0:512:be57:6dcf with SMTP id
 bi15-20020a0565120e8f00b00512be576dcfmr820919lfb.8.1708352085061; 
 Mon, 19 Feb 2024 06:14:45 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 cx1-20020a170907168100b00a3c456b0c0esm2974171ejd.108.2024.02.19.06.14.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 06:14:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] hw/i386/q35: Include missing 'hw/acpi/acpi.h' header
Date: Mon, 19 Feb 2024 15:14:11 +0100
Message-ID: <20240219141412.71418-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219141412.71418-1-philmd@linaro.org>
References: <20240219141412.71418-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

"hw/acpi/acpi.h" is implicitly included. Included it
explicitly to avoid when refactoring headers:

hw/i386/pc_q35.c:209:43: error: use of undeclared identifier 'ACPI_PM_PROP_ACPI_PCIHP_BRIDGE'
                              ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
                              ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d346fa3b1d..a91f414922 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -58,6 +58,7 @@
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
+#include "hw/acpi/acpi.h"
 #include "target/i386/cpu.h"
 
 /* ICH9 AHCI has 6 ports */
-- 
2.41.0


