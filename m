Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C4CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJ8-0008Jn-4p; Tue, 23 Jul 2024 16:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIs-0006s0-AQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIp-0004EA-K6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-427b4c621b9so40018475e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767205; x=1722372005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcNZQQ0nKhi9U2udqnFLIBFior9dBlBIvCxC4fyrbfU=;
 b=MQZBDdsh+8KfLeZJK2ROecLVJs+FsUan2KWdDAwamQ0iryU4J/0x74sYbU5aMLfKPg
 ljwiqJHpYSpC71cRUgBzCSHGsPnxmaure0A/oRAMXeJN93oAwE2Ew3vrzVXhqJixoYdE
 K9atdKa6UAXmMKF/01eOP/ZXlG/A9XROSRBEfCLB2zf3E9YjRdusHxq2lO00VgqmNcyY
 wz/hrW5SnBjkLfPetYl965rHFT4J1S816cVoiPrkZbXn+UlAE88mk5BNy8cdAKUfTTQx
 SJSQB8/xA81zqIR0PBjtQJrXxze8F56un9f97Gd6sO/C92VREJgUx0Kyk8tBusF73bcU
 rCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767205; x=1722372005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcNZQQ0nKhi9U2udqnFLIBFior9dBlBIvCxC4fyrbfU=;
 b=vET8tUIwUC/GQTpaNrhGq7bxHvWA7T4C/WA2r/9y0zA1boYhppLr8zi4y/wvKoeO93
 I9EFXz28QjrQxUim+kCIl9dtH3VtMJoJiKMS5LA2lu7DwUtaAs91G0MAiKKYore4PIpI
 Y3yASJor4F/t5EKtZaRx20rU2BXaYXwr6qWLptFMrFGn2wJK8cs1t5xGgy8LYtqPDnAi
 Ka0sqLn/SgZ27WI+8DMsw1Aaqfd4mZsEVtlRb1XE3ZajYAEhF3qMkNxfMOYIieF52YjD
 HaBWEKDP2qQGbp6a9O868hs+Sjq7GzyEmlt4XipUnRbBXQpm1ieG70I1DVRZ72rdyhZD
 GwGA==
X-Gm-Message-State: AOJu0Yz2o2gUZUerRJJNx+y5YNp0Upq8xkYW3JUevd4H12PGxmoCss7p
 bmCBs4Z8glu3b2cPQhsJsMzc1JRYa/1V7xqOwxMe+okcfo7xKvPGWY+ZRulVpMATiMRr0JoUpGc
 86Ok=
X-Google-Smtp-Source: AGHT+IEr4xLEs0e1uDun0tR1343R6BLZLmCVbrCA4Yj3SaEJBFe+ubjjHSa3GykRhK+rSwdHwZIY3Q==
X-Received: by 2002:a05:600c:4ecd:b0:426:6ee7:c05a with SMTP id
 5b1f17b1804b1-427f95562b9mr114755e9.15.1721767205614; 
 Tue, 23 Jul 2024 13:40:05 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93abff8sm442335e9.38.2024.07.23.13.40.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/28] util/range: Make ranges_overlap() return bool
Date: Tue, 23 Jul 2024 22:38:39 +0200
Message-ID: <20240723203855.65033-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

Just like range_overlaps_range(), use the returned bool value
to check whether 2 given ranges overlap.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240722040742.11513-2-yaoxt.fnst@fujitsu.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/range.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 4ce694a3983..d446ad885d2 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -210,8 +210,8 @@ static inline int range_covers_byte(uint64_t offset, uint64_t len,
 
 /* Check whether 2 given ranges overlap.
  * Undefined if ranges that wrap around 0. */
-static inline int ranges_overlap(uint64_t first1, uint64_t len1,
-                                 uint64_t first2, uint64_t len2)
+static inline bool ranges_overlap(uint64_t first1, uint64_t len1,
+                                  uint64_t first2, uint64_t len2)
 {
     uint64_t last1 = range_get_last(first1, len1);
     uint64_t last2 = range_get_last(first2, len2);
-- 
2.41.0


