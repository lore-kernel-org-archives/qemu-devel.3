Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE78C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 22:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWh4-0008Mw-OC; Wed, 13 Mar 2024 18:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWg2-0007RY-91
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:02:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWfw-0004M2-CO
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:02:20 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e6c8b1ccd7so204536b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 15:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710367334; x=1710972134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nhYYmgtTkAPTHuRKnPIpy8B5UZ1KuAVaIrpsMSHG6w=;
 b=U30au1jBwLQ/9dadBib40wYFnQRgC4O2Ct7i5p6cGyO00e1thGmuVNztEWRHtaYRIN
 S9OT3xzJsNtCzR27RD+gXy99SN61p5hR572FtlwuGAcaakihorRudI6sQZTYhw8tTYsP
 xig6Wod7a2lgv2LW4Bms0jwUB+1eDNmW/evdIvaEAcpVWc4b3Tf2xhsyEBJ6dKKjBG2G
 iePkIRHSTf5M6xjgJ2aEIo8jgUqTKHRTqsFtUARuaaRc6oDu19b6AN13+t3OUea1snC2
 okDrJIwSsWyJ9WqjsCNBCTWWxw6ID+Nao2JWGmBmRlUauQk1le8tqVxDaCOZ+u6+d2+G
 Z6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710367334; x=1710972134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nhYYmgtTkAPTHuRKnPIpy8B5UZ1KuAVaIrpsMSHG6w=;
 b=AYVcRFcCVwhaU6DKOUiWxUlPNHMsDCkIPXYF419GOmVKS2ZZGBr+9pUKS+rLokRkH0
 VWAgiUcOFdAkG9ALB+7FMJZt1mUbTJruzAi0KlWvXQvpk86uOg7mdMxyETSG+d+lQeP0
 1uBl7mjOYleOsWwjKl21bwD24pTfNkpjh1U0rW8NZlmYOCRIrdXh3e5iS1k56jjyS2dR
 cTdj4sPYp9lFMX31yPH5/vSBTjCeLv1j5fuYGLmUl1HyC4iLpuuxRk+dK73QICkB3YTc
 DyYoXjUkEaTL/9K606hP/uXLEI2RIQGejBAx/x/HM23uczRrOHXbLEa6LE757Q8YpxuZ
 GC1w==
X-Gm-Message-State: AOJu0YyrvRQnItbIiyIRKC7DofzGqV+3ENK2T9g8KxbQAVaFvx3F8JS0
 i9fcaamNcvz0x1WeXmMPBLZyfqhP0CJKrVjhVU1FsxZOjzWdh8DNDSOVL//84DLrBJs0XirgSBy
 C
X-Google-Smtp-Source: AGHT+IFMLLyxCXBsgdn/lQG33UZ8Wd6skfsqdDaij/M5BXJkwTnbIGKz095CKQ5nSQqRLOFiP3mEFg==
X-Received: by 2002:a05:6a00:1828:b0:6e5:ec63:95ce with SMTP id
 y40-20020a056a00182800b006e5ec6395cemr26748pfa.10.1710367334563; 
 Wed, 13 Mar 2024 15:02:14 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 ln17-20020a056a003cd100b006e6bcbea9e0sm95812pfb.88.2024.03.13.15.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 15:02:14 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v14 8/8] target/riscv/vector_helper.c: optimize loops
 in ldst helpers
Date: Wed, 13 Mar 2024 19:01:41 -0300
Message-ID: <20240313220141.427730-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313220141.427730-1-dbarboza@ventanamicro.com>
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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
index 48d041dd4e..6ee5380d0e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -209,7 +209,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
 
     VSTART_CHECK_EARLY_EXIT(env);
 
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
@@ -277,7 +277,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     VSTART_CHECK_EARLY_EXIT(env);
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; i++, env->vstart++) {
+    for (i = env->vstart; i < evl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             target_ulong addr = base + ((i * nf + k) << log2_esz);
@@ -393,7 +393,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     VSTART_CHECK_EARLY_EXIT(env);
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
-- 
2.43.2


