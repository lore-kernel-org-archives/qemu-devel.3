Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DB2C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPh-00075w-LF; Tue, 22 Apr 2025 15:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLr-00016L-Qd
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLp-0006gY-Hi
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:15 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224100e9a5cso66545125ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350332; x=1745955132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwX79sAas1p4NfMgvATwyqCc393tpLGILDciw+NSDio=;
 b=ukDBbp0v8H7k/OYeSns6jMTKXHvUyd7oHY+n7gxr9/cPrUvYxDUgEYnyQ7gzrxvkL4
 d3bCadTyWHo5J5XPu7o0DR4LJW51WePhFooG0OergRS2hNufddk57Xuj8dC77THMOBlJ
 UMALB0tneUeQKdhQCXwwTDOvGrxIj+/r3J8bQEMh+e/az3K+NRO2F6qfQY9xYKdzyKFQ
 XNJNp9xSg/cg55TZNyic7NrAwuzhf4A2ro2ErJzjfIwiW4MsLyvEEhj23aCdoxZj+RSn
 FMriebaS2CT6FPO7Qx99PBbKlMdyqYJ2LsIdClf4+Q5x9lb0rAt8/f+uEvYjZbAdRggX
 ETNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350332; x=1745955132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwX79sAas1p4NfMgvATwyqCc393tpLGILDciw+NSDio=;
 b=c5W1jr7dQsF0L/Isi0nyJatKMKwBrdogkQQpcYXN1qVbrbARcvqgs2/4M68cOsADfq
 R+m2nBVxTWHkdJvp1DyYK5jD12rhDt8fAPL6Ktb4HqyCT/sVIlA2Z+SwTT5tprnlAWrO
 8wZBUl32tbMZox+7AHFLsg0YKj4MA18QYX52Gd5dpg/HoxtfRv0EI7wzcS2jLHla6pdZ
 zr+pwBlzw7n2IHnaHp3xWeya+BwOQG0XD2k5omjSIyLhL5U4UvSv6425Ac5pgdNCmcg7
 kP0Fs/0xJYU9EHHhGENpG7elXZ3OncSKnrwz5/Jz8d1N7vSFRPtg6h3nov7KIAzI+G7Y
 KQxg==
X-Gm-Message-State: AOJu0YwyK+m4ximhPdPdlpmk66FYq8g2AkGPBelPyOFd0NYiy9sw2eeY
 OrHkWjHnUYnePWzoC0Bf56tmW3em96lnTTP67xSSdlt2/3bQvxIHkosBWDBsGlUB1SzrIEGj0l1
 S
X-Gm-Gg: ASbGncu2azR/nyoQLzUI7xLHGIGiltNmBmHKULmYXubFKlxTAVz9FWoAkHTOaIE4Vvc
 wqI+MZr8q8L3d5g54MxiXk++4+sKKg+mYj4oq4EEmpqk8nbllwiihGXWqOgYZhJoZLr2KyOZw53
 4pROQ9+BpH+jHJ5xbzmXYxvzb/HBvUqXVgKdqu5cJjDegH8Cu83C66q2rmJaZUJSShG1eqVSxfX
 7mWJS96dd1dI0J4y7UXnNk5R1Stv2rhuVv7lvFFIK0XC6Ef9Kdt2n0Z5vyBZNdQxz8Obtw5mSkc
 K/ZYEGm3//h/cW/ylYVEdMNiiL/elde7iLfmqCnwhzOUfPiAVDrcM211aZ8FLaWmZvoESdyxhcE
 1EqlB2ykDsQ==
X-Google-Smtp-Source: AGHT+IG0RF2vsO8bH3i7lZXB4mZrCCIlQN1eS7tpZxKzFh6qQUjui7lnKj9wbeJ4t7Ds7sGKN6lspg==
X-Received: by 2002:a17:903:244a:b0:21f:988d:5758 with SMTP id
 d9443c01a7336-22c536011bemr283625955ad.35.1745350331768; 
 Tue, 22 Apr 2025 12:32:11 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 078/147] target/i386: Remove unused cpu_(ldub,
 stb)_kernel macros
Date: Tue, 22 Apr 2025 12:27:07 -0700
Message-ID: <20250422192819.302784-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-8-philmd@linaro.org>
---
 target/i386/tcg/seg_helper.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/tcg/seg_helper.h b/target/i386/tcg/seg_helper.h
index ebf1035277..6b8606cd6d 100644
--- a/target/i386/tcg/seg_helper.h
+++ b/target/i386/tcg/seg_helper.h
@@ -35,8 +35,6 @@
  * TODO: Convert callers to compute cpu_mmu_index_kernel once
  * and use *_mmuidx_ra directly.
  */
-#define cpu_ldub_kernel_ra(e, p, r) \
-    cpu_ldub_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_lduw_kernel_ra(e, p, r) \
     cpu_lduw_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_ldl_kernel_ra(e, p, r) \
@@ -44,8 +42,6 @@
 #define cpu_ldq_kernel_ra(e, p, r) \
     cpu_ldq_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 
-#define cpu_stb_kernel_ra(e, p, v, r) \
-    cpu_stb_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stw_kernel_ra(e, p, v, r) \
     cpu_stw_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stl_kernel_ra(e, p, v, r) \
@@ -53,12 +49,10 @@
 #define cpu_stq_kernel_ra(e, p, v, r) \
     cpu_stq_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 
-#define cpu_ldub_kernel(e, p)    cpu_ldub_kernel_ra(e, p, 0)
 #define cpu_lduw_kernel(e, p)    cpu_lduw_kernel_ra(e, p, 0)
 #define cpu_ldl_kernel(e, p)     cpu_ldl_kernel_ra(e, p, 0)
 #define cpu_ldq_kernel(e, p)     cpu_ldq_kernel_ra(e, p, 0)
 
-#define cpu_stb_kernel(e, p, v)  cpu_stb_kernel_ra(e, p, v, 0)
 #define cpu_stw_kernel(e, p, v)  cpu_stw_kernel_ra(e, p, v, 0)
 #define cpu_stl_kernel(e, p, v)  cpu_stl_kernel_ra(e, p, v, 0)
 #define cpu_stq_kernel(e, p, v)  cpu_stq_kernel_ra(e, p, v, 0)
-- 
2.43.0


