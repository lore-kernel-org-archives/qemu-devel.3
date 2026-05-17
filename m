Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A7CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPS0-0006UL-ED; Sat, 16 May 2026 20:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPRx-0006FP-4E
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:45 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPRu-0006mx-KN
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:43 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c80148ae949so349457a12.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978020; x=1779582820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xM35gHOjOqj4uCcYch+AkhQTaXi12XhXc0hhEraB8uM=;
 b=mYAeAGKbflE16nDYTk+DNhzAa79bOLyEYtJHuZUjnn99U9caw/ZqSXMz+L0ybaXDRi
 32mJsNVACLc7EIvlmCNvJ9QnI5a6dcgOdZKXJQdRoDlvpSMRQ5NMLMboD77uY5ei1hyY
 ShaGSyznLyHkhMsU2o9vMp4gzNmSo+m21WQBjHsEiAo+9+1n18Ddp4j6QLfBxz0Vbqed
 fn+HOLu27jklSpi+mqtk423iB74rmswzmO39tDIeCKuOB8T0CQdPwdAPPUo47GGO+TYJ
 l9i9lnWYcQrscrQefIDjTegejfaGu8WmkgAZfyadaudRrS55bFPQdaLPIhyXtZcV7wGR
 9hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978020; x=1779582820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xM35gHOjOqj4uCcYch+AkhQTaXi12XhXc0hhEraB8uM=;
 b=ddkcWSlpwEBOIUmWhdx50l+6cCKDUABQaj88C3inVysDoQhCRLQGmlRmO/Jgx2pVh1
 4SWngPCry15aSEAYYy4tAjoNHOIbwjnq3YA+6IQSCQzVl9aT8pEO/9GHh2zUhjUZeE6h
 ZINarCxhLZwygevVdOTt5mYgFuSiOO6W4Whgkw3D/AU+0XcY5PG6VDg35K2mZgMTWO2O
 2cD2Yzpek4UyUdfKR3YrNm7Yn5SMVVS4W86WbN1CaMdCJANwoS46/Ee8ywObEoeHe20z
 dgweMk/2JMJ89LFJItyM+xggsT3A8WYxf2qIo50ztln0akvAcS+kOE87EhktQMYjfNeL
 0nlg==
X-Gm-Message-State: AOJu0YwilLQVJYOm6VlQdHDWo1XcN6CdKn7OvxWwq9xjyUz90Wpvy1Yb
 KFApDc/+8hXjwTKnmgFxfNe/N+Uu0MiPg7NdGjhEw1bQt5TYh5BAbQtkZtBzU8ZOJqRxcg+xGPl
 evPNs
X-Gm-Gg: Acq92OHjw1o5nqXnrAqlvoD8EKiaMLjZv65/z3wgoOh4mAZeiXXMnrjkkWhIP4wp6Yl
 GQgQzULBG+8nZMgqIOb+HSrM2jU4xAcsmF4AmVg2Tx4dGa1ICCCsm7/EDdvvTViGr/2KN3e8Vgw
 f0RRIvmNQjrAuSvmjtkCQ485GEMD9qssa+VQuLyHFZhuFVlGPcm7tg7udb/gTvVguy4/yGLcgrp
 +WGiDp07yZO+caLqYd+8Wqa1XDVWYPARcXMjsfX997SYnNxUIdNJ0sc/EBqRFYYzq8QUyHHIIuB
 HlphkPZcPscVelzTO3TyprutWxZA7pYUW9QP06C/VjKoXMHO6IEI/UV1Lwvd1TlbHkxWxjvQ9u3
 jTlGQjKk4bvctIkXkCyaKD2MpzvRp4H88l9NEHDkf5X+LRPsfArAO926fHk6dg+CK3yTuiDNE8L
 m+RfP4nT487BfcHTxM4m/LNoQaWhcseo5N6uBNkTA=
X-Received: by 2002:a05:6a20:6a04:b0:3ae:b670:6d35 with SMTP id
 adf61e73a8af0-3b22ecab6f5mr11471316637.24.1778978020427; 
 Sat, 16 May 2026 17:33:40 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 41/63] target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
Date: Sat, 16 May 2026 17:29:40 -0700
Message-ID: <20260517003002.321430-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6d5994450f..811f2a7291 100644
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


