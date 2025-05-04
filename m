Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53A0C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgP1-0008S8-RJ; Sun, 04 May 2025 16:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOv-0008P5-UI
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:31 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOr-0006xF-Kf
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:28 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af52a624283so3180013a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392243; x=1746997043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9IAKV9LJlCW9c1xiMOYV7AbY7Z625Fdb9+xsHG0s8M=;
 b=cwM6W7K3No4yWVxfAaZAq4Pds8jmeTkdO2f+d0KlYDcfk+4B+KfE6aTkFtYoj3U9Xn
 0EB5GT1RyLSQLK6z6evzGViN8/34k3eSslNbWGgqrrDL4Ls0fXzNOwRKFlv6poKX25fH
 vyDwY+kOqhsoUcrjLWVSA+0rb5EM+8Rhe8Ye52UVppvHx91qC7a5KJgt8u0XC64BboxK
 Wd9RYi1cp+HvxKlJT4be7SPjHUDw4QMuo9h8MYL964ECA0pFKTvcOY54DgJkV6g/6SAx
 hpzTRWekgcZf6SE/Z7sSm/Usz3rL6xCs5JlT3iqfJi0zfLtzirUBL79hfBOfQE08YmG0
 aAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392243; x=1746997043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l9IAKV9LJlCW9c1xiMOYV7AbY7Z625Fdb9+xsHG0s8M=;
 b=pQEdr4CAQ28kT6haxnDsUgsyQM85Q6O7qFNcQuNG3ww+MCzndolW9DJHpmN4rHfdLk
 OhDh6lXuQvVBQKLNa7MVh5WA1tlFM71k0X1Nc+oI5U7/9OmngfwYfow96ocjhM2lA5EC
 GT9KXAsh38EAgJGdOvU1Z9vSTvqSCThDRfwT6kLlerYo3T9Vxoi/ERyw0qKGYvRrPnDT
 0NdCrJdoWDD57m8O0kStNmnDFUBeO98qgZ+PnbC935ujL2iqMM9PY0m+PLyAjX8TvF2O
 WVnhSJvbH4wxscI33u8kCRW454m1Xia67BezMHUKcCMpEH+cf3jOeHO1HvN9WLNPKC0P
 mgDg==
X-Gm-Message-State: AOJu0Ywfbx7RZ/jPJ+gy0xsrMghUcYRMRzBbFYh0KiOXwwbX2JXQiADv
 XxlbzQ6GHcRI7ueFM5kzynZHOt7KQ1yAj7rG5QnrvzJFdjuoQtbdrKi9vwIZB//yvrIHglscloI
 G
X-Gm-Gg: ASbGncuHW5BVrHsexmN4vRteea+pY47/bmBcqUIMWIT64sjMuLSHLwwhBjLqvQX7hxg
 RJ1V1xAG3VMpYyVrf8dhYZuER4NsPg7IvSQlwV97Qgh0ZUgvWFEc4XZv9BTxFX+Rp6bxzSc6MwC
 LzMuYaKbP7hlif1wvpziTdLJIixjOknNYtw1VDBu4UhklkuDqrjCKUdSAbq5tqfepDGbHyz74Xj
 iIA5qkMb+lyktrQs//FEv2a/EOXVkjWa8Jo3h68psy6pk7ErsbeASHvcwnnVGTJVEf63h1Cw7JL
 T77OW77GopTiZuzvkGJX78buBJAEyLfXsB9zgt06dK9LkhT4yzMdiVHxCduw1qIxMEYbh944ZrE
 =
X-Google-Smtp-Source: AGHT+IGjcLDUeO+TxdL2cpp2KU0VERd2p9720NngUoGzQTQ0WkBrkMr5zIPuwkcrdyTwZSGS3p8a7Q==
X-Received: by 2002:a17:902:f0d4:b0:22e:23c1:d711 with SMTP id
 d9443c01a7336-22e23c1d7cfmr29261005ad.16.1746392243571; 
 Sun, 04 May 2025 13:57:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com,
	qemu-s390x@nongnu.org
Subject: [PATCH 10/12] target/s390x: Fill in TCGCPUOps.pointer_wrap
Date: Sun,  4 May 2025 13:57:11 -0700
Message-ID: <20250504205714.3432096-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Use the existing wrap_address function.

Cc: qemu-s390x@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 9c1158ebcc..f05ce317da 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -347,6 +347,14 @@ static TCGTBCPUState s390x_get_tb_cpu_state(CPUState *cs)
     };
 }
 
+#ifndef CONFIG_USER_ONLY
+static vaddr s390_pointer_wrap(CPUState *cs, int mmu_idx,
+                               vaddr result, vaddr base)
+{
+    return wrap_address(cpu_env(cs), result);
+}
+#endif
+
 static const TCGCPUOps s390_tcg_ops = {
     .mttcg_supported = true,
     .precise_smc = true,
@@ -367,6 +375,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .record_sigbus = s390_cpu_record_sigbus,
 #else
     .tlb_fill = s390_cpu_tlb_fill,
+    .pointer_wrap = s390_pointer_wrap,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
     .cpu_exec_halt = s390_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


