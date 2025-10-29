Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6E7CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE70K-00030o-Lv; Wed, 29 Oct 2025 10:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vE704-0002zc-6B
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:18:09 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vE6zx-0007WA-L6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:18:06 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-592f098f7adso9398071e87.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761747476; x=1762352276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30doxA5irCh12lo/8IWh5zRedaxf2ZL44iw4b76NrZs=;
 b=FvdIsbisVCAAt3Snj/RMqEt+7UZUgY29Za6DrJKx0ggnLQaDTMhexF/8xjJRrg10AG
 pDTPlTBFgQp9fqHrKvNmivvrMOhqbDLSbPg+ENbfcxnRGVdRil077Tq03p7QkAOVVe1A
 LjewV8XtyJzBv4WeqktH7fJyr9mcOhQaLVvcPYhjnkZk/eN6+KJAr3BlLoeqr+OmN21H
 OccVO++Mhxx2B4swKtzxI/ziQ9Ck4crqicoQE9zfpql8b4kEb3PYkcI7U5pQ5jchUV8m
 alUL8l7yIqmSM4X2ok9nQtx86B7JA47ml8Bn3aa/gEg9dbeFqx+86xY2b1k/6mHtYeIX
 6XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761747476; x=1762352276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30doxA5irCh12lo/8IWh5zRedaxf2ZL44iw4b76NrZs=;
 b=ZXwfxaBJnghPLwa/qGk7gKV3L5eoANpTwKqrSSH/qTJZPTCT1wq2WHVy7aNwmsfCBl
 ypdgAN2tsNPKSuO4MlswPZlFctzAHSaPjRJxd+/JIPAm6mf1UyPv5pfwpzFmu5ht6VM2
 oSM/uzLGZpe7UYnsx06HiGrEEQ1cFDw/2XKaysKNhJkM/E6z4nY6DsOcfNrf/ePHeIUq
 UkcVS8lsWvvVRDIOLOEC5Q68VtwnXDg7J1MG8XgtBAwX425JCJk8GHjZOwcITAiSn05s
 rEDcqIpRtbhXLMUW42Un7oSk89FxGjk06eoSKRl1lhoe2nsIEUvMTpBvC+jDryq2I7Up
 X/qA==
X-Gm-Message-State: AOJu0Yxy5/MvxfqR+K17vdEh0Ax0CbptvLhhEa7cCrLSviVt5GAS1+Yr
 DFEzfBGheNtWOOl8W059zBRXBbcVFDT3ocVyE03hYkrdVdH4hN4c6Fi0p8gwy340CCc=
X-Gm-Gg: ASbGncvaj26Gyj/IcVyP3xm87BC4YUJ0vm4UF6jZ+4AZmhVfPsNBPigUxYzmK6+vdf2
 49Il4yGRPYvuNlU63ro7g0hrE1JktTpg5u0N2BebBiGbA4YGTHYzy9bekkRt3/uoP8Be0Qz5iha
 vbFjs6zddwbONqLjFWbp81xxjsHoZ0EKbnpdT1fMfuS66kKaY04Rwr4+WXKjZhX9AvwnLBaAL4T
 Tt12oJGoNyMY+9IOKvPIGwfWcWmbg2iR3oH1AdZatzfH7+qohFcU9obenk6i7SENw1MlieOiqA5
 5BRvx//HFfoUe6J+EO5sZ8LCP6QUuBKCKtO6QEup/siH/h3xfasz5I2Fz7wWmv721NcfUny5Lxv
 jIXhGtcLz3g8gOcyrIGQ+0jSuznA4rYyMoEWBgfqsWeQkz3o09hAmJ2HrmbS6MuN3622DwQzGvD
 zFHKsofQZRTms/zm5toox7pK0lHkuNSdR6dWzjn2nARog5tq8=
X-Google-Smtp-Source: AGHT+IGxGA4cIHrxBok0i7duBmZ1gh2TIocPUh3Tw209hvmszKW9+HNLnKzhxthMunLbg+U5uKxxow==
X-Received: by 2002:a05:6512:3185:b0:57a:f38a:397b with SMTP id
 2adb3069b0e04-5941286172fmr1019816e87.3.1761747476296; 
 Wed, 29 Oct 2025 07:17:56 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59302982cb2sm3726650e87.65.2025.10.29.07.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 07:17:55 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: richard.henderson@linaro.org, edgar.iglesias@amd.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v1 1/3] target/microblaze: Remove unused arg from check_divz()
Date: Wed, 29 Oct 2025 15:17:47 +0100
Message-ID: <20251029141749.1274729-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
References: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Remove unused arg from check_divz(). No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/op_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index df93c4229d..886224df3c 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,7 +69,7 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static bool check_divz(CPUMBState *env, uint32_t a, uint32_t b, uintptr_t ra)
+static bool check_divz(CPUMBState *env, uint32_t b, uintptr_t ra)
 {
     if (unlikely(b == 0)) {
         env->msr |= MSR_DZ;
@@ -89,7 +89,7 @@ static bool check_divz(CPUMBState *env, uint32_t a, uint32_t b, uintptr_t ra)
 
 uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
 {
-    if (!check_divz(env, a, b, GETPC())) {
+    if (!check_divz(env, b, GETPC())) {
         return 0;
     }
     return (int32_t)a / (int32_t)b;
@@ -97,7 +97,7 @@ uint32_t helper_divs(CPUMBState *env, uint32_t a, uint32_t b)
 
 uint32_t helper_divu(CPUMBState *env, uint32_t a, uint32_t b)
 {
-    if (!check_divz(env, a, b, GETPC())) {
+    if (!check_divz(env, b, GETPC())) {
         return 0;
     }
     return a / b;
-- 
2.43.0


