Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9477C54E58
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjHkg-0007ul-Pf; Sun, 10 Mar 2024 07:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHkf-0007uB-DA
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:54:01 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjHkc-00045e-Ue
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 07:54:01 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so3324402b3a.3
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710071636; x=1710676436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMn63prcVteRus1yYdprTy/N0umMjC+ArdoC3MJRmKA=;
 b=Gp7kAbyVzbhshiGoyksLjdrzntU+i9/DMdM22TRoqLP/s+XCxgCaVCDTiwhcx8MQdr
 fQjO7nhyDVULbmCUsxXKekUpQiiYZYh+gWk2jiJBvvJF8lGQW3qinoLM2wYgIpGExOJt
 jLFu/iuaFWaH/Dl7Fz+ULwN3wDfcX41VOZ6AApPuDCkwLl96rk35BN1tZOJWq6MTqP7r
 LNDLT97oFFbpS87ymG+IC3NcygmR8CRRx46aRrtAigXO7q+g8fudNHV+YcY2KlMBqhRo
 Ei0jkE1PEgUAmPZkKr096P4jTxhN1MX1FHI8jZMQpC41U5R0UXvmJ+axFcJBP9psDhAY
 K/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710071636; x=1710676436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMn63prcVteRus1yYdprTy/N0umMjC+ArdoC3MJRmKA=;
 b=p/qfOEaUHA8IkSrIHt9ASyKTnQAxagG8EgB9bC+Cx3kGQwhA4obk3zMc7ZXC/Ax1aQ
 p99Frygqk5svrLkzGA4Pz9smzqLJA7BfWOvcvdNnOjRAgSf1axGkb78hewhb+Bixlee/
 N82ftuSp1yoGiZS7Dzd1aMKOFQ7mz8geb7of+d3+CgRCgvHO9SAhLYRyi61J0sEFfFdO
 Yh1sLzPGaicfw+8JRxKLBGgiIPerA8jsJV2Eujzu69Sk6y771LLmWt6W4ILC59GAFWyy
 FaB6Q0g4/9ldLrHKMs60TS3Wu42r8AKuCxntqUOBTuEYZ1VURcrhAapmOm8nQkoiv42S
 JDew==
X-Gm-Message-State: AOJu0YyJ/XgHXGNMXfW1+okw5mr8VN9YjfGDcJfCUlJS64Klwp28Jw84
 EBN6icA7IqwJHYqVv5ekuiqe3EDUFxQXYnUXQxmROM1bO/74p1XWcRTmPjJlv4oyXQZIxQ03hJu
 k
X-Google-Smtp-Source: AGHT+IFUwsA/jTOcAvz9/pkbzo5evtQFxHkRNBEKWYoGKUA0bYWWOOsoiPz9hsXp8ZDCHR6hSlZQiQ==
X-Received: by 2002:a05:6a00:2e94:b0:6e6:16b5:2ea3 with SMTP id
 fd20-20020a056a002e9400b006e616b52ea3mr6030031pfb.27.1710071636621; 
 Sun, 10 Mar 2024 04:53:56 -0700 (PDT)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 g22-20020aa78196000000b006e647059cccsm2449253pfi.33.2024.03.10.04.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 04:53:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 10/10] target/riscv/vector_helper.c: optimize loops in
 ldst helpers
Date: Sun, 10 Mar 2024 08:53:14 -0300
Message-ID: <20240310115315.187283-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240310115315.187283-1-dbarboza@ventanamicro.com>
References: <20240310115315.187283-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Change the for loops in ldst helpers to do a single increment in the
counter, and assign it env->vstart, to avoid re-reading from vstart
every time.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 4fe8752eea..ee57300dc0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -195,7 +195,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
         return;
     }
 
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
@@ -270,7 +270,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     }
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; i++, env->vstart++) {
+    for (i = env->vstart; i < evl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             target_ulong addr = base + ((i * nf + k) << log2_esz);
@@ -393,7 +393,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     }
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
-- 
2.43.2


