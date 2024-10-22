Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D5CD1714C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 00:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t32V0-0008Tw-Fk; Mon, 21 Oct 2024 20:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32Uw-0008RX-3f
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:42 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32Ut-0005Sr-2Y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:41 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c8b557f91so50707715ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 17:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729555897; x=1730160697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNuygWaPKpMlZ9zU2OW7iVUnX+FVOoQWUF9XQYmmFl4=;
 b=CMZ1oQqaqkQ2lwuJo5nSz96D+iVhCsKubV+Cf8ObU0NHuKtGIg1rIUTUgZhd5p/caV
 q3kvMVa55zzvN9kZNOmweeABBIWgJToP2Bw5eaPHjXZzBlAJ388BRZww8IBbKIAxla9W
 rR4JskRv4b/AqkdKaWGWpNK46Xb+hZIkDlI8wLq0wwIdzkZMErThniUbTYNFBThJK4X/
 AbULofMSay9YL2P0EFOnDA4K970eV3N1cVruKJa090kiu3zwJPJCR8GhCPPT3BkRQNTz
 HLjO0V4+hFPDteiXcXdRxBR8uX6SU8cOqV//NNn+1iWe34Jq+QT2T1fov/5p/clT5AXj
 Z2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729555897; x=1730160697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNuygWaPKpMlZ9zU2OW7iVUnX+FVOoQWUF9XQYmmFl4=;
 b=fwIiG2f4udFQN2JccHFT/nxEqlpwGh8vKmlp3Q6CqiU1+u8kqV6ArShgBIyKrkL6pX
 3pylfTgzBExi8FmJmzCVMQiGo6TT21bzPFJs2TxL72kB5ASreoVfL5EuzQbyeUcelA1R
 L7FaNQOg1LS0HdbfuWX+/c35+/6VnXBuDu6MpYZZBTZawKPghDyT9wuB12EVrA8y78w1
 iTuqJUSvfrmrCZcWeW1p2SKFbJCqHmXl/ckEF6dw5tPmlFRfCZl4DdJS5ex6z85jpr4X
 p29hZJ7q1FmO26S/HNlSHNHvHFDg+UoOEW7BXq0QS6nbna6ME5qOzDc74fV1yw8aTNy0
 zHpQ==
X-Gm-Message-State: AOJu0YyOKok4nbzzahj46c7CSQt2iJePr/JcxSXsAEGTLTHohjykdd3E
 OMLyFlQvyUQyd/UKsg6tIj+I87wegzX0q7VY0OK7LEa7EEb4/MlopN6Ff96gE+zwDNmoofmG8bl
 8
X-Google-Smtp-Source: AGHT+IF7eL4AUzlQVJQw++yXl9jR2HD9v8Z72qsDFOsgmBD0nB5n8tSTKaTJHRPTvDjMT7xFLGaGzg==
X-Received: by 2002:a17:903:32cd:b0:20c:774b:5ae5 with SMTP id
 d9443c01a7336-20e5a70974cmr231583645ad.9.1729555896944; 
 Mon, 21 Oct 2024 17:11:36 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f6462sm31681145ad.272.2024.10.21.17.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 17:11:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair23@gmail.com,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 01/14] tcg: Reset data_gen_ptr correctly
Date: Mon, 21 Oct 2024 17:11:21 -0700
Message-ID: <20241022001134.828724-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022001134.828724-1-richard.henderson@linaro.org>
References: <20241022001134.828724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


