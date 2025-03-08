Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333A5C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1te-0001DX-Gs; Sat, 08 Mar 2025 16:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1re-0005kb-CW
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:48 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rb-00040H-MT
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:46 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso97395e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469861; x=1742074661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYlUhb3rggQ40rUgdot+a+VslIzJdQ8NRCCBrVTp1kk=;
 b=L0Al8F2x6cx4C95akJgk53AnIz0LD3+T/bG9bE7OEe28QVPxK6TYr6BDJG3Ar8Kl5B
 dwPdnEBPPr2lsVRWQSaopLzBu2wKzIKGMDDwUek86eF9lsfiRPjXb1aJMKWO3Whf5VHF
 Eos9EXclrIvbCW1OKLwOebUJxa0APoFcfbywbcnq6ZOlblL7kCjBpK3Jd07EIAPIK9Wq
 m9gESaBX7P6s0pZDqiG+twmUAMV6jFd9mPHesWNUuhc201j/GhqiKHVFU/4OHKV9uuVW
 S8E7AObwwWmR0kx5saAmFdD8QpPUxXxcDKbFtFrMSH9fak2i4zyF2XG3De+eosVoh4XS
 J2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469861; x=1742074661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYlUhb3rggQ40rUgdot+a+VslIzJdQ8NRCCBrVTp1kk=;
 b=FfmMWh/B3FeaueJGplcZU6U+fXKdIJK10nZvSTxqmvZNRAPHJThWnM0a1jxFRJ0Cm0
 hsE16PpWljazu9Sv0DScLzpixgCZFmYn7ftIrr2/I0HTKkHK0OwF9KVQ6eU7ZNS8LKXY
 5MN2lB9CMU1c0nBg2qz7lBrDlTRZAjizSjoB/wG+HLCW+Si8CwogEo2I0vLxWnjz8IYI
 ldHwE9H5j6+f3zDbGS+REl9PUlsC8V6MPDG9pAAwyCP3JY2jVzwLXWLBZT0aKsnrn7j8
 UNKKNr9l0gSow8FXZe2R9hk+OaqV9Fgfk+49rTuvP0U0nuvvOryFYKR0NCOYemILIW81
 Hi6g==
X-Gm-Message-State: AOJu0YyVaLNnJsecPbEe+0AM13LNpzy4LV/7KhQwDVJ7blq7inkosQAQ
 fyiV0XAontHLxUmz+ieWSWsBc7DXFJPGugP30t1JI9k4sTRuvhc9zuSmOUFht7mHGKWMXXB8Cwn
 VtA0=
X-Gm-Gg: ASbGncuT/oXdb30j9UMDDBN0RnGPNZvbv9pMjVjYX0jOdgaDe8bcN1hk9EuptINE+/t
 rC1Og2n8GRdgAAHjTBoFiLa8k78YwBq+4klwbVKJfC/yTn7JptrlyJtjU/IRdGmX0mc19bqwSKL
 xR39OqXyhcBbcsY0LsRMBXuSTzu5D2AfftzYR3avUfnYP/qwihKbl/chCf11l0OsPkCZTlJ0Pmt
 1J+3oONVvcIyfnV1X+PDww21RXyMDHYoSPu6dN7YqZre02jefrXlYNGNj3hyBPZmROBx241z6uG
 laYvsR8eoi2wnq8PLShf8ZBpZ4HiDks3kqRvgbmwO2EKbPqBEafRJhvth9M82XbbHWW835IuYQM
 AGrWEIW3LS7V6NJNX3gQ=
X-Google-Smtp-Source: AGHT+IGnXCukaOQi3q5SQL72YiOr0dPTmXNdw9xarlK4q1o1vF2CN3iHvdI4SqpEOfl6c1ujDIhPPQ==
X-Received: by 2002:a05:600c:3b1d:b0:439:a5e6:73ff with SMTP id
 5b1f17b1804b1-43c601e18b2mr56121515e9.17.1741469860743; 
 Sat, 08 Mar 2025 13:37:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c6203sm124940935e9.24.2025.03.08.13.37.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 11/14] hw/sd/sdhci: Add SDHCIClass::ro::capareg field
Date: Sat,  8 Mar 2025 22:36:37 +0100
Message-ID: <20250308213640.13138-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Capability register is read-only.

Since we allow instances to clear/set extra bits, log when
read-only bits normally set by hardware are cleared at
board level.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h | 5 +++++
 hw/sd/sdhci.c         | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index a91cda16cbe..15ef3a07b54 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -116,6 +116,11 @@ typedef struct SDHCIClass {
     const MemoryRegionOps *io_ops;
     uint32_t quirks;
     uint64_t iomem_size;
+
+    /* Read-only registers */
+    struct {
+        uint64_t capareg;
+    } ro;
 } SDHCIClass;
 
 /*
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f2bb612c665..9708b52f850 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -73,6 +73,7 @@ static bool sdhci_check_capab_freq_range(SDHCIState *s, const char *desc,
 
 static void sdhci_check_capareg(SDHCIState *s, Error **errp)
 {
+    SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
     uint64_t msk = s->capareg;
     uint32_t val;
     bool y;
@@ -208,6 +209,11 @@ static void sdhci_check_capareg(SDHCIState *s, Error **errp)
         qemu_log_mask(LOG_UNIMP,
                       "SDHCI: unknown CAPAB mask: 0x%016" PRIx64 "\n", msk);
     }
+    msk = sc->ro.capareg & ~s->capareg;
+    if (msk) {
+        qemu_log_mask(LOG_UNIMP,
+                      "SDHCI: ignored CAPAB mask: 0x%016" PRIx64 "\n", msk);
+    }
 }
 
 static uint8_t sdhci_slotint(SDHCIState *s)
-- 
2.47.1


