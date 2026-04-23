Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EFBFDEE2B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxSD-0000Wa-AD; Thu, 23 Apr 2026 13:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxS4-0000Ns-I5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxRy-0004ia-DU
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:02:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso41675465e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963768; x=1777568568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ah6Ua2r56zNx19wd7NL4st28ziivhlE6PqFpaPuGyE=;
 b=PmMdJqafWYYqrBTauMwJXaO3PQl0pk+8R2RQeGFzrCOX+dkq7wbazok2ZLukWGyumc
 +3gYKsxj+Yfffyw9Idz1idPUsq3C9pUT4t58Sb8OCQu5oQQEbuQTtGro5idlk+h3DuOD
 38+NpTk/FhZ48mh3mJ5QMliB+0GmMNSVOX24BDyhhLwwUsfUdw+pMQJBaop2SaL5UsTf
 qtgtHvBIhjx+8ENS4jzERtrt/Eor9imgN/Kb5BWMXIOX7Kb4uKgEdJdio8nMLSU4oi/p
 ek4WS1qdtad8H1ttOhdjsCegwUR5VHafqKS0+YP7vPD3W2NpbTERskej5PBK7jNDhpYF
 PU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963768; x=1777568568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Ah6Ua2r56zNx19wd7NL4st28ziivhlE6PqFpaPuGyE=;
 b=N7QF5NObsSeEPqTt+2LbCdsNlBdr9NbN5P5SRhCHPbkwf90cdnu+uPA4EZKCYSQHkI
 IlowcNG16OTVGw8S8zLjXdkqJsErasSPe/Ql9lRmzkc1oyrzKzbipu3iBftS2X7f8e8p
 IMKA9K6dm6uPH52WEvzt1uF1zZ4i6FqP6Dai+u/C+wJ8aVOeVW5QvHMLS9iLE2jMKmGg
 8H9PjQjQ8t+Hn9bbLuO6iKCdawzaYN6wgkbFFDqisuIRxWVkPQ7aHpB02Xz3yGfdFRuA
 f54KuGjChfr0pL81DRC+xaPusHv6NcJcQn0/3ZAiBHT4VyUceEzTu9pZmnspxwaW4aBP
 4K8A==
X-Gm-Message-State: AOJu0Yw+Qq3wccU6G/6qKYdPmqC69z738qmPk9Z/lkiHG1m8qOQ1gZiA
 XEhic1PpiETXYyXeFbbLUXS5waRFHRt824OKMHleiWaiC4hdq4y0Pxi2DMz1C3+KLncXA67S0U0
 nvQYzhCU=
X-Gm-Gg: AeBDietqfFGscefnjNYSZ6yh9AE6rLikLLUkMd0V0bQB37kFysjTL4nvqOVmpz1Okci
 MpnyJ2sq9aWZVbGbi9EdJh+42T0mCM7YMTWg9YFgZu9jMv//Ilo+2VnxfQL2KmW6cuM73xBZU/g
 +IVN1GtIFwnfYVAdQVVLPSqlcNryFypn5xdrq8mloHu/4+dTnehyi1w+/ABWhTmxTbFl1hBo0dz
 MTX04KO6ASVF9n2pHlnX8ADyVPHMCi3cZrpILCS6pa+qefj4Yg1GI/HYjMTymfJ76R03cgmgP+c
 hRpn3s+fKVTacrc8SAyqYdP7iZjYZr8nn+SqanYYvAlKh/OE9FM4IVnRDy2VgFlrtOpELnz9Uhx
 O7uv++o8cHv+GC1IjzUisNlLoJLN/E2+Hc5BYone44NXhegIEOlg+jiM9vrUuDD0A6UNLljyFSq
 6rGN1Emx5DCMbtPUiV60HgLdQrvYFKml4EvpEE4e0FK1PSLWYsqf4eFYxPeiX2fGA5xjlvoN6y2
 VbM49XVBXSYU2NRMBXY7w==
X-Received: by 2002:a05:600c:c106:b0:489:1ba8:5be9 with SMTP id
 5b1f17b1804b1-4891ba85d07mr187900845e9.29.1776963768440; 
 Thu, 23 Apr 2026 10:02:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5a579bd3sm161809585e9.6.2026.04.23.10.02.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:02:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 02/16] hw/cxl: Define cxl_fmws_get_all_sorted() stub
Date: Thu, 23 Apr 2026 19:02:14 +0200
Message-ID: <20260423170229.64655-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a stub for cxl_fmws_get_all_sorted() to fix building
a QEMU configured with the '--without-default-devices' option:

  Undefined symbols for architecture arm64:
    "_cxl_fmws_get_all_sorted", referenced from:
        _cxl_build_cedt in hw_acpi_cxl.c.o

Note, the CXL <-> ACPI Kconfig relationship is a bit convoluted.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cxl/cxl-host-stubs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index c015baac813..9b515913ea4 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -18,3 +18,8 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 void cxl_fmws_update_mmio(void) {};
 
 const MemoryRegionOps cfmws_ops;
+
+GSList *cxl_fmws_get_all_sorted(void)
+{
+    g_assert_not_reached();
+}
-- 
2.53.0


