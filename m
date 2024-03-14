Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C91C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkpL5-0005qo-EO; Thu, 14 Mar 2024 13:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkpKt-0005bG-Rv
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:57:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkpKs-0005bU-4E
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:57:47 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dee2802d9cso4725405ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710439064; x=1711043864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxixFGsZWk+2lK82HLs417Kxq+8co9P1hPTo5toZe/I=;
 b=JwZXXOFkw6dnZgnjMfTG/gZmqmngg6ECfIeGMjlWTRZ2JLzba3WYbGD0ZqMlW3stFp
 1wQvI9lPchC0DC9+RsndilbcPXsY3QA95CpmwI8P3v2+AXDDo1gLB2hvnyZu7FMur0uu
 Dk0/L8bLv+KZjyXi2EB8PCbNdzXEdG22PerV5PqVsBQBwSpLstCZT9OG1AHHSiuS5jm6
 mOrozKeAjXcAe1reRzjuxBUJXqTDSD1MiV4gJzYCHQF7eUP7acGJ3WPGwcHJR18hnbUy
 C7K5TLmKaIIs0InLZ0oyMJrg1mdeGuVgV2U6Mz/6lWF2dTLMApHf/251M8jkgxrx0sXa
 lWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710439064; x=1711043864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxixFGsZWk+2lK82HLs417Kxq+8co9P1hPTo5toZe/I=;
 b=ua22Uv4LTP1ZLeruI5iX0e0xe7MMdkul56a1UvpIx+NId8uRU2/iGcUoN98L02KwtZ
 BUN89pbuuZHxfKBm0OrcdDaYQJh0Mlw/9H3Veyq/Z6tj4f58fr39QlMafAlaajeRlKD8
 AseWOqrOgf8gj1Z02DGb/prterygY3D4VXbBKnI+av7PXGvD43YtRHjK/KcXrLrEbM2l
 o/IYHg3QIFoIiQRIJyptrn0kufS197CsR36593B2TMgPq0nSIJrV2+HrpaG2vO1Hg9rm
 6orxCG+ViQy+hv3JiQDRGniFFuBSj34W7IQw9zKfFPjIa+suTDBudYZ+skFqoeSFpf/w
 upww==
X-Gm-Message-State: AOJu0Yw9BBTZIqmxoVRPZM7P0RtBNKvqdxQVMlVnO+BFqX9m5CfzKpCL
 1JZ0ga01e0L0NkTV3gWJj/6tSf30f2wJgWVdhR08a/r2DMTnyS27AKzaixE1q7iuawsRcy1jOOC
 E
X-Google-Smtp-Source: AGHT+IFOaqjAwPBmlD6YU9fo4KjEISVzkMtIp0Qnto8csCne1HsV3N4JkONO8/LffGRPas0OfZgARw==
X-Received: by 2002:a17:902:ec88:b0:1dd:918d:33b5 with SMTP id
 x8-20020a170902ec8800b001dd918d33b5mr935286plg.64.1710439064275; 
 Thu, 14 Mar 2024 10:57:44 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a170902c94700b001db717d2dbbsm1991776pla.210.2024.03.14.10.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:57:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for 9.0 v15 10/10] target/riscv/vector_helper.c: optimize
 loops in ldst helpers
Date: Thu, 14 Mar 2024 14:57:04 -0300
Message-ID: <20240314175704.478276-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314175704.478276-1-dbarboza@ventanamicro.com>
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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
index 63a1083f03..fa139040f8 100644
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
2.44.0


