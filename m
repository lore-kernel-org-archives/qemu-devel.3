Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B361FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEub-00069z-3s; Wed, 29 Apr 2026 20:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuZ-00069l-Ir
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:47 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuY-0001k9-9S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:47 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso107960a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507545; x=1778112345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITXVWTswHK0ITcm+gabq4ujW8XFmcTy1jBekq3ZfSNY=;
 b=fsORKUknINLJRbYkmwUDBFIpLDGAkcaS0VzNgfoUCaUnJ87KdotPBxg9WUe7270o3l
 YsESCuo0VA3f8Gv+MllEJdjjiJykdyeaHugr6mZkl4wDOW9FfPQM8lUe6J912hrwlvpT
 6lpWZzfAogEC+oEb/i1/DBttTvRKDNjaaggM4mGhsAYx0fLTMTsizSocpezYwmuw1Vx+
 mhhQoo2Beu5HB7dTuLs4dXYyUooryFiYvIYWCv4mclqGeIpVJeJZAwuayYw5rujL09gs
 7JhiPdrFYv1mjdkdPmZfLl+hy51qlz+a5Y4f/yVpiSYpAo9kYNakPLVHAk0ud/ocXTJM
 Q9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507545; x=1778112345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ITXVWTswHK0ITcm+gabq4ujW8XFmcTy1jBekq3ZfSNY=;
 b=CFS7KM0ubs6pgrd0D090SXdMsMFN03fe9D58qQIqHWxwvJempxAVs7DCWHKSW+r+qB
 xWF6zxZ11sCzJPV2WBENRoTgDLMiR7mdoGlA7TlG7kqRN0h1IwvgdvEs5SaR38QCJakS
 cbNJ/Xkj8sUmiaDUVgPhF4wbeeogCltby5z0kAwWqjxISCyXqo87SIJwUp2UbFvjgh/t
 dK9KS1FvjEVBin15Z0NP0brpU2ChZZ2IMk51mE0yhThuA4Tbce2uMSHKrUIewy3zd4/Q
 SNEnZY13mvA0pXDHi46tklIoFZ6oQP4fjytKTnCsEpJS2/HIKL+hxFmZooAyOwjCs8kE
 p8MQ==
X-Gm-Message-State: AOJu0YzJymzvrYE/yRm4a9n9nZ+lrICUq6IKOFszYnIF4ahn2l/fItuJ
 uTnWe4APJBHVz2rAux6Sb7yO+rJ6hI6nelw7kzdBZWkpM9mxutD2VeuT7CUtnIurnzb5IXv4Ftw
 VnVwJHWc=
X-Gm-Gg: AeBDietLAY7pyvQRR3znF7H+r9CUFkwyWlvRmT3/JET5F2mIFXPXFsUXo+UMcaYJ4gw
 T+iQ+sneM8XoRwHJmur9wVHEzQnBrTSwewYC2V9o7XM74LByL7lpIbxLb3gpz5FBSko4zi7Nzmo
 UCqaj0ncM5ZrSTNGOFFSpqcF3QTwWEHkbw2BqNMuC3dz7vM/Q/K8Sb8DmfjfeGPVrsU39H1mDUa
 E1NDuBX48luAfUkBEpA4oh0kQFti5TQZXV1yjo+ibYRFdXR7l4+qFwSdvN4soXtyqrTCIiovh/T
 XanS4KXh86puK9eJzepXLl54qjKyqY0IjBIh0Mv1x7TNjBsW9Jh0BhdTDAF29aESyOxovWCOYmZ
 qkIaJyhWOhsKd4vnoNB7IK3QGJdi/ouFTlSwwp5KcqWBH1xnHAX89Jj4PEvB4DZ7rIuMywswIjc
 0NaPsFqnLCY0kF2mZkfgl9mQd9288kkKNYAR0RX/3o
X-Received: by 2002:a05:6a00:a809:b0:82c:e83d:a9a3 with SMTP id
 d2e1a72fcca58-834fdb6f1c2mr758322b3a.22.1777507544769; 
 Wed, 29 Apr 2026 17:05:44 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 07/40] fpu: Mark unpack_raw64 QEMU_ALWAYS_INLINE
Date: Thu, 30 Apr 2026 10:04:50 +1000
Message-ID: <20260430000524.56046-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

This is almost always used with a constant FloatFmt,
so inlining pulls the constants into the shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 302612fe42..63697ab3db 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -633,7 +633,8 @@ static const FloatFmt floatx80_params[3] = {
 };
 
 /* Unpack a float to parts, but do not canonicalize.  */
-static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
+static inline QEMU_ALWAYS_INLINE
+FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
 {
     const int f_size = fmt->frac_size;
     const int e_size = fmt->exp_size;
-- 
2.43.0


