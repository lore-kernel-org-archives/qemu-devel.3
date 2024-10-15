Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A303D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlx-0006nd-D7; Tue, 15 Oct 2024 11:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlr-0006c5-B5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:40 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlp-00012P-OJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20caccadbeeso41651395ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007256; x=1729612056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLrx6EmGTvRMia9SJl0yo7FPDa0fQJjS3ptDOLc8dGQ=;
 b=qP3P2GJ3F0nVU/+2ahcZtarhQ6JASmY4Ff4T5poJ+Km4+fkCyjJmZfbMuTpF0Mrltr
 b/8vMfNzRM5w9wVnpm0k0rbR9SDWzsruz5JJ90rK/UO30MFNEfSWWp8nJC5zSkPgXDe3
 HGMxBCv8SknXDoNG3X5L1sJaj13TGQpq/mdfJD9OKeQjuX3YKQH7ZrOGmSQHSqRU8tnN
 rerxy9oXozUH9zqM7T5xx1EVkiw/bUqjDwS/S+qQxw57aiDilNZ6HiDymsZiLBlYnbz7
 RsxDXA87MxNUj1qf9b4dAYrKnRjsnkrHRICk7uepLLwH23ZXvweCSKHRrDJyiwPxhrU5
 J+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007256; x=1729612056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLrx6EmGTvRMia9SJl0yo7FPDa0fQJjS3ptDOLc8dGQ=;
 b=Kj6ZgalO1mxjUnSmNK/p1YsC956nuEvCaLQ90n8ypM4ZSdkYwGmDwXZ1V/qjrtg3zw
 GiyNjp1YRBgV+gfBDIL6lsjlTOIy1QRYSwTVa6lURwc30fBO/gdLokB++KdRcaJItwXj
 KYu44R7lnxL4AGv4eHFoSr2zQIu/7WpajjAEKPYjUuuBKobidndrUgdJYmXNzKs3PUY0
 PihclYZkgDV7Fevg7AHtRZVM51oiP3ft585CJdpxVxl6+gvH9ev0UmwiTK0X4E+VkEfB
 HSf/1MypPNNg+0XfCZX0wmzWyzsWOcgRQx6V0sNOCZ5NvhfNj9EKw/YnOfy5BgCEYsgy
 XJOA==
X-Gm-Message-State: AOJu0YyjOewy038aLpzaTWau950iuJsonksjaKd29GeQeAojKzy6rUl7
 wa5axDAaggx/eN/JWqj2EJ6vE9g+SvVtFF9Vt1/dehcKsGV7USCyKBo1ff4sXKFn4aG9jK8P75d
 f
X-Google-Smtp-Source: AGHT+IEPYGVhaHR3UOQ0OYfQPJLREiwux6vCRx1U5/EnPsydQBhqCiPNjzM7XOamrxVLZAjlUwBlug==
X-Received: by 2002:a17:902:ea0e:b0:20c:bcf1:c70e with SMTP id
 d9443c01a7336-20cbcf1f8a1mr148488305ad.13.1729007256109; 
 Tue, 15 Oct 2024 08:47:36 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b5e5sm13561495ad.197.2024.10.15.08.47.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:47:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/33] target/mips: Rename unused sysemu argument of
 OP_LD_ATOMIC()
Date: Tue, 15 Oct 2024 12:44:33 -0300
Message-ID: <20241015154443.71763-25-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In commit 6d0cad12594 ("target/mips: Finish conversion to
tcg_gen_qemu_{ld,st}_*") we renamed the argument of the user
definition. Rename the system part for coherency. Since the
argument is ignored, prefix with 'ignored_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-9-philmd@linaro.org>
---
 target/mips/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6f047d6069a..6ba8371658c 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1957,7 +1957,7 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
     tcg_gen_st_tl(ret, tcg_env, offsetof(CPUMIPSState, llval));            \
 }
 #else
-#define OP_LD_ATOMIC(insn, fname)                                          \
+#define OP_LD_ATOMIC(insn, ignored_memop)                                  \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
-- 
2.45.2


