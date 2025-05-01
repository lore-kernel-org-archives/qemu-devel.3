Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C6DC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLn-0005kk-6c; Thu, 01 May 2025 02:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLP-0005JP-Bz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:28 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLI-0007QB-Nt
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:27 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso680008b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080657; x=1746685457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+UcETAhnH3DlTkfNI6L/xaOrQDoZAiJi/JTij8z890=;
 b=m9EGGS1zx1OYLKIN2e0X7SvOkOauXhdOcGvVu8sdBpBaAwX+q8l9zWFn5Iecg89atS
 Ne9CanldaRHKo1JwtJ8FbLDdE19N3+j24imjYT3EaekxP/88lQ/lBw3JlISdwJoHpbpU
 oJSHTkLARlFu37nHdigp37tI113jDXzx1dEfkmKDWvseCXY/Qn6yxOCvHTAjhk0gLg3j
 j0bMLRUvvlCkssKj/bXybNv+X12sN/3TP/Fp99fX4vmLsW3+XJqc0Km5Yw/p39qBDucN
 Yi0oFqM69nmEzIEpw1oEKByUUc1gx5a29ULuvT0s4mKVN3uDMGxiDk8+g8rmqgMnGn+I
 +UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080657; x=1746685457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+UcETAhnH3DlTkfNI6L/xaOrQDoZAiJi/JTij8z890=;
 b=eiOrnXyH4ACQ97A7D7Aytkkmu+cyNNaC1wKWFclMARyCXfIiNurdwVnOCyX10adZmk
 f++F3PrsFEWUjDz5limDWh9LhIUbt2JbBC4FTAZ74APTjd/3eFwhNiPQ22JYxMKwDHAQ
 owT0/v+3/Acb43qP5R+jWnveONYLfudxzQPox3kujDD20vmpZdtWFYnnAh+AqvUf4kI5
 ZVVcdBOPmdJq1gJHiK/Tlf0vQ7CzMWJLeTUgtR826w9/x+pUXWlKAXt2sgE9iW6SkAWY
 s1klxGzHqUqrltNyJKe4VTwWHgfm/yuBMgd65xODdDteP/2sIj1BM94999+q5CC0FTMU
 IR1g==
X-Gm-Message-State: AOJu0YzTbmJeoYSNvP4/v6Spi23gC6VFv5tOYFnLLu5TGWc6Hr/d1h4X
 pjj0F8NzLEIVmz4M+czuhy98ZxI5FycoedbF18vmub7sKm/gEqD5sMR73wu2cxiMh/QeWPwtTaV
 M
X-Gm-Gg: ASbGncuweIreXTVk3Hc4mxyZB7ZQZpOdDmFmiI2HXBnbqL5LaDbUsDqA/u6M7U9uVkF
 ncq7x0SPDPM6JB36+ushofs/xMTQzdW7Q7CqE2p3envSzWAeVH4LkeJ1gHgHM8OUyq0U8wrYVD/
 rXzH5fghlz12tUL+BpU25sHceJKsiwFsiPmC+vUOe3mS/MQVkg6QUTW9wPJq2hziN9BpxjNK/W3
 zNYS62Y5STsXdeEe7SJAMss1m5pwU99ocHJFmv5AIyyH3qupy15CG2qMEVE6VSwdglsuGpgCVqe
 +piPBIuqp31meJXNFRTnajmdFVxaTSvh3XQq9mDc
X-Google-Smtp-Source: AGHT+IFO6fCxSsP/dkbciCPmyGC6hhrBvi4oVC/NIhTt06uVNHhT90PcCmbCBk2ph/cAM14rqRmSmg==
X-Received: by 2002:a05:6a21:6802:b0:1f5:839e:ece8 with SMTP id
 adf61e73a8af0-20ba6a201b2mr3247198637.2.1746080657340; 
 Wed, 30 Apr 2025 23:24:17 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 29/33] target/arm/ptw: replace target_ulong with uint64_t
Date: Wed, 30 Apr 2025 23:23:40 -0700
Message-ID: <20250501062344.2526061-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d0a53d0987f..424d1b54275 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     uint64_t ttbr;
     hwaddr descaddr, indexmask, indexmask_grainsize;
     uint32_t tableattrs;
-    target_ulong page_size;
+    uint64_t page_size;
     uint64_t attrs;
     int32_t stride;
     int addrsize, inputsize, outputsize;
@@ -1733,7 +1733,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * validation to do here.
      */
     if (inputsize < addrsize) {
-        target_ulong top_bits = sextract64(address, inputsize,
+        uint64_t top_bits = sextract64(address, inputsize,
                                            addrsize - inputsize);
         if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
-- 
2.47.2


