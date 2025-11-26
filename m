Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1A4D10384
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAIZ-0000fx-JQ; Wed, 26 Nov 2025 02:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAI5-00007p-QJ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:50:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAI2-0003Nf-K5
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:50:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so37641225e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 23:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764143412; x=1764748212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtKth+b9TdPq30wZ/hp2A5R8f47SbZbi440xtKAdXk8=;
 b=qYVlRNYGYA5cNJqhkN+2bLxqpeXfz1XmZijuqPswk5ntnnmCgI848pUGHVJJUDIdTb
 glKzOkckztnN5YUSQSWf+b71D6RNPSZ5PdqCi0ArMBwtc2SmBPbPVQAgYfuVOolLTziC
 nVbA1rO6P0I+nzJmZYCBhlLWR9hdQ36ymgUsG/tiOepoCyhYLsBdLmbR4enzgz7hqtMp
 rvcIKimA2paQeaZMa8VdlfN6zsrkZ7M6/3DzdPWy9blxq7y2W+eQRP2SlxuTnc6Txjol
 9hQdR6kC/tDEoTQGECncvZXtGf7DIpWs/0qjPjiTtxapF6dgobd3PcrWQV2F1PF58WV1
 bThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143412; x=1764748212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FtKth+b9TdPq30wZ/hp2A5R8f47SbZbi440xtKAdXk8=;
 b=W8qOWXPfesDKYc2Ed9iNVkoU3YuIPSpuadtaD46xlM8PkYIXugsTHoLpvOjgZLae62
 GZNL+A+neYzWyzwz4MKY/saAz3CZSU6V6yp3IRD/wT1n8SKnk8vj4LWimXNiYY7Iak8d
 UWZxJOckavsaWKnm9lyekqbR+Lf0vvLHBT0H7hIQR6Cm+Zq5tRAahlV5DHRH0qOdZ6Pg
 e/RIvstC3DypWCSlkDVQmUpu75zOg4ZPJDJLEvAVXoiW7UwpKBI/gSpB8qk7rVMNsjP2
 ycCExfJslRSJga04kcznwDH0XPLZmm/Ot4fn01fc+4o/RKZVtUPT1L8Y1pDgBqo/8UDW
 ylRQ==
X-Gm-Message-State: AOJu0YyiXJOr4PQZt/b3ju5JC58B2lyaYaxB0N72u8jqBWfHPW1Z/HPP
 p/wKXKxP80UL/yzoLb4YouKHysQxRfySjwoqd4i3cXsO7xBRfmp5+fwAJsdJXfBi35zwzAFKSQQ
 S9zMoSo5/QQ==
X-Gm-Gg: ASbGncvtzMpTlgEyvmf48pCd6WoRk9fHt+0DvboHuSBoDfS9yiG4HqrSKptayOAOaFe
 HgrqIHf5LYqc4tGekmOj/lZJkuBAL2b0Yjc2brDnsXfPOlNgG6U6SfkgrouInhPhsc/TxrrNaEf
 3sMhbFlYr9KBIhsRfgGRN4NoGH7+tqBOIVgiNDr6lKa4gLyVISQYbXsFH+k/TVZkXgF1yghIQLr
 Rt7jwQZBxhLY1c2Hcw6Gc/Bevrk8ogqa/Idrfz9jS14/nrBdi8RQc5KLMRS3/Ruaq4zlkO+oyAU
 4OPH6geaV28MGobZmXa2RE2FrFim7jYzNPxjiPved151x368ujUVJ+/iSADYYnKwNiMllMWX/Vc
 XIWs1TyioN2KH3xeUQ5m8VTyEbiM8/HHlAkoFNbCpNwzGlTL0QrC2tZNMoIC4TXZDjlybxdGgJB
 ezvcNgxSxNcl5WYoZmtFIw3VTHfbRA+Fyh/2M+egCo1Fpr7b6utgpKIr232p3V
X-Google-Smtp-Source: AGHT+IE39MONzmqfOsccrgSI1GSL9Vf9zFIhUSES1/kq2pkLjgVmAkmngwovYocZuZ44faHQKiAklw==
X-Received: by 2002:a05:600c:1554:b0:46e:7e22:ff6a with SMTP id
 5b1f17b1804b1-47904aebeb2mr62332085e9.15.1764143412544; 
 Tue, 25 Nov 2025 23:50:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479052def4bsm34010905e9.13.2025.11.25.23.50.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 23:50:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH-for-11.0 v2 01/12] target/hexagon: Use little-endian variant
 of cpu_ld/st_data*()
Date: Wed, 26 Nov 2025 08:49:52 +0100
Message-ID: <20251126075003.4826-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126075003.4826-1-philmd@linaro.org>
References: <20251126075003.4826-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We only build the Hexagon target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=hexagon; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/macros.h    | 6 +++---
 target/hexagon/op_helper.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 088e5961ab7..6c2862a2320 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -519,9 +519,9 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) MEM_LOAD##SIZE##SIGN(DST, EA)
 #else
 #define MEM_LOAD1 cpu_ldub_data_ra
-#define MEM_LOAD2 cpu_lduw_data_ra
-#define MEM_LOAD4 cpu_ldl_data_ra
-#define MEM_LOAD8 cpu_ldq_data_ra
+#define MEM_LOAD2 cpu_lduw_le_data_ra
+#define MEM_LOAD4 cpu_ldl_le_data_ra
+#define MEM_LOAD8 cpu_ldq_le_data_ra
 
 #define fLOAD(NUM, SIZE, SIGN, EA, DST) \
     do { \
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index e2e80ca7efa..08db1e9c56b 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -77,13 +77,13 @@ static void commit_store(CPUHexagonState *env, int slot_num, uintptr_t ra)
         cpu_stb_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 2:
-        cpu_stw_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        cpu_stw_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 4:
-        cpu_stl_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        cpu_stl_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 8:
-        cpu_stq_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
+        cpu_stq_le_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
         break;
     default:
         g_assert_not_reached();
-- 
2.51.0


