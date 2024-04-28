Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE27C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cnm-0005ub-Dd; Sun, 28 Apr 2024 18:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cnc-0005tL-50
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:13 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cna-0005UD-7R
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:07 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51967f75729so4451556e87.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342504; x=1714947304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCSb64QUO6bStXSl37yEjpM4xadVVio6bpX5EBZUn28=;
 b=byFahhmLXmvc8mW1hPRycUEzGe/axojwrkT8Mj7SGhZTGFNBAYhp3QmS65bjtqDMAb
 MHi8d6MEDmchk3SkmHEtlglngmD0Wj97BZSzTWL8BkfVzgJjKAt7oofx4GdR0bXQYUQU
 2ujzKk9APcjgTn9u3HJhL+3H/i/5V13yqvDbUTpp3P//UO/YiLbztdyJJZi/LB1pInXy
 kmAAfqqQfcvytqi4LI5Z7PLfFEq4oi8Xl9G/2/tN+JHe8jxVyLjVlLlyg4RA8VDCwy9Q
 +emYvXEtE7arAjCZlBXv3+VHOluNpoWiT4C/4kt0O4G6tLf/Q4Kq1ooU7/PYibK/BK12
 uKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342504; x=1714947304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LCSb64QUO6bStXSl37yEjpM4xadVVio6bpX5EBZUn28=;
 b=CWPCB3J6X7l2UAP6OAyPdh5pzy0pzCJQMbh1uw/KhyHYzO2fybe6m1HyELZKVKnBym
 PwgDkVDdbRm+t7J7YiAgll+e6WK2WvV2mhw0Otj3IMDF0wpikDokRDBWJS7uPwHlsGre
 IBagFp6ZPuFEeeTya2vkc7sH/l2rE9+/l0w432lctJZtbp0aOAkKmC3Uu38/b2Q6mscX
 Q3MvoXmoSE5TsJ3fYtDDX3igyBoLjGuGfQWV/wWPglqZ8tBuY0F8qoyQAMjLH9pwm7re
 kIRWd0qK4sHtoA1uiR2QzlfhOkvHvLI3C18eTX1WHDuL8p6ssmSFwTegRZXtLJBZYrPo
 tdqA==
X-Gm-Message-State: AOJu0YzFQ/Oy6f5GlfFse+vI/oTuveCQ1T5tosYxsph+gtHILravfIm3
 2rRgFXxjIHl9abvCPRIP70n8Uglbjbz8wmMuTz6WVRC3mGQ5ExrAqY3BFMX3jOsngo0JYEZSkYB
 p
X-Google-Smtp-Source: AGHT+IH3GiS2sMm7GNUp5H/lEciphSyP19Q2r+sYcddT6HRtKIoB13yLydaTIDLDUfPK5UQtN2LV7A==
X-Received: by 2002:a19:7508:0:b0:51b:ac8d:3ba3 with SMTP id
 y8-20020a197508000000b0051bac8d3ba3mr4962843lfe.19.1714342504019; 
 Sun, 28 Apr 2024 15:15:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a170906270c00b00a55895c7f50sm11648411ejc.151.2024.04.28.15.15.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/24] coverity: Update user emulation regexp
Date: Mon, 29 Apr 2024 00:14:28 +0200
Message-ID: <20240428221450.26460-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

All user emulation headers are now under include/user/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/coverity-scan/COMPONENTS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 91be8d1c36..1537e49cd5 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -121,7 +121,7 @@ usb
   ~ (/qemu)?(/hw/usb/.*|/include/hw/usb/.*)
 
 user
-  ~ (/qemu)?(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/include/exec/user/.*)
+  ~ (/qemu)?(/linux-user/.*|/bsd-user/.*|/user-exec\.c|/thunk\.c|/include/user/.*)
 
 util
   ~ (/qemu)?(/util/.*|/include/qemu/.*)
-- 
2.41.0


