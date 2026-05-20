Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F4FCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlYr-00074X-4g; Wed, 20 May 2026 14:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYl-0006qA-D5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:23 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYj-0000U0-Et
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:22 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-367cbac9c37so2875108a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301339; x=1779906139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTOHTZtbLNgNOJvES0sHS6aWgPQHY2/QJQuHdbaHCMc=;
 b=UyKSV8O5PR+Lg0uyatCnfv/lpD/iY13KqlcI1t1g7a8BWrxrrJ0M+cKXqU2p8JeuMO
 LIegXqaXvNPB+EPdNiqJGJRacxMlI4xVLvSTxjsaWQSXeIBKfDIWErqXYv2wnB/5FDRz
 rSNoAOAgHIQszgIEln/x+BGhCmx5oRk+OXOnshB8G9nK1pDHKfWGKLA9yR2xFePNrEeR
 HoAgLo7qsC4GT+Jud9GtmTFqEStppBsg7qMTyn5trAp11epCPQ2SINwB4u2grrQYSIFJ
 aVV3NTy445Z81OQI6f+gTALA5nUX8bZqWgjXDGsXAkltWkhFn8uHY74NJ6pWn8nyh8gz
 xWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301339; x=1779906139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VTOHTZtbLNgNOJvES0sHS6aWgPQHY2/QJQuHdbaHCMc=;
 b=ddc6MK1+tGFQlXHddHRrXm/yszdrDN5WfhpzQkoccwF7mxC/rVpyO9THXwNbTVR9FW
 BSViKfwVKvD25XWTkp/j08tVb3cxsymp4ZGclVu65Ch6MJ4pAH0+8qkbB9ig36ZGV+GI
 CVtCneDQQN40vqpbD3x2rAIidV5R646obP6LI0452rI839+bLpqRVhfXK4cThLiMw9Af
 2dIvl55amnmGF0N5EjA078Y/E0AJnSFuMOaZMDuyJ4rMRD30TJq4+feNlEvN6KcFFvIW
 ptw6I2KLblt8KtuqPax5vzNnFYyXkz4lUsWV2k925cn0uGXQr8jlRy2WViEkscHiWzs0
 Yp3A==
X-Gm-Message-State: AOJu0Yxvr6uqoLl9PwEJ1Gjw0faBCn/ZJWu1Ov9H8JqmNy6xGhFuFQ+V
 RKe56jquptnINOSid+cnEwGY0fzf2JGzCwJoZTSIi8BjHDTLN2sv97iSpQ2wwcRmg4HHg7WgYl3
 C7tfDYCM=
X-Gm-Gg: Acq92OHJMnEg/oMJSVyB7r0EIdwYy+GvaLkqIsYRDosxFGC9WSZkAArCIzockZwYf4H
 Y2AaEnDAIInpIAvQMKr/EgfMdII4prwVvHbuPtfy+Wq6H/GwzDKv6glehypdevhHFMc8TVPQWxX
 A+fNETYpyRjLfn/IcZvSBN3Qh5oZIBkZ5WU4K5Ww/FRejbCJ6EHx6zr5j/ZexP76W5pyWl+tIdW
 igivOzVdQKfysqXYPEcrH6fl7ITR2omGBat78hRGDNX3SFmXcfwX1LE7W8JF23g+E2fvrZpGZMb
 JJYjnuC0eorY5OFeCkzh/ATIlrk4FdwykZBawVeTbRQq1Ksunny8EgyLklLF8ToVZJnddQqBxL3
 W7eyVHOe6V7x8oJJxOS6fpMDgwtXcr7Qi9WeS0o8ds62d9depOfnLHCIh5bucViCmM4QwsA9tSW
 1hGpjYi8rICv+OcT3ba/uAA5B2/aAX
X-Received: by 2002:a17:90b:1344:b0:366:4782:138c with SMTP id
 98e67ed59e1d1-36951b971ccmr26021323a91.17.1779301339380; 
 Wed, 20 May 2026 11:22:19 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 07/64] target/arm: Update HCRX bits for Arm ARM M.a.a
Date: Wed, 20 May 2026 11:21:16 -0700
Message-ID: <20260520182213.872945-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 target/arm/internals.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 00830b1724..f02d3c6a71 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -258,7 +258,9 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 #define HCRX_GCSEN    (1ULL << 22)
-
+#define HCRX_ENFPM    (1ULL << 23)
+#define HCRX_PACMEN   (1ULL << 24)
+#define HCRX_SRMASKEN (1ULL << 26)
 #define HPFAR_NS      (1ULL << 63)
 
 #define HSTR_TTEE (1 << 16)
-- 
2.43.0


