Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5BFCD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzU-0005e2-Ad; Sat, 30 May 2026 17:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzN-0005dE-Sk
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzM-0000dz-Fl
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:01 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c0bb4a94b8so1655105ad.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175579; x=1780780379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riZGLawdoBOsnTwywvNnX4cT6gxxxwkn5L7hcDVC/T8=;
 b=CST/WvmVJ4UbgyHTmUijqvvUBZbEG83j5p+w3cWWXKNvUYNKtlJ4CeLaBGWfgii4Gs
 rzgplRqxBqIxYidLi2oVyqERdxwpdu7DXX+1kb4Fcvo71y0wrS4jzCxNOLqm4u0iG1fF
 06tPFNAJFUGS9ttnCkGak9JmlPhv2CcMGvpGx/D9Em9u6GIn+DfJBfF16HYIsHpPk0nJ
 Dst42VwsuPfdnjso3T4ABTia7R3F2JI7Q3VOtGBQHkQ6Z//L/drflYTtKz7ZACa2+FJh
 cH/ZbQ4yjcjjIV3VXDnN4InZ/0Kj1/sH6N4Fdw1l4TVSi0LovGaF6v+7ovaAMY743K/M
 VeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175579; x=1780780379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=riZGLawdoBOsnTwywvNnX4cT6gxxxwkn5L7hcDVC/T8=;
 b=Pdt8bC2eZHpMX+LoX0PDM57FfG2FyOfx6P7Sk1co/1MWg2o/hce9XqyRJIfqGoDCGQ
 WNo7IUfrFFKP4aeQBlHrYonzSD8AKdjlwpAJbfpa16et12OTqDUuOn6Zi8sjaPW4iG7J
 CB1l1MOA8PbJtkp2nlXxbH08lnLcjgk73oSrISyqrzCS/TPqGxl+Oc2ne0GbwHSlykio
 nDZsNqkkpksrwgeCocYnNKcIDTUhH7QIwyrqEIELDEI6WHzNnUntjPM99u+uEl4oiK88
 O4dOsrNxcVZ29C4bkB+y6PK5wdaBvJNCxKzGt0p0tyj5ObVR8Ho9W8T6TBZrreuVchyh
 wslg==
X-Gm-Message-State: AOJu0YwADls3AHrfoQFVEvLWkaw6gLYzXmJG1hccuXODNHuzgaDHNqIY
 eRGeOXKpnbyMGVFWzF3CBbkIpvMebtv8lZLZ3mjjTY5dkuuVyc1aINKWUMsv2UI57Zqt7UxHrFy
 /Sh22gS0=
X-Gm-Gg: Acq92OESadkvilWPUgyeDmApQkEe/3fXb0UgYsiIvMj2NX60N6vr+QJdLPFJAhbA3Ul
 PkdhUZUixiesG1rYhsMeIGrzHRfK4XeZSoVIc+xq5UE0cKvzpj7jpPK9dlDEVnwRfHqvoncCpBl
 lGdkXYJIbo3HktqATrYcSSTOAPCuVtOW+efkXfXcV8TbQhH/TZrpBk6ktz0zXrK/Bgl6yd3oAGC
 fOT8jjm0QKcVnBRSRkm0uxit5eTYZ0TA9xzjq0Zp26N/rYRWDINuXrwgyLy0kcNABFpKk+QurVC
 jjWkFMhJjPmi+QT/I0/NoPTaec0gcwOE433QyC4xlOE/JqrWsPxfmYSzOYnJadT7Z/MB1D20xQ5
 muuhFyQBd3/hPXcoBWq7VIr9G5YGCrCfTvqRK+2mt6fDIEHiJkzMpfTbIfj3ISZzXwi7UO2fOCw
 1ffWRfzzs/m5XEHeqh/WSv3W2W3Zk4QJhDbnZVqvZGqM7WdJphag==
X-Received: by 2002:a17:903:3510:b0:2bf:3559:b25f with SMTP id
 d9443c01a7336-2bf367dd7ffmr65151115ad.18.1780175577173; 
 Sat, 30 May 2026 14:12:57 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:12:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 08/13] include/user/guest-host: Include missing cpu.h
Date: Sat, 30 May 2026 14:12:42 -0700
Message-ID: <20260530211248.375318-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This file uses CPUState without including the required header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/guest-host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index ef83ad8a18..506efc097e 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -10,6 +10,7 @@
 
 #include "exec/vaddr.h"
 #include "user/guest-base.h"
+#include "hw/core/cpu.h"
 #include "accel/tcg/cpu-ops.h"
 
 /*
-- 
2.43.0


