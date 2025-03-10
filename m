Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFC0C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQhR-0003RP-FB; Sun, 09 Mar 2025 20:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfx-0002Fp-F2
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:22 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfu-0007RT-47
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1897144f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565236; x=1742170036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pnCT+L+XCXZVRzhjHTFwBDsZqVtfDpTg3ZhsoQOpQ8=;
 b=I/PjIAtKIXTUQLVuwyXA3WaaVPgWf4onGC8j+w9YXYSt1LEsv4k09DSgZue2YZTmf0
 cPyTT1/zjWvlLvqPMYV7dId+tM2e/XIbtN2FjKHkaNtMoOVKk4Jy07epll/q8Hf1qSTX
 KyGOz69YShGTtAUv/G5wEjaHL6FOrSTY6v9eGYcPxSrPNwejVK9W/Pewxa57zCl37H2J
 OmHHJHek0TSz1IUMKP/vzq0QnmmgMyBRlZFZGS7xR+d5h3/eOj+xHjgLGzhhpaY4LsRb
 NJA9Ci8Nk9N+7vQxC6CbT146JTbOmodMMC3nYIUKAR9cp2coy676MUmS6ccFvqo8LeXj
 IfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565236; x=1742170036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pnCT+L+XCXZVRzhjHTFwBDsZqVtfDpTg3ZhsoQOpQ8=;
 b=rJoDPPGLJUo/58F9gE2VjhzvstWLD+ROJ2yrDVFcC0lMXnX0H9yCA2Qdpgqzz9i4Qu
 wDm1X60ox7FjWm8kfD2fqvwc3ouP+7plXna41tFlzXwKVemiyhSOF5ZEDRYzYkHpUuI0
 rL0Xeh2WYMpBtWMx1aTl9fi7TB2gMDAtTsYbhpXUg8aBOH/zkRiE2mQAZ4Q0Iiexvzmt
 PI2RN9Z3caaIFyDNO5EI5I0alD9bUVlPrCB2+3Cd++9DgH0/Dnm78ATnQEN7B6NyWHx/
 of4yYG1g9liclBGaTi03WDZpz2cgX+20ezFBFa1f4t+UA4Q2ESZ5qEGCes+lQqm6/WLc
 RvCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv2VbtvoyGC00MxopTNRVRoPxJKvyQLav8JRzY9+dK68KubF8e4oLSTJhFCtPHkGXZ8yzEJb4i/fdC@nongnu.org
X-Gm-Message-State: AOJu0YzsmXPMxxDH31LEY2NL/2sJMVkhh9GpJ5NlP1h5RhrqvRLBZVi8
 8OqNevZd8j9egba3OkE6aQKocl2k2N8FFWmoA+roWf7fm4FsKiCmWauJ1klMSeE=
X-Gm-Gg: ASbGncvzMg+JBvOc9KXwg4r0vilnRXbpZu95EuPX9cUnZxUB6iA1dYhyVwsozIAPqj9
 E5w1Cui5P9G2om12Mdv+SxtZBopD+Ecg/mJzfBMCkUUbkCjtQSz0J+NUuEHUkh98xYD/7Q5pBzr
 m/hlJJfde8eoAE7/wVlGpCATbFWdYb09yp7mLFdxFr9ZxYNS1q1UXTFmxPkK0CVCnmNn4pbFvvy
 TgxLAr5uN/934YBPzeazMsw8KIG/dD8iuWcpA7ocJneMMXY0ixVG1MHogCLA7qn18XLoSAUgX7P
 bwdQ+UOR03RC3EGbSTsFsBytbwvCwMxZI/FC49fUt4PcSmdS4nYEnJO7dak5mhygUjIBmchoPDl
 oWDawufYZ7QMbeMdTt9sfpyD+Sod5DQ==
X-Google-Smtp-Source: AGHT+IExOYuUC9c0jjou6VwjYlH1/dVaaW96Dm5KLLx1HJjqlOxdUjGQDNrH5Vb77V7Nv/5RRsA41A==
X-Received: by 2002:a05:6000:410a:b0:391:4559:8761 with SMTP id
 ffacd0b85a97d-39145598929mr1282305f8f.36.1741565236138; 
 Sun, 09 Mar 2025 17:07:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7aefsm13011423f8f.20.2025.03.09.17.07.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:07:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 10/14] hw/sd/sdhci: Allow SDHCI classes to register their
 own read-only regs
Date: Mon, 10 Mar 2025 01:06:16 +0100
Message-ID: <20250310000620.70120-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Some registers are read-only.

Since we allow instances to clear/set extra bits of capareg,
log when read-only bits normally set by hardware are cleared
at board level.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  7 +++++++
 hw/sd/sdhci.c         | 10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 108bc1993c6..eb21b64f932 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -120,6 +120,13 @@ struct SDHCIClass {
     const MemoryRegionOps *io_ops;
     uint32_t quirks;
     uint64_t iomem_size;
+
+    /* Read-only registers */
+    struct {
+        uint64_t capareg;
+        uint64_t maxcurr;
+        uint16_t version;
+    } ro;
 };
 
 /*
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6868bf68285..eb6a0e0f939 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -73,6 +73,7 @@ static bool sdhci_check_capab_freq_range(SDHCIState *s, const char *desc,
 
 static void sdhci_check_capareg(SDHCIState *s, Error **errp)
 {
+    SDHCIClass *sc = s->sc;
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
@@ -1407,7 +1413,9 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
         error_setg(errp, "Only Spec v2/v3 are supported");
         return;
     }
-    s->version = (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1);
+    s->version = s->sc->ro.version
+                 ?: (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1);
+    s->maxcurr = s->sc->ro.maxcurr;
 
     sdhci_check_capareg(s, errp);
     if (*errp) {
-- 
2.47.1


