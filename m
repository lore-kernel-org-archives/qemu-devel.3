Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA65DCD6E56
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcIX-0007Ge-IZ; Tue, 02 Jun 2026 23:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI9-0006kn-0B
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:20 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI7-0003i2-Hc
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:16 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c8573e75425so1896337a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457354; x=1781062154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JX7+OeeD2FN1dxWerp/I3Ll3/ZlzCTLqZCteUU7Y4Pk=;
 b=lVQ4GcACq1plpz4NlZpuWdu/LRDWOO+SR8SGxIrwKcSWY1s0oyQhkgbrZZLFukGZmX
 FwTSyDM7BC806ddgr1kRFDeRIrDmOaGpdv/xopT0fYoRmXRwD9LXuPwXVm4J99g1Li5i
 za7yIuFcdV2554CLOppDQTMDOgLWSYIFdWOLLwanhTW3r4yJVdZReK1sx8t00zuCcek1
 wBeUkyCiuDA6iMPB0gahhUZ271PTeD/kNEWvzu8/TFu8a7MDnXQcqKL8thyhoVlNMmDd
 7J1MQAEHdupbKXnWLd0Iehx7iExpP8cVXHkngKnEDqSkb1EjOz5Z/oKLZpuqsWJG89x6
 fe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457354; x=1781062154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JX7+OeeD2FN1dxWerp/I3Ll3/ZlzCTLqZCteUU7Y4Pk=;
 b=ngSbGMCo1vL1RQrWNDhobjOb53zGHN8CFwEYJkE60S1btJDX8PPljkjrldI5h3zd+J
 2APk/Yw/RmAh2Bu7RsAv0goB+i43dUG+AXfIlXiVm+Ldlmq+PZGxtwy6uRTCX50eZ/UM
 bIM+8Tk02Xx4IPidiY7W5dEmF/uIM1AYgHEg6m+HMVLwc6yAmvduuQtVEaJ1IXRbZLJ1
 NX21qi/DIG2RamQbBhi4JEFgawkuQ+URbWEln1pE5suz9zShqrZZAMjJ7iKPRwXBEzAO
 jvLNuJJ+i6OxOHd13kpBiYRSyMB+vlcSjKXKuzYhSeIDRNf1MFQeunZcwruk2qEC1u+d
 Xe+g==
X-Gm-Message-State: AOJu0YxdK++vQc/4K+TTchgYM/moKyX5XpG58m6JQL+CGlALtjThtPVl
 rE2m3YfPGH7XX/CvmaWEro5ptsjGvRMhilmCwKIKGcBr68AorFxXvVvR7k45BUy05k6qreKvPFW
 wEgpv3Bo=
X-Gm-Gg: Acq92OE0phaf+KKjYCC5cBN9mIDnHxasYkz8JUpbIxXyAu06/vruY4Lxc1PYBoQlX+C
 gHlhLuFTw+4rS/3pw2B9yIc/w35tmNOvvZXVkr5TouOwALHgFPIqMh8EA+0Wg9ge2V/8bVRC6dW
 ewmHHWVX7BZmafxBvN4sqVZZp9alzRO0wTXX4vsT8/KWJyHhrrX693elI/KTBo/WKZGH6mlxpBz
 xL+VuKUvEb9dXpoiNuyysL8hHPV0gEnHTQG6jyFKZ2uMIotQEFUSII1Ol8zbUHCBWjlxvYlgCua
 7P5SM3AI+Ltg8T+zRY48aYmKfSWQmee8zwYn0G0CVi4fmsstQQAwqif6gC+UypDGW9NgK+o/Tzg
 +m9deiFzyNmXGLLOCfZnwFDuVzeA4SK8y1fqrB2xt/lxgS2kxRekoMjleOttf7dcLOygIdgt7ck
 sQfc/NP8W5jaq3WwTZvoJBj0kat+vpJDpM0e9VuYo=
X-Received: by 2002:a05:6a00:32c5:b0:82f:6e7:1527 with SMTP id
 d2e1a72fcca58-84284e93300mr1622885b3a.23.1780457354041; 
 Tue, 02 Jun 2026 20:29:14 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v9 25/45] target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
Date: Tue,  2 Jun 2026 20:28:34 -0700
Message-ID: <20260603032855.106930-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b220ed3437..3a754f8d61 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -397,17 +397,28 @@ FIELD(ID_AA64ZFR0, F16MM, 48, 4)
 FIELD(ID_AA64ZFR0, F32MM, 52, 4)
 FIELD(ID_AA64ZFR0, F64MM, 56, 4)
 
+FIELD(ID_AA64SMFR0, SMOP4, 0, 1)
+FIELD(ID_AA64SMFR0, STMOP, 16, 1)
+FIELD(ID_AA64SMFR0, SFEXPA, 23, 1)
+FIELD(ID_AA64SMFR0, AES, 24, 1)
+FIELD(ID_AA64SMFR0, SBITPERM, 25, 1)
+FIELD(ID_AA64SMFR0, SF8DP2, 28, 1)
+FIELD(ID_AA64SMFR0, SF8DP4, 29, 1)
+FIELD(ID_AA64SMFR0, SF8FMA, 30, 1)
 FIELD(ID_AA64SMFR0, F32F32, 32, 1)
 FIELD(ID_AA64SMFR0, BI32I32, 33, 1)
 FIELD(ID_AA64SMFR0, B16F32, 34, 1)
 FIELD(ID_AA64SMFR0, F16F32, 35, 1)
 FIELD(ID_AA64SMFR0, I8I32, 36, 4)
+FIELD(ID_AA64SMFR0, F8F32, 40, 1)
+FIELD(ID_AA64SMFR0, F8F16, 41, 1)
 FIELD(ID_AA64SMFR0, F16F16, 42, 1)
 FIELD(ID_AA64SMFR0, B16B16, 43, 1)
 FIELD(ID_AA64SMFR0, I16I32, 44, 4)
 FIELD(ID_AA64SMFR0, F64F64, 48, 1)
 FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
+FIELD(ID_AA64SMFR0, LUTv2, 60, 1)
 FIELD(ID_AA64SMFR0, FA64, 63, 1)
 
 FIELD(ID_AA64FPFR0, F8E5M2, 0, 1)
-- 
2.43.0


