Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E63C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYwK-0000XL-KY; Mon, 26 Feb 2024 06:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwI-0000Wj-V3
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwH-0008Qr-Bq
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:30 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412a4094197so6697175e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946065; x=1709550865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7CkfeTkkLz7+ZUpKzfJZ9NMY5Cg7S1z+LPXlC7Yofg=;
 b=iqj5IHUlr9xa9BsC4VDFMsZSvqhzpedeCzNMbMW4iCyDL22+TkO5/IQ/RbLxORMwg/
 CkpBbwzijpv8OcE4iD76kqfl83W+gETc1Q+omFqPbA+bKo+ISR2tvNABTzW+CsCRTvjd
 yHrOSuLAQi4fjWrireXB+e+YlPhe5kzrOjup1QFGG1FV2Olsf7wcSIHzxEz8OGdoQ7S6
 tQhroPjwC1pnpFKzL3yleo4PeGHRWlt+mIEaPuJ/uZNUawDjhPi5J00yjT4POifXnsRH
 0xMsyWOGTZrzkoMn7NhFfLi53KpuFij/S/ALk8NMukaFpJn1i3BcP/tRF3nIfMMtuKBw
 z7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946065; x=1709550865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7CkfeTkkLz7+ZUpKzfJZ9NMY5Cg7S1z+LPXlC7Yofg=;
 b=keX/MUsovHtx3K6lSs6iqmwFcj5iTg0q3lnehYhyrGnf644Ry06Ih37gThWxRCz0N5
 OnmPVpQF6/+RJkHNAa68u+JXIqY3tFLnrOg1Dsk4yH9JwdifzDChQNTRJrgYIRfxuubY
 QEW5A+safMHrPKXJTnpn71Fy1vP+XBrEjC6xgYgQ+Yfvi6+8Pssl7xFCDfmerJiEkS9o
 KumsmIL7CN82EWM/Qrq3u9gRZct16OpyyhtXrwIxbI4rrAMW0Cakcci7uALHNXLVAZEH
 TPxbdAxzYYpsWPMrCV4rB9n8+MxB1H9+WQFOQifV7CBVGe0Xi5czEDcfnEBWAQd+2pRz
 R/GA==
X-Gm-Message-State: AOJu0Yy97iihB9595OlQM/x+hpH7YK7GFUT7Io4hnCjPJZLrlgZl+gix
 i97GSAY/4bM5KxS0DSqCrFr3pcJwLBEAaPgypsJPLepyj+UOX7HUnjDUrguLaUiTNOm58uazwsW
 K
X-Google-Smtp-Source: AGHT+IGIwat4w4kN/7uF1cOqvUYNGNwOvsyPqqrh2qdU6LfwRwvpObPpmICKQtgirbCVvbcuTe4rdw==
X-Received: by 2002:a5d:468d:0:b0:33d:14a7:c4b with SMTP id
 u13-20020a5d468d000000b0033d14a70c4bmr4358586wrq.40.1708946065528; 
 Mon, 26 Feb 2024 03:14:25 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 bv15-20020a0560001f0f00b0033d47c6073esm8012835wrb.12.2024.02.26.03.14.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:14:25 -0800 (PST)
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
Subject: [PATCH v2 01/15] MAINTAINERS: Add 'ICH9 South Bridge' section
Date: Mon, 26 Feb 2024 12:14:00 +0100
Message-ID: <20240226111416.39217-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Extract 'ICH9 South Bridge' from the 'PC' section.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 992799171f..e3f14c28a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1816,12 +1816,7 @@ F: include/hw/pci-host/i440fx.h
 F: include/hw/pci-host/q35.h
 F: include/hw/pci-host/pam.h
 F: hw/isa/piix.c
-F: hw/isa/lpc_ich9.c
-F: hw/i2c/smbus_ich9.c
 F: hw/acpi/piix4.c
-F: hw/acpi/ich9*.c
-F: include/hw/acpi/ich9*.h
-F: include/hw/southbridge/ich9.h
 F: include/hw/southbridge/piix.h
 F: hw/isa/apm.c
 F: include/hw/isa/apm.h
@@ -2614,6 +2609,16 @@ F: hw/display/edid*
 F: include/hw/display/edid.h
 F: qemu-edid.c
 
+ICH9 South Bridge (82801i)
+M: Michael S. Tsirkin <mst@redhat.com>
+M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
+S: Supported
+F: hw/acpi/ich9*.c
+F: hw/i2c/smbus_ich9.c
+F: hw/isa/lpc_ich9.c
+F: include/hw/acpi/ich9*.h
+F: include/hw/southbridge/ich9.h
+
 PIIX4 South Bridge (i82371AB)
 M: Hervé Poussineau <hpoussin@reactos.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.41.0


