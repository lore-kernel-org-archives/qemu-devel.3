Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A84C56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrzGi-00084U-Io; Thu, 06 Aug 2026 10:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vvisaev@gmail.com>) id 1wryIT-0002hj-4k
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 09:38:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vvisaev@gmail.com>) id 1wryIR-0005zM-PM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 09:38:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso16422985e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786023486; x=1786628286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eH704TxnRusu+iEH09SDQ1XCsum28aO0uNmda66AhBM=;
 b=iCjkhuZj3ZLaNjaYlykcinfvZ1EFvNawxzNQA3qv9DD2U5eUm3TQk6Bk+ysVM7Gu57
 x6wjp+Ys6szCQISizxvmvUShf6ept6E2niT4aAyD3TSYzQRgCpYQONfi2YtmH/vNdlkV
 qEZDuUZqkrdR30YrsmGXbjJXVdvaov4+WeMzqR1j9GOKTNmThUCAI44izKJiQTuvoh86
 kj75gr3baEgITOVuuiTXfLxINK8qqatqICJV1IcG7iN+uCmIyx3tsCvqFJpXT8kvDZr8
 4LSJZidtuLt0eNRUhrW0pdUxXFzNOMei/nn2Aiyh0OswnHf1n79+xLpMiA0K3+duq7th
 TNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786023486; x=1786628286;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eH704TxnRusu+iEH09SDQ1XCsum28aO0uNmda66AhBM=;
 b=J3AmrihhIUxnPidBIHJLPFW4QFQlHRaoPUfQ1DS02xzMnbnfP6TCN/U3ebtcaSQKqh
 xRKNxdRXtxIkgADcxkDWlhSu4ouluz8LRLWCVGDOPDUU8J4yhnVLm/wgdZ2N4zGTOQ51
 8rLJkxkB0E15CEDTTL8qdSNrc4rB2Ydih0h1XP6ZCOjYNPJQfXMr7p+po9Uy2pFIAik4
 zqZ1+KMHLgUZH53K+YRjHIznhRSP+2BMI/o7p+AarGuLLqqi3jhHj1CB3JLVqH5U1+z4
 QdPAdh4gnyxcOml2fa5/pOVTdrnub8Z2S22Z/TtVZTucauQ5TFPD8koMegUzRumnBm9K
 Hopg==
X-Gm-Message-State: AOJu0Yxmb5QWpN/KB4JGwKRhzsR6EEAi5KDgRJzoFqk+SX2q03zO7iw1
 GhijRcL4d0j395Skn2QL0UhGBGcTXg6EjuJOgqtw5wNAAKelVj75EE/qp1zY29lBa+o=
X-Gm-Gg: AR+sD13jsm4E+lbFpZK4siB66TZ2AJbZr8lCLzyVvrdWSZ0miNzYRcIMfOmQJb/F9tJ
 m/xf7f+SrwA6oBc3mPBubdnABkwQ2qBK2ut+Jfu7J3qQLavC57ptFq8oZubfkfMBXidFdJmxOa6
 keGZRKInDHjINs5wkBn6tiTBL6bIdnC1CGfLkqXLUYUxmn2UZa93xP0qSj3BHSEhrvHpOt3q+EL
 x7PUfhrMbk3uELvDO5OauXwCU5lPXNfVSNz9Au4fOgEzZAw1PObh95ancypgAovll++wPj/+iFQ
 XxZ5LKPWRQn7+A8fZQQ5TqiktBnxVuJoOoAb1ZzO4gmH6FYPAJj9VT/fAP0Qy3YlH66EwozyFlV
 tEgxT0Q3UtCCspT74Tj5pAPIgaD+sAeWC2G/2u7xMBsF0kKNyVtSvmA7cFmmDZGch6jAy8tHbPO
 ECA8MHn1B4nlxB02gnJ7ga3Vkree6W/dp+AX0IhhRSWRE=
X-Received: by 2002:a05:600c:8116:b0:495:3da3:beb with SMTP id
 5b1f17b1804b1-4994e7b74a2mr226371315e9.10.1786023485677; 
 Thu, 06 Aug 2026 06:38:05 -0700 (PDT)
Received: from X1 ([178.66.48.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff79a7f07sm6837422f8f.8.2026.08.06.06.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:38:05 -0700 (PDT)
From: Vladimir Isaev <vvisaev@gmail.com>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org,
 Vladimir Isaev <vvisaev@gmail.com>
Subject: [PATCH 1/2] riscv: csr: do not drop C bit on misa write
Date: Thu,  6 Aug 2026 16:37:46 +0300
Message-ID: <20260806133755.45924-1-vvisaev@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=vvisaev@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 06 Aug 2026 10:40:22 -0400
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

According to spec:
> Writing misa may increase IALIGN, e.g., by disabling the "C" extension.
> If an instruction that would write misa increases IALIGN, and the
> subsequent instruction’s address is not IALIGN-bit aligned, the
> write to misa is suppressed, leaving misa unchanged.

So attempt to disable C extension if next instruction is not aligned should not
change the misa.

Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>
---
 target/riscv/tcg/csr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36f2004bc5..58c206c1fa 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2182,9 +2182,10 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
     /* Mask extensions that are not supported by this hart */
     val &= env->misa_ext_mask;
 
-    /* Suppress 'C' if next instruction is not aligned. */
-    if ((val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
-        val &= ~RVC;
+    /* drop write if RVC is cleared and next instruction is not aligned */
+    if ((env->misa_ext & RVC) && !(val & RVC) &&
+         (get_next_pc(env, ra) & 3) != 0) {
+        return RISCV_EXCP_NONE;
     }
 
     /* Disable RVG if any of its dependencies are disabled */
-- 
2.55.0


