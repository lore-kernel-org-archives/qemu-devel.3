Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCD8CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OM-0000Iu-RE; Thu, 07 May 2026 19:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OM-0000Hy-1k
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:30 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OK-00012p-7x
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:29 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso1234709a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197467; x=1778802267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuUYRHuovVEbvZDKoFulOJ76CJMsJZBODEhgWcUkabI=;
 b=mjWds637ItQlf7zO80VqSuJ3LVaXQbRlpWFc3+UfaCwMIXRU/NB+b7BKJdOL4lU9gH
 KgzN5Zfn9tuFROoFrshqcwjxvxhJSs/E+pMeeeiQRPqERDq7UhzlXKv20e1EE42e+uQ1
 MnBJM4tfrWpf+qud4qp7bmG9dfeOK49PMjxdoEM3Kyg13YzxKNGdMxDNrCzTI0IgHAlP
 Lc/+DSuGVH6tqAbUjCcGUg3TKYX5LIDFUlakjGEgg4etVlNYtcBuBXm8DJX03nm///N+
 kCcssvdKUrDw1UrMrXOo6RCtQ9BrgE+Jz9bKSG7/KQOrft3r/D6jLh1cS0Fu3SVBS7/d
 DmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197467; x=1778802267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RuUYRHuovVEbvZDKoFulOJ76CJMsJZBODEhgWcUkabI=;
 b=SqgiOmL5Pcxh720OO788DV632TVWG1KsFZ+Ch9q2Qfkl9w0qtoTNedH5nITrEzvIRK
 jp/zXRUp5zG3JRYB63bq5GUOAUSlJ/czrzYXdNjRs9dZiPQDyOpDDhTpK/1P+7zmQo/E
 RcEgX7vIFmCgzYU3ModGyowZ8pi0IvezVAUAszwtBIgLUjLkfaTogV77oICPgLMOenDv
 UT2UwnYwLcBf/OW6yTrqpX31xXQGxApGeyes7H8pX16sM7txFKkiNsQ/2h9os1bLX/UA
 GhTsa+ZSO21d43Ae1FQdint4QS+N3yQ5yEXHe7nvgB1KQfJLOvJ35l6LbJlPK7pTVJof
 2o8A==
X-Gm-Message-State: AOJu0YwAol3qrcQCrXZwCzXdtg/XI0lKPHh62DBZl1/kAc1guQSYZp5U
 TNCkSHYB5xOtqmaJ+lfKLd/pj3J/HQv2X7N6sy0az367blTS96VoMQSqwUPpCVjjlf/VRBwNZgp
 SY+7w
X-Gm-Gg: AeBDieuAewQWjBSFxHG+iYVW+U5+V1IF2JBRSXEflgzdGcSyIUZMDNiyr4/16UcGeyw
 TpKayB+rJ+c60vwWZpSR5M8I49esw0FGX9xnSBmWAl9q1gqkGkX9FelW5DTVvVMIlky2idwR3Az
 AeuYBQasEMzdOkOYSar06Rsg8onY6wKDRNhXlMbFrXw44nn+vb/J1WsXJHMacTjxh2Ozik1AHjc
 RC7dDtYXwsnv7dwX8kdgSoLorJCsehubj4+6TUXvVTiHNwGandU7mqrnXBywruARaUrbZCH4G14
 /vBoM/dNrGhZkIKH46fH2sHUGiPpfOeTKAp+Il2zsr2MId0OjmoAfbA54s5H/f8v+FdasArHtL6
 IbCwCqxFN3Jz7uFBJZiB0SNWfkDMmMXtItpTA9OqzM+ohKzV0HXMs2RpY6K9H0PnqNSe4rI35MT
 ZzGKJFZvsh7Hc3BNkE62tTpGubWP4t89UGFdb6Fr3nQdaEQTbk9iDXCfiJ
X-Received: by 2002:a05:6830:6206:b0:7dc:e2ae:c15c with SMTP id
 46e09a7af769-7e1fd26cdd9mr3378473a34.16.1778197467013; 
 Thu, 07 May 2026 16:44:27 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 13/60] target/arm: Trap direct acceses to FPMR
Date: Thu,  7 May 2026 18:43:26 -0500
Message-ID: <20260507234413.643512-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
 target/arm/tcg/translate-a64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b013dd51cb..d2a4b0fadc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2899,6 +2899,10 @@ static void handle_sys(DisasContext *s, bool isread,
     }
 
     if (!skip_fp_access_checks) {
+        if ((ri->type & ARM_CP_FPMR) && s->fpmr_el != 0) {
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, s->fpmr_el);
+            return;
+        }
         if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
             return;
         } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-- 
2.43.0


