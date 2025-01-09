Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A651BE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwCf-0002Oo-5w; Thu, 09 Jan 2025 12:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCd-0002Mh-SR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:16 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCb-0000ef-Mo
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:15 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso12581535e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443211; x=1737048011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qz3bj6rw803M1uR6VsFauScvvIZVsKyPf1NJH8U1zkU=;
 b=sXVDktixxqNr4foVZKXSnJCiBqZ4xHs81ZNJvYCqr3QcWEJG/BZwHJxT48h/yDUaF1
 5gAtyy7PYx0xw2GnjG4S4QEOInAJxAuB+lUEcG8Xi2hpqHu0+i2fqh6wUqsN8qEzlRoR
 3WdLnA8mXYP1H6F65OiwTT6PvtUOQIgwFzNWS7vjmJ0Kk3aakH6i2ijvJFeK+GyNI3vg
 SkFJteVbQ3HFM6oiUmrhGfHH2KqY/1gGYdPz8UuJCDoJZc6WRmrhDXy4Mq+dj3ugikgd
 kI2/Ddq9R+BDy+WmNTCbu/ibqNIoHIs5RdwsVcwM/oqMlTdKmwUNXLA6qYf4v0pAl5CG
 qm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443211; x=1737048011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qz3bj6rw803M1uR6VsFauScvvIZVsKyPf1NJH8U1zkU=;
 b=ON/3qop5xPEuytB4UOsYLiApTL9e+CtvDxamokYbnqvM7bDMaFhXfC0PPnqSyIOLFw
 OQS1mnbmFLuwtja7s6dL0Nf7sEZFS5VjfIV5m1u5vptaa9ahWC9WtBCnp7rQyGU8Qu0y
 3HqQf77HBKAeMen2TlRng3iX5IxodQU0CzrZzdffr/zAnpizSypibBpYLBtRPDhnTg/G
 v/w0nkkjWRf0lQ0K1MJu1ZdQPkIKB3Xfh6rhulKkicsnUgxKS+1Rveym17Lby+FPMIz8
 ZeWUBPj17SdsprYUf4nAD64pdK5EqmRQR4bIkiJUc4OJjHPlddKHAQWpM2n/Rsnh1R5J
 TxYw==
X-Gm-Message-State: AOJu0Yw9EWE+yPPgz6Mfcvlo1ZE8gMBMJCza68aKNSKTGPOgiB7nhIF/
 h7qYgixnyiykrmCYZawHGiyWAS4edq3lpooBAjCoRzFEjY/Julu9HimER9v0WA6VHv38zvWCwGA
 RHAA=
X-Gm-Gg: ASbGnctjHQfVNnnOu5KyqAWbwsBOCXLJJmjBSLbI4BwG2TXbk0s7pD+uLmFvXjHNePU
 KLo7TGFuvTe07g+cUldMFQr8jJjYaRXqrGMJ4vPnxW1+TyEmjM18EtyYlZwLdKNVd1PQKL14B9I
 bxplmpdc0J3YGLLtD6+bnrb0na8dP9oyEvT+qJMdxIErHQGojlFiaZqYOZJd14AGqqOgZmY8LfS
 j9qXyIAWKDCemiRPzNY/KdzeFSKagGkzRgvoCSkAxNhrioauaB/a2dR0u6P+Gbt/rMpdRsnCUGk
 A8ddS7Z57+t0w2ZeBr/FMiUiMtZny8daRAQI
X-Google-Smtp-Source: AGHT+IEXJMYOV1taRVFlCVKzS97GhTEvb0dXWNf7+KUvG8AX4EJQtCcmLDtCNJ1S0re1fipnieSg9w==
X-Received: by 2002:a05:600c:3b02:b0:435:1a2:2633 with SMTP id
 5b1f17b1804b1-436e26cf8a5mr32814435e9.15.1736443210960; 
 Thu, 09 Jan 2025 09:20:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37e375sm2295146f8f.22.2025.01.09.09.20.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:20:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/11] qdev: Make qdev_get_machine() not use container_get()
Date: Thu,  9 Jan 2025 18:19:41 +0100
Message-ID: <20250109171948.31092-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Peter Xu <peterx@redhat.com>

Currently, qdev_get_machine() has a slight misuse on container_get(), as
the helper says "get a container" but in reality the goal is to get the
machine object.  It is still a "container" but not strictly.

Note that it _may_ get a container (at "/machine") in our current unit test
of test-qdev-global-props.c before all these changes, but it's probably
unexpected and worked by accident.

Switch to an explicit object_resolve_path_component(), with a side benefit
that qdev_get_machine() can happen a lot, and we don't need to split the
string ("/machine") every time.  This also paves way for making the helper
container_get() never try to return a non-container at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-9-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/qdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 09c4489e3c4..48bc9a7b9c7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -817,7 +817,12 @@ Object *qdev_get_machine(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(object_get_root(), "/machine");
+        dev = object_resolve_path_component(object_get_root(), "machine");
+        /*
+         * Any call to this function before machine is created is treated
+         * as a programming error as of now.
+         */
+        assert(dev);
     }
 
     return dev;
-- 
2.47.1


