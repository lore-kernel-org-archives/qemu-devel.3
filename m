Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72ABC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77Jd-0002k8-AI; Thu, 17 Sep 2026 04:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J9-0002eK-UU
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:28 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J6-0001tN-Ks
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:27 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0c89e33so320053a34.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633043; x=1790237843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R/WaNXo10pQsY0HI4MsRovqE0lyO7EdJZGoj+XHRetI=;
 b=TuN4gsgDPIG35OqplXGcz7UX0HaucY34oSKkzvp41w/6aUYSbqzDGSdGgZMTEDxAq1
 Ua66yrXB/jHJc8a3q3wF2OgLhkhUZndeMUx/1oyrx7uOFoX9noiSMmmwPH0sVD/Q9iaf
 30ugK/FKlKFqhWnC5shNoF7AicU59ou6tPxBzfYj43JIYxJ1kYOktBMEPL5ueBi5U7zo
 rZ2JT9Ri2t+7q1K3Q2Yn69uVm0VWBmCQhlYuI8G1PF76kh9phLWZfmybG2vJE+SXZPNy
 Vlf4uHHrltnesd6idlj+gxF5rERuT23q/Nw/B/2traCfKqg4ulp6Zsn1W3pOt3GG2QJT
 oiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633043; x=1790237843;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R/WaNXo10pQsY0HI4MsRovqE0lyO7EdJZGoj+XHRetI=;
 b=KKVp3JEnDn0Z8ojqLabMBVdOmqJPMlFGoYK45UsMoLE3IHe8HYRdWaInM1sT7JdsqM
 5IMA3iJbHRPBeAxWm9clkUkYfVlEoYpF2YVXXVyrqRlJlQ+XgRcRPSFqm7XYrIMjsZnT
 iPJczQKJPNP93iPrICOVtjGCq6JIh7i3d1XrtXVEKID2uW8tRTux8NJ9/LuT0iKcj0l7
 WyR+pANRXMNn+HscZkVIXsANkOozSX496s33lfGGpI3Fwq3eoSgRMrQI04cOSmmNlSRg
 wQgH0jHnhUw9vsleltnm9YR/lwNkTUd4FR2pIuB0jir5vUshiRj9CvbykjuprnZpc6F3
 fo8w==
X-Gm-Message-State: AFuF++lhmXLPpHNfFVYyToskDZtc0qbfhHVf0QQUhpc53CPLfGcXgJf5
 T93LdbhOGTOAc7DR8KlruNYDYXhLiVme+kVNvT5HwQQC7cvzCRFXUpq0QNBKGU53IilRbkb3leK
 eQ6wwnac=
X-Gm-Gg: AYBFou3+aBwW/JpTMLewSYSFjTGRk6qnQyzyPQTiAFDZBpYEZZoLOnP+L23BfUtqvwT
 1zznpPfq96azOj65WMuCDBOGS9Lr7s3t+25JZHXMG6R3tlL4KF0t14r+1KLWuDUTxDzDGYvOWqF
 tIJeiHU7+UbHEqaAqrxh9V4NT4JzxIULWiAER43oCwAB+mQQL4f82IzDOf/Np0zlq2nQCwNskkD
 ayS24QrvA6iGFLn/Qpba2X6dph0qg2OeZOYfDplHQXCcsbSwfksvKK74J0XPinl0OS0vdHl9gWK
 YgM418RVdKTbloAx0CghdKu7wNKC04YURwfs5WESR+lPcR2HxQZ3CUt3Oe1hxK0OR6r7tU6hGtB
 8s+PXF3pX7j7k/qicyU5Nc+tge7ikuc28oPy0+4tyjfAGhBZwLG1byHHrtSrSIYf3YNbymOWfOi
 HRc3T5BS1DAMkPhCXa6s3sLc2twmprw7UPsRGSEf/6a3nWRWL/kDfJ4NpFzwfeQsuQ7DVm7lK4h
 IzZhmk=
X-Received: by 2002:a05:6808:10d6:b0:4c4:36a8:9599 with SMTP id
 5614622812f47-4ca49bd4b7dmr7027325b6e.8.1789633043300; 
 Thu, 17 Sep 2026 01:17:23 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 04/16] target/alpha: Use tcg_gen_lea_i64 for S{4, 8}ADD{L,
 Q}
Date: Wed, 16 Sep 2026 22:17:04 -1000
Message-ID: <20260917081716.946668-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x10.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index c66e3f9c146..6f18b8d1af6 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1474,10 +1474,8 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x02:
             /* S4ADDL */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 2);
-            tcg_gen_add_i64(tmp, tmp, vb);
-            tcg_gen_ext32s_i64(vc, tmp);
+            tcg_gen_lea_i64(vc, vb, va, 2, 0);
+            tcg_gen_ext32s_i64(vc, vc);
             break;
         case 0x09:
             /* SUBL */
@@ -1502,10 +1500,8 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x12:
             /* S8ADDL */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 3);
-            tcg_gen_add_i64(tmp, tmp, vb);
-            tcg_gen_ext32s_i64(vc, tmp);
+            tcg_gen_lea_i64(vc, vb, va, 3, 0);
+            tcg_gen_ext32s_i64(vc, vc);
             break;
         case 0x1B:
             /* S8SUBL */
@@ -1524,9 +1520,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x22:
             /* S4ADDQ */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 2);
-            tcg_gen_add_i64(vc, tmp, vb);
+            tcg_gen_lea_i64(vc, vb, va, 2, 0);
             break;
         case 0x29:
             /* SUBQ */
@@ -1544,9 +1538,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x32:
             /* S8ADDQ */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 3);
-            tcg_gen_add_i64(vc, tmp, vb);
+            tcg_gen_lea_i64(vc, vb, va, 3, 0);
             break;
         case 0x3B:
             /* S8SUBQ */
-- 
2.53.0


