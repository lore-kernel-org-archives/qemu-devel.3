Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BEDC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuD3-0006Dw-7O; Wed, 21 Feb 2024 16:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuCi-0005a1-9X
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:32:36 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuCR-0004T2-R3
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:32:36 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d8da50bffaso37160575ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708551137; x=1709155937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcNFT1PFZaOBecPCJAxz5rBCgAHoej/Vx9VoGAU8rlY=;
 b=J3dyc+nDQiFjlv4EG5wVj96PvZtGQYWYoQGaXnlPIqLek0bhaWOHgZpOKMAZwtAN8O
 68u/6Nxm4V4tPMeyS9D98PGkPHH+U+AUAFEExA0XN3GdZjk53hCqlzxZRd4ZbUVRPvph
 wJ6mnVar8EaWctu+Bh4nleJq7hRaWIy5FmZBcGew9tls8tEdZwFvUjj++CxYZguIeJgG
 EIE11MdH5pBYpQ/zFE60cE5MVsxHmSbY8rjRL9saWi53a5A4Qbmg1mInuPwK1iPHaMYP
 uGnrKCgXC+e9bL5a2wOpGZCZU52GBe/B6ZW6AwA8MUUYIb1y6sPI62s2W2bHIujZ23AH
 6/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708551137; x=1709155937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcNFT1PFZaOBecPCJAxz5rBCgAHoej/Vx9VoGAU8rlY=;
 b=fdfXopyTmkMcsRPf6GlmeOjP00AyFkTETVHtGdErhnOKpZ+z/AA7FS1MBvPoreBFYB
 lu6h7jR6+Y02br+L4g7oozBsmrKdK5rMxrD2ocTMZAEPlEXCmWm9Ld+8Iq2vo+0r49mD
 xsVB7VWsACk/Zt7H6IXPFuPkHp+2dAdS1jl2gWVLiaFaQ16UAd3cgnQM/wfTetMt3uHR
 0Bn1xpPHeLtsppcEVhgTsHjYAbl7LCWlXOr+X2jawX/S7PoxG9qPEtoM2dG7D8AQ6hMN
 VOeG2xJC/M6MKB0mizrSNWte0WNPxSHSUGtNxrC3BsV5DkxthH6389R6GPTSZOky13In
 L62g==
X-Gm-Message-State: AOJu0YzANXoQ+cshVbebxFrWxN7qTnx+qv0DV4Hhxqt7EGsRpWfTz7ra
 g60hDGMvPg42NMv7ZVWauHFLDX7YByBMb/cbMP+e/8kCVzFfsSvU8ytg5rBOxvL8Hw8sldQjAgU
 b
X-Google-Smtp-Source: AGHT+IE0oMFdIC3eLKXokwWfVNq5dZ9HKw4GFmS2SCD54KbIiXJUD7T1j+2gZZNRg1tn/Q4SbZsFDQ==
X-Received: by 2002:a17:902:dac4:b0:1db:f033:9f95 with SMTP id
 q4-20020a170902dac400b001dbf0339f95mr12181083plx.66.1708551137663; 
 Wed, 21 Feb 2024 13:32:17 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a170902ee9300b001dbb0348733sm6618051pld.67.2024.02.21.13.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 13:32:17 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 9/9] target/riscv/vector_helper.c: optimize loops in ldst
 helpers
Date: Wed, 21 Feb 2024 18:31:40 -0300
Message-ID: <20240221213140.365232-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221213140.365232-1-dbarboza@ventanamicro.com>
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


