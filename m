Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E13DCF042F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCY-0004Po-1x; Tue, 08 Oct 2024 20:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCV-0004NN-Bs
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCT-0002tu-B3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b86298710so53280025ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432308; x=1729037108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I928rOfU7rFS4/uAexBKDkmn1Lv4VMSl/VKyNRV9wmg=;
 b=yc0D//L+IZ+3lFanqlfWduQKjeLINYYiwuiwituX6sA4X+IDYDVSRDQnNZYF53jvXX
 I3Ko/WLd2/QMMzIxxE72CGNXT/u/coAyHi1zsFapuB2TyPF4znfouhMxNfU+QZHfJ9d1
 sOREAS49oAFZes8T1sr8zn6rpMnKJSnmf/fdcq9n8q/1O6SdRfPq4PYoQp7TL1JEZRk/
 sYGmuW/AVtDZ1pPDcwBRg4gTgUr4ePwDvjpdLbYVqyToMqCG3IxYd1dcli0Vhs6Zd3xE
 0mx9si5SKOQZfE3BzQVvng7r6AF4oVmUOb8ZJi0cY3hdmV0Z8mG5gfygV3jmukM8aqXu
 xX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432308; x=1729037108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I928rOfU7rFS4/uAexBKDkmn1Lv4VMSl/VKyNRV9wmg=;
 b=J2sL2PgI7XuF4YMpr6KN1b+PzEyeS0ObA980d8TxTTs2YRap0iI0WA+26gVlzfRD62
 9Q/U6EXOOR0BB6FyZFw85/EKOdA2tf8y3GQgpnkclbKR5kyUvMVWpYZE6xI8a8kb/dmb
 qLXW9CcpAgAST4Ja+BOuvL/W4N+009xNwlf8dOY7oChaaSTiT5mtOBCW1vLyRVR8hHvF
 wKOm1wu16yD0/esjv5SA+osTVAFn8gkIEA79+HSeQZOvI7TlRSuYlnh23lbBE5YR2jdz
 SvZ5MJJZq6hcd+oYakKHXdkWgxHNDd++9X79NVGGH3sP+zWnFGBYvw9d60aDySYYNvJu
 rdIQ==
X-Gm-Message-State: AOJu0YwoFMcdzJcoVbWHgKbDBWwdEDaSYsJAZn+RN8qZvbbouNbSaMgC
 tF1GMewinmcjIWBx2N3NfsmdEoDjknSV3uzYGgx6bHHGISTpEOvrx+Q4yXddKJVVPC517POwHoc
 E
X-Google-Smtp-Source: AGHT+IFMRMcxUNXCHul99WM0nOEYQH8Nd6y4x6kBohzqFF7CIBlmB9qDX2IdxPxzJUxR3zV7HkR2Wg==
X-Received: by 2002:a17:902:da8d:b0:20b:7be8:8ecf with SMTP id
 d9443c01a7336-20c6379030emr10548965ad.53.1728432307943; 
 Tue, 08 Oct 2024 17:05:07 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:05:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/20] target/arm: Pass MemOp to
 get_phys_addr_with_space_nogpc
Date: Tue,  8 Oct 2024 17:04:46 -0700
Message-ID: <20241009000453.315652-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Zero is the safe do-nothing value for callers to use.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 3 ++-
 target/arm/helper.c    | 9 +++++----
 target/arm/ptw.c       | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2b16579fa5..a6088d551c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1461,6 +1461,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
  * @env: CPUARMState
  * @address: virtual address to get physical address for
  * @access_type: 0 for read, 1 for write, 2 for execute
+ * @memop: memory operation feeding this access, or 0 for none
  * @mmu_idx: MMU index indicating required translation regime
  * @space: security space for the access
  * @result: set on translation success.
@@ -1470,7 +1471,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
  * a Granule Protection Check on the resulting address.
  */
 bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
-                                    MMUAccessType access_type,
+                                    MMUAccessType access_type, MemOp memop,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
                                     ARMMMUFaultInfo *fi)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f77b40734..0a731a38e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3599,11 +3599,12 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     GetPhysAddrResult res = {};
 
     /*
-     * I_MXTJT: Granule protection checks are not performed on the final address
-     * of a successful translation.
+     * I_MXTJT: Granule protection checks are not performed on the final
+     * address of a successful translation.  This is a translation not a
+     * memory reference, so "memop = none = 0".
      */
-    ret = get_phys_addr_with_space_nogpc(env, value, access_type, mmu_idx, ss,
-                                         &res, &fi);
+    ret = get_phys_addr_with_space_nogpc(env, value, access_type, 0,
+                                         mmu_idx, ss, &res, &fi);
 
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 373095a339..9af86da597 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3559,7 +3559,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
 }
 
 bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
-                                    MMUAccessType access_type,
+                                    MMUAccessType access_type, MemOp memop,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
                                     ARMMMUFaultInfo *fi)
-- 
2.43.0


