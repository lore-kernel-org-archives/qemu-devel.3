Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF9DC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuw0-00086e-SF; Wed, 06 Mar 2024 12:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuvw-0007sW-84
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:20:00 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuvu-0000qa-NN
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:19:59 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dd10ae77d8so30490205ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709745596; x=1710350396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlmAP9H3GMwk8y8I+55mQA4SRyf/lUmeN/mNvAUpUvc=;
 b=Kyg8UO68Co70olXS46ORys3TMGwnOLD3NkF8wMNI3BlmkN3FBb2n9/kdeWy6aWtnV1
 4+C6/33ZhLZx9Q6ZU96qHOjKNxQ6gEJwJM7qD/F6o/WwTEiFC9ZVTxpICxUtEEWREC7i
 InW1IYB5hvfAp4W1axrK8mV4+1d50CuZghVytIeZfmFLGxxfvt8iOcqk8P03IifHwhxt
 KpaDNUN2PegjT+kv4FbIYlZNpwnV8zYvMaIVvObmY+c0cYvd4YWtI/bQyLE/5xNnYoH4
 T7P8kyjqoXr6CqfskJGkj/nrot7gJlsBke80G/4DYoskqauUP3MppsoryNGUVVny8jgr
 0a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745596; x=1710350396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlmAP9H3GMwk8y8I+55mQA4SRyf/lUmeN/mNvAUpUvc=;
 b=dqOKxot5a8fR6OUAUM6NxjvtFbTQ3NGieQyvaxOkAN5WsJp29nztFe5nkPpur9oGrr
 rh9BE0Ee8k2BgJuXPOQMA4YusjFgIAWnw1VnUCQnaJHG7G3oD7FMmxD+hnq9HYamBisz
 3sNkeq0vDkFd00/8IJHYOULYBB8sQ69iw4ASBiNYhPtmI/BbDc0rgCGXs1gmsuGYd31N
 34E3GQTeBxZkdy5/Y2g6uVTPa0U6v2TGSElUbVEBEW7CtuBpYr5hU3qEAv1Sb7PIr6kw
 RvmYr50YroeCphZ+d/M8ALYjjcxcDjRZnp0ytu9zkFLtfwnYN6LRSMy/J2XEKsMW2NWP
 WSfg==
X-Gm-Message-State: AOJu0YxwYND8mzMYfnptVObmOrL5HA+ZJC9E/TyJIg+ypEpxz79BP/v3
 dN9gW6LGBowzX8VF40nHNb6fLH1O7qc1SavSFUG3LrTHjv/m99DI0CFitfjiaaDurvOmihaPTot
 w
X-Google-Smtp-Source: AGHT+IHjGOKM/oZ3IJIrK6umueEVpkwzuc7Fa6pfiYYTQVjO0OYQitnfcRbX+0WByHvada8DSlDvXQ==
X-Received: by 2002:a17:902:f685:b0:1dc:297d:b621 with SMTP id
 l5-20020a170902f68500b001dc297db621mr7214130plg.16.1709745596541; 
 Wed, 06 Mar 2024 09:19:56 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a170902c71100b001dbb6fef41fsm12869712plp.257.2024.03.06.09.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:19:56 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 6/9] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Wed,  6 Mar 2024 14:19:29 -0300
Message-ID: <20240306171932.549549-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306171932.549549-1-dbarboza@ventanamicro.com>
References: <20240306171932.549549-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The helper isn't setting env->vstart = 0 after its execution, as it is
expected from every vector instruction that completes successfully.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 84cec73eb2..cc7290a1bb 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4782,6 +4782,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.43.2


