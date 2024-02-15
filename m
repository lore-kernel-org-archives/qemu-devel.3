Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505A3C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag1U-0005HY-8F; Thu, 15 Feb 2024 12:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1N-0004qO-Vp
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1J-0001nf-1p
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-411d3c75026so9345805e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019973; x=1708624773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtVnVdwlMQuIF8ap5e3PdkZeedjV1hEn+tIJt0DtjLY=;
 b=fNq53DwwyozzifM4fusy9oRP3ZNj0d5/ACedKnJ044ajwG57b55IEnGXx/ffhGobOl
 kUVZb4Ku0ezhM0pqZpxkRlFY0k1Ex0U8Vbjm9swbi3n1FfwA719dh9k+bxyIx+RE7Mbk
 u+XtgXTLy48LqIaIfJrG0XTU14k/jPf7U4WzqTsipg6rkv3x3e4f/CF6mTTv0R4XjgYw
 /kKiQIktqYaTVu2rOULaRP6gNXSMB14eYCswdoQ0cHKVvS47JFwicYCpjWarKfHvnMfR
 j5mmw5uYZkdksp4Vztb1xUgeWXD3bu3bOwOAP4YwMPYIwgXnrPGUrOAvWvIDh0UKGdW4
 uQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019973; x=1708624773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtVnVdwlMQuIF8ap5e3PdkZeedjV1hEn+tIJt0DtjLY=;
 b=XkQxQckpfA+WDqZq3ccMXZKQqq6+abrvEqZc+apQle5n2kGiK9xzXwErnRZBv6/2t0
 Cgq/JJ3XaiML8O1/eogboXQAJ51BUbv7rkQkwjW25ng2EbKvV+fnIXgjA0Cc8xXSjyLG
 8dQZJ5lzx6zPSFdB/PKhTvw9aik6Tc+B9jYi8v8TNEJn35w7VStFo/6b6NNKUuv8ouE9
 s4kDizOifBgUXNgh7Wqba62SKs5Ud/L/rwCUi3OGJd2eAVc0IKQO3qm6RkvOneVnT8YU
 mqMq/3eunCNpmVTLjBwHfJVjgco2bxMOD8ZZeXD7D3V/OFDPTZIgKRjzdrHQOLo4DGZF
 utKQ==
X-Gm-Message-State: AOJu0YyVMvke3rd6GFQaz5KsGu8h3NTVxkBu7Zvh6XIcpf0Il6HaorAx
 CSzJxSMUjM3hKUjIAMRnT1k/jyTL71fDBjWsRgomB3LJy8Q52DVr6/0EYdg2u9lMwK5ar8lQ6bV
 TxB0=
X-Google-Smtp-Source: AGHT+IHFP2IUSHU86IgQIfwZmfvgEdNXeM25+nL7wFo1X2xlQzAHeVVsANbNFTr0nc5/2OsoBiZvCA==
X-Received: by 2002:a5d:5591:0:b0:33b:2835:a1fe with SMTP id
 i17-20020a5d5591000000b0033b2835a1femr1891387wrv.47.1708019972776; 
 Thu, 15 Feb 2024 09:59:32 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a5d4081000000b0033b6e26f0f9sm2427415wrp.42.2024.02.15.09.59.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:59:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/56] hw/isa: clean up Kconfig selections for ISA_SUPERIO
Date: Thu, 15 Feb 2024 18:57:09 +0100
Message-ID: <20240215175752.82828-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

All users of ISA_SUPERIO include a floppy disk controller, serial port
and parallel port via the automatic creation mechanism of isa-superio.c.

Select the symbol and remove it from the dependents.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240213155005.109954-3-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/Kconfig | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 040a18c070..7884179d08 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -17,7 +17,11 @@ config ISA_SUPERIO
     bool
     select ISA_BUS
     select PCKBD
+    select PARALLEL
+    select SERIAL_ISA
     select FDC_ISA
+    # Some users of ISA_SUPERIO do not use it
+    #select IDE_ISA
 
 config PC87312
     bool
@@ -26,9 +30,6 @@ config PC87312
     select I8254
     select I8257
     select MC146818RTC
-    select SERIAL_ISA
-    select PARALLEL
-    select FDC_ISA
     select IDE_ISA
 
 config PIIX
@@ -49,8 +50,6 @@ config VT82C686
     select ISA_SUPERIO
     select ACPI
     select ACPI_SMBUS
-    select SERIAL_ISA
-    select FDC_ISA
     select USB_UHCI
     select APM
     select I8254
@@ -58,14 +57,10 @@ config VT82C686
     select I8259
     select IDE_VIA
     select MC146818RTC
-    select PARALLEL
 
 config SMC37C669
     bool
     select ISA_SUPERIO
-    select SERIAL_ISA
-    select PARALLEL
-    select FDC_ISA
 
 config LPC_ICH9
     bool
-- 
2.41.0


