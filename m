Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8023CC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdaSs-0001HR-Fs; Fri, 23 Feb 2024 13:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdaA5-0005w8-Jz
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:20:43 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdaA2-0002E0-HM
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:20:40 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41298a20278so412085e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 10:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708712436; x=1709317236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VEpDvpjnE0RxyFhulg9l08v8f2Wz7OaL2p5ANskUvHo=;
 b=CiAbumHMFUMo+387KLFSX+AVv0XvXcmlLiCGgzRucsEOac+OpmEbREfUEwax27wfzn
 jZ+4EQhhs9ZikP6n7YzfmeKC1iSvealmRD2YbFE+sjLvOPWZE4bMfoCrSaH0x8EQIk0G
 l0tltue2fPCoRkEqvk6ZM5zRFhe7nozl/PzYYAnS2ps98W1A7PjOD/xMo75y3bY1p9zS
 pepPT+RlRBE3ZQkZMBP+eJj9QTcLukuNl9LMoSLIHPQWDpEIlV+dUAWG8EeDuALcTO3C
 yTaj6eWKmAKFGZdDgAjPMmqVc+k50Yc9rznrWB/5Upe7S9z8MyGeO2rxIlYv5g0+HLY3
 uqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708712436; x=1709317236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VEpDvpjnE0RxyFhulg9l08v8f2Wz7OaL2p5ANskUvHo=;
 b=V/FUVCPrZ6OhpiUJ0xlPmwLyj+4wmYvcUcucvSClNC69a3ATiv1CZ6KXhia/8uPcTe
 47J/lgAWZ785nT5cgGOoZSo3eZsekq+WO/I097J4zC4RwYcdQ9uYTRC5BXZL8BNVYYXX
 lXy/ahQ6VkFcy4Y13UbAbBMO9NkVMDwavQ692ZExPw6mAaMkpys6rRHbQs6SPevzQoik
 YaXrZyJg6mcJoFMH+MdwTW88Z2D+RgnxqFjbDnE1kqChe9G+bNIsAOJt57TrZ5P1TOXc
 FJ3FASv4MhqDZa/ctica3T7bPVBx0jUBdqpM4jQHwti56+K34AfrY6QBh9BdRK12cWeZ
 yZ4A==
X-Gm-Message-State: AOJu0Ywl7wJwgqTQ/uNZguwNxqOqwb6K8Bg+Ob2pO51rq8yzPRZnLur/
 xaXAuAMIqe2SwNXrfZ3Re2jra7kejWWHccJxY+2G7b9orEUDv2Mclcqmi/A5eu6MM0BRYuuE1gv
 p
X-Google-Smtp-Source: AGHT+IGXdsgXTCGdFTOCXQYzVz/s7LsCvchREGu744mP/9iwhGoLCM3ZpNktoFZSLo3sbuGKzOAwRw==
X-Received: by 2002:adf:fa8f:0:b0:33d:3908:4f29 with SMTP id
 h15-20020adffa8f000000b0033d39084f29mr336939wrr.57.1708712436550; 
 Fri, 23 Feb 2024 10:20:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 bk28-20020a0560001d9c00b0033b728190c1sm3627432wrb.79.2024.02.23.10.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 10:20:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] atomic.h: Reword confusing comment for qatomic_cmpxchg
Date: Fri, 23 Feb 2024 18:20:35 +0000
Message-Id: <20240223182035.1048541-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The qatomic_cmpxchg() and qatomic_cmpxchg__nocheck() macros have
a comment that reads:
 Returns the eventual value, failed or not

This is somewhere between cryptic and wrong, since the value actually
returned is the value that was in memory before the cmpxchg.  Reword
to match how we describe these macros in atomics.rst.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/atomic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f1d3d1702a9..99110abefb3 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -202,7 +202,7 @@
     qatomic_xchg__nocheck(ptr, i);                          \
 })
 
-/* Returns the eventual value, failed or not */
+/* Returns the old value of '*ptr' (whether the cmpxchg failed or not) */
 #define qatomic_cmpxchg__nocheck(ptr, old, new)    ({                   \
     typeof_strip_qual(*ptr) _old = (old);                               \
     (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \
-- 
2.34.1


