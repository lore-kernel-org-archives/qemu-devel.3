Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D162F9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX4r-00065d-0U; Wed, 22 Apr 2026 08:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4j-0005zj-P7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4g-0005UQ-3s
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so3786752f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862380; x=1777467180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUXCf79/aCPWP+oojaJHciitYmV1hJJUoyGLuPcbhOc=;
 b=jHMRUyFsdX4VzurLVquBXj7MaRnWqtfboT+LxS/l5hmDo5irDjH9h/v57ywQMMdXPW
 2Mvg8OjXqS64X0hoUswMsLFfS1IHcJXJTDjw7BrM7YJA61KrsGgmBVk5Ctj5VYtXQoCW
 Z21i4wZLCxWMwt9FBR8Yy1aqBgSmqGHcwvFKaUo4CHmBpxQ/eOUQ6fP+CaCjxhh8xIex
 EgybwgQ/xwcOkJ5PjdXuuUkrBIyqHoj7RvAE/kKns5Q6oWCQzvs8XjBoiXnDAxoSzWLP
 RLPVyCsGPEcOlGI1gMYoeDjDYjn7m9MAbOl12jnH2xgAmoHleuJVGtBpoHzbFvo1c6gw
 EdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862380; x=1777467180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rUXCf79/aCPWP+oojaJHciitYmV1hJJUoyGLuPcbhOc=;
 b=ps9krKsfqxZUDsaLY1enY+8ndIKZPOAv8cfnJ14To2/9Izr/QrgLVpjgK1xzd5wx7f
 VJq6W6fAt+f6Tai5g2wp7u2pWp0LBY+RuDRLD6k5FNLx2wvJcRrhrwgT/PPxiJq3Fu5E
 MmH4P6pvuhhmJMjFKyY/bjV3JPIg0d3tET05tqL++d9W+pynNYFDjze5h3UIWpo8LG2O
 4UCzwMqH8I5Q2fJ6bn2zzHHaYx5w65Qt6NtFBKIaKGwhxDZTOgtEURpfr0f7ttnD9SN2
 JfBOSrNvvVHglrmp22cCq3iKZr3ikDX4oT/ucpE3P3bBsB1KE4Fxow/zLFa8OTe47zcf
 Nvgw==
X-Gm-Message-State: AOJu0YwoXayNSvBB4sWlD/P8fYNU0TJp7YcE3hWb7RH2xjr1fJA2rVGL
 gUKAhMC+XXA15uiX/C1Wvd0BK1wkp+4I03YSwasvi+OeqLNfuHU7Jhk+NNvfMpIVbrs=
X-Gm-Gg: AeBDievz0Nz4ZEEVOAbkpWKlm7OfRDZKSBz2qphMDb5Sw+LJ8R6HPuDHThh7c8LYghM
 kSVkclhU2ojpFOIRl8pPc2eTgA9R9dxUm5vPECti5UKK3XiHLUXMWGXJH4XkhdqZhTV8Mr9Lst9
 zF/kZ+0UeYPpWipF79NuaPXBfjGKT/jNviUmCSRmDYaTnbEBTWdKrC4T9tmPzzj2c+MZFMSGEoJ
 8UHSqj8HRd2Q2hUx899YORGMFNVmE9EgEN31SulLlZ8PtNlrRNLPKPUtT7JmGwX1+U/GQWPK8+D
 yRJ6YMRgwnEnEO1u4Xy/Z7fjZYsuanS2oEoHeGn4gOUZfMC4C0wjfZmuLVCikrWGxvd+9RHOMoA
 lyhFop2vpWbC42GZiuwRsVODloxGTFYYMid2hhP0SaU7XrcqoclYygiLJk8XwL0+cg+OMbkCU6D
 PH5Fkcp75Ia88WugNMBAA97AWhhJf/v2j6wPEmwEuhUn8X
X-Received: by 2002:a05:6000:1788:b0:43d:1c39:593c with SMTP id
 ffacd0b85a97d-43fe3dfbcb8mr35169488f8f.30.1776862380024; 
 Wed, 22 Apr 2026 05:53:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm51870727f8f.20.2026.04.22.05.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 58FDF60342;
 Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 05/32] target/arm: migrate SME trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 13:52:22 +0100
Message-ID: <20260422125250.1303100-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 63c8e66ea91..61053475984 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -384,10 +384,18 @@ static inline uint32_t syn_erettrap(int eret_op)
     return res;
 }
 
+/*
+ * ISS encoding for an exception due to SME functionality
+ */
+FIELD(SME_ISS, SMTC, 0, 2)
+
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
 {
-    return (EC_SMETRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL) | etype;
+    uint32_t res = syn_set_ec(0, EC_SMETRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+    res = FIELD_DP32(res, SME_ISS, SMTC, etype);
+
+    return res;
 }
 
 static inline uint32_t syn_pacfail(bool data, int keynumber)
-- 
2.47.3


