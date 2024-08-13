Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F335EC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy41-0006fM-F6; Tue, 13 Aug 2024 16:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3i-0005Ec-65
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3Q-0006Cm-V6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:23:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-369c609d0c7so4092783f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580618; x=1724185418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQP4Lzk083fG8NuJjpSlR+Yr0hOmETRemBesxY0PRmM=;
 b=CzjgfNnbYHCIOpoA/Ftz4i9TGBf1cfgKz54loszxSewxjiqPeRQucXty21leKYBVZK
 lxWORObsi19p71RfcC0LW9vLeigigqQ4lajmQ+rTf8NlDe285Mkgro08DylaQgzbgeoI
 hi64YuzxJorVj0njqh2BEyLf4aNDkpLjnaco4AwAzIO36gzKyib+7c59sbv2wxLr+PDs
 F7gmjlGij6TBLSJ0bPvBd95hkfQ53Lk7tuJHmdyX5OB5x+KBp7ioW559dDaCoyDdWxOb
 MCiEtSsYW+fNfDufeOZf+hPtEzuEi+7+GmWIEfoGCZEJmFUSh4zgw8v+xelTFJhAQXbt
 z7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580618; x=1724185418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQP4Lzk083fG8NuJjpSlR+Yr0hOmETRemBesxY0PRmM=;
 b=YSVCb/HZuhf7CF8D3DwlZxnsH0f8QCqqOwzwOVjClNa0SErcC6+S8Supc+RJ6HQorx
 EX4nrOYiXadOXOgu2tymtmgKIG50ParrqKZkWUsuTFqu5dKPZ2sr4io7G3caUc9DyCTb
 VixxUMuuDWyd0XQ20REk5OhVdsl0LJcTghaOXUNeG/Nj4rK44/B1j/cEU6WknHv/hWQ8
 8dLYaycXi2tmApgZkNiZtyTZJaMUkrG3nA2JtE5sgj4qFFku0C4etETw0GyxfKflJ1V4
 Ot5LKAQ3FP2LHLhD0HqHluBrWt+ctHCeMcwCLmWO2aRRkToVom1GeyhCr3+3pEilswqb
 BdFg==
X-Gm-Message-State: AOJu0Yzf3BhC/Pf9H55Q3mZGi0JOxcKQWXpuOO6uYdcYRmkZGAJNy/HE
 oNS6ad/bvnWhjOjpeHS4JHYT5ziZYMol9Bad+Pr1sQJ6EwFF77LS5YWkv8OlYSI=
X-Google-Smtp-Source: AGHT+IHzSVZu+eoV4IOl+Tvr1lbYuHvjj8m1fFN5cAonIC+bSJbWWIMBMcpgf+Pbo9r5SqehpOJ7BA==
X-Received: by 2002:a05:6000:e04:b0:36b:3563:15f4 with SMTP id
 ffacd0b85a97d-371777fefe0mr508243f8f.56.1723580617457; 
 Tue, 13 Aug 2024 13:23:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4e51ed16sm11208371f8f.66.2024.08.13.13.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0CFC95F9DA;
 Tue, 13 Aug 2024 21:23:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 07/21] target/i386: allow access_ptr to force slow path on
 failed probe
Date: Tue, 13 Aug 2024 21:23:15 +0100
Message-Id: <20240813202329.1237572-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

When we are using TCG plugin memory callbacks probe_access_internal
will return TLB_MMIO to force the slow path for memory access. This
results in probe_access returning NULL but the x86 access_ptr function
happily accepts an empty haddr resulting in segfault hilarity.

Check for an empty haddr to prevent the segfault and enable plugins to
track all the memory operations for the x86 save/restore helpers. As
we also want to run the slow path when instrumenting *-user we should
also not have the short cutting test_ptr macro.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2489
Fixes: 6d03226b42 (plugins: force slow path when plugins instrument memory ops)
Reviewed-by: Alexandre Iooss <erdnaxe@crans.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240807160236.2478459-1-alex.bennee@linaro.org>

---
v2
  - add comment around haddr1 test
  - drop test_ptr macro
---
 target/i386/tcg/access.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
index 56a1181ea5..e68b73a24b 100644
--- a/target/i386/tcg/access.c
+++ b/target/i386/tcg/access.c
@@ -58,6 +58,11 @@ static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
 
     assert(addr >= ac->vaddr);
 
+    /* No haddr means probe_access wants to force slow path */
+    if (!ac->haddr1) {
+        return NULL;
+    }
+
 #ifdef CONFIG_USER_ONLY
     assert(offset <= ac->size1 - len);
     return ac->haddr1 + offset;
@@ -78,17 +83,11 @@ static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
 #endif
 }
 
-#ifdef CONFIG_USER_ONLY
-# define test_ptr(p)  true
-#else
-# define test_ptr(p)  likely(p)
-#endif
-
 uint8_t access_ldb(X86Access *ac, vaddr addr)
 {
     void *p = access_ptr(ac, addr, sizeof(uint8_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         return ldub_p(p);
     }
     return cpu_ldub_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
@@ -98,7 +97,7 @@ uint16_t access_ldw(X86Access *ac, vaddr addr)
 {
     void *p = access_ptr(ac, addr, sizeof(uint16_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         return lduw_le_p(p);
     }
     return cpu_lduw_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
@@ -108,7 +107,7 @@ uint32_t access_ldl(X86Access *ac, vaddr addr)
 {
     void *p = access_ptr(ac, addr, sizeof(uint32_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         return ldl_le_p(p);
     }
     return cpu_ldl_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
@@ -118,7 +117,7 @@ uint64_t access_ldq(X86Access *ac, vaddr addr)
 {
     void *p = access_ptr(ac, addr, sizeof(uint64_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         return ldq_le_p(p);
     }
     return cpu_ldq_le_mmuidx_ra(ac->env, addr, ac->mmu_idx, ac->ra);
@@ -128,7 +127,7 @@ void access_stb(X86Access *ac, vaddr addr, uint8_t val)
 {
     void *p = access_ptr(ac, addr, sizeof(uint8_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         stb_p(p, val);
     } else {
         cpu_stb_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
@@ -139,7 +138,7 @@ void access_stw(X86Access *ac, vaddr addr, uint16_t val)
 {
     void *p = access_ptr(ac, addr, sizeof(uint16_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         stw_le_p(p, val);
     } else {
         cpu_stw_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
@@ -150,7 +149,7 @@ void access_stl(X86Access *ac, vaddr addr, uint32_t val)
 {
     void *p = access_ptr(ac, addr, sizeof(uint32_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         stl_le_p(p, val);
     } else {
         cpu_stl_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
@@ -161,7 +160,7 @@ void access_stq(X86Access *ac, vaddr addr, uint64_t val)
 {
     void *p = access_ptr(ac, addr, sizeof(uint64_t));
 
-    if (test_ptr(p)) {
+    if (likely(p)) {
         stq_le_p(p, val);
     } else {
         cpu_stq_le_mmuidx_ra(ac->env, addr, val, ac->mmu_idx, ac->ra);
-- 
2.39.2


