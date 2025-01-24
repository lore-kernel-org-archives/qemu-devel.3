Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2D6C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMZf-0005xd-13; Fri, 24 Jan 2025 11:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYK-0003sD-90
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYE-0005Qm-Ru
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso24065665e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736135; x=1738340935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OtS+w3ShI/UCJ8br92Bpn5fDuc7OgrxDrAhBJJSSdts=;
 b=g18EzRDW/QDzbGYc/Dt+BAu3XSZ8WfH2Q5whGZ/mLqbf3kPk/8hyflV4TBxeU1r6xZ
 +RIPZHxqGoslh+HNWrUs/s5Zmr9AmU9CLjkE3K55GQu8umc4zToW7n5J2Y7fCDlpj1Il
 dfbpR/Yk1G0LkTYwD4cnl8cnLLgmNLmOcQ99i0tS7WDEs8XFKuwqWGRQtnUTRARjI/Zh
 dY6mMgwTTfDaJB94YRmTO9RdWiQg+Y7QbLMoQAOqwj1bu48OQvwI9X3dCPnEBMn8il+L
 ONJN4M4Vtdllw69KndgCWg+zwoHug8yD1rhhw8lBNMQYedouZ8RFzk5dS8dg4CuomMh2
 JIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736135; x=1738340935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtS+w3ShI/UCJ8br92Bpn5fDuc7OgrxDrAhBJJSSdts=;
 b=l1bUHKyqy51bZsojSdRfE5PjAx79XcbMAwlWi1rD5vsnuwWB5KglQcQOglomOOKl0a
 vTzej3NCRGqy56PbuAEFPV0YBf5CzP9UL1paL1uu/HAXSflnqDf8Czc6bsoCw0vUe8Ce
 Tj/rWNkQd0etvfB8+CVkBLPJb+bJNOhtNkOHFJpF1mOZkJN82dWtFWXnE03sNrMA99Xc
 PumM7fZThjIHeVp5aGeznw1Fu2hEh5SNrz2bJP6gU1kJO9ohGCBrYSf/sL+cuEn097dp
 Ge/0pHQaWDepTi6UyUcynJRK/rEqFgMDR+A4yNafGVwxAbcpkU39Qr0KxMkdetSyda1X
 czYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/OTl4PCZinZGUAw2Qg8uosNF8t6pCjrF8FG36obWudCc59kzRHFuXs5SvgbGdUoLQbC6wrb9I402J@nongnu.org
X-Gm-Message-State: AOJu0YyyLChnxAAzBJgLVfh7W7Bgsjho9//eYBTj+z3w+dnQVyQR6W0b
 bIJQdBxklYUXe1/oqf0UbHE3j/K65zX6oSCDEatbhVLfvYTgMxJyVVy+0DaIU0wSRm4lhm7WjqV
 H
X-Gm-Gg: ASbGncusuTKy+3lQ5EW4CO8wmXAHBM0ou+WvAOEeZ4uJewzmfxGpRV3rOOdOlLSvppj
 QHO16zslY7E+hCXdAh03JZT8zzQR+u5Gjdec1kwDjc7/RygHjl1rVBIg5Asuw1+jH3k9nCBQ1fG
 dqw57w67VI7JjKBl+6NJipR/SO9y6Oq6jnoKWONIoG9sXS3Wev5H5zsK3kP7EWvQaKHkfV64fsZ
 x5QXeg9XaYWxrGU146Xfjblqpt+Acc/QMRL85lLiGUqmrPamRtjuTrCKnYwanatEVFapf6a6d3O
 WsNigaOXlcg=
X-Google-Smtp-Source: AGHT+IFdao4LCLVQq04Grxx/yXF6IdWnc6mTZdJMECl/eoLrnzhfFt96oZWnOldwMDQ6CQYBXySCPQ==
X-Received: by 2002:a05:600c:a01:b0:436:ed38:5c7f with SMTP id
 5b1f17b1804b1-438913db8b0mr279746685e9.12.1737736135067; 
 Fri, 24 Jan 2025 08:28:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/76] target/arm: Use fp_status_f16_a32 in AArch32-only
 helpers
Date: Fri, 24 Jan 2025 16:27:34 +0000
Message-Id: <20250124162836.2332150-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We directly use fp_status_f16 in a handful of helpers that
are AArch32-specific; switch to fp_status_f16_a32 for these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 4 ++--
 target/arm/vfp_helper.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 44ee2c81fad..aaad947e506 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2060,7 +2060,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
     do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2122,7 +2122,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
     do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 45f9dfc8861..f3aa80bbfb6 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -380,7 +380,7 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
     softfloat_to_vfp_compare(env, \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
-DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16)
+DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16_a32)
 DO_VFP_cmp(s, float32, float32, fp_status_a32)
 DO_VFP_cmp(d, float64, float64, fp_status_a32)
 #undef DO_VFP_cmp
-- 
2.34.1


