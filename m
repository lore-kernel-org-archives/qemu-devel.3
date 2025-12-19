Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC32E66882
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfYw-0002sF-Hx; Fri, 19 Dec 2025 13:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfYt-0002qO-0Q
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:50:48 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfYq-0002hv-WA
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:50:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso17919465e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766170242; x=1766775042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBtqVF9aU011XQ+13ZQmCZYCeHcb9NebZ4I9xBYMCpE=;
 b=aT82qrpYQj5kH9cnLMqtUo8PKtRfQUMdjv1f1MHpj8ivjSn3Ulb1jbNXOthE1v3C0K
 gZiDaKi6HdXuz+fcOfvSYJa8CAm5n0ot32vFUjmIj5ZrfhTCAAYhnCJ2c2W8ZTZVCTCq
 Ypzk3PYz/ZczZHehQF6s9mEtTxQ+0XJYtj9+c2WVextaOP44UCgwXgRTlGDljg9ydpZ3
 yuyZdZKyuQW/LpjCon1FgYOX8hXycIxf3zuIgcos9Ug114SVaD3iikmX+q+WRBd8kukA
 Dz4y+F9/SzA2bXVAiVHhqV9mNvQ6Fo6ydEPbEcb9iI70xesQk9wFHUhKxkHFKWiFdj/0
 HTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766170242; x=1766775042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gBtqVF9aU011XQ+13ZQmCZYCeHcb9NebZ4I9xBYMCpE=;
 b=jjcMHuRC2rarOxFsI+3DDNRUCxWGXr8fG9xle/lx3HlCCn3ynwxIS8cshnIEMDQg4D
 XNGUTuGU2XAweC7mbLXHb3f8rF53fbBuywpqfPa6oWkNG/qqGjHuOYb0g/LFAiyM/OeZ
 FRU4mxPcP5UxosOQLU6hHsBz5yaHmcbRIByRKmkQ06SxvMA6KOyKjlcffK7rRGJ7FhyZ
 itYRjVlnSARPTAMQrIm0wLuAILLcjRz0TIeyXw5vNKGp+KZ7lMux8KXYZFB79Dc7qbVE
 op68A2e5bWLnEADtGO7Ev3dtWkr15JcRDgW6+bWXS+bM0no7FX4YW9X+NCpENgdyOyjv
 EBsw==
X-Gm-Message-State: AOJu0YwjvaD2rhBmT1rrdY2N7DzCElBS54I1NreiADWpiyfdggtlmXc4
 QySSLN9cr4eTdSvlJNtac3mieDyTuG4lbtbDawjfH9/1EbKd8JTmus9DfC1d0IMQd/aQAweR9VH
 f1JW4p70=
X-Gm-Gg: AY/fxX4FpLPBfF2wybojEAaXaD9t35ylf0a3TVaxPq3CVyjWFMd+cSyUMYKZf+Ltlht
 d4S1UJH7KW8VYQzDxn6D3zeEohJYRZip0AZAy2yqnZt286p7GBkFQ9Kx98s7fBEdi4vF0iHGrEk
 FK7O2PwCKplSe1P6Q7LISAdOIG9wOcJhBxOPNiassUajM1I2BNAIpIvkXDIhBWOtpPFvexcgMpW
 AKjgo76an+qkpR1mVYxeemfwtetx/DKZpTDSr5H+pYy9QTwfRGRyhyjRkMz0BVK9W2LsxDsk0Ma
 r3To85JQscOWG7Co7QsXn0/xkrbKm1ACkVxd8n3yzMreUUmDp6qzJzZK/DP/9Xu2xEKt/wF2u58
 a+SZTQLbMdEt5L5VNwSNRNNm1aF2203OZrOybzxV5wQmUGkI7RYbpMSKF4iSbLJLSvOPhTmoaTz
 yBeT/9OPNgrp0qugrzdyyZzdcaBIi+BUgtLikSodoTOyqvubc727MSHJw51RQl
X-Google-Smtp-Source: AGHT+IEazUOLgvL/h7JgPP5cWWGwrz6wq8enonTGSKGlBt6DdP/LrJqVZtZcVS6u/i+A5lU0BEwTjg==
X-Received: by 2002:a05:600c:1c8b:b0:47a:9569:7872 with SMTP id
 5b1f17b1804b1-47d195aafd3mr38652475e9.36.1766170242226; 
 Fri, 19 Dec 2025 10:50:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d5372sm59270625e9.14.2025.12.19.10.50.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:50:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/3] target/hexagon: Use little-endian variant of
 cpu_ld/st_data*()
Date: Fri, 19 Dec 2025 19:50:24 +0100
Message-ID: <20251219185025.97318-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219185025.97318-1-philmd@linaro.org>
References: <20251219185025.97318-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.52.0


