Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C72EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQS1-0007vB-PB; Fri, 06 Feb 2026 13:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRy-0007rj-Iw
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:21:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRx-0005AN-5Z
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:21:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48069a48629so22183745e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402058; x=1771006858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udl4u3wK1/as/9f00LKjlolu36IdtPxffb3xiDh4tWc=;
 b=iKOkkyQBZ01BdNRJeyAmh31OV2GG6mFANV9HPFteN29cQGIE332MH8427oL46oX9ab
 PHZBzoUyyzbWrKANorFlTYUsYnOz7kGfSQ62NoAjT6/x1cdXDNEN9MMfL/caYGvUheHF
 b3JJTkOQZQ6oMSZM7JV0VQKaU5ex8RoIN7Nlsdp1dSzpC6wBoHWDELsqJV5QhSpPGlo0
 cuhpl0+2MCowxHtU+GGnzsj9lP2Decebh18lVOM0p9Y0T+M6E4ZW/ZaES12wBnGnhi5z
 ffa9Lzcsg0Q4NxrTKaWAUiNm8Be2qZ2ODw+xlbR8t/T91EfNA3r+7vn8ERn0tFl1IaGm
 zpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402058; x=1771006858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=udl4u3wK1/as/9f00LKjlolu36IdtPxffb3xiDh4tWc=;
 b=KmWnAwH43rdZDgB0x8/19WK7wSeT1e5wYTqY6bvlrqiFY8CAkVM2FVdIAgb9cM7u+D
 TpKBqLHtRt87WCu9z79TQSC149XM29gUpCdrJE/bBHU3Ki6ho1RHZsk8SME2X0+S4bMT
 CU/Ve+v2kyYK+kLPWpxJ/PgrDasGDh8A8/AwUcDx6lREgdE/etYr5nCP2YkHmNy50au7
 uo2Z1j6j1yTwRd55s0G/Qqt0hXBnAR1HdXuK6CUAP38r9xvc698Qr3P1fcb7jBTnWkQA
 Z657bhZR4lSGf5Buwr3li09Mg37NDG3npEeRvRXIMix7Nz19UNTKdcjD0jCb9SEGN7Q7
 bXoQ==
X-Gm-Message-State: AOJu0YwLbTLCWfKaDzhnFc9sYQ5dNqoH3rGzsKGOo661CuFiFMY77k0K
 ax1x5yfilTRFQ75eX4sx4lNqyvrIvHzynLBGXtTDQ4bSwuGAZhjUoKXkZBJ3RxnsTxYCe68DAaF
 FGKub62E=
X-Gm-Gg: AZuq6aJIpgr3fNYyL8F1IeMXU58Ta4U7KStxrbMfrG4yu2PlJQbJGQjQ/RskxEd95rc
 E47kR++baiaU0Vq5C+2AsTPVVkw53+RhAWqOFh5xoe8D4HWu+e4QHCoN3no9/GHPkyylYqWc1Jz
 cxh6Qh6IdgdlP8K4C0ilROXQkx+1Jd2tXm5Xv9iFzNAratiyUg4SUh2T8Q+Ga3KQaXUNbP6IfvZ
 zdBA+YLzmf9izukhawyQPH35yFLS+GuyxifM2nCZDg0rA0ZgDRUusskLpo4Lm8rTYe4cn3LwsuJ
 GIQtjKDZE9l5dYZMZnRr8VI0uUqd4LvMNSwvpUliEfn83EedC2oBWvfcaxffxWD5PP28pVbpMOv
 tK/IqrofsSWor2nmth4A2bhk6V34Pc0oz3WsF0ilCz3wRYDPMUk9RU4vK/fZmNB6Z01aSlrWCad
 ZchqOymcpfsJMqPL4vde77n8dfN+DLcAB6oDrfh9oOqImwM2qWw7hGqUu5mQrU
X-Received: by 2002:a05:600c:8489:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-48320216cb8mr54156125e9.22.1770402057964; 
 Fri, 06 Feb 2026 10:20:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d3e245sm145169305e9.8.2026.02.06.10.20.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:20:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/10] target/s390x: Expand TCGv type as 64-bit target
Date: Fri,  6 Feb 2026 19:19:51 +0100
Message-ID: <20260206181953.18683-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
References: <20260206181953.18683-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The s390x target is a 64-bit one, so TCGv expands to TCGv_i64.
Use the latter which is already used about a hundred times in
this file, and is also more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 540c5a569c0..437f5a4aeb7 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3142,7 +3142,7 @@ static DisasJumpType op_mov2(DisasContext *s, DisasOps *o)
 static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
 {
     int b2 = get_field(s, b2);
-    TCGv ar1 = tcg_temp_new_i64();
+    TCGv_i64 ar1 = tcg_temp_new_i64();
     int r1 = get_field(s, r1);
 
     o->out = o->in2;
@@ -5743,9 +5743,9 @@ static void in2_a2(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_a2 0
 
-static TCGv gen_ri2(DisasContext *s)
+static TCGv_i64 gen_ri2(DisasContext *s)
 {
-    TCGv ri2 = NULL;
+    TCGv_i64 ri2 = NULL;
     bool is_imm;
     int imm;
 
-- 
2.52.0


