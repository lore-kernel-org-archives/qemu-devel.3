Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E32ACCD1A5
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 13:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squaD-0004fV-9E; Wed, 18 Sep 2024 09:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1squaA-0004XN-OJ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:18:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1squa8-0005Vz-NU
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:18:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2055136b612so84582345ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1726665534; x=1727270334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nUSGCu4AkUfHxrvYixPgCsiLMuPBrCq73vnsoiuSJT8=;
 b=Q2GYBR4OZ3fX1E75XpI9QuAj/LXJzxbV6r1hGQ0F7R0WzAXB6mIoLRlefBNQHV5WGe
 hpHV+x+r1PkR5EO4jA7FbbF+H89x4VOm2o0QfR9ItG6Y7ginbNw0S1q7iMA9XzzYi0ae
 XoWSUwyY2w1WMkje+u00/uiF/Kbm9niV6kJPShNM3CQB9NDiAXxRJCO36FWxhgIPUQ80
 nPYrWsiuxCBdww9DOQCNDsgLMQoon8mcgw8CelQyp4mS95oUsQtKqHUCLZTA6fEGvMur
 0W3BZOhDS26HRRa0bFkn5CzM0qDN1hYb4OfyaYfHZL6GnWOknF2j7h1y5elM1K/mF6Fj
 6KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726665534; x=1727270334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nUSGCu4AkUfHxrvYixPgCsiLMuPBrCq73vnsoiuSJT8=;
 b=IdF9MyaRdgGU5TywmjqUs5XYUNKUGkwnDzplAJIzCD2zxIHhaE/YIaRuRiyuX8IRX9
 ipM+/BS2UAeAu1rXgHBQfQ1/uVq72ZE2ihP8jQnxrmXuYi9oLjFuHgcZLDIp6mV4mrve
 hRqn4JRY4PO3/+M0VD3N1jzehPAwjCtaehlr6GwoA4ooHsRsKxbhFldP39fmnagA1cWK
 SVmmB7xWXC90CFUiQhJ3kVIDs6LS8xe1dCeWvOjmCkttZrxySoWpxPNZ910eRJwMI1NA
 SIh++fS4z05MPU3VSNnRxl8UvgpA7G4rtCNvfdySGMqF8y5MgyZiBS0ucFTA3cYCkRIZ
 ckqw==
X-Gm-Message-State: AOJu0YyZ1qVT3yVr6h0sd6Hgc0tbGHdNZCbel5I7LgTHxyxMl3pE0t7m
 PBmKxfyiBnokOE+sx9vt9VeWm5CzgioPsBxtoEkdqwc9ckuk9jvJpQHcKaFNjYOl4jBfYSv1ZwV
 e
X-Google-Smtp-Source: AGHT+IFWlaF6QYx/ym/ZioEVaIlulSc70T3DHyRDVlNteT+IhaWqmxEeqXGzNeRaWrhjrBm2smAEag==
X-Received: by 2002:a17:902:c64c:b0:207:457f:b8f0 with SMTP id
 d9443c01a7336-2076e36f86amr238412695ad.27.1726665534558; 
 Wed, 18 Sep 2024 06:18:54 -0700 (PDT)
Received: from MacBook-Pro-2.local.bytedance.net ([203.208.167.148])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946d3c8bsm64479485ad.126.2024.09.18.06.18.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Sep 2024 06:18:54 -0700 (PDT)
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH v3] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Date: Wed, 18 Sep 2024 21:18:15 +0800
Message-Id: <20240918131815.8543-1-xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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

When QEMU is started with:
-cpu host,migratable=on,host-cache-info=on,l3-cache=off
-smp 180,sockets=2,dies=1,cores=45,threads=2

Try to execute "cpuid -1 -l 1 -r" in guest, we'll obtain a value of 90 for
CPUID.01H.EBX[23:16], while the expected value is 128. And Try to
execute "cpuid -1 -l 4 -r" in guest, we'll obtain a value of 63 for
CPUID.04H.EAX[31:26] as expected.

As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
integer too. Otherwise we may encounter unexpected results in guest.

For example, when QEMU is started with CLI above and xtopology is disabled,
guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
as the result, even though theads-per-core should actually be 2.

So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
to solve the unexpected result.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4c2e6f3a71..3710ae5283 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6417,7 +6417,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            *ebx |= pow2ceil(threads_per_pkg) << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
-- 
2.20.1


