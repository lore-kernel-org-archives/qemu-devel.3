Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65767EE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOhP-0005RT-AH; Wed, 11 Sep 2024 10:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1soOfx-0007yG-4c
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:50:47 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1soOfs-0006zz-3A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:50:32 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39f4827a07aso28387295ab.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1726066226; x=1726671026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rmKQtVhFV+qmrPC+l2g1n7XwgI++OK9zklf0cT8kpAU=;
 b=VwS4kPsMw9C07krL6of7fZC+9Tmn0pabNxN1mKXaGupIObuqskCYvyyHBtq/5TA/T0
 Rv7Yzs2OXAj2UVq774j6TEuOmKTyPxQlPt8xu0VCzjDjZjN3HVtVPZI9wspSVZloNgY1
 Jt6/1HuZYkleAYomF7jN3e2J9WPuz/DyDWZWrJisby4grdRei7h8k4vWmOMmsqH09ryS
 Q7JquOTvkBVsxehpk/f1fiDS4GgyfCjq98IvfoqXdsdbIcjHFaYLylJlcRP7YgRJZKcD
 k21MuHiDe/IrOcapwCh87PPzIEvMaRE2QJndt+Xca1njio4XDwpHrALLsSbn0E6H6YJG
 kiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726066226; x=1726671026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rmKQtVhFV+qmrPC+l2g1n7XwgI++OK9zklf0cT8kpAU=;
 b=KJ/4cCVaUTq32ssXASLKq3OPXFjWZIK2q8MNGo3Cv94oIMgNJdZO7slvfJJbFHMlju
 kWWss0/SmWb2fAXrr57N7Hhy/kQWhqkjs+gkRgOApHI22kKxO/bMREujTDwBlAupgwnG
 Y7S5lALyjeWM3/lPQIfzWNP9rCDRaB1kgNUEcZCLMXs2u8wf6rT3OkXXCkH98gmw32NM
 o4imFQO/RULlIFiWg7J0+mwxszeS/usmxmVabC5Qdn4Bxalw5/Boo+aRGRCnnCxZMmu1
 e60JqctGjl8gOIe/t/LZkt14l3hAq8CwOhe9K6RoPG0fmVBl4Fcz+9CoC4Wg/ghXiCSL
 SxmA==
X-Gm-Message-State: AOJu0YwvOAvQccHz2rcfdIoa1PVB1KLG6fSnHCxabrbRAgXgo8aQkdnp
 QNTPDPmqemj+ZqNjpNS4wxor5D8XkhP2LfVT7xohBZwdox4NIgYIxO6a8sZj7C5jHqmVssL8qDz
 Au/k=
X-Google-Smtp-Source: AGHT+IHXr3IZsOEjxikd8VYTgBy8kSiVkjgZmrEuf9VMQ2p6HTO/mymVWukb5slblThbHek9iy3deg==
X-Received: by 2002:a17:90a:fd13:b0:2d3:c34e:2fda with SMTP id
 98e67ed59e1d1-2dad4efe241mr17138136a91.14.1726062856861; 
 Wed, 11 Sep 2024 06:54:16 -0700 (PDT)
Received: from MacBook-Pro-2.local.bytedance.net ([124.90.41.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc1105fesm10535966a91.43.2024.09.11.06.54.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2024 06:54:16 -0700 (PDT)
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
 zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: [PATCH] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Date: Wed, 11 Sep 2024 21:52:57 +0800
Message-Id: <20240911135257.16278-1-xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-il1-x12b.google.com
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

As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
integer too. Otherwise we may encounter unexpected results in guest.

For example, some guest os uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26])
to calculate threads-per-core, if we have 90 ht (45 core) in the
package, we'll get "90/(1+63)=1" as the result, even though
theads-per-core should actually be 2.

So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
to solve the unexpected result.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4c2e6f3a71..24d60ead9e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -261,6 +261,12 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
     return num_ids - 1;
 }
 
+static uint32_t max_thread_number_in_package(X86CPUTopoInfo *topo_info)
+{
+    uint32_t num_threads = 1 << apicid_pkg_offset(topo_info);
+    return num_threads;
+}
+
 static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
 {
     uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
@@ -6417,7 +6423,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            *ebx |= max_thread_number_in_package(&topo_info) << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
-- 
2.20.1


