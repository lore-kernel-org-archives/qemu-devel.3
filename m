Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487A6CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1Ed-0004fw-8q; Thu, 07 May 2026 12:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Eb-0004f2-AV
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:57 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EZ-00072X-9k
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:56 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so527263a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169952; x=1778774752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXdWgo7U6STUK/+uhFBzCSUvNxA/ZTksmfzvSpriqBs=;
 b=tX2G/g+I50xpbLODdL4GAIX7ZVZ9atAZs6iJMIqzGJlnZxEcQejhDwIL720pYGgZQ7
 EN07rzyfomv/yoyqWJ5gRu2d5o5riwjP2wkib34TwNfTr/mzwNOSarV2dQWAvMxDL0zT
 Y2IQp5Pa/JztkFjuWQCyBmIuVBJbrdeAhgoCJzxF8PqVO4Yn9cLdvPmhZCSfaQqUeMFv
 zA/UHjmP1NVgVEvPwZlWbdKasgNkLMnWpW+qDaMJ9oMan4oFWMil9xBRnkzVCa8FiLRK
 T5xioLmD5ywln46IbH3m5aDd1tQw4B0r+sud26aysEGMb1RVXAntkelRlWKwJJI11uka
 nZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169952; x=1778774752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WXdWgo7U6STUK/+uhFBzCSUvNxA/ZTksmfzvSpriqBs=;
 b=FJB/LS3aK8K9MVBfTPYgtsPKrpq168x04rocHNu2hAFivwilQocFtjeIUcze4AlQYX
 iIv9KZzMrm55rVH9NccivQPoTNTk5xZX8dlok8uD3jMomgfn3umgRzmfYbX8mE4DJcSi
 a4Cza30dD4QuzVeZ3qGF3OXAcB/Geiqzs8CWKDb835rkYhFC9Y2F2ZrEVweBtIYpQM9m
 tvBRRC5NCLs3VleJ+3nT5meOt/3LJhu3BvupZEiMVrkf+cR7bTQzfYxWu7ay6WT4T2AE
 K7BF9SfVP2DOItlICyeIu4b5Xd1HGxRKjLVBOYmkUpOn7wkl0IRhcHWxUfKen5y2saYv
 DHDw==
X-Gm-Message-State: AOJu0Yy6RZGT0g4HoZu376ZqrsZBtMEIIeS8d4XO3qq9r1XPo6ANpIFo
 FwDqjL2N8OYgL+/OU9gJSa94IQap7YbRuuvegTXC/JeHRYCGkmfGy020+oc33Etz8aGZyIQOnFo
 C9EUL
X-Gm-Gg: AeBDiesH55ZpbBeSrbDpyeVM5cVrWns1aHJGH4YVdt+jhMBsjDlW0ogSR5igK/Qd6/Q
 P5m5e64rFdX0WAAt80vqMlAjWc55DZOF3dMaryPyvRjwYPQz90t1mmWabJ5Oo9yJRVRPAkczoOA
 R89BadD/3KGPQVUrWXDKvX+9a5bjxLX/0kQij8+EhuVDV+TLQYKTHioZKO0UjKzGszjTM3FvANw
 zeiihkwpABJcOwL5kHiTe3g8p++fqovo4R6ZolAYojb+1K+QhrocZcKgCm5EYm557aDoOvyB514
 QryrBJU17HRAoprCR+u93a0cQ7LCG/7CtnJ2g5nz8+SSltxJSE+FS/AqlPzdBevr03NxPPSpOX3
 /yLlqVL/vb9xXLMFIkKSI5UPZ/DmRbfrL3o7HoOCOrlRNoRwUXc8vtPSQmFiLs2ew8XyWV3Q9TS
 iJnxCOfDEp7nFJAae7y0raiSVWhAVFTtZXcEI9KLxsCaiS1g==
X-Received: by 2002:a05:6830:d10:b0:7dc:c43b:9599 with SMTP id
 46e09a7af769-7e1dee5c2a3mr4633994a34.7.1778169951445; 
 Thu, 07 May 2026 09:05:51 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/29] fpu: Drop QEMU_FLATTEN from muladd routines
Date: Thu,  7 May 2026 11:05:16 -0500
Message-ID: <20260507160518.444797-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

The float16, bfloat16 and float128 paths are not so
important that they require forced optimization.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7234ab27da..90ebd83f69 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1900,9 +1900,8 @@ floatx80_mul(floatx80 a, floatx80 b, float_status *status)
  * Fused multiply-add
  */
 
-float16 QEMU_FLATTEN
-float16_muladd_scalbn(float16 a, float16 b, float16 c,
-                      int scale, int flags, float_status *status)
+float16 float16_muladd_scalbn(float16 a, float16 b, float16 c,
+                              int scale, int flags, float_status *status)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
@@ -2126,8 +2125,8 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     return float64r32_pack_raw(pr);
 }
 
-bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
-                                      int flags, float_status *status)
+bfloat16 bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
+                         int flags, float_status *status)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
@@ -2142,8 +2141,8 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     return pack_raw64(pr, &bfloat16_params);
 }
 
-float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
-                                      int flags, float_status *status)
+float128 float128_muladd(float128 a, float128 b, float128 c,
+                         int flags, float_status *status)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-- 
2.43.0


