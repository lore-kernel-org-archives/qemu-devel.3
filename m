Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43697C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMj2-0001QS-R7; Tue, 03 Jun 2025 04:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMj0-0001NC-JK
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMiy-0005jY-VQ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:22 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4fea34e07so1593032f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938219; x=1749543019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0SwvWowjG300ItHhNzuHDz0e7MhZ1a2+OzLfYrOBWk=;
 b=jejwyEQRAzB7SXOsVwv2BAh0SVAcrOSNEhGFEKx0PZqG5VAncHtClV7UtzmOGzsyi8
 PvoZaoVtmFWSVYFbLmkY7uw/0DgWqZe4sLployTfHSECktyvfWeNexwqcKi2PobLmT5S
 mGjbKIRYH/kc+kIthjb3wlNRQxsbtNIj/+IIUOkNB6Z+0kJ16WGokkgYeeBLgTFELI4u
 BSDHMui+XH+tVjnhJa5i0ArOlfHX5a9KijhX4vkg+If9Ol6AgwN6z7vew5yEtnZ8GWEz
 H0GSHbZ0n1XJS7OOePeQoLklqzz3dV17H/V5xFlTOtsDz310whyoxt478hXMAUQdqQhc
 adiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938219; x=1749543019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0SwvWowjG300ItHhNzuHDz0e7MhZ1a2+OzLfYrOBWk=;
 b=fkM5kgnE63BLQxhk6vEBIa3axCk1ot+Z1zjd0XSn+MRD1JuAu5bd9/+qhXbnUX2XDr
 Frt1cI7bKw1GOod1vrhZuTa1EJEoGQpKNlC+C2n8p5CZlTXb9JkKalaQMVX+y4XK3ImU
 3D2bAkdPUlw9QF7V7GTeAYk6EfgYQBlBAxjQO1ZMbOW+6rIQHELDqDmIqx0xQKPjhSUD
 DvVYj5a0+cloMVOcjPBCLWwHZY57+h+O5T4aauIgOa0iumL4igf1iMirK0ZdzDz654D6
 WUlM+NkJ3aGsptqmANjNJDDS5Zamt8X5AlONrdG5e6cHuW/ZsuxcWh0VXDaEFBp9bHwi
 q6yA==
X-Gm-Message-State: AOJu0YzpEVBRPPNccWmsAtKYozxELIJ7o1A86SWv9pmei5TB1F3XJ6SW
 bT3x2Vkd7bBCheZl6BzTZVDeyiIAoEH+WltBO/5oYE9VofhSrzLZvXU9pBSpccMlPebcMyiuPg5
 CqlMBbvc=
X-Gm-Gg: ASbGncttdgcYIkODK2dXeygiRR8VN35tqD5tC7e9rLTH28bx/2MifI8siizoXDDYMO7
 H2irfrXMTqYLDRSRC6/G/2slX4j9sfX4bmPyqESws1GqG8Cp+Nm1RcwDa4q7J+Ji5jtz7xJGrkg
 LBVBQnhIgn+R5gfAz95xmFezM/E1yVoAp7RLEkaDWqbXS4pvoXKN9Si/P3eNAhefB4cR/5JAvN4
 psyX7yG7Ty7XPsRHctiFfSTD49LLV+fxpQc/5sDKilU5QNTfRUFL49pljA4mLtikZgWWnbHiLof
 p2oI7ovBVIr7uBUL8ZPZBw2YvxgkQ7oO4GRW6BuqJdm+sF6XHNl3YbG9Cwf8Q7qO3qOCwBPPiRI
 wJHoPu2DUEaLFgwmXvPw1zCs=
X-Google-Smtp-Source: AGHT+IHehgoc9H1MKGs9ONGS19TIOBJxNMbxbu0GtI755J853T/Z/G2UmaiRoqAPnfi1fQi0MFEaew==
X-Received: by 2002:a5d:64ed:0:b0:3a4:e672:deef with SMTP id
 ffacd0b85a97d-3a4f7a6cd16mr11708636f8f.36.1748938219459; 
 Tue, 03 Jun 2025 01:10:19 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 09/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_not
Date: Tue,  3 Jun 2025 09:08:50 +0100
Message-ID: <20250603080908.559594-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 29d1f29124..d22396f6d7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2251,10 +2251,14 @@ static bool fold_nor(OptContext *ctx, TCGOp *op)
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
 {
+    TempOptInfo *t1;
+
     if (fold_const1(ctx, op)) {
         return true;
     }
-    return fold_masks_s(ctx, op, arg_info(op->args[1])->s_mask);
+
+    t1 = arg_info(op->args[1]);
+    return fold_masks_zos(ctx, op, ~t1->o_mask, ~t1->z_mask, t1->s_mask);
 }
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
-- 
2.43.0


