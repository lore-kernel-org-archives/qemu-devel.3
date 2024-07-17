Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FD5C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxrr-0008AS-S2; Wed, 17 Jul 2024 02:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrN-0005bp-JJ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:53 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxrJ-00036I-I7
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:09:52 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-70448cae1e0so3545276a34.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196588; x=1721801388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shR5dO6yp58OnhkL2VwnGKfoxEn8l1B1D1MBIepMKeA=;
 b=Ki0ZGPmz8Nnnf8hYtB/KLkYOVtPTLOZAetHgXzbaMpXVTm/4VGk25+twsch7hpFrmE
 uCcFE3K1f3Poj58qQawlwBkwIfx5jm8rcDJhw7uO1qRUySx9FLOUyV4uKI1lCbzZp1Qg
 gRBLv5RcLrCB00HiEellPMd056Zz0NWebOVvw69luvyoeRY4TURMoE1I1lCJp6nw6nxf
 VZMUCaTqKMlpdsy0dpB3/VnRLjRgYI6lXb4bk2PN/OvCj38wPf7MmOF0BlGx6Pc1dVzb
 A4eXUMsc/xIPjS14VtU0WeziEiOQ5xiSQON0PIHLokcUM76o8wnJpkFyxPoOxftRYok9
 p1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196588; x=1721801388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shR5dO6yp58OnhkL2VwnGKfoxEn8l1B1D1MBIepMKeA=;
 b=a2SLBVWZ/FtaTgTTQ4eZtLd7KU4mneVicT+ipeCriT0Ng5fBqL6QuEPCksa0SzQQoo
 U8rBZPhl4USNEHdSBkiZdT1mNiu2Biyfk35e0FjyF0Kpxm+pjujw+yTaEGx8LjiOh9hF
 lOUQSIc/GP+uWOxZoJ0FTKzWcQGrdDTfN6Onw1rP3R79iDH/DtpwYHBzNCkDfzM4I5kw
 liPtMD6WbWeRMAoIolglKiZo9hxnhRHRnymq7gn70lCCzQgMhbcwhFKZPceglT3M0guo
 hmb+9RDrjRIst5Eqe8HeBfRQ1ayupWG2S9OZ9da5rZsefLdjaa+skCC4731aarkOcj9R
 WslQ==
X-Gm-Message-State: AOJu0YxLhXkIv1kLw1nU1n/FiTXC0l27iYujpuH4RYvvHmk7sNHWYq+1
 L61K1JFJFngRtpg5Vd0dQvBG2f0F8Q+SY7tbcvNK2rV7rIupdGuHLOUHwQFnkn7dtvfHNtaEoR8
 g+hk=
X-Google-Smtp-Source: AGHT+IHXdI3qRlOirqdTEp/qvlK2rKbjNAbsWEF0ROQkgpQeDm+SAjhBzLzZxpeQnJjRElH1msw6mw==
X-Received: by 2002:a05:6830:6e09:b0:704:47db:cd68 with SMTP id
 46e09a7af769-708e3778001mr1007107a34.4.1721196588116; 
 Tue, 16 Jul 2024 23:09:48 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ecd603bsm7330404b3a.219.2024.07.16.23.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:09:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/17] target/arm: Use {,s}extract in handle_vec_simd_wshli
Date: Wed, 17 Jul 2024 16:09:01 +1000
Message-ID: <20240717060903.205098-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060903.205098-1-richard.henderson@linaro.org>
References: <20240717060903.205098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Combine the right shift with the extension via
the tcg extract operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d0ad6c90bc..627d4311bb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10466,8 +10466,11 @@ static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
     read_vec_element(s, tcg_rn, rn, is_q ? 1 : 0, MO_64);
 
     for (i = 0; i < elements; i++) {
-        tcg_gen_shri_i64(tcg_rd, tcg_rn, i * esize);
-        ext_and_shift_reg(tcg_rd, tcg_rd, size | (!is_u << 2), 0);
+        if (is_u) {
+            tcg_gen_extract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        } else {
+            tcg_gen_sextract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        }
         tcg_gen_shli_i64(tcg_rd, tcg_rd, shift);
         write_vec_element(s, tcg_rd, rd, i, size + 1);
     }
-- 
2.43.0


