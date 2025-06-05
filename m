Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8162DC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 19:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNGNf-0006ko-G6; Thu, 05 Jun 2025 15:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNGNa-0006iI-7w
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:35:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNGNX-000168-C9
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:35:57 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so761389f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749152148; x=1749756948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEDanJuT5WWXk9pLyRjI3VBPkEYLoZCOaoP/BA1XIzI=;
 b=CXUu01cldqKDPVabUN5W7UTR0ufznTeB5ImugbyT3WsRUqD3/kqYoFwznAwdmi3475
 V56DP/axfeZCn31SNQD4/8gXCFURDmZdLwJCv7NQRJeb2aiJbcLAO39DoMEHL0rwglED
 fjhPTyzJfFEUbT8KS5snlPHBQ8iOmbfN/nJs0VHqT4i9I8GMWcyWEKcyTr/7O7zf+tep
 lNfWyBFTyUzrOY2nh5uBuaDLn9jcXs78gFhazrrWYK1NMExnqWMvqlwU1Q3KMtmFNL8k
 3nH7lCfNtt8eLgQVLjm1gGD3oqG2ZUgEMpb898QyjHA/6KxSIO4Cx2on2UG2UGaujrCr
 uR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749152148; x=1749756948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEDanJuT5WWXk9pLyRjI3VBPkEYLoZCOaoP/BA1XIzI=;
 b=cBa/YL2/3d6R9IBry/Dj++xZUtcjUkkcZyOY+xR13NHh9dOhl28hkZJUTQohHlhK0y
 UyH7k5t+OLnkKuFN6DxGhA12LL0tkDdZG90WtZ09HVE66oyO8qtt6rkP5roP6SVjpLj7
 QvOVAIy/g9xMEx2HNFh7rCCXGNvElSgDSBiSWHrqjmHDSEo1vPTbYpZvnnoiU5oYbYbk
 U7FleBOZLcpVloClSvwwI1T+E7XIDcfOJ0ubGUH9mON7qlCPqh1GHLWL3SQLDjU35C28
 ptPqEzj0J13uFLgsKyJJ4ltdhATHJSq4q5K8sLs2ngXIBLfMuZQK77FrGHJKhjNqlgMv
 cIkw==
X-Gm-Message-State: AOJu0YyQjBbhVUd0xrBfToRAAK7IuhorAnmgE8ZUIqlmQV3miFoROcBZ
 v8HV9mFHCM7m/kXZG6DzQ/csVdvKNIpxzslEwEGLc9vpScIpSSsXxrs4cOPuCcI0KDUTDPUeBiR
 HP3zTaXM=
X-Gm-Gg: ASbGncuwqI+5LxNZp/YeQn32oyEE8CxMuIy1fVhdcUZ6pvvpoAXRm/cTDbYOqAC7g6+
 ysztY6fHh/vkxcsfXLxetYGOcej6FDCm+D5NSyGjr2kxeg0CVqBbB4+FtAyL/Bhu0oiPdsPxL4E
 M088N2SG5UeLmhSsGWLZi829TRdyI7aODcMmEpX2VzX7wpJvEI4GwZPahqaOd1vjyP4i9tDM5W2
 3u3WWZ/ENGZNRqK5zuycFbUNqgOG3cbbfNuMjtBZ1153SFYenuAZELCFF696KdsAuHCtDaJ9f93
 Fa3SJrtuTa8KQCvtOtm1qEEt7oI3EUaXbc6hhDnVFs363ksHedqWGvR4pVsdx1UkG3NcsNlE84w
 o3/51PKqwgIxDeiKZr9gwe+ktXA==
X-Google-Smtp-Source: AGHT+IHc1MHgy8W2D4St3enjEpujmvlHttoINu1qJv3LAA4K52ibYyoXIos4EAjPuE3evRxt/WA2Uw==
X-Received: by 2002:a05:6000:240b:b0:3a4:f8fa:9c94 with SMTP id
 ffacd0b85a97d-3a531caa070mr364860f8f.13.1749152148183; 
 Thu, 05 Jun 2025 12:35:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45213754973sm2179575e9.35.2025.06.05.12.35.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Jun 2025 12:35:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/4] hw/gpio/pca9552: Avoid using g_newa()
Date: Thu,  5 Jun 2025 21:35:37 +0200
Message-ID: <20250605193540.59874-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605193540.59874-1-philmd@linaro.org>
References: <20250605193540.59874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

We have pin_count <= PCA955X_PIN_COUNT_MAX. Having
PCA955X_PIN_COUNT_MAX = 16, it is safe to explicitly
allocate the char buffer on the stack, without g_newa().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/pca9552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index d65c0a2e90f..1e10238b2e0 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -76,7 +76,7 @@ static void pca955x_display_pins_status(PCA955xState *s,
         return;
     }
     if (trace_event_get_state_backends(TRACE_PCA955X_GPIO_STATUS)) {
-        char *buf = g_newa(char, k->pin_count + 1);
+        char buf[PCA955X_PIN_COUNT_MAX + 1];
 
         for (i = 0; i < k->pin_count; i++) {
             if (extract32(pins_status, i, 1)) {
-- 
2.49.0


