Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E676EE6B6A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTdj-0005F2-RH; Fri, 06 Feb 2026 16:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdg-0005EL-Lf
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:20 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTde-0002Zs-G3
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:19 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so2468831f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414317; x=1771019117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swGHp40DlbWr+HsCT3VkrO9DpUhRbni5rdOb5/lh39w=;
 b=Xd4doYbWG8CUXIAByrhfbkyjjl3rWkPQOIt8Fs+GT8D1IDSZPWc2fPV2KLb4cb5qpV
 hL5ObenSU5efNnWzHn89rePL0rCZzDLkXDi35F8NnfW08j1YtPx2tBakBuIiQwPnzdLp
 09csitUNeUQUsdo0UooO2CfmZrLeTAreAbnAuYhCHFibhTY7Ggu6GI0L6ucwspT9TBpL
 G+nhjehiVq8Ams+XACHIxbSvWvd65x42gMkaneAqV1IUn4j3P1lPkJnffG7mmv32bbst
 p5Gk+nVkgMe09kxXvTFoxaiIpetpud0J6DNXxJWJ1wHDvfeInUrXIKw5ldomnCXJNO1y
 FjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414317; x=1771019117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=swGHp40DlbWr+HsCT3VkrO9DpUhRbni5rdOb5/lh39w=;
 b=QQaCTLbw2GA8i9cfpDaueUYyORKjWzfboMH/I0J/3jxWaGxzPdnUP494szm9mfplUd
 caQhIJbOUCfpzVR+eYnvB/27a4L21Jp6TNmVAhfh8p3hsk3BEsilXaI/kH+IbVKKFvCV
 +HgPo2wv5ZtxZNgGy02mBTlfKJdmvT74j6nO2wCYdHPLJuArqRWkmG0rZ7fLbr5ezj93
 CsvViwFb2tTpM2+0KAfld50NIJMkmFPCBHRBJXtw6+TRoZY5SfrUX8O5D/KAIvMA5p4T
 LwFVQ5UtoAbdkGEh+yhBnks9CqXTfiAlzDp39Ot7zjyNG2chkU5D/bZM8OiXJHLY+pyF
 LwRw==
X-Gm-Message-State: AOJu0YzWhkBMDC+gF6IoFD84HYYnLvtWgVeSmeg4ksurplOUMQqHeFvv
 zREOD+2DC0XDBASINdSrTNb0FO5e47JlnvmWMYN/U9uX3uKLVH90MBPI5tCHSoExYiV7+mxokM0
 pv2gaIAg=
X-Gm-Gg: AZuq6aIzm6rVnRYACSuLNtRbVsJ9D31BaBemYVf1112CrOnb/J3t0aV8veQVVQl0qys
 ITkr4kYe36VHMuOrtkGiSrBAvCYOkLv0pFbWw4/OKwmmJ9ivrQJlpkic2YsdjtSRbJ3hJ+mMx5+
 9oUa8eY6Cgj3GYttFgc0CZjUF5TTeGGPtli94R+7/RgNYC8qtFEs84IaBaL/er9yxSWbyv0w7Nc
 /m8HeI/TgXwF289Wz8buwJLnDRrxfaYfeP+4gXsytTQBrOjWHcTTItbDcFXCVoBJQ/NTZvltWzW
 YJyjXaOeZ9O6IqpY/L+4RkGIfngCCJDizNVfGamKqJ7XIMQrpoDBU80ClrLdVpqvFHRnYDKlUBP
 YrZbhvj1wGhyS6+oAvAzThgzDmm8vaxZ0c6hPJt6FQ218hBXtZdoAjxUD8ZPI84VUIOD8gxbyyL
 hdo1LZ5K2XBBV2GLERZcD0+YvqjrlMsFAZ4lO5NyuQdSTUBuezGYxtKgYKKmZu
X-Received: by 2002:a5d:6e8b:0:b0:436:216:98d8 with SMTP id
 ffacd0b85a97d-4362933ac4emr5456888f8f.12.1770414316634; 
 Fri, 06 Feb 2026 13:45:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629664632sm8423509f8f.0.2026.02.06.13.45.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:45:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 04/30] target/s390x: Replace %target_ulong -> %vaddr where
 appropriate
Date: Fri,  6 Feb 2026 22:44:22 +0100
Message-ID: <20260206214448.22008-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the %vaddr type for virtual addresses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260206181953.18683-4-philmd@linaro.org>
---
 target/s390x/s390x-internal.h  | 3 ++-
 target/s390x/helper.c          | 2 +-
 target/s390x/mmu_helper.c      | 4 ++--
 target/s390x/tcg/excp_helper.c | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a4b54dc441c..31e164c9b5a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -10,6 +10,7 @@
 #ifndef S390X_INTERNAL_H
 #define S390X_INTERNAL_H
 
+#include "exec/vaddr.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
 
@@ -376,7 +377,7 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
 bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
 /* Special access mode only valid for mmu_translate() */
 #define MMU_S390_LRA        -1
-int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
+int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, uint64_t *tec);
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags, uint64_t *tec);
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index d0c36d4a537..5002eebd4c8 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -71,7 +71,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
 hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr v_addr)
 {
     hwaddr phys_addr;
-    target_ulong page;
+    vaddr page;
 
     page = v_addr & TARGET_PAGE_MASK;
     phys_addr = cpu_get_phys_page_debug(cs, page);
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 30f09ec3de4..39ff42da3a3 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -122,7 +122,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
     return ret == MEMTX_OK;
 }
 
-static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
+static int mmu_translate_asce(CPUS390XState *env, vaddr vaddr,
                               uint64_t asc, uint64_t asce, target_ulong *raddr,
                               int *flags)
 {
@@ -381,7 +381,7 @@ static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
  *               there is an exception to raise
  * @return       0 = success, != 0, the exception to raise
  */
-int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
+int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, uint64_t *tec)
 {
     uint64_t asce;
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 019eb4fba1f..292d130d03e 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -147,7 +147,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        bool probe, uintptr_t retaddr)
 {
     CPUS390XState *env = cpu_env(cs);
-    target_ulong vaddr, raddr;
+    vaddr vaddr;
+    target_ulong raddr;
     uint64_t asc, tec;
     int prot, excp;
 
-- 
2.52.0


