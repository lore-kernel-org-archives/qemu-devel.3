Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF545CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZ9-0001Uq-Mw; Wed, 20 May 2026 13:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ8-0001T9-3r
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:42 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ2-0001yK-Lv
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:41 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3664df30f53so3060440a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297515; x=1779902315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QD0lZ4gXN1fWzU8DAYp+qX7d5AOu5jrmEh8yc45jBSU=;
 b=SESmsV7CddNMEWl22IglVFrBXLnzb717Bu3UuFGctfbpYsCZ0oTVHAXMlNH6Pqew4P
 Uir075+3rxZO8ds4JYwDfjNxUepIphO5WDaznsPr3tXN5zkFk1XC7gA+MPQOHex3eYIC
 Vgi9K6oYo6g+vv4e11TVDzkrg8IECzO1YG2Kzl4iju8p1QL0ZPde6vIeyixIfdhz4T6H
 Cs501BCp8ad+9BDk4K+zsJ375zJFm10xzbguZt/T+suCh26DjS0X+oEi0n66whKv3fbn
 FMO02EmaDRarbE28WM9kf3Hxa9KOy4NuETQl3/AehYNS2/OohEDGExDoKvodTtBZBsKA
 zEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297515; x=1779902315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QD0lZ4gXN1fWzU8DAYp+qX7d5AOu5jrmEh8yc45jBSU=;
 b=U+MQU2V9VrPlrk8/QSLL7xvnQOusUXisobpJIEx6XFspn/uupi4I5QR/Jof979IIdn
 qUwW9SD2QWqXAVNRtXKvUN2hrsgL2YNjhJgI1Xa2lZwiEbJGdQgFeNHKD/JawZBuS1+O
 1InGi/H8MA9WsPtDDjjXG+MsV2TdBHscJg/wVJKq/28+LI3UuZ5fbB/aSQAuSBM79mmQ
 FMH93bxbVmYMHkUITty3kW8fVQK89m5insfFSCVB0PWFAPrRs7PwRv3V8IB9xqa3+QFa
 RsU5h98LFDjE5ECyNdsJn06Ma0ShgJKXnzz3yHqbiO56CAfvhby162Fhx8OYlIJ2S1Kj
 ZGCQ==
X-Gm-Message-State: AOJu0YzUoJr38tIS5tMI8bVkykiEs1ATTuIgm0dN3jKfH1RoksQ3VF7t
 k3wvOEScQmok39e3SMKxWkydRoGml6hPbRJ3R73TaL4sg/hhPQ3Mn0RHb0d6xgn9lD/xZ6+S64L
 13+Fpdkw=
X-Gm-Gg: Acq92OHyk9K+16Uc9GdlIGK3olYb7OV/NUfZn1e/T/0CPvemIPmvLLjh+XZEC9HkeaL
 6v/MPcQd+Hj7D0fPyXrD/bl+hCDmPF2uXoaFqzpjCUk3YebwgCyJc2lCQgmLRmo7U1H2sWMioIP
 EOjkLVQoziWGtj8+DjIFgsSZeSf27C/18GfjOYIcraJbHNDJ2Ola5C53ywKEcX1beNvMI56oY9P
 K9QT0ZCXIPMxEWIRGsgpsqJNcM9SEWMVcjjlJOJRmFbE5zZydCrzJhQXkUCNMIO1CFMA9KXSSMw
 W8Ira2PV40imjr7sxQOL1kC9xmX92KmaDBrydirVDtL/v8drYwceDP/o3RDgs0eGcmAloz4QVpe
 Ra3SM4KE1zIKouXLXAZ83Cu5VBD8Aw8VH/tXeonTlC01aLHqHNZQYYazJQIDLnOnUfRT9/NwAxE
 h2EyOppRNEtX44qJXJoCEDaPngvahn
X-Received: by 2002:a17:90a:d446:b0:35b:8d89:719b with SMTP id
 98e67ed59e1d1-369519af686mr20885994a91.1.1779297515114; 
 Wed, 20 May 2026 10:18:35 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 18/30] fpu: Use get_float_3nan_prop_rule in
 partsN_pick_nan_muladd
Date: Wed, 20 May 2026 10:18:08 -0700
Message-ID: <20260520171820.848839-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index f40a950b41..7781e16122 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -163,7 +163,7 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
         ret = c;
     } else {
         const FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
-        Float3NaNPropRule rule = s->float_3nan_prop_rule;
+        Float3NaNPropRule rule = get_float_3nan_prop_rule(s);
 
         assert(rule != float_3nan_prop_none);
         if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
-- 
2.43.0


