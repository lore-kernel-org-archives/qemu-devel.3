Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6244D11186
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kob-00075Z-JT; Sun, 03 Nov 2024 19:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koV-00073Z-Gr; Sun, 03 Nov 2024 19:19:23 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koT-0002EF-Mu; Sun, 03 Nov 2024 19:19:22 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-720be27db74so2257357b3a.1; 
 Sun, 03 Nov 2024 16:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679559; x=1731284359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZKVJSe3jvXud7zLkI4v01kv3KA+r8AleeOvAHmR7uQ=;
 b=GYBNb+a/l+NsDHPwSWBGojIlsdAL/MAqweNL8ILWSziOxwX4Pfg0h1VFy/+2lEq7jJ
 TPhBsGDz5aTsSDRJPKRwD6Mu413UF+OY69Twi+bE+x1OesJpHjc3waKXePQpkcLvC0lp
 Cc+g5FY1DiN5byPekwpnMGCe2qOtU1cJpMo5KrtXwFcb1gr3bHAuz85AcmRgVq3KvOEc
 cE/laRQhLMxB4uindkGL39QEOftLybUKRSzhmDszGm6zW1XqFxFhS5bV1n1n4+k9m0Xf
 FL7lkHZHBR/dJYnEtFnL14QQ7FO7Hw0hrp1hPViI9RK/RETn7Uoz5k7/foOtj1ppZnw5
 xOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679559; x=1731284359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZKVJSe3jvXud7zLkI4v01kv3KA+r8AleeOvAHmR7uQ=;
 b=lhOR2jkcbbxmgEqjmXeQKF5A1E3L7r8G7Yx502/5iMOQP/T+D7u1YVoM1ajCoom6Ik
 bEkBa75BfP3efrawmvnb7zbVDau/gCNQmXlpwQWhfQ/HVm5MQuM4JEGpanf2tFVek/Zi
 p/duv0PhlOVmb3k8osiIJtnRUuzbbilJ94a072QSWbt5rbOJ1FaMKbfdglxhcjSOyUUF
 DnRu6hl++WbMs6TpQlqU3WGWPns3Av4Pl++hMt+1hfBsxacXYpudeM01V3tW/+LMaJhC
 fEut2krjBirttQQvsLzM1Z+IaA4sAVcJEkj3nCQ27ZDdmIxzIu73uYsojY46jUuMrXAC
 La6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9gydnn2YdpnA+HkEqVm5stR+b+Vrim8W/Br5vmPXJyd2AO5r2nBOU66OLZqZe6zZ1T3eQKYCniCMEv48=@nongnu.org,
 AJvYcCXWVMoC1h0EAXQe2vsv5+VdjoepOu9ALBBh6+7yNtvlh7IMRFVqcWu+NK0kzVHxlYbhkBguJOdTtw==@nongnu.org
X-Gm-Message-State: AOJu0Yws/p2Fc0PAjrAnpze6g5eMH1+8096BXSX7Fgb6BAzDbnTuLVFn
 fu2+fIKVMjW954uI0rYfcTmfxiio5K2U1C9aL1cW7EwQHuGh3NCrQg5qsw==
X-Google-Smtp-Source: AGHT+IEQ+PEWCEXyrIa9y1S2r8KUkAPNi6SymkbfKzOKlmQU1IJk69KuKdX6augBqlh/ugNL57+V+g==
X-Received: by 2002:a05:6a20:e20:b0:1d8:f97e:b402 with SMTP id
 adf61e73a8af0-1db94fc412amr18813899637.13.1730679559533; 
 Sun, 03 Nov 2024 16:19:19 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:19 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/67] target/ppc: Make divd[u] handler method decodetree
 compatible
Date: Mon,  4 Nov 2024 10:17:51 +1000
Message-ID: <20241104001900.682660-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

This is like commit 86e6202a57b1 ("target/ppc: Make divw[u] handler
method decodetree compatible."), but for gen_op_arith_divd().

Cc: qemu-stable@nongnu.org
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index be93777cf6..47ca50a064 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1820,7 +1820,7 @@ static inline void gen_op_arith_divd(DisasContext *ctx, TCGv ret,
         tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
     }
 
-    if (unlikely(Rc(ctx->opcode) != 0)) {
+    if (unlikely(compute_rc0)) {
         gen_set_Rc0(ctx, ret);
     }
 }
-- 
2.45.2


