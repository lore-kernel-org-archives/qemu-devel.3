Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF464C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR3y-0000f7-Uv; Thu, 18 Jul 2024 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3s-0008TV-JF
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3q-0004WM-Lo
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:44 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eedebccfa4so9043141fa.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308841; x=1721913641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pucdh4Y0p96kGpjxvklaJQ0uqOO6+PMhEJIHOFnGpA0=;
 b=mo5XrrAcjINsyxBJHssI//08vrOr5q7TkFXNhjkjFI5sthn2DWSeZZ0/wWfRf1OcLG
 eIEUFyzGq4yV7GMVvrngex0yUcRCEn80tc/PEhB3VoqUxc5q3SRseDYpDEw+P96ldW7G
 Lt+yP8GhZ/LI/kHjhCg4BUMxUtSAYYhW4325fd6m1BrqgKFj66Obi5Dhiy1L1Ht6whHx
 qgqLg2fF39RDuOPp2yQkPajAayD5P+82YGg9FrYbi69KffnqGdwarO4sdburEjLNdeiM
 z583f/s22Rw61e6ec8/RyY5PbPwDp3NJZr27unzvnhZU0vcYalWX4pndYvchKHy9VZOj
 Ye/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308841; x=1721913641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pucdh4Y0p96kGpjxvklaJQ0uqOO6+PMhEJIHOFnGpA0=;
 b=V45ATMFMyL6ak3B4+mRaxX9oLeW+WdyFE8aIyNuRQvfI/5jqRzN/qb8NRcVrpIsxjL
 e/GzFbvZf65+8LpHlMCljivO98mF0E/RaM5/dZxgnHyQJ2Ay8ILMAirmcfHFo/SRgqiM
 wvpYkF+SjwJLNqkG4sXRIwoBnrh/AImOW3ch7FE3Ess40AXOuYQdpEQ6yl3/gUjURYrc
 YNqS46egaUFw9D9pSwjEqjvK08Af1Ig8EFhbCKh1Ph3uB61923D8NfjYzWCyxw9J3yOn
 z0ywz6C/C2jr3pbtT/aA9JzT6BOYxp0QhOTQyyf1voeVn/FzgDtxldfeSnL0+eX0ZkXA
 UbgQ==
X-Gm-Message-State: AOJu0Yy7gvi6DPUtVjQXGtzWHWwBRtQQ1Q814FvEUeELVl5ymyy9v1jF
 0jvBaroInvgqJeIU3goRsJ8OCkdF99yKKPpJAkbz2NB6mg/2LoL3Xw9j1oeISp1ulFvRtKaKo4j
 A
X-Google-Smtp-Source: AGHT+IHKNb3GwlhBTr3uGh2zxy+vvLoztyJdzu74gXiGr3Iap6CbqJaIJYj7ulVtOhlkiTk/Hs9MYA==
X-Received: by 2002:a2e:8813:0:b0:2ee:8aed:ddba with SMTP id
 38308e7fff4ca-2ef05c552bbmr21127021fa.4.1721308840866; 
 Thu, 18 Jul 2024 06:20:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/26] target/arm: Use float_status copy in sme_fmopa_s
Date: Thu, 18 Jul 2024 14:20:24 +0100
Message-Id: <20240718132028.697927-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

From: Daniyal Khan <danikhan632@gmail.com>

We made a copy above because the fp exception flags
are not propagated back to the FPST register, but
then failed to use the copy.

Cc: qemu-stable@nongnu.org
Fixes: 558e956c719 ("target/arm: Implement FMOPA, FMOPS (non-widening)")
Signed-off-by: Daniyal Khan <danikhan632@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240717060149.204788-2-richard.henderson@linaro.org
[rth: Split from a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index e2e05750399..5a6dd76489f 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -916,7 +916,7 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
                         if (pb & 1) {
                             uint32_t *a = vza_row + H1_4(col);
                             uint32_t *m = vzm + H1_4(col);
-                            *a = float32_muladd(n, *m, *a, 0, vst);
+                            *a = float32_muladd(n, *m, *a, 0, &fpst);
                         }
                         col += 4;
                         pb >>= 4;
-- 
2.34.1


