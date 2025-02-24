Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B75C021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc2o-0006vq-Nx; Mon, 24 Feb 2025 12:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2k-0006un-LZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:00 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2j-0005Yf-0P
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:58 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso137339395ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417295; x=1741022095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHAdfN98EalcKVEjBSSimTDU4XR40iCNkU/fGqXPJUE=;
 b=gx02idx/AhbzlDb15bM76d/oEe7za3aSWJr2sa1Z8WLPwrKdeB4qHTDSfyzsDqeLAz
 CiWEuoMzNfnqxWRoHi++63td6OK3D3PwptnxvVedwHlb5okMWKxyQg7nRcG0AKMs9G5Y
 3cIJAt6pFnP7gWgSP7fjjymOtsYcXk+0UsPlgnf/F2cczCeTOs7I7/8eXY4l30F7HbaX
 sDGF0wgjLrCfxWVSv8alPlW/zTPOTU79da7IDM3YA3R7djRDVTlxFYhsvSCgQ/+safNQ
 QgQDOjvbSJsgWFeEKt2mSbGUGVWZ30pTYb8BvLtV/vWiSCJ7/7i+fmS5TZoqN0KKBEHt
 q5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417295; x=1741022095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHAdfN98EalcKVEjBSSimTDU4XR40iCNkU/fGqXPJUE=;
 b=o2y3sPZt/LFDGDEqt3UFbuTa2e6MvpMJlysl9QQlOCiSVBiig6yVo6cWUi9TyNPMFm
 tYOPeNuHNIXWZqunsvCWijIHYE+1VVHEuBt+Y2JS04844aIJ2mV1hylPoKnHZZqLDNvY
 0C6eC3Hwjs6PLCcqe59zE6pYUGJppEKnkUB/aRy6LoHnyu4KStlqzkzoMOnFLX3rKAEf
 iTcwEE4UXvUN8dAzlL7Jx7bw0LESr8YNXeCnF0AhSq7LxygKdHRLGhc1xXpLp4H69Lqp
 y4Bvbi/i7A89tI17SfScADq1fC4qvRpvhm5saSbRqman4MIzjueY4jh27cvM0X0Yb6Mo
 5XrA==
X-Gm-Message-State: AOJu0YznUM0qHpZ0ywoAyQ/DBgD8BLFKdUAQ4X71rWUKgFs18tp66OBQ
 qEt+7emvZR4VlP2UO6uw+ZrZ44gIwwJCGQQmbq8Hyeow/fEWSbTlQCzCM3/rF89Hn7uzMFVZPxK
 h
X-Gm-Gg: ASbGncsyJ41rLt4ZKmN4LxQyejZHb1EreeMF5mp9FdvZf27TI7gNAGUPXaNsbMBOIq0
 aruMtpUcjDhlxZAEoLS1d/db7hk8MQvb4SzpaxeEK/aCDyt23xuQl407T5gBFm+5d/2wkb6i7W1
 ZwLHHGWXRpKG/a628DfP6wlb8kvNWrjBSeKTsciYyliAwNmUYH/q1D63oZUckB5HRa4kv9ZGMB+
 gIpI1qWgJ+PNMZN4vW3HrC4bt/Ot00QFwR3nQG7WADswP6rkG9gHA9EaruZJhFupqBihHhlYsYZ
 YXub7tKF6CPYKLlL7wA6OXAcS1zpefFz8+U=
X-Google-Smtp-Source: AGHT+IELsmtC+rJkJ72K5G3gfhhT2nwyYKEt86zSSmOF6gUhHsxejMrhdScF6c1rTyaq5emHBZoz+Q==
X-Received: by 2002:a17:903:32c3:b0:220:c178:b2e with SMTP id
 d9443c01a7336-22307b4bbc2mr34805ad.17.1740417295560; 
 Mon, 24 Feb 2025 09:14:55 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:14:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 06/24] target/m68k: Introduce
 M68K_FEATURE_FPU_PACKED_DECIMAL
Date: Mon, 24 Feb 2025 09:14:26 -0800
Message-ID: <20250224171444.440135-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Set for 68020 and 68030, but does nothing so far.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h | 2 ++
 target/m68k/cpu.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7b90e1e58f..b394d8bbb9 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -574,6 +574,8 @@ enum m68k_features {
     M68K_FEATURE_MOVEFROMSR_PRIV,
     /* Exception frame with format+vector (from 68010) */
     M68K_FEATURE_EXCEPTION_FORMAT_VEC,
+    /* FPU supports packed decimal real format */
+    M68K_FEATURE_FPU_PACKED_DECIMAL,
 };
 
 static inline bool m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 5dbad8bb43..7936b1a7e7 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -202,6 +202,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MSP);
     m68k_set_feature(env, M68K_FEATURE_UNALIGNED_DATA);
     m68k_set_feature(env, M68K_FEATURE_TRAPCC);
+    m68k_set_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
 }
 
 /*
@@ -244,6 +245,7 @@ static void m68040_cpu_initfn(Object *obj)
 
     m68030_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68030);
+    m68k_unset_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
-- 
2.43.0


