Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C56C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rs-0004Hs-64; Wed, 15 May 2024 03:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Ro-0004FT-1f
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rh-0001bv-J3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso48854755e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759583; x=1716364383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zosCwfAqzS9tNL9GWtQRdlVeW1LGv2S9SgE5WNHpqQg=;
 b=I10h4EwdQtkrAtlww39UGGILScnSdxPxpMTK3U0WNrwwxc3Q0IDUpB13m+uwUVQGs2
 ypXgsnbzrVtDEw6WrMWQUYPlkSj85z4yTd/Sh/wOtvyjUZ2dcRupxdek8B6xJLAghMjC
 tKnN1CMY67IT8OwrLGkgKHBOIN6VyhU5m6muMW/6+AtrMDMGgw+H7oLPPni8pGqQuM44
 P5TjuCroEa510xXiZUsKcQ24Jx2lJJ5GOongi4vkYjbZmlU1+AwEiZl6NNirV5IKzpw/
 JynfIKIz7mx7etl8/k1dQlgtfR1Uj5DcGGZYhQEWKZveayJa2OFO3h82Stlm4gqmWtrI
 lA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759583; x=1716364383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zosCwfAqzS9tNL9GWtQRdlVeW1LGv2S9SgE5WNHpqQg=;
 b=UMCFfJU6Ue7hJjRDFBMTJRNyq05RhyRWqu5LbhFvJldfciXSG3oRvR7/BYuilvwtsi
 PnV8UHfoTMdOFoWahIm7vY+dzA3bGGRBxex6eNGS9VVr9Lr/yZIEuIvkZGIOPrv9lKzr
 tyi62AEfh18t8mU1x0z5YMaho5TY8Qpf2XSDZbIv6RdAdxdBYNVB++Zd9zgz2wzSdsIm
 7AAumqci4ch98Dn4LKa+cdqTogex0zi+3Yxr35bxEmFMHWnxvmpZK0Ct/M7LmvDD5TWc
 4NoW8Ua8x39jfKR+bOFGXujiWr5TuBvjHUhGn+f9Ov+JzojbdjymIJnvnO/59Qw/bay+
 zklA==
X-Gm-Message-State: AOJu0YzTStEriDYlDjqZTEF9SQiNknH4hSL5KV5KETD2xoPtdp8cmP+P
 75S/IZsIrH1P936Doda6l/fdtW723Ov9y9Oskbk3gXOjV7U3dCF/FYcgOTUNOnoVQhbmJ1BOnxB
 XS5M=
X-Google-Smtp-Source: AGHT+IHeLsv6C9/Qldl9aXehZqLCiAVt2bXcitpSvM514HuFJ+EdhmMl2MWhO9XSmpURBYqb2Wvwsg==
X-Received: by 2002:a05:600c:5601:b0:41a:adc3:f777 with SMTP id
 5b1f17b1804b1-41feaa38ec7mr144269005e9.16.1715759583014; 
 Wed, 15 May 2024 00:53:03 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/34] target/s390x: Fix translator_fake_ld length
Date: Wed, 15 May 2024 09:52:34 +0200
Message-Id: <20240515075247.68024-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

The ilen value extracted from ex_value is the length of the
EXECUTE instruction itself, and so is the increment to the pc.
However, the length of the synthetic insn is located in the
opcode like all other instructions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 2eb787e401..95d4d6ebc3 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6200,11 +6200,11 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
         /* Extract the values saved by EXECUTE.  */
         insn = s->ex_value & 0xffffffffffff0000ull;
         ilen = s->ex_value & 0xf;
+        op = insn >> 56;
 
         /* Register insn bytes with translator so plugins work. */
         be_insn = cpu_to_be64(insn);
-        translator_fake_ld(&s->base, &be_insn, ilen);
-        op = insn >> 56;
+        translator_fake_ld(&s->base, &be_insn, get_ilen(op));
     } else {
         insn = ld_code2(env, s, pc);
         op = (insn >> 8) & 0xff;
-- 
2.34.1


