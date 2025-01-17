Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5217BC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdM-0001Hu-Un; Fri, 17 Jan 2025 08:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0000xH-Jg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:08 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcq-0002CS-7x
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:07 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab2c9b8aecaso329038566b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121379; x=1737726179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXBLUkL8+yV2RgOy7GvclV3RoZ3IJx6imsmC3PeKgzg=;
 b=GVokmrSdyT/lwVZRQaZofRkTOLzLgB493e+eKcmLXCkXZ2bUarJBrJqogyNVspnN61
 +aEolV7NbFb5/WatLbfZZiK6ImDE9+Loy7c8IjoAd20Qgh2e6dtwsPPCEE59yHSFz+cL
 1zdRMfZO3MMZ/804uAZUI4hPuT8TaxM5iiATtfMGvGgu5Jv0N0GykNcDVKF0KjuqMJxl
 g/zGUWTX5pwJ0C5rvUhP2HZFC/JPryLGoAlPeMaBm/QsNL/1B7ksuWkQjihgVgaZ4VW/
 foXhzUnl30GabcsMZrSWLznfHuSxgfe/kDhMXgN4a9Czx/dFdGYFhcNBOA3D9kh4b+uj
 5wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121379; x=1737726179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXBLUkL8+yV2RgOy7GvclV3RoZ3IJx6imsmC3PeKgzg=;
 b=oOVzLuUTDC6BtRAuVwL7zIHUf4oRHHGE7PdSjvyi4trlme7BGaxTRodwEy7tGkWfXP
 z+ydLVEsWhR3jV2DiNEEbuDl8G1Jwit3uTDF1Vu2O85AgjvICIA7QP8gQf3v/H6FhuOo
 yaIA3mFn0ceq8ak1x8EH9pVnQ5g17SuQu47Cv4g9UzhvHE/JB2dPLlTT7W9Dmxtrpx6T
 arpYnbo+eh69h9dnN3djSaiWtcm1bWwDQUKm/WM6FL/C6gbAEtGrxKycuKdRrWxJm5oK
 c/4bO016F+GrSRSUHV/WVSbIMI2eJ6R9c0f8Y/6niBpPoJ3CVxDQ6mPLmkJHgF6eF3ek
 CsCw==
X-Gm-Message-State: AOJu0YxkGQcd6RFLvpS3pJ1M9afJVIvdG6AQSVfzZflnDjDjsFW39C5s
 VhIzAyvmkpqlOdgnUv+nQvoQYDtTZAb33b0cfN2ol2P+9T4pXqEJ6VZOVFfRZOI=
X-Gm-Gg: ASbGncvf7GNHlVKkohnNU6uMVLHF/3qrYXvChKf3+EBQGWK5YmcdvUfBfLAyrbfaU3X
 5M3je9LvNey13wdljIY1M7WNR0KgcU+fYpbJrjP8scA8HS0m/cU3v36We/LIEAeVfyQxaicgUai
 tLJBnLgEjhViF0Q2IL676/lkZ2Xytt1Jy3tgWSumfTlRZNaFabXBh1i/QofaQYGnd+qSsNLmUxr
 Oveg+nI4eifILF6zP7vHmStbfKi5nw0cpZdMovtFPxJIBtduiB/yzI=
X-Google-Smtp-Source: AGHT+IGrA5oXTZWhIgwpgVfchuwVEnNvwRhAFU9mByMYIEI0vD6r2UZTeA59LAsmKiaoc5w8heKZUg==
X-Received: by 2002:a17:907:72d4:b0:ab3:84b2:4247 with SMTP id
 a640c23a62f3a-ab38b3808fcmr272000666b.40.1737121378861; 
 Fri, 17 Jan 2025 05:42:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcd90csm169662666b.181.2025.01.17.05.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:42:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 28B8A60858;
 Fri, 17 Jan 2025 13:42:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/37] semihosting/syscalls: Include missing 'exec/cpu-defs.h'
 header
Date: Fri, 17 Jan 2025 13:42:22 +0000
Message-Id: <20250117134256.2079356-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

target_ulong is defined in each target "cpu-param.h",
itself included by "exec/cpu-defs.h".
Include the latter in order to avoid when refactoring:

  include/semihosting/syscalls.h:26:24: error: unknown type name 'target_ulong'
     26 |                        target_ulong fname, target_ulong fname_len,
        |                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-4-alex.bennee@linaro.org>

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index b5937c619a..6627c45fb2 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -9,6 +9,7 @@
 #ifndef SEMIHOSTING_SYSCALLS_H
 #define SEMIHOSTING_SYSCALLS_H
 
+#include "exec/cpu-defs.h"
 #include "gdbstub/syscalls.h"
 
 /*
-- 
2.39.5


