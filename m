Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0290C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBEz-00022x-EN; Mon, 19 Aug 2024 18:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEF-0000em-FD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBED-0000im-RW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-429e29933aaso36681315e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107916; x=1724712716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9dq7opeWVZG3BtwY0r0XLR76Nuys55wAqLRnBp/jbM=;
 b=gfI7ZNmZYRuHprksljSI+Wz5RAIY1tuAU4cLs0RdH79qsOHfdW0ha3ar7div2HX8G1
 ZQcjFxdg/l5eSh2IMz7pjlm7lzI/28BnXUA8E051Bge6cx1wA/t3fy1AIWakvoZt30D0
 ni+SzjBsLdZ5VDpneOj57wcz0+4bVQYF8VYcgvcrfzZVKsNBhvMzCwELv3SPTCxIcT3q
 43PAVsyJXjfHvYOZ405ZzhLwPoInAPAiVTeaMmvHongxhba9RYxvJ8yuTrTNEwOH8K3b
 nx1YgNzc7YOrg22Og8/G9MA66nXkmKOBxAcL3uYvYGNw9CKDh5nbcQgB8MEIe3lV/BWg
 1I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107916; x=1724712716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9dq7opeWVZG3BtwY0r0XLR76Nuys55wAqLRnBp/jbM=;
 b=GCj6ogLiAvWncai7HCJRDQ+fkBV1Cbs7e34XXUzDRrpXVaeMWPgF23+ShlPg6B8s9W
 acYnbgZOrUoXoufXTvziL9snNTzv7cb7C4RS1nwX6mZRHj6Z1PjJH4wlWWcUA4J3txhh
 EJBnDj5q1Nxyqqo/bpcobOhGvNZ4a4CqLBMLUxj6+VIeNvCD9Xq6pfTrcR7ud2e9f87Z
 d5tH6w5VA6Y4QCADqwnq25B3YpwPsJuKN9bOUH+OziESalnVVCXlnalxR3t7z5uFQ502
 K/pmoMk5VYL7be2TXxpBB1xdnveUcjfRVPsyWNkBc1q1gNe32xMbQItfjLg22jVPIaL/
 +tvg==
X-Gm-Message-State: AOJu0YyV27fAhQYHfT88KKfrku8Y/3Bxmu2WR7VhtbVUiALSzbRJC/+T
 Pszklr1a3Dqzw6S2zQKfpWZbChSHfs5wTkS/XUqPrKRPqU0pQ/jZEnlfcgb3tX9a6sIu9J7Gqzh
 Q4AY=
X-Google-Smtp-Source: AGHT+IH3avEpLYouBO8BKbwI8iTPf+GWGZA41+Mzx3b0n30Arpea26YUrQ7BRhLJ0NgNpMs0cGe5kA==
X-Received: by 2002:a05:600c:310f:b0:426:5b21:97fa with SMTP id
 5b1f17b1804b1-429ed7e432cmr101753805e9.29.1724107915886; 
 Mon, 19 Aug 2024 15:51:55 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded1813dsm181831585e9.7.2024.08.19.15.51.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/20] hw/remote/message.c: Don't directly invoke
 DeviceClass:reset
Date: Tue, 20 Aug 2024 00:51:04 +0200
Message-ID: <20240819225116.17928-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Directly invoking the DeviceClass::reset method is a bad idea,
because if the device is using three-phase reset then it relies on
transitional reset machinery which is likely to disappear at some
point.

Reset the device in the standard way, by calling device_cold_reset().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240813165250.2717650-7-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/remote/message.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/remote/message.c b/hw/remote/message.c
index 50f6bf2d49..38ae6c75b4 100644
--- a/hw/remote/message.c
+++ b/hw/remote/message.c
@@ -215,13 +215,10 @@ fail:
 static void process_device_reset_msg(QIOChannel *ioc, PCIDevice *dev,
                                      Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
     DeviceState *s = DEVICE(dev);
     MPQemuMsg ret = { 0 };
 
-    if (dc->reset) {
-        dc->reset(s);
-    }
+    device_cold_reset(s);
 
     ret.cmd = MPQEMU_CMD_RET;
 
-- 
2.45.2


