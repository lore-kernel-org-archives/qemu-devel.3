Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76035C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82S-0002Jh-NY; Sat, 21 Jun 2025 19:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82M-00027I-2U
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:19 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82K-000525-5j
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:17 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso2538000b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550055; x=1751154855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+3cqECiVR2tg+Fz3JMivkL65UkvEtN1qjo705uznv9o=;
 b=wEa1LyapauaH0nwSYRbnkIqqsmvAhd/5VN9ESjlW50Unqhx1csZdmsNntjz+cVu3I2
 0zTAYbhalN6iMPA7Ceb4lGvpIbAKUCtFG37x5PTlz4Wy65afCQP87fQ2uCmmCm9mPRZ7
 vQa+u6bTKd2F3Ri4wpCC5FIOZmopGx2oN1Binn81SbNgkyPv3gOk+VMYv8lm08fPsVFl
 DycRvt2W1h5aT8J4m6SrLM5V2xSq9zEkp1vnZL/gaWdnPnllUK7JdAYg8jzMp/HPY1AF
 HmphXvYFp+4G8KBGppuIL/LRs4Lhry38gHdp85Z3TNHWe/mTX4Ovz25iGVixCVc1+9Mj
 ksaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550055; x=1751154855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3cqECiVR2tg+Fz3JMivkL65UkvEtN1qjo705uznv9o=;
 b=q7uNqfVWDWbvAgjQAm17ji1w+4zDhbwbCJxheYy/rZzFcuRGkSib7EWVa/wvX9wSEu
 Mocm693BGBpGGYCRApNQoy5/59ssSCFgR436HN741gzveiWjcqqZ3PnmJdRtZjhDtP86
 h5ReUzPBSi4AJojmaHOYIZb1Rr/1qeJc91WJ2py1DAQARU+UjCcIVc1NEfoGsVSnSMOW
 bfq80qgG5p3tz9KJu2mJ/LRuJSll5vgzX/N9REJcezf6xdNcWu0VVNtXmqN3yeyDabjN
 EFtvTgpQvdTvcJTdbAhf2GKir5LfjdSDuCgGmM68iTIPMdnK9Yj02nSMR2o5TDxn3ApQ
 5K6Q==
X-Gm-Message-State: AOJu0YyCa/OXdArW6f25XkfinzA8WfP97Slpw7NRTIXo4UaR5jVjAHld
 CCRaB/pzPJIYyVrFEM3f0dKeN9ChkyzAOSOqtggh42UZBbOCS5ljUExxVRTe7J1iLF/Et5W8RZ0
 bNns+veM=
X-Gm-Gg: ASbGncudasBDdaqQhvmczY1Fa0dLMlvHM8N5BmZ/AzapefUIJ2kMoAM2SpKHVzVzNcB
 DprtVPEteCC3aUHsmCdkGUYxVwxY0pfBCbbN4t2wC55qS8wpEbOW0JL7/1HEYSjSN+lwZeD4SnP
 wQ+Sf0SXFhDEiTzx3oEfft64w4pREMaVVeu8yy9fc6QmdsPfg2xW6vedPGGlT7iKM2wa4aXO0Xd
 jjLr/B2ovimW2YkrFFzEKjyn5tg38WHBHvV1pz5DOvY94u4ryGmuhfK4dNzopwM+1vTrNIjBZQV
 xtn2piJBCGDh7w9NkVMFrKSbpmVYUl5UI4kB0euagN/iCp8gB8EH3YejA46USr9MlZee/McU7uF
 005pBYON9l+eeNZFgEsVI
X-Google-Smtp-Source: AGHT+IFFBzpCUkkEDJgy4F4KNuti3xqkVdvl8zkqU3YqAgBd/BmGopLwCdHyz6zqeT8DDcmrAPkDGQ==
X-Received: by 2002:a05:6a00:2e88:b0:742:a77b:8bc with SMTP id
 d2e1a72fcca58-7490d5c1d0cmr11257038b3a.2.1750550054832; 
 Sat, 21 Jun 2025 16:54:14 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 056/101] target/arm: Introduce do_[us]sat_[bhs] macros
Date: Sat, 21 Jun 2025 16:49:52 -0700
Message-ID: <20250621235037.74091-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Inputs are a wider type of indeterminate sign.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 64a7249d01..c0ccf6da7a 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -223,6 +223,13 @@ int16_t do_sqrdmlah_h(int16_t, int16_t, int16_t, bool, bool, uint32_t *);
 int32_t do_sqrdmlah_s(int32_t, int32_t, int32_t, bool, bool, uint32_t *);
 int64_t do_sqrdmlah_d(int64_t, int64_t, int64_t, bool, bool);
 
+#define do_ssat_b(val)  MIN(MAX(val, INT8_MIN), INT8_MAX)
+#define do_ssat_h(val)  MIN(MAX(val, INT16_MIN), INT16_MAX)
+#define do_ssat_s(val)  MIN(MAX(val, INT32_MIN), INT32_MAX)
+#define do_usat_b(val)  MIN(MAX(val, 0), UINT8_MAX)
+#define do_usat_h(val)  MIN(MAX(val, 0), UINT16_MAX)
+#define do_usat_s(val)  MIN(MAX(val, 0), UINT32_MAX)
+
 /**
  * bfdotadd:
  * @sum: addend
-- 
2.43.0


