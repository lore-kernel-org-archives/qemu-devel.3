Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B84CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jLo-0007nU-Vb; Fri, 03 Oct 2025 13:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKT-0005AD-Il
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:26 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJt-0007hM-Iu
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:25 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77e6495c999so2680533b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511501; x=1760116301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRMGkSahDRDIyhY1Pf+KcfrLPaCj+CJxCc4+NBDjs/c=;
 b=w4Bf7s+kVU1ySil4o+8VnMWtjMDBg0hJznfSWBV7RE/oKVO27e5wx7R3H1soCKlXEd
 N327prTxmNzILdsgPEfTnD4JFBqXXnT//pYgpdyeINApi28VoimDmG94gqhEsnPGaYjr
 H3U1JqIYX+B3jwuOHJFFNBkHKvoUqwgZOqcuonXZw+xOlWFe3Zc9DCImtUKYoM9B5tOw
 BqWswdaYaA6gqHDXyqvlv6OEZktwEA7N5EkPJvOzaLdpuQwIgVcGTsqwVve0Kx5H/XDY
 JlYREavlOsatYEcHPvk7CBTdqvRJhMY/cFGHuAFu/UZ1rKULSydi4ooUGDsyhR+u3raY
 n4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511501; x=1760116301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRMGkSahDRDIyhY1Pf+KcfrLPaCj+CJxCc4+NBDjs/c=;
 b=U/oA9FMKYfWLN+/6/p/2A5SIq/zuTXLjU4YUdvFa+JcJgFyxVsv8qGR9LGUbgvEWrr
 gZD+E9swo076logD8semRWLlrDLyc5l5X/vbDvt+J3Xu7jj3ZKEjMWd9vMi7Z7m8Xcv8
 4hOHXHaD47msbTJlwCdskocP6WRAhQn6k3DIAxRpiNesilLnXBuPxnOODjFCqV0nPRiT
 gbOn7vbtywQEb6zj79JsLJSofr0T52P8petsuWn0aAXT7pqiVulAuU7dAveUP5x+KT3K
 REfW1PMxoGj2kXLHtYM85/acvWHOObmwSxqr5rWTANPuxWSLLTPl3/aX3/HV4HdTl8yN
 bxGw==
X-Gm-Message-State: AOJu0YyTIcRBDzQjPHvR2ZeJzxpMPMS342CwwMD2WJ6oEhxUU298jqtL
 L4oilwaI6PY5lgXJKz4tjL9ek6E6kAIYqtm/idOaY3TLtKO9RDD69Y11Vk5/gzxlPwteFpJbANR
 jwZlPZvc=
X-Gm-Gg: ASbGncsYuxd54c70BHIHK1fBroULmJ2t8QU3LW7Cj7LYtVHIR6ngqb3z1xXRXaSumWC
 T3smpqloD4xYP/+9AKPZ7LInvLLLR80R78EUaUu0BEmXenIevSA/km56jORGdfrf5+h+72Fhn6Q
 G3HpZY4Pwlygb9gjz8mqejHHBquPoPoyDn3EX1l0f7e87pjwoYSPl5S4vkiv4acSKJdHpbgaHv7
 RW72MvhBhvLoyOAAPuPS9P7saKw7hWVRG6lKeAi8tSBB1oDmGyBpMN2c3kFOFTQyTxT78wfOQnF
 4eyKVQONOMJSk2AmIAHH8+J3HPD4vrGr/Lf/jOy5ngPB679ZkJ2zBBBJMhUhH0UzDrdMvJ1RLG6
 DxO7X9IZOLDOfFSVxyEV1QIKhiXwfUUy0M4VNfXzybTfuGPRtQM2q/MBw
X-Google-Smtp-Source: AGHT+IE+ORacW94X0aDo3rigKhssHyQl87AG8kFSn5v2Rz8W3E5apxpCl7w8lKGPkWph+09ZO1s1EA==
X-Received: by 2002:a05:6a20:7f8b:b0:2ac:7567:c069 with SMTP id
 adf61e73a8af0-32b61e583d9mr5763638637.17.1759511501263; 
 Fri, 03 Oct 2025 10:11:41 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 44/73] target/arm: Emit HSTR trap exception out of line
Date: Fri,  3 Oct 2025 10:07:31 -0700
Message-ID: <20251003170800.997167-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 78d26aac04..57bc8ea4c5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1774,21 +1774,11 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
 
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


