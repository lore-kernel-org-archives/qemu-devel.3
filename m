Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF95DCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMTx-0005kF-Ib; Mon, 27 Oct 2025 08:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMTl-0005ij-JF
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMTZ-0006L8-JC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-475c9881821so28729495e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761568642; x=1762173442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6rMhXo2mOdIjdjzZeeqxDW16LJN9LlmTyftR2c8mGc=;
 b=uBWwXI4lfDzNcaGOoyNniqyZTswm4Ues08zhyZ18UyCkDTFEuP8Xo+ggMBOU1KMak9
 gopkhjGbrI9zCBSdbniQqv0mxiwHuR+zZN31FjwSWB17oS4EYiMCLNv/pGXGfEZDBEyh
 GRZWmyWrEW4lSGbSAVdYpCsPa2Ipnt9S//bHK6jQfrTQZRZhQJZNS06TlADh9A47en7Y
 PrD8YhEe2g/KH4EdSzujCzIg5HGbC0qkgdluaOLeoe0fKKO7fgVYin1KaqNhfUw5DW2/
 crSdz30yn8pAzOnkTbX3K5WQJIn99lSvcEzdlrw55V7326BtLttywGMVjI7gWIiZMEsw
 icZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761568642; x=1762173442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6rMhXo2mOdIjdjzZeeqxDW16LJN9LlmTyftR2c8mGc=;
 b=qm+zbOkg40Rl9XVFIp/I1M0h9yWUgQEJmaAdhoAsv8YDaLGIO+b/lnq5VXuPFbJL/l
 XIa25Oag+iDnQgICh2IHBXY8aulGZ0ao0MXspwrNwaamVgSXgXmwPozGKCxjFRDuTwPy
 s4oT0XPl19pRN6J4L2Rbb0x7hQbzdjq69DppHp07tNrGttQTmCRlfA+C1NRHC/Qrf2kQ
 17d2yD12qgrjjkkWX8rC9PlzcT9RdbrKcshF4MgJXoZ5DkQLh+JSlH+qExzdlkuQjbLg
 lEdzXOgkK+HrREkH/DRWbLqtaA/jEwF/s4AmfY+dgW5434RpLQlWoNlPLFJNMnhDfUav
 GYRw==
X-Gm-Message-State: AOJu0YyDRABKsPmkQC90au6ao2OH1sPDCTkPo6ncuWwoGGY94T9TMlOq
 6YCXTHNNACoBAL2riDnsLJXSYY2wfqBNpbNO6CuiybiNEaqXAEYzl1JGxqSUk+iZ+agGfiiKZCo
 wZdtMUcw=
X-Gm-Gg: ASbGncvqbxTqA3Poe8455syOSXjTIGaX6kYUhcaSvsktVZG1A1lgRKFhaEv1V88CX5l
 YYH19UeZOlpnjVDR2m+UNdtdKPHAOU4jDn6zb+DNg/V3+2qV4E8SYIG3O3o1/cWk3sokXioT7u+
 2vmsp0436iOl2nnF1y6vjQyXWXXzXrPNlt8j1OO/AouvnauA9x7kKUV/YZayxHp92gHZTkjoVP5
 cXf3sGlfupbLi4hWsWIj6rgM34SRMlsbotfS2rMMtjFouWenTFyk5Cnxjp6VdwiaM7K0j3R/eJC
 vIoFLmrZPOc+2rryus5nxL5Q5m5jz6df2MtfCSQ5HGDHAUuC7wud3CbXHAV7ImocA6EVspPrlab
 tLa7Z1vG8Ta+8XvxLXObmVHWA7SWbNmMk6aFHWGdU7LmHsk/QTwjS4YgV4guYbSADEGndvNwsoG
 BYi4HStoHnwQK2p8RxVaGqEb/B3vGa8iUY/coRYrtlOkTRxp4c8jAIT9tNLMIj
X-Google-Smtp-Source: AGHT+IFJyevXqiI0zymzpvNOLimbpGh+0eHz/sg6gvJKuMo/DrZsHy3+X+m6yJjlG1AQ5LbrjfF1yQ==
X-Received: by 2002:a05:600c:64c5:b0:471:611:c1e2 with SMTP id
 5b1f17b1804b1-475d24088b0mr102973515e9.3.1761568642508; 
 Mon, 27 Oct 2025 05:37:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df3c7sm13906047f8f.40.2025.10.27.05.37.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 05:37:22 -0700 (PDT)
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
Subject: [PATCH 3/6] hw/pci-host/gpex: Log unassigned MMIO accesses with
 unassigned_mem_ops
Date: Mon, 27 Oct 2025 13:36:40 +0100
Message-ID: <20251027123644.63487-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027123644.63487-1-philmd@linaro.org>
References: <20251027123644.63487-1-philmd@linaro.org>
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

Replace unassigned_io_ops -> unassigned_mem_ops to log
accesses as MMIO ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/gpex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 5f809028be2..23c8d22489d 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -128,7 +128,7 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
 
     if (s->allow_unmapped_accesses) {
         memory_region_init_io(&s->io_mmio_window, OBJECT(s),
-                              &unassigned_io_ops, OBJECT(s),
+                              &unassigned_mem_ops, OBJECT(s),
                               "gpex_mmio_window", UINT64_MAX);
         memory_region_init_io(&s->io_ioport_window, OBJECT(s),
                               &unassigned_io_ops, OBJECT(s),
-- 
2.51.0


