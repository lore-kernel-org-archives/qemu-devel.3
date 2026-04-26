Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F509FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzj9-00075H-To; Sun, 26 Apr 2026 09:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzit-0006xw-GZ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:35 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzis-0008M8-1A
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b7adb38d65so31846105ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210832; x=1777815632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7r9gKcYxP/AKKHrV6vUOMBch48/rRs6VOLxoecOoEA=;
 b=huQgvnYhZ4Zr/EQ9osNEdkbE3yVHsR9ljtDeTO8TkiIX85gm/qn8zhs6K1PQ2jwFdJ
 rCaK2Lp9Nvi+d8p5Quf0dQEUq+Flcd8QBUbpNNtBvOluQMk5bYBxMqUWOXlI5H/SGNoX
 C2PgVHdT/D67jXGuxQGml8pzVNrhNuJLHr6zPWCP61gg/4BgR/jPCyHHG5i4fbRfdpAz
 sWfXQ/C8TVHMWDFgsGBcOwXV/4mzdZyQJfjISD+EZSlNxDIcAuLnlFQEJwLXiELY2Hk0
 WgWXrOQtWOluvL+RcmqmWhu6l7UdHRx+aHMxJV5BF+0vwH9VmhrvhIIkaCAtBwN75ey9
 MbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210832; x=1777815632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i7r9gKcYxP/AKKHrV6vUOMBch48/rRs6VOLxoecOoEA=;
 b=atGgjMz4p6x1NvXCnbL65SffRQSZXe3MIvjipNPhtVS6WJFN/Q8YBAlknQ8888BVbV
 1/nypYM1g5hCinBizRTjL9BdvDpxPNmcoAymt93Q+cfwXxwAsvln/MUx7N3G2rRuhMxp
 jkV6vyJI2Qa5EjQ16MKmiQJfBi/R3GHmU5zTFqBvrgcz05QmVhFXGi/z4qMrqfRfaPXj
 /sFHkONfMb4EzySPaL9+B5xb6rVLAaOQ+iOLzp5qXRY684OEWB0Da7HkbBKQxhs5P8oC
 TnnxhDFDKLAnkXLnLoHGnQUHKrKQkkVr9BydG3VKkG7aVAuxA5WYLMzNnBBeUWrovKaf
 vCWA==
X-Gm-Message-State: AOJu0YyWH6mSZogzQwltzlHwCPcuj0ImP+Et3xegQgWgPTm9XoAT/uRI
 sJj2mut22PV/k9i1wtexfeIUfRAvYsBmUNRI/8vrFXU/rrOyqDl85kUwWsuJf9OC0fmjT5zGE4A
 DXUK/44U=
X-Gm-Gg: AeBDietj5jpL5+xZY6IAaZPvenRyA+gGJJPafFimRSj79V/PCZjNX2KXK0U0sulcJY2
 w9Ujxvm7eXyJ/0R9tL1JOnWeNKd90AXVrhix7sGd4BWCRvQorEp1pGv3lBrmOV+1hR/TmffMG1g
 PU2tCqaTeCAxD9s9lB9uQa5Rnk11IQoGoyYJVp+cssNXHOy7cvJsY9MyRVq8gMV8kcDz2o3s6Im
 Im4yXhBHky5rZrME9SG8ZzyFQI3fVkk6I5tnFCr/pLvcHNL5XmqloVOF86+XCqy18IB7oHW5A7n
 cb+sfWRRF3KFgs9s6JFHhaj0r3F2eJseEMRIi1QN8bt9wpRP26v001BLdNVRrg1Zos+hy4evDDx
 EGbW5qVT2tBiM+MBXynX/d6Xf1MV5cHp80nLdCeva3S3VqQ0SHQu4Olmx701j7yqwW5yfwN19Ku
 zwuT87AfqDvJIKohc8EykrxUXlJ8xW2ddhJnQxHeD2
X-Received: by 2002:a17:903:3c67:b0:2ae:8272:deb0 with SMTP id
 d9443c01a7336-2b5f9ebd04amr411907525ad.15.1777210832478; 
 Sun, 26 Apr 2026 06:40:32 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 09/84] fpu: Reverse the order of softfloat-parts* inclusions
Date: Sun, 26 Apr 2026 23:38:46 +1000
Message-ID: <20260426134002.865628-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Define the widest addition primitives first, so that
they're already defined before being used by the
narrower muladd primitive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e5d8b9573a..aa96ac530d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1638,14 +1638,11 @@ static const uint16_t rsqrt_tab[128] = {
 #define FloatPartsN    glue(FloatParts,N)
 #define FloatPartsW    glue(FloatParts,W)
 
-#define N 64
-#define W 128
+#define N 256
 
 #include "softfloat-parts-addsub.c.inc"
-#include "softfloat-parts.c.inc"
 
 #undef  N
-#undef  W
 #define N 128
 #define W 256
 
@@ -1654,9 +1651,11 @@ static const uint16_t rsqrt_tab[128] = {
 
 #undef  N
 #undef  W
-#define N            256
+#define N 64
+#define W 128
 
 #include "softfloat-parts-addsub.c.inc"
+#include "softfloat-parts.c.inc"
 
 #undef  N
 #undef  W
-- 
2.43.0


