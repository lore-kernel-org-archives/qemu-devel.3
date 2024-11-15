Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E21D68BD5
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3P8-0007Vc-UT; Fri, 15 Nov 2024 15:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P6-0007UH-3s
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:56 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P4-0004MF-5A
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:55 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-72410cc7be9so1997032b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704333; x=1732309133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7URjfhdJJgJViY9xy3HGWdoffZ4Bx5+TNtC2smFn9cA=;
 b=v8Hy9w5muerd/afaeZpO4O9jmJVNH0mG8o0/TYRNzmfiujoBYex5a9zRAJETUj16Gu
 LLgX/+9AZG0dqPG+ewSUJtyl79LSN0/MjmerAbcALvdwRxHlc1m1x89ltXCqVVaVhpDh
 zi3tQMok9PM8s4/LAzeriJJH1bM71AND2Zp5ZdFvsF7xIJ0DcI2pz3QcOS2AR+rb8sT/
 8DnFDJ6YnnouwOnckeseVu1XUQMJr2Azl1KSS8j0tWmmHeC7lYH9cRt6eovKbRgVM5hF
 kEMa/Vy6twvBylEneupoZIHikOP3ClnN1ZYX+dTc6QELw5QUQ3WJ1w+lFb3/nlRTV9HL
 X2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704333; x=1732309133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7URjfhdJJgJViY9xy3HGWdoffZ4Bx5+TNtC2smFn9cA=;
 b=Xe5FmI5ZsNw4xH8Lq0UJwB8JqEn8yK/atSOYka4ssx+sctKU7FsWWa7PXJuOMGwVk2
 FVvu1xqz8z+rrluZWMcyOZdpzXbVBWX+ZduGFd68T2mG4+D+Y5O6heyD0kf1HjiCNGvw
 4PiS26JfM0H6Qk1GTEs1KoBHFlBDsjb62DbntY75i9kx5iU4M1+L2CBYxjwQxgmIoBdw
 3nINoHq0MDH3q/sFd7KT8Pg/oeiGY1Kcb/5d1W3Nt9+FcXk4xW5df/42Xeep/YeIm9uh
 /W6DAD/i8Lg2RJY2PTbEbtBs1KfWBe4Q0/RcI7QYPnC5LcYIhlyZmTM92rmzuaZonLRv
 NU0Q==
X-Gm-Message-State: AOJu0YyYVHUMZaIpsCHQTaS8LL7iNMhosIrCRIyiOcd7sy8V0Huan4Qc
 6LI+sBjqSfRVWYYwO5h738uaQlMJeItVkCwAmMUhHt+HJherPlgDucef/smAEjgBfAJH61fX2Ab
 q
X-Google-Smtp-Source: AGHT+IGuugmg9lz3iI9zEvOz+IDioBQPoCN5tRhsAIB+TY0DesBFHUpOeoUFRwBgPuoL4DHJKaaoSg==
X-Received: by 2002:a17:90b:1d05:b0:2e9:2e69:ee10 with SMTP id
 98e67ed59e1d1-2ea1552274bmr4652293a91.19.1731704332696; 
 Fri, 15 Nov 2024 12:58:52 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:58:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/14] accel/tcg: Fix user-only probe_access_internal plugin
 check
Date: Fri, 15 Nov 2024 12:58:37 -0800
Message-ID: <20241115205849.266094-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

The acc_flag check for write should have been against PAGE_WRITE_ORG,
not PAGE_WRITE.  But it is better to combine two acc_flag checks
to a single check against access_type.  This matches the system code
in cputlb.c.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2647
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: 20241111145002.144995-1-richard.henderson@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/user-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index aa8af52cc3..06016eb030 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -800,7 +800,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
     if (guest_addr_valid_untagged(addr)) {
         int page_flags = page_get_flags(addr);
         if (page_flags & acc_flag) {
-            if ((acc_flag == PAGE_READ || acc_flag == PAGE_WRITE)
+            if (access_type != MMU_INST_FETCH
                 && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
                 return TLB_MMIO;
             }
-- 
2.43.0


