Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3846D2A554
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kL-0002di-67; Wed, 16 Oct 2024 15:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kI-0002cZ-N5
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:46 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kF-0003nJ-JK
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-208cf673b8dso1747495ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107102; x=1729711902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAS56LpJLEvFceTFCBsO+yMHFwJ+VtaFv7L9YjE7ffs=;
 b=OSvF6fMopQgsmWmUSA1xiO/3gUZlMxSse5XxAPZAbgtx4sOFZHk5H97BEPKWyKShSS
 71tTJIzSEn8cIuDvk+gKqdOCrYDCXGDzvfhc7siB8EaeoJ0naaAAcDRxEAwYPwPUeGpe
 B34FAsMFA+QyXXNHlx3Tyhj6xTRX99/YisLQT5wo836Q8QfpjP1eIIwarr3sOHz8VWNz
 Vv1/zcWifzEw3ROTqUFX1Moi23qAGtyZqauSZBN48hODn+NEuZfYPktrpX+tqL881fPt
 SLQKezYzN7vxMjV8hltQPh438vsPyuOi9EiXaADJgCRQvIAbVzPP++ce+c/gaqqOps0v
 vWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107102; x=1729711902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pAS56LpJLEvFceTFCBsO+yMHFwJ+VtaFv7L9YjE7ffs=;
 b=V0k35BOwbB2Rnm/QEIDsXK2EIyzFWnrMmW/qKsxfXz/6VxGGpgpvxtUnbnrwGtAxMu
 eBEprxnBRPJO+eQNOvE8wy9CZvpH7l+3Wp6gqMfYK786q4gXIFvprVIjhuHzdwdjTx4w
 a4jaMOUFI3T8e6rtRZzJGaWevgZQeZkC7LQSq5kyAxhtwt4Qx2T8My+mz+kJ0Z+J2Jyw
 0mDttyFdoYEUW8PqIDlI3n3h50secODq67EzsFVt+YbGZntDxJ+gTYBmw+8vxPSpxj1K
 Aah8f4NGB22IiT0bslxNYOvXxfLoCLbgF/8cuOeXUB9DTBv6DE4GAkqKguXYvDlU4MtG
 eLlA==
X-Gm-Message-State: AOJu0Yye0chYvJUrsXMxye/78OKRDXRuc1ZZdYtkiE59jOBX59vaMf9Q
 mc98gpTIfy7CZpRg6IBiUraxfKGI5XMwC5ErFbQsaSzrnDeFiOlBzHIvlKNij49CAO2aqpjhGWv
 W
X-Google-Smtp-Source: AGHT+IFkOIpE7mOZzAuqHtZeBcp/PoRhA6Hzul0zrj2kcEBUIYN6D8Et+bkkoALvnwUMfW3KVQbzyA==
X-Received: by 2002:a17:903:1c9:b0:20c:9d8d:1f65 with SMTP id
 d9443c01a7336-20d27ef315dmr71489035ad.30.1729107102081; 
 Wed, 16 Oct 2024 12:31:42 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com, qemu-stable@nongnu.org
Subject: [PATCH v6 01/14] tcg: Reset data_gen_ptr correctly
Date: Wed, 16 Oct 2024 12:31:27 -0700
Message-ID: <20241016193140.2206352-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

This pointer needs to be reset after overflow just like
code_buf and code_ptr.

Cc: qemu-stable@nongnu.org
Fixes: 57a269469db ("tcg: Infrastructure for managing constant pools")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5decd83cf4..0babae1b88 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1399,7 +1399,6 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
         goto retry;
     }
     qatomic_set(&s->code_gen_ptr, next);
-    s->data_gen_ptr = NULL;
     return tb;
 }
 
@@ -6172,6 +6171,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
      */
     s->code_buf = tcg_splitwx_to_rw(tb->tc.ptr);
     s->code_ptr = s->code_buf;
+    s->data_gen_ptr = NULL;
 
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     QSIMPLEQ_INIT(&s->ldst_labels);
-- 
2.43.0


