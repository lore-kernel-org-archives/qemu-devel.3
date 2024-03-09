Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E44C54E66
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2JD-00056m-OP; Sat, 09 Mar 2024 14:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2JB-0004pU-Mu
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:37 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2J9-0002rw-F9
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:37 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so272739066b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012274; x=1710617074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9ZBcWCorweFf+2JD84jMS2xk8ntDrtFmiyqB/cRtXw=;
 b=JrP5/veXhnTCbopgrBHIatDR4Kk0YJftX+qGahmc3Ocyr7/S3jvI4RsyTKVmVJzXXh
 mvVaNYbflIiy0XlwwO3vkttCT/MDByIO9FlndAOqfhsENaqVhVVjVhR67vRWEHXA9tfM
 ZbQUyDB6d1hemZlBEdZkohNwUbycuWQuOCZnA+1yOuSNU7ucP0j19ZscIOg8+G4NuzTU
 REkapdV68Fplq6VaElHzFhyWa1PIXdFawAfc4sVl+IMPgVBbOChB/rLpc5mCcLqEneoT
 rZY3RbntcrnFWL7Vk54NseDG+0/zNgkQ8auTJsHzJ03+T7WeJpjTn6bHDScgJXGTT4Uu
 GCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012274; x=1710617074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9ZBcWCorweFf+2JD84jMS2xk8ntDrtFmiyqB/cRtXw=;
 b=kvoQmQMTPbNY7QkTLeW/xPCbc90aLmP82actt7vVJsCJsXo+fNvnyZ3OGyV3duZevQ
 YXGxUuyJ2PcPrBM90LSjPVp42pCqQYzlzrHLomfUOrgoJFlt9eHBUh77ttNEdBrER8+X
 U68XY6QPhfM7u6YxHdvvvn+MoYr4d11IvuS0z1Jy4/3fB3cn2yrf3R71T4T3AeAocCJR
 jwwvAllwWC7wOP3tTh3o9V9T86ELub53edSTLWPIR2gkygakZl0vd7N9MtYc1ERL2i+v
 PfWN8TjFGfRhGDEtC/WVoFY9F2Iz/wOp+ARRR2BgXWPr+2v7R3ivcv77AyjrWYHP+ThV
 YUzA==
X-Gm-Message-State: AOJu0YwJleDyk2QAw5LZQwebxTqFZTUQSmQDpTTSfRIVnZm82emtKELv
 EnZXejH1wk8IdQ0dxPjpD+YIf3LbucciW8HTQL+RXpcTZYId/Duqo0E4NvUZ3dtx8kGXbuNf0Un
 W
X-Google-Smtp-Source: AGHT+IHgEf1VoGYbP8PX+uBQFBOrcqcJuu3+uWJK8B0gZBS4Ndlr4ufNHMEDWth1nZW5Ltal/PnjAQ==
X-Received: by 2002:a17:906:9c8e:b0:a43:b50d:1074 with SMTP id
 fj14-20020a1709069c8e00b00a43b50d1074mr1601200ejc.23.1710012273937; 
 Sat, 09 Mar 2024 11:24:33 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 gh16-20020a170906e09000b00a45380dfd09sm1168535ejb.105.2024.03.09.11.24.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:24:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 23/43] hw/intc/apic: fix memory leak
Date: Sat,  9 Mar 2024 20:21:50 +0100
Message-ID: <20240309192213.23420-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

deliver_bitmask is allocated on the heap in apic_deliver(), but there
are many paths in the function that return before the corresponding
g_free() is reached.  Fix this by switching to g_autofree and, while at
it, also switch to g_new.  Do the same in apic_deliver_irq() as well
for consistency.

Fixes: b5ee0468e9d ("apic: add support for x2APIC mode", 2024-02-14)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20240304224133.267640-1-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/apic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 1d887d66b8..4186c57b34 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -291,14 +291,13 @@ static void apic_deliver_irq(uint32_t dest, uint8_t dest_mode,
                              uint8_t delivery_mode, uint8_t vector_num,
                              uint8_t trigger_mode)
 {
-    uint32_t *deliver_bitmask = g_malloc(max_apic_words * sizeof(uint32_t));
+    g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
 
     trace_apic_deliver_irq(dest, dest_mode, delivery_mode, vector_num,
                            trigger_mode);
 
     apic_get_delivery_bitmask(deliver_bitmask, dest, dest_mode);
     apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
-    g_free(deliver_bitmask);
 }
 
 bool is_x2apic_mode(DeviceState *dev)
@@ -662,7 +661,7 @@ static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
     APICCommonState *s = APIC(dev);
     APICCommonState *apic_iter;
     uint32_t deliver_bitmask_size = max_apic_words * sizeof(uint32_t);
-    uint32_t *deliver_bitmask = g_malloc(deliver_bitmask_size);
+    g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
     uint32_t current_apic_id;
 
     if (is_x2apic_mode(dev)) {
@@ -708,7 +707,6 @@ static void apic_deliver(DeviceState *dev, uint32_t dest, uint8_t dest_mode,
     }
 
     apic_bus_deliver(deliver_bitmask, delivery_mode, vector_num, trigger_mode);
-    g_free(deliver_bitmask);
 }
 
 static bool apic_check_pic(APICCommonState *s)
-- 
2.41.0


