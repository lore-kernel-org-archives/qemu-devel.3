Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28E1C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuwA-0008CV-D1; Wed, 06 Mar 2024 12:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuw6-0008BI-Fp
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:20:10 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuw3-0001CY-OB
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:20:10 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29a858a0981so5130237a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709745606; x=1710350406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMBh/u49DOAEejhXpEpyFUDYeRYjhmZaHILM+RyspVc=;
 b=buQP+H7dSgIibeHkksDhYh4nRQ00st3y+chtl7r9LeVqaxHDmLb+PBSfJCvyFgsFcr
 kvfHjigtg9mACKuJlmvmsbO2GeSBoY7huF5G0ryWkjt8K+WIIrb0KZookYfUWbcf+eJ/
 MdulE+xhkxzG9n96G2cElp8XQ02Lf4YRZKcXZxgHSKQbJZSddpM4r47mJs+EcRTUVYvx
 B4tv9ca8IiDzogO3ck6Bf37rzFYFsM69D3KbTTG5BnvEcPuzq1/l/d35gFKBwBmQNoJO
 7ypcmBJtMKleQgi291GbwuVFJFuYM52AlZLgkzeDEoUxcp8U4wPOrpIdIaNStGKp2jcc
 sK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745606; x=1710350406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMBh/u49DOAEejhXpEpyFUDYeRYjhmZaHILM+RyspVc=;
 b=hCTldYSwxQ37lYyviEUjLy3U4YMWmvSK0sAtYEL4fVOuz55gzvl5PkEswzG5pQgjBo
 Wp7LK7whscTwnq1Eu2Dq6BgiLLwyqnMahuaCWENQBIqhatJKDlUmWWV4VMwwlNSbwoCu
 p79cFGmlFrnzZcmGPJo8NtgkUpt4tS44RboEOUYxMbNHUBJ4flyHgytHzuoBsYyzTKyc
 3zDtYrkr6ScHiuM0V2+lwxnCzlxxH5CLIVqK6cWKK435xJjZJ4HIdcJgnTfDiozU7nMv
 drXQy4oGYefuODxa+wsA00ISJtwICJPQNE0ySvzGlF0HD4Lx0uIrxGxlPBXfq9lvgFyh
 MFbg==
X-Gm-Message-State: AOJu0YyOA61qwDy1w7XlO0osB0zZ1B4uSesUL6SMfpcnYWRITXLOa5Pi
 6SuUE+9Fq9oFwdf9djfke/NBPGA/MuPeJQQ6tXuqaDq0W/5a06f4Rj7OwkaPjUZPFUL96ajqOex
 u
X-Google-Smtp-Source: AGHT+IGBMs2oJ/Cl1sXwLlnooX6Yypww/85KPJYpEssH5fcRlOmZO+eJNN41uOy69frFsPwdnTodHw==
X-Received: by 2002:a17:90b:3585:b0:29b:f79:2b75 with SMTP id
 mm5-20020a17090b358500b0029b0f792b75mr13683412pjb.7.1709745606002; 
 Wed, 06 Mar 2024 09:20:06 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a170902c71100b001dbb6fef41fsm12869712plp.257.2024.03.06.09.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:20:05 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 9/9] target/riscv/vector_helper.c: optimize loops in ldst
 helpers
Date: Wed,  6 Mar 2024 14:19:32 -0300
Message-ID: <20240306171932.549549-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306171932.549549-1-dbarboza@ventanamicro.com>
References: <20240306171932.549549-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
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
index cc7290a1bb..1ab386830a 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -208,7 +208,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
@@ -274,7 +274,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t esz = 1 << log2_esz;
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; i++, env->vstart++) {
+    for (i = env->vstart; i < evl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             target_ulong addr = base + ((i * nf + k) << log2_esz);
@@ -388,7 +388,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t vma = vext_vma(desc);
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
-- 
2.43.2


