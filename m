Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2170FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYwh-00014X-Us; Mon, 26 Feb 2024 06:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwg-00010o-37
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:54 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwe-0008Sr-Ig
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412a882bd4eso1781865e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946090; x=1709550890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teclhIdRp9DBtUYfsv1Nj0vfraIqiRBxDKPN1DGCTw4=;
 b=cLlyIZzyIwzRA8+E+YhA565O3kTpK4rTG7rsM6QpkCw7PZ4T/BhnxDdcqtEljjNp7z
 5nWKqg/28lh9qjXIs7657b9LRIVCL88cuboP6PiV8SAFUrImG3Gl2VpXiYtaCoVrNRhr
 usi4hFXuKy7JUkTRhPv/C35sk0XTJjZdu1CGfCTpgV1T83EZNa5EoXG0YeIGDbtlgmb6
 O4hTn2lwN+3BRKSTNTFzUrnoOB/Ayv7/UcWjcmwM05geqgrOFq80JQi9d8Nhulc58DJQ
 Se1ZobVstz6JqyO+1FvQyCWUjvoTbC3dXMi5/4lb5K0iMwrRWUzhy/dNTX/4yZBXN2y6
 wWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946090; x=1709550890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teclhIdRp9DBtUYfsv1Nj0vfraIqiRBxDKPN1DGCTw4=;
 b=uLsG0SBGk4ow15eGWyQrit9HFhtFiEd/RpYJZSiuFZKt6MBRzb81H3OOhiDPzbAy3q
 WOK4jW1w8mwkB3J6VTR/4nIh2SYCjZ6g3SXbkSoq89U/AXBm+QtxSMRl4duNyZNtntBA
 GCPeTlkdrT2WWGKYD1w5EUeYUdxONldWKdbqchfRcifhRkAQZcPOj1IYxlFATFU0UjB7
 rhzL2SyG9pyyAYb+Jkv9JGpS4P2+I3dzEVMEAR530z7LgH41YjqgWHtYKKQ1HfD9FzH8
 iVWjWsRJRkS8/doI5PYyoY/fqpcPXi/gQ6Y9oEUmgj4FdSa5gakzBiv98BbR93j78eXN
 myAg==
X-Gm-Message-State: AOJu0YyUx2ocZaLpTxBl5B28zMYWHAmPMh0i1tTBC9gKf1QL8qEk6WXH
 9Cq3UPKSyvCizvn1A5HBBtoXKwG8kYSVW/hjaQCJLBE13DsOm6E3gIMr4XGnD7X8zyzx+yn4T3F
 +
X-Google-Smtp-Source: AGHT+IEb8lmEgruTmqOdHDSINt4LCZH94mpBFNVUdcpjkGjXh2rFYin8Flm/Xj4osK87Z9UcAkYCMg==
X-Received: by 2002:a05:600c:190b:b0:412:a266:c296 with SMTP id
 j11-20020a05600c190b00b00412a266c296mr3234019wmq.33.1708946090548; 
 Mon, 26 Feb 2024 03:14:50 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a05600c114900b004128fa77216sm11619502wmz.1.2024.02.26.03.14.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:14:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/15] hw/acpi/ich9_tco: Restrict ich9_generate_smi()
 declaration
Date: Mon, 26 Feb 2024 12:14:04 +0100
Message-ID: <20240226111416.39217-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Only files including "hw/acpi/ich9_tco.h" require
the ich9_generate_smi() declaration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/ich9_tco.h    | 1 +
 include/hw/southbridge/ich9.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
index 1c99781a79..68ee64942f 100644
--- a/include/hw/acpi/ich9_tco.h
+++ b/include/hw/acpi/ich9_tco.h
@@ -76,6 +76,7 @@ typedef struct TCOIORegs {
 } TCOIORegs;
 
 void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
+void ich9_generate_smi(void);
 
 extern const VMStateDescription vmstate_ich9_sm_tco;
 
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 1ac4238f7e..bee522a4cf 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -11,8 +11,6 @@
 #include "qemu/notify.h"
 #include "qom/object.h"
 
-void ich9_generate_smi(void);
-
 #define ICH9_CC_SIZE (16 * 1024) /* 16KB. Chipset configuration registers */
 
 #define TYPE_ICH9_LPC_DEVICE "ICH9-LPC"
-- 
2.41.0


