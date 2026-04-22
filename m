Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E59DF9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXE6-0001Kx-Ny; Wed, 22 Apr 2026 09:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDz-0001A4-3y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDx-00019n-II
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so69656705e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862956; x=1777467756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1esNeOF5ufpO0cAxHdsE5rjzSjC5Q+4Ajm02teJ1954=;
 b=qcP5sWV/+P3orJmIQh/4Tp7bsRiuMlRuXSX7xgtks0572Deid/z+fGF2GkRSVc5Rgo
 oWrl5fTq0r9bAxFAw5UwwIjNVjvWfOCn0xaaR8xBVJg1kgbr4sYefl+OBbRL9PBjqnTb
 B6OJChE5d8f+ce6AF89M6HWKOSlc7sX2ZZsI+oZNCD/CMDrQu1aT3k/P9CgC2SaqHW2d
 kM9NNejeMHDk2fxpZcr+x3bfdPtdK2T/lMIVn+ZqCkQEoNovTpnIy++qnBWgbOquGpmV
 9/J88qdYX7Van07ey3td7e+tdOEpXRMUHljtStFOVlrZYmKIm/UELyjhRF4ISy2ONC5X
 CySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862956; x=1777467756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1esNeOF5ufpO0cAxHdsE5rjzSjC5Q+4Ajm02teJ1954=;
 b=lW4P8jciT9H16cKb3xixKYH7U5No2nFoX710qlFgyRqVmdWckSuOuYb/IzhR7OgTg6
 y6exK70U/Rs08Tk3npxsBZWnWPoHDmVp77lCPvsun2GoI9bCFL5Din8ZeC53Y/JZszcl
 7OnJt8SONCZeRcEKI9uttNnyxJsDe51wPfrxYbEE/xgP3qxcMh1S9qUDLypENsea/T8/
 DMYfghBFetIF10wPijPGp58Ls8xFSfcbigmQPgWTk70rgliCPydnxT+zs94mAYYIMdTD
 K0+oBxMAWwxEjnIgrcGeDw8GTxj9Qwgt+aicIz1qkJ0ctS3vqMomUupSCZdhxghT1nnZ
 exkQ==
X-Gm-Message-State: AOJu0YzfGt/EPVRXsAChf4+obfCQ/Ko5PFLFMpKxp5sZfg5X6PNUpNIi
 rc3F5nxz6GHanfh3VBdvC6mJ8R9O6SFFZs5wzm+ROIhveGBArTZ0eQDuErEqcS/OcGM=
X-Gm-Gg: AeBDiesVpmqwAw/1P5n3kzlA9EP2X7T4QG4VEz/XEkUgylRpQT5IAA7gK+O+jFgyc4E
 0IzzEwmWmXHMuB9hqLpk1c6hQq/PM+GV7WZmAus3QqeUivqmsCBL7FQB/nBAjqgWEJYoO+vEOh7
 AtLQVQKxmoML2Ha7/ORUOehkQEu+NX0iomKdSheBADS/5LLh3jtFijIrT/od5dItTal6ZgeJhlX
 EbpEokhVoEb0AmMcyEP5nwnQgNyS5Fjv9E9itIBVIDliPZzSbJ53DtMGDSfRjon2RyU+TbWHSu5
 mTzwuE19RLAAJs7nMulwK/13BoIUNNsTDyMiHNxut1m6VFnkOQOK9W/9CpTHN9i028HkfQuYe4h
 hXY8sYu34ZjF5WTen2rM+oAIXxyARJkrjJWlKl0qIqySzwtz2uDNALFONjgsIpZp88pD9dnzjUR
 R9TfzR7qe72lIUOvesDRF9cp3GMZh9WXU5sA==
X-Received: by 2002:a05:600c:a108:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488fb78a0famr276133055e9.26.1776862952883; 
 Wed, 22 Apr 2026 06:02:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10019bsm458543425e9.4.2026.04.22.06.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 64AB0611AD;
 Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 18/32] target/arm: make whpx use syndrome helpers for decode
Date: Wed, 22 Apr 2026 13:52:35 +0100
Message-ID: <20260422125250.1303100-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions. While we are at it assert it really is a
EC_DATAABORT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/whpx/whpx-all.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bbf0f6be961..4cfc7f99698 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -356,15 +356,16 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
     uint64_t syndrome = ctx->Syndrome;
 
-    bool isv = syndrome & ARM_EL_ISV;
-    bool iswrite = (syndrome >> 6) & 1;
-    bool sse = (syndrome >> 21) & 1;
-    uint32_t sas = (syndrome >> 22) & 3;
+    bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+    bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+    bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+    uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
     uint32_t len = 1 << sas;
-    uint32_t srt = (syndrome >> 16) & 0x1f;
-    uint32_t cm = (syndrome >> 8) & 0x1;
+    uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+    uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
     uint64_t val = 0;
 
+    assert(syn_get_ec(syndrome) == EC_DATAABORT);
     assert(!cm);
     assert(isv);
 
-- 
2.47.3


