Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D9DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNxh-0004st-4o; Sat, 30 Aug 2025 11:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQv-0007Kd-SR
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:26 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQr-0004uH-P7
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-248d5074ff7so18004355ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532832; x=1757137632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UYaNg4HgCgaMfA5VDdSs+JLi614JTEFfBBOaKuI9nc=;
 b=dPYlFRP1aLD1I1Z8m2MkDNqRPyJ22fL9wv2qSDrH6eTnUIV+il87J1+ATL7GHNyXNE
 JlFrHNs3dyYpa2nQ2yHdhknJJ+pjYVYBLBgzPtbRrNBRwtlI8S11xZX3niCSWqqDOwKy
 sB5plgOKY/1ltM3KONUVmqMjMnlt8Ixpe8BRJ36CNJaR1IPUiuCBWtSx82ZHrYSqpGH/
 piXeXrO73hKUDmu1NMJWX2Z6YFTuv9KaCbqaTaRMI7heFrTwZWB25elsFhCDu+dvbWk5
 PN2e14okzw3T7bkbRUp2VoSjXPJuoTz2mw8cg31yBiHqBmP/w/Ysgx1uljwRMn5XzxhV
 0bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532832; x=1757137632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UYaNg4HgCgaMfA5VDdSs+JLi614JTEFfBBOaKuI9nc=;
 b=wlfRN8lPtzS7I1LaUUUE995vNM8LuL+vq/gIZxfj74IV0kOSt1yGOlmZvDoMgHOcv2
 Q2Hkj6uQE2+SCk7pVYJtEYO+99EPgezKawr6DvrQ3G7vfmFPfK7JUcg2b+7NnNu5OaWy
 ErsdiDhKVGEnXmOuTlX4PtrfQiJgC3TVL1HGdvYpdb6igw5Su12fe1z5II90H9blUG8l
 grZbiVtbfBKO8qGMT3AGPE8RhiqeWznXdRC06Zd4N8dRAlRKH71AmgiIWcnxuP1hZ+uj
 tElH75pybE67jfn/AVgI4kL5RVFZEhNh3M5SlsYohypunFtwEdBqdC68u9Pv+BLDMSGG
 JMMg==
X-Gm-Message-State: AOJu0YwPxTuwNnjR+lH8nIlKEst+fp8+jsXNYpXEOiEBmBnjuIF/zo2L
 48/LS6hOlGZ2antGHRI2L6qFGpHXWFJkddcAeiRabKwUrLbesIznUQEUTRdv6j9S8atV2otjyP0
 DvEatpG4=
X-Gm-Gg: ASbGncvf0CJ0GgR6PZQivVGW7xtxEZJ3OQn1x/ROYKBLOkwnBt4SRiLh1P1kFfL8D5q
 RNwlgqwejB9uf3OuZTV88ELtq/aKVkHypsORJ6xkKt+BuLFfY7ethPWMUrSRDbsUu6O9iQPa+16
 1LxqarD1KVXce/qicExfVKx8bAbs/HsEqUeMng8BE4lXWJv3ORRTclmsJrn7IOpGZVDsKOtJqi/
 udWEQ9bgCg/0RyIOreJlBzgSiUvylKT35pt3eovtxyvBF2xY9MmDfsEh6pgAaohIDkzLPd6hU2I
 W5yjfegy6Lr7g0HjFpI0swkwZCpcsmumFASitGVMiLPGaV4d5xBWuhY/EQCrqHKcQgJlUoJKAP6
 LvVMnjKTKKdKlISpDTU97TXoiQiMJu8wYUbIUnDJJ3u0/25c1idKjmVb7ONygpW0=
X-Google-Smtp-Source: AGHT+IG8UaJCD6as6AwAgl/t2kHyyJoXdU9G1h2192y5CU6bj8OK4MCUp5nf/2CCBIIKOioDOdIzBA==
X-Received: by 2002:a17:903:947:b0:248:96e3:6cf8 with SMTP id
 d9443c01a7336-24944b130f9mr12714935ad.24.1756532831961; 
 Fri, 29 Aug 2025 22:47:11 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 55/84] target/arm: Emit HSTR trap exception out of line
Date: Sat, 30 Aug 2025 15:40:59 +1000
Message-ID: <20250830054128.448363-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Use delay_exception_el to move the exception out of line.
Use TCG_COND_TSTNE instead of separate AND+NE.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c4dd3a747c..f6fdfaa551 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3033,21 +3033,11 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
 
         if (maskbit != 4 && maskbit != 14) {
             /* T4 and T14 are RES0 so never cause traps */
-            TCGv_i32 t;
-            DisasLabel over = gen_disas_label(s);
+            TCGLabel *fail = delay_exception_el(s, EXCP_UDEF, syndrome, 2);
+            TCGv_i32 t =
+                load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
 
-            t = load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
-            tcg_gen_andi_i32(t, t, 1u << maskbit);
-            tcg_gen_brcondi_i32(TCG_COND_EQ, t, 0, over.label);
-
-            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
-            /*
-             * gen_exception_insn() will set is_jmp to DISAS_NORETURN,
-             * but since we're conditionally branching over it, we want
-             * to assume continue-to-next-instruction.
-             */
-            s->base.is_jmp = DISAS_NEXT;
-            set_disas_label(s, over);
+            tcg_gen_brcondi_i32(TCG_COND_TSTNE, t, 1u << maskbit, fail);
         }
     }
 
-- 
2.43.0


