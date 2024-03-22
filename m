Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DC6C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 08:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnael-0003mO-6E; Fri, 22 Mar 2024 04:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnaei-0003ls-Q8
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:53:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnaef-0000yg-64
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:53:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e0511a4383so13397005ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711097615; x=1711702415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/T4QIc6EALM5qs4syXwYUJFKzH0rDTI4HgRx0f53UXA=;
 b=Ttw25UB6LocDVERVF0W/7xsCR49mbPvm7ObTFDp/3/fj3x5y3Fys5cmQisI9Vk18n8
 zromp+g6VqFk657ilRvCo8/33QSKh3R8pCfy5r5KgXFmlLW3vpNVVCzvsMU5vFrgKkng
 pcyHf+0NekZRD2e+UsfrgR0A1G77pLkGemOZDqiFJnqxRDwfyZ0VR5kr0D0aJOKcWc6W
 g3iJniv86uYktBR4NyLpVpuHmPlTUa70bK8A2idf3TxnlCJ3QR4juobsi6+v3aXQEmFt
 6rSuVsfZ8IkLiax/nDjVx1u/NhnDOqj7SRgDGZPeRN+HqKwjlAvpCXiw7Aq5jyxk80YS
 A1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097615; x=1711702415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/T4QIc6EALM5qs4syXwYUJFKzH0rDTI4HgRx0f53UXA=;
 b=UW9QgtUC/3F0HhwLHydiX16wF4U6kDWLc7dc9Nv9a4kByleHQ7dBrbkztB1XJfchaG
 YQ6RWTa8ei9yVr6aJeUenrwxDTfdBlsLjxq84ZjdUPJl74fVI+OUnfnL+hcdDThnV5+c
 hJXhJkno89eE5z3h89a28EQoW/DqK+IdRUNsCH2NU+yw9ZC7wsxvhIXTuSYUdw7u06lT
 jMS1L1Fea01AyQuKPYTGz21qwS+zRCBp2mZPHhqGHKh/pndG1WB9u+EfBNmaG2pgDjhu
 MF0tSYOC6BFbco68rn9bJGPKxF0/qZjNvh4LIYoRrwNUhNevPvdL1X83oWOPbeaWOy29
 X6vA==
X-Gm-Message-State: AOJu0YxlOoWrb8WkEz6wN1A8nu4fmCo8cT9iKhzru4kvGQ8Dy2po/xhc
 rBi548vhNltwje8qc06ENN5WeEpoAokG6oLqjkyLhhSdCIO1h/+7RRNL01JggmIk/g==
X-Google-Smtp-Source: AGHT+IHLCWLh6I39YY/Q1B2soBjT966aqKb4Y2te1hD/eP7q66uIu/uh9abVVq6QK22c5yFgTmKJmQ==
X-Received: by 2002:a17:902:ef10:b0:1dd:135e:2604 with SMTP id
 d16-20020a170902ef1000b001dd135e2604mr2217417plx.40.1711097614834; 
 Fri, 22 Mar 2024 01:53:34 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:53:34 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 02/15] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
Date: Fri, 22 Mar 2024 18:53:06 +1000
Message-ID: <20240322085319.1758843-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The helper isn't setting env->vstart = 0 after its execution, as it is
expected from every vector instruction that completes successfully.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20240314175704.478276-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fe56c007d5..ca79571ae2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4781,6 +4781,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
     }                                                                     \
+    env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
     vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
 }
-- 
2.44.0


