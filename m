Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72032C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyN-0003g3-ER; Fri, 03 May 2024 11:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uy0-0003Ff-3X
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:57 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxy-0002k3-CX
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:55 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a524ecaf215so1332580166b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750609; x=1715355409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrZUKaXvCoLZb05WO8svoXk2q630F/QIOO635ivl1JA=;
 b=nJ4PhqveMsb2CWcCBTUY7HHUHzGzJ6Gi5aCTSd3KD0EkkKnX8WVZ3QCxQCdL2YHlvT
 h+t1wzDvoLXbox4hOxLo0yyu9Zse6G6WtewLddAyEDp9GpCnX7RCL869QcAbxUENX+Sm
 4XkfKh8aqTE5R7gwc5WDAlGCGhltqz1uW3CWwxEErTM44ovGdCvqvEJpnEI+GV9IMTYH
 ZlBdvdAk2MpvChCuL0Y6ap9/AJ+mtr05I/l7BXpm6/FHwogMnf9En91MCDKE4ltlj+ax
 es/vHi6ir7WE5EME/QiVpv10VXMhBQlObyVH/ugta51DnimwvLifzXj8DghO6VcZSp/6
 Nm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750609; x=1715355409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrZUKaXvCoLZb05WO8svoXk2q630F/QIOO635ivl1JA=;
 b=UqSoK0ugTXGV4K5YdcCt6Jc62VD+fr53U7P617SLfkAPrnzAtfpfOf+0p4DRXJYcNn
 HmiSLxKTkR5qwqliTcQ+ofG/aF/EcWh5XEG9hCDp/nXjNYPcd9w4NqTi/bMjh0/PxjV8
 n6KVxobSmgEnKU/3seia+Q5gJIchyk5uR26GcNRmbuYBaj/oiUjTj4jOY88aiBnShzRT
 Od5eAaudG2LvyC3jT7Ep90bhfG59jSWph1T4rLRHPg8GtZR+sf5BXjVmjbU2t+ZwfJQo
 iJioaFXW18z9EQsyHYjKqRf4CSdqm0cMtFZFFJjT1RPlTc+fw28U1cvX69eBTj2RTRL0
 Pezw==
X-Gm-Message-State: AOJu0YwF1ClIWzHgwq9YuEYPH4HDATr0egre2FhuDj4a3l0qg6RmbIop
 1sBwPwr+BHSO3i/pOV7mBHsjBJET9RTLPp/bfmBUm5Uk6kt7t537y4KCLfNfIiE5SJdnqKE9gCN
 C
X-Google-Smtp-Source: AGHT+IFLVFozUZfLPUxfKAyHg/U/u7wAGWbKtEQ/XkhQsUTRn1xbEXDo3LGkKl0bhVsky5TAjUNElg==
X-Received: by 2002:a17:906:d8c9:b0:a55:63d3:7499 with SMTP id
 re9-20020a170906d8c900b00a5563d37499mr1984275ejb.59.1714750609659; 
 Fri, 03 May 2024 08:36:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a17090633d300b00a5965ba49cdsm1789020eja.109.2024.05.03.08.36.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:36:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/14] coverity: Update user emulation regexp
Date: Fri,  3 May 2024 17:36:05 +0200
Message-ID: <20240503153613.38709-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-3-philmd@linaro.org>
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


