Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7684C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQo-00074G-Sg; Thu, 05 Jun 2025 12:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQm-000727-BW
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:04 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQk-0007xh-4u
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:04 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad89ee255easo206240866b.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140820; x=1749745620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fvuH8HvAQx8/p/uvR6oOVun26lgz7dGSugraby/u8k=;
 b=x/0Q4efTfCCpsVj0Ram3oLbfU+7C0EKlA4KyC146Rt5hQJabboPM8O4KgHVM7Uo9ub
 6DO5osh202N6co/3eyrTxMYMSS/xMQMMAE/OlqiQRoMg62IK9aRWitQlAde5RSDr0lXo
 7KX+UtDBf0B9CFzySv8rK6F2ne09Xl05EeVq+8cipd/ENNyVc7nokTrz6Kp/HRx2bxQv
 FGseFF1cjRXaJTvu6f1C4SA3aDDX/xQoBsmBM84zjbQNIMzaFF5dkPcNflpjxfiMo15S
 bjsJJ0TbNx6NN+nYh23sqyqGkC0XjrIVeaYG+nbqaU1CkyuETKqaVfeNa1KDQj/08HwJ
 TlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140820; x=1749745620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fvuH8HvAQx8/p/uvR6oOVun26lgz7dGSugraby/u8k=;
 b=go6lfX+v3LkYm1OSY+1u2ySF7UhBifRGq6/OcOf9a0KOTK3D+MY3Axt7UWT96HRAXm
 m9zR6qHls2Q25GwloYzTFxKnBoYUxOUnLtc2naX722ZUDPx3ZQWqQ368YltgB+/Xkb+5
 TBVxsBoivytCm8oK1se5S5YsalH9RXIRRueiXL3hv02ZwGK4+39nghYc0crcD50U0VD3
 cxAkrVZcMovulLviDb36/7EJ7ZPcct+wCkE7bheNtI0GrJpQgyBvW2BB16sVpOf080tN
 UKxf2cXEUKoCySnh2HiG+ltD4++B0xj+S8Xr4/sx3bBirjuiz/KdhfPdjQwtJlMvFjKd
 XsLg==
X-Gm-Message-State: AOJu0Yxl+23ksMalH0sCMoBDpsjY0WY/A6MC9B6mdVNNJkl6Hdw/Vp5k
 /63165m9XRrvQu4VUUa7ybCQ6RFHLbqiJM7l9vtCVAWM/XpdN07Ke27TCUvpiWTpTxY=
X-Gm-Gg: ASbGncvs3UIeJEiMegzLS++WlYw92sUSrqdb5bF7F0aqtZwEHhHGc/9po4aTX1vaAdB
 gQ8gP6VlxGc+qxxR7aYq2fbtHgJeD1KHUR+hN7XHHVIADyyCeeUfAbktryD7+t7A05vFK+Fc7Q2
 KYcEB3fFFixeuLTBZf96tnyNo2RB/8KyQCS0GI6QlrAAzDOykQPbXc2wnsC61ljwnY+/eAFk3cX
 M/16zdgS7o3NhpBJoRUXx33W+DINmRagYaVNi8jRb17gAWA7Z58rFsNwifwYQ5lWzvvn14abbSK
 Y/p+fL0Ts5WrAAqtk6RBjX8BR6VT+jMpX7VQ5lNVIlPeWaBh07DA
X-Google-Smtp-Source: AGHT+IE09wFbC29ty6Wq34SMioKrMVHTE+A3So0UItPzn+BcVFLCh2/RglXZ1TzkzlrHNXas3oXXjQ==
X-Received: by 2002:a17:907:c15:b0:ad8:9e80:6bc8 with SMTP id
 a640c23a62f3a-addf8cdbcd4mr705086866b.19.1749140820136; 
 Thu, 05 Jun 2025 09:27:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd045edsm1275290366b.119.2025.06.05.09.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 979495F831;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/17] include/exec: fix assert in size_memop
Date: Thu,  5 Jun 2025 17:26:46 +0100
Message-ID: <20250605162651.2614401-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We can handle larger sized memops now, expand the range of the assert.

Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-14-alex.bennee@linaro.org>

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 407a47d82c..cf7da3362e 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
 static inline MemOp size_memop(unsigned size)
 {
 #ifdef CONFIG_DEBUG_TCG
-    /* Power of 2 up to 8.  */
-    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
+    /* Power of 2 up to 1024 */
+    assert(is_power_of_2(size) && size >= 1 && size <= (1 << MO_SIZE));
 #endif
     return (MemOp)ctz32(size);
 }
-- 
2.47.2


