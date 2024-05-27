Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63DBC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 03:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQp9-000672-ND; Sun, 26 May 2024 23:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sBQp7-00066W-QK
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:14:57 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1sBQov-0004G1-Q0
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:14:57 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5b9817a135aso805925eaf.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 20:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1716779678; x=1717384478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kdfKBWYgXkwQbXE4PNGLBClW49IP35uOBMWtBZKXUP0=;
 b=ZqrKpOpVKWys1hHn1E4rLJXQV2DO2aJx96BWKpm/YcgpgxxGfYLOYo6lT1gYmsqsWo
 VhJPueh96E0R+M3Gnqgnmup9QL1goWVMQ8Ryw1CN1Sor4gH5fRmMBRQhxn4sR3aWGqiw
 0MthLncNDwG4sUAvvYsrTSzgovYllvhHu2NqUg9mpPt0GPoyigrLyFbpObus4tb0BWKJ
 efaQvEdgzjwJ9q/WRg1RxcMiAKXS/2AmOSkPKCVG8qbL9GU9mgoA9KbDEr72xVoWydYE
 ftFMeTccvcipgp9FVCne8AdsQRtQxJSgNhMZ49kjnzRW2IqHu6WFD/JxTvPTPkPUTEMJ
 qPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716779678; x=1717384478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdfKBWYgXkwQbXE4PNGLBClW49IP35uOBMWtBZKXUP0=;
 b=toN42gNWH3I6bbzXbzNf1WiNl1XuOx6GFzUWiG91Tbo7zHmnu9mt1dGf/PRX5ZLFVT
 +/iC0cRfweVcEThHohRfdSC2h/f2T7A9RUoievTjMQk9+KcCJ51J/rliRyapXJdVaQO4
 MBoGzlSyGflUCGtV2OJ/xDvOKBQ2zTiX/vFq2pC7pLwbZQL53r38DjvXLTVpsS4TpeD+
 NeePgr1NRR3sEaHi3o4rqkp3c2OAa1lQi6jKrBdDTnDHOvIsQoLZoH4wPBRzoNAevF1h
 +nf74jSAHHMG3hSkuWj/HV14wHDKeKuvP4eikYDmMs7VQV4EtunoxQe7yLuEUXfDu3Fy
 sbNw==
X-Gm-Message-State: AOJu0YwF3D57CoTG86SIDKvkCjQeTrKInw9I3qqYw9767UNayJkeHalE
 SkH5rvVjccC2/Fsf/wCmhhbHj1IJAQ1jQKAVHg3xuRaDauFf94YfJQBb/4Dp1ZoR9wycE5cKHjp
 M
X-Google-Smtp-Source: AGHT+IGRhHTXc+LsEodxhXEnl0n2mVHStpAYEdHBYnH4/b9WIzHSstOhRzB7Mi/OcV05D8hI5YaNrQ==
X-Received: by 2002:a05:6870:7195:b0:24f:d4b4:698f with SMTP id
 586e51a60fabf-24fd4b49812mr6594428fac.1.1716779678674; 
 Sun, 26 May 2024 20:14:38 -0700 (PDT)
Received: from MacBook-Pro-2.local.bytedance.net ([203.208.167.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dd5dsm4035662b3a.42.2024.05.26.20.14.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 26 May 2024 20:14:38 -0700 (PDT)
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xieyongji@bytedance.com,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH] x86: cpu: fixup number of addressable IDs for processor cores
 in the physical package
Date: Mon, 27 May 2024 11:13:33 +0800
Message-Id: <20240527031333.85932-1-xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When QEMU is started with:
-cpu host,host-cache-info=on,l3-cache=off \
-smp 2,sockets=1,dies=1,cores=1,threads=2
Guest can't acquire maximum number of addressable IDs for processor cores in
the physical package from CPUID[04H].

This bug was introduced in commit d7caf13b5fcf742e5680c1d3448ba070fc811644.
Fix it by changing the judgement condition to a >= 1.

Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cd16cb893d..0369c01153 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6097,7 +6097,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             if (*eax & 31) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
                 int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
-                if (cs->nr_cores > 1) {
+                if (cs->nr_cores >= 1) {
                     *eax &= ~0xFC000000;
                     *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
                 }
-- 
2.20.1


