Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D10BE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvze-0004l1-UW; Thu, 09 Jan 2025 12:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzQ-0004hU-70
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:36 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzO-0006zA-Kq
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:35 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaf60d85238so230470266b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442393; x=1737047193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8J/ApKgPVXOVC7MF+COAj1wGpBADeRQ/mLFnBALjiW0=;
 b=K9nnGKhQ3+F9O4UwB+iuOo1BoAbqrxPaGr3GakRokLdrUEpxCIQpP+/C4dBT5jZ1R0
 bNuPPwPH24wd565j7i3b/9krWgcQr2u3ZW9nTtyKz/PLzc7wj7BeqbUu6t+h1oPWv0ob
 fhfPEsy/0XQtwax2AzlFt9DkS4++T8U+vMc2mwsG2GnaVeCf5msmuuE0UP7r2vqikxXE
 Ed7rDbyIK58Wt6iTP8wa2ee7cNKexIlI09YER+4XE4JmQouI/Se/l2bPKng+8nyqlTQU
 TM04USxfwfq+PdS5OTuffIJxoj5GWfO0OaC+ZEIFVhmdtgca1YMSYjS/OI3psKvZ2KfL
 KhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442393; x=1737047193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8J/ApKgPVXOVC7MF+COAj1wGpBADeRQ/mLFnBALjiW0=;
 b=DuDv2hT65uSZZ+BGd9bGC+rPQMFAvwA+O9NaoZLr37QYtJM5eN5B0wvuqO4tvAsZC6
 OKf0tBld5EnocTQjwosrPJxy8kjHXax8sZHpNUNsHVTKt440HKdk4Z3Y3lZ2ALJQKf+h
 8WLCE82ehc+Yba17AHAAel15saT4IJAy7uOUnKMC15ABFM+a+1nxTSIHYcyM3a9sqaY3
 S+GisIttI7S9DuRbKEqGAcRdVlyGF5/TN9qy9xsLhpydkml1Lk04mqnRRS5HQFQgo/qb
 rOIKzKGhPcDyIcMSygMpkLZ1JtWpAs+rYr3AwXbgMb7q8mn7o//ShpQqDjatqoDpD0sG
 H3yA==
X-Gm-Message-State: AOJu0YwFBXQlmK6KOAUS8CQcI7QCElhMZGE+bln2TeYQo5mSu6zAcpTU
 zsAssses6G9bRgN5y0UXxcDq0B47KKbLkzcloTuOZNitgJW/WAPUBZleCWP7opo=
X-Gm-Gg: ASbGnctSmfeo/fTdz7qMtlu19OSePcA6CiZ4pboBd8+sVHQtv19KhfJyQ4Tm+nvVWm/
 T/nS5H2WILntC0Inx74Z4+lbSmrjAVS2D1KPRGmRG3kRhsV+2zBBcYhwwZrZiCp/T10oDiygpjC
 t8As0QpA0/kWOB2cmsEFOVefdejoQq+THZTJOqUwka58If1WaOMWBL+9cC4tplgGPYGi1M86HqE
 QeOSz9jzc8z88llHm4X7dOK4E2zAiSwVU6mr2IzYpMQs8DsLL/hcqw=
X-Google-Smtp-Source: AGHT+IH1WwSrucQjhY5tgtkj2lKyMRqnqRWyp7oKmf6PMjNI2EgHOx43PLM6Tr5JRtG7Jb6BueVTig==
X-Received: by 2002:a17:907:971e:b0:aa6:800a:1292 with SMTP id
 a640c23a62f3a-ab2ab70be05mr581209066b.25.1736442392804; 
 Thu, 09 Jan 2025 09:06:32 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9564865sm89347666b.108.2025.01.09.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4311C5F9E2;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 05/22] semihosting/arm-compat: Include missing 'cpu.h' header
Date: Thu,  9 Jan 2025 17:06:02 +0000
Message-Id: <20250109170619.2271193-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

ARM semihosting implementations in "common-semi-target.h"
must de-reference the target CPUArchState, which is declared
in each target "cpu.h" header. Include it in order to avoid
when refactoring:

  In file included from ../../semihosting/arm-compat-semi.c:169:
  ../target/riscv/common-semi-target.h:16:5: error: use of undeclared identifier 'RISCVCPU'
     16 |     RISCVCPU *cpu = RISCV_CPU(cs);
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/arm-compat-semi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index d78c6428b9..86e5260e50 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -166,6 +166,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
 
 #endif
 
+#include "cpu.h"
 #include "common-semi-target.h"
 
 /*
-- 
2.39.5


