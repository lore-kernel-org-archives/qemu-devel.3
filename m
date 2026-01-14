Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC413D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsnZ-00046Q-DY; Tue, 13 Jan 2026 23:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnT-0003rk-8b
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:56 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnR-0003md-Rm
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:54 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so51417165ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366072; x=1768970872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VF8crHFa+z0IL+BbS7WLnNbJmuaTvsGsIEpdQfUVH40=;
 b=CVjs2Aq35X7bnnnTo8VwaifmOjomDw6B1TuS3eUmL18hYqZFq3LYgd6JDOhGW901SF
 qoBx8AgTAI2ONvQOqHWThH5TSfHCayxyL985dYWEcwinQgyxBI9fk2kRkbX9EhyMKu76
 GJTa8810xQWbrRGmeWF5AbT59Amt3mhlUWkoqTVB4X9RfLuAfkUMrOefov47BkFIWUWB
 jn1j7dMmL9Sy1AwUDmypn4UZ5ZGU/a18KA8ZjS/pLAIf9H7IziOiygJFAlTdUreIggJ+
 nGOSyCBIpUY0/augtXlI5z/KecU5aRstSXVAXXvqQUG9SowvLeEhOy/BBlUM0yzkIEjt
 zsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366072; x=1768970872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VF8crHFa+z0IL+BbS7WLnNbJmuaTvsGsIEpdQfUVH40=;
 b=a2gdmCWaFpxueVAKeQfeBhxX8tRjKvS7JMVaC6tTrEdDQ7QsXeg0GBWjGA/LalJY/N
 EIt5cmzHbAzOjjApcv2hSVUUaMlejj8IS4xgq4VZVezxX1xnq74I35nu3pC6QkH/KLnM
 lhriIRZh25huZdewEVx1192aT5y/eKHXpu5eiJevPArtEmtnS7LmnMeMg5GyZ+gYO6Ey
 2sgPD/Nej57UZXBjB2MWA58sl6wD4fz752RI5i9CtLolc1gXML5SQSM1efMSIjTZPQtG
 C3yFvHeSlRqNftwPZ738A87d99USgIYBHOGMosJ+9tcvDeTX7ntVut4DHgiDGjwZmrn1
 AR3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeUX84RNEiczPBAQFntQvp6JOmBxt1B+9PCmW7t9iHb2rw5gyIKYZKhOU93yAUk/pOXO7FhQSBl2FP@nongnu.org
X-Gm-Message-State: AOJu0YwlJ2ywZdzNabKech0iSkqx1O+2N88Co13RxKfQogZvkHypVVa7
 esMNYNbGB0a0e0LMj9i/TuVdRACLoXANffb1uA7yCb52trRF7zSvW8BI
X-Gm-Gg: AY/fxX6JMMuVnBB/dG0XB4eB92xNxpFW5e7Y4mgx8FPsHKjM6x9DWUc0ghdXdAxIdeL
 52hITJrE9D3wBkHUTej48wBD57GC6spUslL/rXXYoj6c9o4IvKO/fU9APb91/v+NjWXrm/qHPOH
 uLPeP/P2l8RlZCxzWD5Vx3bbiyd7SP7yMwuqgLOsyyWSFReyC6R+aCojPFZPvslP6u0JwTqdQ2Q
 xJn5vYB+vJ5WN9xe7J1UyEZEm3yGLFJKfue3//AVwrqYGDGgdv1kzh4qkZPFT/P0aQj+pv1VrzP
 R8BVCF50FTCpHkh5gMscTquZBhCYUrCg/9tLOH7LhilXfjKXDA+2EITVTss7P314OSCJnYPgbHF
 hMpXFPtMIXWeZsXN8t4PY5JtHD7MQlMdNu00iJ5chr6bxClMKJmo+F2iOOCLi/8yGFBfNB5bJOY
 qbHA0WOLHfK3QMPiMR9lwOGOwGXlDm0IB0T1W5/XX5oD4KODR70lMxUjwjlG0MiSB3f2V5Sw==
X-Received: by 2002:a17:902:ea0a:b0:29f:301a:f6d2 with SMTP id
 d9443c01a7336-2a599dd18b2mr14059405ad.19.1768366072493; 
 Tue, 13 Jan 2026 20:47:52 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:47:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 06/25] target/riscv/debug: Implement get_trigger_action
 for icount type trigger
Date: Wed, 14 Jan 2026 14:46:39 +1000
Message-ID: <20260114044701.1173347-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 51c5934bfa..af9c4e37cd 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -110,6 +110,8 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
         action = (tdata1 & TYPE6_ACTION) >> 12;
         break;
     case TRIGGER_TYPE_INST_CNT:
+        action = (tdata1 & ITRIGGER_ACTION);
+        break;
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
     case TRIGGER_TYPE_EXT_SRC:
-- 
2.51.0


