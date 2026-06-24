Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A1FCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMzS-0003TU-NX; Wed, 24 Jun 2026 08:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcMz4-00038V-QZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:45:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcMyz-0006Nx-VD
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:45:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-46019b190b6so844444f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782305132; x=1782909932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJY+W/ZKEQvF6jKnVZwMRA0n7P4OO5L2LHPk6wLaYKI=;
 b=g0iQ/Z+37U9b8RtAsvzkxT7BTh7nhsEH4YsYQHll+e6p7IP1q9zZDQKyBMRS+yelQf
 bWjejhp3vH80ZhnGuReim7wFNdO2Dz/I+1PvDqeem2TIVwBJBG0xhSmKaHKL0ae99tWa
 6cYEwUnqfp9FlmWW2o/7OAz+LrGNyavgnDJ5tH+48VDC1o+QNHaPF9N8Tp7fviroMcWw
 kw/kgJw81u5aePrbMzhlnJ3YYejIQfmgm8EJ7qBk5G+/mRDLcB9zIQeFGh0eeSOIJIKK
 GdnYRymzfffnfVsjmSNqHuIQO7M8KWtJqdzKqo0EppwvDG7wy4mLssp+qNAeFEVtZUAT
 lcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782305132; x=1782909932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jJY+W/ZKEQvF6jKnVZwMRA0n7P4OO5L2LHPk6wLaYKI=;
 b=DU1J87LaC4ZhG3IjFb8uT9K9nm4vD3NK2Qw0T6ZDtVroLLZfIBKmmB5KKubnqRO1T0
 LcgGMj5vJeyAcVfRnYE1wfVOApruuYo8k0Ij7uJ6IzaWgEx2e4/+EiB7GGzH5AhzZp5G
 zszIRG1s+KzLMyjRH5zcf+C625a9PTWi0ni1c2r9m069GmyJRi2oWN6LtcEZYxetJeX/
 dOVLzQsJuwBo81I3uZgxED6rYMbJwyNF+cz5begAwNG8fYyQxfvwlUg51Ovlw9P1YAob
 H9qXDnbF5fzJvRxpaid5+KmMbi5Etckxx7cKq78OVn7to2Uc/sANQzKpzHoAMar6F5wf
 YozA==
X-Gm-Message-State: AOJu0YzNfOWd5peEp1pQ/3prsXbSZeC6YlA1DdH7ipkQk5EK6ls4ts5r
 Y19tUWumdeyMSGxjBWbfcJGHCkO/wj9qMm5CKx56GpoG8USHB45T17x5fG044/NhvwU=
X-Gm-Gg: AfdE7cnacLbU/Wwn8teENGfqxA07qiZMv684FD28g0fEPj9KwbXMtsvf0gkdwl0uJNB
 TYnyYv3pYuzuwLvvVSv3lz+zh4lG1dPJwL3Q2+Fnb/T8yMt2xSr3ZqH8KXfvqBagbjNbJ4LkBk1
 aK8UtLW5/JpRbU5mhQaE9JF977Aifx87ab6tRx+wGnWTUAdgPFUS9Q3+bNQAon/d4T20WLgGbBV
 UWS7ADwW18IqJxR5KweKhpUTy7n9poW9T9ZHgOs8pNCdqeLYAuewg1sZ46U5o3gDXkPbCfLCxe5
 8aI8vojfrB+dv4B9Ggy4Jm12KxUeDaEga246JxCV5mJc8GqktfLMlqugIudfmkEoZKeqUP0vEqu
 dwhZP/TIIRUT3D4etrZ4MbAYM0pZBNPh9lDdWEFhrQx5avO22gCqkWylbuWgRg+cpkp95UzywRA
 wKRf+TziVNoBtJ
X-Received: by 2002:a05:600c:3148:b0:491:9969:739d with SMTP id
 5b1f17b1804b1-492608794f2mr40868705e9.29.1782305132228; 
 Wed, 24 Jun 2026 05:45:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924944faa8sm361273435e9.13.2026.06.24.05.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:45:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 23CE85F845;
 Wed, 24 Jun 2026 13:45:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 1/6] target/arm: split evaluation of CNTHCTL timer IRQ masks
Date: Wed, 24 Jun 2026 13:45:22 +0100
Message-ID: <20260624124527.1018912-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624124527.1018912-1-alex.bennee@linaro.org>
References: <20260624124527.1018912-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Whether the physical and virtual timer IRQs are masked are independent
of each other so the checking of CNTHCTL:CNTPMASK shouldn't depend of
not changing CNTVMASK.

While unlikely to be seen in real life we should still make sure we
behave correctly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a234aa031c0..3d52cdc4a5e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1802,7 +1802,8 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     if ((oldval ^ value) & R_CNTHCTL_CNTVMASK_MASK) {
         gt_update_irq(cpu, GTIMER_VIRT);
-    } else if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
+    }
+    if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
         gt_update_irq(cpu, GTIMER_PHYS);
     }
 }
-- 
2.47.3


