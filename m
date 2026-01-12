Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ED4CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQly-0003Cl-BF; Mon, 12 Jan 2026 17:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlV-0002aV-6I
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:02 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlT-0003AR-Ng
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47755de027eso39933785e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258318; x=1768863118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+FzeQClZlZxqBEDCUrHi/1/FywkHN35PTmkxEs1yo3k=;
 b=aI6Wo6oEOZP31GRi9SdxJsovUWejuwsSmqGRwBAUoXrN/wqMwQ0YI+hxBW2efXaMxH
 ujvkQr+XFMrbdgwN389AGdOgNEqgdT0ckVxx+5eky4ZnD3ns9qmJoZR/ZJ1glM+Qqto1
 q2QrtUfNWTt3L1ObTW7UZDxTC4Qksq6riY8oNv/tnqAxqKpflW4QqjV3102GNlZSwmM1
 WIKtpXT6nQmUVh2q+VKxylcEB8QeWNbfAszFhCTHyb7FAd9aRtmK9b4I36s4teYkeOL4
 LFJF4ZHMLo2Iw3GN8ArwlYintPBo2kpI6OZ528Tpu4QX10f0KoUKUknOFyUjgYXingso
 NGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258318; x=1768863118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+FzeQClZlZxqBEDCUrHi/1/FywkHN35PTmkxEs1yo3k=;
 b=lVue9xisoDY1IFHlxQo690AAImRdnFOMb1H31A7Jphx1+XCSa4Z0svKtCzNTEPyC39
 z7C9VSn6NTB/an4OKUFRZTsyVtXAzL040EXg5EyoBmrQX2RyzVqaDFar75+J2ZyZIFXi
 gXa/z6G0ucTmDYIbUPaZEXT+fJuu2mH9cj6kTix092iA3xfQruAM8TZvMTfdGrM3Cec5
 1IHBiklV+cWm2uEKnLyM5uFouO3LHjtMU4QEl/MrckexlbE7pvfkmlHTLJHeD4N65jBt
 CUm8KVAm5lp24TH2lkVZX0IGVwdzhBBNzZZXvBfdfv4Fnlgn+HG295um0rAbKZlZe/Mn
 bViA==
X-Gm-Message-State: AOJu0Yxk1smvGrwJqakqZNOp5ZPWkWMbjE27oEL0KE/dVWw/a2jRX4F1
 jQfCAzXUu/iLqWWYU71o5bg5vQuZmZhsG0lgets2nvbQR+BEzut3oDZw9V/7H/4f30efPMJnz70
 fzR+lnbo=
X-Gm-Gg: AY/fxX79Yhpxr7WgO8Bw+GscWNXUD89gowcPmHhPj2a84jTwusCp5Jblxtzo8irpFMI
 Q4wLl7vaXOpdNoFXUn6WicEVb3373qy5BM3Hz4e5OB0eQLE0HNN3vFoDHOCLbOma5dxFl9RxnuK
 6igCtX8RwGZg093WVOtDGyegn7+8HDCAsdaPB8NS2bOarxCdYJZ/KFAsHHqNWUFtQpWEUg+CSrI
 ihq47NJS6UnLLFuYRj8dQWoGGwubkpQ1qMxG5PQLdil9mSNlp5TJb8ophAqHWkUJiyfVf2yGTC9
 0D+8bV2SUMdLuen3u7SrRjqZv4RQxzlgWakNJ/ondBcRF4QiikzRlX4T/FNzg1D48HEKZsD5BY2
 RbiMZ+xsXwVMVWacPNmBwMzcnJvnUz4pLnoa6ajZUx313vk0tFDLp0hBqckkMOnaNhLLwsrfVS8
 5P7zybPlmb+xKgN/6A80LCbqmKTUF89YezUFocA0wjw2ntyY3zTze7045a7R7v
X-Google-Smtp-Source: AGHT+IHZ3MVqdaCRTWN5OY+dPSLJDm3hizByCfXrXOdCT1mB8cr1whac5Aq/Xh7HLicx+AtfVm41sw==
X-Received: by 2002:a05:600c:1d0a:b0:477:8b77:155e with SMTP id
 5b1f17b1804b1-47d84b17b55mr228576345e9.15.1768258317837; 
 Mon, 12 Jan 2026 14:51:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm370657895e9.0.2026.01.12.14.51.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:51:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/61] target/loongarch: Replace target_ulong -> uint64_t for
 DMW and TLBRBADV
Date: Mon, 12 Jan 2026 23:48:21 +0100
Message-ID: <20260112224857.42068-27-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Direct Mapping Configuration Window and Bad Virtual
Address CSR registers are declared as uint64_t since their
introduction in commit 398cecb9c3e ("target/loongarch: Add
CSRs definition"):

 296 typedef struct CPUArchState {
 ...
 345     uint64_t CSR_TLBRBADV;
 ...
 359     uint64_t CSR_DMW[4];
 ...
 385 } CPULoongArchState;

Use the proper uint64_t type instead of target_ulong
(which would otherwise be truncated on 32-bit builds).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20251224161456.89707-3-philmd@linaro.org>
---
 target/loongarch/cpu_helper.c     | 2 +-
 target/loongarch/tcg/tlb_helper.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index a6eba4f4160..4864f4d6d87 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -289,7 +289,7 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
     return TLBRET_NOMATCH;
 }
 
-static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, target_ulong dmw)
+static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
 {
     if (is_la64(env)) {
         return va & TARGET_VIRT_MASK;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 01e0a27f0bd..873a0a1b0c4 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -690,7 +690,8 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           uint32_t level, uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong badvaddr, index, phys;
+    uint64_t badvaddr;
+    target_ulong index, phys;
     uint64_t dir_base, dir_width;
 
     if (unlikely((level == 0) || (level > 4))) {
@@ -725,7 +726,8 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
                   uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, badv;
+    target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1;
+    uint64_t badv;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
     uint64_t dir_base, dir_width;
-- 
2.52.0


