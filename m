Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE8CE7316F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu4A-0006qf-PH; Mon, 02 Feb 2026 08:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu49-0006pl-51
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:09 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu47-0002g4-NC
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so32953385e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039246; x=1770644046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSL0DRobOJUmxitsc5wiwq+Lq6G445z8884Xbak4UEA=;
 b=gylD0trZJ+TTEJf+3FufhzEc0bKedH9c/NSfvlJmxLzF0+nnOFfhGa3r6vWewkzPRE
 VTYPnnMFqsZ9MzNQs2gWa8k3yyL/hrkRXMYf0ainWkxUlYiaCPdIHa7XQIz229q50Tme
 uEt8rBzC8cAJhtvp3mQPT5RxC0Gurm7a1rGsF5ICZ0LgOv7jkedbDBhDMC44A8qpxgAr
 B+rVK1hLc/60/EyXTlDAZKVULLC/X7UZLurj1LA2rGVBmW90jFBxapiFolUY0kwODUXK
 S9EXkTujdpcT/O1dTf8qo7vsxeKpS4uBCk1tOYLES76i04naJnyGCiWT3FisV0iILLEu
 9yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039246; x=1770644046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TSL0DRobOJUmxitsc5wiwq+Lq6G445z8884Xbak4UEA=;
 b=fTRJLoRi0toyJPep2UVFJgNgaiCY016SspRjUBwFe6Rssqfea6nZGls1tXtkk7gItQ
 YNhXqMbIsAP4kiziVss9Mr1yUzXspd2kD4klYZzlTlG9V1Sp7ZYz92zUeENA6ai9CNhq
 Jk43KAvbG4LZZgPXGmbnYBjtgMPzHiw2XAcRDV6DyGjNjnXs/f4sDyEIM0+XLnIVVbj0
 zqw0ruEjUrNqlVH6G7ggjYQdgHla4pxM007MXaQJk50BnklIRxziTdNlWa6kObL8ADos
 N/0HBAuit5S/5Yj6QFsc7B1Z3MfT29mJfxJt8iYlI5ehenWTHZFLVM7vP2cr6Ehohq9x
 JiKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ2L13ADJdFcZSIJEm5FCQ7REWSEoY7So0H7U8ebaOkUumxlWSH3lv8mZJTXyz9LiA7FJXSgZNo+Aq@nongnu.org
X-Gm-Message-State: AOJu0YyIkvUgxnQVnooIP4wVVOxcaH732A1XONSIrwYJPl8ZjcCzLrFo
 +N9qTKMsQrAgXomohoqTnbti+GKfvYLIL7tcxj1sNInmlTBTYL/fyPVTO9UChYB801c=
X-Gm-Gg: AZuq6aLrw5qTQIo76bdK2yW7+KGgURSKqMWHQa/ikAVY/DwGdYc/aPjjvNCMMW9LWud
 9wTffPOeC5wOoJaPA6cImj9UY2n53ZDXCG+VPP/Z/lOKDgKjT+gbsIsrZB91oHz3A7dTsxNwrWj
 NqYcBdIyOdnh79nJdjTRDDSGugk2zWrQBUtE79mFnZD+Q1noF1veVrZWnUKr6oLb6HrDFSN4Xc1
 CMjXMEk2246AInbmvhRku+T0cGIdACUoe3tZ8h3HbR4MT+dA4JvJ0NDu5HrDiOG/ic7tY4YHkZP
 UI4+hEkSBKr0rzoKb2ldYByV/MMI9HHeh3BK6LCP35SLMS0HCse4sk86M8mX834UsdGDOwg6ZgS
 WM6sdpQomyAe5Y6gX4+k1C/t00YnGMM7aMgKXO0xMdfDVMk27zjkBRWgudFvmNIOu0wbIneyto/
 J9O48w5XLfmhTW4whptl2NUSxs0gDJMw==
X-Received: by 2002:a05:600c:19c7:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-482db477009mr174720735e9.12.1770039246305; 
 Mon, 02 Feb 2026 05:34:06 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 09/15] target/arm/tcg: Drop unnecessary aa64_sve check from
 do_trans_pmull()
Date: Mon,  2 Feb 2026 13:33:47 +0000
Message-ID: <20260202133353.2231685-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Part of the logic inside do_trans_pmull() applies the aa64_sve
feature check for the non-128-bit-element versions of these insns
(PMULLB and PMULLT).  This is currently a redundant check because we
only invoke this function via the macro invocation
 TRANS_FEAT(..., aa64_sve2, do_trans_pmull, ...)
and it's actively wrong for an SME-only CPU, because these insns
are also available via SME. Remove the unnecessary logic.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e853b4dd0a..fe59126d2b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6782,8 +6782,6 @@ static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
             return false;
         }
         s->is_nonstreaming = true;
-    } else if (!dc_isar_feature(aa64_sve, s)) {
-        return false;
     }
     return gen_gvec_ool_arg_zzz(s, fns[a->esz], a, sel);
 }
-- 
2.43.0


