Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3B0CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmm-00010m-O9; Tue, 26 May 2026 10:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsml-0000yP-5H
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:35 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmj-0001OM-7b
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bdce61897ebso501840766b.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805772; x=1780410572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HEvO5IG8VjlkPXIoc9dWoV0pnU2+6fyZD2rdebxmp2I=;
 b=SGEYpHdhYSvqucixqMb3p36wIduU4ZqOaFvStvIDF6DflZb9b+xPJyMQkP5WVjJycY
 LBMyxhTfAuVSkK+kKCWMHOEvIig+3pRhbgNoh5xaEgcCfiBjUIjSGVu0rf/hZfU8GiUS
 eEg1299QGyapwns4/Y8MLBn8DobFV+rDyEPBbrkyHIOUp42exgXC1FsknpMp5wzjJ0CN
 jcVldh0T4yKjhaQavOvmijj//x+ZCThHEJQrBCbRy3hFGzjPyOMA3bZ5sGCJeN1UzD/O
 GkUtYcvLo8VpRR/+3Ipimm18XvBZPqDhG6aE+oT2eRCrqsxbFPs7su5DsxW2tmOFOfJd
 v/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805772; x=1780410572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HEvO5IG8VjlkPXIoc9dWoV0pnU2+6fyZD2rdebxmp2I=;
 b=gls+H2PY4DvMxuOv7simyILVJ/AJXtMszoxpFcpIh5F6+DGBXh4vBC4HLQZO0106az
 9D7FZm65RpmRus8l33Dioin5SDxanq9/GfW8ijYj0qF3MbQpF2QkYcviqZxDWHoF2tgU
 y3wcNjX4j9AbX27rAjZ73mYR6AVzNHDIO3dHoZ5NZcVOWreVWM+UBOjeNDNPQthV5MdU
 ELyYgX0HUVtsuA9TtJI/EXXvKm96Xl0UcenZHaFnNqIUsyKnHj7YyMr2sohDOQVHnPRq
 KDV1ehpgA6aIlyEKNo4XizuHvE1yiSpUJkYfFFJW56uH8P4nTM6iwvr9GGP3yOL5USDG
 42wg==
X-Gm-Message-State: AOJu0YywbZCJhoXm29LIwW5oNVF3919CSFUCjn8H6NtYTp+JGR+jXNzh
 9hb3QNOIitRwjwc4/kgXFhiYtppp/r5Cs6uT0Es+tTg/G/X6Em+Nb7TTMWteT55gHmFtLpEPx/F
 FQc4T
X-Gm-Gg: Acq92OFyBqE+bSOIX7urECNWTMoXfjzVv58G0DvfvnHcsLq4yaAzraoyIGb+0+gRusG
 dn1o9Ko3lyEI7AHrkSIBwDS7ElCX/9qS3oKkDdqB1tU5ko5Z71RZOSwgE8MvbTYQ2Zl+fu/DYZ5
 3YXuSF1iQwM+Vc2p0PzrleFY6y7XJfmlPe6UCyPjQ8ZuHip+n4c7aNjy418EDo8hZrQeMTZ9WYr
 Wv2XLBES8eGvMgAK7WDZbRODq9qbtsz9rWdpeqcyrJxpA4cwT4THuZ/eaEqUrAo8MmNBSrPSIbR
 LBw9oPHhx2htrP8V1V2XnO3SOaVFQTTh0WOECFRn8KMY/B/MBw9mjQHkxwvCzAFRNN759nonPYo
 PapPFN09aOsQxO1MOKkO6dmrqa3AeJldzgehAnwW6p5a6u63PKpxLZmsMs46OLqDHFDh5pj5Oao
 hSt/yqNKfZSElM5LOfDwW1kBqAksNOhnMSHZmkv51uZhtChpFR6sLL8hD3as4rlUbkCnAP1kS1q
 tkrJ1aV5eBTahMi+XW1zvlidpETu7c=
X-Received: by 2002:a17:907:290f:b0:bde:72a9:ba83 with SMTP id
 a640c23a62f3a-bde72a9beaemr601555866b.29.1779805769641; 
 Tue, 26 May 2026 07:29:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/54] target/arm: Update HCRX bits for Arm ARM M.a.a
Date: Tue, 26 May 2026 15:28:34 +0100
Message-ID: <20260526142850.2326589-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fcc08ece90..0a9b4d41af 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -258,6 +258,9 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 #define HCRX_GCSEN    (1ULL << 22)
+#define HCRX_ENFPM    (1ULL << 23)
+#define HCRX_PACMEN   (1ULL << 24)
+#define HCRX_SRMASKEN (1ULL << 26)
 
 #define HPFAR_NS      (1ULL << 63)
 
-- 
2.43.0


