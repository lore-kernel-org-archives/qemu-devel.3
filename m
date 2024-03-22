Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036D1C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 08:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnaeq-0003nM-9g; Fri, 22 Mar 2024 04:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnaen-0003mw-GE
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:53:45 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnaem-0000zB-3s
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 04:53:45 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dff837d674so14950105ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711097622; x=1711702422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlXAD82ebz/CyDsPxrmXVSEpvs08EGAPAZEitMfGHS4=;
 b=W8ya+HGp4bY/TuDybe3Qmfk5du/YmiS/SzKftj5oqkEeKynQeozjIbTdWoto3nb6vP
 bzYdaqP955/NLpb4pc6wL5L6uDg67V3cMcW3HxwilT9ey+No9cMdtMdnmP2coflfUkTu
 iCki6xBwyO072Sudq3d2hWcz5AnMZ5+RY8RtPoDpud81ZTb2bGUN6LFR82jFlJpihRIn
 Ame2gHzVTr5Puk9YFTJ1pCDpg6lJBu6jZZIPm7E2pq+wyYYfW2JQ0hdIqLXfsUdUpzAM
 9xQloqkb0mnzVK9EO1wplUbUXBjmXJG/TGIyMHEy38VnOsmrprQlhGF8DH+5U67Zi5S7
 0bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097622; x=1711702422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlXAD82ebz/CyDsPxrmXVSEpvs08EGAPAZEitMfGHS4=;
 b=FqsFuAKYEssELd+V865PKpz0nY1rVAOg4JeRQBFRQZV24lUGlzaasJZtGwEgkC+EFQ
 sWjbDgOPUO7x8RV7ZlhB/2VCqQLztXcNYt2cUrm9vkugzEmTs8CudU6RxjLZBTkOKhJ7
 9oB93fZs+r8mE8OnqBM6POpg/wwcCUP+SPKAVnx5MaEnuFlRUQA5EI9tTgIKmgwDFvPO
 mve1+0/iui0PuskDH+HdpfSCIRp4Ci5vHQlrtGEvm6jV/LzmgS0jtVWNlM5Csv0v85W3
 k5IcIY0BMBzY1R9mpSmI0B8A0fUKVCTzzwboFvuw26zxX/owdFiJET5LJ3SqhaAwlm2L
 BvLQ==
X-Gm-Message-State: AOJu0Ywf1HHwrVBcjtPcuVwjLRBHliR++DmiIjW36NcL7e4CcS45SRKF
 tM7sHNL9ax5wWq9JBMuS4IBYxvguQ9ztj+PzHVv6UKBcDY5AYrTeoIcsCu/0ZwFXvg==
X-Google-Smtp-Source: AGHT+IG2KUmHIsErl4CjZ2NuTKtWM5sMXYyIvmQTyrkiVaZHQ9Q+IGjv9KwyyJtcf5eWC3ezfUD6EA==
X-Received: by 2002:a17:902:ea12:b0:1de:f18c:cdd with SMTP id
 s18-20020a170902ea1200b001def18c0cddmr2172556plg.3.1711097621853; 
 Fri, 22 Mar 2024 01:53:41 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:53:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 04/15] target/riscv/vector_helper.c: fix 'vmvr_v' memcpy
 endianess
Date: Fri, 22 Mar 2024 18:53:08 +1000
Message-ID: <20240322085319.1758843-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

vmvr_v isn't handling the case where the host might be big endian and
the bytes to be copied aren't sequential.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240314175704.478276-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ca79571ae2..34ac4aa808 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5075,9 +5075,17 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
     uint32_t startb = env->vstart * sewb;
     uint32_t i = startb;
 
+    if (HOST_BIG_ENDIAN && i % 8 != 0) {
+        uint32_t j = ROUND_UP(i, 8);
+        memcpy((uint8_t *)vd + H1(j - 1),
+               (uint8_t *)vs2 + H1(j - 1),
+               j - i);
+        i = j;
+    }
+
     memcpy((uint8_t *)vd + H1(i),
            (uint8_t *)vs2 + H1(i),
-           maxsz - startb);
+           maxsz - i);
 
     env->vstart = 0;
 }
-- 
2.44.0


