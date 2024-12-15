Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D72E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtx9-0002UL-72; Sun, 15 Dec 2024 14:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwi-0001W0-Ld
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:28 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwe-0001Eg-75
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:28 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5f31f8f4062so1383651eaf.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289583; x=1734894383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVBuRr7KLSLtGzV6O9infIgLbdNJKmSVBAsV5f7mK48=;
 b=sSIu6W1u99Xlr68V05TsIkhQMw+NOkRfUXoG7FYkpniOqiFGzajPqdTdxg9UhZGz8E
 i9bJ1RI0bV1ZnhVguq0HdZvj0mMzL9T/CLEmNdK9wziPgc0zNJRQ80skSiNnDcS9GioQ
 7XwFgrpAETuDMwI6hOHfwNbaxr+LUb1nx2LJmuhCeK5Y5FiR4+xDvKlaQXTKiTFTOFxI
 Fo1y85iwH/wQsqZ8swnO1og654IOsci43C/xKbuQ6dR9Cw8z3HKAfS2PxIZxb9fr4/n3
 4sng8jWwHT8tT+fvHAx6eQR7xZt4iZbySQw7c2ufVdRK7jgbrITXcq6spcns6At1xziy
 CPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289583; x=1734894383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVBuRr7KLSLtGzV6O9infIgLbdNJKmSVBAsV5f7mK48=;
 b=FoqoxGg8ciG8j7TtBinxrN3p38GTGYOZQ0Km7DNMcpYTV/l+V5ReFIL7FBQeQvn9PC
 7wv9Jr9dLN+Q86Jop10DjfagKJwL0FglYD/jNplhuRecVwdBZUxEwjqZ1YgSERibiPtH
 hB+Aj4aayXVP74auR4EjvccROY2n4fBTYyTPq0EaDxWZpru/iHbW/T7gVG+amTI0v+mp
 qVasU1dL0/+ZDxKZcC58uDd1SgfLYVPjQD2Rp1iGahRWWap9IS7VUh7qTuwtTlV51y/G
 YXR/C39Vl5vu95+qh00Q+0DGsomZrq4u2gAKZNqGSNkPvd1T1yIBAJzuNRW5+OVL5b2B
 F+yQ==
X-Gm-Message-State: AOJu0YxX8pbP+sCeDMsxAxGJRE/gABhjLLs7g2ufPvsz+3XdkScGkHDs
 NzZZmEEuWS4itgK8tzh5B9L1OrZGSLdINpg1DjHH3vEcjz/Z8JhKzUQZQSkm7rOfqA8o7nKUAFf
 7KUgHdM8o
X-Gm-Gg: ASbGncs8PZH0zxXSCQJUhPZyutFJqKRf2mopAlIjruiH/O/+FCH7lZ6kOj7L6d6S9Mx
 uyCK8zngNLsG6OhR63gmJ7dLCVdkD/aAofCmqx/cXsHIQdDToE+SYGMIgeEiASeedOwa7rPV8hz
 uMV9EiUNEV5ZaVz20ivdPzPgq0ZuCIOutq4NCI8KfNzdb/ImPZJYE3mj4P8EPFkh5TRVIqN2CMJ
 wMXGhRHtAGmouwr0ywFcjgiBDWnEP4MsYNQwjm9YzuBcX4lHIpCqyLmo0rVl2ChpWJPyDZ7Ij0Z
 PVAE5GX3abKC/ua6jlNVAVt6n7y+CCQcHWpnLGekEUU=
X-Google-Smtp-Source: AGHT+IFPxE9zr62JrE71mZ1RHSMTofF6pIAOtwNXqzLJliQRcfokUPyM42EDpJpZZqNm26P+Jp4PlA==
X-Received: by 2002:a05:6870:40c4:b0:277:caf7:3631 with SMTP id
 586e51a60fabf-2a3ac53f609mr6036474fac.5.1734289582849; 
 Sun, 15 Dec 2024 11:06:22 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Alberto Garcia <berto@igalia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/67] hw/ipack: Constify all Property
Date: Sun, 15 Dec 2024 13:04:58 -0600
Message-ID: <20241215190533.3222854-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Acked-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ipack/ipack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index c39dbb481f..7ffc4ffe6f 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -73,7 +73,7 @@ static void ipack_device_unrealize(DeviceState *dev)
     qemu_free_irqs(idev->irq, 2);
 }
 
-static Property ipack_device_props[] = {
+static const Property ipack_device_props[] = {
     DEFINE_PROP_INT32("slot", IPackDevice, slot, -1),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.43.0


