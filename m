Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CF2CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJT-0001Xu-Ie; Wed, 09 Oct 2024 11:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJP-0001Vr-Jo
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:15 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJO-0007zK-6V
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71e02249621so2639004b3a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486553; x=1729091353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1IdMwosD6leRGtbjgClZZbwFAyeLDeJepvMUUdOag90=;
 b=P5mBGekxJAShpgrYOZwOlo24GEgTTRdqRmipUJ10X8fPMdyST9dS6PvEi2S+msamKN
 vys6yJLi74JkWQxToFjC+ZSfAegayr3LMctdx0ClV06VAP0FkmuAYH1dj38juR7TUfje
 WW+xR9koHSFGzeEV3jaq/60iqwlF8vcCpqUAfyiAEECjXKqaDPARDeQ3LJT5pkl93sFJ
 N/YfmHuj7FgsldxFqAsMcZLdj0Csp7zas44almQyu/vo4/8H3RHvRHQYMc8oZv3rPiWx
 bWCr6Y1GZIn0SJx3AvIo1uj+LQp5E8iZ/h8Pz4Do1vE+xm2fhuUDUZJQXikTkkeCKeHE
 udcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486553; x=1729091353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IdMwosD6leRGtbjgClZZbwFAyeLDeJepvMUUdOag90=;
 b=ToCxgVkxp+kyaDfHCkGpzWoOTsv1aJVKVYtaiOI79GfiVi9qUem17ARNAKI/OKo6Bf
 ADCGvaw6N9Do+rNRS4trKkW6FrpYRkbLSOdqKiotMi0NumTXOxo5sqWKXCfJ9iOIv32P
 gJDtOwJ32wv8yQaGPskKsPwEzMboD/xBSUazawWShbrfxm+TyhKRCLT6yl6zzoS/WslE
 cew2ibtJtaVkMjxbY7xVMql/4/UyEIbnQLsRWtC4HcgK0LEP1NY5DqSt84apMrpCZUpn
 4ZzpX4ggDuUQ2Ur7eZJ46YgrUmHpJF3ctFT0z91ENzz5VrTTmp/RWXLQVZCyeYfhPExw
 GFaA==
X-Gm-Message-State: AOJu0YyK431e4VuJDfy3/Wg4bagyBDj/Qz6eK2nRB9SrBwi0JWr2Onw8
 tomZ2mW2bsX/ceWJVhICFVM+8K7z4aS+Bb4EZXQbTPo48hD6qW37JG1cDmhjxSwp2Nnl/42YC8l
 x
X-Google-Smtp-Source: AGHT+IE7uJxB0FQ4p3NYLi3j24Qz3X6/nR03VhvG1LnABb98FbXBC6GSs4eziwPZ+JZT28KFRlXlYw==
X-Received: by 2002:a05:6a00:1749:b0:71e:148c:4611 with SMTP id
 d2e1a72fcca58-71e1db6488amr4462318b3a.6.1728486552723; 
 Wed, 09 Oct 2024 08:09:12 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/23] accel/tcg: Call cpu_ld*_code_mmu from cpu_ld*_code
Date: Wed,  9 Oct 2024 08:08:50 -0700
Message-ID: <20241009150855.804605-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Ensure a common entry point for all code lookups.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 59ee766d51..61daa89e06 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2954,28 +2954,28 @@ uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
     MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
-    return do_ld1_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
+    return cpu_ldb_code_mmu(env, addr, oi, 0);
 }
 
 uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
     MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
-    return do_ld2_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
+    return cpu_ldw_code_mmu(env, addr, oi, 0);
 }
 
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
     MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
-    return do_ld4_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
+    return cpu_ldl_code_mmu(env, addr, oi, 0);
 }
 
 uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
 {
     CPUState *cs = env_cpu(env);
     MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
-    return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
+    return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
 
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
-- 
2.43.0


