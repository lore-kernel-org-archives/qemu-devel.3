Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6FECCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMU1-0005sD-SX; Mon, 27 Oct 2025 08:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMTt-0005kH-93
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMTh-0006N0-U2
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso3108674f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761568655; x=1762173455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GoeOKyftJ5MLGQxZGLLBGt1lpVhTU2P8wL0zlmwVEXI=;
 b=X2l/OGQJdJIXtzzwx3tyu5WVWYaVhiF00Nrj1P/MZAwCjCbF6yHzUWR7sdPG048g7O
 fodL3L4Lp0MT885CUCQIg9OYn0OdzVQh9q7bsg/b4MRQPoLarLZwfFwmd0FR7FOrXla4
 KAINNnMDomJ7PMKy/FfOIgeMu9Yz85y8yqXwgehPvv2/kfvJMngBVtFiYK2/UPNCccyo
 EtmIUP2q9DPZQEUTGJpitelJzZs1EI/ltCu3H9GHYnarG1XT9gWDRBXSPug/XVpJM7um
 Q+IqfpYI+Xr1bSprhzu3HS6hivjGFirJXG3nxnGp/2U/JbKUZvATsk3VqwZruxNSWXcL
 bYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761568655; x=1762173455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoeOKyftJ5MLGQxZGLLBGt1lpVhTU2P8wL0zlmwVEXI=;
 b=d8E0YDDVDUbHHqrJ8DE+heLLZg4G0Ko/+PNvnIhU5cRyNzlHw+hvcQUz8DOCXnGVtU
 8g6W6MC9GImjx6WjOl+LDC1eaxoyL/bHYUsbPr/VqsBKONCeK5tgPDFBcnjRXQvIUJIO
 7KkHyeBPTWEYaWX7276QZs8em3reHNeqjtSwxg1XItbz/+Zs6Z/i57+09xhORpAyoTyX
 n3Xk01n2rCRPidlVOE0oA+uYp8zlkYPv2DCDbhPFxIY0m9HVXOfoPCIIpUiRh7NKOUNT
 5Z2zIRzfBRyM2CvPMGWL/7YEbXtsklRoHXnuR8QaB74R72UOkpOKXGkGtp8mIJHwmAUq
 Zgmw==
X-Gm-Message-State: AOJu0YztXv1NmFQlKyo+lSBEYeXBa4j/wg8E64DI/X8u8ca4KyYFPT4E
 cbHiMHbXqiy7V3wV1mOsed26pUoQWqnhFrnFWPRiX79hyURwwANzhstcpVrcKy3a/C7d0eXMrxF
 jqOrCZHk=
X-Gm-Gg: ASbGncsNxerqd8OBH05aVQHh3IoExXvgwAoq1PHO4lATwdiPPvfJw6o7Z7P/dWI/tcT
 Ds8YCli+7W4GIO3kt1uGeJ0Ak8DMrPNYirQlvb5VFLMyKTSLMlb5/gDPowFKc3n4mePGLn65uMB
 z8BmF7ODFCzGNHzDXOCvmXLoOhIMi+LhoRgdFxEdgPFuQA8N7z59x/ClEODNWOPv6GUY2XpXJyn
 hpY6FywBwmWa+Md6g3cNUB3izwxlQiYQVt8NsMpMUd/bPakBUKOpznfLQ6LatR9ulejx/xo6Jkx
 FRk6obOT0iqQXkwG6iD88xwtZ3exn5SgBISGTM0029d6WTHGzWE7YsThRvxotsmSOrSJlO1SZ5q
 ewOwY2VafFY4FEtSlCawkGILXNke+Zu6wpNLXrEJtA1Cqw33y/wZTiMpgbmAdHqHjP9rLku9st2
 I0jlSyHQ5HxofTJc1P/Q9i0XILwZscK+pKhiKYQq8EcFE30NpH9Q==
X-Google-Smtp-Source: AGHT+IEPzrIF85HI9BKZoZtnDex6BR5cCOZk8RX2NkrGGjPjR54GiLIVjSu74xAOEiV5Phys85ewCw==
X-Received: by 2002:a05:6000:186a:b0:3ec:db13:89e with SMTP id
 ffacd0b85a97d-42704d1441cmr23640393f8f.7.1761568654607; 
 Mon, 27 Oct 2025 05:37:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7ce1sm13908142f8f.0.2025.10.27.05.37.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 05:37:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Peter Xu <peterx@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH 4/6] hw/pci-host/aspeed: Log unassigned MMIO accesses with
 unassigned_mem_ops
Date: Mon, 27 Oct 2025 13:36:41 +0100
Message-ID: <20251027123644.63487-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027123644.63487-1-philmd@linaro.org>
References: <20251027123644.63487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Replace unassigned_io_ops -> unassigned_mem_ops to log
accesses as MMIO ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/aspeed_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 2499d3fe680..0b32f217e91 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -197,7 +197,7 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
     memory_region_init(&rc->io, OBJECT(rc), "io", 0x10000);
 
     mmio_window_name = g_strdup_printf("pcie.%d.mmio_window", cfg->id);
-    memory_region_init_io(&rc->mmio_window, OBJECT(rc), &unassigned_io_ops,
+    memory_region_init_io(&rc->mmio_window, OBJECT(rc), &unassigned_mem_ops,
                           OBJECT(rc), mmio_window_name, UINT64_MAX);
     ioport_window_name = g_strdup_printf("pcie.%d.ioport_window", cfg->id);
     memory_region_init_io(&rc->io_window, OBJECT(rc), &unassigned_io_ops,
-- 
2.51.0


