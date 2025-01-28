Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA24C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcry0-0002Ht-U8; Tue, 28 Jan 2025 15:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxs-0002Bs-VG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:40 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxr-0001cU-E0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso3381394f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095218; x=1738700018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S0EPrxvy5SUfyFPeGhm6fSW53CJD1XiOAdrHKX+9t+U=;
 b=hb1FYDnhtUVz0viRhevSIPZJeV8cmD1afVWzYao+jRm3WGQV8zqrNrfO16/VI+tTeL
 0hCRP1s9zuvkmpXUjaaxqhnRNBvzsKe0xEahEbAMB5B4Inrdzy/bw5YRHFHoGP+rk1Ws
 gcdn/ojaOgfhUTz624aJ4W2fNCQUSXxy72nPZlzCpZAjPxU/GeocgTws3m71ohGLRTXx
 XZo5SV/g5RwE8V9dSW6FGHb/m9DzenYLrCva12sXGyaSZIthG1q99pqOp4VdHe33CsDC
 A5KcukVNNrpmfXL1NcZJbYU5ODk1QkXEfUTZULS/+NuiRo5t5Gk3WUfStrInCpCOvrKY
 fovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095218; x=1738700018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0EPrxvy5SUfyFPeGhm6fSW53CJD1XiOAdrHKX+9t+U=;
 b=wwjhEC9CJ77+QXteT14uzvORSnsIlXH2+xNB5GZsRuPHwZ/I2i451+NhUYA1J0i/gM
 lrZ+oacRuhlyUFN+HUvXqGWFxzXVQlixrzExu/jUtFdeQnkl95at08rGlFt2ZDzHoOhd
 1jy+YqfYxLKqf84BPWfaI/UDsDGt9fDcHZSUIu6r3XUanQ8kCWTR8Mhnwjxl0KaKzqP7
 5VvG3VHloPvMW+LHCTojeki0HHmv9/1zfpUQfvCPLdqWoV/AFSkyONmfj770h8cy0W3t
 TUKbKNdBw6PoFmaZ9DqhnW9cPzZsS57kEi4K6DBfelSgGSkn7qnVTzDJUznZHwCd3yEe
 uqNw==
X-Gm-Message-State: AOJu0YwFO53mtRWj8VV5OfsQ0yPaYu1B6BwC8e5utcGLzZ62f8womiBP
 BQNPN9Z8CxBL7+fJs3fmvm4ZGbRmZFwDchuJxIhZXwNjAdOQjE7JAWevmKS+83Rp00bmMkB3MgK
 i
X-Gm-Gg: ASbGncsHyor1v0XckcGB/aJY3+lmXAAF+73wZuFZAVDAGJ7jNMC6jr/QkFy40CNz5zy
 KhG6HYKZabqSg0jm2py+syPrCOmaagClucL4HISWNRT+Q56+R9aBoqG//0oKjueYWIGJZ8eEt7I
 7eNr0ndTVXq72vzt6yR/hzDjmBsj/mRWEvbC6ztIh7HoCS707f/Yl/VEFPepTC5C7WOWGqU3Eup
 8RrXq0YWe920fkmmhPKYsvRw7V34rX2S2dZMbqVJOudo5TG323fPHfoUd2YjN95AJuGZ4TmEmu7
 u9PWKVPFt7IEAAPuTvR1Tw==
X-Google-Smtp-Source: AGHT+IG4BAAoLVKXVyr6CTpbroq9XC7zToieBZFe4kXRIiww4JZMtm83u8REglf9bP/FtPlmHphlZg==
X-Received: by 2002:adf:fa8a:0:b0:385:e1eb:a7af with SMTP id
 ffacd0b85a97d-38c520be00dmr281216f8f.48.1738095217794; 
 Tue, 28 Jan 2025 12:13:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/36] target/arm: Use fp_status_a32 in vjvct helper
Date: Tue, 28 Jan 2025 20:12:58 +0000
Message-Id: <20250128201314.44038-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use fp_status_a32 in the vjcvt helper function; this is called only
from the A32/T32 decoder and is not used inside a
set_rmode/restore_rmode sequence.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-9-peter.maydell@linaro.org
---
 target/arm/vfp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 7475f97e0ce..0671ba3a88b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1144,7 +1144,7 @@ uint64_t HELPER(fjcvtzs)(float64 value, float_status *status)
 
 uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
 {
-    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status);
+    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status_a32);
     uint32_t result = pair;
     uint32_t z = (pair >> 32) == 0;
 
-- 
2.34.1


