Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D0EC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5p-000601-0h; Wed, 24 Apr 2024 19:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5i-0005vK-IC
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:54 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5g-0003Yf-Sf
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:54 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ae229e9176so408405a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001511; x=1714606311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hN1dyhS2K76C29H8D9/k3RGranbkoht6vnkUIzOBC5w=;
 b=M0JNmKwkW1bif/LeGAU5aVaTGOYlTMY3FgsQbI31TKCOZ5TYsW6ArafBCP3y+IkefO
 IxwLEbKsX6CQzv0yvkGqY8XwMg5iAtyZhrc5rMiGnvdd0U7iuk9XF7KHeCTGNyd1yrX4
 h/3wBALCsGJvoyHQjLTY4t9gr7F/q0xrINhmZXhikpFytBxfePwNI//uigTPpCxFBWuh
 jKQFObUl75oOVoyhnPGmiIyUeSu8HsNmPszWqzZz1q9Ib1zX5y3vehnElkLWNn5EnoTM
 nO0YBlA+biCC0je7iDNfb+14CEgRIfFzumNjWUKDkqnGBkJrZFnw4tTgicy8nI7Je0R2
 k5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001511; x=1714606311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hN1dyhS2K76C29H8D9/k3RGranbkoht6vnkUIzOBC5w=;
 b=wKMHRmd1R131H60DCXvuZe5AT8HbVxrAXpn1DflEm/l9Bjza9Iz6LylXnn2AtChMI8
 aBACn+Oc9gqIjjY50YEfiTTChZ+jJEpz0e7nrdGiAFUFEyizUthOh39v1m6WWC8nhotS
 Zc1OwJywaRCT2dW3FBfks5M0Z+zVb7l31hpzwwlXVSvEijeYXYeFkw6ZLJZ60HR3OAk0
 IHF9YF1fuj6elVIBokK2Xxmpy333tLH8Df9Fx6F9sUZQBFVwRPfonFF21mqDgcJMMdsp
 kYDg2sViBGqROkLf01z6kijxj8be+2yZOStxIV0JWlhnv1SieYvbCRZwlqr8TyS6nzpd
 o1eg==
X-Gm-Message-State: AOJu0Yxz9YQc4aay+Ba2+Ak2Bat/R5f8nUcLpJUAjTlzhUR/NSK8SpaZ
 sREKARMQmPcxmCroGh6akraVXdlG3JOAKq97SJThO4nyePsEK6hA6KPrX6zArJgF1jim16U61Yp
 j
X-Google-Smtp-Source: AGHT+IHaIz238qEfdtwOVuNgzINpb1UC0yMoJs3rBlCocCR0jGcB9JiqAzeJlsdMupeUs4ueCwK3kw==
X-Received: by 2002:a17:90b:33cf:b0:2a4:752f:b7b7 with SMTP id
 lk15-20020a17090b33cf00b002a4752fb7b7mr4136603pjb.26.1714001511532; 
 Wed, 24 Apr 2024 16:31:51 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/33] target/s390x: Fix translator_fake_ld length
Date: Wed, 24 Apr 2024 16:31:19 -0700
Message-Id: <20240424233131.988727-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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


