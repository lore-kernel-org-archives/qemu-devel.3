Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350A3C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsh-0007YL-LC; Fri, 07 Mar 2025 13:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsV-0007TO-Dg
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:59 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsT-0007oE-Pl
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:59 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso3599772a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373816; x=1741978616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xGAU/49OeEOOEzt+6b6VcCQ4H44QO9LUOBmF2tDbf4=;
 b=Pvry11wzpfe4flGPMP52A+z9+b1TJ+kQy/K41L8FYqfNDRFnqv6dGXAu4+K2hCPT3K
 Mxj3AAVITxG44u3Eho1szYb8mqPOom91zRsgQhQ/U8Hy64gkUpqaGHw4nA2n6aSbEjaG
 T/llqL20LcvnZlUEoQb6DOt6ju3eX2g7hceLSZ5HuwqARy2CtrFpVWWgQpjco42QobD9
 QKSke+89QH6ukYWStqorCYIg3pGwJKm1QiMfqiWuF5QH8WU2FOD8AnoWb+bqSDE++it2
 FW03+5isQ1cY8AFE8WzY65ynvoPnycpJvKBk09Y5Wvgb1M2ghppz+fW9qVNaTINnilBP
 APUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373816; x=1741978616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8xGAU/49OeEOOEzt+6b6VcCQ4H44QO9LUOBmF2tDbf4=;
 b=rvdb4EOfhz8P03rTd7pSuMPHaefiPdhVd2hcp5RiZbe6FO4ekjVxC5KLKFYXV8raSs
 c4n9XV3/6FsG+72+sAKMy+K6scELWMH05s/2mUAOzO44PCQF3gp8sT/nb3YvpwgUhHUf
 sSx0Fg/ogfUhskFYLHCOf3IoGxzQZdNyG9KPpBn66QFrrormxBiZAr2I2n6nCaWaxPlu
 CdP0zFJgVvpRsYhiCw9su5weLwiJAvTnuc79qj+vxosnmW6bbEr0zzmGcJDj1PV9hkj9
 f2nhkflwDk6g7c3n2uYdMC+5i7y2jIdcKlEzHmRbbgfAPPSjsLX0UVEi8g7dDOuWFLIP
 e9/A==
X-Gm-Message-State: AOJu0YzTvOg2G43kHQa3HP9uP85lt3bHjMJ46y0ZTZHsmvsox3FTgyW1
 wMYCuurfFd8qmnpg/KZ35cimOX141ONZg+DLjlwXX9YNm7o9mOH+JjBXsSuyYTpNN3sZbUedJlD
 r
X-Gm-Gg: ASbGnct/0qfQJl0KF3ioAo+JFinB66wWoHek4YLEG1qSOAPBA0ex5J48k0rTTPKR+8h
 lRGM9IYHQDnCNJ6RzzAgF3JKWpgzDi2xpGcconMgoenR4Npj9FcWILbafizYJj6HcrWs9y5Wo6l
 MNqnhV+y36XHrmKMicq/SrQUmx0t6VSd42vXAN1pTTCOdYomIsVfqtXZhtGEmLnXx2L5PTNgRCh
 bawo9iW8pfcPsSbz3cal/GWvv2SRFfwiaIq9l1UpkJtMH17HPnJmogAyjpomUIlwoK0iTKr4lPE
 X1bjG5r/6iUaDnsLfZ8tjrYfbHPt7Vf2Y5tdPTXpE1idxOtACOgsJsr902BElTYlapgTdxIOgML
 a
X-Google-Smtp-Source: AGHT+IHdaukiL68NDZCeyfizn0sTf6RGxC+glZ0vHaixzU+W97bEjj+IR1JJaneQtU1NH7YMnAKKoQ==
X-Received: by 2002:a17:90b:2d82:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-2ff7cf0a651mr7252721a91.25.1741373816466; 
 Fri, 07 Mar 2025 10:56:56 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 12/16] accel/tcg: Build tcg-accel-ops-rr.c once
Date: Fri,  7 Mar 2025 10:56:41 -0800
Message-ID: <20250307185645.970034-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

All that is required is to use cpu-common.h instead of exec-all.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 +-
 accel/tcg/meson.build        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 028b385af9..f62cf24e1d 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -31,7 +31,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
-#include "exec/exec-all.h"
+#include "exec/cpu-common.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-rr.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 891b724eb6..87c1394b62 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -21,7 +21,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
   'tcg-accel-ops-mttcg.c',
-  'tcg-accel-ops-rr.c',
 ))
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
@@ -29,5 +28,6 @@ system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'monitor.c',
   'tcg-accel-ops.c',
   'tcg-accel-ops-icount.c',
+  'tcg-accel-ops-rr.c',
   'watchpoint.c',
 ))
-- 
2.43.0


