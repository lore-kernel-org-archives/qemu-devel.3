Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A83FC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBb-0005kD-2q; Fri, 25 Apr 2025 18:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAt-0003gQ-2K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:40 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAq-0001qn-KT
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:34 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso3837680b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618731; x=1746223531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rT9LqwZ+0UsYny5d9diYjdVrPEXRepL1T9XuOIRkrBk=;
 b=RmoDHoBcdN8/xlgQ3PHEHavGS7vQp71PqiQtSZK5Cvdtf0MJkR2HeG0AAA2xHjyAqM
 5J17VjwbtNo+C8+hsheaaxy3CM3SIgT/WAt4iXYgenFErpbBZQ3e9fy3yn4ucXZ2a1SY
 FFH/pwkIpr0mEIjfmNYedrgp9MDn04UR1BD4xifADBZb4XeoSBd1wtXKMIvQ8xlChfaJ
 QJx/8/B57py2qwgxbm/e3xVcT5c1O6/UJrBoz4uPCbx5bJ+pJrRSuIJF2eTUVNZtQ7/L
 5R92+yk18MJm5fl+pA4v97lAXOSVY12febN3iaLBPkmL8nzkZgwAZ5AZdJuL4/yCSFjt
 VOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618731; x=1746223531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rT9LqwZ+0UsYny5d9diYjdVrPEXRepL1T9XuOIRkrBk=;
 b=dzAUFCcGhnKLc2X75hD/thTFWOsNa4TaHPeZfBaswTVFYO+hE3O6TIfdPqhzXacAZ+
 Fj8ES9ylrc2sWfjc86WgeiWZ6Gs5LGtJEiioMnTVD71itMmRgb6Tx/1OCVUXjObZCN8u
 lzDw/epehl2zozZqiqDVcJWuoyruViyP6oCdE7SkzrLP1wO7yxptjeHQV0TRc9rZ6Jo6
 BZYRzZfHmFKfacmg4fLlzPIDeyoMkK4izX0gUkGfllPwpJ4YyQCYC9kkgVhTWSN2W7tO
 23qkmnRHfH+LACZftGtWAnzvnUFE3I9LySluXPHorYHtPCw9mf52ZVis612G9qhq/qFX
 hnFA==
X-Gm-Message-State: AOJu0YzoIsAp+EXwWn+1u6X9le29LiCMGnz5cxJhv9XNvVMhJD6+It9K
 XEzMnmWIFNNmG5ZQNqnWgWwJoUuJgi29KE3jssQkBTtaLEEx9bt/fYa2Faix6+Dl6w4d7NI2R/B
 a
X-Gm-Gg: ASbGncudTmKxc8xAapXC+oLTYyVYTYqiX1G2lZW0Qy2n9chRSXlLjkQwnquLL5AY+nf
 39oP8zSUlu29fwRTs/s0aIgk65GOnj0kK/fAj7MbWAsMHGnjMsc34R454gLbzj7rv6rw0wPAebj
 y/o+NGlJq51CQ0lZ+3VjkITnEnpdsRLA2H9VEb8dnT3ZuwyNgIQauXv9u4cGHySeXKnDb7kEFi2
 voITyPJskMqu27m0lunhJysSqy3yp+MA3xeuBtBD7V7sbj4Rjbv+QMs3u2J0yQLyh77STJ1bWYD
 KwPtVS9N20zksgr+Easj7d1U8XuA2Id/w7c9Vr10G2V0Pg+WAmzFzFxrNvG+bdkTWlIs/4njFlg
 =
X-Google-Smtp-Source: AGHT+IEddJdyU6Of7uSZmBZxBIvAFvL3/tCmzy0ueaWkzsSit0AfK6E9bfAXRe4ldkCLTfbkmsIybQ==
X-Received: by 2002:a05:6a00:1481:b0:736:42a8:a742 with SMTP id
 d2e1a72fcca58-73ff72e237amr1362498b3a.11.1745618730834; 
 Fri, 25 Apr 2025 15:05:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 129/159] target/microblaze: Use tcg_gen_addcio_i32
Date: Fri, 25 Apr 2025 14:54:23 -0700
Message-ID: <20250425215454.886111-130-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Use this in gen_addc and gen_rsubc, both of which need
add with carry-in and carry-out.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7dcad6cf0d..23f1037236 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -311,11 +311,7 @@ static void gen_add(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 /* Input and output carry. */
 static void gen_addc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
-    TCGv_i32 zero = tcg_constant_i32(0);
-    TCGv_i32 tmp = tcg_temp_new_i32();
-
-    tcg_gen_add2_i32(tmp, cpu_msr_c, ina, zero, cpu_msr_c, zero);
-    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
+    tcg_gen_addcio_i32(out, cpu_msr_c, ina, inb, cpu_msr_c);
 }
 
 /* Input carry, but no output carry. */
@@ -544,12 +540,10 @@ static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 /* Input and output carry. */
 static void gen_rsubc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
-    TCGv_i32 zero = tcg_constant_i32(0);
     TCGv_i32 tmp = tcg_temp_new_i32();
 
     tcg_gen_not_i32(tmp, ina);
-    tcg_gen_add2_i32(tmp, cpu_msr_c, tmp, zero, cpu_msr_c, zero);
-    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
+    tcg_gen_addcio_i32(out, cpu_msr_c, tmp, inb, cpu_msr_c);
 }
 
 /* No input or output carry. */
-- 
2.43.0


