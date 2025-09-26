Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B55CCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28Lb-0008Cb-8S; Fri, 26 Sep 2025 09:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28LX-0008C7-Hz
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kz-00044T-CF
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so1845795e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892682; x=1759497482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLCg9N9mRsCQoeuOOPX2s1zSAKuTeL3IamSuzw4Escg=;
 b=ijcGYD9sXZWLMea9y/z8lTg2FpqaybRx/vcthRmDOfhSzxknccoQN1joYKlfBPrQ1d
 dstsQD4s+dcr3F8bfknC/v6MvVJ4svPUxvUXgmFmMruPfjrp1kljpTO+MXozVxdnMSNE
 iwgwEafWxroo9Bh5qZmV23dh4/hFY8rKD40/ecc4HbZ/wQATLx35sPUo4LlPQ4iAGpTu
 7GXb1TWDMfN3dSwJGODwjH3b3V+e/1VghjMSvemGWzAAdBnLtIaLMHmfO4Q7uozVw0BU
 VRa84zU9rIKAvTwQ1s5PY7vpnS4pDaGEJ37IOp0BIX9XyKxHwd6PiFD+o+mQaGFGwXrG
 4ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892682; x=1759497482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLCg9N9mRsCQoeuOOPX2s1zSAKuTeL3IamSuzw4Escg=;
 b=uCNg7sUXeHZaRKxqWIqgpuxePpkriVDVGib49OM+H1ebAtFZ1qObJxmr1l9cHN7CtM
 978UHqolhC7eXN3DTl1X2lORs93tosmfltaJ66Zp2vCP3HmjDwyESJ/1bfugNfiGTkPG
 KsH4D6bF1UIMTSU6QkrGaEV2KMgxJzRK95CQvVbIoHLYErPr1pY7TfnHZFqN64dSdpQX
 ZvvK4VxqXBW0UANTMZWTaJXOlqfiwnfZqMgUX63kqvBZSGH1xZlUaKcHfVQ14uRcPHkD
 kRvDkCKwwqYhfwlpWa5cqRhhHYyleI2ulDcBI51Py3khJmsUzMA+xEj+jbEZnGnWg19i
 vHcg==
X-Gm-Message-State: AOJu0Ywd9HMFlOOPqavnsldSOqARPsFJb9mos61vSkWpeQICZu1CFJCE
 stGltRgj9j8PeKETwoJonsZ41Lo8WVrgqTfHfCbf4g7onsY+epX1Aiou4Sy3nr8HzF6wmhKlmQR
 rBFLpImk=
X-Gm-Gg: ASbGncu5PC6s0s2USlq5McxnxRZ1r8Vvb9brorlVBwGy8jKiEy40vpqfosCZF5xaGPA
 aaakduYCT1nbsQqF+RLs0fvzWhlCrdC4sEvjUoeB6+TOP7DDVSoNuJHVuZOprPTl+Ru3p1Dc/+/
 B9ixS1MTW68rnWnKl0MQxNZsKEjrAngJ+34umVNYCRwtrW8xppQbz/0HuDMDN732aKdFB7L1WyP
 y4eGg+KwPvInH0ze4YrlEfdXMK6DWyQTv0gjJA9cQJ34QzzJ1+nzgPrVlAoElLodvIZjhlHjmrN
 u1FmXwA9DwetHT9aG/vmQqVM//wJcPWw+9bzk/IC4wDEh7MJ/L5BiyCmrrYpfn4ItSFTFnb317F
 crGw9POSGX7wdL9MDBbv497Ga3BtX7ACw0w==
X-Google-Smtp-Source: AGHT+IHZ9/Opv1Nw1rFjOBxc2VK5uIseSk2BPIdtgwLZCXPlHGoxK1LsYsdV5ko0pSZsBGUVMej0jQ==
X-Received: by 2002:a05:6000:40dc:b0:3ee:13b1:d70e with SMTP id
 ffacd0b85a97d-40e47ee1da9mr7251603f8f.40.1758892681649; 
 Fri, 26 Sep 2025 06:18:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603365sm7353573f8f.37.2025.09.26.06.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F25115F915;
 Fri, 26 Sep 2025 14:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 13/24] semihosting/arm-compat-semi: remove dependency on cpu.h
Date: Fri, 26 Sep 2025 14:17:32 +0100
Message-ID: <20250926131744.432185-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-12-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-15-alex.bennee@linaro.org>

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 3c9192d8684..61001267965 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -34,7 +34,6 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "exec/gdbstub.h"
-#include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
-- 
2.47.3


