Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB6FEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKV-0006OR-Jy; Wed, 11 Sep 2024 08:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKT-0006ET-Tc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKS-0007wh-2q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so5329175e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057210; x=1726662010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3fpD/VMFOwFa8XEeym98j0cuLSh0HOLi0oDR/OuJrLQ=;
 b=C2pYeIWzYkld1xJwtje6k6vRLYVOzhaNoPtuS22dvSh1KIkhMsLNbc7d3ZH8u1NFit
 pyreCRnPM2bqC6g27uUCdLKF63OtF2owJKNGiOE59m4TAE6rJZRDuG93+ofp1ACqIN7q
 mx+naK4TXvmpT9V8eagSI+k5bf1Z1DIvjB0ikpBxnpJYW59nXwJQ5r8t73XqwKA88ywl
 IZ7XOZwuALTHkmTXyrjm/xxwDI3tS2SBFsJ64jx66sSMIpnd+CSyCIIM4xbuqXDRGdwA
 4TQE/LkTYgmanaukWBBv/4q+1CK6iXE85283Ol5W5Czoi01qgEx1BO7BZAv6G3TJylLB
 MHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057210; x=1726662010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fpD/VMFOwFa8XEeym98j0cuLSh0HOLi0oDR/OuJrLQ=;
 b=XFewPkSQwibYLlqsAZwqjoTNyZ32peaUTNsf5hYq+1ybbjai1SgJrl+7aBEXyz+KIc
 myoPO+hcRVIfI8BrrCPCoi2nz0SjTb9GgCAfPbJYIlX/BswScizngZZb1XB+6BvwBRS+
 tLvsSOHUbFwJQuxS0Fz/KizGGa1oYcoNaSYPfKiMnKIXTkC1Cm0Qu/xXQJ6ZmjX5BBt3
 n9zTF9vlSM1yKJXTvsIECP+6j/5vN42aB2ufpjAzGybO7/ZG4n2z2KKqaXKmHgqPurBr
 f+9fkmK2TqnmDPcdRXB3DMBYGtbKDLE+h48NPZxgj2h0r8SdTz3iPa8rjAz4u+GjKwOo
 01Aw==
X-Gm-Message-State: AOJu0YxSr4yYCkyEt8sYdL/lAEij5ObhTe/Dug3m3ZDS/k1/vDZ0KQ4w
 ZkQakoQSes9dIG7DoX7e/8sCqfZSiX6iQb2nNqoq/r6wn8eSz7NxP9C1g+TmvlTr+Q4Ge9LiKtT
 j
X-Google-Smtp-Source: AGHT+IEjxoUOk8qAPtat2+ywCnsRNZPJpIBwt+VKsMCO+SwYoIOjUC+pOrJp5lWj47WQSjbLrVKDEA==
X-Received: by 2002:a05:600c:3ba7:b0:426:67f9:a7d8 with SMTP id
 5b1f17b1804b1-42cbddf191emr40454005e9.9.1726057209971; 
 Wed, 11 Sep 2024 05:20:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caf33e9b2sm142069405e9.14.2024.09.11.05.20.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:20:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 51/56] hw/pci-host: remove break after g_assert_not_reached()
Date: Wed, 11 Sep 2024 14:14:16 +0200
Message-ID: <20240911121422.52585-52-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-31-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 33607dfbec..5855741662 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -689,7 +689,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_PCI0_CFGDATA:
         /* Mapped via in gt64120_pci_mapping() */
         g_assert_not_reached();
-        break;
 
     /* Interrupts */
     case GT_INTRCAUSE:
@@ -933,7 +932,6 @@ static uint64_t gt64120_readl(void *opaque,
     case GT_PCI0_CFGDATA:
         /* Mapped via in gt64120_pci_mapping() */
         g_assert_not_reached();
-        break;
 
     case GT_PCI0_CMD:
     case GT_PCI0_TOR:
-- 
2.45.2


