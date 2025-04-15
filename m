Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1DBC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mJ9-0006tL-0l; Tue, 15 Apr 2025 15:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mDF-0004ED-M0
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:54 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mCO-0000GJ-DX
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:53 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c56a3def84so513682185a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746239; x=1745351039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZXXB5wevT7oKXRhgPjTjZda3nE8gH1g/3tqsd3logyA=;
 b=d9UjDuj6MOnyYUVjLgGHtjiOZDAf60FHzsmKhHPLBuqpLIk93Aw+G+9ikqEsfuXWNc
 2cYYVCfO859WZXnXSVk0lxy9Ka3hW+c/+G2Og7CcCNzZ4yEJlsw0YNYbUFgVKNgkMnmH
 hh0eZPLgpHEtcrJNozkouXezmfz1OHN0uSWOBGGuN994TvgeMHxU58x9IwJAJgKs1Owc
 XoiqOxe4zy7L2qU6xQs2hP+3my6Ag6ZgwwArIeikBSUfVoGxPWVs5nZGHkq/obdsSWZc
 A+ZOh/UtgXOJXrdqyUfGapGVe5DIQrycLrWgBYrzy1q3fmHWDX+vR/+4rLOgf11F1+9O
 cibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746239; x=1745351039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXXB5wevT7oKXRhgPjTjZda3nE8gH1g/3tqsd3logyA=;
 b=MYrUOZsXLQrj4BiJu96CgfECPOnfMHmh4K6yTPBTjsoXIysVJes1tAYXH2YH7rtK8V
 esCpvIwAdVelPEAV0Pqdve1H2LITuDCZ25sQId2s8EXDBLDu5gr/wdCZ0DLcmI0zBrfw
 uMxierasFZTPvghURAzWSFluB2vu64d4Af3E6/uxO6d83zalxX5yKAv1+DCGZA6J4SoC
 PvXVM3Jf1fWdVGFBnrTG+zIKUnQRoUdZRdf4DBMS679MJgwIhns4cQkELYFcgsBAK4ZN
 SkDRWUkVbfcJOFr4RZeo1ODHFUvspV0GDXdcPWDIcFqpaqGpSMNmka9oAtzCCf+KBctw
 0tmA==
X-Gm-Message-State: AOJu0YzjjYrw1Go8Z2MQYAGLrB5VVFdUoxds7d94Uc1I3mbCz1OF4ul6
 m/GePFMFa01AczFsEDdoUqrjLCUTjz0M4V2EDnV7hceOoHe03Vr6xAdfuJ509O6K6Q1/4nKVA/S
 d
X-Gm-Gg: ASbGncsh29BkM/tjpk13NnoQZC9GG1A3L+ByXsx0+ulYzqZq76Cu5/wfB3Gp2A6Z5OL
 6mcXAAqcg2iklW9e3AMyufmMhWtBpJdOxROd4xDamEARGBT+sOgOm1COGqKuPzVh0ygsqptptQt
 2vXk7V9Xo6dUnA4WQsD9s2QDgdaVtlUJ8g8myteOrsa5rK13CvwuEAgNlXOyLpDHEsliv295KhA
 T+iwTbNTiiEhlT30rBM0+rMQvRitfpNA5PR6/aUWgIy5+LJ13Kg7tycCB0rTcAaV67agZbc0XUe
 uF31RViwiY/2cHIDgqjgHLyGr+ruEvjVH2oaThAzvGpu0oT74cPkdUph6H/1Ohd1CpEQEsZbOrA
 =
X-Google-Smtp-Source: AGHT+IHV9ZtAAKzLBSSkD0x758kbGXL3WcrCATkwEdWt3gpGtGbJRqmfXem4JAlmV68ItEyaKLhmDg==
X-Received: by 2002:a05:6a20:d70f:b0:1f5:9cb2:28a2 with SMTP id
 adf61e73a8af0-203adfd9518mr318715637.19.1744745764839; 
 Tue, 15 Apr 2025 12:36:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 129/163] target/s390x: Use tcg_gen_addcio_i64 for op_addc64
Date: Tue, 15 Apr 2025 12:24:40 -0700
Message-ID: <20250415192515.232910-130-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
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
 target/s390x/tcg/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 00073c5560..a714f9c0c2 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1250,11 +1250,7 @@ static DisasJumpType op_addc32(DisasContext *s, DisasOps *o)
 static DisasJumpType op_addc64(DisasContext *s, DisasOps *o)
 {
     compute_carry(s);
-
-    TCGv_i64 zero = tcg_constant_i64(0);
-    tcg_gen_add2_i64(o->out, cc_src, o->in1, zero, cc_src, zero);
-    tcg_gen_add2_i64(o->out, cc_src, o->out, cc_src, o->in2, zero);
-
+    tcg_gen_addcio_i64(o->out, cc_src, o->in1, o->in2, cc_src);
     return DISAS_NEXT;
 }
 
-- 
2.43.0


